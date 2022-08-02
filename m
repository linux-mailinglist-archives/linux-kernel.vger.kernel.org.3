Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D5587E56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiHBOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHBOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634A1EEC9;
        Tue,  2 Aug 2022 07:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656AE614BA;
        Tue,  2 Aug 2022 14:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C248C433D6;
        Tue,  2 Aug 2022 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659451622;
        bh=XHXc2tuUWzuswCzORodOO0Zo5TMbSecJz6yLtAUCEeI=;
        h=Date:From:To:Cc:Subject:From;
        b=bB9/m6s256C0PvQipr1J3raLChKD/nMN0iKeUU5nRw7GwjmkrP/aSu8aEkrOn+dAf
         KGsL9Z2/MkEFeQrClXeqTdVM+FGFXS5cK4VSkYtFY97DTb5xJjHXOd60UXl95t+e1r
         3LpW4wlu2xRvNYiqQJrwBSEoRdmGnp2rTuMJHr7R3lLuwaba/5wHHEulPWScNsc2qO
         SzMqqgZcHcXO+G9WEdSarOTsegL3cbPzPmqUCDcWIKBGEN/Ugmvvo0U0S4/kSmE/+a
         KgzcxCwO6ojvr4+dErfTPgxHaLugPM7OGXOuQhrMs4rGgj0WsXXfzEzA0NpfCiaOl9
         gIpoQeYDpJ4pQ==
Date:   Tue, 2 Aug 2022 16:46:58 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.20-rc1] media updates
Message-ID: <20220802164658.4e533a24@coco.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.20-1

For:

- New driver for Semi AR0521 sensor;
- rkisp1 CSI code was split into a separate file;
- sun6i has gained support for the A31 MIPI CSI-2 controller;
- sun8i has gained support for the A83T MIPI CSI-2 controller;
- vimc driver got support for virtual lens;
- HEVC uAPI has gained its final form and got added to public headers;
- hantro and cedrus got updates on H-265 support;
- stkwebcam was promoted from staging;
- atomisp staging driver got cleanups on its hmm and kmap related logic;
- ov5640 gained support for more modes and got some rework;
- imx7-media-csi staging driver got several improvements related to mc API =
support;
- uvcvideo now handles better power line control;
- mediatec vcodec gained support for new hardware and got some codec update=
s;
- Lots of other bug fixes, improvements and cleanups.

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.20-1

for you to fetch changes up to 485ade76c95ac5ccaa52fee9d712471c9211b989:

  media: hantro: Remove dedicated control documentation (2022-07-27 22:38:4=
7 +0200)

----------------------------------------------------------------
media updates for v5.20-rc1

----------------------------------------------------------------
Ajye Huang (1):
      media: platform: cros-ec: Add kinox to the match table

Akira Yokosawa (1):
      media: docs: Remove extraneous \endgroup from P010 table

Alain Volmat (1):
      media: st-mipid02: add support for YVYU and VYUY formats

Andy Shevchenko (1):
      media: c8sectpfe: Clean up handling of *_buffer_aligned

AngeloGioacchino Del Regno (1):
      media: platform: mtk-mdp: Fix mdp_ipi_comm structure alignment

Ard Biesheuvel (1):
      media: atomisp_gmin_platform: stop abusing efivar API

Arnd Bergmann (1):
      media: sta2x11: remove VIRT_TO_BUS dependency

Benjamin Gaignard (17):
      media: Add P010 video format
      media: hantro: Be more accurate on pixel formats step_width constrain=
ts
      media: Hantro: Correct G2 init qp field
      media: uapi: HEVC: Add missing fields in HEVC controls
      media: uapi: HEVC: Rename HEVC stateless controls with STATELESS pref=
ix
      media: uapi: HEVC: Change pic_order_cnt definition in v4l2_hevc_dpb_e=
ntry
      media: uapi: HEVC: Add SEI pic struct flags
      media: uapi: HEVC: Add documentation to uAPI structure
      media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a d=
ynamic array
      media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
      media: uapi: Move parsed HEVC pixel format out of staging
      media: uapi: Move the HEVC stateless control type out of staging
      media: controls: Log HEVC stateless control in .std_log
      media: hantro: Stop using Hantro dedicated control
      media: uapi: HEVC: fix padding in v4l2 control structures
      media: uapi: Change data_bit_offset definition
      media: uapi: move HEVC stateless controls out of staging

Benjamin Marty (1):
      media: i2c: adv7180: fix reserved bit in Video Selection 2

Chen-Yu Tsai (10):
      media: mediatek: vcodec: Skip SOURCE_CHANGE & EOS events for stateless
      media: mediatek: vcodec: decoder: Const-ify stepwise_fhd
      media: mediatek: vcodec: decoder: Fix 4K frame size enumeration
      media: mediatek: vcodec: decoder: Skip alignment for default resoluti=
on
      media: mediatek: vcodec: decoder: Fix resolution clamping in TRY_FMT
      media: mediatek: vcodec: decoder: Drop max_{width,height} from mtk_vc=
odec_ctx
      media: mediatek: vcodec: decoder: Embed framesize inside mtk_video_fmt
      media: mediatek: vcodec: Initialize decoder parameters for each insta=
nce
      media: mediatek: vcodec: Make decoder capability fields fit requireme=
nts
      media: mediatek: vcodec: Make encoder capability fields fit requireme=
nts

Chengguang Xu (1):
      media: platform: fix missing/incorrect resource cleanup in error case

Christophe JAILLET (4):
      media: rcar_drif: Remove useless license text when SPDX-License-Ident=
ifier is already used
      media: em28xx: Remove useless license text when SPDX-License-Identifi=
er is already used
      media: ddbridge: Remove useless license text when SPDX-License-Identi=
fier is already used
      media: tw686x: Fix an error handling path in tw686x_probe()

Colin Ian King (2):
      media: platform: exynos-gsc: remove redundant initializations of f_ch=
k_len and f_chk_addr
      media: atomisp: clean up for-loop, remove redundant assignment to var=
iable i

Daniel Oakley (3):
      media: vimc: expand the names of vimc entity types
      media: vimc: enumerate data link entities for clarity
      media: vimc: use data link entities enum to index the ent_config array

Daniel Scally (2):
      media: entity: Add iterator for entity data links
      media: entity: Use dedicated data link iterator

Dikshita Agarwal (1):
      media: venus: Add support for SSR trigger using fault injection

Dongliang Mu (1):
      media: pvrusb2: fix memory leak in pvr_probe

Eugen Hristev (3):
      media: atmel: atmel-sama7g5-isc: fix warning in configs without OF
      media: atmel: atmel-isc-base: move cropping settings outside start_dma
      media: atmel: atmel-isc-base: allow wb ctrls to be changed when isc i=
s not configured

Ezequiel Garcia (10):
      media: hantro: Fix RK3399 H.264 format advertising
      media: Add P010 tiled format
      media: videobuf2: Introduce vb2_find_buffer()
      media: mediatek: vcodec: Use vb2_find_buffer
      media: tegra-vde: Use vb2_find_buffer
      media: vicodec: Use vb2_find_buffer
      media: hantro: Use vb2_find_buffer
      media: rkvdec: Use vb2_find_buffer
      hantro: Remove incorrect HEVC SPS validation
      media: hantro: Remove dedicated control documentation

