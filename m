Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30C52FCFB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiEUNwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiEUNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:52:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3D2C10E;
        Sat, 21 May 2022 06:52:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s23-20020a9d7597000000b0060ae566f9a1so4586919otk.1;
        Sat, 21 May 2022 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language
         :from:to:cc:references:subject:in-reply-to;
        bh=WCCTWotX4T0nw9UmQKxb/cOaBPq2qC6mqb3EsYNynso=;
        b=AxRkrUpmmCcHgxNEYJWghWgO7RZINGaCQeTXCwS3xkdZneBSiEXDQ9PNtzgkz2JXXB
         2A27WNYov7Yk/wZxkW6+fV9pt+78o/yru9/Q5P7TQurKasqxo0BbNnjZJrPOaoT92IxW
         HMkLLoHyMCZDH2Z/BN9LIZGjBXGXbjq3UU8cHEgnjAVcGFvwXnzzuei6Px6yHIO/XYF5
         Zoc7oCEHzlE1w3DMjNaigWo71uoTrDK0u1fxArO4J6bhPsAO5YcMMsKanUaob+1vAXEZ
         pYQKOPLQhsHrcvYAJCamK/Fs6vY127AkhZ7JGIvzDc+T7oBvZqByqwN6HhRHlaIZLtbu
         0ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to;
        bh=WCCTWotX4T0nw9UmQKxb/cOaBPq2qC6mqb3EsYNynso=;
        b=mA+PV/jVZrrYhAmFaxzNVbxoI/2kzyYR7EPFf0XzAhy86Ia8pRRa2qAXQ3uKCoYJLj
         e4HDzhdVC5ciOIPI/T4I3dr4m7/wd+EwEQwq6Q/HVsyhPIaJDsgqQXNwRkOA700VZv71
         DhkXrDPGWAEDuur/XN1kUKpfltY7yDUmoNpGRNQI2JJUJyBoM88J5IdYosHQre2bpja4
         tsCma1FA1fv0zEGyzL70DYynQ5dynym+uonIX+AuugHkX2BkHTt0SGHQQng5Zh1CbXkt
         6/hASu7SGaQL2jk9Gg3pQSLdrVwJeQ4U9zR0M1UtMxPhSmUzURMdT2uzSwKISAmTba7A
         D3gQ==
X-Gm-Message-State: AOAM530uGGY/0TP+LuIQUOqJq8+QPDi+Wd9SgKm4YigXj3Cpw0o9Qq5B
        FCvZGvkIqHieniBpGKAo2gosx6y/BJXTFA==
X-Google-Smtp-Source: ABdhPJwWUgrkmKawJoM/5A/BneYZFEJJKbQdoQlsO2Okl3k83d79ITnUCVoRgSbh2sWl/jEczxHr0g==
X-Received: by 2002:a05:6830:1de9:b0:60a:e016:5f41 with SMTP id b9-20020a0568301de900b0060ae0165f41mr5169873otj.352.1653141138324;
        Sat, 21 May 2022 06:52:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1-20020a056870a50100b000e90544b79fsm1970543oal.41.2022.05.21.06.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 06:52:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Type: multipart/mixed; boundary="------------cQam5K1fo34vzmn9LD841KB7"
Message-ID: <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net>
Date:   Sat, 21 May 2022 06:52:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net> <YoHtg30ZrhxjVedA@Red>
 <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
