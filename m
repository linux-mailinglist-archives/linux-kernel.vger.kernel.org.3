Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62824679FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381661AbhLCPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381649AbhLCPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF24C061359
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:07:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so12561229eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQ5ApB0ZPIcQi1X7PS6LivqOFWhSDFxReULmsEQ/x1I=;
        b=egVUF4DA/O5x1D7pWspWl98sdEHj87pVaRYAkyyFCFwz2/vknCdCMU6Ciu0W3meLbF
         PBna+ZZk3/po9HfGz+uMyHhzlytjssNW9iteGHXkAsy3a2TqNon9Kw1D2zy7O1BVf2q8
         4zHB+zV6LIPskCJQ4/DFxzAU+T3h6Sod+FL9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQ5ApB0ZPIcQi1X7PS6LivqOFWhSDFxReULmsEQ/x1I=;
        b=pE5KIxi9scCvh34kiUO5JEfWz5WMHYXOKaXLsgmTyzq+K/kXQ+5dfKiQyOAcjfpPAZ
         cScLdIsm+I7XWau02s4z/CP2KXemE22FUEpQDTFTdL6dHQAgQG45bTrn/RcXavYn+Hee
         CpvjVPhBHO/1h3EU69Tj32aqUrFoE6MFpDbZ5b+7bRLPnAnuAsI6qRA88guJ7LAIL3FR
         yHUsI+nWfexH7AzLsGD4C2nzexp60nUF8vyjcKLnJ3CVjf7Cfx8+kG+WClb/IPPAsvZO
         +3cED4itUvaENbd5vFs939wFDtBkLZXgtAFnA+cgFwfxamPQhHh2Qy1Cao941d07bHA3
         fBmg==
X-Gm-Message-State: AOAM531tgnPC0R4bMKROUxxP6eD4paXiPwWa1mWW+8lXeU3zrO9DLkjA
        fHK10bSfPfCaC47wqGeoCpImzw==
X-Google-Smtp-Source: ABdhPJyh2T9bEMe7PD8PXtMt1dLCfoZrdhHTZ4rRB/6mvvvioaUSceTOjrwRRsQ75iP1hljjZDm0OA==
X-Received: by 2002:a50:e18e:: with SMTP id k14mr27491053edl.147.1638544074682;
        Fri, 03 Dec 2021 07:07:54 -0800 (PST)
Received: from gmail.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id gz26sm2106725ejc.100.2021.12.03.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:07:54 -0800 (PST)
Date:   Fri, 3 Dec 2021 16:07:36 +0100
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com,
        irui.wang@mediatek.com
Subject: Re: [PATCH V6, 3/5] media: mtk-jpegenc: add jpegenc timeout func
 interface
Message-ID: <YaoyuAFD8IaSij6S@gmail.com>
References: <1638501230-13417-1-git-send-email-kyrie.wu@mediatek.com>
 <1638501230-13417-4-git-send-email-kyrie.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638501230-13417-4-git-send-email-kyrie.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kyrie.wu wrote:

> Generalizes jpegenc timeout func interfaces to handle HW timeout.

Where do you call schedule_delayed_work() and init hw_param?
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>
> ---
> V6: no change
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h   |  8 ++++++++
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 23 +++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> index 7d013de..baab305 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> @@ -75,6 +75,12 @@ struct mtk_jpeg_variant {
>  	u32 cap_q_default_fourcc;
>  };
>  
> +struct mtk_jpeg_hw_param {
> +	struct vb2_v4l2_buffer *src_buffer;
> +	struct vb2_v4l2_buffer *dst_buffer;
> +	struct mtk_jpeg_ctx *curr_ctx;
> +};
> +
>  enum mtk_jpegenc_hw_id {
>  	MTK_JPEGENC_HW0,
>  	MTK_JPEGENC_HW1,
> @@ -122,6 +128,8 @@ struct mtk_jpegenc_comp_dev {
>  	struct mtk_jpeg_dev *master_dev;
>  	struct mtk_jpegenc_pm pm;
>  	int jpegenc_irq;
> +	struct delayed_work job_timeout_work;
> +	struct mtk_jpeg_hw_param hw_param;
>  };
>  
>  /**
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> index 4ccda1d..e62b875 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> @@ -183,6 +183,24 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
>  	writel(ctx->restart_interval, base + JPEG_ENC_RST_MCU_NUM);
>  }
>  
> +static void mtk_jpegenc_timeout_work(struct work_struct *work)
> +{
> +	struct delayed_work *Pwork =
> +		container_of(work, struct delayed_work, work);
Please use to_delayed_work()
> +	struct mtk_jpegenc_comp_dev *cjpeg =
> +		container_of(Pwork, struct mtk_jpegenc_comp_dev,
> +		job_timeout_work);
> +	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> +	struct vb2_v4l2_buffer *src_buf;
> +
> +	src_buf = cjpeg->hw_param.src_buffer;
> +
> +	mtk_jpeg_enc_reset(cjpeg->reg_base);
> +	clk_disable_unprepare(cjpeg->pm.venc_clk.clk_info->jpegenc_clk);
> +	pm_runtime_put(cjpeg->pm.dev);
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +}
> +
>  static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>  {
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> @@ -194,6 +212,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>  	struct mtk_jpegenc_comp_dev *jpeg = priv;
>  	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
>  
> +	cancel_delayed_work(&jpeg->job_timeout_work);
Isn't here a race condition is the delayed work is being exectuted?
> +
>  	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>  		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>  	if (irq_status)
> @@ -322,6 +342,9 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
>  
>  	dev->plat_dev = pdev;
>  
> +	INIT_DELAYED_WORK(&dev->job_timeout_work,
> +		mtk_jpegenc_timeout_work);
> +
>  	ret = mtk_jpegenc_init_pm(dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to get jpeg enc clock source");
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