Fabio M. De Francesco (3):
      media: staging: media: atomisp: Convert kmap() to kmap_local_page()
      media: staging: media: atomisp: Use kmap_local_page() in hmm_set()
      media: staging: media: atomisp: Use kmap_local_page() in hmm_store()

Guo Zhengkui (2):
      media: platform: samsung: s5p-jpeg: replace ternary operator with max=
()
      media: mediatek: vcodec: fix minmax.cocci warning

Hans Verkuil (14):
      media: adv7604: try all infoframe types
      media: cec-adap.c: log when claiming LA fails unexpectedly
      media: v4l2-tpg: add HDMI Video Guard Band test pattern
      media: vivid: add HDMI Video Guard Band control
      media: stkwebcam: deprecate driver, move to staging
      media: vivid.rst: document HDMI Video Guard Band control
      media: ar0521: fix Kconfig: VIDEO_V4L2 -> VIDEO_DEV
      media: venus: venus_helper_get_bufreq(): req is never NULL
      media: videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
      media: v4l2-ctrls: add support for dynamically allocated arrays.
      media: vivid: add dynamic array test control
      media: vimc: wrong pointer is used with PTR_ERR
      media: videodev2.h.rst.exceptions: add missing exceptions
      media: sunxi: sun6i_mipi_csi2.c/sun8i_a83t_mipi_csi2.c: clarify error=
 handling

Hans de Goede (43):
      media: atomisp: remove the unused RAW_BUF_STRIDE macro
      media: atomisp: remove unused ia_css_frame_allocate_contiguous*() fun=
ctions
      media: atomisp: drop contiguous argument from ia_css_frame_allocate_w=
ith_buffer_size()
      media: atomisp: drop contiguous argument from frame_allocate_with_dat=
a()
      media: atomisp: drop contiguous argument from frame_create()
      media: atomisp: drop IA_CSS_FRAME_FORMAT_MIPI support from ia_css_fra=
me_init_planes()
      media: atomisp: drop contiguous flag from struct ia_css_frame
      media: atomisp: drop ATOMISP_MAP_FLAG_CONTIGUOUS
      media: atomisp: remove hmm_pool_[un]register()
      media: atomisp: remove dynamic and reserved pool code
      media: atomisp: remove hmm pool code
      media: atomisp: remove hmm_mem_stats
      media: atomisp: remove pool related kernel cmdline options
      media: atomisp: remove unused attribute argument from ia_css_frame_ma=
p()
      media: atomisp: drop hmm_page_type
      media: atomisp: removed unused hmm_bo_get_page_info() function
      media: atomisp: remove bogus comment above hmm_bo_allocated() prototy=
pe
      media: atomisp: remove private acceleration ioctls
      media: atomisp: remove atomisp_acc.c
      media: atomisp: remove unused atomisp_*css_* functions
      media: atomisp: asc.acc.pipeline is always NULL
      media: atomisp: remove no longer used atomisp_css_acc_done() function
      media: atomisp: remove atomisp_is_acc_enabled()
      media: atomisp: drop unused ATOMISP_ACC_FW_LOAD_* defines
      media: atomisp: drop ATOMISP_MAP_FLAG_CLEARED
      media: atomisp: drop unused ATOMISP_MAP_FLAG_* flags
      media: atomisp: remove unused hmm address translation functions
      media: atomisp: add hmm_create_from_userdata() helper
      media: atomisp: Simplify hmm_alloc() calls
      media: atomisp: drop highmem var/arg from the hmm code
      media: atomisp: drop HMM_BO_SHARE type
      media: atomisp: remove hmm_page_object
      media: atomisp: fix __get_frame_info() error handling
      media: atomisp: add error checking to atomisp_create_pipes_stream()
      media: atomisp: add error logging to atomisp_destroy_pipes_stream_for=
ce()
      media: atomisp: use atomisp_create_pipes_stream() in more places
      media: atomisp: use atomisp_css_update_stream() in more places
      media: atomisp: use atomisp_destroy_pipes_stream_force() in more plac=
es
      media: atomisp: remove force argument from __destroy_[stream[s]|pipe[=
s]]()
      media: atomisp: Add a notes.txt file
      media: atomisp: revert "don't pass a pointer to a local variable"
      media: atomisp: fix uninitialized stack mem usage in ia_css_rmgr_acq_=
vbuf()
      media: atomisp: fix -Wdangling-pointer warning

Haowen Bai (2):
      media: mediatek: vcodec: Use kmemdup rather than kmalloc/memcpy
      media: atomisp-mt9m114: Fix pointer dereferenced before checking

Hirokazu Honda (1):
      media: mediatek: vcodec: Report supported bitrate modes

Hugues Fruchet (4):
      media: st-mipid02: add support of pixel clock polarity
      media: st-mipid02: expose 1X16 serial pixel format
      media: stm32-dcmi: add support of 1X16 serial pixel formats variant
      media: ov5640: Adjust vblank with s_frame_interval

Ian Cowan (4):
      media: staging: media: zoran: add logging macros
      media: staging: media: zoran: setup videocodec header for debugging m=
acros
      media: staging: media: zoran: replace all pr_err with zrdev_err as ap=
propriate
      media: staging: media: zoran: replace dprintk with new debugging macr=
os

Jacopo Mondi (27):
      media: ov5640: Add pixel rate to modes
      media: ov5604: Re-arrange modes definition
      media: ov5640: Add ov5640_is_csi2() function
      media: ov5640: Associate bpp with formats
      media: ov5640: Add LINK_FREQ control
      media: ov5640: Update pixel_rate and link_freq
      media: ov5640: Rework CSI-2 clock tree
      media: ov5640: Rework timings programming
      media: ov5640: Fix 720x480 in RGB888 mode
      media: ov5640: Split DVP and CSI-2 timings
      media: ov5640: Provide timings accessor
      media: ov5640: Re-sort per-mode register tables
      media: ov5640: Remove duplicated mode settings
      media: ov5640: Remove ov5640_mode_init_data
      media: ov5640: Add HBLANK control
      media: ov5640: Add VBLANK control
      media: ov5640: Remove frame rate check from find_mode()
      media: ov5640: Change CSI-2 timings to comply with FPS
      media: ov5640: Implement init_cfg
      media: ov5640: Implement get_selection
      media: ov5640: Register device properties
      media: ov5640: Add RGB565_1X16 format
      media: ov5640: Add BGR888 format
      media: ov5640: Restrict sizes to mbus code
      media: ov5640: Adjust format to bpp in s_fmt
      media: ov5640: Split DVP and CSI-2 formats
      media: ov5640: Move format mux config in format

Jernej Skrabec (14):
      media: hantro: Support format filtering by depth
      media: hantro: postproc: Fix buffer size calculation
      media: hantro: postproc: Fix legacy regs configuration
      media: hantro: postproc: Properly calculate chroma offset
      media: hantro: Store VP9 bit depth in context
      media: hantro: sunxi: Enable 10-bit decoding
      media: cedrus: h265: Fix flag name
      media: cedrus: h265: Fix logic for not low delay flag
      media: cedrus: Improve error messages for controls
      media: cedrus: Add error handling for failed setup
      media: cedrus: h265: Add a couple of error checks
      media: cedrus: Add helper for determining number of elements
      media: cedrus: h265: Implement support for tiles
      media: cedrus: hevc: Add check for invalid timestamp

