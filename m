Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504754D042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbiFORoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358220AbiFORnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:43:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9E45075
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:43:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u18so11031456plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H7RU4rTnGyh/N4PK+U9Z+WV3I6PfNhUaTBL3B2sH8vs=;
        b=pWmQ1AN63QHPI15DR38DwfKKN70ZSvIj6ezA24QEaW1U7P1caKtLLgcFRKFjLyXoYF
         +3CSmu1yMZ3J/eoM0DJD0R8nZoNYJgiyFKyZTskEyycxjPiVddXLpr6gztyYQbWg3XRk
         pSLe/SviqTnQbVFMfJIesdao42OHzO5Ntes4gdSIgbbGE6Isvmo79LYbDgyTLvsKfo1b
         kzj0fdFA1xQGEkSKSAWvafg4ZlZfcbh5s268UQyiQNLGnBqOUbBUeXFLB74Bwbw85IvT
         zbXZBA6hdMsTR/J4kDW1VDZj2NOBwmK1QHgaSgo+Esl6cEF5FLyJyc3oi8Il0balB3U6
         OWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H7RU4rTnGyh/N4PK+U9Z+WV3I6PfNhUaTBL3B2sH8vs=;
        b=rXAQC3HWnE31f6QsQEM/IwQUK6JswQLFWbFTPkF/JixGFWes9kFHsf2cBhEn6nOsi8
         tS5aRvTnaWn3D4YjHX5Fxs4y+Ep9hocKjGJ/Bx9F/T4yxM70xCqrhmBRmyzK9LG1F6Rv
         uvvFD1xJ49bTpP19SV+NyaLpzbojOEXbZJV4Xrw9Z+fNutcKAH8c/zCUp0knVzq064Mz
         2Rcc4Tbcswovmsyf8sv/tomlKTGOztGDZawFZYAr4HmXNY0XOuaSRlEENYPQ1yRF1JEC
         ZTh+A+Kzu7BiC5UNFJsxHmtcMz0jlJzjQ4vypTkz0cgltZSc+Xcmb9Ctkzf8i/NRk2hI
         VjCA==
X-Gm-Message-State: AJIora8OODxHO6HKPibx/XV1hY/wvX1IOaMiy/77CCCojEvMFXGc5Q5X
        VnNDnLI3+pS1oVKMuxECF+CN5+Kuhy0=
X-Google-Smtp-Source: AGRyM1sBy2Nor3MBmU0h1Mxel91so9WYQPLrnAC4s2DwYFuAiyArTzeVXWlzo9nhEqwxY1j/+nSIQA==
X-Received: by 2002:a17:902:b090:b0:167:7ae5:e13b with SMTP id p16-20020a170902b09000b001677ae5e13bmr485784plr.170.1655315010873;
        Wed, 15 Jun 2022 10:43:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ja21-20020a170902efd500b0016632179ecfsm9529144plb.264.2022.06.15.10.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:43:30 -0700 (PDT)
Message-ID: <700e7f0b-a535-545b-1c83-26ce2d4e8be1@gmail.com>
Date:   Wed, 15 Jun 2022 10:43:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: bcmbca: add VFP and NEON fixup for bcm6846 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        anand.gore@broadcom.com, kursad.oney@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220525003509.2812-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220525003509.2812-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 17:35, William Zhang wrote:
> BCM6846 SoC only has VFP and NEON support on core 0. So kernel VPF/NEON
> support is disabled in this chip. Add this fixup to manually turn on
> VFP/NEON in case userspace app need to access them on core 0.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

We have had this conversation internally already, but I do not think 
this is sufficient in order to have a workable solution, you indicated 
that there is all sorts of user-space involvement in your SDK to ensure 
that only VFP tasks are scheduled on core 0, but if we were to seek a 
proper solution we would have to modify the ARM Linux kernel to forcibly 
migrate VFP tasks onto a core that can support executing them, or accept 
emulating them with the implied slow down.

Russell, what are your thoughts on this?

> 
> ---
> 
>   arch/arm/mach-bcm/Makefile |  5 ++++
>   arch/arm/mach-bcm/bcmbca.c | 54 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>   create mode 100644 arch/arm/mach-bcm/bcmbca.c
> 
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index b2394ddb0558..137b24b52139 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -68,3 +68,8 @@ CFLAGS_platsmp-brcmstb.o	+= -march=armv7-a
>   obj-y				+= brcmstb.o
>   obj-$(CONFIG_SMP)		+= platsmp-brcmstb.o
>   endif
> +
> +# BCMBCA
> +ifeq ($(CONFIG_ARCH_BCMBCA),y)
> +obj-y				+= bcmbca.o
> +endif
> diff --git a/arch/arm/mach-bcm/bcmbca.c b/arch/arm/mach-bcm/bcmbca.c
> new file mode 100644
> index 000000000000..6fcdfe0b94c1
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcmbca.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Broadcom Ltd
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/smp.h>
> +#include <asm/mach/arch.h>
> +#include <asm/vfp.h>
> +#include <asm/cp15.h>
> +
> +#include "../vfp/vfpinstr.h"
> +
> +/*
> + * In some low end BCA chips, only core 0 has VPF/NEON support. Kernel VPF
> + * NEON are disabled on these platforms. Add this fixup to enable VFP/NEON
> + * on core 0 manually in case some user app need to access vfp/neon on core 0
> + */
> +static void __init neon_enable(void *data)
> +{
> +	u32 access, fpexc;
> +	(void)data;
> +
> +	/* Enable full access to VFP (cp10 and cp11) */
> +	access = get_copro_access();
> +	set_copro_access(access | CPACC_FULL(10) | CPACC_FULL(11));
> +
> +	/* enable NEON and VFP extension */
> +	fpexc = fmrx(FPEXC);
> +	fmxr(FPEXC, fpexc | FPEXC_EN);
> +}
> +
> +static void __init bcmbca_neon_fixup(void)
> +{
> +	smp_call_function_single(0, neon_enable, NULL, 1);
> +}
> +
> +static const char *const bcmbca_match[] __initconst = {
> +	"brcm,bcm6846",
> +	NULL
> +};
> +
> +DT_MACHINE_START(BCMBCA, "Broadcom BCMBCA SoC")
> +	.dt_compat		= bcmbca_match,
> +	.init_late		= bcmbca_neon_fixup,
> +MACHINE_END


-- 
Florian
