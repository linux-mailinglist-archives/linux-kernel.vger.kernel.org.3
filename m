Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C957B685
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiGTMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiGTMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:33:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B64D80E;
        Wed, 20 Jul 2022 05:33:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so1174032wmj.1;
        Wed, 20 Jul 2022 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=70wPtLQs2xXaydfsp0VWQjBJQcr/1Ind/O7AoMY9ZaQ=;
        b=WKOrE/16XURq13q7wLeB5Ylq2qpIsuwyESrPtM3r12S4ja+xSpq1BGUavZA2eYPieZ
         fw60KrfCHG2Fj5c9vnC69+O92HZMbnWn5FRyFCk3XtCK6RsuH6SI+reZaPrMfhcxyzh5
         tV1XEhMJolfxh1J/F1ngAiFDHAxsHJEHAx+tcbErxSLsqiEKdf/DzDEkBifnyeVkYhBD
         nKF7AVMtbbeHrVHsSNmGCz/wVh2xnwflel4WA3nDrqcZWS71ntf4hFHoY4+Y6jBNi1Rn
         6riEGjuL3urxA0vNFADw5TnqJPetn6tQ0ZjCJGPKWzsYVIeoTxf3gPwyj3jmqxvMVF8I
         KOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=70wPtLQs2xXaydfsp0VWQjBJQcr/1Ind/O7AoMY9ZaQ=;
        b=38pDJLtWFYWscs/pTyazBPNosXYSllZWeOhjGZNS58bdM6mSO03dLlDHBz6eRv7wE4
         X0TuHn4Etcx23WHZqR0W8Jw9SUVWlOiFLtYizoYsAIhk8TUBicYelXHo0ajqwktdYzaH
         6ebsG5BCBADJaed7n/9c3/pLg22ng/iH42lBSr0oMxdSIQxiQ9QFPvd4WQAkPXFAHJHD
         glCYDTP+2x3TNbz+KizQhgSIEhs7Gim1F+iiDYCO7QyxTS0i1lgcJwn2CvMEzPWx8aAM
         Jh++ZC6COoLQcdHR1MLWyqY2VQngV55/9UfFo25x01hZUh9asEnFcdbk3wvrHIE2cbVw
         t1JQ==
X-Gm-Message-State: AJIora8XQBfj+cFmZ5OEaeGZTR2M/GnWEPMvhTW1yW1KdPOyQyHC9cLo
        npYmQPI7uicHgKQu3bsK9jUU6IkiMNg=
X-Google-Smtp-Source: AGRyM1sV24k56kfh0k7YwDqN961gdT0GrNddQSn8CN9ubFLO1cIwJNGBsgIMcyTkEyZhYBIRV7RuRA==
X-Received: by 2002:a05:600c:1e8f:b0:3a3:1cfc:ba6 with SMTP id be15-20020a05600c1e8f00b003a31cfc0ba6mr3536879wmb.177.1658320413846;
        Wed, 20 Jul 2022 05:33:33 -0700 (PDT)
Received: from [192.168.3.10] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0021a34023ca3sm15550714wrw.62.2022.07.20.05.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 05:33:33 -0700 (PDT)
Message-ID: <4be15cff-b0af-8671-57aa-6567c0206715@gmail.com>
Date:   Wed, 20 Jul 2022 15:33:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/5] mfd: sm5703: Add support for SM5703 MFD
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
 <YtUXFTx1+vSrXx70@google.com>
 <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
 <Yte7Tgq3w8fowTYA@google.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <Yte7Tgq3w8fowTYA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 7/20/22 11:22, Lee Jones wrote:
