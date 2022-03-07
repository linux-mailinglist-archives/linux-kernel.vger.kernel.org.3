Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69A4CF3E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiCGIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCGIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:45:14 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD06381BF;
        Mon,  7 Mar 2022 00:44:19 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22776UZi023274;
        Mon, 7 Mar 2022 09:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=q9vM+JTYnx7Hnl3JnWzbyAG0hwnKWXbo3MEu8bb1W/o=;
 b=axWHiPoiuWUzK8puQBCEcFwL6CoEXefL8RWgug0VGVv0e5A9Bvb2Uz9dzQWzezmliMRe
 QCc+QkUF99wvNCoCVw+qcQ2k2dL2uwBuJBr78jxAMs8uoXfWz2TK8mZ3bOIHLrJufG2M
 KW6DJbTwcNlB1zJZClYejDTa64I5X/b6SyO4I4yeSB8vOTLnNIDCqNQb/xOINGipoiSg
 NTzlYvC/PWGmH6EuiWfPHMnPclf4XgH6VWwtCEu90yqg7UltMDSOHWLdxktdbqA23rIW
 S42vFtF+rguokhOD6SdVGJycbPz67BQzTU21d2CznV8fpTWHtxHzPV/EYvo8hatw2aB4 hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ekymm0yux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 09:44:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F55110002A;
        Mon,  7 Mar 2022 09:44:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F74E21514B;
        Mon,  7 Mar 2022 09:44:04 +0100 (CET)
Received: from [10.211.3.43] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 7 Mar
 2022 09:44:03 +0100
Message-ID: <bb45f3c7-69de-c5f2-65d9-c36e574d3d8b@foss.st.com>
Date:   Mon, 7 Mar 2022 09:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 4/4] remoteproc: virtio: Create platform device for
 the remoteproc_virtio
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
 <20220126162405.1131323-5-arnaud.pouliquen@foss.st.com>
 <20220304185308.GD1660165@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220304185308.GD1660165@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 3/4/22 19:53, Mathieu Poirier wrote:
> On Wed, Jan 26, 2022 at 05:24:05PM +0100, Arnaud Pouliquen wrote:
>> Define a platform driver to manage the remoteproc virtio device as
>> a platform devices.
>>
>> The platform device allows to pass rproc_vdev_data platform data to
>> specify properties that are stored in the rproc_vdev structure.
>>
>> Such approach will allow to preserve legacy remoteproc virtio device
>> creation but also to probe the device using device tree mechanism.
>>
>> remoteproc_virtio.c update:
>>   - Add rproc_virtio_driver platform driver. The probe/remove ops replace
>>     the rproc_rvdev_add_device/rproc_rvdev_remove_device functions.
>>   - All reference to the rvdev->dev has been updated to rvdev-pdev->dev.
>>   - rproc_rvdev_release is removed as associated to the rvdev device.
>>   - The use of rvdev->kref counter is replaced by get/put_device on the
>>     remoteproc virtio platform device.
>>   - The vdev device no longer increments rproc device counter.
>>     increment/decrement is done in rproc_virtio_probe/rproc_virtio_remove
>>     function in charge of the vrings allocation/free.
>>
>> remoteproc_core.c update:
>>   Migrate from the rvdev device to the rvdev platform device.
>>   From this patch, when a vdev resource is found in the resource table
>>   the remoteproc core register a platform device.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Update vs previous revision:
>>   - squash following two patches
>>     - [4/6] remoteproc: virtio: Create platform device for the remoteproc_virtio
>>       https://lkml.org/lkml/2021/12/22/112
>>     - [6/6] remoteproc: Instantiate the new remoteproc virtio platform device
>>       https://lkml.org/lkml/2021/12/22/114
>> ---
>>  drivers/remoteproc/remoteproc_core.c     |  23 +++-
>>  drivers/remoteproc/remoteproc_internal.h |   3 -
>>  drivers/remoteproc/remoteproc_virtio.c   | 151 +++++++++++------------
>>  include/linux/remoteproc.h               |   6 +-
>>  4 files changed, 93 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index eb6b43b71c2b..5b864c9c6244 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -467,6 +467,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>>  	struct device *dev = &rproc->dev;
>>  	struct rproc_vdev *rvdev;
>>  	struct rproc_vdev_data rvdev_data;
>> +	struct platform_device *pdev;
>>  
>>  	/* make sure resource isn't truncated */
>>  	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
>> @@ -495,9 +496,23 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>>  	rvdev_data.rsc_offset = offset;
>>  	rvdev_data.rsc = rsc;
>>  
>> -	rvdev = rproc_rvdev_add_device(rproc, &rvdev_data);
>> -	if (IS_ERR(rvdev))
>> -		return PTR_ERR(rvdev);
>> +	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
>> +					     sizeof(rvdev_data));
>> +	if (IS_ERR(pdev)) {
>> +		dev_err(rproc->dev.parent,
>> +			"failed to create rproc-virtio device\n");
>> +		return PTR_ERR(pdev);
>> +	}
>> +
>> +	/*
>> +	 * At this point the registered remoteproc virtio platform device should have been probed.
>> +	 * Get the associated rproc_vdev struct to assign the vrings.
>> +	 */
>> +	rvdev = platform_get_drvdata(pdev);
>> +	if (!rvdev) {
>> +		platform_device_unregister(pdev);
>> +		return -EINVAL;
>> +	}
> 
> I can't find a reason to justify this check... Any error condition should be
> handled in rproc_virtio_probe() and reported by IS_ERR(pdev) above.
> 
> Otherwise this patchset is holding together.

