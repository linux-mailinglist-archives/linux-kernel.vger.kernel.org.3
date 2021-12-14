Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1249B474914
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhLNRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:16:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4280 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhLNRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:16:35 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD4gH1MyYz67xdg;
        Wed, 15 Dec 2021 01:12:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 18:16:33 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 17:16:32 +0000
Subject: Re: [PATCH v2 11/11] iommu: Move flush queue data into
 iommu_dma_cookie
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e997d299-9f51-6d17-19ce-d9116c26c967@huawei.com>
Date:   Tue, 14 Dec 2021 17:16:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.94]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 17:54, Robin Murphy wrote:
> Complete the move into iommu-dma by refactoring the flush queues
> themselves to belong to the DMA cookie rather than the IOVA domain.
> 
> The refactoring may as well extend to some minor cosmetic aspects
> too, to help us stay one step ahead of the style police.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---

Again, FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>
