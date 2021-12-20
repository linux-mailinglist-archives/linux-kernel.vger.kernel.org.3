Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3547A344
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhLTBSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:18:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:46670 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhLTBSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:18:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264256574"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="264256574"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 17:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="507496332"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 17:18:51 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH v3 6/9] iommu/vt-d: Use put_pages_list
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1639753638.git.robin.murphy@arm.com>
 <2115b560d9a0ce7cd4b948bd51a2b7bde8fdfd59.1639753638.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1df4cd6c-7f70-4358-e57f-754d98807abe@linux.intel.com>
Date:   Mon, 20 Dec 2021 09:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2115b560d9a0ce7cd4b948bd51a2b7bde8fdfd59.1639753638.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 12/17/21 11:31 PM, Robin Murphy wrote:
> From: "Matthew Wilcox (Oracle)"<willy@infradead.org>
> 
> page->freelist is for the use of slab.  We already have the ability
> to free a list of pages in the core mm, but it requires the use of a
> list_head and for the pages to be chained together through page->lru.
> Switch the Intel IOMMU and IOVA code over to using free_pages_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle)<willy@infradead.org>
> [rm: split from original patch, cosmetic tweaks, fix fq entries]
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

I had boot tests on my development machines with both strict and lazy
flushing modes. I didn't see any regression, the disk i/o and network
i/o worked good for me.

For changes in iommu/vt-d:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
