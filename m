Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73645467B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382074AbhLCQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:40:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhLCQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:40:47 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B3CpZ94024579;
        Fri, 3 Dec 2021 17:37:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=K4RgWknMLLCexYIeFwEvklWtlYteDyJWi9FQJ3DntfY=;
 b=wyhBHP4LriCxRflwPLpgrnKJUsp3CYNzxH49oNJet4xXoZnZ3IH1Ni9tPPSjDx3mKBXy
 RYHhBUCxg+oFulhQAfAP5Krg6aPNF+qu5QiXFHo2/XUcWf298pjjXv/TJI+GcWofR55L
 c/q4L5Q0/4YD0DrCxUnZ8IjF5yvROaIvHWswbECihbOT8iGOPQo1HwvwWb8M9zItiUm3
 HYvTbxVs6Ep+ivSEMHq25YKy5vcQqWK9Iqwt6LJKtU54MitYNY9aPVBDSR5I3BXRS/9X
 lbb1dKR4y6RduPLre5MTpGeA4JkXZKx4U7oFAhqkI9JZ7G2rzMZ/EkH9OT/YgIJW5o/l Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cqg9utsy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:37:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 560E410002A;
        Fri,  3 Dec 2021 17:37:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 449F320B088;
        Fri,  3 Dec 2021 17:37:12 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 3 Dec
 2021 17:37:11 +0100
Subject: Re: [PATCH v7 01/12] rpmsg: char: Export eptdev create an destroy
 functions
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211108141937.13016-1-arnaud.pouliquen@foss.st.com>
 <20211108141937.13016-2-arnaud.pouliquen@foss.st.com>
 <Yal+LKVqvp2v26BD@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <54cc46a3-b8bd-a6ac-cd7b-9741eee5131d@foss.st.com>
Date:   Fri, 3 Dec 2021 17:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yal+LKVqvp2v26BD@builder.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

On 12/3/21 3:17 AM, Bjorn Andersson wrote:
> On Mon 08 Nov 08:19 CST 2021, Arnaud Pouliquen wrote:
> 
>> To prepare the split of the code related to the control (ctrldev)
>> and the endpoint (eptdev) devices in 2 separate files:
>>
>> - Rename and export the functions in rpmsg_char.h.
>>
>> - Suppress the dependency with the rpmsg_ctrldev struct in the
>>   rpmsg_eptdev_create function.
>>
>> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Update vs previous revision:
>> - change IS_REACHABLE by IS_ENABLE ( dependency will be fixed in kconfig instead
>> - fix licensing
>> ---
>>  drivers/rpmsg/rpmsg_char.c | 17 +++++++------
>>  drivers/rpmsg/rpmsg_char.h | 51 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+), 7 deletions(-)
>>  create mode 100644 drivers/rpmsg/rpmsg_char.h
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index 2bebc9b2d163..44934d7fa3c4 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>> + * Copyright (C) 2021, STMicroelectronics
>>   * Copyright (c) 2016, Linaro Ltd.
>>   * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
>>   * Copyright (c) 2012, PetaLogix
>> @@ -23,6 +24,7 @@
>>  #include <uapi/linux/rpmsg.h>
>>  
>>  #include "rpmsg_internal.h"
>> +#include "rpmsg_char.h"
>>  
>>  #define RPMSG_DEV_MAX	(MINORMASK + 1)
>>  
>> @@ -78,7 +80,7 @@ struct rpmsg_eptdev {
>>  	wait_queue_head_t readq;
>>  };
>>  
>> -static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>> +int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>>  {
>>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>>  
>> @@ -97,6 +99,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL(rpmsg_chrdev_eptdev_destroy);
>>  
>>  static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>>  			void *priv, u32 addr)
>> @@ -280,7 +283,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>>  	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
>>  		return -EINVAL;
>>  
>> -	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
>> +	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
>>  }
>>  
>>  static const struct file_operations rpmsg_eptdev_fops = {
>> @@ -339,10 +342,9 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>>  	kfree(eptdev);
>>  }
>>  
>> -static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>> +int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
>>  			       struct rpmsg_channel_info chinfo)
>>  {
>> -	struct rpmsg_device *rpdev = ctrldev->rpdev;
>>  	struct rpmsg_eptdev *eptdev;
>>  	struct device *dev;
>>  	int ret;
>> @@ -362,7 +364,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>  
>>  	device_initialize(dev);
>>  	dev->class = rpmsg_class;
>> -	dev->parent = &ctrldev->dev;
>> +	dev->parent = parent;
>>  	dev->groups = rpmsg_eptdev_groups;
>>  	dev_set_drvdata(dev, eptdev);
>>  
>> @@ -405,6 +407,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>>  
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>>  
>>  static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
>>  {
>> @@ -444,7 +447,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>>  	chinfo.src = eptinfo.src;
>>  	chinfo.dst = eptinfo.dst;
>>  
>> -	return rpmsg_eptdev_create(ctrldev, chinfo);
>> +	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
>>  };
>>  
>>  static const struct file_operations rpmsg_ctrldev_fops = {
>> @@ -530,7 +533,7 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>>  	int ret;
>>  
>>  	/* Destroy all endpoints */
>> -	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_eptdev_destroy);
>> +	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>>  	if (ret)
>>  		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
>>  
>> diff --git a/drivers/rpmsg/rpmsg_char.h b/drivers/rpmsg/rpmsg_char.h
>> new file mode 100644
>> index 000000000000..aa6e08a04577
>> --- /dev/null
>> +++ b/drivers/rpmsg/rpmsg_char.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) STMicroelectronics 2021.
>> + */
>> +
>> +#ifndef __RPMSG_CHRDEV_H__
>> +#define __RPMSG_CHRDEV_H__
>> +
>> +#if IS_ENABLED(CONFIG_RPMSG_CHAR)
>> +/**
>> + * rpmsg_chrdev_eptdev_create() - register char device based on an endpoint
>> + * @rpdev:  prepared rpdev to be used for creating endpoints
>> + * @parent: parent device
>> + * @chinfo: associated endpoint channel information.
>> + *
>> + * This function create a new rpmsg char endpoint device to instantiate a new
>> + * endpoint based on chinfo information.
>> + */
>> +int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
>> +			       struct rpmsg_channel_info chinfo);
>> +
>> +/**
>> + * rpmsg_chrdev_eptdev_destroy() - destroy created char device endpoint.
>> + * @data: private data associated to the endpoint device
>> + *
>> + * This function destroys a rpmsg char endpoint device created by the RPMSG_DESTROY_EPT_IOCTL
>> + * control.
>> + */
>> +int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data);
>> +
>> +#else  /*IS_ENABLED(CONFIG_RPMSG_CHAR) */
>> +
>> +static inline int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
>> +					     struct rpmsg_channel_info chinfo)
>> +{
>> +	/* This shouldn't be possible */
> 
> But isn't it very much possible that userspace invokes this function
> through the ioctl that you move to the separate rpmsg_ctrl driver?
> 
>> +	WARN_ON(1);
> 
> Which would mean that this will spam the kernel with stack dumps.

Good catch, I will suppress the WARM_ON. I propose also to return -ENXIO
instead of -EINVAL to be aligned with other functions in rpmsg.h

Thanks,
Arnaud

> 
> Regards,
> Bjorn
> 
>> +	return -EINVAL;
>> +}
>> +
>> +static inline int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +#endif /*IS_ENABLED(CONFIG_RPMSG_CHAR) */
>> +
>> +#endif /*__RPMSG_CHRDEV_H__ */
>> -- 
>> 2.17.1
>>
