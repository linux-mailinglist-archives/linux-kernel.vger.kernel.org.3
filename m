Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554F4FFB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiDMQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbiDMQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:34:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B979606C1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:32:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so5071510ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpkFzuW5ZiUt687dE3hlxD0FI2i1NvKAD8xsfqrgLtM=;
        b=NUWKTyVT0CdvFJn8a5jpAf4eu0sJt8Pz+IDD17j25FzDxi00VPYP0/pg50QYMjSRAj
         F5YHC5plOd/SEqGVKOWRPBvQ0c9+E0hhFXYKmZPnySQhQ8MlEhGNgv+PXFTbLpY6IWU6
         FXVeceMT/+TR4rAFatGR7Ie3zYBZCwi5mDUdl2yT+P6dd+JcOgdeq7QXPv1FGLt/sNZv
         yFu2e+1HuUR+KO4k/eitViiEr+UyhAUfKgmOr5yd2TqadrbkS+MBpBwa2V/360FBPpPj
         Z8//jVKKCB2U6xQb/1ruagjry5EyzcLSDcemGIOeouHsOZYElgWfrWc5zkqxs7awJndN
         xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpkFzuW5ZiUt687dE3hlxD0FI2i1NvKAD8xsfqrgLtM=;
        b=XhYehqMjyNaw26D4fDDdaKqiVu5PB5MoRR7WC3qMitSGpjVxRD4tOVBlUBle8rV4jm
         tM5NuWcdMenifjiaCvyUQS2Vcko7sBkF/BibVLla9Lfm9/wgMtHikXfmHW0WgnUIIGCg
         lYCa706rD5E9QoDP9aj3xhCpwrdVeq7ozVasEiUSdknZutVVSElIaUbJsrpicTJVmUrW
         +gCR5EpZU3lrF5fDdU5ZZDtO8XU4setMsA8pLzrGk6zYfqnnGxdpfqX1dv9ikGlXWZQ6
         eoD9I2yvbBgccYtm/Y9+qCluP+Bcn/eaGLLT0oIBHP2mg2snB6JY5L8kICPTXqPOB/b+
         JXPQ==
X-Gm-Message-State: AOAM530MLrxGNS058F6zT5RpX9dJow+6VCs88GCF628gAFwurXV5F4yf
        XL0zO6a8nxTrqKFEfgIKLi04keEcq+I=
X-Google-Smtp-Source: ABdhPJzDOSFxIFYAwRX7x1djspP/2mQSQuaxumyoE1HJCWAoRGgQTZTigrUQJyJV21sSxb9QNlgjzA==
X-Received: by 2002:a17:906:d7a2:b0:6e8:9a34:c954 with SMTP id pk2-20020a170906d7a200b006e89a34c954mr11914101ejb.697.1649867530984;
        Wed, 13 Apr 2022 09:32:10 -0700 (PDT)
Received: from skbuf ([188.26.57.45])
        by smtp.gmail.com with ESMTPSA id l3-20020a509dc3000000b00420195722c7sm437399edk.6.2022.04.13.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:32:10 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:32:09 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Message-ID: <20220413163209.4pqqpyqdklhlzp5p@skbuf>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214093240.23320-2-leoyang.li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:32:33AM -0600, Li Yang wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
>
> Add PCIe EP nodes for ls1028a to support EP mode.
>
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index fd3f3e8bb6ce..9010c535252a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -637,6 +637,18 @@ pcie1: pcie@3400000 {
>  			status = "disabled";
>  		};
>
> +		pcie_ep1: pcie-ep@3400000 {
> +			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03400000 0x0 0x00100000
> +			       0x80 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie2: pcie@3500000 {
>  			compatible = "fsl,ls1028a-pcie";
>  			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
> @@ -664,6 +676,18 @@ pcie2: pcie@3500000 {
>  			status = "disabled";
>  		};
>
> +		pcie_ep2: pcie-ep@3500000 {
> +			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03500000 0x0 0x00100000
> +			       0x88 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +			interrupt-names = "pme";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> --
> 2.25.1
>

arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:631.23-656.5: Warning (unique_unit_address): /soc/pcie@3400000: duplicate unit-address (also used in node /soc/pcie-ep@3400000)
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:670.23-695.5: Warning (unique_unit_address): /soc/pcie@3500000: duplicate unit-address (also used in node /soc/pcie-ep@3500000)
