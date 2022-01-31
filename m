Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB04A4FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378397AbiAaUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378385AbiAaUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:15:48 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:15:48 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q186so28961800oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxO4HL3vAUhTJBcsBoRP4TU58IoGPRrYl5E2aI+f7nc=;
        b=bJUvEOlOmzuahvjm4AL/eskyk6nm7kknB7gdgCoRtytffbzI7Y8Umw8GfH8gWjXxv0
         +BraKxwV8fIuPoZdC6KxyIFMs34RKEUsc49ejqN1OZktRqS86vNNW+J2cDRowmICfANz
         7XOsjc3UEpD2oAb/wKcAYVP3uYxBEb1CVH6POqUvwP9jDgNagLJ1LXHzngSvHuH/CKuZ
         eWs2opiuALnQwFACnDkhZHiQMtkFbL/vWb/9pfp3BvyKvVTLr3omLhmjJ4rNj4i0kokh
         loYtA7IRRYI1wX7m6I0RV+ukTZmXBnn6xaQvEctBRYIj3Ur+hSV7fyo2uYdX4AgWZh2G
         hUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxO4HL3vAUhTJBcsBoRP4TU58IoGPRrYl5E2aI+f7nc=;
        b=TRsofTvIIqLopU+Zwby+Q+BIPZZTG1LqGyOLATk2Z4o6hhhUAAPTT1wxX41SsSiDCH
         hyJYmjO3VAygypV2JN087iKlBEB5NVqBPLVmbsnydpa22A/mIV57s/reur3Ltn8/2HEt
         wGFOIvgLvmJdaTy3Uw8NDqc3POwMUyPr8gPKw2H0O2PjDlFhidRcO96L3sWjlL9JnumT
         rZPm/KnP5PcODVDVgfneFs9SmqL5OsTBmweBLR5S+TuRNaZiwfJRQQ477uQ5Kohxbj89
         upJWBLlTTglYWORWwCZ6tNHinBQCXRhSCC64FQTcmDMMt484LPyzLftevIeGUk1mh9XH
         WLgw==
X-Gm-Message-State: AOAM533XeWZsNDuHyIXQqBMPPqDzd2TUnOUT2TxWbLOc5+OnUvqTZa+Y
        85w8rM78mUGQKsk+NmGl/lMT6GII8LjJ49qArro=
X-Google-Smtp-Source: ABdhPJx02+YhKKrAKsIA1dCwlj38aSZeZERiRuIhZ3Bzmu2lMWl16k7vYqt1gJcAhp3LjC9+q6lVD3Zm3Sd2V5KTaRk=
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr19415786oiw.199.1643660147527;
 Mon, 31 Jan 2022 12:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20220129010413.97801-1-yang.lee@linux.alibaba.com> <75ab0f37-a55e-8e81-8cbf-c0de3002c3e4@amd.com>
In-Reply-To: <75ab0f37-a55e-8e81-8cbf-c0de3002c3e4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 31 Jan 2022 15:15:36 -0500
Message-ID: <CADnq5_OhatwsjXzhtb0F0mu0K7BQHCSvH=9nnwkk94njmtda2w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indenting
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Dave Airlie <airlied@linux.ie>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 31, 2022 at 10:17 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-01-28 20:04, Yang Li wrote:
> > Eliminate the follow smatch warning:
> > drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:2246
> > dp_perform_8b_10b_link_training() warn: inconsistent indenting
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index daaec3164875..34ffcd5bb1d7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -2243,11 +2243,11 @@ static enum link_training_result dp_perform_8b_10b_link_training(
> >
> >       if (status == LINK_TRAINING_SUCCESS) {
> >               status = perform_clock_recovery_sequence(link, link_res, lt_settings, DPRX);
> > -     if (status == LINK_TRAINING_SUCCESS) {
> > -             status = perform_channel_equalization_sequence(link,
> > -                                     link_res,
> > -                                     lt_settings,
> > -                                     DPRX);
> > +             if (status == LINK_TRAINING_SUCCESS) {
> > +                     status = perform_channel_equalization_sequence(link,
> > +                                                                    link_res,
> > +                                                                    lt_settings,
> > +                                                                    DPRX);
> >               }
> >       }
> >
>
