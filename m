Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1247D57A741
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiGSTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiGSTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:33:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E154AE9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g1so11279374qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ytt8W99R/1gVL6qCu426JdNAMSwnxaGiB2RrOmPn2bQ=;
        b=jo9GRZmtsv/swjdlfoOk7MWY4r1ORb9kgMa4KTyUSYz7NpLKrmK8iSB37MDIUQZe8d
         pYBryURxrImF61xL1LjUJ+YpBlHXXGoS94oOHdgRj0EAFXrGnrLwxsYVQCJxwNBaosU8
         3+k1xDIyp6ywrasOS5Ym7b5YTaLajr2hdrvcnLWX1ZeLdIXxZYNlv8iwS2OpTAT044nZ
         ZdW5V9qQ+piiVLfrnLtERIhIOkKf6oyMiC3XYUwsbtObWLSq3py9q8zD1ul8GQMJoh/v
         XsoOlJ25zZuaKllIwdKD/rkqde8QYfOHrdakyDbsd2BMUDBgsG/91m8f4CdSl7dSboy0
         mY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ytt8W99R/1gVL6qCu426JdNAMSwnxaGiB2RrOmPn2bQ=;
        b=LzB6kQLsL8EF/St0BKLiPMTJTCOJ03A+LRUlP8yXlXRxuMRs8dom+pwP2sJLZiUVkx
         rCcGp7hU6rts9OoMQ/XtsDU5I7HT5bZOnGXgtrUF/FBqCadgCFjakfwsHHYRJI6d8fmK
         jNRIcY2fOMnm22/GTKsocNFlyz72GAOCKJ3HIUo8M/j8psw/8CEKWxjVEWbVzrnkDSRh
         PnEgrqVnM7pa+1kfbBCxXfEP8GO4K7FFiI3lMkzAX0UgJa2DXKgalCP81iiGTVMkpvWC
         BPU2vAJ88U6eCZ2txbqnsyIjb07eTp0gh+N8VQuIn0vQZYXZrlF97ijCAovI5Qtjksd8
         LRuQ==
X-Gm-Message-State: AJIora9yljsagsrOhQ1eZDOoN45JE9r/9Zd+sY5UbIDntKsJBODietnL
        u8RKh3JIdkbLZn2sWVz20LuxUw==
X-Google-Smtp-Source: AGRyM1sY0SDWkMQO/frX8NkJlMJAlAKkJoEYueosCbdPRwiuMXyvymFN/MS1RD0dc4TfGlG1HjsvOQ==
X-Received: by 2002:a05:620a:2847:b0:6aa:cdf8:f71e with SMTP id h7-20020a05620a284700b006aacdf8f71emr21217869qkp.598.1658259197488;
        Tue, 19 Jul 2022 12:33:17 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a28c500b006b5e48997c2sm7712097qkp.32.2022.07.19.12.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:33:16 -0700 (PDT)
