Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9F4D6D48
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiCLHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCLHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:47:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9F234050
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:46:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qa43so23374081ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opm0RTYgKsezOjMybsaQMQvfYC2eFXeXWanMke4xljQ=;
        b=doCEK9S9d11Ijh3AYCuvnbhhbjt1qtI9IrlKFVyEJL82m7ptsCxASUOlgeWaBQpEKQ
         nj6OghomR4bQiFV/g7IDhRPKlaenccetxNreiB2DmLnlR44omRF0smVkECSNlSVgTjoV
         gnv/L3jw2YY3mariSCK9RCrsjR4H6lX/F/MIwZYOsT9Uh/VJ9CGQ0fzpCxW56lTkKCQu
         8FaHi3F25wOwSgdZMVHrxIHYDNg82VRLveU8q7NaF9QSW9+oL/A6BgVnMD2VdqJlVh+c
         6XTcXoLfD+7Nd7wZr4FBCbhdKgMo78PFk2tx9Gl9eiaFjzAvNckPj/jjovp7y422kz6t
         WfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opm0RTYgKsezOjMybsaQMQvfYC2eFXeXWanMke4xljQ=;
        b=JNKFpq/QKGvZmdpQZ+lvKN3jTp9UteIHfZ3XyY+PxY2Yc5zbQB6Jk/wbWGL0HqmYp5
         DVkGNrcilkHP+Qgk9CzLg4WQGh6QQubWk19uL/bt1c2Hf5HNa5ROSmzwKtbLlrl0hzOj
         zLuSplKOlTg+hCKJsBZbvXaJl4sJk8mi1JALFQvHi2h/gYq+QRnCwIePrMw1crbL/2Fq
         RfHz89n/yvo6Bklvcg4aJpfoA+skkIjFyVhO86Z25KIz7TcrW99xHHmOGwzNcxwfDcxd
         YBXdxivNsPD2cJIOTS/+ccbhWDDeVze7jAFmwIfocjn9wjyWMU2w4XID4eXzcgHrBbrf
         /5Ug==
X-Gm-Message-State: AOAM5311E+5I/pNINnP4gpxjxTWHufGe8JCZrkPpn74RUyS3N6AZnX/A
        GcDYRglpbEyk/A+UNN04WZjW2r/CD1Slbigzg+0=
X-Google-Smtp-Source: ABdhPJw1/g3wq98ZWZ7Mub/gSMRzcKLI2KSYxEUZBwFPH9q46gVskXknhgzycEgPOLrxJEcqlXSe/EjRm92OzoRwM0w=
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id
 hd15-20020a170907968f00b006dba3c5ae3emr5601661ejc.770.1647071189988; Fri, 11
 Mar 2022 23:46:29 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
 <c5d6fd7b-54ff-e407-2da8-ea2a6157fbff@leemhuis.info>
In-Reply-To: <c5d6fd7b-54ff-e407-2da8-ea2a6157fbff@leemhuis.info>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 12 Mar 2022 17:46:18 +1000
Message-ID: <CAPM=9twQe2S11C+kLBLbqt1aabnu8x79BZugRnjg6aN4NBvw-A@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.17-rc8/final
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 at 17:51, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 11.03.22 06:15, Dave Airlie wrote:
> >
> > As expected at this stage its pretty quiet, one sun4i mixer fix and
> > one i915 display flicker fix.
> >
> > Thanks,
> > Dave.
> >
> > drm-fixes-2022-03-11:
> > drm fixes for v5.17-rc8/final
> >
> > i915:
> > - psr fix screen flicker
> >
> > sun4i:
> > - mixer format fix.
> > The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:
> > [...]
>
> Out of curiosity: I might be missing something, but why wasn't the
> (afaics simple) fix for a build problem caused by 9d6366e743f3 ("drm:
> fb_helper: improve CONFIG_FB dependency") (merged for v5.16-rc1) not
> among these fixes? I mean this one:
> https://lore.kernel.org/lkml/20220203093922.20754-1-tzimmermann@suse.de/
>
> It's sitting in next for a few days already:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eea89dff4c39a106f98d1cb5e4d626f8c63908b9
>
> I already asked a few days ago why this fix was not on track for merging
> in this cycle, but I didn't get an answer:
> https://lore.kernel.org/lkml/782a683e-c625-8e68-899b-ce56939afece@leemhuis.info/
>
> Fun fact: It seems the problem and at a rough fix were already kinda
> known mid November when 9d6366e743f3 was still in next:
> https://lore.kernel.org/all/20211117062704.14671-1-rdunlap@infradead.org/
>
> Then the issue was reported again two times in February:
> https://lore.kernel.org/dri-devel/CA+G9fYvN0NyaVkRQmA1O6rX7H8PPaZrUAD7=RDy33QY9rUU-9g@mail.gmail.com/
> https://lore.kernel.org/lkml/YhofdlzadzRmy7tj@debian/
>
> And the fix is relative simple, that's why I wonder why merging is
> delayed. What am I missing?

My radar just missed it, though someone else should have realised it
was necessary on fixes earlier, it also had incorrect Fixes: tagging,
so I fixed that and sent it to Linus,

Thanks,
Dave.
