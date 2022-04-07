Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913E4F7F68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiDGMsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbiDGMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:48:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D578164F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:46:08 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ1Jz0TTnzFpcB;
        Thu,  7 Apr 2022 20:43:47 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 20:46:06 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 20:46:06 +0800
Subject: Re: [PATCH v3 0/2] Add Support for HiSilicon CPA PMU
To:     Linuxarm <linuxarm@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <20220407123645.43019-1-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <c8fe3321-e049-31ed-0169-ea135b8d4599@huawei.com>
Date:   Thu, 7 Apr 2022 20:46:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220407123645.43019-1-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This should be version 4 of this patchset, please ignore this series and 
I'll resend it latter.

Thanks,
Qi

On 2022/4/7 20:36, Qi Liu wrote:
> Add Support for HiSilicon CPA PMU driver. Json file in perf tool
> is applied in
> https://lore.kernel.org/linux-arm-kernel/YhkhSZp+a715Ldzr@kernel.org/.
> 
> Change since v3:
> - Add more explanation for changing CPA PMUs CPU affinity.
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220321070124.41338-1-liuqi115@huawei.com/
> 
> Change since v2:
> - Associate CPA PMUs with CPUs online, rather than CPUs in the nearest SCCL.
> - Move CPA power management to probe and remove function.
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220224111129.41416-1-liuqi115@huawei.com/
> 
> Change since v1:
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220214114228.40859-1-liuqi115@huawei.com/
> 
> Qi Liu (2):
>    drivers/perf: hisi: Associate PMUs in SICL with CPUs online
>    drivers/perf: hisi: Add Support for CPA PMU
> 
>   drivers/perf/hisilicon/Makefile              |   2 +-
>   drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 401 +++++++++++++++++++
>   drivers/perf/hisilicon/hisi_uncore_pa_pmu.c  |  18 +-
>   drivers/perf/hisilicon/hisi_uncore_pmu.c     |   4 +
>   drivers/perf/hisilicon/hisi_uncore_pmu.h     |   1 +
>   include/linux/cpuhotplug.h                   |   1 +
>   6 files changed, 415 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> 
