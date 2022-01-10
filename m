Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A490489DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiAJQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:36:41 -0500
Received: from foss.arm.com ([217.140.110.172]:36344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237563AbiAJQgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:36:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA512B;
        Mon, 10 Jan 2022 08:36:36 -0800 (PST)
Received: from [10.57.11.80] (unknown [10.57.11.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647943F5A1;
        Mon, 10 Jan 2022 08:36:35 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Update create_bo flags comment
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20220109163704.2564-1-alyssa.rosenzweig@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e917afba-0858-bcdd-a7f5-33501158d4ca@arm.com>
Date:   Mon, 10 Jan 2022 16:36:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220109163704.2564-1-alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2022 16:37, Alyssa Rosenzweig wrote:
> Update a comment stating create_bo took no flags, since it now takes a
> bit mask of optional flags NOEXEC and HEAP.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-next.

Thanks,

Steve

> ---
>  include/uapi/drm/panfrost_drm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 061e700dd06c..9e40277d8185 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -84,14 +84,14 @@ struct drm_panfrost_wait_bo {
>  	__s64 timeout_ns;	/* absolute */
>  };
>  
> +/* Valid flags to pass to drm_panfrost_create_bo */
>  #define PANFROST_BO_NOEXEC	1
>  #define PANFROST_BO_HEAP	2
>  
>  /**
>   * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost BOs.
>   *
> - * There are currently no values for the flags argument, but it may be
> - * used in a future extension.
> + * The flags argument is a bit mask of PANFROST_BO_* flags.
>   */
>  struct drm_panfrost_create_bo {
>  	__u32 size;
> 

