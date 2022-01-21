Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B0495D89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379957AbiAUKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349962AbiAUKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:16:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B3C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 02:16:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso27982559wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CLYJz2R+mFRqKL06xxzdwISpHcTd92SLYyoRfz6Al/k=;
        b=ImlCVd8TOUysf7M9Mfv1MzTv3rmqrgTlic/bC1gbxOJw/rZ5BQCqGg2CmfpR5Q5lcq
         k1jErxG3rifuktK2RinNxjLDxT0VsvPbki1Ge9sP/dyzSc8Y5M870vm7xymaqjqVZ27D
         gtcGfGqJ4o6c4YJepG0hUT1oQLR5U8YfpFg6ZDIz+DcZ12ztoK1tY1noAAH1+YOBdR9b
         WezQngRAvPXEvwk0ZBykKwlkQ3qo3yo3Lic3rQrp2heaERoZVQ5ZmxiZrOxei3igXxQl
         n8yLOIwZHekLh6jKCk7XVrZAj8uA7NCkLRhWBKmSZTACwumpeiBJR69bAK1m350kyBKj
         KOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CLYJz2R+mFRqKL06xxzdwISpHcTd92SLYyoRfz6Al/k=;
        b=X/keeAztB4U2JptyxMigYsUQ/OlLMMYI4X5uc/02IbTKrLVie5ImxiCaXKmuqbWMet
         c6b68eMlcBU5JspzIQjPJjse6gcJa5RMDoOzFqhlKBVMi/6Iro3QJ6Nr1TTO2iUGZHwo
         fQUM+eVQCUJxW/xBMolq2OZ4Yd7OVqPKV+HH5Ws/zyy8LRQe8CSgC+obI3fAv9ZVGhy1
         bq/ZNUbZFu7zRxgdArWBvDfKe8NN0XH7R+GjseV2zpt9ss/Gnv9am4TzeU0M5gJ4xMvC
         UtDHBmWHlbb7YvqXXEUB/qIirVGHWCt96ynHisegQEq3gpp8OUdENHvFkxo8QnIEZohe
         3VjQ==
X-Gm-Message-State: AOAM530n6oCz1aow0A6sANW+jQhAIdXe4zYwbdWz11leyU1fnIMs5DKC
        HYbC4Mj7ho3kuo/b80woGXGvFw==
X-Google-Smtp-Source: ABdhPJxiH8szE7URldCF7knvg8nx9Plh7JPmXtM2hJR79Fpi7soLXMfkEG5o/1HFNKOVFP8qEZ+DTQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr40421wmq.41.1642760180152;
        Fri, 21 Jan 2022 02:16:20 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id y15sm2219968wry.36.2022.01.21.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:16:19 -0800 (PST)
Date:   Fri, 21 Jan 2022 10:16:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
Message-ID: <YeqH8Y6+gElerxZm@google.com>
References: <Yeg11pHSqx29yg/T@ls3530>
 <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
 <87fsph4fr2.fsf@intel.com>
 <Yep6te0wrK0ZQ8SB@google.com>
 <CAKMK7uG9FaBM6e_kXFZUgBCk4JFcPCbzG5D_9XcypwVeXqDq6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uG9FaBM6e_kXFZUgBCk4JFcPCbzG5D_9XcypwVeXqDq6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022, Daniel Vetter wrote:

> On Fri, Jan 21, 2022 at 10:19 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 21 Jan 2022, Jani Nikula wrote:
> >
> > > On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> > > >> A first bunch of updates and fixes for the following fbdev & backlight drivers:
> > > >> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
> > > >> lm3630a_bl, omap2, controlfb, matroxfb
> > > >>
> > > >> Nothing really important, mostly cleanups, const conversions, added null
> > > >> pointer/boundary checks and build fixes.
> > > >>
> > > >> Signed-off-by: Helge Deller <deller@gmx.de>
> > > >
> > > > Not sure whether Linus missed this or just wanted to let the
> > > > discussion settle first. But since this is all random patches for
> > > > drivers that many distros don't even enable anymore there's no issues
> > > > here, and I very much welcome someone volunteering to pick these up.
> > > > I'd expect there's a pile more since it's been 1-2 years since Bart
> > > > took care of these and merged them consistently.
> > > >
> > > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > ...
> > >
> > > >>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
> > > >>  drivers/video/backlight/qcom-wled.c                      |  1 +
> > >
> > > Backlight changes usually go through the backlight tree.
> >
> > Yes, they do.  How were these applied to the DRM tree?
> 
> They are not applied to any drm trees, Helge jumped in last week to
> take over drivers/video maintainership.
> -Daniel

Sorry s/DRM/fbdev/

> > I don't see any mails about them being applied:
> >
> >   Luca Weiss (2):
> >         backlight: qcom-wled: Add PM6150L compatible
> >
> >   https://lore.kernel.org/all/20211229170358.2457006-2-luca.weiss@fairphone.com/
> >
> >   Xu Wang (2):
> >         backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls
> >
> >   https://lore.kernel.org/all/20220113084806.13822-1-vulab@iscas.ac.cn/
> >
> 
> 
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
