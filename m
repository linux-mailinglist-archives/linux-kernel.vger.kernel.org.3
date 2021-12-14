Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D8473CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhLNFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhLNFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:46:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A62C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D319360E15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648A9C34604;
        Tue, 14 Dec 2021 05:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460788;
        bh=4Qo7hbcTtNKS5mtjhODUyZ/MjrS+eFwRhNLs731fQZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZC1kHovldrO/ng2L/myr2+ZW9hicUC3ivk0+nYtrn6HkYRp8WQ1AHu0LkVPWTSYP7
         8yuKDP2URNuJRkYmHc56y6XOjsEXQwT450Dp9+o2Ef8a1purL4YFd5CYA27fI/hZjz
         v5Hot8X9oGTYRacS/Gp1lvhB3QA2axweLJO9m0m3KyRRn+5Q8aPvWht+t6d+yE259O
         tKTDC8PupPgUEurHXaGFZECDx/LcB1H485/pNg9ygHBEZDRSWg5FupwMmU9JwhMPMc
         fSj7RCv29GuhbcEVPwtO5cgum7bnMQmBQlB95MuOIoOCNLyig24dQ8RgkqVWyCxgJu
         asAoBVd7E+87w==
Date:   Tue, 14 Dec 2021 13:46:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be
 used as wakeup source
Message-ID: <20211214054619.GI10916@dragon>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204001718.8511-3-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:17:12PM -0600, Li Yang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add flextimer2 based ftm_alarm1 node and enable it to be the default rtc
> wakeup source for rdb and qds boards instead of the original flextimer1
> based ftm_alarm0.  The ftm_alarm0 node hence is disabled by default.

What's wrong with using ftm_alarm0?

Shawn

> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 6 +++++-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 6 +++++-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 9 +++++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 6e2a1da662fb..00d5b81bdef3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -25,7 +25,7 @@ aliases {
>  		serial1 = &duart1;
>  		mmc0 = &esdhc;
>  		mmc1 = &esdhc1;
> -		rtc1 = &ftm_alarm0;
> +		rtc1 = &ftm_alarm1;
>  	};
>  
>  	chosen {
> @@ -234,6 +234,10 @@ mt35xu02g0: flash@0 {
>  	};
>  };
>  
> +&ftm_alarm1 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 7719f44bcaed..41900d351a92 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -21,7 +21,7 @@ aliases {
>  		serial1 = &duart1;
>  		mmc0 = &esdhc;
>  		mmc1 = &esdhc1;
> -		rtc1 = &ftm_alarm0;
> +		rtc1 = &ftm_alarm1;
>  	};
>  
>  	chosen {
> @@ -132,6 +132,10 @@ mt35xu02g0: flash@0 {
>  	};
>  };
>  
> +&ftm_alarm1 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 9efcaf68578c..ef9d17df2afa 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -1198,6 +1198,15 @@ ftm_alarm0: timer@2800000 {
>  			reg = <0x0 0x2800000 0x0 0x10000>;
>  			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
>  			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		ftm_alarm1: timer@2810000 {
> +			compatible = "fsl,ls1028a-ftm-alarm";
> +			reg = <0x0 0x2810000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
>  		};
>  	};
>  
> -- 
> 2.25.1
> 
