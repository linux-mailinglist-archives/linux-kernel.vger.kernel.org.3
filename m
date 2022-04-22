Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D313950BE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiDVRak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiDVRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:30:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF9DEBB7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:27:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r83so7856174pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bAHjx2LvQweg3IXQ+XUZ0847Fs7Oh/UmTS1DX0FwCP8=;
        b=G6gNb7IE4Xovf0intE+OpbnpdmDJNrGDa5FZ0qU1/i9dlVv2S0SxzzGRedm7H7Bo9c
         S5qPQ8wwE9+LoCPcGa46ZQ9MQrBWxbwKvTvz1KnauIw0DBnwWnlxB4dcAh5ykAIdfawx
         wUa6E84YEaOO9gEylWkp3WxDKatXE8AHWJeTjY0SUCsZzLe9KiYfBtHi2BtjeGomCTLb
         OFUZgjxKLBK/5fBGLHWCP3UUaP8K6AJuR27sFiTGefA67XdMDNf4xjod9uaWPHSobb8Q
         4rLW640nqXcbwrdJcyZGn7VxIE2FCYPn9DnJe1mQ2XFJnPLaJfLfzcWzmFe7bc3UqW9K
         p6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bAHjx2LvQweg3IXQ+XUZ0847Fs7Oh/UmTS1DX0FwCP8=;
        b=Ll+B3FOU9/Bim+/ntIW2GiI1xTYohKLYx4kF/Rp5o5ds+K+fef/gdzfV2aimCPAdwy
         R3AIJMFCWNw8R9CmCQFReNO/o4Kr8eiGlwuYCFECN3saYTsHysflf7cg1Fs+GlPhaZrC
         RQ4AdYaxj44Aa4yBuznAU5ttE3CpMo90o58u/GPI4bK2mhfTUcZhBbZUDhPTM+FC8egB
         3zmvfJct+viRIlpQHGu4mqGjI/fQyvI2t8QBs2AaA/moSX61F5ow5fXAoaR553eAYC6C
         locGFyo8QJT+Q2+GiyStHo/pjKF5UoNiIqV6Clix7rMHn7HgCcQkytNsJ/ujoRGhv5Fc
         7Nww==
X-Gm-Message-State: AOAM532PBUX/B6WIXcOVALzELsrXlCLsFOq4aWLgH7gnVxFGCKHF+XEy
        2f1dqZV1Qj1OrRB4CY5i4s4=
X-Google-Smtp-Source: ABdhPJw2LCGoc103LUCVqi3pR1A+6h16x21/qvm7I0rbHHgSlcLAZqZiYbjX96zWNoV3omUs5WJJow==
X-Received: by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id h1-20020a056a00218100b004f6f1b11ba7mr6012389pfi.73.1650648278972;
        Fri, 22 Apr 2022 10:24:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t18-20020aa79472000000b0050ad180a4bbsm3227872pfq.1.2022.04.22.10.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:24:38 -0700 (PDT)
Message-ID: <b8a5bb60-15d4-0b3b-9d96-758e5136fb46@gmail.com>
Date:   Fri, 22 Apr 2022 10:24:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
 <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
 <b95d9b1058eed13489adba0bccdeb600950eb153.camel@perches.com>
 <dd97ffe3-3983-fc45-469b-703900077f2f@broadcom.com>
 <feff60ee8a6d10da7d10b421d18407a5d040680e.camel@perches.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <feff60ee8a6d10da7d10b421d18407a5d040680e.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 14:31, Joe Perches wrote:
> On Wed, 2022-04-20 at 11:50 -0700, William Zhang wrote:
>>
>> On 4/19/22 16:11, Joe Perches wrote:
>>> On Tue, 2022-04-19 at 12:00 -0700, Florian Fainelli wrote:
>>>> On 4/12/2022 11:34 AM, Joe Perches wrote:
>>>>> Convert the broadcom internal list M: and L: entries to R: as
>>>>> exploder email addresses are neither maintainers nor mailing lists.
>>>>>
>>>>> Reorder the entries as necessary.
>>> []
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> []
>>>>> @@ -3746,7 +3746,7 @@ F:	include/linux/platform_data/b53.h
>>>>>     
>>>>>     BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
>>>>>     M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
>>>>> -L:	bcm-kernel-feedback-list@broadcom.com
>>>>> +R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
>>>
>>>> There is not a "Broadcom Kernel Team", the description of R: appears to
>>>> require some kind of full name, hence the choice of L: instead of R:.
>>>
>>> If you don't like "Broadcom Kernel Team", perhaps
>>> "Broadcom Kernel Reviewers" might work for you.
>>>
>>> I think it doesn't matter much.
>>>
>> I can see that we shouldn't use M as maintainer for this Broadcom
>> mailing list email. But I honestly don't understand why we have to use
>> R. Just for the sake of full name?  Not everyone in this distribution
>> list is reviewer.  IMHO I would prefer to change all entries to L
>> without a full name.
> 
> I think "R:" is a better choice than "L:"
> 
> "L:" Mailing list entries have archives that are publicly searchable.
> 
> Are the broadcom bcm-kernel-feedback-list entries publicly archived?

They are not indeed.

> 
> If not, these are one-way entries, so someone sends and hopes only.
> Replies that are sent from these entries are not visible to the public.

OK, fair enough, I will change to:

R: Broadcom internal kernel review list 
<bcm-kernel-feedback-list@broadcom.com>

If that works for everyone?
-- 
Florian
