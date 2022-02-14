Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903544B52EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354994AbiBNOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:14:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:14:47 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BA278
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:14:39 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E6060374; Mon, 14 Feb 2022 15:14:37 +0100 (CET)
Date:   Mon, 14 Feb 2022 15:14:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Message-ID: <YgpjzNtQlOdq+1AB@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:55:28AM +0800, Lu Baolu wrote:
> v3:
>  - Remove ops check when dev_iommu_ops() is used.
>  - This version of series is available on github:
>    https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v3
> 
> Lu Baolu (10):
>   iommu/vt-d: Remove guest pasid related callbacks
>   iommu: Remove guest pasid related interfaces and definitions
>   iommu/vt-d: Remove aux-domain related callbacks
>   iommu: Remove aux-domain related interfaces and iommu_ops
>   iommu: Remove apply_resv_region
>   drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>   iommu: Use right way to retrieve iommu_ops
>   iommu: Remove unused argument in is_attach_deferred
>   iommu: Use dev_iommu_ops() helper
>   iommu: Split struct iommu_ops

Really cool, thanks for doing this, Baolu! I am currently running some
tests on this series to make sure there are no build breakages. And I
agree with Jason that:

	iommu: Use right way to retrieve iommu_ops and
	iommu: Use dev_iommu_ops() helper

can be combined into one patch. Splitting iommu_ops was something I have
been thinking about for some time, so thanks again for doing this.

Regards,

	Joerg
