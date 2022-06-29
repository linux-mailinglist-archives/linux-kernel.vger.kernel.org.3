Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2C560A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiF2TeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2TeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:34:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC322B12;
        Wed, 29 Jun 2022 12:34:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so464067pjz.1;
        Wed, 29 Jun 2022 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YYCqzzmao2nkKWy6jAkVvj4l8v/TmTYQQPXuNAPJEaI=;
        b=qS10neaoML1jirwTEWwcNgQ+OR4PuGQr0cAfF7KIHricCWzZSJUe64bckBQTl73nfx
         JV0C4uT2/1IPu6WNQ0cxXu+5XOTekrydSTiS3fDfW9/+HOuTdJgUDQtov84IxPBxbgqL
         6rEQwjLKUZc3g6vyWICyo5YitPtJrj377vrMFqwT5b5JNCupJtxmECMiG5/LiJZvPCus
         urpY7d0Ra/ifM16jx5mEIPwuaE4vbVslphfEhqSTm1rhS9EoLOPruZuyGvxpCon0s3IS
         XEc8Lsd8zHmBBDkxUmxeMa3UWX9ZyWfZXasM/CPiytj0gPFmgqaObO/c/znbMnBgViLu
         F2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YYCqzzmao2nkKWy6jAkVvj4l8v/TmTYQQPXuNAPJEaI=;
        b=11sVb8FGtf6yXNXHAnzFg7TtvueN948AdvTnFY2wYEphSGghxGRxHHCSMKterGX5I/
         VKs3QVUIf5tXgu3FWEcOZMjsloOxFYv+/98AwCZdKbEIWibTBXhzjrUw0D+MZgZMahJ6
         3w6I4itj0ZNh52ouUCaVSo2DzUoSPUtZs3K6wXsMLpkZ6sHZmlAY668I66Kb6BemI07L
         T2aaBskezTz9tuRBAUWiOyS7mn1k+iqjwz7B4poQ+YNlsleq0kQUq2CZgfKDzhrKv07q
         l6BBS0q6aS8YDfxYjFNYzdb8XicaIkBU1resWndLA1WRIjg5ch8kz7+4Jrf1XdgQ/66x
         KgMQ==
X-Gm-Message-State: AJIora/M4crjOWYLzCyruGbSDe+gLdl5mzfrtE0TCRE7NQ2vFLwcqEI5
        llO7O1XWEo0tU2OYauOpi6rjoR0WwYE=
X-Google-Smtp-Source: AGRyM1srYx29S6gzu8JZbBQlxGDNK8Oa6fpbSwnqiJMdielPgTUcIu6i5r1elXEFNT+LsePbSZi/pA==
X-Received: by 2002:a17:903:2347:b0:16a:33cd:5308 with SMTP id c7-20020a170903234700b0016a33cd5308mr10479936plh.122.1656531249629;
        Wed, 29 Jun 2022 12:34:09 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b0016a1b60b19dsm11789007plb.91.2022.06.29.12.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:34:09 -0700 (PDT)
Message-ID: <0f1fd530-7764-a465-0b02-0027fc9a1383@gmail.com>
Date:   Thu, 30 Jun 2022 04:34:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PM / devfreq: passive: revert an editing accident in
 SPDX-License line
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220628053411.22438-1-lukas.bulwahn@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220628053411.22438-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 28. 14:34, Lukas Bulwahn wrote:
> Commit 26984d9d581e ("PM / devfreq: passive: Keep cpufreq_policy for
> possible cpus") reworked governor_passive.c, and accidently added a
> tab in the first line, i.e., the SPDX-License-Identifier line.
> 
> The checkpatch script warns with the SPDX_LICENSE_TAG warning, and hence
> pointed this issue out while investigating checkpatch warnings.
> 
> Revert this editing accident. No functional change.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Chanwoo, please pick this minor non-urgent fix to your latest change above.
> 
>  drivers/devfreq/governor_passive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 72c67979ebe1..326482a68986 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -1,4 +1,4 @@
> -	// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * linux/drivers/devfreq/governor_passive.c
>   *

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
