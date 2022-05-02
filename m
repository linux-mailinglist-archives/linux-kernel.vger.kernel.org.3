Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D7517A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiEBXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiEBXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:05:41 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6B2DAB6;
        Mon,  2 May 2022 16:02:11 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id z8so16683564oix.3;
        Mon, 02 May 2022 16:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WR/yNaVn0oKvy+CnVuoKUFtzBzSP5sIDulB7MsR7hO8=;
        b=3VyCCiQzm/6A3n9txOycqgc7J0+/YCmAO1drlgvgu4l6k6vrahk2OTUDa7ES+eshrd
         Sp2NI+3Ifimqhi98V7rhZCvLxVfTN5xqAlnXaoLlPEzJm9TX686qFR9r00oyggGqRNT+
         flQA2gySHHsyMoS4qNQFsqT6f2+zhK8UhFcKmCs9/FJyORCOCHWo3HlzZdFED79nAhSE
         FpCXq+EdpUJ32NpdddpoUhQB5on9My8tQhDuS3Vg7pu5oxu2jxpOF/sTRWDo/OH0w6Ob
         wV4A4okCD3YoHBaTxMx0mRaLtkVu0aAEsBMUIrHNqIcxwwNPaLieeGaFPpf6ZAnM//ne
         xRtQ==
X-Gm-Message-State: AOAM531FHUMxSHyba7sYVhCZ8tr8UyKwPszrOEqAhcKf/wYqy+fMVZ2o
        ar99AQ2NjPFTJy4H4xazgw==
X-Google-Smtp-Source: ABdhPJyrrrVy/nBJX0NxS3n0bBBerGGiEY+59Kdl77j+XTI2OWdQl05GkFXTfkI0N6SkepTNcpUUnw==
X-Received: by 2002:a05:6808:1c7:b0:326:134f:1f50 with SMTP id x7-20020a05680801c700b00326134f1f50mr670432oic.203.1651532530718;
        Mon, 02 May 2022 16:02:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w23-20020a9d6757000000b0060603221257sm3378457otm.39.2022.05.02.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:02:10 -0700 (PDT)
Received: (nullmailer pid 1963769 invoked by uid 1000);
        Mon, 02 May 2022 23:02:09 -0000
Date:   Mon, 2 May 2022 18:02:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Message-ID: <YnBi8dnKQQC0bHsR@robh.at.kernel.org>
References: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
 <20220425110330.1630984-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425110330.1630984-2-peng.fan@oss.nxp.com>
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

On Mon, Apr 25, 2022 at 07:03:28PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX 93 applications processors are the first in the i.MX portfolio
> to integrate the scalable Arm Cortex-A55 core, bringing performance
> and energy efficiency to Linux-based edge applications and the
> Arm Ethos-U65 microNPU, enabling developers to create more capable,
> cost-effective and energy-efficient ML applications.
> 
> Add the basic dtsi support for i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 337 ++++++++++
>  2 files changed, 960 insertions(+)
>  create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-pinfunc.h b/arch/arm64/boot/dts/freescale/imx93-pinfunc.h
> new file mode 100755
> index 000000000000..f848ccd411cb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-pinfunc.h
> @@ -0,0 +1,623 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Your licensing isn't consistent. The board dts is different. Dual 
licensing is what's correct.

Your company is okay with GPLv3?

Rob
