Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21E49BF49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiAYXBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiAYXBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:01:45 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41407C061744;
        Tue, 25 Jan 2022 15:01:45 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so431160oth.12;
        Tue, 25 Jan 2022 15:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj8yAEXMoW1YOr4cIyIA1NShiqvkXIc5M2zpkHZV3M8=;
        b=oppo2Xe515X+Ou6ZhtNfbWd4XPTzk5Gz1+q9j4buYOLK1QMztj43c0m/b8icFD85qu
         TXIQcIsWh0uV0Nr3JziGpama7N4NrB3/V7EKESlJ2ZHZ+dhMO6GKtmsFfKdfwYMzawgI
         3dFIPXnCNDn/1UUTc6HT4PUfpnX5TM84KwvzJhAJUZF73H4hUZqWDDgSpo6bbRj4aeQw
         ZJfjRRuvIszjhtViWlEH2AQtap95Or42BbAR8MB+k3FcNtuJaVWmg2okVVHThyB2yj/o
         yt2KOCKi8vnNvjAEheyvB0t+JW/VkL5syt7VPaDuk+Mrj7AH006ZpI1gCeyBAoNCn0nT
         EQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj8yAEXMoW1YOr4cIyIA1NShiqvkXIc5M2zpkHZV3M8=;
        b=Eo2rD8USYq7iqrJGGvrAKbpwGs7MeOeKiBGmiHK4hJRM670digu/jPH1fG27gP4xF4
         8w0NDWk1uq9+KWsxMMKPSvEfpk0T+b0Bp5a8tnGtydQyGwb4vwV63/YPNZNhG7Fn/cGC
         Nqlsg45SE2X9dt46mILgQYs35nCtSknYdsABS6w5pdvkRj7iPqas+mX8d6zsSjfAcfXg
         VUpivdDTNc636fcwYoog8d1KHvL80AmeeQ0jE6nZc2D/nooe/lVHkWZ1fE5H+4PUVho7
         dhQ9bGAxBSN9SIu/GCgVSuFTdLxEsFDfeZO6lK+fLKdGof00W0YDLZGgARiSrNDE9n5o
         q/9Q==
X-Gm-Message-State: AOAM533ma7EqWSv7NFVKTIfLag5VSMWgDJnnuh/uw6ieNSTfcwOt+5Sm
        2QfN6kUhNFBB4nM8GCZw8r7iE1ie2VgMoou0RYOpSpjY
X-Google-Smtp-Source: ABdhPJwXFT0Ka4NKG0D7RN7JlP3I5uUJqfYSY82X9BMgEsXjIGwO02MjzQpl2LiPM2/16XH/k+s/QS/y4n+2WgJ7j0Y=
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr16022996oti.200.1643151704608;
 Tue, 25 Jan 2022 15:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20220126094035.631da5e3@canb.auug.org.au> <999b1940-3e72-be82-8acd-0634ae50cda9@amd.com>
In-Reply-To: <999b1940-3e72-be82-8acd-0634ae50cda9@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Jan 2022 18:01:33 -0500
Message-ID: <CADnq5_N+CiA2wja+2ArtCTSiBdmMEA6Q2VvTqz=8Evf6XFPN7g@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 5:59 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Not sure what to do with this, because in our tree, I see this:
>
> commit 824c2051039dfc
> Author: shaoyunl <shaoyun.liu@amd.com>
> Date:   Thu Jan 20 10:39:41 2022 -0500
>
>     drm/amdgpu: Disable FRU EEPROM access for SRIOV
>
>
> And this is what I used.

I typo-ed it when I fixed it up.  Properly fixed up now.

Alex

>
> Regards,
> Luben
>
>
> On 2022-01-25 17:40, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   69bba523d97a ("drm/amdgpu: Fix kernel compilation; style")
> >
> > Fixes tag
> >
> >   Fixes: 1b08dfb889b2c5 ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
> >
> > has these problem(s):
> >
> >   - Subject does not match target commit subject
> >     Just use
> >       git log -1 --format='Fixes: %h ("%s")'
> >
> > Thus:
> >
> > Fixes: 1b08dfb889b2 ("drm/amdgpu: remove gart.ready flag")
> >
> > or
> >
> > Fixes: eadabcc2bc6c ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
> >
>
> Regards,
> --
> Luben
>
