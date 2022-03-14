Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55BC4D870F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbiCNOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiCNOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:38:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF110FA;
        Mon, 14 Mar 2022 07:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8AB6CE1292;
        Mon, 14 Mar 2022 14:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA29CC340E9;
        Mon, 14 Mar 2022 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647268662;
        bh=ZHoUtJKA0SpRqP75CZ9MUNxuB4PnjepeKckBnJGWgr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AGBd+CSScIQ6AMxCSzvqfp354wxAa9bWDi1yJXIyY5pcHzD5QpQncpCBnkaDNohEK
         BuOY4o1pCi/f58DjJuVjR0rG237sAgz7xRGxuSbAzeFVhpW2TfFO0/T6HXFCIgPEfR
         P7Rnp9P0KvdhxF5UlnWMfhCB4zFdbKmKqFcyHKTrhrMMnPysDpEryV6tZZzwO1TBSC
         9hRzNwV+vP3GkrF0CMrAtxOIkYlEwtmGFalKTgfsKwn4/2NQc/CDP4ynLa+CCo2njv
         /r3BFWTbyg6DGOLpb2crAmZ2n+tsKwaX1G5KEs+ccBaZw5n7TCrRQOigGeR86259SN
         DZeGnqpXQhtmA==
Date:   Mon, 14 Mar 2022 15:37:33 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Courbot <acourbot@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hirokazu Honda <hiroh@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Cho <stevecho@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 06/24] media: platform: rename mtk-vcodec/ to
 mediatek/mtk-vcodec/
Message-ID: <20220314153733.63d1451f@coco.lan>
In-Reply-To: <17120e5dcc7b7fdac207a41d764a13db7b270380.camel@collabora.com>
References: <cover.1647167750.git.mchehab@kernel.org>
        <53a632ce79c9d02673d7540e18d681f123afb801.1647167750.git.mchehab@kernel.org>
        <17120e5dcc7b7fdac207a41d764a13db7b270380.camel@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 14 Mar 2022 09:09:45 -0400
Nicolas Dufresne <nicolas.dufresne@collabora.com> escreveu:

> Le dimanche 13 mars 2022 =C3=A0 11:51 +0100, Mauro Carvalho Chehab a =C3=
=A9crit=C2=A0:
> > As the end goal is to have platform drivers split by vendor,
> > rename mtk-vcodec/ to mediatek/mtk-vcodec/. =20
>=20
> Was thinking all these mtk-* directory didn't fit with the platform/ sema=
ntic. I
> totally support this change. I suppose jpeg/mdp/vpu also needs to be move=
d. And
> mdp3 and various vcodec patches will need a new submission.

