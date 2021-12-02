Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDFD465B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbhLBBBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbhLBBBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:01:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45BC061756;
        Wed,  1 Dec 2021 16:58:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so109014853eda.11;
        Wed, 01 Dec 2021 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MDs/Jyg2/Fm6/tmFp/cfCeZAs/P9gxctfJQzTv1D9I4=;
        b=Z0aZppabcMHqAqe/IELdlodhbZPrnBrurEFt6x9k9ONn7v28tmLWjtowBVrAZQTdAl
         rf5KbRRrj9IO49s54jiz4FYwK6WEfY3t3Qx2mnLRyvHHCNss50wHQRlZwDLzVErq55tO
         Dh+fF8MmtzESvuOsxiVaeZgPtG8398wykTWGr5nc0T2IdUrQ/pc3WIPRStGQzpuDVnqo
         RmG5y6SR7H0ACd8nWSltrrtRO+yJAlvlqjkcwGNGY+d9zZwfZOb7wsltc9DeyfVmxfnN
         43L3ntatwysSiiO1l1Wu28qtZVLfKG/eh2OhdPRU8SwTDNtpoqHfWoH7C55cshUt0qDX
         fMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDs/Jyg2/Fm6/tmFp/cfCeZAs/P9gxctfJQzTv1D9I4=;
        b=fY+dqliHAlnunO/ZV8PbWwYlxZdcpK6N4RTtBhC04O5LEFkJYXiwXLGUbghDLjXuSr
         qKupl9PcB9Q4enDst4AbOm8zBM6qoqxOTzauGhjms/Ux5KrdFTDeIIK9UzTmuZc/3DVj
         iU69NrpKvgWnrOcdAiWxya1iu+1rXoAn/Zz4rS2o7YEXTj/mvaQ6lHJ40a457ASIUY5d
         ZHUzegnwNUs52c13NbXp9B7Gne6SkTPT6fbMJj92fIiv2y+uzARF4BGCaqEgJ/aHq2UV
         RSILOYav8TgTKDVvgMBDyl9mAXURh9zz3cfal8gi7RE8gD5vD/CBU+uu22eK6R7Q8T2/
         nMeQ==
X-Gm-Message-State: AOAM531z/u06XYR58ExsxV7sFKvKwba0B9ZNdIfVadlzPKd/BpqOKA7y
        IY8RuFR02AqepEAWboXbyt0GqPXC7kCGKjXHq18=
X-Google-Smtp-Source: ABdhPJy2AeC+wjbxokHKkX1QJDz4q03oGJTAKXg4f61iAPBx4Kwt2Z2Gsb5gMxoLVsTajmPMfJR8Ls7h2+OxRikmXPo=
X-Received: by 2002:a17:907:1b17:: with SMTP id mp23mr10807590ejc.521.1638406692655;
 Wed, 01 Dec 2021 16:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com> <20211201013329.15875-2-aford173@gmail.com>
 <CAAEAJfBBFhRtW2wmoA6T+yyM-nurUbtPqYHKPHjeRdKzA34PcQ@mail.gmail.com>
 <CAHCN7xLGTadbr+=-j2yJHFn233dgHic28njej8LHS2M0WwtqYQ@mail.gmail.com>
 <CAAEAJfDqBezv1_ZsF3vjAFprZYuaE7krkSXa4vzAfMZp5_z+sA@mail.gmail.com> <d8335964ece000814c8ec2ea0274498b3280812c.camel@ndufresne.ca>
