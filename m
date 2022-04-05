Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F047A4F49F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453609AbiDEWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457238AbiDEQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1613D28
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:34:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k2so8137764edj.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a1xJ6jFPkFxQuvHAGPReiLsquMYU3s3ZKHuSgQSN2JI=;
        b=yCS5jpe9VjM9C+zh8VBKOmizln04kAtaeouTe7pAMtjRZrAsxmkgvcwGiMGfaxwyS4
         kw1rejBx6SrcJNllN4RSW73Vtr8GHYX+dZXOznMHs64ypDbqAvv83cGXTzTyhIDMSPR4
         06XGaPkjtIXljr7u7xRJUxDhwZWo7Rb8V62qaT7radA5uDvQILA//MWgaU8xJIIrWB4l
         lnYVVbnbiA/cbGcskrhmlDGUre5mfuSWPrlt/p9x6XUKP6vSE6VHRMMBhXddXdMyrq6u
         sbDpCh7Y+eCVlvhQn8y6w/C2epmbcOfA8cT6Nb2yzLtxWWW72tLEWGUtA5gfVNhGGniy
         WjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a1xJ6jFPkFxQuvHAGPReiLsquMYU3s3ZKHuSgQSN2JI=;
        b=wAlg4TdUoZk2T+Zw8X0GWHdBq+PUT/0iUxCzVDf6vyxcLGI8UOcsVb2SCe7a7etNwP
         SvONijy23yY3yyaFJ0yi6SsspCmKAe9yZtvpyYLz8f0aBQc2w+/4c4lfYVwVX7QngLA1
         Ar1UknsfQANz4GUt2jp4TCyaTtHuMtUcLfDSIAwXMGUj9s1RQABJIVHa1o5Xw0SX9fXA
         ZQqrS4ZIvz65Xvlh8CNKeR66gzujObAlLd+vt29juSKkbVf+knf02rCIJULC/4JMeCfq
         EkEB1PXyHl6JyiwfEEgLnhLBKjGNbZr6rjmeMYSxb0o5YQ5nUZ4FVtbzjfFl1wj6wJ2S
         OVmA==
X-Gm-Message-State: AOAM532DTZO+1VeGm5GY0xn8u1d+b2PT/shcrd4Ja7NGPLwbDC2I//FX
        arDA4Psck4OrBBqOOy48Fx18om2Zavp5oJcP/JgXDw==
X-Google-Smtp-Source: ABdhPJzw4YwchmSZLuoyl5Jwvu1T8kRfHZDvBRGJl2eE8vJuOb0LnTTOzWkxc9myV9hSldolnwOUHnDWJByG+ntYhWQ=
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id
 n9-20020aa7c789000000b00413605d8d17mr4224378eds.100.1649172881727; Tue, 05
 Apr 2022 08:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-14-nicolas.dufresne@collabora.com> <YkgwmwTMa83RysKB@eze-laptop>
 <92001085580ac1005596b34f79f1dadcc4b3f3c9.camel@collabora.com>
In-Reply-To: <92001085580ac1005596b34f79f1dadcc4b3f3c9.camel@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 5 Apr 2022 12:34:30 -0300
Message-ID: <CAAEAJfA_+ZAcjHUN7Ydi0b=XB0=kFMaaPQC=h_44CNHq9rBsmQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/23] media: rkvdec: h264: Fix dpb_valid implementation
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 12:11 PM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le samedi 02 avril 2022 =C3=A0 08:16 -0300, Ezequiel Garcia a =C3=A9crit =
:
> > On Thu, Mar 31, 2022 at 03:37:15PM -0400, Nicolas Dufresne wrote:
> > > The ref builder only provided references that are marked as valid in =
the
> > > dpb. Thus the current implementation of dpb_valid would always set th=
e
> > > flag to 1. This is not representing missing frames (this is called
> > > 'non-existing' pictures in the spec). In some context, these non-exis=
ting
> > > pictures still need to occupy a slot in the reference list according =
to
> > > the spec.
> > >
> >
> > Good catch! OOC, did you find this because it was failing a test vector=
?
>
> The effect is complex, so I could not correlate to specific tests. Also, =
what I
> wanted to fix isn't covered by the ITU conformance, its mostly resiliance
> requirement. But this should remove some of the IOMMU fault on broken str=
eams
> and make it less likely to use references that don't exists or aren't set=
 what
