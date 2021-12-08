Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49B46D370
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhLHMn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:43:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE1C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:40:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u17so3890835wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/DBuZhUDRGHeWyIemGFSVWESfZOsYaKYb9NzvIqeyk=;
        b=RFIAPeDp55STzXxu8uXq/Ygb9Pm15wcypmAq856iXatgWal7I6ZSBtslPfz4AzoT1W
         Xf3tbVwUgSYy0wvnr5sLoOQRebmv3rNS9jvRakRQVkxqtCRgbX+OWmVIaj/EmYswqmau
         FyAd3v1cp3Xf+IK2oi/l4UG6qMu41Tpsue92Gndu7AMwQpVN2XUWrAHXdJbP210CVJow
         sR73MVRofqT1xxi02OJbNIXE6zRvUYk5PF5lq4Scdi3mJQ8aUcH9kxIo/QaBJ9vjNlTC
         X4jgwtA+1kuxyKQa0/B4rncfDAsHoQnSAb1F0RzQYtgxIgQoIRJ9zpS7D4f4WvkZxVHT
         SJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K/DBuZhUDRGHeWyIemGFSVWESfZOsYaKYb9NzvIqeyk=;
        b=GJTy/+ou49eE2qN3Do5NQD1WMfkNT6GEuik4mM/oKLK9QF5GhGI9Ln27xqy/B0unuX
         0ed3JXa9gqpwiRmkMUsBqR+8pCpFOJ9WsdGpFP9CXgVhe2d2kI/juKylWQdOyoTvvpXV
         EIc6tsnifSBiQJQ3GnvCaie3tAMtHX3NXlfFAnWVHpBbbytRDKKB9IRnRLzbolpRDtTv
         HiMlIT6X8qciXoPcwCXBvUOFZ0LSGtSw4jQQIzuX9RuB19PjdmVR3qHK4nHAe4UPcw7g
         Tl2VEHhNKqvQmd1KE7ez7Xm2yMv6GSLMLekx84odPt45HVH4AehaZS9jXJXF92pbdgtx
         cCAA==
X-Gm-Message-State: AOAM531S0q7bzAC7W13d/Tyta2/0kOkhf8MlsjqaOU+S2x7I7q9+8H/F
        LNf2yxJN7Oe8glK2w5303CU=
X-Google-Smtp-Source: ABdhPJwF4fWlhWx6371UkgDlh+QrnNifqBx+j+pVkco+bQ0yns1inYtrGkhnzJftDWC5eC3zbb12SQ==
X-Received: by 2002:a5d:6dab:: with SMTP id u11mr58232155wrs.46.1638967222364;
        Wed, 08 Dec 2021 04:40:22 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.199.136])
        by smtp.gmail.com with ESMTPSA id n1sm2767877wmq.6.2021.12.08.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:40:22 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:40:18 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     kuninori.morimoto.gx@renesas.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: test-component: replace of_match_device() to
 of_device_get_match_data()
Message-ID: <20211208124018.GA15923@hamza-OptiPlex-7040>
References: <20211208120526.GA12550@hamza-OptiPlex-7040>
 <20211208123659.15789-1-amhamza.mgc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208123659.15789-1-amhamza.mgc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:36:59PM +0500, Ameer Hamza wrote:
> Getting device data from of_device_get_match_data() for a cleaner
> implementation.
> 
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  sound/soc/generic/test-component.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
> index 8fc97d3ff011..5da4725d9e16 100644
> --- a/sound/soc/generic/test-component.c
> +++ b/sound/soc/generic/test-component.c
> @@ -531,17 +531,13 @@ static int test_driver_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
>  	struct device_node *ep;
> -	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
> -	const struct test_adata *adata;
> +	const struct test_adata *adata = of_device_get_match_data(&pdev->dev);
>  	struct snd_soc_component_driver *cdriv;
>  	struct snd_soc_dai_driver *ddriv;
>  	struct test_dai_name *dname;
>  	struct test_priv *priv;
>  	int num, ret, i;
>  
> -	if (!of_id)
> -		return -EINVAL;
> -	adata = of_id->data;
>  	num = of_graph_get_endpoint_count(node);
>  	if (!num) {
>  		dev_err(dev, "no port exits\n");
> @@ -552,7 +548,7 @@ static int test_driver_probe(struct platform_device *pdev)
>  	cdriv	= devm_kzalloc(dev, sizeof(*cdriv),		GFP_KERNEL);
>  	ddriv	= devm_kzalloc(dev, sizeof(*ddriv) * num,	GFP_KERNEL);
>  	dname	= devm_kzalloc(dev, sizeof(*dname) * num,	GFP_KERNEL);
> -	if (!priv || !cdriv || !ddriv || !dname)
> +	if (!priv || !cdriv || !ddriv || !dname || !adata)
>  		return -EINVAL;
>  
>  	priv->dev		= dev;
> -- 
Hi Kuninori,
Would be really appreciated if you can review the patch please.

Best Regards,
Ameer Hamza.
