Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18135ADFDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiIFGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiIFGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:34:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6F13D47
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:34:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q21so1644603lfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 23:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LVOsXJQI125Ckr6ifoVQCFLirqLRDSFdjJHHgypslT4=;
        b=ciNvF/UU5tVYPVCRAiw7CGteWeFPqdPuL+O4PYNlSGsBeR9/M0QIQwDdWqW7ZfpQou
         EaipA3U969KdACPaxocWDO/AK8BqAOMU7buzPzJ2xtG0d0H1eyrFrQWHeJaOdAhzulim
         Dpl6p4wNIrHMWf12bA0bnudNk2AzafciZfi07SKTwq8eScSeY+M6DtHnMCBVxFxBe643
         y//+ljs3F0ZLrEPMSmVgrV1YEpZjf/fol91ZzAxJGUPb2GNqFPFdxL/KAwM7y73ddSHB
         KVxF5/sp/h4krd4TeJBPGm4N+ufkcvVyZuX/KerhnyrC9hrmcJ+jUekWS6GdqvGgARJO
         9YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LVOsXJQI125Ckr6ifoVQCFLirqLRDSFdjJHHgypslT4=;
        b=EJOjvMbowyrrRBLsJeV3m0UGZnV0hiKrnbm0PgNyOw2DELWzW2TLYYZpW5IaW0orUI
         fGhAIzlxD4zajegpuqust/HEyRKH76D2+Gkp1YNzX73sMTq4U/tPsZhLsZU1eOlY1AFb
         qyMlbclpETR0j3se0/CREFbllDHyefm8Genyrpn/WiF+MwtNwNDVZadM282cK/LYngny
         bcKcs4gapaY9gnZSAn6Q/aY6rFxkgKuCtY9p79Q0EPgAGIYihyVvCVV30g/m9NpHqmcz
         SdBaxF8BkUUR2SrCIO4kHRf6uCmJZNdSnafAMbF/mm39Hopb6z4PU7JgE2LKW7itdiKD
         YDnA==
X-Gm-Message-State: ACgBeo3Q22ToT05AKeAlRpVJomhQl7swb7mLp2qKno68TP6nKXrqO+QH
        RugJm58aqPHvzyUHMe5fJAWOUw==
X-Google-Smtp-Source: AA6agR6Zm9uFyMxlZAARXbaJvkP1ZK4ka/fEwh8uVkXFg+wiZq8w/eJghDtqiLLLXy36by83U/ny5g==
X-Received: by 2002:a05:6512:3faa:b0:48a:f17a:579e with SMTP id x42-20020a0565123faa00b0048af17a579emr18867679lfa.30.1662446085234;
        Mon, 05 Sep 2022 23:34:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g3-20020a2ea4a3000000b0026707e5a611sm1712073ljm.20.2022.09.05.23.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 23:34:44 -0700 (PDT)
Message-ID: <1750926a-9177-a26f-1219-c85eaf676890@linaro.org>
Date:   Tue, 6 Sep 2022 08:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
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
 <7a43aa79-9c40-867c-c585-3bb448a54647@linaro.org>
 <20220905171226.fla6i5cgrx2lbq3u@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905171226.fla6i5cgrx2lbq3u@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 19:12, Pali Rohár wrote:
