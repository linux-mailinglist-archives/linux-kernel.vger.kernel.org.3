Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9F458DC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiHIQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiHIQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:37:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC182F9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:37:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so14965994wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=X6MoPuBxB5LTaIpwHgwbCSWtaGD5GP/fUf8i2jb34y4=;
        b=YYFt5Hvk/GA/aYQDThMEhnkFeG40v5eWaqD5RVCuoCI5uK/07t3E5fR6jL4qn7DEYR
         zViLu6mr7jl7ctZbQDoa9xQZKNKqiA95aqiHa8LJP7h6escYhs0koUmPFts6RhqrXOk/
         yN+220j0woh5fKuBdr+jklN8ZsiBtUlH7QLuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=X6MoPuBxB5LTaIpwHgwbCSWtaGD5GP/fUf8i2jb34y4=;
        b=654PQjE5yKD6ag9dNQeQf6ccLBajTs82kkk0PTx6HkDJ+zBSUnaJnYyBen6D0EEgEO
         zvHmpQN/eyOn/MVDQUk56Hl2KywUoiv8nuO3dlVefh8vld2QitNv/dqfkCWWDGXOoo9y
         tJ34KbMlR5U8xFn5I37+OQfuoLrJ8hcLXJeT0ECIHI18pQkLfmPvD38SXuewgzP/U+wH
         +2VKZ/xiGIS6dT89Pkeqgh5+2jlHWlPzUfK7QLxVF+083uUU1Mv1XibIDhLXykiO+PVK
         KE47OgxRL544a87K1IaGyBoyvFB7AC5fUHC37Bcqap/yGFBG2BB6psl+jBhXbe8mP9XR
         H+sg==
X-Gm-Message-State: ACgBeo2etTEZms0YldPVK/MOpcVXDr0CD0EgsoP6F9t18M/Msvmgd587
        z2mq/oLsamymAmSGlnpuR7pGxw==
X-Google-Smtp-Source: AA6agR7rbtu73gmgTkuGQJU/XLaVRYmZEDfYA+1YrhcoZwGgf2aMhYhyzwlzXCnqTQoNUelc9/MxFQ==
X-Received: by 2002:a05:6000:2ab:b0:223:6167:a213 with SMTP id l11-20020a05600002ab00b002236167a213mr4039906wry.310.1660063019958;
        Tue, 09 Aug 2022 09:36:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i204-20020a1c3bd5000000b003a536d5aa2esm9884682wma.11.2022.08.09.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:36:59 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:36:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v7 2/2] drm/shmem-helper: Correct doc-comment of
 drm_gem_shmem_get_sg_table()
Message-ID: <YvKNKSqVlc0vwDS/@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
References: <20220630200058.1883506-1-dmitry.osipenko@collabora.com>
 <20220630200058.1883506-3-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630200058.1883506-3-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:00:58PM +0300, Dmitry Osipenko wrote:
> drm_gem_shmem_get_sg_table() never returns NULL on error, but a ERR_PTR.
> Correct the doc comment which says that it returns NULL on error.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 904fc893c905..0b526657fbea 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -663,7 +663,8 @@ EXPORT_SYMBOL(drm_gem_shmem_print_info);
>   * drm_gem_shmem_get_pages_sgt() instead.
>   *
>   * Returns:
> - * A pointer to the scatter/gather table of pinned pages or NULL on failure.
> + * A pointer to the scatter/gather table of pinned pages or an ERR_PTR()-encoded
> + * error code on failure.

There was a conflict here because another patch adjusted this already, but
I fixed it up and merged this to drm-misc-next.

Thanks, Daniel

>   */
>  struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>  {
> @@ -689,7 +690,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>   * drm_gem_shmem_get_sg_table() should not be directly called by drivers.
>   *
>   * Returns:
> - * A pointer to the scatter/gather table of pinned pages or errno on failure.
> + * A pointer to the scatter/gather table of pinned pages or an ERR_PTR()-encoded
> + * error code on failure.
>   */
>  struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>  {
> -- 
> 2.36.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
