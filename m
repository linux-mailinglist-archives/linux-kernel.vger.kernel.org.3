Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D447A5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhLTIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:03:39 -0500
Received: from 8bytes.org ([81.169.241.247]:50336 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhLTIDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:03:39 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D90CF39A; Mon, 20 Dec 2021 09:03:37 +0100 (CET)
Date:   Mon, 20 Dec 2021 09:03:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, linux-mm@kvack.org, hch@lst.de,
        thierry.reding@gmail.com
Subject: Re: [PATCH v3 0/9] iommu: refactor flush queues into iommu-dma
Message-ID: <YcA42LtpISehG6O9@8bytes.org>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 03:30:54PM +0000, Robin Murphy wrote:
> Matthew Wilcox (Oracle) (2):
>   iommu/amd: Use put_pages_list
>   iommu/vt-d: Use put_pages_list
> 
> Robin Murphy (6):
>   iommu/iova: Squash entry_dtor abstraction
>   iommu/iova: Squash flush_cb abstraction
>   iommu/amd: Simplify pagetable freeing
>   iommu/iova: Consolidate flush queue code
>   iommu/iova: Move flush queue code to iommu-dma
>   iommu: Move flush queue data into iommu_dma_cookie
> 
> Xiongfeng Wang (1):
>   iommu/iova: Fix race between FQ timeout and teardown

Applied, thanks Robin.
