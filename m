Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171D4924A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiARLTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiARLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:43 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C52C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:18:43 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bb37so242294oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa1dZG4GoQTrXlzOi6DDYuer/mOyHhSLIkqIRyNfCb0=;
        b=fuf/49aasH2ICZ5tiYtVjQdBuAqwceTPNFDeB2rPyXb5ynaEJYfpZPt98OPIWjHB9A
         SixKkvj07y2F7xGCnTcxaJk5Rpwb349v98j/8S5jwou/75iGPEOmUFL/p/+/9hfvK/mf
         tMBRo5/5GEbk14QLHVOhXOJ/O5l/4D6Q8nsQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa1dZG4GoQTrXlzOi6DDYuer/mOyHhSLIkqIRyNfCb0=;
        b=qGLiHNEzsFb74DPhs60gslpx8n+jgGUPY0rOM1W7ekZDkp+/KjAR10tnf+syGwLLRD
         sW1kyMnqj9G54a6EAPUHP+yFn8ystozAafA9BAOvXiEy8OrNzlsF7kwMljwR36TOCT4g
         +x39tOKSHLJX5kJ/dMXbAiSwaFXHQckWhRIRQk6jOMj2JJw/b3TnI17UNzuc8VbsXvoA
         5dV1LL24AobRgvRn9GB3pWVXHDK1ztT3rwpMZlZIn34SOBU5hvwcVbn4O4riOi8zuECe
         RCIWdau2kxiwKGNzmsBxq0eBTnfIxzQyKL5rBfZ8VTrklDQxWaJpQ7xyqOjL36RPmJKZ
         88dg==
X-Gm-Message-State: AOAM532lQAsXNavo1iO2j1c+2UM4POHEqAsFXehx7V/3cAXfMHABjWzV
        YQB7+ii0gDE7dAPTmh7GogwuHBAjpOCBCQXpRQK0Xxa42c8=
X-Google-Smtp-Source: ABdhPJwaiWOvuwzgv58eTEUe46jNmMAihEdSp5q+fSNBT1IED8/qYXBr7kRmRyn8hc73vcobXONscKk/imKt+JwYtY4=
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr12412474oie.128.1642504723007;
 Tue, 18 Jan 2022 03:18:43 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <87ee5659dt.fsf@intel.com> <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de>
 <87a6ft5thv.fsf@intel.com> <5ba33e10-7d75-9f9a-dfd6-c04608d230a4@gmx.de>
In-Reply-To: <5ba33e10-7d75-9f9a-dfd6-c04608d230a4@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Jan 2022 12:18:31 +0100
Message-ID: <CAKMK7uG48Due9Tv_78BJT52hvC5JcbT6-7S6_Qt7FiZ-GrTRzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 9:56 AM Helge Deller <deller@gmx.de> wrote:
>
> On 1/18/22 09:38, Jani Nikula wrote:
> > On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> >> On 1/17/22 22:40, Jani Nikula wrote:
> >>> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>> Seems like few people read linux-fbdev these days.
> >>>
> >>> How much traffic is there to linux-fbdev that is *not* Cc'd to dri-devel
> >>> also?
> >>
> >> Doesn't seem like much traffic - which IMHO is OK for such a tree with
> >> mostly just maintenance patches.
> >>
> >>> Do we still need a separate linux-fbdev mailing list at all?
> >>
> >> Yes. I want to have it seperate of dri-devel.
> >> Actually I'd prefer to drop dri-devel from the list where patches
> >> for fbdev are sent...
> >
> > Disagreed. If anything, this thread shows we can't have fbdev and drm in
> > silos of their own.
>
> Patches to fbdev usually don't affect DRM.
> Patches which affect DRM needs to through to dri-devel.
> In addition this would take the burden of the dri-developers to receive
> unrelated fbdev driver updates and patches.

I added dri-devel for fbdev because stuff landed that shouldn't have.
Let's not remove that, because the amount of patches for fbdev which
arent relevant for drm drivers is pretty much nothing.

I really don't like the idea that fbdev goes off again becoming a
silo, just because it's too hard to wire through low-bit greyscale
support. Which no I can't type for you, because I don't have such hw
here.

Everything where people cared enough for adding fbdev compat support
for to actually write a patch is supported.

If you do want a silo  for fbdev then I think the only reasonable
option is that we create a copy of the fbdev/fbcon code for drm
(somewhat renamed), so that you can do the reverts without impacting
drm drivers. But there will still be some overlap and minimal
coordination, plus I'm not seeing anyone from the drm side
volunteering for the sizeable amount of work.
-Daniel

> > Also, if the patches continue to get merged through drm-misc, they need
> > to be sent to dri-devel.
>
> Helge



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