> On Monday 05 September 2022 18:34:48 Krzysztof Kozlowski wrote:
>> On 05/09/2022 18:19, Florian Fainelli wrote:
>>>
>>>
>>> On 9/3/2022 8:27 AM, Pali Rohár wrote:
>>>> On Friday 02 September 2022 00:45:58 Andrew Lunn wrote:
>>>>> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
>>>>>> PING?
>>>>>>
>>>>>> On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
>>>>>>> At i2c address 0x2a is MCU command interface which provides access to GPIOs
>>>>>>> connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
>>>>>>>
>>>>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>>>>>>
>>>>>>> ---
>>>>>>> Same change was already sent to U-Boot project together with driver. As
>>>>>>> Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
>>>>>>> this change also in Linux. There is a plan to write also Linux driver for
>>>>>>> Turris Omnia MCU, like there is already in U-Boot.
>>>>>>>
>>>>>>> https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
>>>>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
>>>>>>> ---
>>>>>>>   arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
>>>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>>>> index f4878df39753..f655e9229d68 100644
>>>>>>> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>>>> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
>>>>>>> @@ -184,7 +184,13 @@
>>>>>>>   			#size-cells = <0>;
>>>>>>>   			reg = <0>;
>>>>>>>   
>>>>>>> -			/* STM32F0 command interface at address 0x2a */
>>>>>>> +			/* MCU command i2c API */
>>>>>>> +			mcu: mcu@2a {
>>>>>>> +				compatible = "cznic,turris-omnia-mcu";
>>>>>>> +				reg = <0x2a>;
>>>>>>> +				gpio-controller;
>>>>>>> +				#gpio-cells = <3>;
>>>>>>> +			};
>>>>>
>>>>> Please document the binding, preferably in yaml.
>>>>
>>>> I'm not going to send any new yaml dt binding document as I see that
>>>> dt bindings is clearly deprecated project. Either patches for dt
>>>> bindings are waiting without any answer for months (maybe year?) or
>>>> patches are ignored/not accepted by beyond reasons or there are request
>>>> for changes which cannot work on the real hardware or that new yaml
>>>> cannot be parsed/validated due to ton of bugs in other schemas.
>>>
>>> These are some pretty hard statements that are not nearly true, maybe 
>>> they are based upon your past experience, but Rob and Krysztof provide 
>>> feedback within a few days at most on DT bindings and DTS files.
>>
>> Pali, you wrote in the past that you cannot run one command to install
>> dtschema ("pip") thus for you this automated testing is
>> difficult/broken/non working. If running one "pip" command is not
>> possible, what I can say more? Shall I login to your machine and set it
>> up? Or did you configure your machine that way, that it is not possible
>> to run one pip command?
> 
> Sorry no, it is too late. I have already lost interested in it. For me
> it is like a ride on the dead horse.
> 
>> Whether the patches are waiting for months and years is difficult to
>> address to, without actual links. Because for sure you will be able to
>> find one patch which was missed in our inboxes and you did not get an
>> answer...  With Rob we both work much more than reasonable/healthy 8h
>> per day... Yet I recall you always received feedback, just not always
>> what you expected or wanted.
> 
> Now I have replied to one example email without a reaction. 

Which was not a patch. You asked us for some knowledge and Rob provided
you answers. Or maybe you think that our job is to solve each technical
problem of everyone in the world till asking person is happy? Sounds
like nice job. :)

> Another
> example is this https://github.com/devicetree-org/dt-schema/pull/64
> which completely blocked any improvements which I proposed in PCIe core
> code for fixing PCIe state machine. After half of year of waiting I
> decided to stop any work on this as I see it is dead those schemas.

It finished with Rob comments, so ball is on your side, isn't it?

> Other examples are that received feedback suggest to do change which
> does not work on the real hardware. So yes, I cannot accept, expect or
> want something like that. Schema which works in that ultra-supper-duper
> software but DTS written according to it does not work on the real
> hardware is for me useless...
> 
>> This binding here was never sent to mailing list:
>> https://lore.kernel.org/all/?q=cznic%2Cturris-omnia-mcu
>>
>>>> Sorry, this is just a waste of time and energy to write new those yamls
>>>> as it does not bring any value.
>>
>> It brings quite nice value - allows to check whether your bindings and
>> your DTS are correct. Any difficulty to install and run dtschema is not
>> equal to "does not bring any value"...
> 
> It just took lot of my time and did nothing useful. Hence for it it has
> zero value.

Sorry to hear. When I was very, very small, C also took a lot of my time
and did nothing useful. Nothing useful in that stage of my knowledge, of
course.


Best regards,
Krzysztof
