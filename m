Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E974FAB60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiDJBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiDJBaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:30:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BB26D;
        Sat,  9 Apr 2022 18:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C81B2B80761;
        Sun, 10 Apr 2022 01:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0377CC385A0;
        Sun, 10 Apr 2022 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649554083;
        bh=KYUIDdGadwCWYX1/JBcmj0ypEv2EUIi/0XYJ3YHRYcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiuMcEK/Z6t/pyE3BgZLmvOhtBwX1JfD8Cdj2ZGLQSFPL91Fg+KPeIyBvk5ta5/D0
         X63D7ig1OJRiFd6Y28EL3pI4c/tAUe4h/vCB2dTVywrDJqk+RcvzCBO5DubMHxACbC
         A/a/UthnNPa1WNCk80/oMOFWw6ysQzfdn5YfwwzaobrACqpP/CftTNEbWHoViX1yt4
         TheaD+tA/VJ6Scd2NxQKp/+a6xmIsu/j9zFZIZ4Jy882ETkMwixXLrhzdtfMAevpZ7
         DTnIElRo7BZdAL1qp5UvZIqqs4SxUEBhcs5RrEmdwyCMuuxN0pBmablP42IF3Pwxfn
         XzyPVQNTFtRqg==
Date:   Sun, 10 Apr 2022 09:27:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sandeep Malik <sandeep.malik@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: ls208x: remove NXP Erratum A008585 from
 LS2088A.
Message-ID: <20220410012757.GK129381@dragon>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
 <20220317190109.3742-6-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317190109.3742-6-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:01:09PM -0500, Li Yang wrote:
> From: Pankaj Bansal <pankaj.bansal@nxp.com>
> 
> NXP Erratum A008585 affects A57 core cluster used in LS2085rev1.

s/LS2085rev1/LS2085 rev1

Shawn

> However this problem has been fixed in A72 core cluster used in LS2088.
> Therefore remove the erratum from LS2088A. Keeping it only in LS2085.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Reviewed-by: Sandeep Malik <sandeep.malik@nxp.com>
> Acked-by: Priyanka Jain <priyanka.jain@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 6f6667b70028..a2cadf757148 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -150,3 +150,7 @@ &pcie4 {
>  	ranges = <0x81000000 0x0 0x00000000 0x16 0x00010000 0x0 0x00010000   /* downstream I/O */
>  		  0x82000000 0x0 0x40000000 0x16 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
>  };
> +
> +&timer {
> +	fsl,erratum-a008585;
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 3cb9c21d2775..d823d54a01a5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -239,13 +239,12 @@ map0 {
>  		};
>  	};
>  
> -	timer {
> +	timer: timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
>  			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
>  			     <1 11 4>, /* Virtual PPI, active-low */
>  			     <1 10 4>; /* Hypervisor PPI, active-low */
> -		fsl,erratum-a008585;
>  	};
>  
>  	pmu {
> -- 
> 2.25.1
> 
