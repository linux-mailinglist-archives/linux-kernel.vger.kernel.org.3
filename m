Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4E5AC866
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiIEBFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIEBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3C1EEFB;
        Sun,  4 Sep 2022 18:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C286103F;
        Mon,  5 Sep 2022 01:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602EAC433D6;
        Mon,  5 Sep 2022 01:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662339916;
        bh=tKAcod8O+0mkAOBPOkXfZhwjcn956ykjPq75O0AB4+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsPBOfPH9EiQo8PU00qMAlAql8Fztzmqm0d/6llGjerBk/arAP192o2O9jeAt70TN
         dpw8RTwjx3+K6NByAxrgVSiuSzdWwiOC5dkXx8EE5vxkicvgF0Zine4SyPxUpFWJRR
         mpoDYNDTlji2KDem7asAyvhDUqB9QD7s+ufAC3Z7+ZIZ2NNiDfQ+ilj0+7NO6EQdbJ
         R+jzj8CmHsX8RnVsXnzHaxJCD7gzN3tgYpAKQr00vqJOxZIZ7+GoHD3kcZjlkzWMAy
         i+aZPCLtxFpnj+ub8Mm4D40roMr7gsVwRHV3NH1LIAAG3a5vwjIZyyPh0TFBeoSCsW
         9xF4vBixtgFTw==
Date:   Mon, 5 Sep 2022 09:05:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Po Liu <po.liu@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 03/11] arm64: dts: ls1043a: use pcie aer/pme interrupts
Message-ID: <20220905010510.GO1728671@dragon>
References: <20220824223700.32442-1-leoyang.li@nxp.com>
 <20220824223700.32442-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824223700.32442-4-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:36:54PM -0500, Li Yang wrote:
> After the binding has been updated to include more specific interrupt
> definition, update the dts to use the more specific interrupt names.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 3ba66b18de35..242fe8bfab17 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -883,9 +883,9 @@ pcie1: pcie@3400000 {
>  			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
>  			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 118 0x4>, /* controller interrupt */
> -				     <0 117 0x4>; /* PME interrupt */
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 117 0x4>,
> +				     <0 118 0x4>;

While at it, could you use IRQ_TYPE_LEVEL_HIGH for the polarity cell? 

Shawn

> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -909,9 +909,9 @@ pcie2: pcie@3500000 {
>  			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
>  			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 128 0x4>,
> -				     <0 127 0x4>;
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 127 0x4>,
> +				     <0 128 0x4>;
> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -935,9 +935,9 @@ pcie3: pcie@3600000 {
>  			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
>  			      <0x50 0x00000000 0x0 0x00002000>; /* configuration space */
>  			reg-names = "regs", "config";
> -			interrupts = <0 162 0x4>,
> -				     <0 161 0x4>;
> -			interrupt-names = "intr", "pme";
> +			interrupts = <0 161 0x4>,
> +				     <0 162 0x4>;
> +			interrupt-names = "pme", "aer";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -- 
> 2.37.1
> 
