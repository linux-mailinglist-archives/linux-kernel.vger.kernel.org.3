Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D027A54B12F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiFNMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiFNMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:37:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF84EDF8;
        Tue, 14 Jun 2022 05:34:15 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMnrr1TPwzjY4Q;
        Tue, 14 Jun 2022 20:32:44 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 20:34:13 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 20:34:13 +0800
Subject: Re: [PATCH v2 0/3] crypto: hisilicon - supports device isolation
 feature
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
References: <20220614122311.824-1-yekai13@huawei.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <64bc0f6e-2711-4361-9c7b-abe489001683@huawei.com>
Date:   Tue, 14 Jun 2022 20:34:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220614122311.824-1-yekai13@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 20:23, Kai Ye wrote:
> Add the hardware error isolation feature for ACC. Defines a driver debugfs
> node that used to configures the hardware error frequency. When the error
> frequency is exceeded, the device will be isolated. The isolation strategy
> can be defined in each driver module. e.g. Defining the isolation strategy
> for ACC, if the AER error frequency exceeds the value of setting for a
> certain period of time, The device will not be available in user space. The
> VF device use the PF device isolation strategy. as well as the isolation
> strategy should not be set during device use.
>
> changes v1->v2:
> 	1、deleted dev_to_uacce api.
> 	2、add vfs node doc.
> 	3、move uacce->ref to driver.
>
> Kai Ye (3):
>   uacce: supports device isolation feature
>   Documentation: add a isolation strategy vfs node for uacce
>   crypto: hisilicon/qm - defining the device isolation strategy
>
>  Documentation/ABI/testing/sysfs-driver-uacce |  17 ++
>  drivers/crypto/hisilicon/qm.c                | 157 +++++++++++++++++--
>  drivers/misc/uacce/uacce.c                   |  37 +++++
>  include/linux/hisi_acc_qm.h                  |   9 ++
>  include/linux/uacce.h                        |  16 +-
>  5 files changed, 219 insertions(+), 17 deletions(-)
>

please ignore this patchset.

thanks
Kai
