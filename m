Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2582848464A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiADQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiADQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:56:16 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D77C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:56:15 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id w13so76017602ybs.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuUzzCM3nnuYuvtfO1tfNIRyalOFRtKhum93Q0q5wBc=;
        b=UBTRkNLJxtIMDJ6OLdFOIEqb/ecIxV6S0BQzJY53jQvxxPcUz7XAm6UD7zAHZObT9Y
         N2FzhP/NXSo9UTVBOJmehckUybL9rwBWmkUHRhz4umyFSac1qQIQ8zt1ooii4wEqMcD6
         OKZtXEnNBr7oU/4NefOvzFJhV2ezSJDVO5nbLUnGdBv9MpSZbxLPki/0dd8HKntyI5jT
         aT7vfbUmzG8rZmnxnbhYyvKdNfGQziumZBy6jjoi+dc2QHI4FSB2Rt/6JMJomApsxspC
         wTLOwabrDOHfXWPfC4xYSPCdbHwrcBO50HfUMZJejc+tc6nWycD/jCJ4QbdIBrkU1dYn
         7Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuUzzCM3nnuYuvtfO1tfNIRyalOFRtKhum93Q0q5wBc=;
        b=Skv3YYY06F4kyoCvftZHRWJbQcahZBp0YcZqz6jqTy0h4erlojLVSaTm4oh5KcKsPA
         ycs+a9RCXbCKcXW5hIf60WgOlIQ6oo/3U/M86ULFoCxEM4eRZ7k29hXkzTrEjxVkSLZ7
         hLMZEicw2cp+IA22+iiunGIatiAkutJs/gxt+OkPkFW+8KUjPZGZEfAzfE3Wx2xyv49e
         0anndopK2TX2JkFqDIoHCDOk1LKvoWP+wTsy5DdWY5zBSL4xbuLVvuzRa3/xXHmpI/Jd
         aT7g7sBwPiQk1JLUvFt4IlBje4sJjj+6kW4iqxiImwD2kqy2pxvPsjM3L9rpN9CHRTIs
         orBA==
X-Gm-Message-State: AOAM533/3QFW3IiH34HYpVJsjT6Fw/q/paAPv66qzOpPTikpPMSc2lfv
        2QYiezzwH3ViM2QLOj1/bsu7GO0vhJgs2DkF/wM=
X-Google-Smtp-Source: ABdhPJzMV/dD3wcr+hjr0asqo1Y9ZhOjb8gtKwkA9wUaT5tf5LYB8SZmWc41tAqREEWoe2XAx4L16ghFmRxejGnT7Ng=
X-Received: by 2002:a25:880d:: with SMTP id c13mr65300907ybl.720.1641315374501;
 Tue, 04 Jan 2022 08:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20211110220050.2854-1-jirivanek1@gmail.com> <CAG3jFyvB-Dzd9YDJ7FrAC5avobL7Wfk-91E-DVeYWwfNcQLiLg@mail.gmail.com>
 <CAGWqDJ5ZKJ0skLnhfhC0cbzNnSo7HLY7Cqr2ZhOcb_YiHNsA1A@mail.gmail.com> <CAG3jFyt1nvtkDC2r3wc+3ky_VxtZ7s4Rto_+kMg6J_x1=QpO-Q@mail.gmail.com>
In-Reply-To: <CAG3jFyt1nvtkDC2r3wc+3ky_VxtZ7s4Rto_+kMg6J_x1=QpO-Q@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Tue, 4 Jan 2022 22:26:03 +0530
Message-ID: <CAGWqDJ6eUqm+NiA5dAR_GNGtjjBiYQom3gyGn49i1PhwxfVGvg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for dual-link LVDS
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Jiri Vanek <jirivanek1@gmail.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,
What is R-b tag?


On Tue, Jan 4, 2022 at 7:21 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Jiri: Are you able to test this patch?
>
> Vinay: Could you supply a R-b tag, if you feel that it is warranted?
>
> On Tue, 14 Dec 2021 at 09:13, Vinay Simha B N <simhavcs@gmail.com> wrote:
> >
> > Robert,
> > I do not have the hardware to test this feature. Sorry for the late response.
> >
> > On Thu, Nov 18, 2021 at 8:20 PM Robert Foss <robert.foss@linaro.org> wrote:
> >>
> >> + Zhen & Vinay
> >>
> >> This patch looks good in itself, but I would like to see a tested by
> >> tag. At the very least testing for regression in single-link LVDS but
> >> ideally some third party verification of this patch.
> >>
> >> On Wed, 10 Nov 2021 at 23:01, Jiri Vanek <jirivanek1@gmail.com> wrote:
> >> >
> >> > Fixed wrong register shift for single/dual link LVDS output.
> >> >
> >> > Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
> >> > ---
> >> >  drivers/gpu/drm/bridge/tc358775.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> >> > index 2272adcc5b4a..1d6ec1baeff2 100644
> >> > --- a/drivers/gpu/drm/bridge/tc358775.c
> >> > +++ b/drivers/gpu/drm/bridge/tc358775.c
> >> > @@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
> >> >  }
> >> >
> >> >  #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
> >> > -#define TC358775_LVCFG_LVDLINK__SHIFT                        0
> >> > +#define TC358775_LVCFG_LVDLINK__SHIFT                        1
> >> >  static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
> >> >  {
> >> >         return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
> >> > --
> >> > 2.30.2
> >> >
> >
> >
> >
> > --
> > regards,
> > vinaysimha



-- 
regards,
vinaysimha
