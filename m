Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCC486A30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiAFSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiAFSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:53:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFDC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:53:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v25so3382128pge.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JNS0S6ws0b44uRH/I7fHJUlSoq/HfDftbNx1kWhJBDY=;
        b=C3J72x1eujONqwRMfNpCgBraDBl5F0HTlrDwkyG9dAbOZ7scJAuWZffpVhejkYf9VR
         UpQcWhRIQvduHeJONSD+e14UoZ1WCvIASeYtusK3tPaLvANNBhuKDj0+VLoiPOgMlUuS
         qMshNcLU4baJG+xltNXFhjexyYyFdSfmjZXK+baX7VfgBWvpl0SYtxi8eLu1vtERU6xa
         UG87F3wqoLKtmV46VMsRz7X9SfLMLWadperyd5xdGjJ9QcEXxArShoCdFLIrADyv0UKt
         EQyMtYvu5ggCGiYshY2JTv9iwRhQhbTAmLgf9enVLS/L6Ttk6Gc2EzDmrDpbRa30OZwM
         UahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNS0S6ws0b44uRH/I7fHJUlSoq/HfDftbNx1kWhJBDY=;
        b=4MrZMNRk6wssFJnUdC1JtcissWb2M/g8X2OA48lEpTUlEFwqvI2HMoKRlikBJDGXiD
         nemjbiW9LHCi0PrIRpnt0f7JpsRTt2a+/sh6HwiCIxO+175wJtv7ZP+6DUgwzXjN0Z7u
         nv9NSNLP2edOJ1SxberuyyUa19FfWB8KlQ0R+IO2vfsvnTgsm7rb+CcYehBQsxFfW+td
         AJ2JOYMt2z7hWSbYlQOQLvsScFb8p/xoIwwC0Opwr1A4nhbJqKRWls7v1G7AmAGrpUJD
         eqRst86jKpW+hO7uRcCcBD4STD5fgUKGcg6vDaVafJqDtKvD3XIgrYNOzTYtrZIcPUC6
         jXZA==
X-Gm-Message-State: AOAM530190SJ2kHxrROj1/Di13OH3AWBnCFzn1liUM/eGMm9IT9X9/S4
        L51cTfWYcNoNQ/xD9Uwq5hV3ZQ==
X-Google-Smtp-Source: ABdhPJy6rQHSiSMgrDLVkpo3O/ViA2YSigATsKEr+J9KyotV6Ig/DgyVJF2M7sByf/cSlIP2E9VC6g==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr43522960pgc.287.1641495193133;
        Thu, 06 Jan 2022 10:53:13 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c10sm127881pfl.200.2022.01.06.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:53:11 -0800 (PST)
Date:   Thu, 6 Jan 2022 11:53:09 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH v2 4/6] remoteproc: virtio: Create platform device
 for the remoteproc_virtio
Message-ID: <20220106185309.GC642186@p14s>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
 <20211222082349.30378-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222082349.30378-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:23:47AM +0100, Arnaud Pouliquen wrote:
> Define a platform driver to prepare for the management of
> remoteproc virtio devices as platform devices.
> 
> The platform device allows to pass rproc_vdev_data platform data to
> specify properties that are stored in the rproc_vdev structure.
> 
> Such approach will allow to preserve legacy remoteproc virtio device
> creation but also to probe the device using device tree mechanism.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Update vs previous revision:
>   - Fix commit and rename rproc_vdev_data to rproc_vdev_pdata
> ---
>  drivers/remoteproc/remoteproc_internal.h |  6 +++
>  drivers/remoteproc/remoteproc_virtio.c   | 65 ++++++++++++++++++++++++
>  include/linux/remoteproc.h               |  2 +
>  3 files changed, 73 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index e9e9a551a8c2..6f511c50a15d 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,12 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +struct rproc_vdev_pdata {
> +	u32 rsc_offset;
> +	unsigned int id;
> +	unsigned int index;
> +};
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  int rproc_of_parse_firmware(struct device *dev, int index,
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 51d415744fc6..5f8005caeb6e 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2021 STMicroelectronics
>   *
>   * Ohad Ben-Cohen <ohad@wizery.com>
>   * Brian Swetland <swetland@google.com>
> @@ -13,6 +14,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/remoteproc.h>
>  #include <linux/virtio.h>
> @@ -575,3 +577,66 @@ void rproc_vdev_release(struct kref *ref)
>  
>  	rproc_rvdev_remove_device(rvdev);
>  }
> +
> +static int rproc_virtio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rproc_vdev_pdata *vdev_data = dev->platform_data;
> +	struct rproc_vdev *rvdev;
> +	struct rproc *rproc;
> +
> +	if (!vdev_data)
> +		return -EINVAL;
> +
> +	rvdev = devm_kzalloc(dev, sizeof(*rvdev), GFP_KERNEL);
> +	if (!rvdev)
> +		return -ENOMEM;
> +
> +	rproc = container_of(dev->parent, struct rproc, dev);
> +
> +	rvdev->rsc_offset = vdev_data->rsc_offset;
> +	rvdev->id = vdev_data->id;
> +	rvdev->index = vdev_data->index;
> +
> +	rvdev->pdev = pdev;
> +	rvdev->rproc = rproc;
> +
> +	platform_set_drvdata(pdev, rvdev);
> +
> +	return rproc_rvdev_add_device(rvdev);
> +}
> +
> +static int rproc_virtio_remove(struct platform_device *pdev)
> +{
> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
> +	struct rproc *rproc = rvdev->rproc;
> +	struct rproc_vring *rvring;
> +	int id;
> +
> +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> +		rvring = &rvdev->vring[id];
> +		rproc_free_vring(rvring);
> +	}
> +
> +	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	rproc_unregister_rvdev(rvdev);
> +	dev_dbg(&pdev->dev, "virtio dev %d removed\n",  rvdev->index);
> +

Function rproc_virtio_remove() doesn't do the opposite of rproc_virtio_probe(),
making it hard for people to wrap their head around what is happening.  This may
get cleaned up as part of the error path problem we already talked about...  If not
this is something to improve one.

I am done reviewing this set.

Thanks,
Mathieu

> +	return 0;
> +}
> +
> +/* Platform driver */
> +static const struct of_device_id rproc_virtio_match[] = {
> +	{ .compatible = "rproc-virtio", },
> +	{},
> +};
> +
> +static struct platform_driver rproc_virtio_driver = {
> +	.probe		= rproc_virtio_probe,
> +	.remove		= rproc_virtio_remove,
> +	.driver		= {
> +		.name	= "rproc-virtio",
> +		.of_match_table	= rproc_virtio_match,
> +	},
> +};
> +builtin_platform_driver(rproc_virtio_driver);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..542a3d4664f2 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -616,6 +616,7 @@ struct rproc_vring {
>   * struct rproc_vdev - remoteproc state for a supported virtio device
>   * @refcount: reference counter for the vdev and vring allocations
>   * @subdev: handle for registering the vdev as a rproc subdevice
> + * @pdev: remoteproc virtio platform device
>   * @dev: device struct used for reference count semantics
>   * @id: virtio device id (as in virtio_ids.h)
>   * @node: list node
> @@ -628,6 +629,7 @@ struct rproc_vdev {
>  	struct kref refcount;
>  
>  	struct rproc_subdev subdev;
> +	struct platform_device *pdev;
>  	struct device dev;
>  
>  	unsigned int id;
> -- 
> 2.17.1
> 