Message-ID: <29f4606d3a028da62d4d5f5686622609364a1979.camel@ndufresne.ca>
Subject: Re: [PATCH] media: destage Hantro VPU driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Chris Healy <cphealy@gmail.com>
Date:   Tue, 19 Jul 2022 15:33:15 -0400
In-Reply-To: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
References: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 18:41 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> The Hantro mainline driver has been used in production
> since several years and was only kept as a staging driver
> due the stateless CODEC controls.
>=20
> Now that all the stateless CODEC controls have been moved
> out of staging, graduate the driver as well.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  MAINTAINERS                                                 | 2 +-
>  drivers/media/platform/Kconfig                              | 1 +
>  drivers/media/platform/Makefile                             | 1 +
>  .../media/hantro =3D> media/platform/verisilicon}/Kconfig     | 6 +++++-
>  .../media/hantro =3D> media/platform/verisilicon}/Makefile    | 0
>  .../media/hantro =3D> media/platform/verisilicon}/hantro.h    | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_drv.c      | 0
>  .../media/hantro =3D> media/platform/verisilicon}/hantro_g1.c | 0
>  .../platform/verisilicon}/hantro_g1_h264_dec.c              | 0
>  .../platform/verisilicon}/hantro_g1_mpeg2_dec.c             | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_g1_regs.h  | 0
>  .../platform/verisilicon}/hantro_g1_vp8_dec.c               | 0
>  .../media/hantro =3D> media/platform/verisilicon}/hantro_g2.c | 0
>  .../platform/verisilicon}/hantro_g2_hevc_dec.c              | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_g2_regs.h  | 0
>  .../platform/verisilicon}/hantro_g2_vp9_dec.c               | 0
>  .../platform/verisilicon}/hantro_h1_jpeg_enc.c              | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_h1_regs.h  | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_h264.c     | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_hevc.c     | 0
>  .../media/hantro =3D> media/platform/verisilicon}/hantro_hw.h | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_jpeg.c     | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_jpeg.h     | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_mpeg2.c    | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_postproc.c | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_v4l2.c     | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_v4l2.h     | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_vp8.c      | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_vp9.c      | 0
>  .../hantro =3D> media/platform/verisilicon}/hantro_vp9.h      | 0
>  .../hantro =3D> media/platform/verisilicon}/imx8m_vpu_hw.c    | 0
>  .../platform/verisilicon}/rockchip_vpu2_hw_h264_dec.c       | 0
>  .../platform/verisilicon}/rockchip_vpu2_hw_jpeg_enc.c       | 0
>  .../platform/verisilicon}/rockchip_vpu2_hw_mpeg2_dec.c      | 0
>  .../platform/verisilicon}/rockchip_vpu2_hw_vp8_dec.c        | 0
>  .../platform/verisilicon}/rockchip_vpu2_regs.h              | 0
>  .../hantro =3D> media/platform/verisilicon}/rockchip_vpu_hw.c | 0
>  .../hantro =3D> media/platform/verisilicon}/sama5d4_vdec_hw.c | 0
>  .../hantro =3D> media/platform/verisilicon}/sunxi_vpu_hw.c    | 0
>  drivers/staging/media/Kconfig                               | 2 --
>  drivers/staging/media/Makefile                              | 1 -
>  drivers/staging/media/hantro/TODO                           | 2 --
>  42 files changed, 8 insertions(+), 7 deletions(-)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/Kc=
onfig (91%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/Ma=
kefile (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_drv.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g1.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g1_h264_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g1_mpeg2_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g1_regs.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g1_vp8_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g2.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g2_hevc_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g2_regs.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_g2_vp9_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_h1_jpeg_enc.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_h1_regs.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_h264.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_hevc.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_hw.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_jpeg.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_jpeg.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_mpeg2.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_postproc.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_v4l2.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_v4l2.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_vp8.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_vp9.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ha=
ntro_vp9.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/im=
x8m_vpu_hw.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu2_hw_h264_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu2_hw_jpeg_enc.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu2_hw_mpeg2_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu2_hw_vp8_dec.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu2_regs.h (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/ro=
ckchip_vpu_hw.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/sa=
ma5d4_vdec_hw.c (100%)
>  rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/su=
nxi_vpu_hw.c (100%)
>  delete mode 100644 drivers/staging/media/hantro/TODO
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fee2ac9a98f4..07ed4aaf545d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8686,7 +8686,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
>  F:	Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
>  F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> -F:	drivers/staging/media/hantro/
> +F:	drivers/media/platform/verisilicon/
> =20
>  HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
>  M:	Frank Seidel <frank@f-seidel.de>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kcon=
fig
> index f1056ceaf5a8..a9334263fa9b 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -81,6 +81,7 @@ source "drivers/media/platform/samsung/Kconfig"
>  source "drivers/media/platform/st/Kconfig"
>  source "drivers/media/platform/sunxi/Kconfig"
>  source "drivers/media/platform/ti/Kconfig"
> +source "drivers/media/platform/verisilicon/Kconfig"
>  source "drivers/media/platform/via/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
> =20
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Mak=
efile
> index a881e97bae95..a91f42024273 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -24,6 +24,7 @@ obj-y +=3D samsung/
>  obj-y +=3D st/
>  obj-y +=3D sunxi/
>  obj-y +=3D ti/
> +obj-y +=3D verisilicon/
>  obj-y +=3D via/
>  obj-y +=3D xilinx/
> =20
> diff --git a/drivers/staging/media/hantro/Kconfig b/drivers/media/platfor=
m/verisilicon/Kconfig
> similarity index 91%
> rename from drivers/staging/media/hantro/Kconfig
> rename to drivers/media/platform/verisilicon/Kconfig
> index 0172a6822ec2..e65b836b9d78 100644
> --- a/drivers/staging/media/hantro/Kconfig
> +++ b/drivers/media/platform/verisilicon/Kconfig
> @@ -1,7 +1,11 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +comment "Verisilicon media platform drivers"
> +
>  config VIDEO_HANTRO
>  	tristate "Hantro VPU driver"
>  	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMP=
ILE_TEST
> +	depends on V4L_MEM2MEM_DRIVERS
>  	depends on VIDEO_DEV
>  	select MEDIA_CONTROLLER
>  	select MEDIA_CONTROLLER_REQUEST_API
> diff --git a/drivers/staging/media/hantro/Makefile b/drivers/media/platfo=
rm/verisilicon/Makefile
> similarity index 100%
> rename from drivers/staging/media/hantro/Makefile
> rename to drivers/media/platform/verisilicon/Makefile
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/media/platfo=
rm/verisilicon/hantro.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro.h
> rename to drivers/media/platform/verisilicon/hantro.h
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/media/pl=
atform/verisilicon/hantro_drv.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_drv.c
> rename to drivers/media/platform/verisilicon/hantro_drv.c
> diff --git a/drivers/staging/media/hantro/hantro_g1.c b/drivers/media/pla=
tform/verisilicon/hantro_g1.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g1.c
> rename to drivers/media/platform/verisilicon/hantro_g1.c
> diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/=
media/platform/verisilicon/hantro_g1_h264_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g1_h264_dec.c
> rename to drivers/media/platform/verisilicon/hantro_g1_h264_dec.c
> diff --git a/drivers/staging/media/hantro/hantro_g1_mpeg2_dec.c b/drivers=
/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g1_mpeg2_dec.c
> rename to drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
> diff --git a/drivers/staging/media/hantro/hantro_g1_regs.h b/drivers/medi=
a/platform/verisilicon/hantro_g1_regs.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g1_regs.h
> rename to drivers/media/platform/verisilicon/hantro_g1_regs.h
> diff --git a/drivers/staging/media/hantro/hantro_g1_vp8_dec.c b/drivers/m=
edia/platform/verisilicon/hantro_g1_vp8_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g1_vp8_dec.c
> rename to drivers/media/platform/verisilicon/hantro_g1_vp8_dec.c
> diff --git a/drivers/staging/media/hantro/hantro_g2.c b/drivers/media/pla=
tform/verisilicon/hantro_g2.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g2.c
> rename to drivers/media/platform/verisilicon/hantro_g2.c
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/=
media/platform/verisilicon/hantro_g2_hevc_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> rename to drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
> diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/medi=
a/platform/verisilicon/hantro_g2_regs.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g2_regs.h
> rename to drivers/media/platform/verisilicon/hantro_g2_regs.h
> diff --git a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c b/drivers/m=
edia/platform/verisilicon/hantro_g2_vp9_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_g2_vp9_dec.c
> rename to drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/=
media/platform/verisilicon/hantro_h1_jpeg_enc.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> rename to drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
> diff --git a/drivers/staging/media/hantro/hantro_h1_regs.h b/drivers/medi=
a/platform/verisilicon/hantro_h1_regs.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_h1_regs.h
> rename to drivers/media/platform/verisilicon/hantro_h1_regs.h
> diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/media/p=
latform/verisilicon/hantro_h264.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_h264.c
> rename to drivers/media/platform/verisilicon/hantro_h264.c
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/media/p=
latform/verisilicon/hantro_hevc.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_hevc.c
> rename to drivers/media/platform/verisilicon/hantro_hevc.c
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/media/pla=
tform/verisilicon/hantro_hw.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_hw.h
> rename to drivers/media/platform/verisilicon/hantro_hw.h
> diff --git a/drivers/staging/media/hantro/hantro_jpeg.c b/drivers/media/p=
latform/verisilicon/hantro_jpeg.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_jpeg.c
> rename to drivers/media/platform/verisilicon/hantro_jpeg.c
> diff --git a/drivers/staging/media/hantro/hantro_jpeg.h b/drivers/media/p=
latform/verisilicon/hantro_jpeg.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_jpeg.h
> rename to drivers/media/platform/verisilicon/hantro_jpeg.h
> diff --git a/drivers/staging/media/hantro/hantro_mpeg2.c b/drivers/media/=
platform/verisilicon/hantro_mpeg2.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_mpeg2.c
> rename to drivers/media/platform/verisilicon/hantro_mpeg2.c
> diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/med=
ia/platform/verisilicon/hantro_postproc.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_postproc.c
> rename to drivers/media/platform/verisilicon/hantro_postproc.c
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/media/p=
latform/verisilicon/hantro_v4l2.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_v4l2.c
> rename to drivers/media/platform/verisilicon/hantro_v4l2.c
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/media/p=
latform/verisilicon/hantro_v4l2.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_v4l2.h
> rename to drivers/media/platform/verisilicon/hantro_v4l2.h
> diff --git a/drivers/staging/media/hantro/hantro_vp8.c b/drivers/media/pl=
atform/verisilicon/hantro_vp8.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_vp8.c
> rename to drivers/media/platform/verisilicon/hantro_vp8.c
> diff --git a/drivers/staging/media/hantro/hantro_vp9.c b/drivers/media/pl=
atform/verisilicon/hantro_vp9.c
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_vp9.c
> rename to drivers/media/platform/verisilicon/hantro_vp9.c
> diff --git a/drivers/staging/media/hantro/hantro_vp9.h b/drivers/media/pl=
atform/verisilicon/hantro_vp9.h
> similarity index 100%
> rename from drivers/staging/media/hantro/hantro_vp9.h
> rename to drivers/media/platform/verisilicon/hantro_vp9.h
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/media/=
platform/verisilicon/imx8m_vpu_hw.c
> similarity index 100%
> rename from drivers/staging/media/hantro/imx8m_vpu_hw.c
> rename to drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c b/d=
rivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c
> rename to drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/d=
rivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> rename to drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_mpeg2_dec.c b/=
drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu2_hw_mpeg2_dec.c
> rename to drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_vp8_dec.c b/dr=
ivers/media/platform/verisilicon/rockchip_vpu2_hw_vp8_dec.c
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu2_hw_vp8_dec.c
> rename to drivers/media/platform/verisilicon/rockchip_vpu2_hw_vp8_dec.c
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_regs.h b/drivers/=
media/platform/verisilicon/rockchip_vpu2_regs.h
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu2_regs.h
> rename to drivers/media/platform/verisilicon/rockchip_vpu2_regs.h
> diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/med=
ia/platform/verisilicon/rockchip_vpu_hw.c
> similarity index 100%
> rename from drivers/staging/media/hantro/rockchip_vpu_hw.c
> rename to drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> diff --git a/drivers/staging/media/hantro/sama5d4_vdec_hw.c b/drivers/med=
ia/platform/verisilicon/sama5d4_vdec_hw.c
> similarity index 100%
> rename from drivers/staging/media/hantro/sama5d4_vdec_hw.c
> rename to drivers/media/platform/verisilicon/sama5d4_vdec_hw.c
> diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/media/=
platform/verisilicon/sunxi_vpu_hw.c
> similarity index 100%
> rename from drivers/staging/media/hantro/sunxi_vpu_hw.c
> rename to drivers/media/platform/verisilicon/sunxi_vpu_hw.c
> diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfi=
g
> index 421ce9dbf44c..2b8ad4cc8ac5 100644
> --- a/drivers/staging/media/Kconfig
> +++ b/drivers/staging/media/Kconfig
> @@ -24,8 +24,6 @@ source "drivers/staging/media/atomisp/Kconfig"
> =20
>  source "drivers/staging/media/av7110/Kconfig"
> =20
> -source "drivers/staging/media/hantro/Kconfig"
> -
>  source "drivers/staging/media/imx/Kconfig"
> =20
>  source "drivers/staging/media/ipu3/Kconfig"
> diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makef=
ile
> index 950e96f10aad..a12d0bb9dca3 100644
> --- a/drivers/staging/media/Makefile
> +++ b/drivers/staging/media/Makefile
> @@ -8,7 +8,6 @@ obj-$(CONFIG_VIDEO_ROCKCHIP_VDEC)	+=3D rkvdec/
>  obj-$(CONFIG_VIDEO_STKWEBCAM)	+=3D stkwebcam/
>  obj-$(CONFIG_VIDEO_SUNXI)	+=3D sunxi/
>  obj-$(CONFIG_VIDEO_TEGRA)	+=3D tegra-video/
> -obj-$(CONFIG_VIDEO_HANTRO)	+=3D hantro/
>  obj-$(CONFIG_VIDEO_IPU3_IMGU)	+=3D ipu3/
>  obj-$(CONFIG_VIDEO_ZORAN)	+=3D zoran/
>  obj-$(CONFIG_DVB_AV7110)	+=3D av7110/
> diff --git a/drivers/staging/media/hantro/TODO b/drivers/staging/media/ha=
ntro/TODO
> deleted file mode 100644
> index 8483ff482146..000000000000
> --- a/drivers/staging/media/hantro/TODO
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -The V4L controls for the HEVC CODEC are not yet part of the stable uABI,
> -we are keeping this driver in staging until the HEVC uABI has been merge=
d.

