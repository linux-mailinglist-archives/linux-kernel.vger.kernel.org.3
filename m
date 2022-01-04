Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41E48484D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiADTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiADTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:08:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A0C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:08:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w7so27172802plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQF+XH6V3kVHXWMXV3EqI1J84nIsrn1qXMCyxHnZTsc=;
        b=FiB1DfbLLjQ29EVkKGbeCeHRekDd/OS5bBExr6rJx7COnYOge7ZEpfxupcxx5TqM4/
         loCsJHdeShJSN0TTKrNk0O/MedFHbumhWmFnidhP6D2gW6t+gOiipwKILPj29DdHKHci
         w6+yJaBBExlOwHKk9R8QIZCr6xNjFB+LSp8YcoAPNb/hkI3YEFArKh6XxoqLouzdHZfj
         7UDna6l9NTPRmT3xuwNHagpxn9IrKt01pBMyHd22sJdPKTHiRIWj6B94Y86HEl41HQBH
         UwkQ9WR8bJwPd7ixBptosHbjI0DO6Iivoq+eb+UePncHwXZX8X52EOYAPtG1oJVabPNj
         oLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQF+XH6V3kVHXWMXV3EqI1J84nIsrn1qXMCyxHnZTsc=;
        b=GaDOMDE4IukCMWVhGeL1XezpVzSc4zHN5u1jXnoNDxYqoPhm0WqktU+FpnTFrqxqFU
         7UEX1f0pLz45/UJXm/eGxJ7bNzjTCH4QzpTtK8n6+taz3hekOwGbgSk68n1HI4Yz3LfN
         52lTuQEf/dhBzbRE6OIEiUcCVMDgJmXR/wMWfln8dg2+Pi+QHELkQ8XVP/QMddP8/2Ee
         HRRA6lUoej12xia4SwrU8s51pI6ivafPA/mVZa9x/5CkUZ192ofQZEOsSCG69rYkS8IL
         hxNpT7WwNkIFkCx8mpKvwUJnYNFQXOHAYXl2OAWANnb4tFZ6JlZ6TZV6OMm07WeWNI0q
         FdHQ==
X-Gm-Message-State: AOAM530mD5uhTpYDVHFhP+vAxp/C6PZQeh+S4U27j2ke9ZEbM83URYEQ
        40XIfw5HeCXxgQAE9YWmcv2Tqg==
X-Google-Smtp-Source: ABdhPJw+rINow93orCEPCmEtD0MDuQgTEqcobjcf4Rhbdbw1tMT0NIZjbrecupBcM9PPml8ExcaUEA==
X-Received: by 2002:a17:90b:4d8c:: with SMTP id oj12mr62468509pjb.11.1641323293874;
        Tue, 04 Jan 2022 11:08:13 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h4sm499390pjk.2.2022.01.04.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:08:12 -0800 (PST)
Date:   Tue, 4 Jan 2022 12:08:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH v2 1/6] remoteproc: core: Introduce virtio device
 add/remove functions
Message-ID: <20220104190810.GB540353@p14s>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
 <20211222082349.30378-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222082349.30378-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Wed, Dec 22, 2021 at 09:23:44AM +0100, Arnaud Pouliquen wrote:
