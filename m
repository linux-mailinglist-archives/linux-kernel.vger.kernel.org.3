Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3B5AC84F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 02:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiIEAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEAqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 20:46:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DA23146;
        Sun,  4 Sep 2022 17:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0000AB80E4F;
        Mon,  5 Sep 2022 00:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05496C433C1;
        Mon,  5 Sep 2022 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662338805;
        bh=rXxAoMUzT6IN6nIfQahWEPXVjuD9Sn5HHE6RbrhylFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7YMqL2L7rtMnRb+u6BLY1rL9MUiOwc+7Xlb2jLdavHwXEvgbP0MqFItmwyJygh9G
         H2RfS51i3javKfbjc/IZBX7SHvFevPT4D/YjJcm6HXlWz5tgq+Nm2zNrB6uwAtRWE+
         3Ym/gL9gMwmIvaZKJ2YKOqFmaRwNVQOev6cqN2L6E/zvPJtqO0uwzh8iMP4MaW1ZMa
         Xsq/Wxt0N6Bru1MLhG97JKSgySKhQX9gbJJq0+CBDtgNcRuAI7LxiSnYkRNsBXbqTr
         neRf9ne/Nhynyk0GAFlkp20wng2VeZ7zEUkHayJC0ubQqnlNK4y8I1+fu5H07N8kGa
         2UGN71IfYENMA==
Date:   Mon, 5 Sep 2022 08:46:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sandeep Malik <sandeep.malik@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: ls208x: remove NXP Erratum A008585
 from LS2088A.
Message-ID: <20220905004639.GM1728671@dragon>
References: <20220823234913.30325-1-leoyang.li@nxp.com>
 <20220823234913.30325-6-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823234913.30325-6-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 06:49:13PM -0500, Li Yang wrote:
> From: Pankaj Bansal <pankaj.bansal@nxp.com>
> 
> NXP Erratum A008585 affects A57 core cluster used in LS2085 rev1.
> However this problem has been fixed in A72 core cluster used in LS2088.
> Therefore remove the erratum from LS2088A. Keeping it only in LS2085.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Reviewed-by: Sandeep Malik <sandeep.malik@nxp.com>
> Acked-by: Priyanka Jain <priyanka.jain@nxp.com>

Missing your SoB.

Shawn

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
> index d76f1c42f3fa..f1b9cc8714dc 100644
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
> 2.37.1
> 
