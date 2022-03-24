Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1014E62A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349831AbiCXLtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiCXLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:49:19 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F86EA1461;
        Thu, 24 Mar 2022 04:47:47 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id b24so5282620edu.10;
        Thu, 24 Mar 2022 04:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dFOPtoWPcTnsyVvvROBn8Be2+egyjb08ekt/mEU0j1k=;
        b=yBGTo3sSTgM4+UOOwcC6sPgGrb+GIP4XioqqEFeZG+gfjvVdykUHj/rBrbucmo09DJ
         cihpinNMLTbB2Jxs6ImVaJU/AWsllN1Ju/uFCjkaPipp6fiW5TKMTlzty0zcVQhwqyc7
         keRglxHEoUbE3iUxHnkoqxzLdo4xqjdw/H1E2x4D9N73pOVXZGV7Jvc8VW9E1A6sIBRY
         UQGROssQauENPTai0qqltimtzA7MDKTR4uZgfOfI3RJdXOTqHtuOlPWPZPIOvgUJEqpe
         05JjSppW9QE9sl32h9Q8q8KboD2qv+jVqHEQc241XG99aMJqwkpw7l8TqKObPWejdQuW
         vrKg==
X-Gm-Message-State: AOAM532qwuxNVtUHXO8zOQH2X3MRuuEId/sWTK6pgAbMo9mtfxB99z29
        45GPS7PhhNO485q+UYYRkG4=
X-Google-Smtp-Source: ABdhPJypl5ghtQpKOlZZNUXQUQvR9b2GpZ9XFdEpskJFtEHsYMH2vGZZV+HFKZbc/sfsgk0GAEBomA==
X-Received: by 2002:aa7:c348:0:b0:418:e515:69e with SMTP id j8-20020aa7c348000000b00418e515069emr6143338edr.393.1648122466050;
        Thu, 24 Mar 2022 04:47:46 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm1031073ejc.25.2022.03.24.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:47:45 -0700 (PDT)
Message-ID: <c96f889e-cbd0-4221-fcff-ef0cf93236d2@kernel.org>
Date:   Thu, 24 Mar 2022 12:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 7/7] ARM: dts: s5pv210: Add charger support in Aries
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
 <CY4PR04MB05671BD0A7FF349E8B04EE84CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <2eee2611-d618-3fe2-4315-c57a26de6b21@kernel.org>
 <CY4PR04MB0567BD17C2EED0CAFA044020CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CY4PR04MB0567BD17C2EED0CAFA044020CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 18:20, Jonathan Bakker wrote:
