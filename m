Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35901508EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349757AbiDTRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiDTRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:42:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971B43ADF;
        Wed, 20 Apr 2022 10:40:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x33so4311302lfu.1;
        Wed, 20 Apr 2022 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fDm0hCeP1iuF9WL7RiqDe/J3rtlxPQX1zeA/vezHRa0=;
        b=WA6ZRCaU3cdlumlpbvWHxfloi03BAMhbknENhqsaWPbHRTCv9SZOTLs6l5atjl/rNB
         WhDgJgxuFoJ/Qjj/q6o0HjImWWNexAoe3iis41zRi8T7cp+cNxoIeLsaIrzGx7M+aP5f
         yTAUWAt+k6SrK4lNorKyp7zkayVMzWGHtU826B3wT4VF+PqS8rhJhhQw+6nzVJOpHjPO
         Z+fl0//75bOefoMVkqelSYCTT7/Fe7c10WZtohovtXDzsn3PyILek6foHM5/OQmQFSLW
         u1+mJd34DWLpm19EGHWC0J1RcHPjVNnGwatLnAkk0E4lmNtGfNVpgiVhfCCchSqTE+cC
         Tr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fDm0hCeP1iuF9WL7RiqDe/J3rtlxPQX1zeA/vezHRa0=;
        b=zdu1gMgQd6+MDp3H8S+NCcjuLHjg29gxBItxzhtBIdwItURUHeGDvVxDd7Mc09tuhc
         4oUUPfWa+8mEi0zyGAq7GcVNFvvm5YRDMX78DVR8C5Iinw7UeEm5BXDXhei5gVf+G1mT
         AG8R71Q4zAmHEtvlJ6CcP5NS/fhk/iO+FXA46+t6f3/RD/XHCToyooePf3PbLN75+T7u
         lvG9VDHtV8lkQr2DwRgsbV34xOE86cDYZAS2W5GgHfI5Sv853ZA5K+MTAF37JVftQA4J
         avGSEeR493mgbugCyRHNtobBOhgqvnjhU4CwvU+xYZz3pZsFzuhc/3gw2d10pKpgkTcq
         F4Cg==
X-Gm-Message-State: AOAM533Nzb5cLxGlJXU9gTDaSRq0L8vJ+19cmOs2DzZXm9rIccZNRuMt
        knmk/celBkcCvJHMFaB9GwA=
X-Google-Smtp-Source: ABdhPJxge8XTkpASmraJ0VjrGWjf9n/ju/ayI7pvlM3z8AJpfQOWU1Cqk3TRPVw0hpSrfMk+YQhJmQ==
X-Received: by 2002:a05:6512:1504:b0:44b:36e:b50d with SMTP id bq4-20020a056512150400b0044b036eb50dmr15640332lfb.558.1650476402746;
        Wed, 20 Apr 2022 10:40:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:9cae:8c00:9682:e720:334f:2fac? (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id s17-20020a195e11000000b0046eec768984sm1785063lfb.200.2022.04.20.10.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 10:40:02 -0700 (PDT)
Message-ID: <90e11a93-4f3a-2209-2bc2-acfb791b8ac0@gmail.com>
Date:   Wed, 20 Apr 2022 20:40:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs/ntfs3: remove redundant assignment to variable vcn
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220418140038.82843-1-colin.i.king@gmail.com>
From:   Kari Argillander <kari.argillander@gmail.com>
In-Reply-To: <20220418140038.82843-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.4.2022 17.00, Colin Ian King wrote:
> Variable vcn is being assigned a value that is never read, it is
> being re-assigned again in the initialization of a for-loop.  The
> assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/ntfs3/attrib.c:1176:7: warning: Value stored to 'vcn' during its
> initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>   fs/ntfs3/attrib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index e8c00dda42ad..fc0623b029e6 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -1173,7 +1173,7 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
>   {
>   	struct ntfs_sb_info *sbi = ni->mi.sbi;
>   	u8 cluster_bits = sbi->cluster_bits;
> -	CLST vcn = from >> cluster_bits;
> +	CLST vcn;
>   	CLST vcn_last = (to - 1) >> cluster_bits;
>   	CLST lcn, clen;
>   	int err;
