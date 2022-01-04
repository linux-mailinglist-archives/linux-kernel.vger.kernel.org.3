Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6418483CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiADHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiADH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:29:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B2C061761;
        Mon,  3 Jan 2022 23:29:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so12566113wra.8;
        Mon, 03 Jan 2022 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=xIB56m/M+LTtKGiy0gvmAJt4zdZApfvrec3tM9nvLPQ=;
        b=eTSR4/WkiJLOwUeA11RWmDy05yxi9LhWMuFKbWdA9sUbPhuBsT5t4DIzrjdhticWfc
         ffZDEspHnUZ0sV9hWByWUDFDi3whKQhfoIFZwrfW55Ad1FUBLcCWyNkX57+gsPexCoHG
         bV4vnBYeMcsMYB2IqW7nZ/O7KKfRdtWyBn48zTjqKTS38be7F64JSf/HxOJqe6daw+Wg
         ixVwXlxDqdcMYkQK4aw4EI8mHISNjLNoG7du2J0cq59Hbc27KXIZqtrGUKWkv2R6+9Up
         3394apd+PVn4MtN7Z9a0pY+dzq3cm23C6e6mI7ZpHx/2J4p5E2qRzB31IyKJot2CZe0f
         vjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=xIB56m/M+LTtKGiy0gvmAJt4zdZApfvrec3tM9nvLPQ=;
        b=2l6YP1DJwu1v+Wj7gTC7Rr1W9UAfgmnCB1AR3pgxMuhr1Z96wrwcbEFJjxnRgabEQ0
         juw1Y2YpVU0Q1o7gix+lvK83ZnEid1w81nHN8stN4J+EYoPcACnVg/res7tOm1YXRf3b
         5P7cN0YgJz1IFDsiSaE7Swf2kovCmtZAi54NVb3K9Mtec6nWkcelLcDz/TpLUen2nyc/
         4/+XXRiIaLnvZpJD5JK0e4b2b6bwlj4No/XB/5us5s8H6ftvFJhsHwyyaxIa0JfWvFt0
         4GqDuHvcXmgWu9d14jzBqXrUIiZixrMQEfR8ikrzU0cg3v5JUZNhqS0VisJV2VHihC4J
         2QVQ==
X-Gm-Message-State: AOAM533GN5KcaIjPGYmU0vruXnpOMHvm/ITV+ziIg838O2cqU97b2LdC
        m0VcXrAkY0QAEA2CbEjYDbw5mL4BESA=
X-Google-Smtp-Source: ABdhPJzY7PxVNKBQ+OBhiVMaB/Io0gAoVcm8WMdnYfoAvhIUlc+yVtgrKeYSRZMdyK5258B+E27Eww==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr18381642wru.673.1641281374572;
        Mon, 03 Jan 2022 23:29:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:fd36:5cb2:ef91:142a? (p200300ea8f24fd00fd365cb2ef91142a.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:fd36:5cb2:ef91:142a])
        by smtp.googlemail.com with ESMTPSA id p18sm7787211wmq.23.2022.01.03.23.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 23:29:34 -0800 (PST)
Message-ID: <d485fb62-b576-f9b6-13bc-709a2c409240@gmail.com>
Date:   Tue, 4 Jan 2022 08:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220104111551.7f26e893@canb.auug.org.au>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: linux-next: build failure after merge of the pm tree
In-Reply-To: <20220104111551.7f26e893@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.2022 01:15, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_84 allmodconfig)
> failed like this:
> 
> sound/soc/sh/rz-ssi.c: In function 'rz_ssi_probe':
> sound/soc/sh/rz-ssi.c:1023:2: error: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>  1023 |  pm_runtime_resume_and_get(&pdev->dev);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   877d952c261e ("PM: runtime: Annotate pm_runtime_resume_and_get() as __must_check")
> 
> This also produced the following warnings in my arm multi_v7_defconfig
> build:
> 
> drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_hw_init':
> drivers/crypto/stm32/stm32-hash.c:816:2: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]
>   816 |  pm_runtime_resume_and_get(hdev->dev);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_import':
> drivers/crypto/stm32/stm32-hash.c:1003:2: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]
>  1003 |  pm_runtime_resume_and_get(hdev->dev);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_export':
> drivers/crypto/stm32/stm32-hash.c:965:2: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]
>   965 |  pm_runtime_resume_and_get(hdev->dev);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/crypto/stm32/stm32-cryp.c: In function 'stm32_cryp_hw_init':
> drivers/crypto/stm32/stm32-cryp.c:545:2: warning: ignoring return value of 'pm_runtime_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-result]
>   545 |  pm_runtime_resume_and_get(cryp->dev);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I have used the pm tree from next-20211224 for today.
> 
The patch in the pm tree annotating pm_runtime_resume_and_get() as __must_check
follows some fixes of pm_runtime_resume_and_get() usage that went through other
trees. These fixes are in linux-next but don't seem to be in the pm tree.
We talk about:
f04b4fb47d83 ("ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()")
3d6b661330a7 ("crypto: stm32 - Revert broken pm_runtime_resume_and_get changes")
