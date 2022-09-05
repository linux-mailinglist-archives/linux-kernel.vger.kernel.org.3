Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442425AD73E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiIEQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiIEQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:19:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130FA54CB2;
        Mon,  5 Sep 2022 09:19:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id w4so2627974qvp.2;
        Mon, 05 Sep 2022 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uhRqw8EqRi+lEySsOz/4qBzr6CVwtQdAYLBsx5kklCA=;
        b=p46B1b/QZs1GQ1tq8aypEYLTnKEC4iX6EHzXcQ59pLNEw3VGb58iP9BuykUu/xl5XB
         4ISoH3/KlB07AW30sucKVshpCUTC6g0oqKZh6V+sSXRSneIaHXTtqUjtD5Xj7s0AaCj6
         VYSOc3n5i44kGNhJcuTgBMgVORHCPSSBKc9CUzIox4ywkMY/Ti+QXxhgh9JLRB9QnBVC
         WrJa+4mjUZaFsReYojvUmkZSrssntsQKzY+N29HWlymSlTfR3E1FAfXmNtshT0/D64bS
         v85qYeQ13x4ZNxEydaoJSYKkajcNH0sOqfqitfIACeVR4w+xNyH4oCu6Mf4T+MQxo9E0
         Y0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uhRqw8EqRi+lEySsOz/4qBzr6CVwtQdAYLBsx5kklCA=;
        b=LcF4NXkYgQebRDo15uc4eP5lnohYTvuxtsFWo1PtKt4ZHMFhMXDuEoEKQAFfq6v++H
         hDFR60+ztTT4sE8CdPi3n22LS5AZdGjh+jmQZjnsxoScO3f55cRefTvmzF6N9ThiV2LV
         AVQ2WDG5pRowcqVVM3O+mfwJSGRfGI0ctZtkeT3/lMKGxAEqsx15IrWr0D5lXIvaCeMS
         UXcK1qfH4pcXCor9HlL/oIjwWGuh33MJ9cIirHPjdnRjF6lBZB+3LKQhMb4yUw9gh98l
         F+uWOg1Yb1Y9CshiJvUljxjBsrDjCnVQuQ65yrg2fDYwKk+hpf5XuBoimqCabXo2mrAk
         439A==
X-Gm-Message-State: ACgBeo3iLGuUBcTBAI2ZeTLqI2m3IZ6BDHOB5D4WrFUGAtqeVf0yFHTD
        5c2FMfrzK0L5RsSLUSUem28=
X-Google-Smtp-Source: AA6agR6hrZw+mQNfPBoAYB1l7x3IaubOHFaNtcMY3M3RYXt3dlGoh1+gdbHl9KNSFnvS1Kbd6SLuFw==
X-Received: by 2002:a05:6214:d61:b0:499:6d:9e82 with SMTP id 1-20020a0562140d6100b00499006d9e82mr34420545qvs.20.1662394749119;
        Mon, 05 Sep 2022 09:19:09 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84a8e000000b00341a807ed21sm7296111qtq.72.2022.09.05.09.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:19:08 -0700 (PDT)
Message-ID: <30d3f753-187f-4a3f-c14a-f3b003f23773@gmail.com>
Date:   Mon, 5 Sep 2022 09:19:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220903152735.2ga3iwrivh6zhibf@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2022 8:27 AM, Pali Rohár wrote:
> On Friday 02 September 2022 00:45:58 Andrew Lunn wrote:
>> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
>>> PING?
>>>
>>> On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
>>>> At i2c address 0x2a is MCU command interface which provides access to GPIOs
>>>> connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
>>>>
>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>>>
>>>> ---
>>>> Same change was already sent to U-Boot project together with driver. As
>>>> Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
>>>> this change also in Linux. There is a plan to write also Linux driver for
>>>> Turris Omnia MCU, like there is already in U-Boot.
>>>>
>>>> https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
>>>> ---
>>>>   arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>> index f4878df39753..f655e9229d68 100644
>>>> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>> @@ -184,7 +184,13 @@
>>>>   			#size-cells = <0>;
>>>>   			reg = <0>;
>>>>   
>>>> -			/* STM32F0 command interface at address 0x2a */
>>>> +			/* MCU command i2c API */
>>>> +			mcu: mcu@2a {
>>>> +				compatible = "cznic,turris-omnia-mcu";
>>>> +				reg = <0x2a>;
>>>> +				gpio-controller;
>>>> +				#gpio-cells = <3>;
>>>> +			};
>>
>> Please document the binding, preferably in yaml.
> 
> I'm not going to send any new yaml dt binding document as I see that
> dt bindings is clearly deprecated project. Either patches for dt
> bindings are waiting without any answer for months (maybe year?) or
> patches are ignored/not accepted by beyond reasons or there are request
> for changes which cannot work on the real hardware or that new yaml
> cannot be parsed/validated due to ton of bugs in other schemas.

These are some pretty hard statements that are not nearly true, maybe 
they are based upon your past experience, but Rob and Krysztof provide 
feedback within a few days at most on DT bindings and DTS files.

> 
> Sorry, this is just a waste of time and energy to write new those yamls
> as it does not bring any value.

So you say.
-- 
Florian
