Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC2474864
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhLNQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:41:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4279 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLNQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:41:18 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD3xx3X1nz67PFK;
        Wed, 15 Dec 2021 00:39:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:41:16 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 16:41:15 +0000
Subject: Re: [PATCH v2 10/11] iommu/iova: Move flush queue code to iommu-dma
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <02cf45fc-49e8-e471-8d57-5917b03ddc6e@huawei.com>
Date:   Tue, 14 Dec 2021 16:40:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
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
> Flush queues are specific to DMA ops, which are now handled exclusively
> by iommu-dma. As such, now that the historical artefacts from being
> shared directly with drivers have been cleaned up, move the flush queue
> code into iommu-dma itself to get it out of the way of other IOVA users.
> 
> This is pure code movement with no functional change; refactoring to
> clean up the headers and definitions will follow.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Again FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>
