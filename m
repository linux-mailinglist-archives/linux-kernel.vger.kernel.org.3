Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C41525996
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376454AbiEMCEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiEMCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:04:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E628FE8C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:04:50 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzsKX19yJzCsf3;
        Fri, 13 May 2022 10:00:00 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 10:04:49 +0800
Subject: Re: [PATCH V6 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
To:     Guangbin Huang <huangguangbin2@huawei.com>,
        <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>
References: <20220427121000.56026-1-huangguangbin2@huawei.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <76e3cfd5-0dfc-bc4b-480f-3c18722480fb@hisilicon.com>
Date:   Fri, 13 May 2022 10:04:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220427121000.56026-1-huangguangbin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guangbin,

Thanks for your work that we did some internal review, please free
to add:
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

On 2022/4/27 20:09, Guangbin Huang wrote:
> This patch-set adds driver for HNS3(HiSilicon network system version 3)
> PMU and doc to descript it.
> 
> Change logs:
> V5 -> V6:
>  - Modify prefix hns3_get into hns3_pmu_get.
>  - Some switch cases return directly.
>  - Modify failed log when io remap failed.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220426132822.51735-1-huangguangbin2@huawei.com/
> V4 -> V5:
>  - Add COMPILE_TEST and include io-64-nonatomic-hi-lo.h as suggestion of
>    John Garry.
> V3 -> V4:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220329113930.37631-1-huangguangbin2@huawei.com/
> V2 -> V3:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220228123955.30284-1-huangguangbin2@huawei.com/
> V1 -> V2:
>  - Modify the comments of John Garry.
>  - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/
> 
> 
> Guangbin Huang (2):
>   drivers/perf: hisi: Add description for HNS3 PMU driver
>   drivers/perf: hisi: add driver for HNS3 PMU
> 
>  Documentation/admin-guide/perf/hns3-pmu.rst |  136 ++
>  MAINTAINERS                                 |    6 +
>  drivers/perf/hisilicon/Kconfig              |   10 +
>  drivers/perf/hisilicon/Makefile             |    1 +
>  drivers/perf/hisilicon/hns3_pmu.c           | 1654 +++++++++++++++++++
>  include/linux/cpuhotplug.h                  |    1 +
>  6 files changed, 1808 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
>  create mode 100644 drivers/perf/hisilicon/hns3_pmu.c
> 
