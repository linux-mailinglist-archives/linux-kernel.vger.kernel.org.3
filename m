Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824B4FB16D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiDKBjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiDKBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:39:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55644755
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:37:02 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcBH06gjJzFpfF;
        Mon, 11 Apr 2022 09:34:36 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 09:36:59 +0800
Received: from [10.67.102.67] (10.67.102.67) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 09:36:59 +0800
Subject: Re: [PATCH V3 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
To:     <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <lipeng321@huawei.com>,
        <shenjian15@huawei.com>, <moyufeng@huawei.com>
References: <20220329113930.37631-1-huangguangbin2@huawei.com>
From:   "huangguangbin (A)" <huangguangbin2@huawei.com>
Message-ID: <bfec5dc5-cb6e-e27e-f233-7f16e53edab7@huawei.com>
Date:   Mon, 11 Apr 2022 09:36:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220329113930.37631-1-huangguangbin2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping. Any comment or suggestion is appreciated. Thanks

On 2022/3/29 19:39, Guangbin Huang wrote:
> Change logs:
> V2 -> V3:
>   - Modify the comments of John Garry.
>   - Link: https://lore.kernel.org/linux-arm-kernel/20220228123955.30284-1-huangguangbin2@huawei.com/
> V1 -> V2:
>   - Modify the comments of John Garry.
>   - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/
> 
> Guangbin Huang (2):
>    drivers/perf: hisi: Add description for HNS3 PMU driver
>    drivers/perf: hisi: add driver for HNS3 PMU
> 
>   Documentation/admin-guide/perf/hns3-pmu.rst |  136 ++
>   MAINTAINERS                                 |    6 +
>   drivers/perf/hisilicon/Kconfig              |   10 +
>   drivers/perf/hisilicon/Makefile             |    1 +
>   drivers/perf/hisilicon/hns3_pmu.c           | 1640 +++++++++++++++++++
>   include/linux/cpuhotplug.h                  |    1 +
>   6 files changed, 1794 insertions(+)
>   create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
>   create mode 100644 drivers/perf/hisilicon/hns3_pmu.c
> 
