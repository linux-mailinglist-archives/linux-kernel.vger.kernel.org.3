Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507DD5B2374
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiIHQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiIHQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:18:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02246B66C;
        Thu,  8 Sep 2022 09:18:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l65so18422503pfl.8;
        Thu, 08 Sep 2022 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=S8xBG1WmiMbamx7MOD7HEHdBnjH2zfQVc+ZNubPB0yw=;
        b=iVlOnAlGwOfIeRETWRs23zEcBCCidjztIzhjJjB5nFD9LxIJjN0XwI0NUB9aBSf+7B
         /LTkqg5VIWZnA2F2crUfyeKWj1VCjJwiiQjgV8YJwX/NbLgS16+LkJ/nLk09cQt2CbOS
         llRt9UyiJGUQGvCseQzksmyeLBYZmbOx0TiaFdtk0Ttw5ccqCZrgkUYdBXPq6d1vKpNI
         ZBC5qpajc6YB2e1+uWpcwF5qP38z3OpH+zo3TpTDcFbEaoKmyiCDfMbvfYdEqvNKPkgb
         ZhsfN18dQvnuJ6Nc//LAVMGE0o1W4GnNENGADiz2hy1rYFKY2m7+k7v1/Scj7NzJDGny
         Xy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=S8xBG1WmiMbamx7MOD7HEHdBnjH2zfQVc+ZNubPB0yw=;
        b=5S6390BpQCkETbHw0qRVNtkIxD7ldbR0RD8feGjpjJj/kvYhIIekCdLwXynaB2ectk
         CKs2AfU09URXdYb7PYkKLsaUGiAq7R+CwpNAn7lRPo53TT3A8jCzW7SX+F00JlRYTWhN
         8290OLJO7C2MxZ7GJKH7mmd+0NUpFZpWzewWCbmhYqld0QYVbhCbPie0ytte6w4pF9rQ
         ZIkHK94IzjDm6aK8ShdJj4nYS8AAupyNjfqeyAesLvMamkp8qpKe1rvCWNJ1OBm5Ah3i
         pP7OpC1h8jfeUZjmS8z3l2XLrvURBKwmxEsP1KqoU6TtalNSpZNIxiBuL34MOUm5bqaI
         v2Rg==
X-Gm-Message-State: ACgBeo2g5TQDg32gafN3Dle1p5DY/Y3a83PvUU9Zot+nmgRCVnUVITQy
        qiy/nGlt8U426tKg9uRdRiicPpTLgQtKWA==
X-Google-Smtp-Source: AA6agR6m6qPS5Hmd/Sy+JQHswDDJH5N5t+WtUcJgn6IuRMsEJ2ppHgLSMYeyHNht8gmGRamjVYzjlQ==
X-Received: by 2002:a63:345:0:b0:438:66e3:b10d with SMTP id 66-20020a630345000000b0043866e3b10dmr1997268pgd.278.1662653894828;
        Thu, 08 Sep 2022 09:18:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b005350ea966c7sm15100485pfb.154.2022.09.08.09.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:18:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50319404-1b09-93ea-dbd5-b840167a4819@roeck-us.net>
Date:   Thu, 8 Sep 2022 09:18:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v6 3/4] dt-bindings: hwmon: Add bindings for
 max31760
Content-Language: en-US
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220908082358.186268-1-Ibrahim.Tilki@analog.com>
 <20220908082358.186268-4-Ibrahim.Tilki@analog.com>
 <5d36f4f2-f67b-32c3-ff6a-937b2e4723fe@roeck-us.net>
 <DM8PR03MB6247E3770CF8C2A20A47E45E96409@DM8PR03MB6247.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DM8PR03MB6247E3770CF8C2A20A47E45E96409@DM8PR03MB6247.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 08:46, Tilki, Ibrahim wrote:
> 
>> On 9/8/22 01:23, Ibrahim Tilki wrote:
>>> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
>>>
>>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>>
>> This time you dropped the maintainers from Cc:. Why ?
>>
>> Guenter
>>
> 
> I thought I need to send the patch to devicetree list <devicetree@vger.kernel.org>
> instead of sending directly to maintainers as per Rob's reply.

I don't think Rob said "instead" in his e-mail. He asked you to send
the patches to the recipients listed by the get_maintainers script.

> Should I add them to Cc as well and resend again?
> 

You'll wee if/when he replies. Note that you got a 0-day report,
so you'll have to send another version of your series anyway
with the reported problem fixed.

Thanks,
Guenter

> Ibrahim
> 
> 
>>> ---
>>>    .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++++
>>>    1 file changed, 44 insertions(+)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>> b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>> new file mode 100644
>>> index 000000000..003ec1317
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>> @@ -0,0 +1,44 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id:
>>> +https://urldefense.com/v3/__http://devicetree.org/schemas/hwmon/adi,m
>>> +ax31760.yaml*__;Iw!!A3Ni8CS0y2Y!4jxXOqgSL2JDA_zhVxa1gDg-X3GvtxnISuyIJ
>>> +0fz_0Blfkx3tzqwICgIVHzIxrv7-7nDoCZqZgYJ0OtFP8A$
>>> +$schema:
>>> +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
>>> +aml*__;Iw!!A3Ni8CS0y2Y!4jxXOqgSL2JDA_zhVxa1gDg-X3GvtxnISuyIJ0fz_0Blfk
>>> +x3tzqwICgIVHzIxrv7-7nDoCZqZgYJ5GeDd5g$
>>> +
>>> +title: Analog Devices MAX31760 Fan-Speed Controller
>>> +
>>> +maintainers:
>>> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>>> +
>>> +description: |
>>> +  Analog Devices MAX31760 Fan-Speed Controller
>>> +  https://datasheets.maximintegrated.com/en/ds/MAX31760.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,max31760
>>> +
>>> +  reg:
>>> +    description: |
>>> +      I2C address of slave device.
>>> +    items:
>>> +      minimum: 0x50
>>> +      maximum: 0x57
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c0 {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        max31760@50 {
>>> +                reg = <0x50>;
>>> +                compatible = "adi,max31760";
>>> +        };
>>> +    };

