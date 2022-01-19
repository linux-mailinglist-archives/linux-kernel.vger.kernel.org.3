Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574A493CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355568AbiASPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355520AbiASPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:11:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398B8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so4728842wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=izxGGQW6Yc7uP2xkbN05zLxPnUarfXqJHNM0MzCtvc4=;
        b=dMUGZpy6EppePcB7SWnRxhl/NhTUsHy0swVs23SVdLsP26NHoI85d+FU/cI9J7KYXr
         3cC5V9mQOqwaY4lzgq3SkdBCUmfFUeSNgqYTx5FA8obC5OdRXQK4mG+PiykgRBsZ5I2f
         t1LGFvuwOzAPLgZ8ueQTLCArOGvsv8SoDNJyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=izxGGQW6Yc7uP2xkbN05zLxPnUarfXqJHNM0MzCtvc4=;
        b=U1wyqAd4E0ToxOz7KLI8zxqMINeRNRmoS+O3VLaTpXx/h9ufv+XKX4cg40iBeb6HYe
         tBI7XXNGvYHwdVuQvhbnYWq7Zr2AZL0/SS9/6NQ1OZ+WzBWmPb0xeNpoy38ZQJgJG/nR
         U5KKgx6FPoBumDS9Iocd/tSd4MmZ4Sog8JnGgsIjKHjR7vpvXka3/T5zw72+W3EFgC0u
         d9amrrIJwrtT7puWJxhlEl4kOpEnTs3dqS60KtG0m3h785TGyA0LgW3dGk1gwLit3TCd
         eZcsON0V/impiildBvS+/49WwNrJyaMWN9f2kL1Tupna7PF+GC/jt65ZsmdDl86oqLDc
         l6CA==
X-Gm-Message-State: AOAM5310hIv3nBt5V7aGUKnu/wLLnJ18lv6KSygYdzn+PzRtac4p+oDS
        7bXP4ZB7Yu1eMpvzOXCmKTJNPQ==
X-Google-Smtp-Source: ABdhPJwWKiX3b84nnqbVBf7hcUVuHA9efXM1lkEC5jf1AhuqPLNvBna1jfZ+WafG/7T1KG+RL1jw4g==
X-Received: by 2002:a5d:6643:: with SMTP id f3mr5252221wrw.709.1642605079775;
        Wed, 19 Jan 2022 07:11:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z6sm7348470wmp.9.2022.01.19.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:11:19 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:11:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/doc: Fix TTM acronym
Message-ID: <YegqFcqrakvn30QA@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220107180230.132666-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107180230.132666-1-jose.exposito89@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:02:30PM +0100, José Expósito wrote:
> The TTM acronym is defined for the first time in the documentation as
> "Translation Table Maps". Afterwards, "Translation Table Manager" is
> used as definition.
> 
> Fix the first definition to avoid confusion.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied to drm-misc-next, thanks for the patch.
-Daniel

> ---
>  Documentation/gpu/drm-mm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index e0538083a2c0..198bcc1affa1 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -8,7 +8,7 @@ the very dynamic nature of many of that data, managing graphics memory
>  efficiently is thus crucial for the graphics stack and plays a central
>  role in the DRM infrastructure.
>  
> -The DRM core includes two memory managers, namely Translation Table Maps
> +The DRM core includes two memory managers, namely Translation Table Manager
>  (TTM) and Graphics Execution Manager (GEM). TTM was the first DRM memory
>  manager to be developed and tried to be a one-size-fits-them all
>  solution. It provides a single userspace API to accommodate the need of
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
