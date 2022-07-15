Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B9575DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiGOIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:44:53 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D84814A8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:44:53 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C69C7535; Fri, 15 Jul 2022 10:44:51 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:44:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        robin.murphy@arm.com, vasant.hegde@amd.com, ashish.kalra@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH v4 0/9] iommu/amd: Enforce IOMMU restrictions for
 SNP-enabled system
Message-ID: <YtEpAgSGz+Linner@8bytes.org>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:56:42PM -0500, Suravee Suthikulpanit wrote:
> Brijesh Singh (1):
>   iommu/amd: Introduce function to check and enable SNP
> 
> Suravee Suthikulpanit (8):
>   iommu/amd: Change macro for IOMMU control register bit shift to
>     decimal value
>   iommu/amd: Introduce Support for Extended Feature 2 Register
>   iommu/amd: Introduce global variable for storing common EFR and EFR2
>   iommu/amd: Process all IVHDs before enabling IOMMU features
>   iommu/amd: Globally detect SNP support
>   iommu/amd: Set translation valid bit only when IO page tables are in
>     use
>   iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
>   iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

Applied, thanks Suravee.

