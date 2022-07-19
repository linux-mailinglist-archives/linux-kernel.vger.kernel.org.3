Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79257A12C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiGSOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiGSOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:19:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D546DB9;
        Tue, 19 Jul 2022 06:58:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y11so24930319lfs.6;
        Tue, 19 Jul 2022 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+2aJAl0rRfbzSKkiIftk8ldOFxfh5EXLt3BAbAT41JQ=;
        b=B/ONy45MnsJccYM7mg0CgiUa0J3wDHVOzPTDwYrw2gXv+iVdO+kVOQJMPy9qv67HFd
         376UIbXeWBXxc1ev5+VAHnlltdzq7ICMlAIz7aK2UDeAVzi+t80CFTYtmY9B0TFovHq+
         WS9nbWCeAuT7Y13+9jbkp/jwySDzOsaD0qTN7FOZ/bfylRLxb9g/wCnCzEUeoS+8rgpo
         AzFpobpVUKsRSHPnQmfcIns79xY/XnXa8ZnKmkHbTgB8A9EzNVVHWLYOe/iiBh8ecw/e
         eqUznLouomgZmwUwR0TrEDmW50HnYmveaqrPSB82Gh/xuAQxrKgzZ0T7W1ZHHn/yxFsT
         RS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+2aJAl0rRfbzSKkiIftk8ldOFxfh5EXLt3BAbAT41JQ=;
        b=4m4Dc7JFCDPJy12u5eUctOo6SoXh9Kad6gLpCfMeVd/JAW/Rwm7HkzCFDMaJ0pDi5x
         XHWkHywlJiOIspNUrJaysy/N/a5zy3GNFGh2LXdrF7//GJ8SJu83R71j4qLPYxM3Lwen
         QOUCo7nVY4F7ZQMURlcPUnJlloHGnKsumgTH3c3Ijat6SHWMPfJAnwOVG0DmzNs6hOmh
         1ROkx9pUtST0dY3SegTcO1b/8VMAeXJd9RxHO3BGcAkmQ34UtYdHG/3k83QUaKsLARWN
         /TtS+3lT6ni1hxjKZuaYVarOc0glK+OY8asXw/xGztCI32Y38BupYtK6GZlsuz/OE2Xa
         YAwg==
X-Gm-Message-State: AJIora9sEXqniVM688B1hNMAlxPz3+7y8M6+tjfBS7+bZ5jHrdoX/YDe
        AcMJYfk9ALIJ/BDR78hGK30=
X-Google-Smtp-Source: AGRyM1ur8+BWTKBaz162gwI4bD871JbUmpMCZkEqrK1qZeLrDpPwNz+LSFkAjJubVIsH51V2wxmGlQ==
X-Received: by 2002:a05:6512:10d1:b0:489:feee:3b80 with SMTP id k17-20020a05651210d100b00489feee3b80mr17413587lfg.212.1658239127946;
        Tue, 19 Jul 2022 06:58:47 -0700 (PDT)
Received: from [192.168.3.10] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h11-20020ac25d6b000000b00489d16820ecsm3232351lft.165.2022.07.19.06.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:58:47 -0700 (PDT)
Message-ID: <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
Date:   Tue, 19 Jul 2022 16:58:45 +0300
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
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <YtUXFTx1+vSrXx70@google.com>
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

