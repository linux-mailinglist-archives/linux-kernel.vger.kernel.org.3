Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0C4DC2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiCQJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCQJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:38:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F516BCF7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:36:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x15so6447268wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1i7cT2ko1hGy64hM+B681n9QzyGnrB/xnsaByZUNh8=;
        b=bT3V2iREkpKRmBDY+g7eALtr2ZrQzwNd3hRJ8VsYaZQdh4QtwfMbuvSO2LYeQck2+m
         blb5DQOnSiZn9qqTx7mM3L6osuzQv91f7qSuuELZYtAgFdShTDmlAlhAO+/4/qeqIahJ
         w2bbZqr2KyIMqNh+SX3GTt0IaCKm1NIHnbjNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=O1i7cT2ko1hGy64hM+B681n9QzyGnrB/xnsaByZUNh8=;
        b=tmqGWH7YkAeyROJxpgw25KDGSI5xzWvNvt0wZ9ec8btkllX8ZVMijkgAAYVdFQvYcm
         vNkJyeoEplxz0HJ1HX9DK9XyDZIAdSoCmm7t36RhC/mQDAnk7/PSNwJcg0gnyw3x6mFC
         qUQy4QN1IFnvnEvegwg65HtQefJKRraA13neTtq3ifMvPuwnz4V1c2PROnlW93NtWu6u
         jlYdUHpDCMHlhTezTVj2Fn5GRFJngeQq/lhqT/2cguRK/H6v0f22dNoxUID995tNNIWr
         dM2I4x6fg/y3OZ6h8mJd/qhiE3Oy5B7VFgmlMCGqYo+R0hnC0GwnI5oxDkBdbr/qRhxM
         vbGg==
X-Gm-Message-State: AOAM530LPOuU7KZmwOz57HtOHlzmA6MFL+q33G9rXrOIYH2trFBygnpL
        KfR/EjdgJ63Jx4gYmmLFroystw==
X-Google-Smtp-Source: ABdhPJyBrD7lqlP9xmnBLxk8QITal87n7bvpbobiyjAncbEh+KRG7YowAhGzRkaFfT/qWpV6bR+A+w==
X-Received: by 2002:a5d:47c8:0:b0:1ef:8e97:2b8c with SMTP id o8-20020a5d47c8000000b001ef8e972b8cmr3264671wrc.545.1647509817467;
        Thu, 17 Mar 2022 02:36:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd849000000b00203d18bf389sm3442926wrl.17.2022.03.17.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:36:56 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:36:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        corbet@lwn.net, pekka.paalanen@collabora.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/doc: Clarify what ioctls can be used on
 render nodes
Message-ID: <YjMBN8XcQLmQJuWc@phenom.ffwll.local>
Mail-Followup-To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, corbet@lwn.net,
        pekka.paalanen@collabora.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1646667156-16366-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646667156-16366-1-git-send-email-quic_jhugo@quicinc.com>
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

On Mon, Mar 07, 2022 at 08:32:36AM -0700, Jeffrey Hugo wrote:
> The documentation for render nodes indicates that only "PRIME-related"
> ioctls are valid on render nodes, but the documentation does not clarify
> what that means.  If the reader is not familiar with PRIME, they may
> beleive this to be only the ioctls with "PRIME" in the name and not other
> ioctls such as set of syncobj ioctls.  Clarify the situation for the
> reader by referencing where the reader will find a current list of valid
> ioctls.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

Applied to drm-misc-next, thanks for the patch.
-Daniel

> ---
> 
> I was confused by this when reading the documentation.  Now that I have
> figured out what the documentation means, I would like to add a clarification
> for the next reader which would have helped me.
> 
>  Documentation/gpu/drm-uapi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 199afb5..ce47b42 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -148,7 +148,9 @@ clients together with the legacy drmAuth authentication procedure.
>  If a driver advertises render node support, DRM core will create a
>  separate render node called renderD<num>. There will be one render node
>  per device. No ioctls except PRIME-related ioctls will be allowed on
> -this node. Especially GEM_OPEN will be explicitly prohibited. Render
> +this node. Especially GEM_OPEN will be explicitly prohibited. For a
> +complete list of driver-independent ioctls that can be used on render
> +nodes, see the ioctls marked DRM_RENDER_ALLOW in drm_ioctl.c  Render
>  nodes are designed to avoid the buffer-leaks, which occur if clients
>  guess the flink names or mmap offsets on the legacy interface.
>  Additionally to this basic interface, drivers must mark their
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
