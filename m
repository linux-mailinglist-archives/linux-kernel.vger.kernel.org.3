Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05954FB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383357AbiFQQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383354AbiFQQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:41:14 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD649B71
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:41:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id p31so7200779qvp.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ICFZ/PbGc0+5fagTJPsSgzABld3cNYKFZAZogQ8d6KE=;
        b=ICtoZJmNHccJ5Kb9uPkCDvMV7vNVJ0X4gmJBwqYRlBRYsHGBVYe0hs0sTepZTC98Az
         d4UB0NsMX2sZzgaxUtxmN1VQrV0Ls3/5yPpBTWZsoXPEh1qLvL1aw1qQkpi5OxnbxMH1
         fLUEo66SPBQJXQIJm+gwjoN7J/YEgQGH+91/AKJNE80p9nodSf7zzw6pBQA+dTtjBRdH
         bCgWbAp9FkVsyC7S/ccEi+XLC0WDvJJS64uEaFssDGB9jOr6hUTIZFzWsD0Ibdq3LNJW
         op+V/JrdOpJoJioFKR2zK6YUFzF3SQf6kz7YNn/UZ4fReQfQtv/+L0mXYMEfLMkp7t17
         GkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ICFZ/PbGc0+5fagTJPsSgzABld3cNYKFZAZogQ8d6KE=;
        b=3I2mUWtGC7YbNOc/cQxWZmpMw2l2u0rh0Y6VC1+waj6wzP1epX5wAH9AMJCKKho8+B
         Kl4HcaG4YbRObrIs7Rwl1c7JdogU02UGHe3t2TpG4uo/wPpUUIwD4Cbn4n7Brw9kcTZu
         pZ1LSuoxfNS40lak77FcnXRgtbIbG4prmxOM17OeybEUaXK3SvsxDHEV1u5gyyl7YCY7
         fqeeyrZXjIHtILPrRj32xQAEClhKAEn5zZiNiuNrdn6B+Rk5c99JvSMfcACv5NmKYYl/
         upRrfShVYbPJ7cjcL3IPLM3BkhQcvBTm8TxslQePGz3wLYA/mKfg8AmNT56oEidunFRG
         RaqQ==
X-Gm-Message-State: AJIora9/Fq29txEOQysHtD0qh4hOSx/ZcCBK4rWaxHrahvg8aluvJV7l
        MBy65lqkGIruQkhE5gH9okej2cf7E6htgKcclw==
X-Google-Smtp-Source: AGRyM1uMa/VGc21wZOnWL0laNFhFMnGtz9S3xBOSazDWvMdn/L3NSLXjMKp6dZwcAHk972n0yWyiXg==
X-Received: by 2002:a05:6214:2a8e:b0:464:5b2f:76bf with SMTP id jr14-20020a0562142a8e00b004645b2f76bfmr9152409qvb.60.1655484072736;
        Fri, 17 Jun 2022 09:41:12 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a0bc300b006a67d257499sm5368395qki.56.2022.06.17.09.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:41:11 -0700 (PDT)
Message-ID: <1856d213-6119-74f1-f768-6ff05ba8f03b@gmail.com>
Date:   Fri, 17 Jun 2022 12:41:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFCv4 3/4] lib/test_printf.c: split write-beyond-buffer
 check in two
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, Jia He <justin.he@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-4-justin.he@arm.com> <YMtZcVy4gvmMtYv+@alley>
 <d0798b26-9c77-7209-8c16-0d067ea5720c@rasmusvillemoes.dk>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <d0798b26-9c77-7209-8c16-0d067ea5720c@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 03:15, Rasmus Villemoes wrote:
> On 17/06/2021 16.17, Petr Mladek wrote:
>> On Tue 2021-06-15 23:49:51, Jia He wrote:
>>> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>
>>> Before each invocation of vsnprintf(), do_test() memsets the entire
>>> allocated buffer to a sentinel value. That buffer includes leading and
>>> trailing padding which is never included in the buffer area handed to
>>> vsnprintf (spaces merely for clarity):
>>>
>>>    pad  test_buffer      pad
>>>    **** **************** ****
>>>
>>> Then vsnprintf() is invoked with a bufsize argument <=
>>> BUF_SIZE. Suppose bufsize=10, then we'd have e.g.
>>>
>>>   |pad |   test_buffer    |pad |
>>>    **** pizza0 **** ****** ****
>>>   A    B      C    D           E
>>>
>>> where vsnprintf() was given the area from B to D.
>>>
>>> It is obviously a bug for vsnprintf to touch anything between A and B
>>> or between D and E. The former is checked for as one would expect. But
>>> for the latter, we are actually a little stricter in that we check the
>>> area between C and E.
>>>
>>> Split that check in two, providing a clearer error message in case it
>>> was a genuine buffer overrun and not merely a write within the
>>> provided buffer, but after the end of the generated string.
>>>
>>> So far, no part of the vsnprintf() implementation has had any use for
>>> using the whole buffer as scratch space, but it's not unreasonable to
>>> allow that, as long as the result is properly nul-terminated and the
>>> return value is the right one. However, it is somewhat unusual, and
>>> most %<something> won't need this, so keep the [C,D] check, but make
>>> it easy for a later patch to make that part opt-out for certain tests.
>>
>> Excellent commit message.
>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> Tested-by: Jia He <justin.he@arm.com>
>>> Signed-off-by: Jia He <justin.he@arm.com>
>>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Hi Petr
> 
> It seems Justin's series got stalled, but I still think this patch makes
> sense on its own (especially since another series in flight mucks about
> in this area), so can you please pick it up directly?
> 
> The lore link for the above is
> https://lore.kernel.org/lkml/20210615154952.2744-4-justin.he@arm.com/ ,
> while my original submission is at
> https://lore.kernel.org/lkml/20210615085044.1923788-1-linux@rasmusvillemoes.dk/

That patch definitely clarifies things, feel free to add my reviewed-by tag

