///用户首选项数据存储工具类

import preferences from '@ohos.data.preferences';

class PreferencesUtil{
//全局map
  prefMap: Map<string, preferences.Preferences> = new Map()

  //创建存储实例，建议在App启动时候，统一初始化一份。
  async loadPreference(context, name: string){
    try { // 加载preferences
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      console.log('testTag', `加载Preferences[${name}]成功`)
    } catch (e) {
      console.log('testTag', `加载Preferences[${name}]失败`, JSON.stringify(e))
    }
  }

  //存入数据：实例、数据存储的key、存储的值
  async putPreferenceValue(name: string, key: string, value: preferences.ValueType){
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 写入数据-内存
      await pref.put(key, value)
      // 写入磁盘
      await pref.flush()
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]成功`)
    } catch (e) {
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  //取出数据：实例、数据存储的key、默认的值
  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType){
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 读数据
      let value = await pref.get(key, defaultValue)
      console.log('testTag', `读取Preferences[${name}.${key} = ${value}]成功`)
      return value
    } catch (e) {
      console.log('testTag', `读取Preferences[${name}.${key} ]失败`, JSON.stringify(e))
    }
  }
}

//初始化，const单例
const preferencesUtil = new PreferencesUtil()
//导出
export default preferencesUtil as PreferencesUtil