Jian Zhang (1):
      media: driver/nxp/imx-jpeg: fix a unexpected return value problem

Jiang Jian (9):
      media: usb: gspca: aligned '*' each line
      media: saa7164: Remove duplicate 'on' in two places.
      media: av7110: Remove duplicate 'with' in two places.
      media: cx18: Fix typo in comments
      media: gspca: drop unexpected word 'is' in the comments
      media: ti: drop unexpected word 'a' in comments
      media: pvrusb2: drop unexpected word 'a' in comments
      media: atomisp: Fix typo in comments
      media: xilinx: Drop unexpected word 'with' in comments

Jorge Maidana (2):
      media: cx88: Fix PAL-Nc standard
      media: usbtv: Add PAL-Nc standard

Julia Lawall (4):
      media: platform: exynos-gsc: fix typo in comment
      media: mediatek: vcodec: fix typo in comment
      media: platform: exynos4-is: fix typos in comments
      media: staging: atomisp: fix typo in comment

Justin Green (2):
      media: mediatek/vcodec: Enable incoherent buffer allocation
      media: mediatek: vcodec: return EINVAL if plane is too small

Karthik Alapati (1):
      media: staging: media/atomisp: use max() impl

Kees Cook (1):
      media: amphion: Replace zero-length array with flexible-array member

Krzysztof Ha=C5=82asa (2):
      media: dt-bindings: Add bindings for On Semi AR0521 camera sensor
      media: On Semi AR0521 sensor driver

Krzysztof Kozlowski (2):
      media: dt-bindings: qcom,sdm660-camss: document interconnects
      media: dt-bindings: media: samsung,s5pv210-jpeg: convert to dtschema

Laurent Pinchart (121):
      media: rkisp1: capture: Initialize entity before video device
      media: rkisp1: capture: Fix and simplify (un)registration
      media: rkisp1: isp: Fix and simplify (un)registration
      media: rkisp1: resizer: Fix and simplify (un)registration
      media: rkisp1: params: Fix and simplify (un)registration
      media: rkisp1: stats: Simplify (un)registration
      media: rkisp1: Simplify rkisp1_entities_register() error path
      media: rkisp1: regs: Don't use BIT() macro for multi-bit register fie=
lds
      media: rkisp1: regs: Rename CCL, ICCL and IRCL registers with VI_ pre=
fix
      media: rkisp1: Swap value and address arguments to rkisp1_write()
      media: rkisp1: resizer: Simplify register access
      media: rkisp1: Move debugfs code to a separate file
      media: rkisp1: Compile debugfs support conditionally
      media: rkisp1: debug: Collect input status by sampling ISP_FLAGS_SHD
      media: rkisp1: debug: Add debugfs files to dump core and ISP registers
      media: rkisp1: debug: Move resizer register dump to debugfs
      media: rkisp1: debug: Consolidate reg dumps for shadow registers
      media: rkisp1: debug: Update max register name length
      media: rkisp1: Align macro definitions
      media: rkisp1: Drop parentheses and fix indentation in rkisp1_probe()
      media: renesas: rcar_drif: Drop of_match_ptr()
      media: staging: media: imx: imx7-media-csi: Initialize locks early on
      media: staging: media: imx: imx7-media-csi: Split imx_media_dev from =
probe()
      media: staging: media: imx: imx7-media-csi: Import notifier helpers
      media: staging: media: imx: imx7-media-csi: Drop duplicate link creat=
ion
      media: staging: media: imx: imx7-media-csi: Drop the imx_media notifi=
er
      media: staging: media: imx: imx7-media-csi: Don't populate vdev lists
      media: staging: media: imx: imx7-media-csi: Drop unused frame_interval
      media: staging: media: imx: imx7-media-csi: Move format init to probe=
 time
      media: staging: media: imx: imx7-media-csi: Import video device helpe=
rs
      media: staging: media: imx: imx7-media-csi: Drop legacy video device =
support
      media: staging: media: imx: imx7-media-csi: Drop unused controls supp=
ort
      media: staging: media: imx: imx7-media-csi: Reorganize imx7_csi struc=
ture
      media: staging: media: imx: imx7-media-csi: Fold capture_priv into im=
x7_csi
      media: staging: media: imx: imx7-media-csi: Ensure consistent functio=
n prefix
      media: staging: media: imx: imx7-media-csi: Don't set subdev group id
      media: staging: media: imx: imx7-media-csi: Import imx_media_dev_init=
() helper
      media: staging: media: imx: imx7-media-csi: Embed imx_media_dev in im=
x7_csi
      media: staging: media: imx: imx7-media-csi: Drop imx_media_add_video_=
device call
      media: staging: media: imx: imx7-media-csi: Don't initialize unused f=
ields
      media: staging: media: imx: imx7-media-csi: Inline imx_media_pipeline=
_pad()
      media: staging: media: imx: imx7-media-csi: Import imx_media_pipeline=
_set_stream()
      media: staging: media: imx: imx7-media-csi: Avoid unnecessary casts
      media: staging: media: imx: imx7-media-csi: Inline pipeline start/stop
      media: staging: media: imx: imx7-media-csi: Fold imx_media_dev into i=
mx7_csi
      media: staging: media: imx: imx7-media-csi: Decouple from imx_media_b=
uffer
      media: staging: media: imx: imx7-media-csi: Fold imx_media_video_dev =
into imx7_csi
      media: staging: media: imx: imx7-media-csi: Store imx7_csi in drv data
      media: staging: media: imx: imx7-media-csi: Decouple from imx_media_d=
ma_buf
      media: staging: media: imx: imx7-media-csi: Decouple from shared macr=
os
      media: staging: media: imx: imx7-media-csi: Drop error message on all=
oc failure
      media: staging: media: imx: imx7-media-csi: Import format helpers
      media: staging: media: imx: imx7-media-csi: Replace ipu_color_space w=
ith bool yuv field
      media: staging: media: imx: imx7-media-csi: Drop IC support from imx7=
_csi_try_colorimetry()
      media: staging: media: imx: imx7-media-csi: Drop IPU-only formats
      media: staging: media: imx: imx7-media-csi: Drop unsupported YUV and =
RGB formats
      media: staging: media: imx: imx7-media-csi: Make default formats cons=
istent
      media: staging: media: imx: imx7-media-csi: Define macro for default =
mbus code
      media: staging: media: imx: imx7-media-csi: Simplify default mbus cod=
e in try_fmt
      media: staging: media: imx: imx7-media-csi: Drop YUV/RGB/BAYER format=
 selectors
      media: staging: media: imx: imx7-media-csi: Drop unneeded imx7_csi_pi=
xfmt fields
      media: staging: media: imx: imx7-media-csi: Inline imx7_csi_init_mbus=
_fmt()
      media: staging: media: imx: imx7-media-csi: Simplify default format i=
n try_fmt
      media: staging: media: imx: imx7-media-csi: Fix list of supported for=
mats
      media: staging: media: imx: imx7-media-csi: Add V4L2_PIX_FMT_Y14 supp=
ort
      media: staging: media: imx: imx7-media-csi: Drop unneeded pixel forma=
t validation
      media: staging: media: imx: imx7-media-csi: Inline imx7_csi_enum_pixe=
l_formats()
      media: staging: media: imx: imx7-media-csi: Drop V4L2 events support
      media: staging: media: imx: imx7-media-csi: Drop usage of shared help=
