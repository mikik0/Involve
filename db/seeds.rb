if Category.count == 0
  Category.create([
    {name: 'ダイエット'},
    {name: '健康'},
    {name: '読書'},
    {name: '運動'},
    {name: '勉強'},
    {name: '日記・ブログ'},
    {name: '資格'},
    {name: '音楽'},
    {name: '制作'},
    {name: 'チャレンジ'},
    {name: '仕事'},
    {name: '部活・サークル'},
    {name: '生活'}
  ])
end