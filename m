Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EF586DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiHAPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHAPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:34:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A22AE26;
        Mon,  1 Aug 2022 08:34:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 206so6509601pgb.0;
        Mon, 01 Aug 2022 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4o2qdt7SZGblVE7kju+ci215WWeZIAGpk1CSOhpNJVg=;
        b=QG2mU3hq3vwmH+oiUzkI5Bbir1f0F6w+DXNjRNVGI0Ptv/LjVmZFQ3jxSjb61eDArQ
         EaM4kizSLifnhwT9E9M8AAewtjqpw7z4iKJGeJysdcsUspSkWkq79N6gTU8xgp5TyiFc
         u6ugIPSs9qKeZ3PbAlppVjUQL0T1Ue+Hl4IYizCYen4bOlDtVJrZXZGv1ennRomjzcHS
         qaHUqJVTzGIEQXfHj4s6qnQAzI0L1YXoQw7JRrn8Oqa9RKoBabEsd2A1ZDRyNsvf0nEV
         ww4buTLCqi/lstrjDkRusj8j1bHF0UvBjIVAcbEyG9yP0H4cTBqAdUSMwA+tbWruSFSt
         LPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4o2qdt7SZGblVE7kju+ci215WWeZIAGpk1CSOhpNJVg=;
        b=Elrom1P23X/Xrtaic0iSglVLh0oFrnF5Rr/WkV5UtT+T/2L/XjZbGrrA+OLVG4nXBi
         DHaSpmRPTwbuK6tfOloTrhaHNFMbCWd02lISTCfFGR7N3QeeQYnD+xFDvy03mLZQ5yJa
         NtiY0g4wsROz7bKj6/x1shev+138NEpE1BLyNQKPbZzEZXeTvMXbioNdsB78wMMWJ2ms
         7wBMu57GUkQ1fs80+NgTFgVln5sEXmWL0mtr3iNOZjKku586pzJKElGLWfQrzyAjEG2S
         I+nRnnLG+C1FPDfTgSvwBv2mGv4XFK0nn4ezK6vMO4sPYnJbQ3blV6zbl3ZbPzbgg2AC
         Of1g==
X-Gm-Message-State: AJIora8eUjRy6hTGBumIKvZFi22TCk2OFT1u9qHNuRqMJaamEGtzhM6W
        ct9cjeDsWLZGrQlqFOKk4zs=
X-Google-Smtp-Source: AGRyM1sNAgHSTTEW9vSsltNGBUcdjujIMwX8ay61Yf3t820y1s5yAEeZn6swq7mfiFFV6TE6QYManQ==
X-Received: by 2002:a63:2c10:0:b0:411:4fd8:9fc8 with SMTP id s16-20020a632c10000000b004114fd89fc8mr14109427pgs.313.1659368063121;
        Mon, 01 Aug 2022 08:34:23 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902f60e00b0016c4331e61csm9712401plg.137.2022.08.01.08.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:34:22 -0700 (PDT)
Message-ID: <f89b9f28-5e59-ac43-ffc1-cc04a394c369@gmail.com>
Date:   Mon, 1 Aug 2022 08:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous SError
 Interrupt
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>, stefan.wahren@i2se.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210210114829.2915de78@gollum>
 <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
 <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
 <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
 <6612b35f-86bb-bb1e-bae8-188366495dbe@gmail.com>
 <20220727100510.4723ec84@smeagol>
 <f309790a-a41b-cb2d-811e-51dc08154c04@gmail.com>
 <20220728103513.38e93fa9@gollum>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220728103513.38e93fa9@gollum>
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



