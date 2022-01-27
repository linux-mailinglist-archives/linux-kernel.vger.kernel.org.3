Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96DC49E0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiA0Lbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiA0Lbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:31:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D26C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:31:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso5670330wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkClxaa+2C8a0Gjj8wVr84ck/Y/nk6VOxGU9yJzk5zg=;
        b=LiJaUPMq92a9bfWZNpvKXwGghvP4zSBcAMDzeZ/ReWu44m0+N68+ddiTjdr8P02zXx
         zaH+11MhDX1nAmKSJIcan2E3OYlZzK6odIWYyzvDS+K83UQ/qJ4v4DJDbLTFOHFhGkWT
         RizQFMxXQrQ3WuwfTgWdmBr6i5ncNvUlw8Me0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hkClxaa+2C8a0Gjj8wVr84ck/Y/nk6VOxGU9yJzk5zg=;
        b=XtBa+YYXhUEFdcBHhNnlzDnM9NUI+fW65T4bcHHrvihleqxdQMO77QT3k/f34YBsdD
         6v12cdRdFk+NDFX/TCEhbHaQAf6Mtsz4oX1s6FxqbjDcdrRXY36twTiKoCaEPqH64pa0
         uks/2sR5VM+O+oCYh+8iOI1mMyxE/2iIAjS4yoxs6LPe8Zc12RYioim0ssxSkrBsAOQY
         UGmK0Nhao7lhLgNfduuSp9WCHIYr+/RJ9yZ22Tkb3z3x6D7oPeR3TyAYjr55t1Y9sGIs
         JgOtptHLpsC/me0SDy8jG3UnFPqVoB+2TGA+zm+a7RDCc8ulZmVPTkoRxp+Ed5Jc6uRh
         KLCQ==
X-Gm-Message-State: AOAM532Yx7dccKrhPUiJbXKMMEhnnk2ILGgD6ZyZA1AiUhHvuD0rPYMn
        KfkT+QkK1qHbeth8zotc/MqYig==
X-Google-Smtp-Source: ABdhPJzsSgHQc4/Sisg9p2IJQo1l/N+Y/KjTBTOmd8sk+y5btszDk60YCnmxc1l3iGgHjdXMSGgnwg==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr2780924wme.43.1643283107438;
        Thu, 27 Jan 2022 03:31:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5sm2288561wrb.113.2022.01.27.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:31:46 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:31:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pekka Paalanen <pekka.paalanen@collabora.co.uk>
Subject: Re: [PATCH] drm/doc: Add section in the introduction page about
 learning material
Message-ID: <YfKCoOk2sxDzHVXv@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pekka Paalanen <pekka.paalanen@collabora.co.uk>
References: <20220127082058.434421-1-javierm@redhat.com>
 <c99a7784-7ac4-e305-1a06-dfb514a409ff@suse.de>
 <b305cb36-1a09-c990-a3e6-98d420c62e3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b305cb36-1a09-c990-a3e6-98d420c62e3a@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:50:30AM +0100, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 1/27/22 10:18, Thomas Zimmermann wrote:
> > Hi Javier,
> > 
> > thanks for this patch.
> > 
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> 
> Thanks!
>  
> > Find some ideas for consideration below.
> > 
> 
> [snip]
> 
> >> +
> >> +Learning material
> >> +=================
> > 
> > Maybe 'External References'.
> >
> 
> Agreed, I'll change it.
> 
> >> +
> >> +Since the Linux DRM layer supports complex graphics devices, it can be quite
> >> +overwhelming for newcomers to get familiar with all the needed concepts and
> >> +learn the subsystem's internals.
> > 
> > It sounds a bit intimdating to me. Can we give it a positive spin?
> >
> 
> Pekka also had reservations about this paragraph, so I think that will just
> drop it. The goal of having this section was to ease the learning curve but
> the way I worded it may reinforce the perception that DRM is hard to learn.
> 
> > IMHO we could add a separate section that talks about complexity and 
> > provides guidelines about how to deal with it:  trivial HW? use simple 
> > pipe;  dedicated VRAM? try TTM;  awkward color formats?  see 
> > drm_format_helper.c
> >
> 
> Indeed. And we can add such section as a follow-up. Maybe referring to some
> of the drivers in drivers/gpu/drm/tiny.

Do we have a talk anywhere for tiny?

Otherwise I think it'd be good to just add a paragraph about "hey tiny
exists" and maybe link to fbdev helpers and simple pipe helpers to get
people started with the right entry points for simple drivers.

And make it clear that the above pile of links is more for general
overview and if you don't yet know what exactly it is you need.

Also I guess for this year's xdc I really need to volunteer someone to do
a drm/tiny intro :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