ers
      media: v4l: Add packed YUV 4:4:4 YUVA and YUVX pixel formats
      media: v4l2-tpg: Add support for the new YUVA and YUVX formats
      media: vivid: Add support for the new YUVA and YUVX formats
      media: v4l2: Make colorspace validity checks more future-proof
      media: v4l2: Sanitize colorspace values in the framework
      media: Replace dependency on VIDEO_V4L2_SUBDEV_API with select
      media: imx: imx-mipi-csis: Set the subdev fwnode for endpoint matching
      media: imx: imx-mipi-csis: Add version register
      media: imx: imx-mipi-csis: Implement the .get_frame_desc() operation
      media: dt-bindings: media: nxp,imx-mipi-csi2: i.MX8MP support
      media: uvcvideo: Fix comment blocks style
      media: uvcvideo: Replace broken URL
      media: v4l2-async: Add notifier operation to destroy asd instances
      media: mc-entity: Rename media_entity_remote_pad() to media_pad_remot=
e_pad_first()
      media: mc-entity: Add a new helper function to get a remote pad
      media: mc-entity: Add a new helper function to get a remote pad for a=
 pad
      media: rkisp1: Enable compilation on ARCH_MXC
      media: rkisp1: Disable runtime PM in probe error path
      media: rkisp1: Read the ID register at probe time instead of streamon
      media: rkisp1: Rename rkisp1_match_data to rkisp1_info
      media: rkisp1: Access ISP version from info pointer
      media: rkisp1: cap: Print debug message on failed link validation
      media: rkisp1: Move sensor .s_stream() call to ISP
      media: rkisp1: Reject sensors without pixel rate control at bound time
      media: rkisp1: Create link from sensor to ISP at notifier bound time
      media: rkisp1: Create internal links at probe time
      media: rkisp1: Rename rkisp1_subdev_notifier() to rkisp1_subdev_notif=
ier_register()
      media: rkisp1: Fix sensor source pad retrieval at bound time
      media: rkisp1: isp: Start CSI-2 receiver before ISP
      media: rkisp1: csi: Handle CSI-2 RX configuration fully in rkisp1-csi=
.c
      media: rkisp1: csi: Rename CSI functions with a common rkisp1_csi pre=
fix
      media: rkisp1: csi: Move start delay to rkisp1_csi_start()
      media: rkisp1: csi: Pass sensor pointer to rkisp1_csi_config()
      media: rkisp1: csi: Constify argument to rkisp1_csi_start()
      media: rkisp1: isp: Don't initialize ret to 0 in rkisp1_isp_s_stream()
      media: rkisp1: isp: Pass mbus type and flags to rkisp1_config_cif()
      media: rkisp1: isp: Rename rkisp1_device.active_sensor to source
      media: rkisp1: isp: Add container_of wrapper to cast subdev to rkisp1=
_isp
      media: rkisp1: isp: Add rkisp1_device backpointer to rkisp1_isp
      media: rkisp1: isp: Pass rkisp1_isp pointer to internal ISP functions
      media: rkisp1: isp: Move input configuration to rkisp1_config_isp()
      media: rkisp1: isp: Merge ISP_ACQ_PROP configuration in single variab=
le
      media: rkisp1: isp: Initialize some variables at declaration time
      media: rkisp1: isp: Fix whitespace issues
      media: rkisp1: isp: Constify various local variables
      media: rkisp1: isp: Rename rkisp1_get_remote_source()
      media: rkisp1: isp: Disallow multiple active sources
      media: rkisp1: csi: Plumb the CSI RX subdev
      media: rkisp1: Add infrastructure to support ISP features
      media: rkisp1: Make the internal CSI-2 receiver optional
      media: Documentation: mc-core: Fix typo
      media: uvcvideo: Fix invalid pointer in uvc_ctrl_init_ctrl()

Li zeming (1):
      media: staging/media/atomisp/pci/atomisp: Fix typo in string

Linus Walleij (1):
      media: platform: omap: Pass a pointer to virt_to_page()

Lukas Bulwahn (1):
      media: MAINTAINERS: add include/dt-bindings/media to MEDIA INPUT INFR=
ASTRUCTURE

Marek Vasut (8):
      media: stm32: dcmi: Fill in remaining Bayer formats
      media: stm32: dcmi: Drop always NULL sd_state from dcmi_pipeline_s_fm=
t()
      media: v4l2-ctrls: Fix missing newline in examples
      media: docs: Fix VIVIOC typo
      media: dt-bindings: mt9p031: Add MT9P006 compatible string
      media: mt9p031: Add MT9P006 compatible
      media: mt9p031: Move open subdev op init code into init_cfg
      media: mt9p031: Implement crop bounds get selection

Marko M=C3=A4kel=C3=A4 (1):
      media: lirc: ensure lirc device receives repeats

Miaoqian Lin (1):
      media: tw686x: Fix memory leak in tw686x_video_init

Michael Grzeschik (1):
      media: uvcvideo: Remove unneeded goto

Ming Qian (16):
      media: imx-jpeg: Don't fill the description field in struct v4l2_fmtd=
esc
      media: amphion: support for reloading module
      media: imx-jpeg: Encoder support to set jpeg quality
      media: amphion: vdec check format in enum_fmt
      media: amphion: return error if format is unsupported by vpu
      media: imx-jpeg: Correct some definition according specification
      media: imx-jpeg: Leave a blank space before the configuration data
      media: imx-jpeg: Align upwards buffer size
      media: imx-jpeg: Implement drain using v4l2-mem2mem helpers
      media: imx-jpeg: Disable slot interrupt when frame done
      media: amphion: output firmware error message
      media: v4l2-mem2mem: prevent pollerr when last_buffer_dequeued is set
      media: amphion: release core lock before reset vpu core
      media: amphion: defer setting last_buffer_dequeued until resolution c=
hanges are processed
      media: amphion: sync buffer status with firmware during abort
      media: amphion: only insert the first sequence startcode for vc1l for=
mat

Nicolas Frattaroli (2):
      media: dt-binding: media: Add rk3568-vepu binding
      media: hantro: Add support for RK356x encoder

Niels Dossche (1):
      media: hdpvr: fix error value returns in hdpvr_read

Niklas S=C3=B6derlund (1):
      media: rcar-vin: Fix channel routing for Ebisu

Oliver Neukum (13):
      media: igorplugusb: respect DMA coherency
      media: igorplugusb: prevent use after free in probe error
      media: igorplugusb: break cyclical race on disconnect
      media: igorplugusb: remove superfluous usb_unlink_urb()
      media: iguanair: no superfluous usb_unlink_urb()
      media: imon_raw: respect DMA coherency
      media: redrat3: no unnecessary GFP_ATOMIC
      media: streamzap: avoid unnecessary GFP_ATOMIC
      media: xbox_remote: xbox_remote_initialize() cannot fail
      media: ttusbir: NOIO during resume
      media: ttusbir: avoid unnecessary usb_unlink_urb()
      media: airspy: respect the DMA coherency rules
      media: ati-remote: remove private err() macro

Paul Elder (11):
      media: rkisp1: capture: Bypass the main device for handling querycap
      media: staging: media: imx: imx7-media-csi: Move misc init out of pro=
be()
      media: staging: media: imx: imx7-media-csi: Remove imx_media_of_add_c=
