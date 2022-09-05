Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01F5AC8F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiIEDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiIEDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1123E12744;
        Sun,  4 Sep 2022 20:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0210B80E99;
        Mon,  5 Sep 2022 03:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF768C433D7;
        Mon,  5 Sep 2022 03:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662347112;
        bh=bBbKjCYPa2yQ8PsoSG7Gmg41PXdrEAFx1+nbuzO1p0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCvaLBHjI6f77PccWsLr+54Ar+VTygTGNRR4DgpYo6C0fwcYRWr0fNm/12Iwk74te
         ToyDyHD6acAZWYYIjLgV71k9x+Qni04rVH8O1fzOUXk1rl5yfV0bOP5n13yBVr7vJu
         JWputrOxVbRvSZV4ZfajZ0S0PN4uNsU9zghRrdj7D5wHua4vVc6zC0Fh+549QvNzWE
         ImOswrlBYEihQLLUBoaLb+tGjOx1ghMEVBQ64+z4gjJWKhewVuOkrS/MBXCXzZRKE4
         cPU5J5Hk5jm8d5QS67DdCgqI4KnzvxIm3o3Xq+vZuzh8NLiBEYfcS46yBjSz9VGxpf
         SETXTGKE9Xkzw==
Date:   Mon, 5 Sep 2022 11:05:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V3 4/8] arm64: dts: imx93: add s4 mu node
Message-ID: <20220905030505.GF1728671@dragon>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
 <20220831141418.38532-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831141418.38532-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:14:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add s4 mu node for sentinel communication
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 26d5ce4a5f2c..dd76472ced46 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -342,5 +342,15 @@ gpio1: gpio@47400080 {
>  			clock-names = "gpio", "port";
>  			gpio-ranges = <&iomuxc 0 0 32>;
>  		};
> +
> +		s4muap: mailbox@47520000 {
> +			compatible = "fsl,imx93-mu-s4";
> +			reg = <0x47520000 0x10000>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "txirq", "rxirq";
> +			#mbox-cells = <2>;
> +			status = "okay";

Unneeded "okay" status?

Shawn

> +		};
>  	};
>  };
> -- 
> 2.37.1
> 
