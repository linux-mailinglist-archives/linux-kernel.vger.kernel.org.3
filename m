Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FC512E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbiD1Ial (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbiD1Iah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:30:37 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB1A0BCE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 955572FB; Thu, 28 Apr 2022 10:27:20 +0200 (CEST)
Date:   Thu, 28 Apr 2022 10:27:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix issues with untrusted devices and AMD IOMMU
Message-ID: <YmpP59PHSJpqbbBT@8bytes.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404204723.9767-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:47:21PM -0500, Mario Limonciello wrote:
> Mario Limonciello (2):
>   iommu/amd: Enable swiotlb in all cases
>   dma-iommu: Check that swiotlb is active before trying to use it
> 
>  drivers/iommu/amd/iommu.c | 7 -------
>  drivers/iommu/dma-iommu.c | 5 +++++
>  2 files changed, 5 insertions(+), 7 deletions(-)

Applied to core branch, thanks.
