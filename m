Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2833F474922
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhLNRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:19:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4281 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhLNRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:19:19 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD4kR2flTz67xBm;
        Wed, 15 Dec 2021 01:14:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 14 Dec 2021 18:19:17 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 17:19:16 +0000
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
Message-ID: <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
Date:   Tue, 14 Dec 2021 17:18:53 +0000
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
> +	iovad->fq_domain = fq_domain;
> +	iovad->fq = queue;
> +
> +	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
> +	atomic_set(&iovad->fq_timer_on, 0);
> +
> +	return 0;
> +}
> +
> +

nit: a single blank line is standard, I think

Cheers

>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>   {


