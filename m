Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADC5AD79B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiIEQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiIEQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:34:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA215FD2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:34:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p16so13817462lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yEx5//ShOkRRoNBbjByMt9QJ4HAKCceTerVbLkUZNS0=;
        b=YCVRx8gQfAYB5aIBO0aXUKLZ9+k/xRezTGzMgKHcG24UJ1GbD5Tl5KG6D2mdawmk2f
         BhWRDjhAzaclJ7UjxMH/leRbobEnfmggKAMt84+WNf/MLTrk6sRW0H5oQJdv3oUWSym5
         hdModvgiD0st7x4PFTXabjQaNRC8YEs7bLEwaap2jKGDbcx2RoNWno9tFMJ7JRTpG3Nh
         IEqXMEvR1lf4JnxU7sXzsMR4cCq0u8XItFvzPKhX03p+k9Do2GT40+OK8BI4A37GfqZs
         /0UxdWUGwpeN+T7y66Rx6GgCCMohunTocVMQCXgYY4mJltzV7Z5IfyudU6fFXTaIZ6D2
         Le+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yEx5//ShOkRRoNBbjByMt9QJ4HAKCceTerVbLkUZNS0=;
        b=oeFFKQc4fDqY9or5jjmxMCmSnIFlXaDRmOc/LvdPYqN7AnveS6CIvlPRnAhD+Nx3uF
         4svh/8nSjGC1uojt0+bLLVqb+jZ7iRArZUs+vq3F8uMNpnfX5QMZN0tbOX6YmkuKqlMl
         BOf2UelH5K8lEf3jWQ1T6lORly2TNbH8ISW6X80OJ4qZMXp6zm/16c/YcY9DJOpsyS1T
         mvCLb2BbY9KkVRfjO+nosI5t7TKDt/JOoxdbO7U2SxT4Cgwrn60xcxKocq1V6x0EE6vu
         L02pxM+4PK5Sp3p49cv7Qo2hSkYnjj5intIrrQj4ob9LX+cXedJ+9sXr8RARql2qnPKB
         0Ybg==
X-Gm-Message-State: ACgBeo1gkzLfHpkTXuZDstpg2xw/xA5zXLz3xoQRkYQ2JEDfNl0ukRaD
        eu42p7bBacN6NaxMdnjwzrtLqg==
X-Google-Smtp-Source: AA6agR4+el+HYyKgzhzy2PPDNyV6fBi7zJXtMYVBVPN/XFLUFV5k3+b1idELLg20DQ3NwBTTPHVhEw==
X-Received: by 2002:a05:6512:12cc:b0:494:b251:5b0f with SMTP id p12-20020a05651212cc00b00494b2515b0fmr4146602lfg.111.1662395690791;
        Mon, 05 Sep 2022 09:34:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b0047f8e9826a1sm1239112lfr.31.2022.09.05.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:34:50 -0700 (PDT)
Message-ID: <7a43aa79-9c40-867c-c585-3bb448a54647@linaro.org>
Date:   Mon, 5 Sep 2022 18:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali> <YxE2JqJutZ0ilghH@lunn.ch>
 <20220903152735.2ga3iwrivh6zhibf@pali>
 <30d3f753-187f-4a3f-c14a-f3b003f23773@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <30d3f753-187f-4a3f-c14a-f3b003f23773@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 18:19, Florian Fainelli wrote:
> 
> 
> On 9/3/2022 8:27 AM, Pali Rohár wrote:
>> On Friday 02 September 2022 00:45:58 Andrew Lunn wrote:
>>> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
>>>> PING?
>>>>
>>>> On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
>>>>> At i2c address 0x2a is MCU command interface which provides access to GPIOs
>>>>> connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
>>>>>
>>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>>>>
>>>>> ---
>>>>> Same change was already sent to U-Boot project together with driver. As
>>>>> Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
>>>>> this change also in Linux. There is a plan to write also Linux driver for
>>>>> Turris Omnia MCU, like there is already in U-Boot.
>>>>>
>>>>> https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
>>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
>>>>> ---
>>>>>   arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>> index f4878df39753..f655e9229d68 100644
>>>>> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>> @@ -184,7 +184,13 @@
>>>>>   			#size-cells = <0>;
>>>>>   			reg = <0>;
>>>>>   
>>>>> -			/* STM32F0 command interface at address 0x2a */
>>>>> +			/* MCU command i2c API */
>>>>> +			mcu: mcu@2a {
>>>>> +				compatible = "cznic,turris-omnia-mcu";
>>>>> +				reg = <0x2a>;
>>>>> +				gpio-controller;
>>>>> +				#gpio-cells = <3>;
>>>>> +			};
>>>
>>> Please document the binding, preferably in yaml.
>>
>> I'm not going to send any new yaml dt binding document as I see that
>> dt bindings is clearly deprecated project. Either patches for dt
>> bindings are waiting without any answer for months (maybe year?) or
>> patches are ignored/not accepted by beyond reasons or there are request
>> for changes which cannot work on the real hardware or that new yaml
>> cannot be parsed/validated due to ton of bugs in other schemas.
> 
> These are some pretty hard statements that are not nearly true, maybe 
> they are based upon your past experience, but Rob and Krysztof provide 
> feedback within a few days at most on DT bindings and DTS files.

Pali, you wrote in the past that you cannot run one command to install
dtschema ("pip") thus for you this automated testing is
difficult/broken/non working. If running one "pip" command is not
possible, what I can say more? Shall I login to your machine and set it
up? Or did you configure your machine that way, that it is not possible
to run one pip command?

Whether the patches are waiting for months and years is difficult to
address to, without actual links. Because for sure you will be able to
find one patch which was missed in our inboxes and you did not get an
answer...  With Rob we both work much more than reasonable/healthy 8h
per day... Yet I recall you always received feedback, just not always
what you expected or wanted.

This binding here was never sent to mailing list:
https://lore.kernel.org/all/?q=cznic%2Cturris-omnia-mcu

>> Sorry, this is just a waste of time and energy to write new those yamls
>> as it does not bring any value.

It brings quite nice value - allows to check whether your bindings and
your DTS are correct. Any difficulty to install and run dtschema is not
equal to "does not bring any value"...

Anyway devices cannot go without bindings, thus it's a NAK.

Best regards,
Krzysztof
