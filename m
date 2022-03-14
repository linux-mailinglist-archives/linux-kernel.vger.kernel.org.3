Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6E4D8868
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiCNPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiCNPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFA2E0BD;
        Mon, 14 Mar 2022 08:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D5BB80D40;
        Mon, 14 Mar 2022 15:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5309FC340E9;
        Mon, 14 Mar 2022 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272563;
        bh=rlomTh/bDE2SR0iJKSP/UqznM+vMfw7/o7SNQEMHVkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cC3cs/elW5BH7UAWfAD8MZd+XWOT8RGIUJWA4ehdzUHYkh8tfkTS2AKJym6WN8vgi
         MPx5W6XxREqc0jU/GMyMEi3XpS24oQo55ZeF7bK6q+Tv9QWjV5FGwpV5xhP8AO3YG0
         vHkM+GMyqr9+06Uvva+2S42Ae5zPCZAOLS0ykn+bMb9R/yrJbfr0BuH9H8cc/3+39j
         7vP0gqwnzJRd302oQgkBXodIZnfEFLJRwnV6NiS0N5MDjGaD6A6eKikWvvxAAdZ7ZC
         6Uv9KiwUdefJDVAix/SwJLSraZ09uIEoMypSKqxiaCxtr6aU8MqYYv9DG8CNvqKbTb
         0B+SoEh2Hx3JA==
Date:   Mon, 14 Mar 2022 16:42:34 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Courbot <acourbot@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
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
Message-ID: <20220314164234.5666592e@coco.lan>
In-Reply-To: <30eae66e-5dd2-9868-dd2a-aab377ffd821@collabora.com>
References: <cover.1647167750.git.mchehab@kernel.org>
        <53a632ce79c9d02673d7540e18d681f123afb801.1647167750.git.mchehab@kernel.org>
        <17120e5dcc7b7fdac207a41d764a13db7b270380.camel@collabora.com>
        <20220314153733.63d1451f@coco.lan>
        <30eae66e-5dd2-9868-dd2a-aab377ffd821@collabora.com>
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

Em Mon, 14 Mar 2022 16:02:43 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> escrev=
eu:

> Il 14/03/22 15:37, Mauro Carvalho Chehab ha scritto:
> > Em Mon, 14 Mar 2022 09:09:45 -0400
> > Nicolas Dufresne <nicolas.dufresne@collabora.com> escreveu:
> >  =20
> >> Le dimanche 13 mars 2022 =C3=A0 11:51 +0100, Mauro Carvalho Chehab a =
=C3=A9crit=C2=A0: =20
> >>> As the end goal is to have platform drivers split by vendor,
> >>> rename mtk-vcodec/ to mediatek/mtk-vcodec/. =20
> >>
> >> Was thinking all these mtk-* directory didn't fit with the platform/ s=
emantic. I
> >> totally support this change. I suppose jpeg/mdp/vpu also needs to be m=
oved. And
> >> mdp3 and various vcodec patches will need a new submission. =20
> >=20
> > They were all moved too, each one on a separate patch in this series:
> >  =20
>=20
> Hello Mauro, Nicolas
>=20
> I was wondering if we could also drop the 'mtk-' prefix from the folder n=
ames,
> as 'mtk' effectively stands for 'mediatek'... so we would have them as:
>=20
> mediatek/jpeg
> mediatek/mdp

> mediatek/mdp3

Hmm... I guess this one didn't reach upstream yet.

> mediatek/vcodec
> mediatek/vpu
>=20
> mediatek/mtk-... looks a bit repetitive :)

Ok, but I'll likely place this on a separate patch at the end of this=20
series. Rebasing such series has been no fun ;-)

