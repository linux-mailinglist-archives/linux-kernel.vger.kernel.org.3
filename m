Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AAA478AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhLQMIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:08:32 -0500
Received: from foss.arm.com ([217.140.110.172]:56776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLQMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:08:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29B81435;
        Fri, 17 Dec 2021 04:08:30 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743A93F5A1;
        Fri, 17 Dec 2021 04:08:29 -0800 (PST)
Message-ID: <cc7d6f7f-1077-9ad0-69e5-a4851229fd37@arm.com>
Date:   Fri, 17 Dec 2021 12:08:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 05/11] iommu/iova: Squash flush_cb abstraction
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6326303c396e28fd3b9ed89d82673dfcf159b8c6.1639157090.git.robin.murphy@arm.com>
 <Ybryoh61+htoulPN@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Ybryoh61+htoulPN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-16 08:02, Christoph Hellwig wrote:
>> @@ -147,7 +142,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>   	unsigned long pfn_hi);
>>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>   	unsigned long start_pfn);
>> -int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
>> +int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain);
> 
> Overly long line here.

Fear not, it disappears again in the final patch. In cases like this I 
much prefer to minimise the amount of churn within the series, to keep 
the patches focused on the meaningful changes.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the reviews!

Robin.
