Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C24CA954
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiCBPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbiCBPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:44:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A157256421;
        Wed,  2 Mar 2022 07:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DEDBB8207A;
        Wed,  2 Mar 2022 15:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41036C004E1;
        Wed,  2 Mar 2022 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646235832;
        bh=TmvnxBsaIBUo1rh+HLkFLT9be6FT33TNEKEXBh+iG90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9XenydVpDCJIsdnH4ohFLJpQ2tYFwYMF0Drkw2WwbRg+0YI2TX0ZlIq31meoJWsa
         GpE5DLpRR5j3M6HVFeIEtehuq3Hl+gAr7DO9ANbFW91n3ixycocH+JoBq0+v26yJ8x
         KeRVTf8sIn/+AuiAag89d7H18GLdy3yiLgzCV/qaIs85UzXxkRMHu6kDOtPDIe+4Rr
         vjRGeGVC7B9Uik8GHw5JQ0E+czlurNS2qIHJuZRovBagTOme8qnnu7JTFqzn22HZ6g
         m9ag0dvUDCXHLujMkOELkRl3sOTMxP8+dTd8VJnrfMWZJNgGxljDW1hE/ZES1JI0wM
         sY04ndQpkGKVg==
Date:   Wed, 2 Mar 2022 21:13:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 1/3] soundwire: qcom: Add compatible name for v1.6.0
Message-ID: <Yh+Qs6P3pm2mHDjJ@matsya>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646224982-3361-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 18:13, Srinivasa Rao Mandadapu wrote:
> Update compatible string and master data information in soundwire driver
> to support v1.6.0 in lpass sc7280 based platform.

Where is the documentation of this new compatible

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  drivers/soundwire/qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 5481341..fc41210 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1348,6 +1348,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>  static const struct of_device_id qcom_swrm_of_match[] = {
>  	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>  	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
> +	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_5_data },
>  	{/* sentinel */},
>  };
>  
> -- 
> 2.7.4

-- 
~Vinod
