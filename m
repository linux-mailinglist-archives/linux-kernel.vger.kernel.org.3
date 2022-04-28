Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD3512FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiD1Jst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347857AbiD1JfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:35:22 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF4939E8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:32:07 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CCD492FB; Thu, 28 Apr 2022 11:32:05 +0200 (CEST)
Date:   Thu, 28 Apr 2022 11:32:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YmpfFA1iIQyGBipX@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> Lu Baolu (10):
>   iommu: Add DMA ownership management interfaces
>   driver core: Add dma_cleanup callback in bus_type
>   amba: Stop sharing platform_dma_configure()
>   bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
>   PCI: pci_stub: Set driver_managed_dma
>   PCI: portdrv: Set driver_managed_dma
>   vfio: Set DMA ownership for VFIO devices
>   vfio: Remove use of vfio_group_viable()
>   vfio: Remove iommu group notifier
>   iommu: Remove iommu group changes notifier

Applied to core branch, thanks Baolu.
