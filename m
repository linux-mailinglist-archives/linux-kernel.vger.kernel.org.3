Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA1590E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiHLJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiHLJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:47:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D5AA4D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a9so606460lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DywEXydriB9RHQfiUoHdykArQLV4TBJt7mtn5YtjZoE=;
        b=LwBHdnO1aRo+0D4D+H6G/KpkkhcLYKCY5twp4lafcbV2iNbBewTSuDHWAicBUVyZ6k
         XD8W67AyOXCddFyRPbPFxX2NebnYA8KEpp5Bv1Uh9wvmz3oLqEDa6EGVrbCQmkmAdSUr
         EGjZXkJ2DQHVf2RSr3780Kkzyl1edtbSVocJT6VzGItAQ6VoQ+9Z+gaRbWBDXkp1YsBz
         JevUOIXgRV99bgu4/HsyvOTB7UNcUJ1vMtw9ObV0ZAadxCMhg/p12YxZ5xKeVDbCtuY+
         2w0sy1R7C0exFVZAMQp1oHgeQ3MBNp6OdxY5twq70XNaD7QKfqQqwY6cZ5LNxMH01tpc
         1O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DywEXydriB9RHQfiUoHdykArQLV4TBJt7mtn5YtjZoE=;
        b=QDEuLNKsDcKhFCTDAmPTlzSsSTf8I++PV2RNbohDeZZCKFz52331GdYpW9wcetBavp
         yU/GZKfGmFofxWLikKLSgM7LxbqsyXV2RJJBDkZDSzcZntnRmHnmItmfySs3LxC7qsUD
         uEGX5QueLTYY4JRU8OKQbNiDzh1nH8zG1/EGe+5vHwThmSB8/8XBndRc4b+ILs0KjuKz
         wFtjrJM6YWkeZxYhnfQIhH3guqrlIcgX2a+nmI8WPD8BuMj+DyeO4DgSzZfMP4BZ1YsD
         mmlx7D2bVo3BdDMJ0XAzsjeiQkwpBQAwgJxrYupmQ7HCVyoVk8sFEBKj0ZYOrUIbmbaG
         551Q==
X-Gm-Message-State: ACgBeo2Bnbeaz2tyLMd4GShZh6otFAdeAdMzy5JAblRSMNUTpxuoqOnF
        SmOp9gWPZvQTUa3EHx0SUi2rzw==
X-Google-Smtp-Source: AA6agR7eHNAVuLG1Tzwad6XCZn0/j6CytzXhWajS9DLvUg5eG94lCgboTQKVISVSGSj5oeRbZaww8g==
X-Received: by 2002:a05:6512:3fa8:b0:48c:ffd1:625d with SMTP id x40-20020a0565123fa800b0048cffd1625dmr925593lfa.251.1660297641606;
        Fri, 12 Aug 2022 02:47:21 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b0025e496dad47sm295617ljb.26.2022.08.12.02.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:47:21 -0700 (PDT)
Message-ID: <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
Date:   Fri, 12 Aug 2022 12:47:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees for
 MSC SM2S-IMX8PLUS SoM and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220812084120.376042-1-martyn.welch@collabora.com>
 <20220812084120.376042-2-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812084120.376042-2-martyn.welch@collabora.com>
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

On 12/08/2022 11:41, Martyn Welch wrote:
> Add device trees for one of a number of MSC's (parent company, Avnet)
> variants of the SM2S-IMX8PLUS system on module along with the compatible
> SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of SoMs use
> the NXP i.MX8MP SoC and provide the SMARC module interface.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes in v2
>   - Added compatibles
>   - Removed underscores from node names
>   - Make node names more generic
>   - Reorder properties
>   - Fix issues found by dtbs_check in these files
> 
> Changes in v3:
>   - Switched to avnet vendor string in compatibles
>   - Corrected patch description
> 
> Changes in v4:
>   - Switched from phy-reset-gpios to reset-gpios, removing duplication
>   - Removed unneeded sdma1 node
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-msc-sm2s-14N0600E.dts    |  72 ++
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     |  53 ++
>  .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 812 ++++++++++++++++++
>  4 files changed, 938 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 8bf7f7ecebaa..139c8b95c9c9 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
> new file mode 100644
> index 000000000000..9e976e8baaee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Avnet Embedded GmbH
> + */
> +/dts-v1/;
> +
> +#include "imx8mp-msc-sm2s.dtsi"
> +
> +/ {
> +	model = "MSC SM2S-IMX8PLUS-QC6-14N0600E SoM";
> +	compatible = "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
> +		     "fsl,imx8mp";

This does not match your bindings. Please test your DTS.

Best regards,
Krzysztof
