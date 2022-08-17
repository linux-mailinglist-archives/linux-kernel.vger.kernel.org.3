Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717F596CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiHQKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiHQKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:24:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3259240
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:24:13 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M73yk1QRBz67Pn6;
        Wed, 17 Aug 2022 18:23:58 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 12:24:11 +0200
Received: from [10.48.158.152] (10.48.158.152) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:24:11 +0100
Message-ID: <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
Date:   Wed, 17 Aug 2022 11:24:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/3] iova: Some misc changes
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.152]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:09, John Garry wrote:
> This series includes:
> - remove checks in the code which are not required
> - the re-org, which I had originally posted separately

BTW, Can we drop the !IOMMU_IOVA stubs in iova.h? I could not find a 
kernel config which actually exercises that code (so testing changes 
there is difficult).

> 
> Based on v6.0-rc1
> 
> John Garry (3):
>    iova: Remove some magazine pointer NULL checks
>    iova: Remove magazine BUG_ON() checks
>    iova: Re-order code to remove forward declarations
> 
>   drivers/iommu/iova.c | 1074 +++++++++++++++++++++---------------------
>   include/linux/iova.h |   60 +--
>   2 files changed, 559 insertions(+), 575 deletions(-)
> 