si
      media: rkisp1: Save info pointer in rkisp1_device
      media: rkisp1: Make rkisp1_isp_mbus_info common
      media: rkisp1: Split CSI handling to separate file
      media: rkisp1: csi: Implement a V4L2 subdev for the CSI receiver
      media: rkisp1: Use fwnode_graph_for_each_endpoint
      media: dt-bindings: media: rkisp1: Add port for parallel interface
      media: rkisp1: Support the ISP parallel input
      media: rkisp1: debug: Add dump file in debugfs for MI main path regis=
ters

Paul Kocialkowski (6):
      media: dt-bindings: media: sun6i-a31-csi: Add MIPI CSI-2 input port
      media: dt-bindings: media: Add Allwinner A31 MIPI CSI-2 bindings docu=
mentation
      media: sunxi: Add support for the A31 MIPI CSI-2 controller
      media: MAINTAINERS: Add entry for the Allwinner A31 MIPI CSI-2 bridge=
 driver
      media: dt-bindings: media: Add Allwinner A83T MIPI CSI-2 bindings doc=
umentation
      media: sunxi: Add support for the A83T MIPI CSI-2 controller

Randy Dunlap (1):
      media: isl7998x: select V4L2_FWNODE to fix build error

Ricardo Ribalda (7):
      media: uvcvideo: Add missing value for power_line_frequency
      media: uvcvideo: Add support for per-device control mapping overrides
      media: uvcvideo: Limit power line control for Quanta UVC Webcam
      media: uvcvideo: Limit power line control for Chicony Easycamera
      media: uvcvideo: Limit power line control for Chicony Easycamera
      media: uvcvideo: Limit power line control for Quanta cameras
      media: uvcvideo: Limit power line control for Acer EasyCamera

Sakari Ailus (3):
      media: ov7251: Fix multiple problems in s_stream callback
      media: v4l: async: Also match secondary fwnode endpoints
      media: sunxi: Depend on GENERIC_PHY_MIPI_DPHY

Scott Chao (1):
      media: platform: cros-ec: Add moli to the match table

Sebastian Fricke (1):
      media: Fix incorrect P010 chroma order description

Tom Rix (1):
      media: staging: atomisp: rework reading the id and revision values

Tomi Valkeinen (2):
      media: subdev: Add v4l2_subdev_call_state_try() macro
      media: stm32: dcmi: Fix subdev op call with uninitialized state

Tommaso Merciai (6):
      media: ov5693: count num_supplies using array_size
      media: ov5693: add dvdd into ov5693_supply_names array
      media: ov5693: rename clk into xvclk
      media: ov5693: add support for acpi clock-frequency prop
      media: dt-bindings: ov5693: document YAML binding
      media: ov5693: add ov5693_of_match, dts support

Vikash Garodia (2):
      media: venus: hfi_platform: Correct supported codecs for sc7280
      media: venus: set ubwc configuration on specific video hardware

Vladimir Zapolskiy (3):
      media: camss: Allocate power domain resources dynamically
      media: camss: Allocate camss struct as a managed device resource
      media: camss: Move and unexport functions specific to ISPIF

Wan Jiabing (2):
      media: st-delta: Remove unneeded NULL check in delta-v4l2
      media: c8sectpfe: Remove unneeded NULL check before clk_disable_unpre=
pare

Xiaomeng Tong (1):
      media: [PATCH] pci: atomisp_cmd: fix three missing checks on list ite=
rator

Yang Li (2):
      media: atmel: atmel-isc-base: remove unneeded semicolon
      media: mediatek: vcodec: remove unneeded semicolon

Yang Yingliang (4):
      media: camss: csid: fix wrong size passed to devm_kmalloc_array()
      media: davinci: vpif: add missing of_node_put() in vpif_probe()
      media: igorplugusb: use correct size pass to igorplugusb_probe()
      media: ov7251: add missing disable functions on error in ov7251_set_p=
ower_on()

Yunfei Dong (15):
      media: mediatek: vcodec: add vp9 decoder driver for mt8186
      media: dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings=
 for lat soc
      media: mediatek: vcodec: Add to support lat soc hardware
      media: dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings=
 for mt8195
      media: mediatek: vcodec: Adds compatible for mt8195
      media: mediatek: vcodec: Different codec using different capture form=
at
      media: mediatek: vcodec: prevent kernel crash when scp ipi timeout
      media: mediatek: vcodec: Add to support H264 inner racing mode
      media: mediatek: vcodec: Fix decoder v4l2 bus_info not correctly
      media: mediatek: vcodec: Change decoder v4l2 capability value
      media: mediatek: vcodec: Fix encoder v4l2 bus_info not correctly
      media: mediatek: vcodec: Change encoder v4l2 capability value
      media: mediatek: vcodec: Initialize decoder parameters after getting =
dec_capability
      media: MAINTAINERS: add Yunfei Dong as mediatek vcodec driver maintai=
ner
      media: mediatek: vcodec: Fix non subdev architecture open power fail

Yunke Cao (2):
      media: vimc: add ancillary lens
      media: vimc: documentation for lens

Zhang Zekun (1):
      media: rkvdec:Remove redundant memset

Zheyu Ma (3):
      media: TDA1997x: Fix the error handling in tda1997x_probe()
      media: tw5864: Convert to use managed functions pcim* and devm*
      media: tw686x: Register the irq at the end of probe

Ziyang Xuan (1):
      media: amphion: delete unnecessary NULL check

keliu (1):
      media: rc: Directly use ida_free()

kyrie wu (2):
      media: media: jpegenc: add mediatek,mt8186-jpgenc compatible
      media: media: jpegenc: set bit mask for jpegenc

 Documentation/admin-guide/media/vimc.dot           |    4 +
 Documentation/admin-guide/media/vimc.rst           |   19 +
 Documentation/admin-guide/media/vivid.rst          |   14 +
 .../bindings/media/allwinner,sun6i-a31-csi.yaml    |   58 +-
 .../media/allwinner,sun6i-a31-mipi-csi2.yaml       |  137 ++
 .../media/allwinner,sun8i-a83t-mipi-csi2.yaml      |  125 ++
 .../bindings/media/exynos-jpeg-codec.txt           |   16 -
 .../bindings/media/i2c/aptina,mt9p031.yaml         |    1 +
 .../devicetree/bindings/media/i2c/onnn,ar0521.yaml |  112 ++
 .../devicetree/bindings/media/i2c/ovti,ov5693.yaml |  124 ++
 .../media/mediatek,vcodec-subdev-decoder.yaml      |   52 +-
 .../bindings/media/mediatek-jpeg-encoder.yaml      |    6 +
 .../bindings/media/nxp,imx-mipi-csi2.yaml          |   11 +-
 .../bindings/media/qcom,sdm660-camss.yaml          |    7 +
 .../bindings/media/rockchip,rk3568-vepu.yaml       |   69 +
 .../devicetree/bindings/media/rockchip-isp1.yaml   |   23 +-
 .../bindings/media/samsung,s5pv210-jpeg.yaml       |  123 ++
 Documentation/driver-api/media/mc-core.rst         |    5 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |    6 +
 .../userspace-api/media/drivers/hantro.rst         |   19 -
 .../userspace-api/media/drivers/index.rst          |    1 -
 Documentation/userspace-api/media/v4l/control.rst  |    4 +-
 .../media/v4l/ext-ctrls-codec-stateless.rst        |  902 +++++++++++
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |  780 ---------
 Documentation/userspace-api/media/v4l/mmap.rst     |    2 +-
 .../userspace-api/media/v4l/pixfmt-compressed.rst  |    7 +-
 .../userspace-api/media/v4l/pixfmt-packed-yuv.rst  |   20 +
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |   63 +
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |   20 +
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |    8 +
 .../userspace-api/media/videodev2.h.rst.exceptions |    9 +
 MAINTAINERS                                        |   20 +
 drivers/media/cec/core/cec-adap.c                  |    5 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    4 +
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   44 +
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   12 +
 drivers/media/i2c/Kconfig                          |   18 +-
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/adv7180.c                        |    5 +-
 drivers/media/i2c/adv748x/adv748x.h                |    2 +-
 drivers/media/i2c/adv7604.c                        |    5 +-
 drivers/media/i2c/ar0521.c                         | 1061 +++++++++++++
 drivers/media/i2c/mt9p031.c                        |   93 +-
 drivers/media/i2c/ov5640.c                         | 1650 ++++++++++++++--=
