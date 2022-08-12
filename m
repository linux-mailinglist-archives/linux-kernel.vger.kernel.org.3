Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8A590C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiHLHL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiHLHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:11:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E39A2B26A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:11:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v3so242312wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=1kTHQ78qe8UPM4cdFXOsk5nFZVYmZD+vL0HBZlWukDY=;
        b=NITgJ10Qy4/KnfGWxZ/TuJFN+JazDiosieAMYaEgSKEJ7jo2XowqjLpzSFF9wby4R9
         i1klqKcyvoQewsFnKmqUwkRw7POoWz/kU99tvEUanh8tJVnPYDECF5eI7fNloiyqNtMs
         cUsrbFwTHomiddf/ia/mUfBRdq30/P9HuuXkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=1kTHQ78qe8UPM4cdFXOsk5nFZVYmZD+vL0HBZlWukDY=;
        b=yUmAKaanifZd6P6b815tWNdoHR4JXrFf0G/B8+6Jqv2nZh1mdgYRlfw8LEa1C1CGB4
         VzEGBdpxklxcMf5W7Ra3NS7Df24kRtchY9cj+lWLbGCSF/mSnkdIfLK6RKYIGaCm49X4
         yQmtxznIhahY3jcenWsX8W8MFrhCreKhU+JdUjEe27L4Gcfj++GYfMCH8H2P4EL4dCml
         m/2LpuqYv4WEmk9tn8PZS5EoDeD6mjtIW7ep+5nbuJ42hAO1fE67vWC8XMqiog5bZz+6
         xo7nKCjaScMTTJtt/F3MFqOCPgKpLvUCB1CYFDR+KaVtOXAqFtK6KJGSU4zGz+IreRSI
         fKFA==
X-Gm-Message-State: ACgBeo0hHQCViSStq0PG6ajTNKT5fuUaEyFVg7Zonsas0btEktdkHf6Z
        02nWBNfCW+2Mlv0oGOJVggJLYg==
X-Google-Smtp-Source: AA6agR4pH5VR48E+MInnf4od9xftjF9X19R8k8HYqmSrMdKMdDBAEbr49D3bt8CWjC2Y07xUTnmUMg==
X-Received: by 2002:a5d:54cb:0:b0:220:6426:6219 with SMTP id x11-20020a5d54cb000000b0022064266219mr1200520wrv.461.1660288312964;
        Fri, 12 Aug 2022 00:11:52 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d500e000000b00222d4dfcdffsm1135146wrt.87.2022.08.12.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 00:11:52 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:11:50 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 1/4] media: add nv12_8l128 and
 nv12_10be_8l128 video format.
Message-ID: <20220812071150.GA5705@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
 <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB6341198A94DC408DF921503BE7679@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB6341198A94DC408DF921503BE7679@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Fri, Aug 12, 2022 at 01:25:37AM +0000, Ming Qian wrote:
> >From: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >Sent: 2022年8月11日 23:19
> >To: Ming Qian <ming.qian@nxp.com>
> >Cc: mchehab@kernel.org; hverkuil-cisco@xs4all.nl; shawnguo@kernel.org;
> >robh+dt@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> >festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; X.H. Bao
> ><xiahong.bao@nxp.com>; linux-media@vger.kernel.org;
> >linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >Subject: [EXT] Re: [PATCH v4 1/4] media: add nv12_8l128 and
> >nv12_10be_8l128 video format.
> >
> >Caution: EXT Email
> >
> >Hi Ming,
> >
> >On Tue, Aug 09, 2022 at 02:50:38PM +0800, Ming Qian wrote:
> >> add contiguous nv12 tiled format nv12_8l128 and nv12_10be_8l128
> >>
> >> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> >> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >> ---
> >>  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst         | 8 ++++++++
> >>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 2 ++
> >>  include/uapi/linux/videodev2.h                            | 2 ++
> >>  3 files changed, 12 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> >> b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> >> index 10b1feeb0b57..f1d5bb7b806d 100644
> >> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> >> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> >> @@ -273,7 +273,9 @@ of the luma plane.
> >>  .. _V4L2-PIX-FMT-NV12-16L16:
> >>  .. _V4L2-PIX-FMT-NV12-32L32:
> >>  .. _V4L2-PIX-FMT-NV12M-8L128:
> >> +.. _V4L2-PIX-FMT-NV12-8L128:
> >>  .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> >> +.. _V4L2-PIX-FMT-NV12-10BE-8L128:
> >>  .. _V4L2-PIX-FMT-MM21:
> >>
> >>  Tiled NV12
> >> @@ -319,6 +321,9 @@ pixels in 2D 8x128 tiles, and stores tiles linearly in
> >memory.
> >>  The image height must be aligned to a multiple of 128.
> >>  The layouts of the luma and chroma planes are identical.
> >>
> >> +``V4L2_PIX_FMT_NV12_8L128`` is similar to
> >> +``V4L2_PIX_FMT_NV12M_8L128`` but stores two planes in one memory.
> >> +
> >
> >Don't know, maybe we need more details here?
> 
> Hi Tommaso,
>     I have added the non contiguous format V4L2_PIX_FMT_NV12M_8L128, they're almost same, but store two planes in contiguous memory or non contiguous memory, just like NV12 and NV12M,  
>     the descriptions are almost the same, so I just say V4L2_PIX_FMT_NV12_8L128 is similar to V4L2_PIX_FMT_NV12M_8L128.
>     Do I need to copy the full description from the V4L2_PIX_FMT_NV12M_8L128 to here?
> 
> Ming

