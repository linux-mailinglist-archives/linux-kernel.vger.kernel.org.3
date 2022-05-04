Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94C519C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347656AbiEDJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiEDJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:42:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125E275C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:38:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so1035624edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=v445vAlme2zlrPL6XrM4JniIviakM8QqlAR33SjZ/5E=;
        b=hM2bbzfYB9M+Ca6zJVRzpxwIn7EMB8SBN8mUvDSIzsa+xWIcfUGlTfwqzMYyRTSfXm
         sisamAPFM5rcXf413mOFntR5wifzmK2GIzilqLQcVqKa74yGBGZzrTgfmApi2V4lxIkn
         D00G1ZxDPYQLCbCzPIezeBFYNL+fl0wRhgsPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=v445vAlme2zlrPL6XrM4JniIviakM8QqlAR33SjZ/5E=;
        b=z9yuB+hbIQ4SuLF8mlqMc0wH1cYZNIVpa4rA0squIMRkB6Tj2/378jt3N5KzHZXk/5
         8AebK0uC0wtdwv/1/yU4Cmg2M8AtskfYel167Tgx1hpEA3f3LQiCVc4kx4CxnUHbGeF/
         8yhu/VMq2tL+A+A4J96cTBsKE+DROA1ho6LbLm+mt/9XWz0jwS4Rb6SG8kWP0Qdo+qhv
         SzkBVyHRyzmPglbTkkWHhNhGdv6Z2yNp26DT/9W0fNqjTsI0fbacvRTyv873+czWMtTZ
         QC8fXKG2KzUDqM8A5HSc1oV5/M5X2xTAM99gocgONaX4eoZSBMWZxkoANFShGuI3RJkK
         yzaA==
X-Gm-Message-State: AOAM531/dha1nqLcgrhhO68icprPQFjGT1qHonqPyAIwCdCdgSZu3lmJ
        r9kToIvEOyJu6x3exNBv0xkLeQ==
X-Google-Smtp-Source: ABdhPJyvZnRAfF291GMqjz7DLqK6y4u0GKdaL17PBCM4iimO9RBWYJ1fAx8Vy9Brbgoj0DSchPP6sA==
X-Received: by 2002:a05:6402:42c4:b0:426:a7a8:348f with SMTP id i4-20020a05640242c400b00426a7a8348fmr22175278edc.341.1651657133662;
        Wed, 04 May 2022 02:38:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gv8-20020a1709072bc800b006f3ef214e5csm5520368ejc.194.2022.05.04.02.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:38:53 -0700 (PDT)
Date:   Wed, 4 May 2022 11:38:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: drm_gem.h: Add explicit includes for
 DEFINE_DRM_GEM_FOPS
Message-ID: <YnJJq6UdCVIWcH3G@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1651262112-29664-1-git-send-email-quic_jhugo@quicinc.com>
 <87y1zkq6vg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1zkq6vg.fsf@intel.com>
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

On Mon, May 02, 2022 at 06:41:39PM +0300, Jani Nikula wrote:
> On Fri, 29 Apr 2022, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
> > DEFINE_DRM_GEM_FOPS() references drm functions from other headers.  For
> > example drm_open() is defined in drm_file.h and drm_ioctl() is defined
> > in drm_ioctl.h.  Since drm_gem.h doesn't include these headers, it
> > relies on an implicit include from the .c file to have included these
> > required headers before DEFINE_DRM_GEM_FOPS() gets used.  Relying on
> > these implicit includes can cause build failures for new code that
> > doesn't know about these requirements, and can lead to future problems
> > if the headers ever get restructured as there will be a need to update
> > every downstream file that includes drm_gem.h.
> >
> > Lets fix this explicitly including the required headers in drm_gem.h so
> > that code that includes drm_gem.h does not need to worry about these
> > implicit dependencies.
> 
> In the general case, I tend to agree, but in this specific instance I
> think I'd err on the side of fewer includes. I think the more likely
> outcome here is accumulating implicit dependencies on symbols from
> drm_file.h and drm_ioctl.h by including drm_gem.h only!
> 
> I do think headers need to be self-contained, and we actually enforce
> this in i915 (see HDRTEST in drivers/gpu/drm/i915/Makefile), but not to
> the point of macro expansions.

Yeah we abuse macros in a bunch of places to untangle header dependencies,
so then going back and pulling in all the headers back in feels a bit
silly and defeats the point.

iow, I concur.
-Daniel

> 
> BR,
> Jani.
> 
> 
> 
> >
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > ---
> >  include/drm/drm_gem.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 9d7c61a..1cbe3d8 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -37,6 +37,8 @@
> >  #include <linux/kref.h>
> >  #include <linux/dma-resv.h>
> >  
> > +#include <drm/drm_file.h>
> > +#include <drm/drm_ioctl.h>
> >  #include <drm/drm_vma_manager.h>
> >  
> >  struct iosys_map;
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
