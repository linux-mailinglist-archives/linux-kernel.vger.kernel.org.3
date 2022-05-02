Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97851705E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385333AbiEBNfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385321AbiEBNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:35:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6680A1B3;
        Mon,  2 May 2022 06:32:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so6648993oty.3;
        Mon, 02 May 2022 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JBrd1Rj8pXekZRhf1iSXV3bf3S85pGZUSMP33kjZN68=;
        b=FoKDFwoHhjBCICe1m9uEBjPrZ4P9ubEt0WV2a0Acx6ftW2lW+82rDH4+dUhPpfsJ5I
         0DAnB0vKNTRzRTH1+uwc/f3Z5kOcSvlP2XRO1/W4/d9J1+3vEnjujczb+oh7mByYKj0U
         eVengyXn41u3fBqkmTy6pevAeYD6F/0nzxOdoKoK6L6MZhSf0YOjrbGMdrOIxDJzyiOl
         jX7LTekUN8tfH+DNnoOACbIp8HaCCPvr2Bcw6pKciD/sK+TU9/lyP64x7OVhYRp7aq/S
         4ASQyGhkAhmLF1z+yn0Y9LwaSPzSfYnkOq5LYJ5NSxdhElBtPwhG9o6AkTptRwALh0cG
         9+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JBrd1Rj8pXekZRhf1iSXV3bf3S85pGZUSMP33kjZN68=;
        b=NAKi3GhatLAdnw3iD261gtW4f78Pbkjon0HC4SYtB/s68ayLdEVg+/06iIgDeIBvY6
         Wn8Cuj4XUiIbcN71UB8RSCgiECWFwe4tdamfq+aAV45LckUSiil2cqXLnjlGbBp8OI5D
         oAbksYAg/YEzlJJwRaQxiwb1Ev3fJw++0lkkcA7vk2sNY8UceuLIcTBF++tztQGWwTN0
         KIv9kz1NhWCW2Q4KHqH92jnx50Vb87p04d/avZeKFI+6gZe+z20CofACs7BP65+fK72s
         mewFsF8ucBSA83g+T1h3wh55VeEq7XOT8RQH3z9sIc3eCTzULV0KYrD0Ij1DpiEx+eMo
         3RUg==
X-Gm-Message-State: AOAM53107FxIxDRkMS8ZoFabKBaQKazxLG8EEnL0deAuHS/VpjWCHj9k
        PcvD7Vpo8eRBapF79VUuIXw=
X-Google-Smtp-Source: ABdhPJwufWJNpmAQdVUJkxoWJlbp27/3rQmMvO+c4GsVgKlA1e+XjcWAY6jqPd3f+SpQoUz2CdRK1g==
X-Received: by 2002:a9d:7f13:0:b0:605:f24e:f738 with SMTP id j19-20020a9d7f13000000b00605f24ef738mr4068097otq.323.1651498320034;
        Mon, 02 May 2022 06:32:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b11-20020a056808010b00b00325cda1ff87sm2322405oie.6.2022.05.02.06.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:31:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <21a89ae0-7152-49eb-7500-7d46dfb259f6@roeck-us.net>
Date:   Mon, 2 May 2022 06:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Ruslan Zalata <rz@fabmicro.ru>
Cc:     Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220502110010.q7vvdkdpaiz5acjl@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 04:00, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
>> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
>> low rate (6 bit) ADC that is often used for extra keys. There's a driver
>> for that already implementing standard input device, but it has these
>> limitations: 1) it cannot be used for general ADC data equisition, and
>> 2) it uses only one LRADC channel of two available.
>>
>> This driver provides basic hwmon interface to both channels of LRADC on
>> such Allwinner SoCs.
>>
>> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
>> ---
>>   MAINTAINERS                       |   6 +
>>   drivers/hwmon/Kconfig             |  13 ++
>>   drivers/hwmon/Makefile            |   1 +
>>   drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++
>>   4 files changed, 300 insertions(+)
>>   create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5e8c2f61176..d9c71e94133 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18861,6 +18861,12 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>>   F:	drivers/input/keyboard/sun4i-lradc-keys.c
>>   
>> +SUN4I LOW RES ADC HWMON DRIVER
>> +M:	Ruslan Zalata <rz@fabmicro.ru>
>> +L:	linux-hwmon@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
>> +
>>   SUNDANCE NETWORK DRIVER
>>   M:	Denis Kirjanov <kda@linux-powerpc.org>
>>   L:	netdev@vger.kernel.org
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 68a8a27ab3b..86776488a81 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called sis5595.
>>   
>> +config SENSORS_SUN4I_LRADC
>> +	tristate "Allwinner A13/A20 LRADC hwmon"
>> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
>> +	help
>> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
>> +	  Both channels are supported.
>> +
>> +	  This driver can also be built as module. If so, the module
>> +	  will be called sun4i-lradc-hwmon.
>> +
>> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
>> +	  of these must be used at a time.
> 
> How do you plan on enforcing that?
> 
	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
                                  ^^^^^^^^^^^^^^^^^^^^^

> I guess a better path forward would be to either register an hwmon
> device in the original driver, or convert that driver to iio and use
> iio-hwmon.
> 
Both is fine with me.

Guenter

