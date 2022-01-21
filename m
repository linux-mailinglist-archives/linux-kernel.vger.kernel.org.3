Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56900495CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379719AbiAUJTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379716AbiAUJTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:19:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A71C061746
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:19:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c66so16675346wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GYdREzPPehBfIAVKcYM846GIJdP7RKGamqemruCZcS8=;
        b=YHlPtVnKvW1tZAk5y/iTR0nITKiyB3iCFvLzRlfP41zV6VrKL0c0N7KJsPOXp+5rdL
         32FO6WUkOaOXRi/uBMfATqJ0n21gw/c2z9y7IQ53FIHJXaliEkqH2+50UVCstmNLCcwW
         sGWIqVvk2N8r52eK6/xDqs52pGF0lCEkw7/7aKNPdgQBSuuIZQDO8LcmKWsBA49qQxpk
         xdcqc76bxg8MVzwh7Vz+RwMvN6QaBM3CeaHBbwEEdyeuQqd/Wu7bC2nkpzRBu2AzAHst
         mM0FlaB89t1y/4BXLKpby+rtp7+zK+n7paMshOao6GrdDPU66WTzNOkgiteYUDyKy4a2
         jnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GYdREzPPehBfIAVKcYM846GIJdP7RKGamqemruCZcS8=;
        b=J7RHYII0y7NLGqcJ4JZ1pmymAARVLZAWDyS4Js6JD6VoZ8GrQQfX02fYHa9WV8QkpT
         IYk5RnNYRfIXMjAjSkCYIDPqez0rAqwPrWwCoh4PCftdnb8eG/8Y1kgcjNUi+D806Ea2
         Ru9s8jmCfTtVr3Aha7VcoOE1IFunhwyzP8Ps1rKH1yDtzMza8QQII/3cGNwVF6GTu/5u
         SM4jzkHFJfbA0g0gP5f1eA4Bv4QzF7+jKoCWhiIqywfPZgk7ssuXyfurkU8xXoTPEOrt
         8OcYRRIPzuUpNb4SJBKifhA9mCRVePayMKtJnN3rOjpxqf3mtngL221urEOFCZM82IOq
         lOwg==
X-Gm-Message-State: AOAM531/M8PBur+d/h1iUK+6vn9XAykHHWQAavkvrorvOaGVANaPWWKC
        PKVvCy2tYExf4ztlWAKQTmVspw==
X-Google-Smtp-Source: ABdhPJzlxVLbKAQa65mfmbQ6ypNKFfoSvb0OzD41M5HKQ50KGmx7X1+TN0mlVpv4dIJ7DS1bjvlrHw==
X-Received: by 2002:a05:6000:1ac9:: with SMTP id i9mr2958493wry.349.1642756792164;
        Fri, 21 Jan 2022 01:19:52 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id k8sm4604422wms.15.2022.01.21.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:19:51 -0800 (PST)
Date:   Fri, 21 Jan 2022 09:19:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
Message-ID: <Yep6te0wrK0ZQ8SB@google.com>
References: <Yeg11pHSqx29yg/T@ls3530>
 <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
 <87fsph4fr2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsph4fr2.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022, Jani Nikula wrote:

> On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> >> A first bunch of updates and fixes for the following fbdev & backlight drivers:
> >> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
> >> lm3630a_bl, omap2, controlfb, matroxfb
> >>
> >> Nothing really important, mostly cleanups, const conversions, added null
> >> pointer/boundary checks and build fixes.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > Not sure whether Linus missed this or just wanted to let the
> > discussion settle first. But since this is all random patches for
> > drivers that many distros don't even enable anymore there's no issues
> > here, and I very much welcome someone volunteering to pick these up.
> > I'd expect there's a pile more since it's been 1-2 years since Bart
> > took care of these and merged them consistently.
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> ...
> 
> >>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
> >>  drivers/video/backlight/qcom-wled.c                      |  1 +
> 
> Backlight changes usually go through the backlight tree.

Yes, they do.  How were these applied to the DRM tree?

I don't see any mails about them being applied:

  Luca Weiss (2):
        backlight: qcom-wled: Add PM6150L compatible

  https://lore.kernel.org/all/20211229170358.2457006-2-luca.weiss@fairphone.com/

  Xu Wang (2):
        backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls

  https://lore.kernel.org/all/20220113084806.13822-1-vulab@iscas.ac.cn/

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
