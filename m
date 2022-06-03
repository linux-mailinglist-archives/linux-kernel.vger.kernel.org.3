Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA953C99C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiFCLyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbiFCLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:54:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD8237D8;
        Fri,  3 Jun 2022 04:54:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253APJir032493;
        Fri, 3 Jun 2022 13:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=FKNUpyVIm2CLWGCn06bJoa+bMwjpTz6taBDfFnjmWeM=;
 b=eYu69aYxSK7uvhzjWMBLonngbwhJqsInLXxLFQkcNQUidE0rdJshCx4SI/AmDT9RfKSt
 3S5ouF4FstHIp22BXpCJ6pXCnaVsiqAeK1c6LeRFf+EmZcdhyGotbviWXeAGvV6lPaWJ
 FY7VBcd/3EwWzqj/fDfH+qn/ZVUWpS4O4FvgNEaFbosWte7vqKf22HnfECmE7NArUrL0
 93Lp/nKp7kqfcqRQhhQ7rF5olAXELOUlMr3D7eb/IYR9CuLPnobcRPWRw3qa3G4khKun
 IfFy4LqjSDXqDKQJYzbg2QK2/5Bw2KphgvihQyeSIEZxfcV0vI202wh4J9nBuaawPbHQ dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3get03qg0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:53:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C29C1100034;
        Fri,  3 Jun 2022 13:53:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4095421E69A;
        Fri,  3 Jun 2022 13:53:54 +0200 (CEST)
Received: from [10.211.10.149] (10.75.127.44) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 3 Jun
 2022 13:53:51 +0200
Message-ID: <b85c7526-80a4-35f2-7629-319d172bc734@foss.st.com>
Date:   Fri, 3 Jun 2022 13:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v5 2/4] remoteproc: core: Introduce
 rproc_register_rvdev function
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-3-arnaud.pouliquen@foss.st.com>
 <20220601174159.GD531268@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220601174159.GD531268@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_03,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 6/1/22 19:41, Mathieu Poirier wrote:
> On Wed, Apr 06, 2022 at 11:54:44AM +0200, Arnaud Pouliquen wrote:
>> The rproc structure contains a list of registered rproc_vdev structure.
> 
> This should be rproc_rvdev.

Thanks for your review!

I will send a new version according to your comments except
this one.
The structure name rproc_vdev is the good one, or
or maybe I'm missing something?

Thanks,
Arnaud

> 
>> To be able to move the management of the rproc_vdev structure in
>> remoteproc_virtio.c (i.e rproc_rvdev_add_device and
>> rproc_rvdev_remove_device functions), introduce the rproc_register_rvdev
>> and rproc_unregister_rvdev functions.
> 
> The name of those functions doesn't match the content of the patch.
> 
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 3a469220ac73..081bea39daf4 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -484,6 +484,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
>>  	return 0;
>>  }
>>  
>> +static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
>> +{
>> +	if (rvdev && rproc)
>> +		list_add_tail(&rvdev->node, &rproc->rvdevs);
>> +}
>> +
>> +static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
>> +{
>> +	if (rvdev)
>> +		list_del(&rvdev->node);
>> +}
>> +
>>  static struct rproc_vdev *
>>  rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>>  {
>> @@ -547,7 +559,7 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
>>  			goto unwind_vring_allocations;
>>  	}
>>  
>> -	list_add_tail(&rvdev->node, &rproc->rvdevs);
>> +	rproc_add_rvdev(rproc, rvdev);
>>  
>>  	rvdev->subdev.start = rproc_vdev_do_start;
>>  	rvdev->subdev.stop = rproc_vdev_do_stop;
>> @@ -576,7 +588,7 @@ static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
>>  	}
>>  
>>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>> -	list_del(&rvdev->node);
>> +	rproc_remove_rvdev(rvdev);
> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>>  	device_unregister(&rvdev->dev);
>>  }
>>  
>> -- 
>> 2.25.1
>>
