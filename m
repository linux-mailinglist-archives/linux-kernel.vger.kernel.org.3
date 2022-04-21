Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8915509F55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383220AbiDUMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351963AbiDUMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63C5825C57
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:09:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26AB01480;
        Thu, 21 Apr 2022 05:09:33 -0700 (PDT)
Received: from [10.1.196.43] (hal.cambridge.arm.com [10.1.196.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B342A3F5A1;
        Thu, 21 Apr 2022 05:09:27 -0700 (PDT)
Message-ID: <15ceea01-20c3-0fd1-f045-ffa1dd4fb6c3@foss.arm.com>
Date:   Thu, 21 Apr 2022 13:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] arm64: defconfig: Enable modules for arm displays
Content-Language: en-US
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        krzk@kernel.org, biju.das.jz@bp.renesas.com,
        enric.balletbo@collabora.com, agx@sigxcpu.org, spujar@nvidia.com,
        alexander.stein@ew.tq-group.com, yuzenghui@huawei.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org
References: <20220128100720.87803-1-carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220128100720.87803-1-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping - has anyone looked at this?

On 1/28/22 10:07, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Key devices that support displays on SoCs like the Komeda DRM driver, the
> older HDLCD were not enabled by default and should be so displays can work
> out of the box on defconfig. Also Candence I2C support should be enabled so
> the PHY and thus displays can work too.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>   arch/arm64/configs/defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 30516dc0b70e..87edd79dac99 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -469,6 +469,7 @@ CONFIG_I2C_TEGRA=y
>   CONFIG_I2C_UNIPHIER_F=y
>   CONFIG_I2C_RCAR=y
>   CONFIG_I2C_CROS_EC_TUNNEL=y
> +CONFIG_I2C_CADENCE=m
>   CONFIG_SPI=y
>   CONFIG_SPI_ARMADA_3700=y
>   CONFIG_SPI_BCM2835=m
> @@ -678,7 +679,9 @@ CONFIG_VIDEO_OV5645=m
>   CONFIG_VIDEO_QCOM_CAMSS=m
>   CONFIG_DRM=m
>   CONFIG_DRM_I2C_NXP_TDA998X=m
> +CONFIG_DRM_HDLCD=m
>   CONFIG_DRM_MALI_DISPLAY=m
> +CONFIG_DRM_KOMEDA=m
>   CONFIG_DRM_NOUVEAU=m
>   CONFIG_DRM_EXYNOS=m
>   CONFIG_DRM_EXYNOS5433_DECON=y
