# Домашнее задание к занятию "6. Написание собственных провайдеров для Terraform."

Бывает, что 
* общедоступная документация по терраформ ресурсам не всегда достоверна,
* в документации не хватает каких-нибудь правил валидации или неточно описаны параметры,
* понадобиться использовать провайдер без официальной документации,
* может возникнуть необходимость написать свой провайдер для системы используемой в ваших проектах.   

## Задача 1. 
Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда: 
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git).
Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.  


1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на 
гитхабе.   
2. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`. 
    * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.
    * Какая максимальная длина имени? 
    * Какому регулярному выражению должно подчиняться имя? 
	
## Ответ
1. [resource](https://github.com/hashicorp/terraform-provider-aws/blob/cfb1f8285d8571267f12749958a54749f968c3d4/internal/provider/provider.go#L944)
   [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/cfb1f8285d8571267f12749958a54749f968c3d4/internal/provider/provider.go#L419)
2. * Параметр `name` конфликтует с параметром [name_prefix](https://github.com/hashicorp/terraform-provider-aws/blob/cfb1f8285d8571267f12749958a54749f968c3d4/internal/service/sqs/queue.go#L88)
   * Максимальная длина [80](https://github.com/hashicorp/terraform-provider-aws/blob/cfb1f8285d8571267f12749958a54749f968c3d4/internal/service/sqs/queue.go#L434) и [75](https://github.com/hashicorp/terraform-provider-aws/blob/cfb1f8285d8571267f12749958a54749f968c3d4/internal/service/sqs/queue.go#L432) для `fifo`
   * Ссылки на выражения указаны выше - вот в явном виде (и для fifo)
   ```
   		if fifoQueue {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,75}\.fifo$`)
		} else {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)
		}
   ```
    
## Задача 2. (Не обязательно) 
В рамках вебинара и презентации мы разобрали как создать свой собственный провайдер на примере кофемашины. 
Также вот официальная документация о создании провайдера: 
[https://learn.hashicorp.com/collections/terraform/providers](https://learn.hashicorp.com/collections/terraform/providers).

1. Проделайте все шаги создания провайдера.
2. В виде результата приложение ссылку на исходный код.
3. Попробуйте скомпилировать провайдер, если получится то приложите снимок экрана с командой и результатом компиляции.   

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---