> we expect. After this change, the driver was getting more stable, and res=
ults
> was also more reproducible (specially in parallel decode case, which I us=
e to
> speed up testing).
>

Thanks for the details. This sounds like something that could
be added to the commit description itself.

> >
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> >
> > Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Thanks for the review.
>

No problem :)

> >
> > Thanks,
> > Ezequiel
> >
> > > ---
> > >  drivers/staging/media/rkvdec/rkvdec-h264.c | 33 ++++++++++++++++----=
--
> > >  1 file changed, 24 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/sta=
ging/media/rkvdec/rkvdec-h264.c
> > > index dff89732ddd0..bcde37d72244 100644
> > > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > > @@ -112,6 +112,7 @@ struct rkvdec_h264_run {
> > >     const struct v4l2_ctrl_h264_sps *sps;
> > >     const struct v4l2_ctrl_h264_pps *pps;
> > >     const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
> > > +   int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
> > >  };
> > >
> > >  struct rkvdec_h264_ctx {
> > > @@ -725,6 +726,26 @@ static void assemble_hw_pps(struct rkvdec_ctx *c=
tx,
> > >     }
> > >  }
> > >
> > > +static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> > > +                          struct rkvdec_h264_run *run)
> > > +{
> > > +   const struct v4l2_ctrl_h264_decode_params *dec_params =3D run->de=
code_params;
> > > +   u32 i;
> > > +
> > > +   for (i =3D 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
> > > +           struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> > > +           const struct v4l2_h264_dpb_entry *dpb =3D run->decode_par=
ams->dpb;
> > > +           struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> > > +           int buf_idx =3D -1;
> > > +
> > > +           if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > > +                   buf_idx =3D vb2_find_timestamp(cap_q,
> > > +                                                dpb[i].reference_ts,=
 0);
> > > +
> > > +           run->ref_buf_idx[i] =3D buf_idx;
> > > +   }
> > > +}
> > > +
> > >  static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> > >                         struct rkvdec_h264_run *run)
> > >  {
> > > @@ -762,7 +783,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ct=
x,
> > >
> > >     for (j =3D 0; j < RKVDEC_NUM_REFLIST; j++) {
> > >             for (i =3D 0; i < h264_ctx->reflists.num_valid; i++) {
> > > -                   u8 dpb_valid =3D 0;
> > > +                   bool dpb_valid =3D run->ref_buf_idx[i] >=3D 0;
> > >                     u8 idx =3D 0;
> > >
> > >                     switch (j) {
> > > @@ -779,8 +800,6 @@ static void assemble_hw_rps(struct rkvdec_ctx *ct=
x,
> > >
> > >                     if (idx >=3D ARRAY_SIZE(dec_params->dpb))
> > >                             continue;
> > > -                   dpb_valid =3D !!(dpb[idx].flags &
> > > -                                  V4L2_H264_DPB_ENTRY_FLAG_ACTIVE);
> > >
> > >                     set_ps_field(hw_rps, DPB_INFO(i, j),
> > >                                  idx | dpb_valid << 4);
> > > @@ -859,13 +878,8 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct rkvde=
c_h264_run *run,
> > >         unsigned int dpb_idx)
> > >  {
> > >     struct v4l2_m2m_ctx *m2m_ctx =3D ctx->fh.m2m_ctx;
> > > -   const struct v4l2_h264_dpb_entry *dpb =3D run->decode_params->dpb=
;
> > >     struct vb2_queue *cap_q =3D &m2m_ctx->cap_q_ctx.q;
> > > -   int buf_idx =3D -1;
> > > -
> > > -   if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > > -           buf_idx =3D vb2_find_timestamp(cap_q,
> > > -                                        dpb[dpb_idx].reference_ts, 0=
);
> > > +   int buf_idx =3D run->ref_buf_idx[dpb_idx];
> > >
> > >     /*
> > >      * If a DPB entry is unused or invalid, address of current destin=
ation
> > > @@ -1102,6 +1116,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *c=
tx)
> > >
> > >     assemble_hw_scaling_list(ctx, &run);
> > >     assemble_hw_pps(ctx, &run);
> > > +   lookup_ref_buf_idx(ctx, &run);
> > >     assemble_hw_rps(ctx, &run);
> > >     config_registers(ctx, &run);
> > >
> > > --
> > > 2.34.1
> > >
>
