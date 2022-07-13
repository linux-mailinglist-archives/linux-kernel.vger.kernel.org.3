Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA27573956
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiGMOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGMOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC02C137;
        Wed, 13 Jul 2022 07:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7988B81FE9;
        Wed, 13 Jul 2022 14:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91075C34114;
        Wed, 13 Jul 2022 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657724109;
        bh=JCMYOgHh13djCFYUsT9i7vQJW/izMROu+WExt6XiksM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sh9Vm/8qzC+3J8KYmo88DnArQlq83EnPu/SDu4obxrL+KAPcxaIOhNARrWTO1NHnf
         qvbZiuj5anW6FGOQ4Nu1DcUDPGe/XYo/8+XyjQ2+/d9Bzu3gIZ/xgZIkrxEEGCI6hj
         psahT4LXR3jHYuZmWoIzkrf50H/Qb4cF4mM6Hi0wPoQuweejEY+cH3NHj68qKjW9Fb
         AMGnJ4sd9Nw5TFy0lhG7/D5U1K64IDI7xEjwDUj0Ngy1Qsh1D6M96CEeK8T9+y9Dd/
         nl97BFeBHHoSVWBqLjXSaCF8sXMvYb0A76rBgsbGInywO7hSSyQ8SvLR8r2swMQAfl
         IBIDjZa7xzu/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBdlg-0001Fm-Di; Wed, 13 Jul 2022 16:55:13 +0200
Date:   Wed, 13 Jul 2022 16:55:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
Message-ID: <Ys7c0JGAV7AAEjaO@hovoldconsulting.com>
References: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:04:29PM +0530, Manivannan Sadhasivam wrote:
> PPI interrupt should be 7 for the PMU.
> 
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Reported-by: Steve Capper <Steve.Capper@arm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 268ab423577a..2d7823cb783c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -477,7 +477,7 @@ memory@80000000 {
>  
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
> -		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	psci {

The interrupt number matches the vendor devicetree I have access to, but
the vendor source also has IRQ_TYPE_LEVEL_LOW instead of
IRQ_TYPE_LEVEL_HIGH here.

Is that another copy-paste error, perhaps?

Johan