On 7/18/22 11:17, Lee Jones wrote:
> On Fri, 15 Jul 2022, Markuss Broks wrote:
>
>> Hi Lee,
>>
>> Sorry to bother you again, but I've got additional questions while I was
>> preparing the next version of the series:
>>
>> On 6/15/22 00:32, Lee Jones wrote:
>>> On Sat, 23 Apr 2022, Markuss Broks wrote:
>>>
>>>> Silicon Mitus SM5703 is a multi-function device, meant to be
>>> Please avoid using the term MFD.
>>>
>>> How is the device described in the data-sheet?
>>>
>>> What do you mean by "meant to be"?
>>>
>>>> used in mobile devices. It has several modules: LDO, BUCK regulators,
>>> Modules or functions?
>>>
>>>> charger circuit, flash LED driver, a fuel gauge for monitoring the battery
>>>> and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
>>>> they use separate i2c lines to communicate with the device, while charger
>>> "I2C"
>>>
>>>> circuit, LED driver and regulators are on the main i2c line the device is
>>>> controlled with.
>>>>
>>>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>>>> ---
>>>>    MAINTAINERS                |   8 +++
>>>>    drivers/mfd/Kconfig        |  13 +++++
>>>>    drivers/mfd/Makefile       |   1 +
>>>>    drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
>>>>    include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
>>>>    5 files changed, 205 insertions(+)
>>>>    create mode 100644 drivers/mfd/sm5703.c
>>>>    create mode 100644 include/linux/mfd/sm5703.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 6157e706ed02..6125ed1a3be4 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>>>>    F:	include/linux/srcu*.h
>>>>    F:	kernel/rcu/srcu*.c
>>>> +SM5703 MFD DRIVER
>>>> +M:	Markuss Broks <markuss.broks@gmail.com>
>>>> +S:	Maintained
>>>> +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>>>> +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>>>> +F:	drivers/mfd/sm5703.c
>>>> +F:	drivers/regulator/sm5703-regulator.c
>>>> +
>>>>    SMACK SECURITY MODULE
>>>>    M:	Casey Schaufler <casey@schaufler-ca.com>
>>>>    L:	linux-security-module@vger.kernel.org
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 3b59456f5545..c13a99ceae99 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1237,6 +1237,19 @@ config MFD_SM501
>>>>    	  interface. The device may be connected by PCI or local bus with
>>>>    	  varying functions enabled.
>>>> +config MFD_SM5703
>>>> +	tristate "Silicon Mitus SM5703 MFD"
>>>> +	depends on I2C
>>>> +	depends on OF
>>>> +	select MFD_CORE
>>>> +	select REGMAP_I2C
>>>> +	help
>>>> +	  This is the core driver for the Silicon Mitus SM5703 multi-function
>>> Please drop the MFD term, as above.
>>>
>>>> +	  device. This device is meant to be used in phones and it has numerous
>>> "meant to be"?
>>>
>>>> +	  modules, including LED controller, regulators, fuel gauge, MUIC and
>>> Either "an LED controller" or "LED controllers"
>>>
>>> Same with "charger circuit" below.
>>>
>>>> +	  charger circuit. It also support muxing a serial interface over USB
>>> "supports"
>>>
>>> What kind of serial?
>>>
>>>> +	  data lines.
>>>> +
>>>>    config MFD_SM501_GPIO
>>>>    	bool "Export GPIO via GPIO layer"
>>>>    	depends on MFD_SM501 && GPIOLIB
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index 858cacf659d6..ca8b86736a36 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>>>>    rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
>>>>    obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>>>>    obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
>>>> +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
>>>> diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
>>>> new file mode 100644
>>>> index 000000000000..7f9838149051
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/sm5703.c
>>>> @@ -0,0 +1,78 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/gpio/consumer.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/mfd/core.h>
>>>> +#include <linux/mfd/sm5703.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +static const struct mfd_cell sm5703_devs[] = {
>>>> +	{ .name = "sm5703-regulator", },
>>>> +};
>>> Where are the rest of the child drivers?
>> Should those devices still be present even though there's no driver for them
>> (yet) ? I have a WIP version of driver for almost every function, but I
>> currently lack time to get them done.
> Without them the driver-set is useless, no?
>
> We try to refrain from applying dead code.
>
> A lot of it has a tendency to stay that way.
Well, in my opinion, having just the regulator driver is already useful 
enough: my board (Samsung Galaxy J5 (2015) ) uses one of LDO outputs for 
powering the touchscreen. Touchscreen is kind of vital functionality for 
a phone so I decided to upstream parts that are necessary for it first 
and finish up other stuff later. It's not the only board that uses 
SM5703's regulators for supplying all different kinds of hardware, either.
>
> [...]
>
>>>> +++ b/include/linux/mfd/sm5703.h
>>>> @@ -0,0 +1,105 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +
>>>> +#ifndef _SM5703_H
>>>> +#define _SM5703_H
>>>> +
>>>> +struct sm5703_dev {
>>>> +	struct device *dev;
>>>> +	struct regmap *regmap;
>>>> +	struct gpio_desc *reset_gpio;
>>>> +};
>>>> +
>>>> +// Regulator-related defines
>>> No C++ style comments.
>>>
>>>> +#define SM5703_REG_LDO1				0x1A
>>> I'd drop the REG parts from these.
>> I have no issues with that, however the already upstreamed sm5703-regulator
>> driver uses those defines. If I change the define name, how should I make
>> changes in that driver, would it be reasonable to send an additional patch
>> together with the new MFD series?
> It would.  You could also keep them in for now.
>
> They're not a major blocker.
>
- Markuss
