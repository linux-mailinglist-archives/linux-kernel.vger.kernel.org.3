Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1F467A16
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352722AbhLCPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381671AbhLCPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:13:20 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78EC061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:09:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so3528936qtj.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5VMkJHZbpjViTRA6Jhw7uB7mIcmNarQHy6QHizi1178=;
        b=71sGRR2nzOUu+vhocYFVTNVjY6/WqTrpjHHbfXEKt3elniexjPfWxOLr032mBBN+9Y
         Tw220SxKekKZsp8S/8e/xLS0Hnu6R5ruFD5wh6hN/9mO4ndz4eE7tHjJxeqQWDJNLqrq
         qfwGlUWt/qpUhoICghex1ctpDy+V5nUt/7Jh5j9M24TsTVjQOgeBpuc3+x3PNRQRmUZc
         zgAKIocNjvp9XXJRBoWZ3FkdzPnXuIDPL24wz+TmN3YYOYBxPgIVZsut/g6DIsjuL2Gt
         wSJaQt3bzU4ZgUkvsY6hg+Qq46O2COoQNWpTGqQeLJ24WsmNHOTnIDAckM1UfrhQqwhG
         F4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5VMkJHZbpjViTRA6Jhw7uB7mIcmNarQHy6QHizi1178=;
        b=6ZTe7ACMuqH04OuOOv6tq/y3wdJWwz1jdcxAo4gu21+Pstb3071/cQmhsVxkZ+579X
         XsLnaehPVYh2PgS7X/uWAxa3k/wXiza9UwdDKm8Rwt78iwq/KtrC4W/m3nsUmTHc2gb7
         GaS7GiGxmQB2KRGLARiV6sPsbbd2Le65eY4Ho+4c+eQ8v7OB6Y5ResXeniUa3qNenZRp
         XwhL6hVP/9EAuvAjgNg/QWjGnrGYG/C1pjULqsNZaDsvJt6PtA6zVRhsmdJFVYW3EjCd
         rJRgvnYY73VcOajjgBX43H7k8g6/ZYEyASK4l775EeHNVg9wXUexuetbdkLbkZ9XC6S4
         M07Q==
X-Gm-Message-State: AOAM5323KSfdeIY+Paf/hm2b4aRi3MmUoC+7VOp42RKaT+mt7HbcyffG
        pRyav9c4gxWMpCquFHGRvKE2FQ==
X-Google-Smtp-Source: ABdhPJy61ZibMg8ILoK2AEsliArYVxsRd68TcRbdLO8nY0DiJ6C4K2+uM90k9CMi4r2w2KTjYsUWmg==
X-Received: by 2002:ac8:598c:: with SMTP id e12mr21240483qte.337.1638544195661;
        Fri, 03 Dec 2021 07:09:55 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id u10sm2307205qkp.104.2021.12.03.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:09:55 -0800 (PST)
Message-ID: <7e63c1665c96feccadd9c05dc603349b3a93900d.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
 decoder stateful driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 03 Dec 2021 10:09:53 -0500
In-Reply-To: <AM6PR04MB6341537EBD82451CA14A5E3EE76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
         <9122e66af668c095548321d45dec33a3fd6ee77d.1638263914.git.ming.qian@nxp.com>
         <fceda1576bcb2fc4e576b59e09214ab1320558b3.camel@ndufresne.ca>
         <AM6PR04MB6341AC4C0057B09DB8A58234E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB6341537EBD82451CA14A5E3EE76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 03 décembre 2021 à 06:01 +0000, Ming Qian a écrit :
