Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE574C20CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBXAsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBXAsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:48:39 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077C107AAF;
        Wed, 23 Feb 2022 16:48:00 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso1167289oon.5;
        Wed, 23 Feb 2022 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oLxhe1+/q/ffytS2x1bnbij1SrGOn3CdIxFKv6xoCNQ=;
        b=T1Pc4B23cN3s1FGEyr9jrL0b8gag+JUNzErCsCXYOhNTaC9lMQqhiVTDrXqC4kcDz5
         4GBMrIYL7Oez63vIGGSOU70kgfUEkiQknd2HqL2t+N5Ohdln0utp/KlJrvhl3Fa6GBN0
         bXyabAAVmmb/lusrMmTE/7s5MPg2a0nVzjeQ8lFHlDtm/rMXUSXXdHYL9PJWGDwEFc8Q
         gMeg9uCvhL9izTnstMr83iWz8QKqjZuYYdZ0Vj/t9PB/vqMMjO2t+9w9mL5DHIM+lXpi
         7RlG8RwYAdWVYIa7GH8QBsQuVeq6TKZYoWcEFiEucaDJB7l8XuAN21bWA0fpIxEUIqDD
         kCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oLxhe1+/q/ffytS2x1bnbij1SrGOn3CdIxFKv6xoCNQ=;
        b=Y/WT2rb2o1wmAN++/ly2RnqTZnbDK1aIOaXY3JQxzU3UN3F4nVosVCwo1I34zXICMu
         0Qs3ziwsoMjDzAMXLq5+oQSh+7UgP6pybJ4rIb6NzyCbyw5HQfJe6vfOF7mlnOxEJL+j
         Vx2V9EoWdq/AUPklixYNzrkMbe5kdzNQV6pwamrrSo4A/tfVdE3CATuQ6z10tntprBvs
         gZp3tHqNEpXs7y3ReHuPYCQmXezwc2medut4Eo7UaA9JROwZ2R0jw7l4YJda3YrKMGmc
         jCx4MmbdcwcblhfeShXWBXWC70llzXqORBBtpMoHz1uV1OAhkussAcQB9D4VJenJ9Iwl
         UzLQ==
X-Gm-Message-State: AOAM530swnl5ETu4WebBiC83VgWgkxXM5u6SdR0qMRnI3i2jjMPKblll
        vrIjQYjwsG29DsikUGzOl88=
X-Google-Smtp-Source: ABdhPJy6H3eQot88I8lZuYMy6ofwOtngNCOg+LNyNN4ORGIy4QzWOecyi1QiCR5UB7B0KiqEg7u+Wg==
X-Received: by 2002:a05:6870:aa8a:b0:d6:c3ca:7e9c with SMTP id gr10-20020a056870aa8a00b000d6c3ca7e9cmr52765oab.118.1645663530391;
        Wed, 23 Feb 2022 16:45:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p13sm578119oiv.23.2022.02.23.16.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 16:45:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e0c0eac9-a66a-fc35-0864-2ca1ba7cb32f@roeck-us.net>
Date:   Wed, 23 Feb 2022 16:45:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Armin Wolf' <W_Armin@gmx.de>,
        =?UTF-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220220190851.17965-1-W_Armin@gmx.de>
 <20220222165432.GA255373@roeck-us.net> <20220222175150.qs32v4outislnqj6@pali>
 <b3cecea1376f4080929f47da2529685c@AcuMS.aculab.com>
 <4b5ca065-06a4-c1ff-ed16-3bbb038ee6e0@gmx.de>
 <63a04993864f4c08923ed753d83cdf37@AcuMS.aculab.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <63a04993864f4c08923ed753d83cdf37@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 14:35, David Laight wrote:
> From: Armin Wolf
>> Sent: 23 February 2022 21:39
> ...
>>> As far as this patch goes I think I'd add a 'stc' (set carry)
>>> instruction before the first 'outb'.
>>> Then if the 'something magic happens here' doesn't happen (because
>>> you aren't on the right kind of motherboard) the action fails.
>>>
>>> 	David
>>
>> We already check for such scenarios by checking if eax changed.
>> I would not set the carry flag before doing a SMM call since im
>> not sure if the firmware code always clears the carry flag when
>> the call was successful.
>> If for example the firmware code only sets the carry flag on
>> error and otherwise ignores the carry flag, we might create some
>> false negatives when a successful SMM call leaves the carry flag set.
> 
> If you are worried about that you should be clearing carry on entry.
> 

I agree, but now we have an argument for clearing carry (because the
SMM code might not do it) and for setting carry (because the SMM code
might not execute). I don't know which way to go, if any, but that
would be a functional change and should be submitted as separate patch.

Guenter
