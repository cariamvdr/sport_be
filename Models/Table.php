<?php
namespace Models;

use Configs\Database as Database;
use \PDO as PDO;
/**
 * Table is class to be extended by models defined database
 */
abstract class Table {
    
    protected $table = '';
    
    // can be used by children
    protected static $db = null;
    
    public $id = 0;
    
    static function init(&$obj, $id=0){
        $class = get_called_class();
        $obj->table = $class::TABLE_NAME;
        self::$db = new PDO (Database::CONNECT, Database::USERNAME, Database::PASSWORD);
        self::$db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE,PDO::FETCH_ASSOC);
        
        if($id){
            $obj->load($id);
        }
        return $obj;
    }
    
    protected function load($id){
        self::get($id, $this);
    }
   
    /**
     * Load an item with ID from DB
     * @param type $id database primary key
     */
    public static function get ($id=0, &$obj=null){
        $current = $obj;
        $instances = [];
        $items = [];
        $class = get_called_class();
        $sql = "SELECT * FROM ".$class::TABLE_NAME." ";
        $sql .= $id?"WHERE id = :id":"ORDER BY id";
        $stmt = self::$db->prepare($sql);
        if($stmt->execute([":id"=>$id])){
            $instances = $stmt->fetchAll();
        }
        $bindings = $class::getBindings();
        if($instances){
            foreach($instances as $instance){
                $current = !empty($current)?$current:new static();
                foreach($instance as $key => $value){
                    if(in_array($key, array_keys($bindings))){
                        $property = $bindings[$key];
                        $current->$property = $value;
                    }
                }
                $items[] = $current;
                $current = null;
            }
        }
        if(count($items))
            return $id?$items[0]:$items;
        else
            return $id?null:[];
    }
    
    /**
     * Load an item with ID from DB
     * @param type $id database primary key
     */
    public static function getAll (){
        return self::get();
    }

    /**
     * Remove an item with ID from DB
     * @param type $id database primary key
     */
    public function save (){
        // abbiamo preso ad ispirazione http://ginho.it/articolo/guida-completa-a-pdo
        $bindings = $this::getBindings();
        $id = 0;
        unset($bindings['id']); 
        if(!$this->id){
            $cols = join(", ", $bindings);
            $data = [];
            foreach($bindings as $key){
                $data[] = self::$db->quote($this->$key);
            }
            $vals = join(", ", $data);
            $query = "INSERT INTO ".$this->table." ($cols) VALUES ($vals)";
            if(self::$db->exec($query)) $id = self::$db->lastInsertId();
            $this->id = $id;
        }else{
            $data = [];
            foreach($bindings as $key=>$value){
                $data[] = "$key = ".self::$db->quote($this->$value);
            }
            $assign = join(", ", $data);
            if(self::$db->exec("UPDATE ".$this->table." SET $assign WHERE id = $this->id"))
                $id = $this->id;
        }
        return $id;
    }
    
    /**
     * Remove an item with ID from DB
     * @param type $id database primary key
     */
    public function delete (){
        // abbiamo preso ad ispirazione http://ginho.it/articolo/guida-completa-a-pdo
        $number = 0;
        if($this->id){
            self::$db->exec("DELETE FROM ".$this->table." WHERE id = ".$this->id);
            $this->id = 0;
        }		
        return $number;
    }
}