They were all moved too, each one on a separate patch in this series:

    $ LANG=3DC tree -d drivers/media/platform/
    drivers/media/platform/
    |-- allegro-dvt
    |-- allwinner
    |   |-- sun4i-csi
    |   |-- sun6i-csi
    |   |-- sun8i-di
    |   `-- sun8i-rotate
    |-- amlogic
    |   `-- meson-ge2d
    |-- amphion
    |-- aspeed
    |-- atmel
    |-- cadence
    |-- chips-media
    |-- intel
    |-- marvell
    |-- mediatek
    |   |-- mtk-jpeg
    |   |-- mtk-mdp
    |   |-- mtk-vcodec
    |   |   |-- vdec
    |   |   `-- venc
    |   `-- mtk-vpu
    |-- nvidia
    |   `-- tegra-vde
    |-- nxp
    |   `-- imx-jpeg
    |-- qcom
    |   |-- camss
    |   `-- venus
    |-- renesas
    |   |-- rcar-vin
    |   `-- vsp1
    |-- rockchip
    |   |-- rga
    |   `-- rkisp1
    |-- samsung
    |   |-- exynos-gsc
    |   |-- exynos4-is
    |   |-- s3c-camif
    |   |-- s5p-g2d
    |   |-- s5p-jpeg
    |   `-- s5p-mfc
    |-- stm
    |   |-- sti
    |   |   |-- bdisp
    |   |   |-- c8sectpfe
    |   |   |-- delta
    |   |   `-- hva
    |   `-- stm32
    |       `-- dma2d
    |-- ti
    |   |-- am437x
    |   |-- cal
    |   |-- davinci
    |   |-- omap
    |   |-- omap3isp
    |   `-- vpe
    |-- ti-vpe
    |-- via
    `-- xilinx

>=20
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org> =20
>=20
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>=20
> > ---
> >=20
> > To avoid mailbombing on a large number of people, only mailing lists we=
re C/C on the cover.
> > See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.=
mchehab@kernel.org/
> >=20
> >  MAINTAINERS                                                     | 2 +-
> >  drivers/media/platform/Kconfig                                  | 2 +-
> >  drivers/media/platform/Makefile                                 | 2 +-
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Kconfig        | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Makefile       | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec.c   | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec.h   | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c     | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h      | 0
> >  .../{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c         | 0
> >  .../{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c        | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_drv.h   | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc.c   | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc.h   | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c     | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h      | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw.c    | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw.h    | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h     | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c      | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_intr.c  | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_intr.h  | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_util.c  | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_util.h  | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h264_if.c      | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c  | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_base.h    | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.c  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.h  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_ipi_msg.h | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_queue.c   | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_queue.h   | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.c  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.h  | 0
> >  .../platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_h264_if.c      | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_vp8_if.c | 0
> >  .../media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_base.h    | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.c  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.h  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_ipi_msg.h | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.c  | 0
> >  drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.h  | 0
> >  49 files changed, 3 insertions(+), 3 deletions(-)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Kconfig (100=
%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Makefile (10=
0%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_drv.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_hw.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_hw.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_pm.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_pm.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_stateful.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
ec_stateless.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_d=
rv.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_e=
nc.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_e=
nc.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_e=
nc_drv.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_e=
nc_pm.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_e=
nc_pm.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_f=
w.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_f=
w.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_f=
w_priv.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_f=
w_scp.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_f=
w_vpu.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_i=
ntr.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_i=
ntr.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_u=
til.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_u=
til.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h2=
64_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h2=
64_req_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp=
8_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp=
9_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_bas=
e.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.=
c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.=
h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_ipi_msg=
.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_que=
ue.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_que=
ue.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.=
c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.=
h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_h2=
64_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_vp=
8_if.c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_bas=
e.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.=
c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.=
h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_ipi_msg=
.h (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.=
c (100%)
> >  rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.=
h (100%)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2203d98bbcf1..bfe014870a77 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12147,7 +12147,7 @@ M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> >  S:	Supported
> >  F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> >  F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
> > -F:	drivers/media/platform/mtk-vcodec/
> > +F:	drivers/media/platform/mediatek/mtk-vcodec/
> >  F:	drivers/media/platform/mtk-vpu/
> > =20
> >  MEDIATEK MMC/SD/SDIO DRIVER
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kc=
onfig
> > index a45fd3fe103e..8ba10b657164 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -80,7 +80,7 @@ source "drivers/media/platform/intel/Kconfig"
> >  source "drivers/media/platform/marvell/Kconfig"
> >  source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
> >  source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
> > -source "drivers/media/platform/mtk-vcodec/Kconfig"
> > +source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
> >  source "drivers/media/platform/mtk-vpu/Kconfig"
> >  source "drivers/media/platform/nxp/Kconfig"
> >  source "drivers/media/platform/omap/Kconfig"
> > diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/M=
akefile
> > index 6f5d09cd8f9b..637a3a7ac036 100644
> > --- a/drivers/media/platform/Makefile
> > +++ b/drivers/media/platform/Makefile
> > @@ -20,7 +20,7 @@ obj-y +=3D intel/
> >  obj-y +=3D marvell/
> >  obj-y +=3D mediatek/mtk-jpeg/
> >  obj-y +=3D mediatek/mtk-mdp/
> > -obj-y +=3D mtk-vcodec/
> > +obj-y +=3D mediatek/mtk-vcodec/
> >  obj-y +=3D mtk-vpu/
> >  obj-y +=3D nxp/
> >  obj-y +=3D omap/
> > diff --git a/drivers/media/platform/mtk-vcodec/Kconfig b/drivers/media/=
platform/mediatek/mtk-vcodec/Kconfig
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/Kconfig
> > rename to drivers/media/platform/mediatek/mtk-vcodec/Kconfig
> > diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/media=
/platform/mediatek/mtk-vcodec/Makefile
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/Makefile
> > rename to drivers/media/platform/mediatek/mtk-vcodec/Makefile
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drive=
rs/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/d=
rivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv=
.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.=
c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_sta=
teful.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless=
.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_sta=
teless.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drive=
rs/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/d=
rivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv=
.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/driver=
s/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/driver=
s/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h b/d=
rivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv=
.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c =
b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req=
_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_base.h b/driver=
s/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_drv_base.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.c b/drivers/=
media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h b/drivers/=
media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers=
/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.c b/drive=
rs/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/=
media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/=
media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
> > diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_base.h b/driver=
s/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_drv_base.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.c b/drivers/=
media/platform/mediatek/mtk-vcodec/venc_drv_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_drv_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/=
media/platform/mediatek/mtk-vcodec/venc_drv_if.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_drv_if.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_ipi_msg.h b/drivers=
/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_ipi_msg.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/=
media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.c
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
> > diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/drivers/=
media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
> > similarity index 100%
> > rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.h
> > rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h =20
>=20



Thanks,
Mauro