> > -----Original Message-----
> > From: Ming Qian
> > Sent: Friday, December 3, 2021 1:43 PM
> > To: Nicolas Dufresne <nicolas@ndufresne.ca>; mchehab@kernel.org;
> > shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> > Cc: hverkuil-cisco@xs4all.nl; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: RE: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
> > decoder stateful driver
> > 
> > > -----Original Message-----
> > > From: Nicolas Dufresne [mailto:nicolas@ndufresne.ca]
> > > Sent: Friday, December 3, 2021 12:56 PM
> > > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> > > shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> > > Cc: hverkuil-cisco@xs4all.nl; kernel@pengutronix.de;
> > > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; Aisheng Dong
> > > <aisheng.dong@nxp.com>; linux-media@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
> > > decoder stateful driver
> > > 
> > > Caution: EXT Email
> > > 
> > > Le mardi 30 novembre 2021 à 17:48 +0800, Ming Qian a écrit :
> > > > This consists of video decoder implementation plus decoder controls.
> > > > 
> > > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > > Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> > > > Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> > > > ---
> > > >  drivers/media/platform/amphion/vdec.c | 1680
> > > +++++++++++++++++++++++++
> > 
> > 
> > > > +
> > > > +static void vdec_init_fmt(struct vpu_inst *inst) {
> > > > +     struct vdec_t *vdec = inst->priv;
> > > > +     const struct vpu_format *fmt;
> > > > +     int i;
> > > > +
> > > > +     fmt = vpu_helper_find_format(inst, inst->cap_format.type,
> > > vdec->codec_info.pixfmt);
> > > > +     inst->out_format.width = vdec->codec_info.width;
> > > > +     inst->out_format.height = vdec->codec_info.height;
> > > > +     inst->cap_format.width = vdec->codec_info.decoded_width;
> > > > +     inst->cap_format.height = vdec->codec_info.decoded_height;
> > > > +     inst->cap_format.pixfmt = vdec->codec_info.pixfmt;
> > > > +     if (fmt) {
> > > > +             inst->cap_format.num_planes = fmt->num_planes;
> > > > +             inst->cap_format.flags = fmt->flags;
> > > > +     }
> > > > +     for (i = 0; i < inst->cap_format.num_planes; i++) {
> > > > +             inst->cap_format.bytesperline[i] =
> > > vdec->codec_info.bytesperline[i];
> > > > +             inst->cap_format.sizeimage[i] =
> > > vdec->codec_info.sizeimage[i];
> > > > +     }
> > > > +     if (vdec->codec_info.progressive)
> > > > +             inst->cap_format.field = V4L2_FIELD_NONE;
> > > > +     else
> > > > +             inst->cap_format.field = V4L2_FIELD_INTERLACED;
> > > 
> > > As a followup, this should be conditional to the chosen pixel format.
> > > If I understood correct, you produce interlaced is only produce for
> > > linear NV12, for tiled the fields are outputed seperated in their
> > > respective v4l2_buffer. Note sure where yet, but the V4L2 spec
> > > requires you to pair the fields by using the same seq_num on both.
> > 
> > The amphion vpu will store the two fields into one v4l2_buf, So I'll change
> > V4L2_FIELD_INTERLACED to V4L2_FIELD_SEQ_TB
> > 
> 
> Hi Nicolas,
>     Seems gstreamer doesn't support V4L2_FIELD_SEQ_TB yet.
> 
>   switch (fmt.fmt.pix.field) {
>     case V4L2_FIELD_ANY:
>     case V4L2_FIELD_NONE:
>       interlace_mode = GST_VIDEO_INTERLACE_MODE_PROGRESSIVE;
>       break;
>     case V4L2_FIELD_INTERLACED:
>     case V4L2_FIELD_INTERLACED_TB:
>     case V4L2_FIELD_INTERLACED_BT:
>       interlace_mode = GST_VIDEO_INTERLACE_MODE_INTERLEAVED;
>       break;
>     case V4L2_FIELD_ALTERNATE:
>       interlace_mode = GST_VIDEO_INTERLACE_MODE_ALTERNATE;
>       break;
>     default:
>       goto unsupported_field;
>   }

This is correct, I had never had the chance to implement it. So far I only know
IMX6 camera pipeline producing that, but rarely used in practice. What matters
here is that your driver does report the right information so that userspace
don't get fooled into thinking it's interleaved.

> 
> > > 
> > > > +     if (vdec->codec_info.color_primaries ==
> > V4L2_COLORSPACE_DEFAULT)
> > > > +             vdec->codec_info.color_primaries =
> > > V4L2_COLORSPACE_REC709;
> > > > +     if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
> > > > +             vdec->codec_info.transfer_chars = V4L2_XFER_FUNC_709;
> > > > +     if (vdec->codec_info.matrix_coeffs == V4L2_YCBCR_ENC_DEFAULT)
> > > > +             vdec->codec_info.matrix_coeffs = V4L2_YCBCR_ENC_709;
> > > > +     if (vdec->codec_info.full_range == V4L2_QUANTIZATION_DEFAULT)
> > > > +             vdec->codec_info.full_range =
> > > V4L2_QUANTIZATION_LIM_RANGE;
> > > > +}
> > > > +

