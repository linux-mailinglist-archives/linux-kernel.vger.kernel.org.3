Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9F584D29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiG2IKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiG2IKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:10:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3456113E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:10:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l4so5039160wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sm9qXIp8zk3KteEmbM0OHiY+JEPNUrWfWi6v+8LAnMA=;
        b=QkGSON/Sf+wdffx9Kxw/bOPGCtJsGDpgSki/75kLj1ioaCa8m61urDI60V3Yw5OlQC
         h24yjTrumk4ILaTSvK67T5yw/XiFuou+sw7fSrlzyIR94xVgkxiRG+loPzRLJfozPEU2
         hjiPltPvjc/0dknTv942KlfyWsH7Dr/AQbAPT5wrmxxbdjpwHEUx49fxfliySySChdVn
         4CSMH0L/nMQQt0nciE5HrTF5iu5Iuej4TcBHxNrLI+6+mi87XFaRdzjf2VMPSuICes2b
         2pVen9Gck/clZfW8vBHrTDDMfH4VsGNlwZLBWUiZ2kTzJL9Dcuf11MDrLwy6gWKpZnmQ
         oQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sm9qXIp8zk3KteEmbM0OHiY+JEPNUrWfWi6v+8LAnMA=;
        b=ghl4z0Ebg1xKXbw4gfTqMfBZVh/RP72I7KRrOTdyGD8XYsY4Xc7aax7+t/gh9OwX76
         0VAcj3lDQ5bDwVsL4lbNdnPCISdyCE2AFPRtXOkiiBbMS1YpCT1doQAh19YmXLDDeKmS
         7aznuBXZVZ+/BZCUcqaub82+S0v+nct8gTmcHuSbmdq2MB4GAH+o0g/pw4kGFnM5QuS8
         aBNjy6iXM2BRBvn31va44kQxfaUs0KIblqRCImzg30mpuOfF+m0EBsDbBtiX7Lf3vgIR
         1IrhLY3COV8GxaOHF6KpBjLshNMviu7eFf9hno+C28W/6HUeR/Ifh4QnBuBTzK7Vmhga
         G+yg==
X-Gm-Message-State: ACgBeo1zZpAnnkW6cbG+EZLXThb/GIBzIQvn0VXysSORcHGKC9tyyzsF
        Xv+GcYuGqZPS02q9YuixySUAft7acvJhER5/
X-Google-Smtp-Source: AA6agR6niZOH+y7eRa2ahPkFQ1bxuAO4+m0GEItqjk2SC/XH6z9EcZdt61VgvRGQgTk9SYmvW7+Guw==
X-Received: by 2002:a5d:6484:0:b0:21e:8ab7:fbc9 with SMTP id o4-20020a5d6484000000b0021e8ab7fbc9mr1607199wri.316.1659082210224;
        Fri, 29 Jul 2022 01:10:10 -0700 (PDT)
Received: from [10.35.5.25] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b003a31ca9dfb6sm4213883wmp.32.2022.07.29.01.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 01:10:09 -0700 (PDT)
Message-ID: <bee82951-47c9-20bc-3cb2-3a52f67a4728@sifive.com>
Date:   Fri, 29 Jul 2022 09:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Content-Language: en-GB
To:     Tudor.Ambarus@microchip.com, sudip.mukherjee@sifive.com
Cc:     p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com>
 <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
 <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
 <CAHyZL-c9iSd8=CaQ00Nptea4cqp9f7oqS5VefT3vfcr2J3hmSQ@mail.gmail.com>
 <d5662307-200e-171d-58fd-8f26dc02c771@microchip.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <d5662307-200e-171d-58fd-8f26dc02c771@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 08:48, Tudor.Ambarus@microchip.com wrote:
> On 7/22/22 13:24, Sudip Mukherjee wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi Tudor,
>>
> 
> Hi!
> 
>> On Mon, Jul 18, 2022 at 7:49 PM Sudip Mukherjee
>> <sudip.mukherjee@sifive.com> wrote:
>>>
>>> On Mon, Jul 18, 2022 at 6:02 PM <Tudor.Ambarus@microchip.com> wrote:
>>>>
>>>> On 7/12/22 19:38, Sudip Mukherjee wrote:
>>>>> [You don't often get email from sudip.mukherjee@sifive.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>
>>>>> Some flash chips which does not have a SFDP table can support Quad
>>>>> Input Page Program. Enable it in hwcaps if defined.
>>>>>
>>>
>>> <snip>
>>>
>>>>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>>>>> index 58fbedc94080f..dde636bdb1a7c 100644
>>>>> --- a/drivers/mtd/spi-nor/core.h
>>>>> +++ b/drivers/mtd/spi-nor/core.h
>>>>> @@ -462,6 +462,7 @@ struct spi_nor_fixups {
>>>>>    *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
>>>>>    *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
>>>>>    *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
>>>>> + *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
>>>>
>>>> You don't need this flag if your flash supports the 4-byte Address
>>>> Instruction Table. Does you flash support it? Can you dump all the
>>>> SFDP tables, please?
>>>
>>> Not sure what the correct way to dump sfdp is. I did this from sysfs.
>>
>> I tried decoding this SFDP table and I think the parameters table says
>> it has "3-Byte only addressing".
>> So, I guess that means it does not support 4-byte Address Instruction
>> Table. And the datasheet
>> says it supports "Quad Input Page Program (3-byte Address)".
>> My existing patchset works for Quad Input Page Program, and I can send
>> a v2 with the previous
>> patch and this merged together (as you suggested) or I can try
>> enabling sfdp for this chip and then use
> 
> You should definitely enable SFDP and get rid of the NO_SFDP_FLAGS flags,
> regardless of the 1-1-4 PP outcome.
> 
>> a fixup_flags to enable "Quad Input Page Program" which I think will
>> be more complicated.
>> Which one will you suggest?
>>
> 
> First I'd like to understand what "much better performance" means. Would
> you run some speed tests please? mtd-utils should have a speedtest, otherwise
> you can use the in kernel mtd_speedtest module. Page programs are slow anyway,
> using 4 lines may not make any difference. But let's see.
> 
> About your question, it depends on how common is 1-1-4 pp. If it's common and
> desirable we can introduce a flash info flag.

We have an issue with the SPI controller where if it isn't in the above 
1 bit modes it has to block the CPU as the feature to hold the clock is
not enabled in the 1bit "old" modes. In the old modes, if the FIFO gets
to the empty stage then the CS gets de-selected. If we can enable the
4bit mode, we can also set the clock-suspend flag which means the code
does not have to block the core it is running on to ensure it gets the
data out in time.

At the moment speed tests are not easy as we are on entirely emulated
hardware, we could try some but the results may not represent what the
real chip can perform.

-- 
Ben
