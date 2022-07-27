Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461B5834F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiG0Vva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiG0Vv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:51:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F42C114;
        Wed, 27 Jul 2022 14:51:27 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f65so16915404pgc.12;
        Wed, 27 Jul 2022 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rkjBsi1c69LoC24Xf516mQgoWnGspVcUZ+1F/npRnIQ=;
        b=fCZY//9BKaFQINtpxaXPxabdQLaP42RUZ/DaqwRQ/8CLuoMsuhCTkeaatoqJPpF1Pd
         JEiI49iCaZOVBb0HDMBsBTr3cpml4QVSKTeN5UatqkJQo4yqCavuMLubNuddE1PEUSlF
         sLNlkXgpXMLmdQRxYRX3deeh0HrgynDuZz/CwLwn8e1nX4qJZtcarUh8J19r2cDflMs2
         D/XHYHv+inSvWlBKtO29Lu0Kjg4YdyoB+VA4skH/CHeWpUhchrsYa2HI8bGiNAhFEArl
         UQ5Y8eNNiUTG/J/atM1bVZs6ufuPB+2gopOCeJ3/k8cklf7r9X+VlUvt6aWOCJ57ocld
         pb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rkjBsi1c69LoC24Xf516mQgoWnGspVcUZ+1F/npRnIQ=;
        b=OOLqIc+OKhSFXwpugLuWY30L169bu4A7/2qs3Kv5ed1IyB03/7Lkt5nDx+8QJ79E3A
         N3Sjlaf7cj3HyXrebwceeWLcLxfZO8Gc9TdY8CcpApzYxYw+f+segEkroGHLdYyRyFzT
         md+adRVEylukZvkRJmVjWD7HoVKneGGLay6ESBUMuXQ8sD+2h+E2FtirQeJfUX/lvTjS
         6mP5gB/FO/JBFCuEwu2KHKzX70WiycM1Xr/Nby+1a8VV/3is5r64oitS7VpcKvigHUGe
         TRwoDM80FT1Z0KiGYn09t+4wTFeA5AyKF82SH2XiMcHltSsNit8jUqT0mwiL30irO/eW
         CguA==
X-Gm-Message-State: AJIora/I8Idvkgd8+1n7zeuNBmKfYEgzsXsyz6SPFlPEH1/r4bh71cmy
        uQcDD7quXheCwQBRcRqHe6s=
X-Google-Smtp-Source: AGRyM1vpnw2S+wW3eqWaqwqeetfX/Afny2l9bVPauXSZNSOKQSX6k652gDjiTshTLKuWADmdu1p9Qw==
X-Received: by 2002:a63:8841:0:b0:412:b40b:cfb5 with SMTP id l62-20020a638841000000b00412b40bcfb5mr21279602pgd.197.1658958686396;
        Wed, 27 Jul 2022 14:51:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n12-20020a63f80c000000b0040d0a57be02sm12697412pgh.31.2022.07.27.14.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 14:51:25 -0700 (PDT)
Message-ID: <f309790a-a41b-cb2d-811e-51dc08154c04@gmail.com>
Date:   Wed, 27 Jul 2022 14:51:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous SError
 Interrupt
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220727100510.4723ec84@smeagol>
Content-Type: text/plain; charset=UTF-8
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

On 7/27/22 01:05, Juerg Haefliger wrote:
> On Wed, 10 Feb 2021 14:59:45 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 2/10/2021 8:55 AM, Nicolas Saenz Julienne wrote:
>>> Hi Robin,
>>>
>>> On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote:  
>>>> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:  
>>>>> [ Add Robin, Catalin and Florian in case they want to chime in ]
>>>>>
>>>>> Hi Juerg, thanks for the report!
>>>>>
>>>>> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:  
>>>>>> Trying to dump the BCM2711 registers kills the kernel:
>>>>>>
>>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
>>>>>> 0-efc
>>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
>>>>>>
>>>>>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError  
>>>>>
>>>>> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
>>>>> SError,' hence IIUC the rest of the error code is meaningless to anyone outside
>>>>> of Broadcom/RPi.  
>>>>
>>>> It's imp-def from the architecture's PoV, but the implementation in this 
>>>> case is Cortex-A72, where 0x000002 means an attributable, containable 
>>>> Slave Error:
>>>>
>>>> https://developer.arm.com/documentation/100095/0003/system-control/aarch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=en
>>>>
>>>> In other words, the thing at the other end of an interconnect 
>>>> transaction said "no" :)
>>>>
>>>> (The fact that Cortex-A72 gets too far ahead of itself to take it as a 
>>>> synchronous external abort is a mild annoyance, but hey...)  
>>>
>>> Thanks for both your clarifications! Reading arm documentation is a skill on
>>> its own.  
>>
>> Yes it is.
>>
>>>   
>>>>> The regmap is created through the following syscon device:
>>>>>
>>>>> 	avs_monitor: avs-monitor@7d5d2000 {
>>>>> 		compatible = "brcm,bcm2711-avs-monitor",
>>>>> 			     "syscon", "simple-mfd";
>>>>> 		reg = <0x7d5d2000 0xf00>;
>>>>>
>>>>> 		thermal: thermal {
>>>>> 			compatible = "brcm,bcm2711-thermal";
>>>>> 			#thermal-sensor-cells = <0>;
>>>>> 		};
>>>>> 	};
>>>>>
>>>>> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range is
>>>>> full of addresses that trigger this same error. Also note that as per Florian's
>>>>> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what I can
>>>>> tell, at least 0x7d5d22b0 seems to be faulty too.
>>>>>
>>>>> Any ideas/comments? My guess is that those addresses are marked somehow as
>>>>> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimately,
>>>>> the solution is to narrow the register range exposed by avs-monitor to whatever
>>>>> bcm2711-thermal needs (which is ATM a single 32bit register).  
>>>>
>>>> When a peripheral decodes a region of address space, nobody says it has 
>>>> to accept accesses to *every* address in that space; registers may be 
>>>> sparsely populated, and although some devices might be "nice" and make 
>>>> unused areas behave as RAZ/WI, others may throw slave errors if you poke 
>>>> at the wrong places. As you note, in a TrustZone-aware device some 
>>>> registers may only exist in one or other of the Secure/Non-Secure 
>>>> address spaces.
>>>>
>>>> Even when there is a defined register at a given address, it still 
>>>> doesn't necessarily accept all possible types of access; it wouldn't be 
>>>> particularly friendly, but a device *could* have, say, some registers 
>>>> that support 32-bit accesses and others that only support 16-bit 
>>>> accesses, and thus throw slave errors if you do the wrong thing in the 
>>>> wrong place.
>>>>
>>>> It really all depends on the device itself.  
>>>
>>> All in all, assuming there is no special device quirk to apply, the feeling I'm
>>> getting is to just let the error be. As you hint, firmware has no blame here,
>>> and debugfs is a 'best effort, zero guarantees' interface after all.  
>>
>> We should probably fill a regmap_access_table to deny reading registers
>> for which there is no address decoding and possibly another one to deny
>> writing to the read-only registers.
> 
> 
> Below is a patch that adds a read access table but it seems wrong to include
> 'internal.h' and add the table in the thermal driver. Shouldn't this happen
> in a higher layer, somehow between syscon and the thermal node?

What is the purpose of doing doing this though that cannot already be done using devmem/devmem2 if the point is explore the address space?
-- 
Florian