Thanks for the review! 
I plan to send this week or next week a new version integrating all your comments.

Regards,
Arnaud

> Thanks,
> Mathieu
> 
>>  
>>  	return 0;
>>  }
>> @@ -1237,7 +1252,7 @@ void rproc_resource_cleanup(struct rproc *rproc)
>>  
>>  	/* clean up remote vdev entries */
>>  	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
>> -		kref_put(&rvdev->refcount, rproc_vdev_release);
>> +		platform_device_unregister(rvdev->pdev);
>>  
>>  	rproc_coredump_cleanup(rproc);
>>  }
>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>> index 7725b404afc6..175e64a1f3a1 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -45,10 +45,7 @@ int rproc_of_parse_firmware(struct device *dev, int index,
>>  			    const char **fw_name);
>>  
>>  /* from remoteproc_virtio.c */
>> -struct rproc_vdev *rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data);
>> -void rproc_rvdev_remove_device(struct rproc_vdev *rvdev);
>>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
>> -void rproc_vdev_release(struct kref *ref);
>>  
>>  /* from remoteproc_debugfs.c */
>>  void rproc_remove_trace_file(struct dentry *tfile);
>> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
>> index 1c4fd79ac1c5..de9f12fcd044 100644
>> --- a/drivers/remoteproc/remoteproc_virtio.c
>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/export.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/of_reserved_mem.h>
>>  #include <linux/remoteproc.h>
>>  #include <linux/virtio.h>
>> @@ -46,7 +47,11 @@ static int copy_dma_range_map(struct device *to, struct device *from)
>>  
>>  static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
>>  {
>> -	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
>> +	struct platform_device *pdev;
>> +
>> +	pdev = container_of(vdev->dev.parent, struct platform_device, dev);
>> +
>> +	return platform_get_drvdata(pdev);
>>  }
>>  
>>  static  struct rproc *vdev_to_rproc(struct virtio_device *vdev)
>> @@ -341,13 +346,10 @@ static void rproc_virtio_dev_release(struct device *dev)
>>  {
>>  	struct virtio_device *vdev = dev_to_virtio(dev);
>>  	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
>> -	struct rproc *rproc = vdev_to_rproc(vdev);
>>  
>>  	kfree(vdev);
>>  
>> -	kref_put(&rvdev->refcount, rproc_vdev_release);
>> -
>> -	put_device(&rproc->dev);
>> +	put_device(&rvdev->pdev->dev);
>>  }
>>  
>>  /**
>> @@ -363,7 +365,7 @@ static void rproc_virtio_dev_release(struct device *dev)
>>  static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>>  {
>>  	struct rproc *rproc = rvdev->rproc;
>> -	struct device *dev = &rvdev->dev;
>> +	struct device *dev = &rvdev->pdev->dev;
>>  	struct virtio_device *vdev;
>>  	struct rproc_mem_entry *mem;
>>  	int ret;
>> @@ -433,18 +435,8 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>>  	vdev->dev.parent = dev;
>>  	vdev->dev.release = rproc_virtio_dev_release;
>>  
>> -	/*
>> -	 * We're indirectly making a non-temporary copy of the rproc pointer
>> -	 * here, because drivers probed with this vdev will indirectly
>> -	 * access the wrapping rproc.
>> -	 *
>> -	 * Therefore we must increment the rproc refcount here, and decrement
>> -	 * it _only_ when the vdev is released.
>> -	 */
>> -	get_device(&rproc->dev);
>> -
>>  	/* Reference the vdev and vring allocations */
>> -	kref_get(&rvdev->refcount);
>> +	get_device(dev);
>>  
>>  	ret = register_virtio_device(vdev);
>>  	if (ret) {
>> @@ -486,78 +478,57 @@ static int rproc_vdev_do_start(struct rproc_subdev *subdev)
>>  static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>>  {
>>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>> +	struct device *dev = &rvdev->pdev->dev;
>>  	int ret;
>>  
>> -	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
>> +	ret = device_for_each_child(dev, NULL, rproc_remove_virtio_dev);
>>  	if (ret)
>> -		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
>> -}
>> -
>> -/**
>> - * rproc_rvdev_release() - release the existence of a rvdev
>> - *
>> - * @dev: the subdevice's dev
>> - */
>> -static void rproc_rvdev_release(struct device *dev)
>> -{
>> -	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
>> -
>> -	of_reserved_mem_device_release(dev);
>> -
>> -	kfree(rvdev);
>> +		dev_warn(dev, "can't remove vdev child device: %d\n", ret);
>>  }
>>  
>> -struct rproc_vdev *
>> -rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>> +static int rproc_virtio_probe(struct platform_device *pdev)
>>  {
>> +	struct device *dev = &pdev->dev;
>> +	struct rproc_vdev_data *rvdev_data = dev->platform_data;
>>  	struct rproc_vdev *rvdev;
>> -	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
>> -	char name[16];
>> +	struct rproc *rproc = container_of(dev->parent, struct rproc, dev);
>> +	struct fw_rsc_vdev *rsc;
>>  	int i, ret;
>>  
>> -	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
>> -	if (!rvdev)
>> -		return ERR_PTR(-ENOMEM);
>> +	if (!rvdev_data)
>> +		return -EINVAL;
>>  
>> -	kref_init(&rvdev->refcount);
>> +	rvdev = devm_kzalloc(dev, sizeof(*rvdev), GFP_KERNEL);
>> +	if (!rvdev)
>> +		return -ENOMEM;
>>  
>>  	rvdev->id = rvdev_data->id;
>>  	rvdev->rproc = rproc;
>>  	rvdev->index = rvdev_data->index;
>>  
>> -	/* Initialise vdev subdevice */
>> -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
>> -	rvdev->dev.parent = &rproc->dev;
>> -	rvdev->dev.release = rproc_rvdev_release;
>> -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
>> -	dev_set_drvdata(&rvdev->dev, rvdev);
>> -
>> -	ret = device_register(&rvdev->dev);
>> -	if (ret) {
>> -		put_device(&rvdev->dev);
>> -		return ERR_PTR(ret);
>> -	}
>> -
>> -	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
>> +	ret = copy_dma_range_map(dev, rproc->dev.parent);
>>  	if (ret)
>> -		goto free_rvdev;
>> +		return ret;
>>  
>>  	/* Make device dma capable by inheriting from parent's capabilities */
>> -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
>> +	set_dma_ops(dev, get_dma_ops(rproc->dev.parent));
>>  
>> -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
>> -					   dma_get_mask(rproc->dev.parent));
>> +	ret = dma_coerce_mask_and_coherent(dev, dma_get_mask(rproc->dev.parent));
>>  	if (ret) {
>> -		dev_warn(&rvdev->dev,
>> -			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
>> +		dev_warn(dev, "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
>>  			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
>>  	}
>>  
>> +	platform_set_drvdata(pdev, rvdev);
>> +	rvdev->pdev = pdev;
>> +
>> +	rsc = rvdev_data->rsc;
>> +
>>  	/* parse the vrings */
>>  	for (i = 0; i < rsc->num_of_vrings; i++) {
>>  		ret = rproc_parse_vring(rvdev, rsc, i);
>>  		if (ret)
>> -			goto free_rvdev;
>> +			return ret;
>>  	}
>>  
>>  	/* remember the resource offset*/
>> @@ -577,18 +548,30 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>>  
>>  	rproc_add_subdev(rproc, &rvdev->subdev);
>>  
>> -	return rvdev;
>> +	dev_dbg(dev, "virtio dev %d added\n",  rvdev->index);
>> +
>> +	/*
>> +	 * We're indirectly making a non-temporary copy of the rproc pointer
>> +	 * here, because the platform devicer or the vdev device will indirectly
>> +	 * access the wrapping rproc.
>> +	 *
>> +	 * Therefore we must increment the rproc refcount here, and decrement
>> +	 * it _only_ on platform remove.
>> +	 */
>> +	get_device(&rproc->dev);
>> +
>> +	return 0;
>>  
>>  unwind_vring_allocations:
>>  	for (i--; i >= 0; i--)
>>  		rproc_free_vring(&rvdev->vring[i]);
>> -free_rvdev:
>> -	device_unregister(&rvdev->dev);
>> -	return ERR_PTR(ret);
>> +
>> +	return ret;
>>  }
>>  
>> -void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
>> +static int rproc_virtio_remove(struct platform_device *pdev)
>>  {
>> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
>>  	struct rproc *rproc = rvdev->rproc;
>>  	struct rproc_vring *rvring;
>>  	int id;
>> @@ -600,19 +583,29 @@ void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
>>  
>>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>>  	rproc_unregister_rvdev(rvdev);
>> -	device_unregister(&rvdev->dev);
>> -}
>>  
>> -void rproc_vdev_release(struct kref *ref)
>> -{
>> -	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
>> -	struct rproc_vring *rvring;
>> -	int id;
>> +	of_reserved_mem_device_release(&pdev->dev);
>>  
>> -	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
>> -		rvring = &rvdev->vring[id];
>> -		rproc_free_vring(rvring);
>> -	}
>> +	dev_dbg(&pdev->dev, "virtio dev %d removed\n",  rvdev->index);
>>  
>> -	rproc_rvdev_remove_device(rvdev);
>> +	/* The remote proc device can be removed */
>> +	put_device(&rproc->dev);
>> +
>> +	return 0;
>>  }
>> +
>> +/* Platform driver */
>> +static const struct of_device_id rproc_virtio_match[] = {
>> +	{ .compatible = "rproc-virtio", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver rproc_virtio_driver = {
>> +	.probe		= rproc_virtio_probe,
>> +	.remove		= rproc_virtio_remove,
>> +	.driver		= {
>> +		.name	= "rproc-virtio",
>> +		.of_match_table	= rproc_virtio_match,
>> +	},
>> +};
>> +builtin_platform_driver(rproc_virtio_driver);
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index e0600e1e5c17..7951a3e2b62a 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -614,9 +614,8 @@ struct rproc_vring {
>>  
>>  /**
>>   * struct rproc_vdev - remoteproc state for a supported virtio device
>> - * @refcount: reference counter for the vdev and vring allocations
>>   * @subdev: handle for registering the vdev as a rproc subdevice
>> - * @dev: device struct used for reference count semantics
>> + * @pdev: remoteproc virtio platform device
>>   * @id: virtio device id (as in virtio_ids.h)
>>   * @node: list node
>>   * @rproc: the rproc handle
>> @@ -625,10 +624,9 @@ struct rproc_vring {
>>   * @index: vdev position versus other vdev declared in resource table
>>   */
>>  struct rproc_vdev {
>> -	struct kref refcount;
>>  
>>  	struct rproc_subdev subdev;
>> -	struct device dev;
>> +	struct platform_device *pdev;
>>  
>>  	unsigned int id;
>>  	struct list_head node;
>> -- 
>> 2.25.1
>>