In-Reply-To: <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------cQam5K1fo34vzmn9LD841KB7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/22 05:21, Guenter Roeck wrote:
> On 5/15/22 23:21, LABBE Corentin wrote:
>> Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
>>> On 5/15/22 12:36, LABBE Corentin wrote:
>>>> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
>>>>> Corentin,
>>>>>
>>>>> On 5/8/22 23:30, Corentin Labbe wrote:
>>>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>>>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>>>>
>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>> ---
>>>>> [ ... ]
>>>>>
>>>>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>>>             if (res)
>>>>>>                 break;
>>>>>> -        remove_attrs(resource);
>>>>>> +        remove_domain_devices(resource);
>>>>>>             setup_attrs(resource);
>>>>>
>>>>> Zhang Rui found an interesting problem with this code:
>>>>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
>>>>> to update sysfs attribute visibility, probably between
>>>>> remove_domain_devices() and setup_attrs().
>>>>>
>>>>>>             break;
>>>>>>         case METER_NOTIFY_TRIP:
>>>>>> -        sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>>>>> +        hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>>>>>
>>>>> ... which makes realize: The notification device should be the hwmon device.
>>>>> That would be resource->hwmon_dev, not the acpi device.
>>>>>
>>>>
>>>> Hello
>>>>
>>>> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
>>>> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
>>>>
>>>> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
>>>>
>>>> For testing config change I have tried lot of way:
>>>>                   res = read_capabilities(resource);
>>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>                   remove_domain_devices(resource);
>>>>                   setup_attrs(resource);
>>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
>>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>>>
>>> Did you add a debug log here ?
>>
>> Yes I added debug log to check what is called.
>>
>>>
>>> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
>>> It would have to be resource->hwmon_dev->groups.
>>>
>>
>> Even with that, no call to is_visible:
>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>                  remove_domain_devices(resource);
>>                  setup_attrs(resource);
>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>>                  break;
>>
>> I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
>> So perhaps it explain why it is never called.
> 
> Ah yes, you are correct. Sorry, it has been too long ago that I wrote that code.
> Effectively that means we'll have to rework the hwmon core to generate attributes
> anyway and leave it up to the driver core to call the is_visible function.
> 

Attached is an outline of what would be needed in the hwmon core.
Completely untested. I wonder if it may be easier to always
create all attributes and have them return -ENODATA if not
supported.

Guenter
--------------cQam5K1fo34vzmn9LD841KB7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hwmon-Implement-hwmon_update_groups.patch"
Content-Disposition: attachment;
 filename="0001-hwmon-Implement-hwmon_update_groups.patch"
Content-Transfer-Encoding: base64

