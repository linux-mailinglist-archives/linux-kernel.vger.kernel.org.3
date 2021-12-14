Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00B474860
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhLNQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:39:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4277 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhLNQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:39:39 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD3vJ1m02z67qfF;
        Wed, 15 Dec 2021 00:37:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:39:38 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 16:39:37 +0000
Subject: Re: [PATCH v2 05/11] iommu/iova: Squash flush_cb abstraction
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6326303c396e28fd3b9ed89d82673dfcf159b8c6.1639157090.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b5f8e415-65e2-9ae6-6c0c-15017d23c974@huawei.com>
Date:   Tue, 14 Dec 2021 16:39:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <6326303c396e28fd3b9ed89d82673dfcf159b8c6.1639157090.git.robin.murphy@arm.com>
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
> Once again, with iommu-dma now being the only flush queue user, we no
> longer need the extra level of indirection through flush_cb. Squash that
> and let the flush queue code call the domain method directly.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Again seems pretty straightforward, so FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>