----
 drivers/media/i2c/ov5693.c                         |   57 +-
 drivers/media/i2c/ov7251.c                         |    7 +-
 drivers/media/i2c/st-mipid02.c                     |   30 +-
 drivers/media/i2c/tda1997x.c                       |    1 +
 drivers/media/i2c/tvp5150.c                        |    2 +-
 drivers/media/mc/mc-entity.c                       |   96 +-
 drivers/media/pci/cx18/cx18-av-core.c              |    2 +-
 drivers/media/pci/cx88/cx88-core.c                 |   22 +-
 drivers/media/pci/ddbridge/ddbridge-ci.c           |    9 -
 drivers/media/pci/ddbridge/ddbridge-ci.h           |    9 -
 drivers/media/pci/ddbridge/ddbridge-core.c         |    9 -
 drivers/media/pci/ddbridge/ddbridge-hw.c           |    9 -
 drivers/media/pci/ddbridge/ddbridge-hw.h           |   11 +-
 drivers/media/pci/ddbridge/ddbridge-i2c.c          |    9 -
 drivers/media/pci/ddbridge/ddbridge-i2c.h          |    9 -
 drivers/media/pci/ddbridge/ddbridge-io.h           |    9 -
 drivers/media/pci/ddbridge/ddbridge-main.c         |    9 -
 drivers/media/pci/ddbridge/ddbridge-max.c          |    9 -
 drivers/media/pci/ddbridge/ddbridge-max.h          |   11 +-
 drivers/media/pci/ddbridge/ddbridge-mci.c          |    9 -
 drivers/media/pci/ddbridge/ddbridge-mci.h          |    9 -
 drivers/media/pci/ddbridge/ddbridge-regs.h         |    9 -
 drivers/media/pci/ddbridge/ddbridge-sx8.c          |    9 -
 drivers/media/pci/ddbridge/ddbridge.h              |   11 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |    2 +-
 drivers/media/pci/saa7164/saa7164-api.c            |    2 +-
 drivers/media/pci/sta2x11/Kconfig                  |    2 +-
 drivers/media/pci/tw5864/tw5864-core.c             |   30 +-
 drivers/media/pci/tw686x/tw686x-core.c             |   21 +-
 drivers/media/pci/tw686x/tw686x-video.c            |    4 +-
 drivers/media/platform/amphion/vdec.c              |   50 +-
 drivers/media/platform/amphion/venc.c              |    3 +-
 drivers/media/platform/amphion/vpu.h               |    1 +
 drivers/media/platform/amphion/vpu_cmds.c          |    3 +-
 drivers/media/platform/amphion/vpu_core.c          |   18 +-
 drivers/media/platform/amphion/vpu_dbg.c           |    2 +-
 drivers/media/platform/amphion/vpu_malone.c        |   20 +
 drivers/media/platform/amphion/vpu_malone.h        |    1 +
 drivers/media/platform/amphion/vpu_msgs.c          |    7 +-
 drivers/media/platform/amphion/vpu_rpc.c           |    2 +-
 drivers/media/platform/amphion/vpu_rpc.h           |    7 +-
 drivers/media/platform/amphion/vpu_v4l2.c          |    6 +-
 drivers/media/platform/atmel/Kconfig               |    4 +-
 drivers/media/platform/atmel/atmel-isc-base.c      |   20 +-
 drivers/media/platform/atmel/atmel-sama7g5-isc.c   |    2 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |    3 +
 drivers/media/platform/mediatek/mdp/mtk_mdp_ipi.h  |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |  133 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |   13 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.c   |   12 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.h   |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.c   |   50 +
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   29 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |   30 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |   36 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |   37 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_common.c    |    7 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |   25 +-
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c         |    7 +-
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     |  210 ++-
 .../media/platform/mediatek/vcodec/vdec_drv_if.c   |    2 +-
 .../media/platform/mediatek/vcodec/vdec_vpu_if.c   |    5 +
 drivers/media/platform/nvidia/tegra-vde/h264.c     |    9 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c  |   16 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h  |   10 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  328 ++--
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |    4 +-
 drivers/media/platform/nxp/imx-mipi-csis.c         |   41 +
 drivers/media/platform/qcom/camss/camss-csid.c     |    8 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |    2 +-
 drivers/media/platform/qcom/camss/camss-ispif.c    |   43 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |   36 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |    3 -
 drivers/media/platform/qcom/camss/camss-video.c    |    6 +-
 drivers/media/platform/qcom/camss/camss.c          |   73 +-
 drivers/media/platform/qcom/camss/camss.h          |    7 +-
 drivers/media/platform/qcom/venus/core.c           |   20 +-
 drivers/media/platform/qcom/venus/core.h           |    2 +
 drivers/media/platform/qcom/venus/dbgfs.c          |    9 +
 drivers/media/platform/qcom/venus/dbgfs.h          |   13 +
 drivers/media/platform/qcom/venus/helpers.c        |    6 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c       |    9 +
 drivers/media/platform/qcom/venus/hfi_cmds.h       |    1 +
 drivers/media/platform/qcom/venus/hfi_helper.h     |   20 +
 drivers/media/platform/qcom/venus/hfi_parser.c     |    6 +-
 drivers/media/platform/qcom/venus/hfi_platform.c   |   22 +
 drivers/media/platform/qcom/venus/hfi_platform.h   |    2 +
 drivers/media/platform/qcom/venus/hfi_venus.c      |   26 +
 .../media/platform/renesas/rcar-vin/rcar-core.c    |    4 +-
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |    2 +-
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |    2 +-
 .../media/platform/renesas/rcar-vin/rcar-v4l2.c    |    2 +-
 drivers/media/platform/renesas/rcar_drif.c         |    7 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.c  |    4 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    2 +-
 drivers/media/platform/rockchip/rkisp1/Kconfig     |    2 +-
 drivers/media/platform/rockchip/rkisp1/Makefile    |   18 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |  181 ++-
 .../media/platform/rockchip/rkisp1/rkisp1-common.c |  143 ++
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |  157 +-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  536 +++++++
 .../media/platform/rockchip/rkisp1/rkisp1-csi.h    |   28 +
 .../media/platform/rockchip/rkisp1/rkisp1-debug.c  |  243 +++
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |  504 +++---
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  691 +++-----
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |  713 ++++-----
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |  190 ++-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |  218 +--
 .../media/platform/rockchip/rkisp1/rkisp1-stats.c  |   17 +-
 .../media/platform/samsung/exynos-gsc/gsc-core.c   |    3 +-
 .../media/platform/samsung/exynos-gsc/gsc-core.h   |    2 +-
 drivers/media/platform/samsung/exynos4-is/common.c |    2 +-
 .../platform/samsung/exynos4-is/fimc-capture.c     |    6 +-
 .../platform/samsung/exynos4-is/fimc-is-errno.h    |    2 +-
 .../platform/samsung/exynos4-is/fimc-isp-video.c   |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    2 +-
 .../media/platform/samsung/exynos4-is/media-dev.c  |    2 +-
 .../media/platform/samsung/exynos4-is/mipi-csis.c  |    2 +-
 .../platform/samsung/s3c-camif/camif-capture.c     |    2 +-
 .../media/platform/samsung/s5p-jpeg/jpeg-core.c    |    2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.c    |    3 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |   33 +-
 drivers/media/platform/st/sti/delta/delta-v4l2.c   |   24 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |   91 +-
 drivers/media/platform/sunxi/Kconfig               |    2 +
 drivers/media/platform/sunxi/Makefile              |    2 +
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |    4 +-
 .../media/platform/sunxi/sun6i-mipi-csi2/Kconfig   |   15 +
 .../media/platform/sunxi/sun6i-mipi-csi2/Makefile  |    4 +
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |  750 +++++++++
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.h        |   52 +
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2_reg.h    |   76 +
 .../platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig    |   13 +
 .../platform/sunxi/sun8i-a83t-mipi-csi2/Makefile   |    4 +
 .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c   |   72 +
 .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h   |   39 +
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |  816 ++++++++++
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h    |   55 +
 .../sun8i_a83t_mipi_csi2_reg.h                     |  151 ++
 drivers/media/platform/ti/cal/cal-camerarx.c       |    4 +-
 drivers/media/platform/ti/cal/cal-video.c          |    2 +-
 drivers/media/platform/ti/davinci/vpif.c           |    1 +
 drivers/media/platform/ti/omap/omap_voutlib.c      |    4 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    6 +-
 drivers/media/platform/ti/omap3isp/ispccdc.c       |    2 +-
 drivers/media/platform/ti/omap3isp/ispccp2.c       |    2 +-
 drivers/media/platform/ti/omap3isp/ispcsi2.c       |    2 +-
 drivers/media/platform/ti/omap3isp/ispvideo.c      |    4 +-
 drivers/media/platform/video-mux.c                 |    2 +-
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |    2 +-
 drivers/media/platform/xilinx/xilinx-dma.c         |    4 +-
 drivers/media/platform/xilinx/xilinx-vip.h         |    4 +-
 drivers/media/rc/ati_remote.c                      |   11 +-
 drivers/media/rc/igorplugusb.c                     |   23 +-
 drivers/media/rc/iguanair.c                        |    5 +-
 drivers/media/rc/imon_raw.c                        |   16 +-
 drivers/media/rc/lirc_dev.c                        |    6 +-
 drivers/media/rc/rc-main.c                         |    9 +-
 drivers/media/rc/redrat3.c                         |    4 +-
 drivers/media/rc/streamzap.c                       |    2 +-
 drivers/media/rc/ttusbir.c                         |    4 +-
 drivers/media/rc/xbox_remote.c                     |   10 +-
 drivers/media/test-drivers/vicodec/vicodec-core.c  |    8 +-
 drivers/media/test-drivers/vimc/Makefile           |    2 +-
 drivers/media/test-drivers/vimc/vimc-capture.c     |  270 ++--
 drivers/media/test-drivers/vimc/vimc-common.h      |    9 +-
 drivers/media/test-drivers/vimc/vimc-core.c        |  142 +-
 drivers/media/test-drivers/vimc/vimc-debayer.c     |  393 ++---
 drivers/media/test-drivers/vimc/vimc-lens.c        |  102 ++
 drivers/media/test-drivers/vimc/vimc-scaler.c      |  216 +--
 drivers/media/test-drivers/vimc/vimc-sensor.c      |  307 ++--
 drivers/media/test-drivers/vimc/vimc-streamer.c    |    2 +-
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |   29 +
 .../media/test-drivers/vivid/vivid-vid-common.c    |   15 +
 drivers/media/usb/Kconfig                          |    1 -
 drivers/media/usb/Makefile                         |    1 -
 drivers/media/usb/airspy/airspy.c                  |   17 +-
 drivers/media/usb/em28xx/em28xx-audio.c            |   10 -
 drivers/media/usb/em28xx/em28xx-camera.c           |   10 -
 drivers/media/usb/em28xx/em28xx-cards.c            |   10 -
 drivers/media/usb/em28xx/em28xx-core.c             |   10 -
 drivers/media/usb/em28xx/em28xx-dvb.c              |    4 -
 drivers/media/usb/em28xx/em28xx-i2c.c              |   10 -
 drivers/media/usb/em28xx/em28xx-input.c            |   10 -
 drivers/media/usb/em28xx/em28xx-v4l.h              |    9 -
 drivers/media/usb/em28xx/em28xx-vbi.c              |   10 -
 drivers/media/usb/em28xx/em28xx-video.c            |   10 -
 drivers/media/usb/em28xx/em28xx.h                  |   10 -
 drivers/media/usb/gspca/spca501.c                  |    2 +-
 drivers/media/usb/gspca/xirlink_cit.c              |    2 +-
 drivers/media/usb/hdpvr/hdpvr-video.c              |    2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |    3 +-
 drivers/media/usb/usbtv/usbtv-video.c              |    5 +-
 drivers/media/usb/usbtv/usbtv.h                    |    3 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |  120 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  143 +-
 drivers/media/usb/uvc/uvc_isight.c                 |   13 +-
 drivers/media/usb/uvc/uvc_queue.c                  |    6 +-
 drivers/media/usb/uvc/uvc_status.c                 |    6 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |   18 +-
 drivers/media/usb/uvc/uvc_video.c                  |   96 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   16 +-
 drivers/media/v4l2-core/Kconfig                    |    6 +-
 drivers/media/v4l2-core/v4l2-async.c               |   45 +-
 drivers/media/v4l2-core/v4l2-common.c              |    2 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |  103 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  212 ++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |   38 +-
 drivers/media/v4l2-core/v4l2-ctrls-priv.h          |    3 +-
 drivers/media/v4l2-core/v4l2-ctrls-request.c       |   13 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   71 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    2 +-
 drivers/staging/media/Kconfig                      |   12 +-
 drivers/staging/media/Makefile                     |    1 +
 drivers/staging/media/atomisp/Makefile             |    3 -
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |    4 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |   20 +-
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h  |    2 +-
 drivers/staging/media/atomisp/include/hmm/hmm.h    |   32 +-
 drivers/staging/media/atomisp/include/hmm/hmm_bo.h |   37 +-
 .../staging/media/atomisp/include/hmm/hmm_common.h |   26 -
 .../staging/media/atomisp/include/hmm/hmm_pool.h   |  116 --
 .../staging/media/atomisp/include/linux/atomisp.h  |  146 --
 drivers/staging/media/atomisp/notes.txt            |   30 +
 drivers/staging/media/atomisp/pci/atomisp_acc.c    |  625 --------
 drivers/staging/media/atomisp/pci/atomisp_acc.h    |  120 --
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   92 +-
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   29 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |  365 +----
 .../media/atomisp/pci/atomisp_compat_ioctl32.h     |   58 -
 drivers/staging/media/atomisp/pci/atomisp_drvfs.c  |    7 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |   13 -
 .../media/atomisp/pci/atomisp_gmin_platform.c      |   27 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |   73 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |    1 -
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |    3 -
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   10 -
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   32 -
 .../pci/hive_isp_css_include/host/debug_public.h   |    2 +-
 drivers/staging/media/atomisp/pci/hmm/hmm.c        |  202 +--
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |  261 +---
 .../media/atomisp/pci/hmm/hmm_dynamic_pool.c       |  234 ---
 .../media/atomisp/pci/hmm/hmm_reserved_pool.c      |  253 ---
 .../media/atomisp/pci/ia_css_frame_public.h        |   40 -
 .../isp/kernels/sdis/sdis_1.0/ia_css_sdis.host.c   |    2 +-
 .../isp/kernels/sdis/sdis_2/ia_css_sdis2.host.c    |    2 +-
 .../atomisp/pci/isp/modes/interface/isp_const.h    |    6 -
 .../atomisp/pci/runtime/debug/src/ia_css_debug.c   |    2 -
 .../pci/runtime/frame/interface/ia_css_frame.h     |    7 +-
 .../media/atomisp/pci/runtime/frame/src/frame.c    |  110 +-
 .../atomisp/pci/runtime/isp_param/src/isp_param.c  |    2 +-
 .../media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c |   23 +-
 .../media/atomisp/pci/runtime/spctrl/src/spctrl.c  |    2 +-
 drivers/staging/media/atomisp/pci/sh_css.c         |    8 +-
 .../staging/media/atomisp/pci/sh_css_firmware.c    |    2 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |    3 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c  |   47 +-
 drivers/staging/media/av7110/av7110.c              |    2 +-
 drivers/staging/media/hantro/hantro.h              |    4 +
 drivers/staging/media/hantro/hantro_drv.c          |   58 +-
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |   44 +-
 drivers/staging/media/hantro/hantro_g2_regs.h      |    2 +-
 drivers/staging/media/hantro/hantro_g2_vp9_dec.c   |   18 +-
 drivers/staging/media/hantro/hantro_hevc.c         |   33 +-
 drivers/staging/media/hantro/hantro_hw.h           |   18 +-
 drivers/staging/media/hantro/hantro_postproc.c     |   38 +-
 drivers/staging/media/hantro/hantro_v4l2.c         |   52 +-
 drivers/staging/media/hantro/hantro_v4l2.h         |    3 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c        |   80 +-
 drivers/staging/media/hantro/rockchip_vpu_hw.c     |  189 ++-
 drivers/staging/media/hantro/sama5d4_vdec_hw.c     |   40 +-
 drivers/staging/media/hantro/sunxi_vpu_hw.c        |   51 +-
 drivers/staging/media/imx/imx-media-dev-common.c   |    2 +-
 drivers/staging/media/imx/imx-media-utils.c        |    2 +-
 drivers/staging/media/imx/imx7-media-csi.c         | 1607 +++++++++++++++-=
