Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E458578617
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGRPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGRPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:17:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFD25C43
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41573B81646
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3DDC36AE5;
        Mon, 18 Jul 2022 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658157431;
        bh=7vYdhXeQdOu5QO7fBUho2H+EQnIcqXUqzgdSIhY4WMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfCvzksFJwZBgBuzW2Rf+hh7lzSOze0hr87nXoiLN2ybN3Tud+f9IAZyWinu/+q+4
         54/G/vPbhIslkJvs5NBprcI2JK4ZuZhngkOyoGb60lz1xVSvFxppoQafFejAlyVrkC
         7V2+GF+MTQqPpFSSpxEo0FSS31QhqZU0P4FaH+v1oe0/+axYqjKdVuWbusikDHTY21
         OKpKDYcybJc5pOQu6y+7gL3zWWC7q1lLZsC+5mM6o4Ws9NmCaHZB0FwS/bUV5S4EC2
         au6e+pEswAgMOIvr0ZvKqaBPBH/97Mx0kNtQUyAhqFk3uDqIyvGblLLieQC0diGvk3
         d+7eJhh2A5HGg==
Date:   Mon, 18 Jul 2022 16:17:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
Message-ID: <20220718151704.GB12935@willie-the-truck>
References: <20220715110334.6969-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715110334.6969-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:03:34PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Robin has been acting as a reviewer of the IOMMU Subsystem for a long
> time. He is also defacto maintaining the IOMMU DMA-API Layer, so make
> both roles official by adding Robin to the MAINTAINERS file.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  MAINTAINERS | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f9ed151ad4c..029f49f29982 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10448,9 +10448,20 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>  F:	fs/iomap/
>  F:	include/linux/iomap.h
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
>  M:	Joerg Roedel <joro@8bytes.org>
>  M:	Will Deacon <will@kernel.org>
> +R:	Robin Murphy <robin.murphy@arm.com>

It's about time!

Acked-by: Will Deacon <will@kernel.org>

Will
