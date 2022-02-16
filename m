Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C694B831C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiBPIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:40:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBPIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:40:02 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 00:39:50 PST
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C538120E8B;
        Wed, 16 Feb 2022 00:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YLqbvNAQ5McurwQxgQURUxYEK/101B81ffBYTWQOubQ=; b=eL7Hr/lkBZAvTbiBImym7WqBQv
        fFtLWY1zFgcvz0Y28ZdTef3hq5UPUDbyOdU9owOcUlMeUyuZ3oyA98+tA7VtWzh/V83PJpmahWg5r
        mvo8+O4dcwNzaE4UT8NttIU5Q9B24c2fgT7vTH888Bt6ebP3Ss7Na0xbwHiYPj0X9IyrjurNjA5eB
        ZWjzedHDsBYGuHo0wwQOWbdJJooJ46j4RrmUOFAYciKhQ5IxMuRrv2wAplC9c/d+YFiFj0HwvJvHq
        KNdq7ecLO91xqhxo3t7F2RmN2eLeyUJ6R9jJqyAbe7jDYAW+nOrk0ELj+fWkrABrJye0Ksa6W80gd
        A3UB8CtA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nKEop-0001Qm-2c; Wed, 16 Feb 2022 09:33:43 +0200
Message-ID: <f0eb82eb-dec6-0870-3896-0973758caebb@kapsi.fi>
Date:   Wed, 16 Feb 2022 09:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 4/6] dt-bindings: Add HDA support for Tegra234
Content-Language: en-US
To:     Mohan Kumar <mkumard@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        tiwai@suse.com, jonathanh@nvidia.com, spujar@nvidia.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210065057.13555-1-mkumard@nvidia.com>
 <20220210065057.13555-5-mkumard@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220210065057.13555-5-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 08:50, Mohan Kumar wrote:
> Add hda clocks, memory ,power and reset binding entries
> for Tegra234.
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>   include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
>   include/dt-bindings/memory/tegra234-mc.h       | 6 ++++++
>   include/dt-bindings/power/tegra234-powergate.h | 9 +++++++++
>   include/dt-bindings/reset/tegra234-reset.h     | 2 ++
>   4 files changed, 21 insertions(+)
>   create mode 100644 include/dt-bindings/power/tegra234-powergate.h
> 
> diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
> index 8d7e66e1b6ef..c014269b7245 100644
> --- a/include/dt-bindings/clock/tegra234-clock.h
> +++ b/include/dt-bindings/clock/tegra234-clock.h
> @@ -30,5 +30,9 @@
>   #define TEGRA234_CLK_PLLC4			237U
>   /** @brief 32K input clock provided by PMIC */
>   #define TEGRA234_CLK_CLK_32K			289U
> +/** @brief CLK_RST_CONTROLLER_AZA2XBITCLK_OUT_SWITCH_DIVIDER switch divider output (aza_2xbitclk) */
> +#define TEGRA234_CLK_AZA_2XBIT			457U
> +/** @brief aza_2xbitclk / 2 (aza_bitclk) */
> +#define TEGRA234_CLK_AZA_BIT			458U
>   
>   #endif
> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
> index 2662f70c15c6..f538fc442cee 100644
> --- a/include/dt-bindings/memory/tegra234-mc.h
> +++ b/include/dt-bindings/memory/tegra234-mc.h
> @@ -7,6 +7,8 @@
>   #define TEGRA234_SID_INVALID		0x00
>   #define TEGRA234_SID_PASSTHROUGH	0x7f
>   
> +/* NISO0 SMMU STREAM IDs */
> +#define TEGRA234_SID_NISO0_HDA		0x03

Please follow the existing convention in this file.

/* NISO0 stream IDs */
#define TEGRA234_SID_HDA	0x03

>   
>   /* NISO1 stream IDs */
>   #define TEGRA234_SID_SDMMC4	0x02
> @@ -16,6 +18,10 @@
>    * memory client IDs
>    */
>   
> +/* High-definition audio (HDA) read clients */
> +#define TEGRA234_MEMORY_CLIENT_HDAR 0x15
> +/* High-definition audio (HDA) write clients */
> +#define TEGRA234_MEMORY_CLIENT_HDAW 0x35
>   /* sdmmcd memory read client */
>   #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
>   /* sdmmcd memory write client */
> diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
> new file mode 100644
> index 000000000000..3c5575a51296
> --- /dev/null
> +++ b/include/dt-bindings/power/tegra234-powergate.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved. */
> +
> +#ifndef __ABI_MACH_T234_POWERGATE_T234_H_
> +#define __ABI_MACH_T234_POWERGATE_T234_H_
> +
> +#define TEGRA234_POWER_DOMAIN_DISP	3U
> +
> +#endif
> diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
> index 50e13bced642..2ab61c69a3d9 100644
> --- a/include/dt-bindings/reset/tegra234-reset.h
> +++ b/include/dt-bindings/reset/tegra234-reset.h
> @@ -10,6 +10,8 @@
>    * @brief Identifiers for Resets controllable by firmware
>    * @{
>    */
> +#define TEGRA234_RESET_HDA			20U
> +#define TEGRA234_RESET_HDACODEC			21U
>   #define TEGRA234_RESET_SDMMC4			85U
>   #define TEGRA234_RESET_UARTA			100U
>   

