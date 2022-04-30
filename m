Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC90515977
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381954AbiD3BAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiD3BAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:00:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3819AE55;
        Fri, 29 Apr 2022 17:57:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so400409pjb.1;
        Fri, 29 Apr 2022 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mNyLvH43MfPDniIsq9lMkWz/KLzGO/YPNGTp4lBSC4c=;
        b=Ikn2m/zUdMTBUneTvHpZGEvTEvEkBSKkAf7tfUvGabeK/E23MOq6UhUFbeQ3k9G2U7
         UoA3O3+BGw2v7X/jbMz3hjxTrHYm7YBNQeels+KnyC35p0Qs1rjyVX7xSJrgfUAfgdJi
         RW6tKIsKNbIVLx6j7+5qvyyr3zm99GWWoIiUIpeTclTXMxl/WxCVRCD72QCv1v1w9/IO
         zNV2+tyQWMmPlVkRV0CgpfkmO3+umUR+DmkRyZwdXJC/cRF18wQ6OZl8GNJ7gz6LoqMr
         abiSSbxYqVfIxshW6SMxw/iaZHq6j7zLP5JOhsAs+O2W5ySd18cCy6Q60dhzw1OcpLZ/
         dC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mNyLvH43MfPDniIsq9lMkWz/KLzGO/YPNGTp4lBSC4c=;
        b=ehQjd8pFdGh0JavSOMEECI9TJRY8H32yvgdBqJkjjGAycrelFcR1l/4610v7W5K+zy
         9G+mNwBKm1yMsjed9sRZF3C5ftohm8U3rke/QSWk9sDntnnt86AuJ6KJ4CDgmKBs1xfl
         qevjkJKPgf216EUq//hYpdEeA/GAmJ5VwjNvJnKwAc9c7SuYx9Tz6fCS4YYD3eWKyF1T
         Py4gIRHLGcrk+f2UnpFcJQEWiy9pv2u07gTAdd+MiAWFdUpCqM+O4UVloBVHySkub1p9
         gIGzXpZap7ywbW5svaTc28W7ejYyg0n9ylsURyLomRhQAeHJ8h6W94YCarZCXADBXZ6V
         he0g==
X-Gm-Message-State: AOAM530l1yJjtr4a+Om6jGfBX3K3RbtlwYZeEn5+iAQCMhVZUuOn6fY4
        enF1HEhOKIkv8R8GfbHFBLg=
X-Google-Smtp-Source: ABdhPJwE/7f5AnlFfXfh4dUCYmbF+dvvij3jKffdGgValII8eU6AVuSoxIGBoluNUioKER8t6HMOFg==
X-Received: by 2002:a17:90a:9418:b0:1d8:91d1:4d74 with SMTP id r24-20020a17090a941800b001d891d14d74mr6779237pjo.62.1651280243475;
        Fri, 29 Apr 2022 17:57:23 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903301200b0015e8d4eb2ddsm204019pla.295.2022.04.29.17.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 17:57:22 -0700 (PDT)
Message-ID: <83176583-f392-ed9c-a4a2-9d8f67c0fd19@gmail.com>
Date:   Sat, 30 Apr 2022 09:57:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and
 Describe details using table
Content-Language: en-US
To:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, baihaowen@meizu.com, seakeel@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        caoyixuan2019@email.szu.edu.cn, yejiajian2018@email.szu.edu.cn,
        yuhongf@szu.edu.cn
References: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 30 Apr 2022 02:19:26 +0800,
Shenghong Han wrote:
> Subject: [PATCH] Documentation/vm/page_owner.rst: ...
This is v2 of the patch, isn't it?  If so, it should be indicated
in the prefix as "[PATCH v2]".

> Some syntax errors exist in "page_owner.rst". Thanks to Akira Yokosawa and
> Haowen Bai for tips to help improve the documentation.> 
> We try to fix them. Hope that the Documentation is showed as we expect.
In changelog, describe technical facts.  Not what you think or hope.
You need to do a respin with a better explanation at least.

Hint: A fix without using tables would be the simplest.  Please look
at the changes in the preceding section I made in commit 5603f9bdea68
("docs: vm/page_owner: use literal blocks for param description").
You are seeing the build error because a literal block ends at a next
line which starts from column 1.

I don't think Jon would dislike the simplest approach. :-)

Of course, if you guys love tables so much, I don't mind.

> 
> Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
> Fixes: edc93abbcc6d ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")
SHA-1 ID of a not-yet-merged commit will likely break later in
the merge window.

Good luck!

        Thanks, Akira
> 
> ---
> Thanks Jonathan's suggestion.
> 
> This fix is a simpler than before.
> And yes, It has built in my machine.
> 
> Best,
> 
> 	Shenghong Han
> ---
> ---
>  Documentation/vm/page_owner.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 25622c715..0ecb4a739 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
[...]
