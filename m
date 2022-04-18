Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F8504CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiDRGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiDRGqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:46:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760019021;
        Sun, 17 Apr 2022 23:44:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j71so3721693pge.11;
        Sun, 17 Apr 2022 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=afjJNp66CnOhPMa973ezhZwuSP+3vtgA4sRXX7R/zkk=;
        b=bUgO0sfnCFDRDUfZk/tX6mX/33+7xHHGXcXr6ABF3sBqwmwhyaGKo+7dBJUOJVS1hq
         irJtPpS2OtBE2o3VhNy178IiUgBc4O+2iKZ81hFu1ErTZLuhcPPTBMzqzQrYFTG+xyTO
         CvygdN9MQw5pGYi1eY90JfjHQWQXa8daWqs59fEyWFDV5mR4L+aqSK0C1MndN4JlJpMx
         uT/v216kkQHY77k598ZaWK2eTW5oG3pe8ay+beb30uMzvJ8wEwKZ/GUfAcrLS3jtNSKr
         hOI5JweYEXr+79C+6F+k7+TXi8zU5HqIuchpC75uz5Pf86huP687YB2UAo1jC4WZevkU
         36VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=afjJNp66CnOhPMa973ezhZwuSP+3vtgA4sRXX7R/zkk=;
        b=lZ3AMyzrzs9MapAHcOPweNvzxAmIQl4runHzl7hArm3hl83oCjuHgnVHIf//dXobgQ
         NQoWh9jo6OELea75qqGCfCH3imhdpuWrMKvS5d3C/P/9t2W1IR0kAUvJ9+coBkwEHRmW
         AANkfNcYn3yoyHduoCQijtcB2WK80iK1bRAs08SPqLmqdtAtMIhcLNLwfE2McWsriR2y
         PccksuE4SmMwPBUlVASWhm6VsSl8aAP8FfZ2GzaqJLFzb3g0Esi7o1EnMOYX3/ZbxnpT
         JknWCmsVyJ2t2VPTv87qSmYPgx80ZyQZsLD9D0gBDFco/opKFNdP26RO6OTstzXKlZrO
         usAw==
X-Gm-Message-State: AOAM530EHtqgqpkDyvyOjGV8Hsv25LJ1esmkQJcVpwIMwlvXreAYGBce
        WcgGYqItgyKMpdMRfYoCtoVWLbYZNX8=
X-Google-Smtp-Source: ABdhPJxHPMNPmQC9p96JTP64fIi9uINectvMKZx8d2t/mgSu5ClcTKHfsSOevb0RUDxmK3ZZno1Wqg==
X-Received: by 2002:a65:4b84:0:b0:382:65ea:bb10 with SMTP id t4-20020a654b84000000b0038265eabb10mr8902804pgq.50.1650264250023;
        Sun, 17 Apr 2022 23:44:10 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm11814867pfm.17.2022.04.17.23.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 23:44:09 -0700 (PDT)
Message-ID: <40b763ab-d35d-03de-9d27-bca2af56dd34@gmail.com>
Date:   Mon, 18 Apr 2022 15:44:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/trans/ja_JP/howto: Don't mention specific kernel
 versions
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220417070451.19736-1-fujimotokosuke0@gmail.com>
Content-Language: en-US
In-Reply-To: <20220417070451.19736-1-fujimotokosuke0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fujimoto-san,

This looks mostly good to me.
Please find inline comments below on a couple of conventions expected in
this community.

On Sun, 17 Apr 2022 16:04:51 +0900,
Kosuke Fujimoto wrote:
> [PATCH] docs/trans/ja_JP/howto: Don't mention specific kernel versions

It looks like patches to Chinese docs carry a simpler "docs/zh_CN:" prefix [1].
So "docs/ja_JP/howto:" should suffice.

[1]: example: https://lore.kernel.org/r/2fc8a76e1308e15823eebf614f35f36f322a55d3.1649384633.git.siyanteng@loongson.cn/

> This change is based on commit d2b008f134b7 (Documentation/process/howto: Update for 4.x -> 5.x versioning)

In changelog explanation, lines should not exceed 75 chars unless you
have a good reason.
The rule is stricter than the contents of documents because some of git
commands auto indent changelogs by 4 spaces, and the result should fit
in an 80-column wide terminal.
Also, the title of the referenced commit should be enclosed in a pair
of double quotation marks.  So this should be:

   This change is based on commit d2b008f134b7
   ("Documentation/process/howto: Update for 4.x -> 5.x versioning").

[with a punctuation fix]

> Replace "4.x kernel version" with generic term such as "mainline tree"
> 
> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: linux-doc@vger.kernel.org
Please note that the above mentioned width limit does not apply to
tags.  E.g., Fixes: and Link: tags should not wrap.

These conventions are covered in the latter part of Section "Describe
your changes" and Section "The canonical patch format" of
Documentation/process/submitting-patches.rst.

So I'd suggest that you post a v2 with the subject and changelog
fixed.
But please wait a few days for comments from someone else.

With the above addressed, feel free to add:

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> ---
>  Documentation/translations/ja_JP/howto.rst | 43 ++++++++++------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
[...]

