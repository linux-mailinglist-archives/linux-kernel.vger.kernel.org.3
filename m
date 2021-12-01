Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B368464E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349439AbhLANB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244869AbhLANBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:01:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9189C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:58:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z5so36175655edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5PW8BhdAuu4oqSswIsrh+4cgg8Ko16BHPb2BC0DyDc=;
        b=ShtUvDfW5PyLg35gKksvBhAIF13Qdlo2k1kJ5nf9ddtcN2IWargq9oK9uH9Mj7mOlM
         yrZ5ncJ7wlQ3v3gaY2hNqU4iayvlI7vavUCnibRCmaVdQk34nmuQKcpVe0PohmHbMvqP
         Nx1ViR1M93mzRFKRGh73XszDpowN3KMR+Opzfq2PvivLIH0YhKXdc+DMIXTeShsMgFxl
         9/rGywoLb97EPLIPX0ys7IEZFihb9iHe1IeX3ailUU8luIz9EXUyP9Qn6V0BocL4t0CC
         j9BgxuSZEW7jn2HQAkvAuK6mVu7ghUJOjDX/Fe7XXV7vRQ/AHlnQE8pbKWqG8SpIt0l0
         Nf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5PW8BhdAuu4oqSswIsrh+4cgg8Ko16BHPb2BC0DyDc=;
        b=3sdfJuQ24YG53nAdL/c/Zq3ZTNoP4NnNd/FOQvKrqSd9VmyEVCSDvKCqg5JawI2aRn
         81OUWTeZEPFj0Hh8lm6rN5V7kA40ch5JtEWYnOgSi/2dvLtrDc6Qc9BBj+1WdoR1QpSm
         FbSJRzrWZGfItCJn+Hj7MJ0eBIw4J60W1n5wGk4eIENAVU72NLqeEkPrTXST6Pm+Atnc
         jhWqKk4iip/ZIFdsOK71q2GgHC+jSYx9c+QUOf6e51tjMXSUW+YTzL49qmyxBojesCxs
         ev0DSxCoTIWr+L5BfLSCMNBKOAbn/vK9jMTshOeDZJMJCh0By6d1o4x9tfUwzlw/qiRU
         BH1A==
X-Gm-Message-State: AOAM531RJyOkLIlg+B+WBp0jLaG15sYf+SC/kGOFA+RScV80bRzc83db
        STLvzAiV6pq3B8Oth8p4wFoVrC4we7V9dPfRCh6Spw==
X-Google-Smtp-Source: ABdhPJz9iOdDKNgMdJzD0gqeRB73Q1A4iiFR0FxNxz9fFpszk+uTamQrvcRyI5fCgzr/AcT0r10edZjMU7/6TzU7sCE=
X-Received: by 2002:aa7:c946:: with SMTP id h6mr8446283edt.190.1638363509446;
 Wed, 01 Dec 2021 04:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <20211201013329.15875-2-aford173@gmail.com>
 <CAAEAJfBBFhRtW2wmoA6T+yyM-nurUbtPqYHKPHjeRdKzA34PcQ@mail.gmail.com> <CAHCN7xLGTadbr+=-j2yJHFn233dgHic28njej8LHS2M0WwtqYQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLGTadbr+=-j2yJHFn233dgHic28njej8LHS2M0WwtqYQ@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 1 Dec 2021 09:58:17 -0300
Message-ID: <CAAEAJfDqBezv1_ZsF3vjAFprZYuaE7krkSXa4vzAfMZp5_z+sA@mail.gmail.com>
Subject: Re: [RFC V2 1/2] media: hantro: Add support for i.MX8M Mini
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tim Harvey <tharvey@gateworks.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 09:36, Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Dec 1, 2021 at 6:25 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > Hi Adam,
> >
> > On Tue, 30 Nov 2021 at 22:33, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > The i.MX8M Mini has a similar implementation of the Hantro G1 and
> > > h decoders, but the Mini uses the vpu-blk-ctrl for handling the
> > > VPU resets through the power domain system.  As such, there are
> > > functions present in the 8MQ that are not applicable to the Mini
> > > which requires the driver to have a different compatible flags.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > > index fb82b9297a2b..2aa1c520be50 100644
> > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > @@ -592,6 +592,8 @@ static const struct of_device_id of_hantro_match[] = {
> > >         { .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
> > >  #endif
> > >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> > > +       { .compatible = "nxp,imx8mm-vpu", .data = &imx8mm_vpu_variant, },
> > > +       { .compatible = "nxp,imx8mm-vpu-g2", .data = &imx8mm_vpu_g2_variant },
> > >         { .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> > >         { .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> > >  #endif
> > > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> > > index 267a6d33a47b..ae7c3fff760c 100644
> > > --- a/drivers/staging/media/hantro/hantro_hw.h
> > > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > > @@ -211,6 +211,8 @@ enum hantro_enc_fmt {
> > >         ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
> > >  };
> > >
> > > +extern const struct hantro_variant imx8mm_vpu_g2_variant;
> > > +extern const struct hantro_variant imx8mm_vpu_variant;
> > >  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> > >  extern const struct hantro_variant imx8mq_vpu_variant;
> > >  extern const struct hantro_variant px30_vpu_variant;
> > > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > index ea919bfb9891..c68516c00c6d 100644
> > > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > @@ -242,6 +242,32 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
> > >         },
> > >  };
> > >
> > > +static const struct hantro_codec_ops imx8mm_vpu_codec_ops[] = {
> > > +       [HANTRO_MODE_MPEG2_DEC] = {
> > > +               .run = hantro_g1_mpeg2_dec_run,
> > > +               .init = hantro_mpeg2_dec_init,
> > > +               .exit = hantro_mpeg2_dec_exit,
> > > +       },
> > > +       [HANTRO_MODE_VP8_DEC] = {
> > > +               .run = hantro_g1_vp8_dec_run,
> > > +               .init = hantro_vp8_dec_init,
> > > +               .exit = hantro_vp8_dec_exit,
> > > +       },
> > > +       [HANTRO_MODE_H264_DEC] = {
> > > +               .run = hantro_g1_h264_dec_run,
> > > +               .init = hantro_h264_dec_init,
> > > +               .exit = hantro_h264_dec_exit,
> > > +       },
> > > +};
> > > +
> > > +static const struct hantro_codec_ops imx8mm_vpu_g2_codec_ops[] = {
> > > +       [HANTRO_MODE_HEVC_DEC] = {
> > > +               .run = hantro_g2_hevc_dec_run,
> > > +               .init = hantro_hevc_dec_init,
> > > +               .exit = hantro_hevc_dec_exit,
> > > +       },
> > > +};
> > > +
> >
> > I believe you are missing VP9, which explains why you get
> > a zero fluster score.
>
> That's what I was thinking too and that's why I was wondering if I
> should wait on G2 until more of those G2 patches have been finalized
> and accepted.  Is there a way to test the HEVC?  I didn't see one in
> the fluster list.
>

VP9 is on its way to be merged. There is a pull request from Hans
already: see https://www.spinics.net/lists/linux-media/msg202448.html
which includes the git repository and tag you can merge/rebase to test
it.

It would be great if you can test G2 on top of that, but it's also fine
if you want to just submit G1 for now. Up to you.

Regarding HEVC, currently Benjamin is who knows best how to test it.
Thinking about it, perhaps we should document this somewhere?

Regards,
Ezequiel
