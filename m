Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B6489C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiAJPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiAJPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:36:20 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E38C061757
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:36:20 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so15346354oti.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATxtiYXvw3f0w5oe53WLDKO2TXCGgBhdfvvMrUcEva8=;
        b=RVKy991vsKZPUqeSDvtT2c9YiyufQrUJFAro3GIl16zm2A1XBsIfj41jeCAJyNNvZX
         fJWenSLCEqON+23Z9Fgua1U/hnSfW9NSgCEYmivvAwGhsdRW5Be2MM7+ME6WxDWUSnKz
         w0/63zBwzHpVY4Vyh6NTnG4VEau6+75eZO6VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATxtiYXvw3f0w5oe53WLDKO2TXCGgBhdfvvMrUcEva8=;
        b=MmXWfD1dVAcQNO9WV6uImf+dbOp4yGeyIYbXca1Zs2gVuYfaqFU1hJgaGGNhdhrjdO
         Adx3udIwSCU2YB50+tNofnl+m+v8t0VY6EisjIbiBZHcQg3G4eNBTKeMfWjdK26CpnGy
         l72Gw3blGS59Vn+u54CnDvFTX1BgSoWZukOGiHYBHt1BhHprhB1MS1ToQZ9vya635tsg
         sdsn09Gs0V2rUASIvdJfllbdLwrv428xfcBZilFNEAtXtJztRFYVJDnHd9mq4gJkr1Bs
         iJZjbqEIv81lWWQ6F8k6yeI1gIJaV3bgslhv17DuhOpChvszLhPf3epMLJpK3FgOBANO
         lutg==
X-Gm-Message-State: AOAM532cXR15+JxbzjYVrs94WCp7Ry0swFrdmfZUqsBkmmCFiS4WyzEy
        lQvIye01on0kTEdXVxzUJSmFG6saYzbE/E1hdklTbQ==
X-Google-Smtp-Source: ABdhPJw01Lr6GKe3wvkwZbJM4Hvg5bnDiT/nQ6OYafRt8sdo7mWRLMgoKS0pl4fnXWSVt3gc0IRwJu6VUhJw8/ztu9Y=
X-Received: by 2002:a9d:685a:: with SMTP id c26mr217105oto.239.1641828979718;
 Mon, 10 Jan 2022 07:36:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twnYJ8SrVzJEEH+Vksibomvk5CE+Nn6BXKYwLG_8r=GJQ@mail.gmail.com>
 <CAHk-=wiyfiVoci-LHaY=e70zOpAoUqwoaFF4iD3xm847PkK1CQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiyfiVoci-LHaY=e70zOpAoUqwoaFF4iD3xm847PkK1CQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 10 Jan 2022 16:36:08 +0100
Message-ID: <CAKMK7uE_89hiD=C4z9i_XBPCqCAnL1SzXbzHqwOrCphFZKtUWg@mail.gmail.com>
Subject: Re: [git pull] drm final fixes for 5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 6:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 6, 2022 at 7:23 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > There is only the amdgpu runtime pm regression fix in here.
>
> Thanks, from a quick test it works for me - the backlight actually
> does eventually go away.
>
> It does so only on the second time the monitors say "no signal, going
> to power save", but that has been true before too.
>
> So I think there's still some confusion in this area, but it might be
> elsewhere - who knows what Wayland and friends do. At least it doesn't
> look like a regression to me any more.

Well it's not a true fix, just a "go back to exact old behaviour, but
limited to relevant gpus for amdgpu only" so that i915 doesn't
regress. I think there's some more debug to do here and
Alex/Harry&team can look at leisure now :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
