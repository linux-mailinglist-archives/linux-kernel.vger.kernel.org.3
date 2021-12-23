Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052AE47E76C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349692AbhLWSFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbhLWSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:05:34 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073DC061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:05:34 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so7341542oti.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1v9L4T41CwGiy712+i5FQLKiko4j+O1n9FYDtFOGNoU=;
        b=HlaIv8e1qvy3wsrLeReJQH7FO3DX7fYc9QBZELRfuyUC3iXhmiKK4jQVo9DdDR2oJ4
         GQNzKJCYCvExKUR3XcrkynxEszSZfANE3EBSZh/UjavaUaU923nbFDIkwYDPehTu9LRf
         3H8DP5U69BGoqRdO+iC0KJdbYXvA1S+HsNM87VhuLf/uQ89QHTyNQZRa7j54lSVS/9Zr
         wZc+YLl2Nm0bz5EE9p1mWVb5etdPQCopOCnwAc5Ry+U9jYjosyI4heA9loyfFZJLil/b
         dh2m+PEZa3sLFbSjRXd9Oy1ekmpPiVV4Ke6MnmtaNH7zSkKeRj/VZezpe0edjLhRDWcd
         Ty3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1v9L4T41CwGiy712+i5FQLKiko4j+O1n9FYDtFOGNoU=;
        b=EEMLL2bSGmH2aWZ/va471BrqnybJg2WYXuWSYmerzIja7Kb6dQn7TCn9GP6fLPPT8H
         1730MXcwP5/94Oddj9QhROyNI1y/ldgLzAaYSCg0dlYlXzIxwR5areL4hlcGgSqB9p1C
         R7h08GBPOOK3pP2FrgRUrXWg/3VKyeSgrEE17usMyPMRKpb5bOpqUvtMbD2wlO68dZ25
         kk8eUhXHe6WNyEB2L2TykSyDpi/Qo2MLqzCcHWt13b93vAoKoMGoy1aEZO6n6v4p7Q23
         frjRJPtSPXu5XG3WAK2HFuDMDcTydXGp5mixTFlbtVqw3ZXM3NEml2xiJePvVmEV0ypD
         Mbaw==
X-Gm-Message-State: AOAM530cbcvwJ0+ZpkFGRQIi7IgdLRFkaJ4tlOW+rBxVFl6oE3ago1us
        lWy3/js7BH/7P3emxpGuNnYK7w==
X-Google-Smtp-Source: ABdhPJwMf+E+xKIgFWu/fxvD3O6pjtvJtMAtY6YGFU6Mx+dbyzCPksk6IqLrnj00vlCR48AzuMzEHg==
X-Received: by 2002:a05:6830:43aa:: with SMTP id s42mr2201594otv.118.1640282733237;
        Thu, 23 Dec 2021 10:05:33 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x4sm1168770oiv.35.2021.12.23.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:05:32 -0800 (PST)
Date:   Thu, 23 Dec 2021 10:06:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-media@vger.kernel.org, Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/13] media: camss: Use platform_get_irq_byname() to get
 the interrupt
Message-ID: <YcS6rl+dFqhH7giF@ripper>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223173015.22251-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Dec 09:30 PST 2021, Lad Prabhakar wrote:

> platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_byname().
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/media/platform/qcom/camss/camss-csid.c   | 12 ++++--------
>  drivers/media/platform/qcom/camss/camss-csiphy.c | 12 ++++--------
>  drivers/media/platform/qcom/camss/camss-ispif.c  | 12 ++++--------
>  drivers/media/platform/qcom/camss/camss-vfe.c    | 12 ++++--------
>  4 files changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index a1637b78568b..ac3504e98668 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -544,7 +544,6 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
>  {
>  	struct device *dev = camss->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource *r;
>  	int i, j;
>  	int ret;
>  
> @@ -571,14 +570,11 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
>  
>  	/* Interrupt */
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> -					 res->interrupt[0]);
> -	if (!r) {
> -		dev_err(dev, "missing IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
> +	if (ret < 0)
> +		return ret;
>  
> -	csid->irq = r->start;
> +	csid->irq = ret;
>  	snprintf(csid->irq_name, sizeof(csid->irq_name), "%s_%s%d",
>  		 dev_name(dev), MSM_CSID_NAME, csid->id);
>  	ret = devm_request_irq(dev, csid->irq, csid->ops->isr,
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 24eec16197e7..6b225d06f35a 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -568,7 +568,6 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  {
>  	struct device *dev = camss->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource *r;
>  	int i, j;
>  	int ret;
>  
> @@ -611,14 +610,11 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  
>  	/* Interrupt */
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> -					 res->interrupt[0]);
> -	if (!r) {
> -		dev_err(dev, "missing IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
> +	if (ret < 0)
> +		return ret;
>  
> -	csiphy->irq = r->start;
> +	csiphy->irq = ret;
>  	snprintf(csiphy->irq_name, sizeof(csiphy->irq_name), "%s_%s%d",
>  		 dev_name(dev), MSM_CSIPHY_NAME, csiphy->id);
>  
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
> index ba5d65f6ef34..4ee11bb979cd 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -1100,7 +1100,6 @@ int msm_ispif_subdev_init(struct camss *camss,
>  	struct device *dev = camss->dev;
>  	struct ispif_device *ispif = camss->ispif;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource *r;
>  	int i;
>  	int ret;
>  
> @@ -1153,14 +1152,11 @@ int msm_ispif_subdev_init(struct camss *camss,
>  
>  	/* Interrupt */
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res->interrupt);
> -
> -	if (!r) {
> -		dev_err(dev, "missing IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = platform_get_irq_byname(pdev, res->interrupt);
> +	if (ret < 0)
> +		return ret;
>  
> -	ispif->irq = r->start;
> +	ispif->irq = ret;
>  	snprintf(ispif->irq_name, sizeof(ispif->irq_name), "%s_%s",
>  		 dev_name(dev), MSM_ISPIF_NAME);
>  	if (camss->version == CAMSS_8x16)
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 71f78b40e7f5..7c2311d70546 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1279,7 +1279,6 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  {
>  	struct device *dev = camss->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource *r;
>  	int i, j;
>  	int ret;
>  
> @@ -1312,14 +1311,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  
>  	/* Interrupt */
>  
> -	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> -					 res->interrupt[0]);
> -	if (!r) {
> -		dev_err(dev, "missing IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
> +	if (ret < 0)
> +		return ret;
>  
> -	vfe->irq = r->start;
> +	vfe->irq = ret;
>  	snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
>  		 dev_name(dev), MSM_VFE_NAME, vfe->id);
>  	ret = devm_request_irq(dev, vfe->irq, vfe->ops->isr,
> -- 
> 2.17.1
> 
