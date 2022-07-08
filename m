Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8A56B851
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiGHLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbiGHLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:21:31 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04001904C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:21:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10bffc214ffso18133463fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fk+P4TpRe3CkZlCcO0VHdUg0ryTXyZTgaMiJH+Gu2l0=;
        b=argv1qd1G6LzdfJmh4AdxiqvYZnhJtEFgQwb0QzxhzYB374qlJySF3NWM1GXJVbhjZ
         ULCW9mtoB9PunLPSGfLVmDcvI59acA37YEISlN/vouFPihAgix7R1PzrR9w9mXw4WqTR
         bBFi8gTexx6FkTohlb0sbSXwjkS41XQfPhIeLujyWpAybWHOKQAmsxpBtWHdvy+UiwhY
         tof4IEsS+00CAweN+sDP8QcX2lxVX0FQh1V7SDLzMcqQkJFEpZ27sKh6N7uy1ElMUK3e
         8dTjjQuo3AFcoCC/L0GCW0JdALrZSpo8ahjNpLFdWEnvGGfWHFMcxD+8Qj0DP4ZlWmW+
         K02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fk+P4TpRe3CkZlCcO0VHdUg0ryTXyZTgaMiJH+Gu2l0=;
        b=6luN2jcecaRk4rTYT9HDeYpUYF65rcXd0dyPUqzP0D4ny0p4rWm2dIpsop++4mlpvh
         Rc6wvOL0lVX+YOM5bNoB1aVJanzIA671Jv6Y9LwIFklPGZMgVRoX4afQWV9uv5udbKHe
         zmjIL2H1P/5UiLc1jc/JBF6Hhn/rbUbxTISEnEadSZSQQQ+EIJcwNX9Bu7HrX7qfEqaS
         VAkw/6wgmJ05vWVWL6sBeRpK6Z/4VydyjZ7cAHn/kCQEwVVVUrMKBz1M/rnF/UCWSn6+
         9umdaSmcJWVFuk5ETVNWfwBqyIMi4c22Urv0cUl6FwwlhUKWmkzEfndOFfQSI2mK9AjM
         G8sA==
X-Gm-Message-State: AJIora+UJ1FoWkaFM4RYElJRuwbUHV1uos7hjLgx/WRcuwcCr7jsAR4f
        goIxCtxxqRw3lyRHX+3HNoFLDQ==
X-Google-Smtp-Source: AGRyM1sXR0J8jPl5Fc/3xvMemjbnmlkd8jlz3vdBxTtjmgJOzf2uiSpuOTxN5lDSQZTgcY4nTaWm6w==
X-Received: by 2002:a05:6871:80a:b0:10b:e1fa:17a with SMTP id q10-20020a056871080a00b0010be1fa017amr1651937oap.262.1657279289345;
        Fri, 08 Jul 2022 04:21:29 -0700 (PDT)
Received: from eze-laptop ([186.13.97.246])
        by smtp.gmail.com with ESMTPSA id z23-20020a4ad1b7000000b0035eb4e5a6b6sm17976802oor.12.2022.07.08.04.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:21:28 -0700 (PDT)
Date:   Fri, 8 Jul 2022 08:21:23 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 6/8] rkvdec: Use vb2_find_buffer
Message-ID: <YsgTM1zYMDHa2HJd@eze-laptop>
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
 <20220706182657.210650-7-ezequiel@vanguardiasur.com.ar>
 <CAAFQd5BSDnZ6MyXfcRWNM9f9WF82sjPX3F1ZjYjcOuz3b1fPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BSDnZ6MyXfcRWNM9f9WF82sjPX3F1ZjYjcOuz3b1fPkw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Fri, Jul 08, 2022 at 01:40:53PM +0900, Tomasz Figa wrote:
> Hi Ezequiel,
> 
> On Thu, Jul 7, 2022 at 3:27 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> > given a buffer timestamp.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 41 ++++++++--------------
> >  drivers/staging/media/rkvdec/rkvdec-vp9.c  | 10 +++---
> >  2 files changed, 19 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > index 2992fb87cf72..4af5a831bde0 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -109,7 +109,7 @@ struct rkvdec_h264_run {
> >         const struct v4l2_ctrl_h264_sps *sps;
> >         const struct v4l2_ctrl_h264_pps *pps;
> >         const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
> > -       int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
> > +       struct vb2_buffer *ref_buf[V4L2_H264_NUM_DPB_ENTRIES];
> 
> How do we guarantee that those pointers remain valid through the
> lifetime of this structure?
> 

The rkvdec_h264_run is populated in .device_run, and used to program
the hardware for each decode job.

So these videobuf2 buffer won't outlive a given decode job. The vb2
queue can't be released (so buffers can't be released) while
a job is runnning (i.e. the driver is in a "streaming" state).