---
 drivers/staging/media/omap4iss/iss.c               |    6 +-
 drivers/staging/media/omap4iss/iss_csi2.c          |    2 +-
 drivers/staging/media/omap4iss/iss_video.c         |    2 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c         |   41 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c          |   12 +-
 .../{media/usb =3D> staging/media}/stkwebcam/Kconfig |    8 +-
 .../usb =3D> staging/media}/stkwebcam/Makefile       |    2 +-
 drivers/staging/media/stkwebcam/TODO               |   12 +
 .../usb =3D> staging/media}/stkwebcam/stk-sensor.c   |    0
 .../usb =3D> staging/media}/stkwebcam/stk-webcam.c   |    0
 .../usb =3D> staging/media}/stkwebcam/stk-webcam.h   |    0
 drivers/staging/media/sunxi/cedrus/cedrus.c        |   54 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h        |    7 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |   37 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |    5 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |  180 ++-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c  |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |    3 +-
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |    1 -
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c    |    5 +-
 drivers/staging/media/tegra-video/vi.c             |    4 +-
 drivers/staging/media/zoran/videocodec.c           |   93 +-
 drivers/staging/media/zoran/videocodec.h           |   15 +
 drivers/staging/media/zoran/zoran.h                |   14 +
 drivers/staging/media/zoran/zr36016.c              |   91 +-
 drivers/staging/media/zoran/zr36050.c              |  144 +-
 drivers/staging/media/zoran/zr36060.c              |   97 +-
 include/media/hevc-ctrls.h                         |  250 ---
 include/media/media-entity.h                       |   98 +-
 include/media/tpg/v4l2-tpg.h                       |   16 +
 include/media/v4l2-async.h                         |    2 +
 include/media/v4l2-common.h                        |    6 +-
 include/media/v4l2-ctrls.h                         |   48 +-
 include/media/v4l2-subdev.h                        |   34 +
 include/media/videobuf2-v4l2.h                     |   10 +
 include/uapi/linux/v4l2-controls.h                 |  459 ++++++
 include/uapi/linux/videodev2.h                     |   39 +
 356 files changed, 14808 insertions(+), 8467 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i=