> 
> 
> On 2022-03-23 8:31 a.m., krzk@kernel.org wrote:
>> On 23/03/2022 16:03, Jonathan Bakker wrote:
>>> Add charger-manager support to Aries boards to allow safe
>>> charging of the battery without the need for userspace control.
>>>
>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>> ---
>>>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 162 ++++++++++++++++++++++
>>>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 144 +++++++++++++++++++
>>>  2 files changed, 306 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>> index 7427c84f1126..9530231b7a70 100644
>>> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>>> @@ -57,6 +57,168 @@
>>>  		pinctrl-0 = <&main_micbias_ena>;
>>>  	};
>>>  
>>> +	thermal-zones {
>>> +		batt_thermal: batt-thermal {
>>> +			polling-delay-passive = <60000>; /* 60 seconds */
>>
>> There is no passive cooling device, so why do you need it?
>>
> 
> The charger manager code needs a passive cooling device, so that's
> why this is present here.
> 
>>> +			polling-delay = <600000>; /* 600 seconds */
>>> +
>>> +			thermal-sensors = <&batt_thermistor>;
>>> +		};
>>> +	};
>>> +
>>> +	batt_thermistor: thermal-sensor-0 {
>>> +		compatible = "generic-adc-thermal";
>>> +		#thermal-sensor-cells = <0>;
>>> +		io-channels = <&adc 6>;
>>> +		io-channel-names = "sensor-channel";
>>> +
>>> +		temperature-lookup-table = <
>>> +			(-20000) 1859
>>> +			(-19000) 1846
>>> +			(-18000) 1832
>>> +			(-17000) 1818
>>> +			(-16000) 1804
>>> +			(-15000) 1790
>>> +			(-14000) 1773
>>> +			(-13000) 1756
>>> +			(-12000) 1739
>>> +			(-11000) 1722
>>> +			(-10000) 1705
>>> +			(-9000) 1691
>>> +			(-8000) 1677
>>> +			(-7000) 1663
>>> +			(-6000) 1649
>>> +			(-5000) 1635
>>> +			(-4000) 1550
>>> +			(-3000) 1510
>>> +			(-2000) 1500
>>> +			(-1000) 1490
>>> +			0 1480
>>> +			1000 1470
>>> +			2000 1460
>>> +			3000 1450
>>> +			4000 1430
>>> +			5000 1420
>>> +			6000 1406
>>> +			7000 1386
>>> +			8000 1366
>>> +			9000 1346
>>> +			10000 1326
>>> +			11000 1302
>>> +			12000 1278
>>> +			13000 1254
>>> +			14000 1230
>>> +			15000 1206
>>> +			16000 1182
>>> +			17000 1158
>>> +			18000 1134
>>> +			19000 1110
>>> +			20000 1086
>>> +			21000 1059
>>> +			22000 1035
>>> +			23000 1011
>>> +			24000 987
>>> +			25000 963
>>> +			26000 937
>>> +			27000 913
>>> +			28000 889
>>> +			29000 865
>>> +			30000 841
>>> +			31000 816
>>> +			32000 794
>>> +			33000 772
>>> +			34000 750
>>> +			35000 728
>>> +			36000 708
>>> +			37000 690
>>> +			38000 672
>>> +			39000 654
>>> +			40000 636
>>> +			41000 616
>>> +			42000 599
>>> +			43000 580
>>> +			44000 565
>>> +			45000 548
>>> +			46000 529
>>> +			47000 512
>>> +			48000 495
>>> +			49000 478
>>> +			50000 461
>>> +			51000 440
>>> +			52000 431
>>> +			53000 416
>>> +			54000 405
>>> +			55000 396
>>> +			56000 375
>>> +			57000 360
>>> +			58000 347
>>> +			59000 334
>>> +			60000 325
>>> +			61000 311
>>> +			62000 303
>>> +			63000 296
>>> +			64000 290
>>> +			65000 279
>>> +			66000 265
>>> +			67000 254
>>> +			68000 240
>>> +			69000 220
>>> +			70000 206>;
>>> +	};
>>> +
>>> +	charger_manager: charger-manager-0 {
>>> +		compatible = "charger-manager";
>>
>> Sorry, this is not a hardware. It's a hack to configure kernel charging
>> driver via DT which was made deprecated.
> 
> Thanks, I missed the deprecation notice in the binding file.
> 
> What would be the better way of creating a functional charging system?
> A new device-specific driver?

I am not sure, but maybe you could use charger-manager, just configure
it from user-space (or add such features). Better ask power supply
maintainer. But anyway charger-manager is mostly abandoned. I don't
think anyone develops it.

>  Userspace monitoring of temperature/connected
> device and extensions to the max8998 driver for enabling/disabling/configuring
> charging via the power supply subsystem instead of the regulator subsystem?
> Something else?

Enabling charging via regulators was done only for some drivers, I think
for charger-manager. I don't think it is the recommended way now.

Everything should be controlled rather via power supply from user-space.

How postmarketos or lineageos are doing it?

> 
> The way I understand the charging system, there is
> 
> - The fuelgauge (max17042)
> - The max8998 charger portion, including the ability to vary the current
> - The thermistor for checking battery temperature
> - The FSA9480 to determine what sort of cable is connected
> 

Best regards,
Krzysztof
