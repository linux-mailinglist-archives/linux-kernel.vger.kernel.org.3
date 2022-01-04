Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E48484382
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiADOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiADOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:37:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DAC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:37:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p14so27237572plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ba6Ub/A0lPMMoXtyIIeuHTcGAbNHFYM2vP9dl7sGMEk=;
        b=ygG8Aq1rlaIlTiXCrdFc26v2RvT9Nl7oTAfZ0AZzanbdGWM6Un5f6uG/bJSGn6baUj
         9A6DenkOZ20KRO615Bo3godzyIGVMHGpxb9VbR9mYEujNgaQKUcN/7MWkDnPwNCmvmzH
         5ogH1Wvi1mn18g+CLoIV2FVyWYvVouywDtTM9mxmzqWSYFFuaA+f5gOgdynbfjRZ0XYx
         ENrYMJmjDn9eBZYkLxUmwGZ2JL+xXuMZyIom/JYHTEwEhKItZn9+Z3U48BsexdBETxk9
         Eu9Xvtp48VMZyFhLHiBl6LWT3bHTmHz8LdNPgU2j3EjmJCb0oAHWWuo0jkprLbvP7Z3/
         eOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ba6Ub/A0lPMMoXtyIIeuHTcGAbNHFYM2vP9dl7sGMEk=;
        b=3jOWiMTdvDXcONBIV28Ps20p+DvEEFVKfMoLILVq0x1g945yisE1F8UdPGRdjXXIIG
         P6O5gv9Npxf2LfWSkXONKQvy52p31QNP/3kUfvWig2gzt97Vim+YhgnpJc9AdMny/hwG
         ONY0YGJLdZwNFFCLBr02dvIkOMU+EL8eYwiIoJK64sqwWdOXJmTvif9IrXIT8R+rY5TI
         p7/3sAKLaYZdWwBkwFNamoGYuAurJLxC1Z0JkvsRieFoJHXMV177V+pBrign3pMOoeGy
         YZm2pVbQFd2Oj+WqiqpnnvcYaxEsqiznPPFZu69vudyFXecuEAjKQto3+MyEVnzaGv0a
         /2cA==
X-Gm-Message-State: AOAM533Oe+MsLbyvlMnr8vKDa0DTPHJA0yI43LhpO6zIOvXYPQw22bNs
        bUjT1HtVZAhPrPNLzmgbmAr+LN4TIGMtTqmJylsX0A==
X-Google-Smtp-Source: ABdhPJyxXpQ3SZaGckeNU85xnpDX3fWx3PiYQSh7DZvnd63LlPMNHQ9hKgz5OQgH6t6bwXvXkxZa/kmsDLJs+hz+Kz4=
X-Received: by 2002:a17:90a:a6d:: with SMTP id o100mr61866726pjo.179.1641307028333;
 Tue, 04 Jan 2022 06:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20211110220050.2854-1-jirivanek1@gmail.com> <CAG3jFyvB-Dzd9YDJ7FrAC5avobL7Wfk-91E-DVeYWwfNcQLiLg@mail.gmail.com>
 <CAGWqDJ5ZKJ0skLnhfhC0cbzNnSo7HLY7Cqr2ZhOcb_YiHNsA1A@mail.gmail.com>
 <CAG3jFyt1nvtkDC2r3wc+3ky_VxtZ7s4Rto_+kMg6J_x1=QpO-Q@mail.gmail.com> <CAECvnWLivbpHQc1Qu0NowXFhSHgQModwcwG0=zviqmGPxnjUHg@mail.gmail.com>
In-Reply-To: <CAECvnWLivbpHQc1Qu0NowXFhSHgQModwcwG0=zviqmGPxnjUHg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:36:57 +0100
Message-ID: <CAG3jFytx_vzwcLKa8p4RE5dbyjBe7NwMz5ECYwNF2utD7LDBLA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for dual-link LVDS
To:     =?UTF-8?B?SmnFmcOtIFZhbsSbaw==?= <jirivanek1@gmail.com>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent.

Jiri, can you add your Tested-by tag to this patch?

On Tue, 4 Jan 2022 at 15:29, Ji=C5=99=C3=AD Van=C4=9Bk <jirivanek1@gmail.co=
m> wrote:
>
> Actually, this patch is based on testing with a real HW with dual-link LV=
DS display (full HD) and it also matches with a datasheet. Without this fix=
 it does not work at all.
>
> =C3=BAt 4. 1. 2022 v 14:51 odes=C3=ADlatel Robert Foss <robert.foss@linar=
o.org> napsal:
>>
>> Jiri: Are you able to test this patch?
>>
>> Vinay: Could you supply a R-b tag, if you feel that it is warranted?
>>
>> On Tue, 14 Dec 2021 at 09:13, Vinay Simha B N <simhavcs@gmail.com> wrote=
:
>> >
>> > Robert,
>> > I do not have the hardware to test this feature. Sorry for the late re=
sponse.
>> >
>> > On Thu, Nov 18, 2021 at 8:20 PM Robert Foss <robert.foss@linaro.org> w=
rote:
>> >>
>> >> + Zhen & Vinay
>> >>
>> >> This patch looks good in itself, but I would like to see a tested by
>> >> tag. At the very least testing for regression in single-link LVDS but
>> >> ideally some third party verification of this patch.
>> >>
>> >> On Wed, 10 Nov 2021 at 23:01, Jiri Vanek <jirivanek1@gmail.com> wrote=
:
>> >> >
>> >> > Fixed wrong register shift for single/dual link LVDS output.
>> >> >
>> >> > Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
>> >> > ---
>> >> >  drivers/gpu/drm/bridge/tc358775.c | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/br=
idge/tc358775.c
>> >> > index 2272adcc5b4a..1d6ec1baeff2 100644
>> >> > --- a/drivers/gpu/drm/bridge/tc358775.c
>> >> > +++ b/drivers/gpu/drm/bridge/tc358775.c
>> >> > @@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32=
_t val)
>> >> >  }
>> >> >
>> >> >  #define TC358775_LVCFG_LVDLINK__MASK                         0x000=
00002
>> >> > -#define TC358775_LVCFG_LVDLINK__SHIFT                        0
>> >> > +#define TC358775_LVCFG_LVDLINK__SHIFT                        1
>> >> >  static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
>> >> >  {
>> >> >         return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
>> >> > --
>> >> > 2.30.2
>> >> >
>> >
>> >
>> >
>> > --
>> > regards,
>> > vinaysimha