> On Tue, 19 Jul 2022, Markuss Broks wrote:
>
>> Hi Lee,
>>
>> On 7/18/22 11:17, Lee Jones wrote:
>>> On Fri, 15 Jul 2022, Markuss Broks wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> Sorry to bother you again, but I've got additional questions while I was
>>>> preparing the next version of the series:
>>>>
>>>> On 6/15/22 00:32, Lee Jones wrote:
>>>>> On Sat, 23 Apr 2022, Markuss Broks wrote:
>>>>>
>>>>>> Silicon Mitus SM5703 is a multi-function device, meant to be
>>>>> Please avoid using the term MFD.
>>>>>
>>>>> How is the device described in the data-sheet?
>>>>>
>>>>> What do you mean by "meant to be"?
>>>>>
>>>>>> used in mobile devices. It has several modules: LDO, BUCK regulators,
>>>>> Modules or functions?
>>>>>
>>>>>> charger circuit, flash LED driver, a fuel gauge for monitoring the battery
>>>>>> and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
>>>>>> they use separate i2c lines to communicate with the device, while charger
>>>>> "I2C"
>>>>>
>>>>>> circuit, LED driver and regulators are on the main i2c line the device is
>>>>>> controlled with.
>>>>>>
>>>>>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>>>>>> ---
>>>>>>     MAINTAINERS                |   8 +++
>>>>>>     drivers/mfd/Kconfig        |  13 +++++
>>>>>>     drivers/mfd/Makefile       |   1 +
>>>>>>     drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
>>>>>>     include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
>>>>>>     5 files changed, 205 insertions(+)
>>>>>>     create mode 100644 drivers/mfd/sm5703.c
>>>>>>     create mode 100644 include/linux/mfd/sm5703.h
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 6157e706ed02..6125ed1a3be4 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>>>>>>     F:	include/linux/srcu*.h
>>>>>>     F:	kernel/rcu/srcu*.c
>>>>>> +SM5703 MFD DRIVER
>>>>>> +M:	Markuss Broks <markuss.broks@gmail.com>
>>>>>> +S:	Maintained
>>>>>> +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>>>>>> +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>>>>>> +F:	drivers/mfd/sm5703.c
>>>>>> +F:	drivers/regulator/sm5703-regulator.c
>>>>>> +
>>>>>>     SMACK SECURITY MODULE
>>>>>>     M:	Casey Schaufler <casey@schaufler-ca.com>
>>>>>>     L:	linux-security-module@vger.kernel.org
>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>> index 3b59456f5545..c13a99ceae99 100644
>>>>>> --- a/drivers/mfd/Kconfig
>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>> @@ -1237,6 +1237,19 @@ config MFD_SM501
>>>>>>     	  interface. The device may be connected by PCI or local bus with
>>>>>>     	  varying functions enabled.
>>>>>> +config MFD_SM5703
>>>>>> +	tristate "Silicon Mitus SM5703 MFD"
>>>>>> +	depends on I2C
>>>>>> +	depends on OF
>>>>>> +	select MFD_CORE
>>>>>> +	select REGMAP_I2C
>>>>>> +	help
>>>>>> +	  This is the core driver for the Silicon Mitus SM5703 multi-function
>>>>> Please drop the MFD term, as above.
>>>>>
>>>>>> +	  device. This device is meant to be used in phones and it has numerous
>>>>> "meant to be"?
>>>>>
>>>>>> +	  modules, including LED controller, regulators, fuel gauge, MUIC and
>>>>> Either "an LED controller" or "LED controllers"
>>>>>
>>>>> Same with "charger circuit" below.
>>>>>
>>>>>> +	  charger circuit. It also support muxing a serial interface over USB
>>>>> "supports"
>>>>>
>>>>> What kind of serial?
>>>>>
>>>>>> +	  data lines.
>>>>>> +
>>>>>>     config MFD_SM501_GPIO
>>>>>>     	bool "Export GPIO via GPIO layer"
>>>>>>     	depends on MFD_SM501 && GPIOLIB
>>>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>>>> index 858cacf659d6..ca8b86736a36 100644
>>>>>> --- a/drivers/mfd/Makefile
>>>>>> +++ b/drivers/mfd/Makefile
>>>>>> @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>>>>>>     rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
>>>>>>     obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>>>>>>     obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
>>>>>> +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
>>>>>> diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..7f9838149051
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/mfd/sm5703.c
>>>>>> @@ -0,0 +1,78 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>> +
>>>>>> +#include <linux/err.h>
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/gpio/consumer.h>
>>>>>> +#include <linux/i2c.h>
>>>>>> +#include <linux/mfd/core.h>
>>>>>> +#include <linux/mfd/sm5703.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/regmap.h>
>>>>>> +
>>>>>> +static const struct mfd_cell sm5703_devs[] = {
>>>>>> +	{ .name = "sm5703-regulator", },
>>>>>> +};
>>>>> Where are the rest of the child drivers?
>>>> Should those devices still be present even though there's no driver for them
>>>> (yet) ? I have a WIP version of driver for almost every function, but I
>>>> currently lack time to get them done.
>>> Without them the driver-set is useless, no?
>>>
>>> We try to refrain from applying dead code.
>>>
>>> A lot of it has a tendency to stay that way.
>> Well, in my opinion, having just the regulator driver is already useful
>> enough: my board (Samsung Galaxy J5 (2015) ) uses one of LDO outputs for
>> powering the touchscreen. Touchscreen is kind of vital functionality for a
>> phone so I decided to upstream parts that are necessary for it first and
>> finish up other stuff later. It's not the only board that uses SM5703's
>> regulators for supplying all different kinds of hardware, either.
> Upstreaming functionality which is useful on its own is fine, but that
> doesn't tick all of the boxes to justify an MFD.  This is a lot of
> code which is hard to justify if it only registers a Regulator driver.
Do you think I should hold on this series until I have other things 
done? Alternatively, I could make the regulator driver standalone, 
dedicated, but then when I'd add other functionality I'd have to redo it 
and add the MFD driver back, that I believe would be quite annoying from 
maintainers' and sanity perspective. The other functions left on the 
main control I2C are also not really "vital" to device's functionality 
(Flash LED and charger), so the regulator function makes the most sense 
to be available first, which was my motivation behind upstreaming that 
first.
>
- Markuss