>=20
> Cheers,
> Angelo
>=20
> >      $ LANG=3DC tree -d drivers/media/platform/
> >      drivers/media/platform/
> >      |-- allegro-dvt
> >      |-- allwinner
> >      |   |-- sun4i-csi
> >      |   |-- sun6i-csi
> >      |   |-- sun8i-di
> >      |   `-- sun8i-rotate
> >      |-- amlogic
> >      |   `-- meson-ge2d
> >      |-- amphion
> >      |-- aspeed
> >      |-- atmel
> >      |-- cadence
> >      |-- chips-media
> >      |-- intel
> >      |-- marvell
> >      |-- mediatek
> >      |   |-- mtk-jpeg
> >      |   |-- mtk-mdp
> >      |   |-- mtk-vcodec
> >      |   |   |-- vdec
> >      |   |   `-- venc
> >      |   `-- mtk-vpu
> >      |-- nvidia
> >      |   `-- tegra-vde
> >      |-- nxp
> >      |   `-- imx-jpeg
> >      |-- qcom
> >      |   |-- camss
> >      |   `-- venus
> >      |-- renesas
> >      |   |-- rcar-vin
> >      |   `-- vsp1
> >      |-- rockchip
> >      |   |-- rga
> >      |   `-- rkisp1
> >      |-- samsung
> >      |   |-- exynos-gsc
> >      |   |-- exynos4-is
> >      |   |-- s3c-camif
> >      |   |-- s5p-g2d
> >      |   |-- s5p-jpeg
> >      |   `-- s5p-mfc
> >      |-- stm
> >      |   |-- sti
> >      |   |   |-- bdisp
> >      |   |   |-- c8sectpfe
> >      |   |   |-- delta
> >      |   |   `-- hva
> >      |   `-- stm32
> >      |       `-- dma2d
> >      |-- ti
> >      |   |-- am437x
> >      |   |-- cal
> >      |   |-- davinci
> >      |   |-- omap
> >      |   |-- omap3isp
> >      |   `-- vpe
> >      |-- ti-vpe
> >      |-- via
> >      `-- xilinx
> >  =20
> >> =20
> >>>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org> =20
> >>
> >> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >> =20
> >>> ---
> >>>
> >>> To avoid mailbombing on a large number of people, only mailing lists =
were C/C on the cover.
> >>> See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.gi=
t.mchehab@kernel.org/
> >>>
> >>>   MAINTAINERS                                                     | 2=
 +-
> >>>   drivers/media/platform/Kconfig                                  | 2=
 +-
> >>>   drivers/media/platform/Makefile                                 | 2=
 +-
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Kconfig        |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Makefile       |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec.c   |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec.h   |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c     |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h      |=
 0
> >>>   .../{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c         |=
 0
> >>>   .../{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c        |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_drv.h   |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc.c   |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc.h   |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c     |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h      |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw.c    |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw.h    |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h     |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c      |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_intr.c  |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_intr.h  |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_util.c  |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcodec_util.h  |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h264_if.c      |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c  |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_base.h    |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.c  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_if.h  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_ipi_msg.h |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_queue.c   |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_queue.h   |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.c  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_if.h  |=
 0
> >>>   .../platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_h264_if.c      |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc_vp8_if.c |=
 0
> >>>   .../media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_base.h    |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.c  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_if.h  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_ipi_msg.h |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.c  |=
 0
> >>>   drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_if.h  |=
 0
> >>>   49 files changed, 3 insertions(+), 3 deletions(-)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Kconfig (=
100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/Makefile =
(100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_drv.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_hw.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_hw.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_pm.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_pm.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_stateful.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_dec_stateless.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_drv.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_enc.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_enc.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_enc_drv.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_enc_pm.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_enc_pm.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_fw.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_fw.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_fw_priv.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_fw_scp.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_fw_vpu.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_intr.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_intr.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_util.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/mtk_vcode=
c_util.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec=
_h264_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec=
_h264_req_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec=
_vp8_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec/vdec=
_vp9_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_=
base.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_=
if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_drv_=
if.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_ipi_=
msg.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_=
queue.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_msg_=
queue.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_=
if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/vdec_vpu_=
if.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc=
_h264_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc/venc=
_vp8_if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_=
base.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_=
if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_drv_=
if.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_ipi_=
msg.h (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_=
if.c (100%)
> >>>   rename drivers/media/platform/{ =3D> mediatek}/mtk-vcodec/venc_vpu_=
if.h (100%)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 2203d98bbcf1..bfe014870a77 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -12147,7 +12147,7 @@ M:	Andrew-CT Chen <andrew-ct.chen@mediatek.co=
m>
> >>>   S:	Supported
> >>>   F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> >>>   F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
> >>> -F:	drivers/media/platform/mtk-vcodec/
> >>> +F:	drivers/media/platform/mediatek/mtk-vcodec/
> >>>   F:	drivers/media/platform/mtk-vpu/
> >>>  =20
> >>>   MEDIATEK MMC/SD/SDIO DRIVER
> >>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/=
Kconfig
> >>> index a45fd3fe103e..8ba10b657164 100644
> >>> --- a/drivers/media/platform/Kconfig
> >>> +++ b/drivers/media/platform/Kconfig
> >>> @@ -80,7 +80,7 @@ source "drivers/media/platform/intel/Kconfig"
> >>>   source "drivers/media/platform/marvell/Kconfig"
> >>>   source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
> >>>   source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
> >>> -source "drivers/media/platform/mtk-vcodec/Kconfig"
> >>> +source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
> >>>   source "drivers/media/platform/mtk-vpu/Kconfig"
> >>>   source "drivers/media/platform/nxp/Kconfig"
> >>>   source "drivers/media/platform/omap/Kconfig"
> >>> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform=
/Makefile
> >>> index 6f5d09cd8f9b..637a3a7ac036 100644
> >>> --- a/drivers/media/platform/Makefile
> >>> +++ b/drivers/media/platform/Makefile
> >>> @@ -20,7 +20,7 @@ obj-y +=3D intel/
> >>>   obj-y +=3D marvell/
> >>>   obj-y +=3D mediatek/mtk-jpeg/
> >>>   obj-y +=3D mediatek/mtk-mdp/
> >>> -obj-y +=3D mtk-vcodec/
> >>> +obj-y +=3D mediatek/mtk-vcodec/
> >>>   obj-y +=3D mtk-vpu/
> >>>   obj-y +=3D nxp/
> >>>   obj-y +=3D omap/
> >>> diff --git a/drivers/media/platform/mtk-vcodec/Kconfig b/drivers/medi=
a/platform/mediatek/mtk-vcodec/Kconfig
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/Kconfig
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/Kconfig
> >>> diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/med=
ia/platform/mediatek/mtk-vcodec/Makefile
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/Makefile
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/Makefile
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h b/dri=
vers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b=
/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_d=
rv.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_h=
w.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_h=
w.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_p=
m.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_p=
m.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_statefu=
l.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful=
.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_s=
tateful.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_statele=
ss.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateles=
s.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_s=
tateless.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/dri=
vers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/dri=
vers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b=
/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_d=
rv.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_p=
m.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_p=
m.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/driv=
ers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h b=
/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_pr=
iv.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_sc=
p.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/=
drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vp=
u.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/dr=
ivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/=
drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_i=
f.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.=
c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_r=
eq_if.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/d=
rivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if=
.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/d=
rivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if=
.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_base.h b/driv=
ers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_base.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.c b/driver=
s/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h b/driver=
s/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.c b/dri=
vers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.h b/dri=
vers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/driver=
s/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/driver=
s/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/=
drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_i=
f.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/d=
rivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if=
.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_base.h b/driv=
ers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_drv_base.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.c b/driver=
s/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_drv_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/driver=
s/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_drv_if.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_ipi_msg.h b/drive=
rs/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_ipi_msg.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/driver=
s/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.c
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
> >>> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/driver=
s/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
> >>> similarity index 100%
> >>> rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.h
> >>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h =20
> >> =20
> >=20
> >=20
> >=20
> > Thanks,
> > Mauro =20
>=20
>=20



Thanks,
Mauro
