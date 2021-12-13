Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821FE4737E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhLMWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbhLMWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:47:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0094C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:47:47 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso19040302ots.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5H0qbzaIjgpKRl661XZSUbngEcJPf590BIus7cp6ncA=;
        b=R8VoYyyDTSEuy9f0P5FaPR1C53Xu7aozxo+dMc2TKIiQHU8WDK78rkYLFGz2W9PvW7
         Rc6ms+egFX7SkYxyk7zzCTGkoqVk2nv4iJcBSAVQj1h8PBYGZW8JwRQJdKGgD8Phe932
         KV+utJuCmcnQ+tcsjSsktrHTtmEtTFAqyiYB9vzPdDOXCru6cQ6mPlh836V1XKUKnDqh
         SWcROoMM2fPmQt51gazWdN+qK6SYOMXNj+hYfjdhxrdV+6XREu1aVl6wOX68d3Yj2D4L
         +b1zOkEAWEoX/dF7bR6efzQ6uCVkvOcDlAzh8/KQIUx1KIdaiFUSMNQm3qSSXPga45Nr
         p1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5H0qbzaIjgpKRl661XZSUbngEcJPf590BIus7cp6ncA=;
        b=MPZJLmuuDGpB66uX/8XeqfqHPWVCMpGsiJKRVMlBg3qQOlttjl6FYwmGsz6CrfiTts
         YoYroTOgSnjjRRABsBWRiwBxHItNKBsPt1KOHF5CleWKqIJV7sP1sTWW4NXBIpp+gStA
         SaF27yWkQT3KzXoUh6UjgueCrTtPaXFpgfTJDh6HsQzSwC2e0ywHJ+5URKjCRJqzTSMJ
         BVSNqy1tfeL0xauJnsUltPw5dasfOORhacz9qO0bMSEXvAjP32NlTFrWylSzwwwMc53o
         ikviImm0F8dDMPCmf+Lxkgf/e7IkyUi65bNKMAK32HMF6O1qTVJwDzQhy75fwbbd7+Qs
         YTKw==
X-Gm-Message-State: AOAM5339g6J8fgX8j7aSSa9Lvfx9rtNiuGAKL48dTbFvvIRBPxtRcRi+
        pqRuwrwMJTYsoTRa1OM/omWX/Q==
X-Google-Smtp-Source: ABdhPJxwfsPGVsS6Hn+ISBirM7ASf+Uy53iWfLYPVPoMDB+x0HE6I2kdL1NxQdLYbPLt8fOLBERuOw==
X-Received: by 2002:a9d:6254:: with SMTP id i20mr1172374otk.343.1639435667299;
        Mon, 13 Dec 2021 14:47:47 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm2473150oth.81.2021.12.13.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:47:46 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:47:42 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: qcom-qmp: Add SM8450 USB QMP PHYs
Message-ID: <YbfNji+glICLDy76@builder.lan>
References: <20211213131450.535775-1-vkoul@kernel.org>
 <20211213131450.535775-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131450.535775-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13 Dec 07:14 CST 2021, Vinod Koul wrote:

> Add support for the USB DP & UNI PHYs found on SM8450. This is same as
> the phy version used on SM8350 and sequences turned out to be same, so
> use the same table from SM8350 for this as well.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index a959c97a699f..13a249ec8ab6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -5777,6 +5777,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sm8450-qmp-ufs-phy",
>  		.data = &sm8450_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm8450-qmp-usb3-phy",
> +		.data = &sm8350_usb3phy_cfg,
>  	}, {
>  		.compatible = "qcom,qcm2290-qmp-usb3-phy",
>  		.data = &qcm2290_usb3phy_cfg,
> -- 
> 2.31.1
> 
