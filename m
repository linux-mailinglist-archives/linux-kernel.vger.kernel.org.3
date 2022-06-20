Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A15550E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiFTAlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiFTAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6364E1;
        Sun, 19 Jun 2022 17:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B838612FC;
        Mon, 20 Jun 2022 00:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0943EC34114;
        Mon, 20 Jun 2022 00:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655685682;
        bh=Hgwn1GpC9/vbnJZHAosID2GrphkNdUfvhQ5a+CEPMdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gk+4XLev4zYdp2hNSRsO4ZeTPKrmM4dDcO1pJf/wQ8BJsyGnIPqC+nwdf0pNJeJv2
         XJ17EO4AbG3aeVSB//xN1beIh7ApGyQINRceGOLbW95iM04qg/2v8B2U7IfYAYCv3T
         qiRo2H+lzl7jAgFZvz7RTG8+aKIduwBE7cdAigfmaXyjgTCe+IfktYrJTmyYkYRVY/
         IsHY7fNwAADSCH1pk5H7JRXDMT05/tqFfTdabGMpkHp4/0OsZBqPGxfyrn4BNMi+Vc
         1kBBGomZLczVR1JBX9diBDLnqwDqejMdHXgwh+YNXXUw0ZRwoCvLkxpqWg0fDk+3+u
         zeRxNJuoNOLbQ==
Date:   Mon, 20 Jun 2022 08:41:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm-evk: add bt-sco sound card support
Message-ID: <20220620004116.GP254723@dragon>
References: <1655288134-14083-1-git-send-email-shengjiu.wang@nxp.com>
 <1655288134-14083-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655288134-14083-2-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 06:15:32PM +0800, Shengjiu Wang wrote:
> Add bt-sco sound card, which supports wb profile as default
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index c42b966f7a64..d99b562bb00e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -75,6 +75,11 @@
>  		linux,autosuspend-period = <125>;
>  	};
>  
> +	bt_sco_codec: bt_sco_codec {

Generic node name, maybe 'audio-codec'?

Shawn

> +		#sound-dai-cells = <1>;
> +		compatible = "linux,bt-sco";
> +	};
> +
>  	wm8524: audio-codec {
>  		#sound-dai-cells = <0>;
>  		compatible = "wlf,wm8524";
> @@ -107,6 +112,25 @@
>  			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>  		};
>  	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "bt-sco-audio";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&bt_sco_codec 1>;
> +		};
> +	};
>  };
>  
>  &A53_0 {
> @@ -346,6 +370,16 @@
>  	status = "okay";
>  };
>  
> +&sai2 {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> @@ -494,6 +528,15 @@
>  		>;
>  	};
>  
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
> +			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
> +			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
> +			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
> +		>;
> +	};
> +
>  	pinctrl_sai3: sai3grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> -- 
> 2.17.1
> 
