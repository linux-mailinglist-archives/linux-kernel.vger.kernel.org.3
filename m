Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BA52106D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiEJJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiEJJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:19:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0627305B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BFF1B81BA0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7A5C385C6;
        Tue, 10 May 2022 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652174107;
        bh=lM1+kE2QV8SlVYSZWkGmJrEU/HzkPtLQjdJHnR4KYu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8LF3JKBuJRLKsFvx7XvcUsCwUJusV8PespA1LrHkio2FVm+3BVY7wPYDHj+StSAB
         scsZV6L9Zc8u1VZVYG16qZ4p3uPuGT8ssDiLC3aeJj+ZD+hrXPV7WDJr3dv/xekv3R
         KC4RdAewZBHknjp9xY7ALPpsyADhFOUHtYqbhNSNeOV5iYwyoFZ7LlQjmJgKuc6LsE
         333y1RjUgDlGN/Nga5Nh8MnZLla4lL+p0kajJmxksHAi0IOoEbXxHIA8oMNM4yyBDu
         honuZo2E/Bjp/t7JrN5Lq7e+eUBKHxJtk3rc4T7R3IzISWhaYNZ7UKG1HZF1qdWWeZ
         5CKQFReH2XFHA==
Date:   Tue, 10 May 2022 10:15:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
Message-ID: <20220510091502.GA27219@willie-the-truck>
References: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:40:30PM +0200, Geert Uytterhoeven wrote:
> The help text for the config option to enable support for the ARM
> Scalable Matrix Extension does not mention the specification baseline
> for this extension.  Make it clear this is an extension for the ARMv9-A
> architecture, so users know when it is safe to disable this option,
> which is enabled by default.
> 
> Fixes: a1f4ccd25cc25625 ("arm64/sme: Provide Kconfig for SME")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0e9bbeb1262d0ca8..f3a0d0cff3fb5265 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1964,9 +1964,9 @@ config ARM64_SME
>  	default y
>  	depends on ARM64_SVE
>  	help
> -	  The Scalable Matrix Extension (SME) is an extension to the AArch64
> -	  execution state which utilises a substantial subset of the SVE
> -	  instruction set, together with the addition of new architectural
> +	  The Scalable Matrix Extension (SME) is an ARMv9-A extension to the
> +	  AArch64 execution state which utilises a substantial subset of the
> +	  SVE instruction set, together with the addition of new architectural

Why is this useful information? The v9 vs v8 distinction is purely a
marketing thing, so I'd be _very_ wary of drawing any technical conclusions
based on that, especially as Arm have a track record for "backporting"
features into older CPUs if there is demand for it. Do you know what the
toolchains have done here? (i.e. is there march=armv9-a or can you do
march=armv8-a+sme or something else?).

Having said all that, we do already have the Kconfig menu entries for "Armv8.x
architectural features", so adding one for "Armv9" would be consistent with
that if you really want it.

Will
