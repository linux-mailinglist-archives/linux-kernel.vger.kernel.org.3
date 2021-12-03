Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B6467BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358643AbhLCRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:00:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59496 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240527AbhLCRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:00:22 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B3FHjxt024476;
        Fri, 3 Dec 2021 17:56:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=lVFPlD5zTSPixkBBTEMlFlHKw7YEEz4hyL4vWG8qF4A=;
 b=ZNWWUMWGhQ0vTcZDWynG49WfgKhPG35aeVNdMit6tCxev/MdNmA2C5M3YuUO7fMxwN1d
 Kmk4OTV4L3m2KFaA2/Oa+aHZxlNvQPkWxeV4sQOEL5vlmQ+8z5ZphGr5mX+JjA370jdR
 1LwRkdtXtCAWQULvoMupxV4v51Ujv0c0c8PHVYJf9dz/Evmb7yPvqZ7XnSMUiDmJfoWV
 IJZzahGlnkamkfrF6jMqcfA0rzlhYcYvo7wqgUOCfoPFfmvkKcIrQSDPmeNvnMC/hc6U
 LDJcZ5x/vFXUwZeExp3vjmD7xcA/+U1fdDV/K84aPxlGjsNiCQR2x7gghrct7Fh9Caq7 TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cqnrmrdw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 17:56:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC64510002A;
        Fri,  3 Dec 2021 17:56:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C467D20C118;
        Fri,  3 Dec 2021 17:56:49 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 3 Dec
 2021 17:56:49 +0100
Subject: Re: [PATCH v7 12/12] rpmsg: core: send a ns announcement when a
 default endpoint is created
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20211108141937.13016-1-arnaud.pouliquen@foss.st.com>
 <20211108141937.13016-13-arnaud.pouliquen@foss.st.com>
 <Yal5tplvcqDjEeTs@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <eb3cc7a1-251e-7d40-225a-a5528a22323e@foss.st.com>
Date:   Fri, 3 Dec 2021 17:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yal5tplvcqDjEeTs@builder.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/21 2:58 AM, Bjorn Andersson wrote:
> On Mon 08 Nov 08:19 CST 2021, Arnaud Pouliquen wrote:
> 
>> When a channel is created by user space application with the
>> RPMSG_CREATE_DEV_IOCTL controls, a ns announcement has to be sent
>> (depending on backend) to inform the remote side that a new service
>> is available.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/rpmsg/rpmsg_core.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index bdcde57c22f6..63227279397d 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -145,6 +145,9 @@ EXPORT_SYMBOL(rpmsg_destroy_ept);
>>   *
>>   * This function returns a pointer to an endpoint created and assigned as the default
>>   * endpoint of the rpmsg device.
>> + * If we need to, we also announce about this channel to the remote
>> + * processor. This announcement is needed in case the driver is exposing an rpmsg service that has
>> + * been created locally.
>>   *
>>   * Drivers should provide their @rpdev channel (so the new endpoint would belong
>>   * to the same remote processor their channel belongs to), an rx callback
>> @@ -161,6 +164,7 @@ struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
>>  						struct rpmsg_channel_info chinfo)
>>  {
>>  	struct rpmsg_endpoint *ept;
>> +	int err = 0;
>>  
>>  	if (WARN_ON(!rpdev))
>>  		return NULL;
>> @@ -183,6 +187,16 @@ struct rpmsg_endpoint *rpmsg_create_default_ept(struct rpmsg_device *rpdev,
>>  	rpdev->ept = ept;
>>  	rpdev->src = ept->addr;
>>  
>> +	if (rpdev->ops->announce_create)
>> +		err = rpdev->ops->announce_create(rpdev);
>> +	if (err) {
>> +		rpmsg_destroy_ept(ept);
>> +		rpdev->ept = NULL;
>> +		rpdev->src = RPMSG_ADDR_ANY;
>> +
>> +		return NULL;
>> +	}
>> +
> 
> Unless I'm missing something I think this would be cleaner as:
> 
> 	if (rpdev->ops->announce_create) {
> 		err = rpdev->ops->announce_create(rpdev);
> 		if (err) {
> 			...;
> 		}
> 	}
> 
> which also implies that you don't need to zero-initialize err.

Ack, i will change this.

> 
> Other than that, this looks good and follows what would happen in
> rpmsg_dev_probe()...
> 
> 
> PS. In rpmsg_dev_probe(), if rpdrv->probe() succeeds but announce_create
> returns a failure we will exit the function with an error, which will
> just fail really_probe() and we won't ever clean up the device (i.e.
> call rpdev->remove()).

Right the error management in rpmsg_dev_probe needs to be improved.
I will probably found time to address this when preparing the next revision
of my patchset (just need before a clarification from you about patch
v7 10/12] rpmsg: char: Introduce the "rpmsg-raw" channel).

Thanks,
Arnaud

> 
> Regards,
> Bjorn
> 
>>  	return ept;
>>  }
>>  EXPORT_SYMBOL(rpmsg_create_default_ept);
>> -- 
>> 2.17.1
>>
