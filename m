Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0947A9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhLTMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:40:11 -0500
Received: from foss.arm.com ([217.140.110.172]:54556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhLTMkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:40:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F9731042;
        Mon, 20 Dec 2021 04:40:10 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2690E3F718;
        Mon, 20 Dec 2021 04:40:09 -0800 (PST)
Message-ID: <e92a5d33-55a4-7262-0448-4ad8f924e6c3@arm.com>
Date:   Mon, 20 Dec 2021 12:40:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] iommu/iova: Temporarily include dma-mapping.h from iova.h
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20211220123448.19996-1-joro@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211220123448.19996-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-20 12:34, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some users of iova.h still expect that dma-mapping.h is also included.
> Re-add the include until these users are updated to fix compile
> failures in the iommu tree.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   include/linux/iova.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 0abd48c5e622..cea79cb9f26c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -12,6 +12,7 @@
>   #include <linux/types.h>
>   #include <linux/kernel.h>
>   #include <linux/rbtree.h>
> +#include <linux/dma-mapping.h>
>   
>   /* iova structure */
>   struct iova {