RnJvbSAwZmYxYTMxNmMwZjBjYTM2YzQ5ZjI0MTVmNDFkNDllZjE1ODE4MDhkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5u
ZXQ+CkRhdGU6IEZyaSwgMjAgTWF5IDIwMjIgMjE6NTQ6NDggLTA3MDAKU3ViamVjdDogW1BB
VENIXSBod21vbjogSW1wbGVtZW50IGh3bW9uX3VwZGF0ZV9ncm91cHMoKQoKSW4gc29tZSBz
aXR1YXRpb25zIHRoZSB2aXNpYmlsaXR5IG9mIGh3bW9uIHN5c2ZzIGF0dHJpYnV0ZXMgbWF5
IGNoYW5nZS4KU3VwcG9ydCB0aGlzIGJ5IHByb3ZpZGluZyBhIG5ldyBBUEkgZnVuY3Rpb24g
aHdtb25fdXBkYXRlX2dyb3VwcygpLgoKU2lnbmVkLW9mZi1ieTogR3VlbnRlciBSb2VjayA8
bGludXhAcm9lY2stdXMubmV0PgotLS0KIGRyaXZlcnMvaHdtb24vaHdtb24uYyB8IDk1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KIGluY2x1ZGUvbGlu
dXgvaHdtb24uaCB8ICAyICsKIDIgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwg
MjEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9od21vbi5jIGIv
ZHJpdmVycy9od21vbi9od21vbi5jCmluZGV4IDJlMmNkNzlkODllYi4uZDg0MmFiNjA3Y2Nm
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2h3bW9uL2h3bW9uLmMKKysrIGIvZHJpdmVycy9od21v
bi9od21vbi5jCkBAIC0yNDgsNyArMjQ4LDE5IEBAIHN0YXRpYyBpbnQgaHdtb25fdGhlcm1h
bF9hZGRfc2Vuc29yKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGluZGV4KQogCXJldHVybiAw
OwogfQogCi1zdGF0aWMgaW50IGh3bW9uX3RoZXJtYWxfcmVnaXN0ZXJfc2Vuc29ycyhzdHJ1
Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgc3RydWN0IGh3bW9uX3RoZXJtYWxfZGF0YSAqaHdt
b25fdGhlcm1hbF9maW5kX3R6KHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGluZGV4KQorewor
CXN0cnVjdCBod21vbl9kZXZpY2UgKmh3ZGV2ID0gdG9faHdtb25fZGV2aWNlKGRldik7CisJ
c3RydWN0IGh3bW9uX3RoZXJtYWxfZGF0YSAqdHpkYXRhOworCisJbGlzdF9mb3JfZWFjaF9l
bnRyeSh0emRhdGEsICZod2Rldi0+dHpkYXRhLCBub2RlKSB7CisJCWlmICh0emRhdGEtPmlu
ZGV4ID09IGluZGV4KQorCQkJcmV0dXJuIHR6ZGF0YTsKKwl9CisJcmV0dXJuIE5VTEw7Cit9
CisKK3N0YXRpYyBpbnQgaHdtb25fdGhlcm1hbF9yZWdpc3Rlcl9zZW5zb3JzKHN0cnVjdCBk
ZXZpY2UgKmRldiwgYm9vbCB1cGRhdGUpCiB7CiAJc3RydWN0IGh3bW9uX2RldmljZSAqaHdk
ZXYgPSB0b19od21vbl9kZXZpY2UoZGV2KTsKIAljb25zdCBzdHJ1Y3QgaHdtb25fY2hpcF9p
bmZvICpjaGlwID0gaHdkZXYtPmNoaXA7CkBAIC0yNjMsMTYgKzI3NSwzMCBAQCBzdGF0aWMg
aW50IGh3bW9uX3RoZXJtYWxfcmVnaXN0ZXJfc2Vuc29ycyhzdHJ1Y3QgZGV2aWNlICpkZXYp
CiAJCQljb250aW51ZTsKIAogCQlmb3IgKGogPSAwOyBpbmZvW2ldLT5jb25maWdbal07IGor
KykgeworCQkJdW1vZGVfdCBtb2RlOwogCQkJaW50IGVycjsKIAotCQkJaWYgKCEoaW5mb1tp
XS0+Y29uZmlnW2pdICYgSFdNT05fVF9JTlBVVCkgfHwKLQkJCSAgICAhY2hpcC0+b3BzLT5p
c192aXNpYmxlKGRydmRhdGEsIGh3bW9uX3RlbXAsCi0JCQkJCQkgICBod21vbl90ZW1wX2lu
cHV0LCBqKSkKKwkJCWlmICghKGluZm9baV0tPmNvbmZpZ1tqXSAmIEhXTU9OX1RfSU5QVVQp
KQogCQkJCWNvbnRpbnVlOwotCi0JCQllcnIgPSBod21vbl90aGVybWFsX2FkZF9zZW5zb3Io
ZGV2LCBqKTsKLQkJCWlmIChlcnIpCi0JCQkJcmV0dXJuIGVycjsKKwkJCW1vZGUgPSBjaGlw
LT5vcHMtPmlzX3Zpc2libGUoZHJ2ZGF0YSwgaHdtb25fdGVtcCwKKwkJCQkJCSAgICAgaHdt
b25fdGVtcF9pbnB1dCwgaik7CisJCQlpZiAoIW1vZGUpIHsKKwkJCQlzdHJ1Y3QgaHdtb25f
dGhlcm1hbF9kYXRhICp0emRhdGE7CisKKwkJCQlpZiAoIXVwZGF0ZSkKKwkJCQkJY29udGlu
dWU7CisJCQkJdHpkYXRhID0gaHdtb25fdGhlcm1hbF9maW5kX3R6KGRldiwgaik7CisJCQkJ
aWYgKHR6ZGF0YSkgeworCQkJCQlkZXZtX3RoZXJtYWxfem9uZV9vZl9zZW5zb3JfdW5yZWdp
c3RlcihkZXYsIHR6ZGF0YS0+dHpkKTsKKwkJCQkJZGV2bV9yZWxlYXNlX2FjdGlvbihkZXYs
IGh3bW9uX3RoZXJtYWxfcmVtb3ZlX3NlbnNvciwgJnR6ZGF0YS0+bm9kZSk7CisJCQkJfQor
CQkJfSBlbHNlIHsKKwkJCQlpZiAoIXVwZGF0ZSB8fCAhaHdtb25fdGhlcm1hbF9maW5kX3R6
KGRldiwgaikpIHsKKwkJCQkJZXJyID0gaHdtb25fdGhlcm1hbF9hZGRfc2Vuc29yKGRldiwg
aik7CisJCQkJCWlmIChlcnIpCisJCQkJCQlyZXR1cm4gZXJyOworCQkJCX0KKwkJCX0KIAkJ
fQogCX0KIApAQCAtMjgxLDE1ICszMDcsMTEgQEAgc3RhdGljIGludCBod21vbl90aGVybWFs
X3JlZ2lzdGVyX3NlbnNvcnMoc3RydWN0IGRldmljZSAqZGV2KQogCiBzdGF0aWMgdm9pZCBo
d21vbl90aGVybWFsX25vdGlmeShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpbmRleCkKIHsK
LQlzdHJ1Y3QgaHdtb25fZGV2aWNlICpod2RldiA9IHRvX2h3bW9uX2RldmljZShkZXYpOwot
CXN0cnVjdCBod21vbl90aGVybWFsX2RhdGEgKnR6ZGF0YTsKKwlzdHJ1Y3QgaHdtb25fdGhl
cm1hbF9kYXRhICp0emRhdGEgPSBod21vbl90aGVybWFsX2ZpbmRfdHooZGV2LCBpbmRleCk7
CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHR6ZGF0YSwgJmh3ZGV2LT50emRhdGEsIG5vZGUp
IHsKLQkJaWYgKHR6ZGF0YS0+aW5kZXggPT0gaW5kZXgpIHsKLQkJCXRoZXJtYWxfem9uZV9k
ZXZpY2VfdXBkYXRlKHR6ZGF0YS0+dHpkLAotCQkJCQkJICAgVEhFUk1BTF9FVkVOVF9VTlNQ
RUNJRklFRCk7Ci0JCX0KLQl9CisJaWYgKHR6ZGF0YSkKKwkJdGhlcm1hbF96b25lX2Rldmlj
ZV91cGRhdGUodHpkYXRhLT50emQsCisJCQkJCSAgIFRIRVJNQUxfRVZFTlRfVU5TUEVDSUZJ
RUQpOwogfQogCiAjZWxzZQpAQCAtNDAxLDEwICs0MjMsMTIgQEAgc3RhdGljIHN0cnVjdCBh
dHRyaWJ1dGUgKmh3bW9uX2dlbmF0dHIoY29uc3Qgdm9pZCAqZHJ2ZGF0YSwKIAlpZiAoIXRl
bXBsYXRlKQogCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKIAorCS8qCisJICogQmFzaWMg
bW9kZSBzYW5pdHkgY2hlY2suIFRoaXMgaXMgbGVzcyB0aGFuIHBlcmZlY3Qgc2luY2UKKwkg
KiBhdHRyaWJ1dGUgdmlzaWJpbGl0eSBhbmQgd2l0aCBpdCB0aGUgbW9kZSBjYW4gY2hhbmdl
IGR1cmluZworCSAqIHJ1bnRpbWUsIGJ1dCBpdCBpcyB0aGUgYmVzdCB3ZSBjYW4gZG8uCisJ
ICovCiAJbW9kZSA9IG9wcy0+aXNfdmlzaWJsZShkcnZkYXRhLCB0eXBlLCBhdHRyLCBpbmRl
eCk7Ci0JaWYgKCFtb2RlKQotCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKLQogCWlmICgo
bW9kZSAmIDA0NDQpICYmICgoaXNfc3RyaW5nICYmICFvcHMtPnJlYWRfc3RyaW5nKSB8fAog
CQkJCSAoIWlzX3N0cmluZyAmJiAhb3BzLT5yZWFkKSkpCiAJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOwpAQCAtNDM1LDcgKzQ1OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpo
d21vbl9nZW5hdHRyKGNvbnN0IHZvaWQgKmRydmRhdGEsCiAJYSA9ICZkYXR0ci0+YXR0cjsK
IAlzeXNmc19hdHRyX2luaXQoYSk7CiAJYS0+bmFtZSA9IG5hbWU7Ci0JYS0+bW9kZSA9IG1v
ZGU7CisJYS0+bW9kZSA9IG9wcy0+d3JpdGUgPyAwNjQ0IDogMDQ0NDsJLyogdXBkYXRlZCB3
aGVuIGF0dHJpYnV0ZXMgYXJlIGdlbmVyYXRlZCAqLwogCiAJcmV0dXJuIGE7CiB9CkBAIC02
MzgsNiArNjYyLDI0IEBAIHN0YXRpYyBjb25zdCBpbnQgX190ZW1wbGF0ZXNfc2l6ZVtdID0g
ewogCVtod21vbl9pbnRydXNpb25dID0gQVJSQVlfU0laRShod21vbl9pbnRydXNpb25fYXR0
cl90ZW1wbGF0ZXMpLAogfTsKIAoraW50IGh3bW9uX3VwZGF0ZV9ncm91cHMoc3RydWN0IGRl
dmljZSAqZGV2KQoreworCXN0cnVjdCBod21vbl9kZXZpY2UgKmh3ZGV2ID0gdG9faHdtb25f
ZGV2aWNlKGRldik7CisJY29uc3Qgc3RydWN0IGh3bW9uX2NoaXBfaW5mbyAqY2hpcCA9IGh3
ZGV2LT5jaGlwOworCWNvbnN0IHN0cnVjdCBod21vbl9jaGFubmVsX2luZm8gKippbmZvID0g
Y2hpcC0+aW5mbzsKKwlpbnQgcmV0OworCisJcmV0ID0gc3lzZnNfdXBkYXRlX2dyb3Vwcygm
ZGV2LT5rb2JqLCBkZXYtPmdyb3Vwcyk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CWlmIChpbmZvWzBdLT50eXBlICE9IGh3bW9uX2NoaXAgfHwgIShpbmZvWzBdLT5jb25maWdb
MF0gJiBIV01PTl9DX1JFR0lTVEVSX1RaKSkKKwkJcmV0dXJuIDA7CisKKwlyZXR1cm4gaHdt
b25fdGhlcm1hbF9yZWdpc3Rlcl9zZW5zb3JzKGRldiwgdHJ1ZSk7Cit9CitFWFBPUlRfU1lN
Qk9MX0dQTChod21vbl91cGRhdGVfZ3JvdXBzKTsKKwogaW50IGh3bW9uX25vdGlmeV9ldmVu
dChzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gaHdtb25fc2Vuc29yX3R5cGVzIHR5cGUsCiAJ
CSAgICAgICB1MzIgYXR0ciwgaW50IGNoYW5uZWwpCiB7CkBAIC03NDgsNiArNzkwLDE2IEBA
IF9faHdtb25fY3JlYXRlX2F0dHJzKGNvbnN0IHZvaWQgKmRydmRhdGEsIGNvbnN0IHN0cnVj
dCBod21vbl9jaGlwX2luZm8gKmNoaXApCiAJcmV0dXJuIGF0dHJzOwogfQogCitzdGF0aWMg
dW1vZGVfdCBod21vbl9pc192aXNpYmxlKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3Qg
YXR0cmlidXRlICphdHRyLCBpbnQgbikKK3sKKwlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
ZGF0dHIgPSB0b19kZXZfYXR0cihhdHRyKTsKKwlzdHJ1Y3QgaHdtb25fZGV2aWNlX2F0dHJp
YnV0ZSAqaGF0dHIgPSB0b19od21vbl9hdHRyKGRhdHRyKTsKKwlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSBrb2JqX3RvX2Rldihrb2JqKTsKKwl2b2lkICpkcnZkYXRhID0gZGV2X2dldF9kcnZk
YXRhKGRldik7CisKKwlyZXR1cm4gaGF0dHItPm9wcy0+aXNfdmlzaWJsZShkcnZkYXRhLCBo
YXR0ci0+dHlwZSwgaGF0dHItPmF0dHIsIGhhdHRyLT5pbmRleCk7Cit9CisKIHN0YXRpYyBz
dHJ1Y3QgZGV2aWNlICoKIF9faHdtb25fZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Ug
KmRldiwgY29uc3QgY2hhciAqbmFtZSwgdm9pZCAqZHJ2ZGF0YSwKIAkJCWNvbnN0IHN0cnVj
dCBod21vbl9jaGlwX2luZm8gKmNoaXAsCkBAIC03OTcsNiArODQ5LDcgQEAgX19od21vbl9k
ZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLCB2
b2lkICpkcnZkYXRhLAogCQl9CiAKIAkJaHdkZXYtPmdyb3VwLmF0dHJzID0gYXR0cnM7CisJ
CWh3ZGV2LT5ncm91cC5pc192aXNpYmxlID0gaHdtb25faXNfdmlzaWJsZTsKIAkJbmdyb3Vw
cyA9IDA7CiAJCWh3ZGV2LT5ncm91cHNbbmdyb3VwcysrXSA9ICZod2Rldi0+Z3JvdXA7CiAK
QEAgLTg0MCw3ICs4OTMsNyBAQCBfX2h3bW9uX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKmRydmRhdGEsCiAJaWYgKGRldiAm
JiBkZXYtPm9mX25vZGUgJiYgY2hpcCAmJiBjaGlwLT5vcHMtPnJlYWQgJiYKIAkgICAgY2hp
cC0+aW5mb1swXS0+dHlwZSA9PSBod21vbl9jaGlwICYmCiAJICAgIChjaGlwLT5pbmZvWzBd
LT5jb25maWdbMF0gJiBIV01PTl9DX1JFR0lTVEVSX1RaKSkgewotCQllcnIgPSBod21vbl90
aGVybWFsX3JlZ2lzdGVyX3NlbnNvcnMoaGRldik7CisJCWVyciA9IGh3bW9uX3RoZXJtYWxf
cmVnaXN0ZXJfc2Vuc29ycyhoZGV2LCBmYWxzZSk7CiAJCWlmIChlcnIpIHsKIAkJCWRldmlj
ZV91bnJlZ2lzdGVyKGhkZXYpOwogCQkJLyoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
aHdtb24uaCBiL2luY2x1ZGUvbGludXgvaHdtb24uaAppbmRleCAxNDMyNWY5M2M2YjIuLjM4
OWVkNDVkNGJkNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9od21vbi5oCisrKyBiL2lu
Y2x1ZGUvbGludXgvaHdtb24uaApAQCAtNDY3LDYgKzQ2Nyw4IEBAIGludCBod21vbl9ub3Rp
ZnlfZXZlbnQoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGh3bW9uX3NlbnNvcl90eXBlcyB0
eXBlLAogY2hhciAqaHdtb25fc2FuaXRpemVfbmFtZShjb25zdCBjaGFyICpuYW1lKTsKIGNo
YXIgKmRldm1faHdtb25fc2FuaXRpemVfbmFtZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IGNoYXIgKm5hbWUpOwogCitpbnQgaHdtb25fdXBkYXRlX2dyb3VwcyhzdHJ1Y3QgZGV2aWNl
ICpkZXYpOworCiAvKioKICAqIGh3bW9uX2lzX2JhZF9jaGFyIC0gSXMgdGhlIGNoYXIgaW52
YWxpZCBpbiBhIGh3bW9uIG5hbWUKICAqIEBjaDogdGhlIGNoYXIgdG8gYmUgY29uc2lkZXJl
ZAotLSAKMi4zNS4xCgo=

--------------cQam5K1fo34vzmn9LD841KB7--
