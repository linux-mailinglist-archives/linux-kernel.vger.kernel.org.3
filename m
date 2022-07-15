Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37AA575FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiGOLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiGOLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:06:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB9FCDF98
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:06:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E691474;
        Fri, 15 Jul 2022 04:06:01 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF79A3F73D;
        Fri, 15 Jul 2022 04:05:59 -0700 (PDT)
Message-ID: <fa52e5cc-41e6-a77c-a200-70a3a2c3b508@arm.com>
Date:   Fri, 15 Jul 2022 12:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20220715110334.6969-1-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220715110334.6969-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-15 12:03, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Robin has been acting as a reviewer of the IOMMU Subsystem for a long
> time. He is also defacto maintaining the IOMMU DMA-API Layer, so make
> both roles official by adding Robin to the MAINTAINERS file.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   MAINTAINERS | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f9ed151ad4c..029f49f29982 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10448,9 +10448,20 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>   F:	fs/iomap/
>   F:	include/linux/iomap.h
>   
> -IOMMU DRIVERS
> +IOMMU DMA-API LAYER
> +M:	Robin Murphy <robin.murphy@arm.com>
> +L:	iommu@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +F:	drivers/iommu/dma-iommu.c
> +F:	drivers/iommu/iova.c
> +F:	include/linux/dma-iommu.h
> +F:	include/linux/iova.h
> +
> +IOMMU SUBSYSTEM
>   M:	Joerg Roedel <joro@8bytes.org>
>   M:	Will Deacon <will@kernel.org>
> +R:	Robin Murphy <robin.murphy@arm.com>
>   L:	iommu@lists.linux.dev
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
