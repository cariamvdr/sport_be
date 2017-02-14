<?php
namespace Models\Sport;

use Models\Table as Table;

class Atleta extends Table {
    
    // Nome della tabella
    const TABLE_NAME = "categorie";
    
    public $categoria;
    protected $gare = array(); // array of ID
    
    public function __construct($id = 0, $params = []){
        
        parent::init($this, $id);
        
        foreach($params as $k => $v){
            if(is_array($v)){
                $this->$k = 
                        array_map(function($i){return is_int($i)?$i:$i->id;}, $v);
                $this->$k = array_unique($this->$k);
                sort($this->$k);
            }else{
                $this->$k = $v;
            }       
        }
    }
    
    /**
     * Metodo richiesto per integrare l'oggetto con una tabella estendendo table.php
     * Quesyo metodo avrà lo scopo di mappare tutti le proprietà dell oggetto studente
     * con i nomi delle colonne sul database
     * @return type
     */
    static function getBindings(){
        return [
            //"nome_colonna"=>"nome_parametro",
            "id"=>"id",
            "categoria"=>"categoria"
        ];
    }
    
    protected function load($id){
        parent::load($id, $this);
        $this->loadGare();
    }
    
    public function save(){
        parent::save();
        $this->storeGare();
    }
    
    public function loadGare(){
        try{
            $sql = "SELECT id FROM gare WHERE ".self::TABLE_NAME."_id = :id ORDER BY id";
            $stmt = self::$db->prepare($sql);
            if($stmt->execute([":id"=>$this->id])){
                $this->iscrizioni = array_map(function($i){return $i['id'];}, $stmt->fetchAll());
            }
        }catch(\PDOException $e){
            die($e->getMessage());
        }
    }
    
    public function storeGare(){
        try{
            // rimuovo quelle relazioni che non valgono piu
            $sql = "UPDATE gare SET categorie_id = null WHERE id NOT IN (".
                    join(", ",$this->gare).") AND categorie_id = :id";
            $stmt = self::$db->prepare($sql);
            $stmt->execute([":id"=>$this->id]);
        }catch(\PDOException $e){
            die($e->getMessage());
        }
        
        if(count($this->gare)){
            try{
                // aggiungo quelle relazione che valgono da adesso
                $sql = "UPDATE gare SET categorie_id = :id WHERE id IN (".
                        join(", ",$this->gare).")";
                $stmt = self::$db->prepare($sql);
                $stmt->execute([":id"=>$this->id]);
            }catch(\PDOException $e){
                die($e->getMessage());
            }
        }
        
    }
}