-a31-mipi-csi2.yaml
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun8i=
-a83t-mipi-csi2.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/exynos-jpeg-cod=
ec.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ar0521=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3568=
-vepu.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5pv210=
-jpeg.yaml
 delete mode 100644 Documentation/userspace-api/media/drivers/hantro.rst
 create mode 100644 drivers/media/i2c/ar0521.c
 create mode 100644 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
 create mode 100644 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.h
 create mode 100644 drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi=
_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi=
_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi=
_csi2_reg.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconf=
ig
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makef=
ile
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i=
_a83t_dphy.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i=
_a83t_dphy.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i=
_a83t_mipi_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i=
_a83t_mipi_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i=
_a83t_mipi_csi2_reg.h
 create mode 100644 drivers/media/test-drivers/vimc/vimc-lens.c
 delete mode 100644 drivers/staging/media/atomisp/include/hmm/hmm_pool.h
 create mode 100644 drivers/staging/media/atomisp/notes.txt
 delete mode 100644 drivers/staging/media/atomisp/pci/atomisp_acc.c
 delete mode 100644 drivers/staging/media/atomisp/pci/atomisp_acc.h
 delete mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c
 delete mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool=
.c
 rename drivers/{media/usb =3D> staging/media}/stkwebcam/Kconfig (68%)
 rename drivers/{media/usb =3D> staging/media}/stkwebcam/Makefile (63%)
 create mode 100644 drivers/staging/media/stkwebcam/TODO
 rename drivers/{media/usb =3D> staging/media}/stkwebcam/stk-sensor.c (100%)
 rename drivers/{media/usb =3D> staging/media}/stkwebcam/stk-webcam.c (100%)
 rename drivers/{media/usb =3D> staging/media}/stkwebcam/stk-webcam.h (100%)
 delete mode 100644 include/media/hevc-ctrls.h

