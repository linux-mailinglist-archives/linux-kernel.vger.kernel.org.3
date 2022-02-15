Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB34B6510
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiBOIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:03:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBOIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:03:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7A26574;
        Tue, 15 Feb 2022 00:03:29 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JyYVf56Pvz6F92f;
        Tue, 15 Feb 2022 16:03:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 09:03:28 +0100
Received: from [10.47.81.62] (10.47.81.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 08:03:27 +0000
Message-ID: <a756b22a-5eb5-a883-c9ca-c2345493dee7@huawei.com>
Date:   Tue, 15 Feb 2022 08:03:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH -next] scsi: hisi_sas: Remove unnecessary print function
 dev_err()
To:     Yang Li <yang.lee@linux.alibaba.com>, <jejb@linux.ibm.com>
CC:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220215020524.44268-1-yang.lee@linux.alibaba.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220215020524.44268-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.62]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 02:05, Yang Li wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Eliminate the follow coccicheck warnings:
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1661:3-10: line 1661 is
> redundant because platform_get_irq() already prints an error
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1642:4-11: line 1642 is
> redundant because platform_get_irq() already prints an error
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1679:3-10: line 1679 is
> redundant because platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Yang Li<yang.lee@linux.alibaba.com>

Acked-by: John Garry <john.garry@huawei.com>
