Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444DE5B03EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIGM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIGM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:27:58 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11E1ACA33
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:27:54 -0700 (PDT)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id AD80324000A;
        Wed,  7 Sep 2022 14:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1662553673;
        bh=0wl2Nk9Q0WFKXl/+RiiHcEiTn36WNoLwCfq691DbiTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSE7PKfrDVe8icJKeddE6TPmkE9jmff1nD4d+WlM1hY3/Cw75Y+xwk9/93uFz6W15
         GR8e8OiIgZW8JR5IAhp0Uy5JXQphStqSTD6FmEOTqhIrf/+VFazqJYYFRBcQ2lV3cB
         s3eT/CoqR3bpcmPloFTMEsw2SmRaOp+3V1xrdixQU4wWiP6D2lXQdjNjBq5yfr99i9
         tOeHU659HmNsLiGg9WTIiDnu2ZRrG7kJlZ9UAV2HC4cBWSqsm9dasxoXWKThmZKn8+
         HZNmWiU7Nj+NTlbE2wjnfEg5CFSqNj6rmEe39f0YNDrJ55E4Ow+VvKi7qVnB7+sRZ3
         mhe21gvCnHSZQ==
Date:   Wed, 7 Sep 2022 14:27:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] iommu: retire bus_set_iommu()
Message-ID: <YxiOSNz7gPuTzgY6@8bytes.org>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:20:01PM +0100, Robin Murphy wrote:
> Matthew Rosato (1):
>   iommu/s390: Fail probe for non-PCI devices
> 
> Robin Murphy (15):
>   iommu/vt-d: Handle race between registration and device probe
>   iommu/amd: Handle race between registration and device probe
>   iommu: Always register bus notifiers
>   iommu: Move bus setup to IOMMU device registration
>   iommu/amd: Clean up bus_set_iommu()
>   iommu/arm-smmu: Clean up bus_set_iommu()
>   iommu/arm-smmu-v3: Clean up bus_set_iommu()
>   iommu/dart: Clean up bus_set_iommu()
>   iommu/exynos: Clean up bus_set_iommu()
>   iommu/ipmmu-vmsa: Clean up bus_set_iommu()
>   iommu/mtk: Clean up bus_set_iommu()
>   iommu/omap: Clean up bus_set_iommu()
>   iommu/tegra-smmu: Clean up bus_set_iommu()
>   iommu/virtio: Clean up bus_set_iommu()
>   iommu: Clean up bus_set_iommu()

Applied, thanks Robin.
