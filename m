Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707A58DB5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiHIPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiHIPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:52:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E721758A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:52:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq11so17601687lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7luNtuPXP34XcP/NCS8jrOTG+DNTpVMVakj9FLoruiQ=;
        b=fZWqyo0qDtvMLTwKxsTHCN9jYJPz9hlujy4EwQXMgREL112hq3UvmNw0c717YRVyum
         IQnaeryQNLbVjbAApBuw0A2i77KndMaeNoYZe2xF0yzS54cyfbvGA5G/mHyvcWq3g/wd
         XfD0VhO7jmAsh0xWa2STilRdONSCDgwFW3/6OM13xnY/yqxdEc6j5nVgQD1n+OhsP/1B
         qHv1qBcegq3KL3/4ky1u7eQ55DexdvOD+TJbqo7uXBMsezG34KkjZSKA77vziXbd48iN
         XNmu2lHzveNaHdmUHRkE+nhjqwDvyzXpmaqCYXULBalWCrEBD8mWSQ77EuIZOd+T651s
         25EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7luNtuPXP34XcP/NCS8jrOTG+DNTpVMVakj9FLoruiQ=;
        b=sek179FUUL91U8YDDItl1mShbAC9JEChkZvdivQ1fvUxkOLawPk28yIdboszxbEPow
         8/ONXZRCUHsmxXQrG1rovG1AQadAkKc+FNT+dntVVSNsh3K9Yqf41VjVVqOeD8UGuH13
         0bOHf7UzCMINbdVkdgIJDK3t4k7wB0fKRo63DrqgcTVkgtpIzDgdKIkFdSc7qc4ebQBQ
         sNUMMfCKxa83J9oPEfONAlICCnkwMBP+/ATaKC1pxAznRwuimaC+l1x4jaGKiiJqTrD4
         xn1d3+gUQaod2BPjfhZT5rQP8qmUjI/akoiw+5xdkLVsbLv/z2r8e/RMnul04sZXgsg+
         bkcQ==
X-Gm-Message-State: ACgBeo1FckHKBPJWd64CgQup9KkKPaXYnKDWec66zbc6b+N6kkQxmPsH
        GBflBoBlixg2OrRKpfOIilRhYA==
X-Google-Smtp-Source: AA6agR7r+SUF5C/1PAK7LvhFkrThl9JElxkvc5b36lhq9wWn37Z8fjNGg483pize6dt2qzvBXREfxw==
X-Received: by 2002:a05:6512:3483:b0:48b:403:ee89 with SMTP id v3-20020a056512348300b0048b0403ee89mr7822911lfr.468.1660060321951;
        Tue, 09 Aug 2022 08:52:01 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c16-20020a05651c015000b0025e6e1c836dsm6706ljd.126.2022.08.09.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:52:00 -0700 (PDT)
Message-ID: <21b84f49-67af-6217-a662-f890db5525a8@linaro.org>
Date:   Tue, 9 Aug 2022 18:51:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Lee Jones <lee@kernel.org>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-14-paul@crapouillou.net>
 <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
 <YvJ+YPAynhFKj5DR@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvJ+YPAynhFKj5DR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 18:33, Lee Jones wrote:
> On Mon, 08 Aug 2022, Krzysztof Kozlowski wrote:
> 
>> On 07/08/2022 17:52, Paul Cercueil wrote:
>>> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
>>> to handle the .suspend/.resume callbacks.
>>>
>>> These macros allow the suspend and resume functions to be automatically
>>> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
>>> to use #ifdef guards.
>>>
>>> The advantage is then that these functions are now always compiled
>>> independently of any Kconfig option, and thanks to that bugs and
>>> regressions are easier to catch.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>
>> The address does not work. Please don't add it to commit log.
>>
>>> Cc: linux-samsung-soc@vger.kernel.org
>>
>> This is also not really needed in commit log... it's just a mailing list...
>>
>> I actually never understood why people want to add to commit log, so to
>> something which will last 10 years, Cc-ing other folks, instead of
>> adding such tags after '---'. Imagine 10 years from now:
>>
>> 1. What's the point to be cced on this patch after 10 years instead of
>> using maintainers file (the one in 10 years)? Why Cc-ing me in 10 years?
>> If I am a maintainer of this driver in that time, I will be C-ced based
>> on maintainers file. If I am not a maintainer in 10 years, why the heck
>> cc-ing me based on some 10-year old commit? Just because I was a
>> maintainer once, like 10 years ago?
> 
> Why would that happen?
> 
> These tags are only used during initial submission.

No, the tags are used in any other resends, backports etc while
traveling through different trees. I think only stable-backports do not
use them, but all other gfp+git-send will follow the tags.

> 
>> 2. Or why cc-ing such people when backporting to stable?
> 
> That doesn't happen either.

Indeed, stable does not use these Cc.

> 
>> It's quite a lot of unnecessary emails which many of us won't actually
>> handle later...
>>
>> I sincerely admit I was once also adding such Cc-tags. But that time my
>> employer was counting lines-of-patch (including commit log)... crazy, right?
> 
> Nothing wrong with adding these tags IMHO.  It's what they're for.
> 
> I use them when I'm maintaining a large amount of out-of-tree, but
> to-be-upstreamed patches over several versions.  Re-applying the
> recipients list can become pretty labour-some after several
> iterations.

You can do it still while keeping the tags after ---. Only patch-related
workflows strip such tags. If you cherry-pick, rebase, merge, you always
get the content of ---.

The same as typical changelog (not cover letter but one in the patch) -
you keep it after --- and it does not disappear.

> 
> Adding them under the '---' doesn't work when the purpose of them is
> to keep the recipients list in Git history.

This I understand, what I did not understand (and you did not explain)
is what would be the purpose to keep them in Git history. What is the
point to have them in commit log of 10 year old commit?

Best regards,
Krzysztof
