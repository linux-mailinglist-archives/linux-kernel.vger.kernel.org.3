Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0D565E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGDTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGDTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:40:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348BE00F;
        Mon,  4 Jul 2022 12:40:30 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5165660199A;
        Mon,  4 Jul 2022 20:40:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656963628;
        bh=nNZa7Ge5MHVKSzxBaBt+mXeh5k5ePRYOAg+X8XLySH4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eruSIePRQZDm8Ne6Q3JCzJYO4I/2i42H4ighHZIUZPsW4j5ybJQFO/HpxAeFIjEaa
         TsMqdPXipksdbSR//jj/PvOVqUEuz2U9Js2S6F6K6Rb6KUiC6k+rDHTWFjzr+6+RNi
         VXeeswjL5JjfsUNA2cnsqE9KOycsiHjZ9q6ETTa05y+SMTtXutv8eU/29RgAANrvTQ
         GF5OsiKwqO96SQuWmvgUdnPDTZQdRkcKacH+uze9IhkGVDbg1A9xQUSMLKDnu4k75n
         8+WHp5yVIK+F2WhKruhqFrLpHw3bkM/Bio1rfZb/ytyuADnkGtlGyWtt5Ja44T1HMk
         eho8sO2JQmPWQ==
Message-ID: <cbdf14457647730569c9ac186965e98f67582ec0.camel@collabora.com>
Subject: Re: [PATCH v9 00/17] Move HEVC stateless controls out of staging
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Date:   Mon, 04 Jul 2022 15:40:17 -0400
In-Reply-To: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
References: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

Le vendredi 17 juin 2022 =C3=A0 10:35 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> This series aims to make HEVC uapi stable and usable for hardware
> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
> and 2 out of the tree drivers (rkvdec and RPI).

As of today, we have 2 userland implementation (GStreamer and FFMPEG) that =
we
have been testing with. We have this API working for Hantro G2 and Cedrus. =
There
is still some driver stability issues, but what matters for an uAPI is the
conformance and this seems to go quite well everywhere. We also have a WIP =
of
rkvdec (derived from LibreELEC fork) that should get to the mailing list an=
d is
based on this series. With all the review that already taken place this see=
ms
more then enough to conclude this API is ready. So for the entire series:

Acked-by: Nicolas Dufresne <nicolas.dufresne.com>

p.s. I didn't link anything due to lack of time, ping me if you need any of=
 the
referred items, test results, etc.

>=20
> version 9:
> - Reword some commit message
> - Use fls()
> - Remove useless padding at the end of hevc structures
> - Reword all _minus* field description
> - change CVS to codec video sequence
> - Fix various typo
> - Fix undefined label: v4l2-ctrl-flag-dynamic-array warning
> - fix the waring reported by 'scripts/kernel-doc -none
>   include/uapi/linux/v4l2-controls.h'
>=20
> This version has been tested with these branches:
> - GStreamer: https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/=
-/tree/HEVC_aligned_with_kernel_5.15
> - Linux: https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tr=
ee/HEVC_UAPI_V9
>=20
> With patches to decode 10-bits bitstream and produce P010 frames the Flus=
ter score=20
> which was 77/147 before, is now 141/147.
> The 10-bits series will comes after this because of it dependency to
> uAPI change. If you are curious you can find the WIP branch here:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/WIP=
_HEVC_UAPI_V9
>=20
> The 6 failing tests are:
> - PICSIZE_{A,B,C,D}_Bossen_1 where resolutions are to big for Hantro hard=
ware.
> - WPP_D_ericsson_MAIN_2 and WPP_D_ericsson_MAIN10_2 are visually ok but s=
ome=20
>   difference exist on 5 decoded frames. Some pixels values are no the sam=
e=20
>   the very end of few lines.
>=20
> version 8:
> - Same than v7 but rebased on media_stage/master
>=20
> version 7:
> - Apply Jernej patches for Cedrus about bit offset definition and
>   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS being a dynamic array control.
> - Based on media_tree/master
>=20
> version 6:
> - Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
>   in v4l2_ctrl_hevc_decode_params structure.
> - Change slice_pic_order_cnt type to s32 to match with PoC type.
> - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
> - Add a define for max slices count
> - Stop using Hantro dedicated control.
>=20
> version 5:
> - Change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val in
>   hevc_dpb_entry structure
> - Add defines for SEI pic_struct values (patch 4)
> - Fix numbers of bits computation in cedrus_h265_skip_bits() parameters
> - Fix num_short_term_ref_pic_sets and num_long_term_ref_pics_sps
>   documentation (patch 8)
> - Rebased on v5-18-rc1
>=20
> Version 4:
> - Add num_entry_point_offsets field in  struct v4l2_ctrl_hevc_slice_param=
s
> - Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
> - Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> - Fix space/tab issue in kernel-doc
> - Add patch to change data_bit_offset definition
> - Fix hantro-media SPDX license
> - put controls under stateless section in v4l2-ctrls-defs.c
>=20
> Benjamin Gaignard (14):
>   media: uapi: HEVC: Add missing fields in HEVC controls
>   media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>     prefix
>   media: uapi: HEVC: Change pic_order_cnt definition in
>     v4l2_hevc_dpb_entry
>   media: uapi: HEVC: Add SEI pic struct flags
>   media: uapi: HEVC: Add documentation to uAPI structure
>   media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>     dynamic array
>   media: uapi: Move parsed HEVC pixel format out of staging
>   media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
>   media: uapi: Move the HEVC stateless control type out of staging
>   media: controls: Log HEVC stateless control in .std_log
>   media: hantro: Stop using Hantro dedicated control
>   media: uapi: HEVC: fix padding in v4l2 control structures
>   media: uapi: Change data_bit_offset definition
>   media: uapi: move HEVC stateless controls out of staging
>=20
> Hans Verkuil (3):
>   videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>   v4l2-ctrls: add support for dynamically allocated arrays.
>   vivid: add dynamic array test control
>=20
>  .../media/v4l/ext-ctrls-codec-stateless.rst   | 897 ++++++++++++++++++
>  .../media/v4l/ext-ctrls-codec.rst             | 780 ---------------
>  .../media/v4l/pixfmt-compressed.rst           |   7 +-
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>  .../media/v4l/vidioc-queryctrl.rst            |   8 +
>  .../media/videodev2.h.rst.exceptions          |   6 +
>  .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>  drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 +-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     | 212 ++++-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  38 +-
>  drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>  drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>  drivers/staging/media/hantro/hantro_drv.c     |  62 +-
>  .../staging/media/hantro/hantro_g2_hevc_dec.c |  44 +-
>  drivers/staging/media/hantro/hantro_hevc.c    |  10 +-
>  drivers/staging/media/hantro/hantro_hw.h      |   4 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  26 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  |  23 +-
>  .../staging/media/sunxi/cedrus/cedrus_video.c |   1 -
>  include/media/hevc-ctrls.h                    | 250 -----
>  include/media/v4l2-ctrls.h                    |  48 +-
>  include/uapi/linux/v4l2-controls.h            | 459 +++++++++
>  include/uapi/linux/videodev2.h                |  13 +
>  24 files changed, 1826 insertions(+), 1226 deletions(-)
>  delete mode 100644 include/media/hevc-ctrls.h
>=20