On 7/28/2022 2:06 AM, Juerg Haefliger wrote:
> On Wed, 27 Jul 2022 14:51:24 -0700
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 7/27/22 01:05, Juerg Haefliger wrote:
>>> On Wed, 10 Feb 2021 14:59:45 -0800
>>> Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>    
>>>> On 2/10/2021 8:55 AM, Nicolas Saenz Julienne wrote:
>>>>> Hi Robin,
>>>>>
>>>>> On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote:
>>>>>> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:
>>>>>>> [ Add Robin, Catalin and Florian in case they want to chime in ]
>>>>>>>
>>>>>>> Hi Juerg, thanks for the report!
>>>>>>>
>>>>>>> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
>>>>>>>> Trying to dump the BCM2711 registers kills the kernel:
>>>>>>>>
>>>>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
>>>>>>>> 0-efc
>>>>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
>>>>>>>>
>>>>>>>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError
>>>>>>>
>>>>>>> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
>>>>>>> SError,' hence IIUC the rest of the error code is meaningless to anyone outside
>>>>>>> of Broadcom/RPi.
>>>>>>
>>>>>> It's imp-def from the architecture's PoV, but the implementation in this
>>>>>> case is Cortex-A72, where 0x000002 means an attributable, containable
>>>>>> Slave Error:
>>>>>>
>>>>>> https://developer.arm.com/documentation/100095/0003/system-control/aarch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=en
>>>>>>
>>>>>> In other words, the thing at the other end of an interconnect
>>>>>> transaction said "no" :)
>>>>>>
>>>>>> (The fact that Cortex-A72 gets too far ahead of itself to take it as a
>>>>>> synchronous external abort is a mild annoyance, but hey...)
>>>>>
>>>>> Thanks for both your clarifications! Reading arm documentation is a skill on
>>>>> its own.
>>>>
>>>> Yes it is.
>>>>   
>>>>>      
>>>>>>> The regmap is created through the following syscon device:
>>>>>>>
>>>>>>> 	avs_monitor: avs-monitor@7d5d2000 {
>>>>>>> 		compatible = "brcm,bcm2711-avs-monitor",
>>>>>>> 			     "syscon", "simple-mfd";
>>>>>>> 		reg = <0x7d5d2000 0xf00>;
>>>>>>>
>>>>>>> 		thermal: thermal {
>>>>>>> 			compatible = "brcm,bcm2711-thermal";
>>>>>>> 			#thermal-sensor-cells = <0>;
>>>>>>> 		};
>>>>>>> 	};
>>>>>>>
>>>>>>> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range is
>>>>>>> full of addresses that trigger this same error. Also note that as per Florian's
>>>>>>> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what I can
>>>>>>> tell, at least 0x7d5d22b0 seems to be faulty too.
>>>>>>>
>>>>>>> Any ideas/comments? My guess is that those addresses are marked somehow as
>>>>>>> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimately,
>>>>>>> the solution is to narrow the register range exposed by avs-monitor to whatever
>>>>>>> bcm2711-thermal needs (which is ATM a single 32bit register).
>>>>>>
>>>>>> When a peripheral decodes a region of address space, nobody says it has
>>>>>> to accept accesses to *every* address in that space; registers may be
>>>>>> sparsely populated, and although some devices might be "nice" and make
>>>>>> unused areas behave as RAZ/WI, others may throw slave errors if you poke
>>>>>> at the wrong places. As you note, in a TrustZone-aware device some
>>>>>> registers may only exist in one or other of the Secure/Non-Secure
>>>>>> address spaces.
>>>>>>
>>>>>> Even when there is a defined register at a given address, it still
>>>>>> doesn't necessarily accept all possible types of access; it wouldn't be
>>>>>> particularly friendly, but a device *could* have, say, some registers
>>>>>> that support 32-bit accesses and others that only support 16-bit
>>>>>> accesses, and thus throw slave errors if you do the wrong thing in the
>>>>>> wrong place.
>>>>>>
>>>>>> It really all depends on the device itself.
>>>>>
>>>>> All in all, assuming there is no special device quirk to apply, the feeling I'm
>>>>> getting is to just let the error be. As you hint, firmware has no blame here,
>>>>> and debugfs is a 'best effort, zero guarantees' interface after all.
>>>>
>>>> We should probably fill a regmap_access_table to deny reading registers
>>>> for which there is no address decoding and possibly another one to deny
>>>> writing to the read-only registers.
>>>
>>>
>>> Below is a patch that adds a read access table but it seems wrong to include
>>> 'internal.h' and add the table in the thermal driver. Shouldn't this happen
>>> in a higher layer, somehow between syscon and the thermal node?
>>
>> What is the purpose of doing doing this though that cannot already be done using devmem/devmem2 if the point is explore the address space?
> 
> The goal is to prevent a kernel crash when doing
> $ cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers

Fair enough, but that really does not scale across drivers nor across 
power management decisions being made to various drivers.

The thermal sensor is unlikely to ever be clock gated by the time Linux 
runs, but if you were to do the same thing for any other type of 
peripheral, chances are the same outcome would be produced.

So this really begs the question as to how to address this globally 
short of disabling regmap debugfs support which is likely what is 
happening in a production environment anyway.
-- 
Florian
