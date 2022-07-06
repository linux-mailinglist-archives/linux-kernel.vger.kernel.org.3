Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0E568611
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiGFKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGFKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:47:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ACD275F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:47:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7121D30A;
        Wed,  6 Jul 2022 12:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657104433;
        bh=9JaP2fGIpmtkusdcte62H9gcOzDrXSqF6Hq1SEPJFHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olJhy+TU7+GEMlctggH2Zsa9QxQKtwZ8SPYz9LVyk0BXJAhcsOaXctk/mkjE3UN8V
         yvFtv+Jj1qEgeKIL1wuRuf9IEWCUXx5FCKL5yUHAUCkn1XbIJQ+JWdBMT+CfZROZuz
         jOxY5JeDtTJlcOhnZRg3fbc0XmM/jCyQ8nnpZR8s=
Date:   Wed, 6 Jul 2022 13:46:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/todo: remove task to rename CMA helpers
Message-ID: <YsVoGKaoVvqijqOe@pendragon.ideasonboard.com>
References: <20220705212613.732039-1-dakr@redhat.com>
 <20220705212613.732039-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220705212613.732039-4-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch.

On Tue, Jul 05, 2022 at 11:26:13PM +0200, Danilo Krummrich wrote:
> Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
> hence the task can be removed.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/gpu/todo.rst | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 10bfb50908d1..fd5b3f2fb19e 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -343,19 +343,6 @@ converted, except for struct drm_driver.gem_prime_mmap.
>  
>  Level: Intermediate
>  
> -Rename CMA helpers to DMA helpers
> ----------------------------------
> -
> -CMA (standing for contiguous memory allocator) is really a bit an accident of
> -what these were used for first, a much better name would be DMA helpers. In the
> -text these should even be called coherent DMA memory helpers (so maybe CDM, but
> -no one knows what that means) since underneath they just use dma_alloc_coherent.
> -
> -Contact: Laurent Pinchart, Daniel Vetter
> -
> -Level: Intermediate (mostly because it is a huge tasks without good partial
> -milestones, not technically itself that challenging)
> -
>  connector register/unregister fixes
>  -----------------------------------
>  

-- 
Regards,

Laurent Pinchart
