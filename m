Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B03473C99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhLNFeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhLNFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:34:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E36611D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68087C34604;
        Tue, 14 Dec 2021 05:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639460044;
        bh=9rP6/NwG9+Y+r5x7C89m1LeZ5qQeGVNQ1b/LnZFs5m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7y1hVLjZijfJ23DLpRp0wafZQkd4XfhnLl3aVjJIi/RuG51lfrxEieiaTZUB4YOW
         MIz22u5ikyUrOYW1dEK3MwJWq5Q2ArM3dF/0Qk7jlF37xMazNLtGV96VI37dSi3Qnr
         NO7yFfDWXDPoZEPhQqiH7mIhAIajQLhR2SmUZZxiaRT6mJp2ps58SKRgQYUSoW+eS3
         onYwZ0XGxnWqzERYvSzXxFzVSO1O3jf64WdANCCH38E9jgGjc5SmP8h8yXn2cr5xFU
         xlKI6DK+8afantkQ9J4LihCrutc21yNGIkt26w8e8nlO32eMs+b5l/bF3g7hh8r32s
         ZdAvsls6QkrcQ==
Date:   Tue, 14 Dec 2021 13:33:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: Re: [PATCH v2 01/10] arm64: dts: lx2160a: fix scl-gpios property name
Message-ID: <20211214053357.GE10916@dragon>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
 <20211203235446.8266-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203235446.8266-2-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:54:37PM -0600, Li Yang wrote:
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Fix the typo in the property name.
> 
> Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Shouldn't we have a Fixes tag?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index dc8661ebd1f6..2433e6f2eda8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -719,7 +719,7 @@ i2c0: i2c@2000000 {
>  			clock-names = "i2c";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
> +			scl-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
>  			status = "disabled";
>  		};
>  
> @@ -768,7 +768,7 @@ i2c4: i2c@2040000 {
>  			clock-names = "i2c";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(16)>;
> -			scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
> +			scl-gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.25.1
> 
