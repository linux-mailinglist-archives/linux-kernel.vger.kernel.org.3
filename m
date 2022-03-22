Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467364E3B89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiCVJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiCVJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:16:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951B45522;
        Tue, 22 Mar 2022 02:14:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 530BF68AFE; Tue, 22 Mar 2022 10:14:33 +0100 (CET)
Date:   Tue, 22 Mar 2022 10:14:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v2 1/2] iommu: Add capability for pre-boot DMA
 protection
Message-ID: <20220322091432.GA27069@lst.de>
References: <cover.1647624084.git.robin.murphy@arm.com> <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 05:42:57PM +0000, Robin Murphy wrote:
> VT-d's dmar_platform_optin() actually represents a combination of
> properties fairly well standardised by Microsoft as "Pre-boot DMA
> Protection" and "Kernel DMA Protection"[1]. As such, we can provide
> interested consumers with an abstracted capability rather than
> driver-specific interfaces that won't scale. We name it for the former
> aspect since that's what external callers are most likely to be
> interested in; the latter is for the IOMMU layer to handle itself.
> 
> Also use this as an opportunity to draw a line in the sand and add a
> new interface so as not to introduce any more callers of iommu_capable()
> which I also want to get rid of. For now it's a quick'n'dirty wrapper
> function, but will evolve to subsume the internal interface in future.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I can't really think of a way in which I suggested this, but it does
looks like a good interface:

Reviewed-by: Christoph Hellwig <hch@lst.de>