You are right the only differences is in which way the planes are
stored in memory, sorry. It's clear :)

Thanks for clarifications,
Tommaso

> 
> >
> >>  ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to
> >> ``V4L2_PIX_FMT_NV12M`` but stores
> >>  10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
> >>  the data is arranged in big endian order.
> >> @@ -334,6 +339,9 @@ byte 2: Y1(bits 3-0) Y2(bits 9-6)  byte 3: Y2(bits
> >> 5-0) Y3(bits 9-8)  byte 4: Y3(bits 7-0)
> >>
> >> +``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to
> >> +``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores two planes in one
> >memory.
> >> +
> >
> >here also?
> 
> It's the same issue.
> 
> >
> >>  ``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma
> >> pixels  in 16x16 tiles. The line stride must be aligned to a multiple
> >> of 16 and the  image height must be aligned to a multiple of 32. The
> >> number of luma and chroma diff --git
> >> a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> index c314025d977e..d973bd2ff750 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> @@ -1444,7 +1444,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc
> >*fmt)
> >>       case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
> >>       case V4L2_META_FMT_RK_ISP1_PARAMS:      descr = "Rockchip
> >ISP1 3A Parameters"; break;
> >>       case V4L2_META_FMT_RK_ISP1_STAT_3A:     descr = "Rockchip ISP1
> >3A Statistics"; break;
> >> +     case V4L2_PIX_FMT_NV12_8L128:   descr = "NV12 (8x128 Linear)";
> >break;
> >>       case V4L2_PIX_FMT_NV12M_8L128:  descr = "NV12M (8x128
> >Linear)";
> >> break;
> >> +     case V4L2_PIX_FMT_NV12_10BE_8L128:      descr = "10-bit NV12
> >(8x128 Linear, BE)"; break;
> >>       case V4L2_PIX_FMT_NV12M_10BE_8L128:     descr = "10-bit
> >NV12M (8x128 Linear, BE)"; break;
> >>
> >>       default:
> >> diff --git a/include/uapi/linux/videodev2.h
> >> b/include/uapi/linux/videodev2.h index cd66e01ed3c3..64f16490dd2b
> >> 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -655,6 +655,8 @@ struct v4l2_pix_format {  #define
> >> V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr
> >> 4:2:0 16x16 tiles */  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S',
> >> 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */  #define
> >> V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr
> >> 4:2:0 10-bit 4x4 macroblocks */
> >> +#define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /*
> >Y/CbCr 4:2:0 8x128 tiles */
> >> +#define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1',
> >> +'2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> >>
> >>  /* Tiled YUV formats, non contiguous planes */  #define
> >> V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr
> >> 4:2:0 64x32 tiles */
> >> --
> >> 2.37.1
> >>
> >
> >For the other parts look's good to me.
> >Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >
> >Regards,
> >Tommaso
> >
> >--
> >Tommaso Merciai
> >Embedded Linux Engineer
> >tommaso.merciai@amarulasolutions.com
> >__________________________________
> >
> >Amarula Solutions SRL
> >Via Le Canevare 30, 31100 Treviso, Veneto, IT T. +39 042 243 5310
> >info@amarulasolutions.com
> >https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.am
> >arulasolutions.com%2F&amp;data=05%7C01%7Cming.qian%40nxp.com%7Cb6
> >16d089dcbb47195b1308da7baccf05%7C686ea1d3bc2b4c6fa92cd99c5c30163
> >5%7C0%7C0%7C637958279379165164%7CUnknown%7CTWFpbGZsb3d8eyJW
> >IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> >00%7C%7C%7C&amp;sdata=ReeppP8PqkPQN5uQClb1CdRcNupMFHybRrbQoM
> >%2B2Wkg%3D&amp;reserved=0

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