> In preparation of the migration of the management of rvdev in
> remoteproc_virtio.c, this patch spins off new functions to manage the
> remoteproc virtio device.
> 
> The rproc_rvdev_add_device and rproc_rvdev_remove_device will be
> moved to remoteproc_virtio.c.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> update vs previous revision:
>  - update according to the rebase from v15-rc1 to v16-rc1
>  - split patch to introduce rproc_register_rvdev and rproc_unregister_rvdev
>    function in a separate patch
> ---
>  drivers/remoteproc/remoteproc_core.c | 94 +++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..d1f1c5c25bd7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -484,6 +484,61 @@ static int copy_dma_range_map(struct device *to, struct device *from)
>  	return 0;
>  }
>  
> +static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
> +{
> +	struct rproc *rproc = rvdev->rproc;
> +	char name[16];
> +	int ret;
> +
> +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> +	rvdev->dev.parent = &rproc->dev;
> +	rvdev->dev.release = rproc_rvdev_release;
> +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> +	dev_set_drvdata(&rvdev->dev, rvdev);
> +
> +	ret = device_register(&rvdev->dev);
> +	if (ret) {
> +		put_device(&rvdev->dev);
> +		return ret;
> +	}

Registering the device here is a problem...  If device_register() fails
put_device() is called and we return, only to call device_unregister() on the
same device in rproc_handle_vdev(). 

Moreover in rproc_handle_vdev(), device_unregister() is called in the error
path but device_register() is called here in rproc_rvdev_add_device().  This
introduces coupling between the two functions, making it hard to maintain from
hereon.

I suggest calling device_register() in rproc_handle_vdev() after
rproc_rvdev_add_device() has returned successfully. 

More comments to come tomorrow.

Thanks,
Mathieu

> +	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> +	if (ret)
> +		goto free_rvdev;
> +
> +	/* Make device dma capable by inheriting from parent's capabilities */
> +	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> +
> +	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> +					   dma_get_mask(rproc->dev.parent));
> +	if (ret) {
> +		dev_warn(&rvdev->dev,
> +			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> +			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> +	}
> +
> +	list_add_tail(&rvdev->node, &rproc->rvdevs);
> +
> +	rvdev->subdev.start = rproc_vdev_do_start;
> +	rvdev->subdev.stop = rproc_vdev_do_stop;
> +
> +	rproc_add_subdev(rproc, &rvdev->subdev);
> +
> +	return 0;
> +
> +free_rvdev:
> +	device_unregister(&rvdev->dev);
> +	return ret;
> +}
> +
> +static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> +{
> +	struct rproc *rproc = rvdev->rproc;
> +
> +	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	list_del(&rvdev->node);
> +	device_unregister(&rvdev->dev);
> +}
> +
>  /**
>   * rproc_handle_vdev() - handle a vdev fw resource
>   * @rproc: the remote processor
> @@ -519,7 +574,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	struct device *dev = &rproc->dev;
>  	struct rproc_vdev *rvdev;
>  	int i, ret;
> -	char name[16];
>  
>  	/* make sure resource isn't truncated */
>  	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> @@ -553,34 +607,10 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev->rproc = rproc;
>  	rvdev->index = rproc->nb_vdev++;
>  
> -	/* Initialise vdev subdevice */
> -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> -	rvdev->dev.parent = &rproc->dev;
> -	rvdev->dev.release = rproc_rvdev_release;
> -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> -	dev_set_drvdata(&rvdev->dev, rvdev);
> -
> -	ret = device_register(&rvdev->dev);
> -	if (ret) {
> -		put_device(&rvdev->dev);
> -		return ret;
> -	}
> -
> -	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
> +	ret = rproc_rvdev_add_device(rvdev);
>  	if (ret)
>  		goto free_rvdev;
>  
> -	/* Make device dma capable by inheriting from parent's capabilities */
> -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> -
> -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> -					   dma_get_mask(rproc->dev.parent));
> -	if (ret) {
> -		dev_warn(dev,
> -			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> -			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> -	}
> -
>  	/* parse the vrings */
>  	for (i = 0; i < rsc->num_of_vrings; i++) {
>  		ret = rproc_parse_vring(rvdev, rsc, i);
> @@ -598,13 +628,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  			goto unwind_vring_allocations;
>  	}
>  
> -	list_add_tail(&rvdev->node, &rproc->rvdevs);
> -
> -	rvdev->subdev.start = rproc_vdev_do_start;
> -	rvdev->subdev.stop = rproc_vdev_do_stop;
> -
> -	rproc_add_subdev(rproc, &rvdev->subdev);
> -
>  	return 0;
>  
>  unwind_vring_allocations:
> @@ -619,7 +642,6 @@ void rproc_vdev_release(struct kref *ref)
>  {
>  	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
>  	struct rproc_vring *rvring;
> -	struct rproc *rproc = rvdev->rproc;
>  	int id;
>  
>  	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> @@ -627,9 +649,7 @@ void rproc_vdev_release(struct kref *ref)
>  		rproc_free_vring(rvring);
>  	}
>  
> -	rproc_remove_subdev(rproc, &rvdev->subdev);
> -	list_del(&rvdev->node);
> -	device_unregister(&rvdev->dev);
> +	rproc_rvdev_remove_device(rvdev);
>  }
>  
>  /**
> -- 
> 2.17.1
> 