We should be good, right?

Thanks for the review,
Ezequiel

> Best regards,
> Tomasz
> 
> >  };
> >
> >  struct rkvdec_h264_ctx {
> > @@ -742,17 +742,16 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> >                 struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> >                 const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
> >                 struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> > -               int buf_idx = -1;
> > +               struct vb2_buffer *buf = NULL;
> >
> >                 if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> > -                       buf_idx = vb2_find_timestamp(cap_q,
> > -                                                    dpb[i].reference_ts, 0);
> > -                       if (buf_idx < 0)
> > +                       buf = vb2_find_buffer(cap_q, dpb[i].reference_ts);
> > +                       if (!buf)
> >                                 pr_debug("No buffer for reference_ts %llu",
> >                                          dpb[i].reference_ts);
> >                 }
> >
> > -               run->ref_buf_idx[i] = buf_idx;
> > +               run->ref_buf[i] = buf;
> >         }
> >  }
> >
> > @@ -805,7 +804,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> >                         if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
> >                                 continue;
> >
> > -                       dpb_valid = run->ref_buf_idx[ref->index] >= 0;
> > +                       dpb_valid = run->ref_buf[ref->index] != NULL;
> >                         bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
> >
> >                         set_ps_field(hw_rps, DPB_INFO(i, j),
> > @@ -881,24 +880,6 @@ static const u32 poc_reg_tbl_bottom_field[16] = {
> >         RKVDEC_REG_H264_POC_REFER2(1)
> >  };
> >
> > -static struct vb2_buffer *
> > -get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_h264_run *run,
> > -           unsigned int dpb_idx)
> > -{
> > -       struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> > -       struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> > -       int buf_idx = run->ref_buf_idx[dpb_idx];
> > -
> > -       /*
> > -        * If a DPB entry is unused or invalid, address of current destination
> > -        * buffer is returned.
> > -        */
> > -       if (buf_idx < 0)
> > -               return &run->base.bufs.dst->vb2_buf;
> > -
> > -       return vb2_get_buffer(cap_q, buf_idx);
> > -}
> > -
> >  static void config_registers(struct rkvdec_ctx *ctx,
> >                              struct rkvdec_h264_run *run)
> >  {
> > @@ -971,8 +952,14 @@ static void config_registers(struct rkvdec_ctx *ctx,
> >
> >         /* config ref pic address & poc */
> >         for (i = 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
> > -               struct vb2_buffer *vb_buf = get_ref_buf(ctx, run, i);
> > -
> > +               struct vb2_buffer *vb_buf = run->ref_buf[i];
> > +
> > +               /*
> > +                * If a DPB entry is unused or invalid, address of current destination
> > +                * buffer is returned.
> > +                */
> > +               if (!vb_buf)
> > +                       vb_buf = &dst_buf->vb2_buf;
> >                 refer_addr = vb2_dma_contig_plane_dma_addr(vb_buf, 0);
> >
> >                 if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> > index c2f42e76be10..d8c1c0db15c7 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> > @@ -383,17 +383,17 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *dst, u64 timestamp)
> >  {
> >         struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> >         struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> > -       int buf_idx;
> > +       struct vb2_buffer *buf;
> >
> >         /*
> >          * If a ref is unused or invalid, address of current destination
> >          * buffer is returned.
> >          */
> > -       buf_idx = vb2_find_timestamp(cap_q, timestamp, 0);
> > -       if (buf_idx < 0)
> > -               return vb2_to_rkvdec_decoded_buf(&dst->vb2_buf);
> > +       buf = vb2_find_buffer(cap_q, timestamp);
> > +       if (!buf)
> > +               buf = &dst->vb2_buf;
> >
> > -       return vb2_to_rkvdec_decoded_buf(vb2_get_buffer(cap_q, buf_idx));
> > +       return vb2_to_rkvdec_decoded_buf(buf);
> >  }
> >
> >  static dma_addr_t get_mv_base_addr(struct rkvdec_decoded_buffer *buf)
> > --
> > 2.34.3
> >
