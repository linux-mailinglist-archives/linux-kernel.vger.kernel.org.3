Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A44C35EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiBXTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiBXTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:32:17 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2750054;
        Thu, 24 Feb 2022 11:31:43 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id q5so4443355oij.6;
        Thu, 24 Feb 2022 11:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiafZeplBWhT7qA6TILDu8RUDYpdcUkSvNy49Uo79Y4=;
        b=6WHEiE2939aMhWbKPVZp69i0TT92WG1CSxQMaEFJofU5IOLRpEpxzjsA32Yd4g8DNj
         eURk0CcLFl+UmIeS+VgMZHbLkVG68ZsvoC6Zd27gM/08vAwm0507oOO6fY6yMWpmBMVe
         Wrxj2cj+nPKz1C3hAIz3/DgD9RNXpZ9M0YQvbSttlpif7idIKygLOQ7VOYyqP/7k48m/
         1FRMIzUQcBYknKZA9oth5ezvZY9wv21Ez1IFjDZdizjDeZfpodG1M+e78z2DKziufzni
         f0KRadfgtZR7iEBxQbTgWi4DkAuLFwCMxJzSpCI4R+y0d8jKrZFqp6TF5eMPicE1Aeso
         Utvw==
X-Gm-Message-State: AOAM530m8XewdDMMAIphyCh2vewp5eKlEzorDUnppa9njQcO7lZhpzBN
        5q7jlnyLLReUkxdp4ZftmDa8fGHOaw==
X-Google-Smtp-Source: ABdhPJwZKPUfwn6b609ImZjzM72DsS1EGoc6MqGOxqYPh0gRQ8a18eVWjrPShbIcgD6oyXqcu+p1kQ==
X-Received: by 2002:a05:6808:138e:b0:2d5:1ed5:e0ac with SMTP id c14-20020a056808138e00b002d51ed5e0acmr2252281oiw.214.1645731103283;
        Thu, 24 Feb 2022 11:31:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v7-20020a4aa507000000b0031c01a4ef37sm79465ook.32.2022.02.24.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:31:42 -0800 (PST)
Received: (nullmailer pid 3451260 invoked by uid 1000);
        Thu, 24 Feb 2022 19:31:41 -0000
Date:   Thu, 24 Feb 2022 13:31:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        tiwai@suse.com, jonathanh@nvidia.com, spujar@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: Add HDA support for Tegra234
Message-ID: <YhfdHd2LPc+ifFTS@robh.at.kernel.org>
References: <20220216092240.26464-1-mkumard@nvidia.com>
 <20220216092240.26464-5-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216092240.26464-5-mkumard@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:52:38PM +0530, Mohan Kumar wrote:
> Add hda clocks, memory ,power and reset binding entries
> for Tegra234.
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
>  include/dt-bindings/memory/tegra234-mc.h       | 6 ++++++
>  include/dt-bindings/power/tegra234-powergate.h | 9 +++++++++
>  include/dt-bindings/reset/tegra234-reset.h     | 2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/power/tegra234-powergate.h
> 
> diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
> index 2529e7ec0bf4..2ab651916127 100644
> --- a/include/dt-bindings/clock/tegra234-clock.h
> +++ b/include/dt-bindings/clock/tegra234-clock.h
> @@ -64,4 +64,8 @@
>  #define TEGRA234_CLK_PLLC4			237U
>  /** @brief 32K input clock provided by PMIC */
>  #define TEGRA234_CLK_CLK_32K			289U
> +/** @brief CLK_RST_CONTROLLER_AZA2XBITCLK_OUT_SWITCH_DIVIDER switch divider output (aza_2xbitclk) */
> +#define TEGRA234_CLK_AZA_2XBIT			457U
> +/** @brief aza_2xbitclk / 2 (aza_bitclk) */
> +#define TEGRA234_CLK_AZA_BIT			458U
>  #endif
> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
> index 2662f70c15c6..c42fe61fba5e 100644
> --- a/include/dt-bindings/memory/tegra234-mc.h
> +++ b/include/dt-bindings/memory/tegra234-mc.h
> @@ -7,6 +7,8 @@
>  #define TEGRA234_SID_INVALID		0x00
>  #define TEGRA234_SID_PASSTHROUGH	0x7f
>  
> +/* NISO0 stream IDs */
> +#define TEGRA234_SID_HDA		0x03
>  
>  /* NISO1 stream IDs */
>  #define TEGRA234_SID_SDMMC4	0x02
> @@ -16,6 +18,10 @@
>   * memory client IDs
>   */
>  
> +/* High-definition audio (HDA) read clients */
> +#define TEGRA234_MEMORY_CLIENT_HDAR 0x15
> +/* High-definition audio (HDA) write clients */
> +#define TEGRA234_MEMORY_CLIENT_HDAW 0x35
>  /* sdmmcd memory read client */
>  #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
>  /* sdmmcd memory write client */
> diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
> new file mode 100644
> index 000000000000..3c5575a51296
> --- /dev/null
> +++ b/include/dt-bindings/power/tegra234-powergate.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

> +/* Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved. */
> +
> +#ifndef __ABI_MACH_T234_POWERGATE_T234_H_
> +#define __ABI_MACH_T234_POWERGATE_T234_H_
> +
> +#define TEGRA234_POWER_DOMAIN_DISP	3U
> +
> +#endif
> diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
> index ba390b86361d..178e73a687f0 100644
> --- a/include/dt-bindings/reset/tegra234-reset.h
> +++ b/include/dt-bindings/reset/tegra234-reset.h
> @@ -10,6 +10,8 @@
>   * @brief Identifiers for Resets controllable by firmware
>   * @{
>   */
> +#define TEGRA234_RESET_HDA			20U
> +#define TEGRA234_RESET_HDACODEC			21U
>  #define TEGRA234_RESET_I2C1			24U
>  #define TEGRA234_RESET_I2C2			29U
>  #define TEGRA234_RESET_I2C3			30U
> -- 
> 2.17.1
> 
> 
