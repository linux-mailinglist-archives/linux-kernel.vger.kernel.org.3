Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337D4B0F04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbiBJNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:44:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242345AbiBJNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2745CF1;
        Thu, 10 Feb 2022 05:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F322B82555;
        Thu, 10 Feb 2022 13:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A894C004E1;
        Thu, 10 Feb 2022 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644500695;
        bh=gl0+6aw+lns7XJcPqkrOFcOcJKBydkHbo45rLX/aLu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzWJBcPSdHJav8ESBtDWRGgsGrvgx3gzxmoITK1aRaOhOsu4U9kXdgEIl/c1skYCM
         VTY9bVliMe99PmzPaQ7PXTl8vpMzSpwB4Lrm9bpShJiUnaMH8jSPgZgNGqmCsKBViU
         d0TAtMMvrYMLimEg2iv8/K//IMLPlFuvw+Q6vYqTPV3yRVeeiLHL2ZFLNLctpPHsF0
         K03K3I13SxxH2FCqmF834PfHV4bFUuKbSXgwul151kkylqL7gGrI9jimL5rj2aUoXA
         knNmJAfA0Ftm/cO/GvDbNIaH/lyWvuldVb4fTeZEJwnVcyug1/D5sIqYILNLieLMet
         q60Kl68rTfCHw==
Date:   Thu, 10 Feb 2022 19:14:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add some more PMICs and SoCs
Message-ID: <YgUW0SrMgIKWGdqL@matsya>
References: <20220210051043.748275-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210051043.748275-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-22, 21:10, Bjorn Andersson wrote:
> Add SM8350, SC8280XP, SA8540P and one more SM8450 and various PMICs
> found on boards on these platforms to the socinfo driver.

This fixes the unknown ids reported by socinfo debugfs for SM8450 HDK

Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>


> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 6dc0f39c0ec3..8b38d134720a 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -104,6 +104,14 @@ static const char *const pmic_models[] = {
>  	[36] = "PM8009",
>  	[38] = "PM8150C",
>  	[41] = "SMB2351",
> +	[47] = "PMK8350",
> +	[48] = "PM8350",
> +	[49] = "PM8350C",
> +	[50] = "PM8350B",
> +	[51] = "PMR735A",
> +	[52] = "PMR735B",
> +	[58] = "PM8450",
> +	[65] = "PM8010",
>  };
>  #endif /* CONFIG_DEBUG_FS */
>  
> @@ -314,10 +322,14 @@ static const struct soc_id soc_id[] = {
>  	{ 422, "IPQ6010" },
>  	{ 425, "SC7180" },
>  	{ 434, "SM6350" },
> +	{ 439, "SM8350" },
> +	{ 449, "SC8280XP" },
>  	{ 453, "IPQ6005" },
>  	{ 455, "QRB5165" },
>  	{ 457, "SM8450" },
>  	{ 459, "SM7225" },
> +	{ 460, "SA8540P" },
> +	{ 480, "SM8450" },
>  };
>  
>  static const char *socinfo_machine(struct device *dev, unsigned int id)
> -- 
> 2.33.1

-- 
~Vinod