In-Reply-To: <d8335964ece000814c8ec2ea0274498b3280812c.camel@ndufresne.ca>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 1 Dec 2021 18:58:01 -0600
Message-ID: <CAHCN7xK7L2iJvHa8j+W0n2ufOUeLTdF06r=Fa4wjXj5UE9mM-Q@mail.gmail.com>
Subject: Re: [RFC V2 1/2] media: hantro: Add support for i.MX8M Mini
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tim Harvey <tharvey@gateworks.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 3:03 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrot=
e:
>
> Le mercredi 01 d=C3=A9cembre 2021 =C3=A0 09:58 -0300, Ezequiel Garcia a =
=C3=A9crit :
> > On Wed, 1 Dec 2021 at 09:36, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Wed, Dec 1, 2021 at 6:25 AM Ezequiel Garcia
> > > <ezequiel@vanguardiasur.com.ar> wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > On Tue, 30 Nov 2021 at 22:33, Adam Ford <aford173@gmail.com> wrote:
> > > > >
> > > > > The i.MX8M Mini has a similar implementation of the Hantro G1 and
> > > > > h decoders, but the Mini uses the vpu-blk-ctrl for handling the
> > > > > VPU resets through the power domain system.  As such, there are
> > > > > functions present in the 8MQ that are not applicable to the Mini
> > > > > which requires the driver to have a different compatible flags.
> > > > >
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > >
> > > > > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/=
staging/media/hantro/hantro_drv.c
> > > > > index fb82b9297a2b..2aa1c520be50 100644
> > > > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > > > @@ -592,6 +592,8 @@ static const struct of_device_id of_hantro_ma=
tch[] =3D {
> > > > >         { .compatible =3D "rockchip,rk3399-vpu", .data =3D &rk339=
9_vpu_variant, },
> > > > >  #endif
> > > > >  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> > > > > +       { .compatible =3D "nxp,imx8mm-vpu", .data =3D &imx8mm_vpu=
_variant, },
> > > > > +       { .compatible =3D "nxp,imx8mm-vpu-g2", .data =3D &imx8mm_=
vpu_g2_variant },
> > > > >         { .compatible =3D "nxp,imx8mq-vpu", .data =3D &imx8mq_vpu=
_variant, },
> > > > >         { .compatible =3D "nxp,imx8mq-vpu-g2", .data =3D &imx8mq_=
vpu_g2_variant },
> > > > >  #endif
> > > > > diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/s=
taging/media/hantro/hantro_hw.h
> > > > > index 267a6d33a47b..ae7c3fff760c 100644
> > > > > --- a/drivers/staging/media/hantro/hantro_hw.h
> > > > > +++ b/drivers/staging/media/hantro/hantro_hw.h
> > > > > @@ -211,6 +211,8 @@ enum hantro_enc_fmt {
> > > > >         ROCKCHIP_VPU_ENC_FMT_UYVY422 =3D 3,
> > > > >  };
> > > > >
> > > > > +extern const struct hantro_variant imx8mm_vpu_g2_variant;
> > > > > +extern const struct hantro_variant imx8mm_vpu_variant;
> > > > >  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> > > > >  extern const struct hantro_variant imx8mq_vpu_variant;
> > > > >  extern const struct hantro_variant px30_vpu_variant;
> > > > > diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/driver=
s/staging/media/hantro/imx8m_vpu_hw.c
> > > > > index ea919bfb9891..c68516c00c6d 100644
> > > > > --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > > +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> > > > > @@ -242,6 +242,32 @@ static const struct hantro_codec_ops imx8mq_=
vpu_g2_codec_ops[] =3D {
> > > > >         },
> > > > >  };
> > > > >
> > > > > +static const struct hantro_codec_ops imx8mm_vpu_codec_ops[] =3D =
{
> > > > > +       [HANTRO_MODE_MPEG2_DEC] =3D {
> > > > > +               .run =3D hantro_g1_mpeg2_dec_run,
> > > > > +               .init =3D hantro_mpeg2_dec_init,
> > > > > +               .exit =3D hantro_mpeg2_dec_exit,
> > > > > +       },
> > > > > +       [HANTRO_MODE_VP8_DEC] =3D {
> > > > > +               .run =3D hantro_g1_vp8_dec_run,
> > > > > +               .init =3D hantro_vp8_dec_init,
> > > > > +               .exit =3D hantro_vp8_dec_exit,
> > > > > +       },
> > > > > +       [HANTRO_MODE_H264_DEC] =3D {
> > > > > +               .run =3D hantro_g1_h264_dec_run,
> > > > > +               .init =3D hantro_h264_dec_init,
> > > > > +               .exit =3D hantro_h264_dec_exit,
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +static const struct hantro_codec_ops imx8mm_vpu_g2_codec_ops[] =
=3D {
> > > > > +       [HANTRO_MODE_HEVC_DEC] =3D {
> > > > > +               .run =3D hantro_g2_hevc_dec_run,
> > > > > +               .init =3D hantro_hevc_dec_init,
> > > > > +               .exit =3D hantro_hevc_dec_exit,
> > > > > +       },
> > > > > +};
> > > > > +
> > > >
> > > > I believe you are missing VP9, which explains why you get
> > > > a zero fluster score.
> > >
> > > That's what I was thinking too and that's why I was wondering if I
> > > should wait on G2 until more of those G2 patches have been finalized
> > > and accepted.  Is there a way to test the HEVC?  I didn't see one in
> > > the fluster list.
> > >
> >
> > VP9 is on its way to be merged. There is a pull request from Hans
> > already: see https://www.spinics.net/lists/linux-media/msg202448.html
> > which includes the git repository and tag you can merge/rebase to test
> > it.
> >

Thanks for that.  I rebased my work and found some bugs, so I'll be
posting an RFC V3 later tonight.

> > It would be great if you can test G2 on top of that, but it's also fine
> > if you want to just submit G1 for now. Up to you.
> >
> > Regarding HEVC, currently Benjamin is who knows best how to test it.
> > Thinking about it, perhaps we should document this somewhere?
>
> There is GStreamer-H.265-V4L2SL-Gst1.0 decoder already in fluster. And GS=
treamer
> support is still WIP.
>
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079
>
> We had put on hold the HEVC work in order to focus on VP9. Now that VP9 i=
s on
> its way (I've sent another MR today to GStreamer to fix some more tests).=
 I
> haven't tested myself imx8mq recently, will likely do soon, so I can give=
 you
> the expected score. Your VP8 and H264 score matches the result I got. Not=
e that
> H264 driver is missing interlace support, which is half the tests.
>
> We will can resume this work. Help is welcome of course. The HEVC staging=
 API is
> by was the worst, so there is quite some work to move this API to stable =
and
> then port all the drivers to the require changes that will be needed.

With the latest gstreamer and the rebase off Hans' work along with
some improvements to my code, fluster now runs the VP9...at least for
a while.  It doesn't technically finish because the power domain
appears to choke which causes a hang.  This was reported by Tim
Harvey, and with some of my updates, I can reproduce it now too.  :-(

At least I know I'm off to the right start on the VP9.

adam
>
> >
> > Regards,
> > Ezequiel
>
