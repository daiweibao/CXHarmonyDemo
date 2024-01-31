///用户首选项数据存储工具类
import preferences from '@ohos.data.preferences';

class PreferenceUtil{
  private pref: preferences.Preferences
  //Preferences实例的名称，用户自定义
  private name: string = 'chaoxiApp'
  //初始化
  async loadPreference(context){
    try { // 加载preferences
      this.pref = await preferences.getPreferences(context, this.name)
      console.log(`加载Preferences[${this.name}]成功`)
    } catch (e) {
      console.log(`加载Preferences[${this.name}]失败`, JSON.stringify(e))
    }
  }

  //保存数据
  async putPreferenceValue(key: string, value: preferences.ValueType){
    if (!this.pref) {
      console.log(`Preferences[${this.name}]尚未初始化！`)
      return
    }
    try {
      // 写入数据
      await this.pref.put(key, value)
      // 刷盘，持久化保存到磁盘
      await this.pref.flush()
      console.log(`保存Preferences[${key} = ${value}]成功`)
    } catch (e) {
      console.log(`保存Preferences[${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  //读取数据
  async getPreferenceValue(key: string, defaultValue: preferences.ValueType){
    if (!this.pref) {
      console.log(`Preferences[${this.name}]尚未初始化！`)
      return
    }
    try {
      // 读数据
      let value = await this.pref.get(key, defaultValue)
      console.log(`读取Preferences[${key} = ${value}]成功`)
      return value
    } catch (e) {
      console.log(`读取Preferences[${key}]失败`, JSON.stringify(e))
    }
  }
}
//初始化，单例
const preferenceUtil = new PreferenceUtil()
//导出
export default preferenceUtil as PreferenceUtil