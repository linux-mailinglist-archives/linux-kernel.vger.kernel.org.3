Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040750A02B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiDUNC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDUNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A3326F9;
        Thu, 21 Apr 2022 05:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5855F61852;
        Thu, 21 Apr 2022 12:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48642C385A1;
        Thu, 21 Apr 2022 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650545973;
        bh=8803hr6O5mQBudZ27bUhnRG0/mmmQXp3VtHKDzpV0oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yu63/tQTCWNHg+l1Po21sOyavfk0zUQnCi1y5uIVRmlAoNiyrrSjnHw9pDSoeWJpd
         dov3dRWoo9ZHOuhJx0tz+8ARGsv+tR5AjTK+A7QUC6gqcZNMfGMJUNbRGqrys08KmM
         8Cc0Dk9ePNFl2Ji3AQn/xbP0jpJAJxrASxxmZPAzqaj6IVy6X3UTKhrHiPVPuPMOl4
         st+5UEWjVNAzHFqyNY/I2zAhfDloK9ZLPzrzoxxLhGZwp3Sqo0OaGJgY6HMPVXTbjX
         FKhen/SBTqBaFTmSxGt8jQBYiQWiUqbtIeWSmnw+dySQrpOJ0O23YO8jdcbjEKN2O9
         iIrL/vFuY4H+w==
Date:   Thu, 21 Apr 2022 18:29:23 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: Fix can-clock node name
Message-ID: <20220421125923.GA262430@thinkpad>
References: <20220421073502.1824089-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421073502.1824089-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 01:05:02PM +0530, Vinod Koul wrote:
> Per DT spec node names should not have underscores (_) in them, so
> change can_clock to can-clock.
> 
> Fixes: 5c44c564e449 ("arm64: dts: qcom: qrb5165-rb5: Add support for MCP2518FD")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 845eb7a6bf92..0e63f707b911 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -29,7 +29,7 @@ chosen {
>  	};
>  
>  	/* Fixed crystal oscillator dedicated to MCP2518FD */
> -	clk40M: can_clock {
> +	clk40M: can-clock {

Should the node name be just "clock"?

Thanks,
Mani

>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <40000000>;
> -- 
> 2.34.1
> 
