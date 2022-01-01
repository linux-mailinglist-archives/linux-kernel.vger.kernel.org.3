Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8457A482642
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 02:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiAABm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 20:42:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52734 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAABm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 20:42:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8280061807;
        Sat,  1 Jan 2022 01:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C0C36AEC;
        Sat,  1 Jan 2022 01:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641001374;
        bh=XlhXDyq6GBmEbwVlyXb6e6Brs1NYt20nTffF6EHGyUI=;
        h=Date:From:To:Cc:Subject:From;
        b=aTyeNQbTPXhbjauTznSbQ4+dlLqVx9U1wVY4lzBNVD+2WcvIUcITcexclvBpTOrEE
         PHlH+yqBYrpfMj9M9KSBKe387t7QqLfhhCIe9H+4uUtoddju2fx5MgVCkqt1tpRV+s
         nPyDVbQQ7zrExygWyn/N0kBxBfi5HluUbHQbiWc4S+JuE+kfyepphQrVWdsfDyZGcZ
         AH9jG7ibp9MIO/yln9N/fxxWtUB/q60t9gzc6F3bo+Pg3q7/q8+rlLDA6bt9of5wMV
         QUIAV4stYASL5qtUevuAwWKlM3rSXl0iP8omUtOHEOKisL9knJnucK+XJJhu7r3ARl
         QDnfKlQT6ZAsQ==
Date:   Sat, 1 Jan 2022 02:42:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.17-rc1] New year's media updates
Message-ID: <20220101024250.39c9b5b6@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since this year the next merge window may happen at the first couple of wee=
ks=20
in January, I'm opting to submit the media pull request a little earlier, as
we don't expect too much traffic anyway on media ML, and this might help you
on any travel plans you could have. Also, there's nothing better to desire a
wishful New Year to everybody than to send patches to improve the Linux=20
Kernel ;-)

So, please merge from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.17-1

For:

  - New sensor driver: ov5693;
  - A new driver for STM32 Chrom-ART Accelerator;
  - Added V4L2 core helper functions for VP9 codec;
  - Hantro driver has gained support for VP9 codecs;
  - Added support for Maxim MAX96712 Quad GMSL2 Deserializer;
  - The staging atomisp driver has gained lots of improvements, fixes
    and cleanups. It now works with userptr;
  - Lots of random driver improvements as usual.

Happy New Year!

Best regards,
Mauro

---

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.17-1

for you to fetch changes up to 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c:

  media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs (202=
1-12-16 20:58:56 +0100)

----------------------------------------------------------------
media updates for v5.17-rc1

----------------------------------------------------------------
Akira Yokosawa (1):
      media: docs: media: Fix imbalance of LaTeX group

Alan (1):
      media: atomisp: Fix up the open v load race

Alexandre Courbot (1):
      media: docs: dev-decoder: add restrictions about CAPTURE buffers

Andrzej Hajda (1):
      media: MAINTAINERS: Update email of Andrzej Hajda

Andrzej Pietrasiewicz (8):
      media: uapi: Add VP9 stateless decoder controls
      media: Add VP9 v4l2 library
      media: rkvdec: Add the VP9 backend
      media: hantro: Rename registers
      media: hantro: Prepare for other G2 codecs
      media: hantro: Support VP9 on the G2 core
      media: hantro: Staticize a struct in postprocessor code
      media: hantro: Support NV12 on the G2 core

Andy Shevchenko (2):
      media: i2c: max9286: Get rid of duplicate of_node assignment
      media: dmxdev: drop unneeded <linux/kernel.h> inclusion from other he=
aders

Anton Vasilyev (1):
      media: dw2102: Fix use after free

Benjamin Gaignard (1):
      media: hantro: Fix G2/HEVC negotiated pixelformat

Bingbu Cao (7):
      media: staging: ipu3-imgu: clarify the limitation of grid config
      media: dw9768: activate runtime PM and turn off device
      media: ov8856: support device probe in non-zero ACPI D state
      media: ov2740: support device probe in non-zero ACPI D state
      media: imx208: Support device probe in non-zero ACPI D state
      media: ov5675: Support device probe in non-zero ACPI D state
      media: hi556: Support device probe in non-zero ACPI D state

Cai Huoqing (4):
      media: gspca: Make use of the helper macro kthread_run()
      media: rc: ir-hix5hd2: Add the dependency on HAS_IOMEM
      media: dvb-core: Convert to SPDX identifier
      media: b2c2: flexcop: Convert to SPDX identifier

Chen-Yu Tsai (1):
      media: hantro: Hook up RK3399 JPEG encoder output

Christophe JAILLET (8):
      media: tw5864: Simplify 'tw5864_finidev()'
      media: s5p-mfc: Use 'bitmap_zalloc()' when applicable
      media: mtk-vpu: Remove redundant 'flush_workqueue()' calls
      media: mtk-vcodec: Remove redundant 'flush_workqueue()' calls
      media: mtk-vcodec: Fix an error handling path in 'mtk_vcodec_probe()'
      media: venus: core: Fix a potential NULL pointer dereference in an er=
ror handling path
      media: venus: core: Fix a resource leak in the error handling path of=
 'venus_probe()'
      media: mc: mc-entity.c: Use bitmap_zalloc() when applicable

Colin Ian King (8):
      media: dvb-frontends/stv0367: remove redundant variable ADCClk_Hz
      media: drivers: cx24113: remove redundant variable r
      media: uvcvideo: Fix memory leak of object map on error exit path
      media: atomisp: make array idx_map static const
      media: c8sectpfe: remove redundant assignment to pointer tsin
      media: media si2168: Fix spelling mistake "previsously" -> "previousl=
y"
      media: saa7146: remove redundant assignments of i to zero
      media: davinci: remove redundant assignment to pointer common

Dafna Hirschfeld (8):
      media: mtk-vcodec: enc: add vp8 profile ctrl
      media: mtk-vcodec: remove unused func parameter
      media: mtk-vcodec: call v4l2_m2m_ctx_release first when file is relea=
sed
      media: mtk-vcodec: fix debugging defines
      media: mtk-vcodec: replace func vidioc_try_fmt with two funcs for out=
/cap
      media: mtk-vcodec: don't check return val of mtk_venc_get_q_data
      media: replace setting of bytesused with vb2_set_plane_payload
      media: videobuf2: add WARN_ON_ONCE if bytesused is bigger than buffer=
 length

Dan Carpenter (3):
      media: ipu3-cio2: fix error code in cio2_bridge_connect_sensor()
      media: atomisp: fix uninitialized bug in gmin_get_pmic_id_and_addr()
      media: c8sectpfe: fix double free in configure_channels()

Daniel Kamil Kozar (1):
      media: Print chip type explicitly when loading the Rafael Micro r820t=
 module

Daniel Scally (19):
      media: ipu3-cio2: Toggle sensor streaming in pm runtime ops
      media: i2c: Add support for ov5693 sensor
      media: ipu3-cio2: Add link freq for INT33BE entry
      media: i2c: Re-order runtime pm initialisation
      media: i2c: Add ACPI support to ov8865
      media: i2c: Fix incorrect value in comment
      media: i2c: Defer probe if not endpoint found
      media: i2c: Support 19.2MHz input clock in ov8865
      media: i2c: Add .get_selection() support to ov8865
      media: i2c: Switch control to V4L2_CID_ANALOGUE_GAIN
      media: i2c: Add vblank control to ov8865
      media: i2c: Add hblank control to ov8865
      media: i2c: Update HTS values in ov8865
      media: i2c: cap exposure at height + vblank in ov8865
      media: i2c: Add controls from fwnode to ov8865
      media: i2c: Switch exposure control unit to lines
      media: i2c: Use dev_err_probe() in ov8865
      media: i2c: Fix max gain in ov8865
      media: ipu3-cio2: Add INT347A to cio2-bridge

Dillon Min (9):
      media: admin-guide: add stm32-dma2d description
      media: dt-bindings: media: add document for STM32 DMA2d bindings
      media: v4l2-mem2mem: add v4l2_m2m_get_unmapped_area for no-mmu platfo=
rm
      media: videobuf2: Fix the size printk format
      media: v4l2-ctrls: Add V4L2_CID_COLORFX_CBCR max setting
      media: v4l2-ctrls: Add RGB color effects control
      media: stm32-dma2d: STM32 DMA2D driver
      media: stm32-dma2d: fix compile errors when W=3D1
      media: stm32-dma2d: fix compile-testing failed

Dmitry Osipenko (1):
      media: staging: tegra-vde: Reorder misc device registration

Dongliang Mu (4):
      media: em28xx: fix memory leak in em28xx_init_dev
      media: driver: hva: add pm_runtime_disable in the error handling code=
 of hva_hw_probe
      media: driver: bdisp: add pm_runtime_disable in the error handling co=
de
      media: driver: s3c_camif: move s3c_camif_unregister_subdev out of cam=
if_unregister_media_entities

Dorota Czaplejewicz (1):
      media: imx: Remove unused functions

Eugen Hristev (6):
      media: i2c: imx274: fix s_frame_interval runtime resume not requested
      media: i2c: imx274: fix trivial typo expsoure/exposure
      media: i2c: imx274: fix trivial typo obainted/obtained
      media: i2c: imx274: implement enum_mbus_code
      media: i2c: imx274: simplify probe function by adding local variable =
dev
      media: i2c: imx274: implement fwnode parsing

Evgeny Novikov (1):
      media: pt3: Switch to using functions pcim_* and devm_*

Ezequiel Garcia (4):
      media: hantro: postproc: Fix motion vector space size
      media: hantro: postproc: Introduce struct hantro_postproc_ops
      media: hantro: Simplify postprocessor
      media: hantro: Add quirk for NV12/NV12_4L4 capture format

Fabio Estevam (2):
      media: imx-pxp: Initialize the spinlock prior to using it
      media: imx-pxp: Add rotation support

Geert Uytterhoeven (1):
      media: dt-bindings: media: renesas,jpu: Convert to json-schema

Guo Zhengkui (1):
      media: imx: fix boolreturn.cocci warning:

Hans Verkuil (12):
      media: cec-ioc-receive.rst: clarify sequence and status fields
      media: v4l2-ioctl.c: readbuffers depends on V4L2_CAP_READWRITE
      media: drivers/index.rst: add missing rkisp1 entry
      media: vb2: frame_vector.c: don't overwrite error code
      media: cec: safely unhook lists in cec_data
      media: pvrusb2: fix inconsistent indenting
      media: omap3isp.h: fix kernel-doc warnings
      media: libv4l-introduction.rst: fix undefined label
      media: hantro: drop unused vb2 headers
      media: cec-pin: drop unused 'enabled' field from struct cec_pin
      media: cec-pin: fix interrupt en/disable handling
      media: cec: fix a deadlock situation

Hans de Goede (24):
      media: atomisp-ov2680: Remove a bunch of unused vars from ov2680_devi=
ce
      media: atomisp-ov2680: Turn on power only once
      media: atomisp-ov2680: Push the input_lock taking up into ov2680_s_po=
wer()
      media: atomisp-ov2680: Remove the ov2680_res and N_RES global variabl=
es
      media: atomisp-ov2680: Move ov2680_init_registers() call to power_up()
      media: atomisp-ov2680: Save/restore exposure and gain over sensor pow=
er-down
      media: atomisp-ov2680: Make ov2680_read_reg() support 24 bit registers
      media: atomisp-ov2680: Fix and simplify ov2680_q_exposure()
      media: atomisp-ov2680: Fix ov2680_write_reg() always writing 0 to 16 =
bit registers
      media: atomisp-ov2680: Fix ov2680_set_fmt() clobbering the exposure
      media: atomisp-ov2680: Fix ov2680_set_fmt() messing up high exposure =
settings
      media: i2c: ov8865: Fix lockdep error
      ACPI: delay enumeration of devices with a _DEP pointing to an INT3472=
 device
      i2c: acpi: Use acpi_dev_ready_for_enumeration() helper
      i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
      platform_data: Add linux/platform_data/tps68470.h file
      platform/x86: int3472: Split into 2 drivers
      platform/x86: int3472: Add get_sensor_adev_and_name() helper
      platform/x86: int3472: Pass tps68470_clk_platform_data to the tps6847=
0-regulator MFD-cell
      platform/x86: int3472: Pass tps68470_regulator_platform_data to the t=
ps68470-regulator MFD-cell
      platform/x86: int3472: Deal with probe ordering issues
      media: ipu3-cio2: Defer probing until the PMIC is fully setup
      media: ipu3-cio2: Call cio2_bridge_init() before anything else
      media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs

James Cowgill (1):
      media: hantro: Avoid global variable for jpeg quantization tables

James Hilliard (1):
      media: uvcvideo: Increase UVC_CTRL_CONTROL_TIMEOUT to 5 seconds.

Jammy Huang (2):
      media: aspeed: fix mode-detect always time out at 2nd run
      media: aspeed: Update signal status immediately to ensure sane hw sta=
te

Jason Wang (1):
      media: ivtv: no need to initialise statics to 0

Jean-Michel Hautbois (1):
      media: staging: ipu3-imgu: add the AWB memory layout

Jernej Skrabec (8):
      media: hantro: Fix probe func error path
      media: hantro: add support for reset lines
      media: hantro: vp9: use double buffering if needed
      media: hantro: vp9: add support for legacy register set
      media: hantro: move postproc enablement for old cores
      media: hantro: Convert imx8m_vpu_g2_irq to helper
      media: dt-bindings: allwinner: document H6 Hantro G2 binding
      media: hantro: Add support for Allwinner H6

Jiasheng Jiang (1):
      media: coda/imx-vdoa: Handle dma_set_coherent_mask error codes

Johan Hovold (9):
      media: mceusb: fix control-message timeouts
      media: redrat3: fix control-message timeouts
      media: flexcop-usb: fix control-message timeouts
      media: cpia2: fix control-message timeouts
      media: em28xx: fix control-message timeouts
      media: pvrusb2: fix control-message timeouts
      media: s2255: fix control-message timeouts
      media: stk1160: fix control-message timeouts
      media: uvcvideo: fix division by zero at stream start

Kieran Bingham (2):
      media: tw5864: Disable PCI device when finished
      media: i2c: max9286: Depend on VIDEO_V4L2

Krzysztof Kozlowski (1):
      media: siano: remove duplicate USB device IDs

Kwang Son (1):
      media: docs: Fix newline typo

Lukas Middendorf (3):
      media: media dvb_frontend: add suspend and resume callbacks to dvb_fr=
ontend_ops
      media: si2168: drop support for old firmware file name for si2168 B40
      media: media si2168: fully initialize si2168 on resume only when nece=
ssary

Mansur Alisha Shaik (2):
      media: venus: correct low power frequency calculation for encoder
      media: venus: avoid calling core_clk_setrate() concurrently during co=
ncurrent video sessions

Martin Kepplinger (2):
      media: i2c: hi846: check return value of regulator_bulk_disable()
      media: i2c: hi846: use pm_runtime_force_suspend/resume for system sus=
pend

Martin Weber (1):
      media: coda: V4L2_PIX_FMT_GREY for coda960 JPEG Encoder

Mauro Carvalho Chehab (134):
      media: atomisp: get rid of two unused functions
      media: atomisp: fix enum formats logic
      media: atomisp: better describe get_frame_info issues
      media: atomisp: properly implement g_fmt
      media: atomisp: report colorspace information
      media: atomisp: don't print errors for ignored MBUS formats
      media: atomisp: report the visible resolution
      media: atomisp: comment-out JPEG format
      media: atomisp: add a default case at __get_frame_info()
      media: atomisp: TODO: make it updated to the current issues
      media: atomisp: align sizes returned by g_fmt
      media: atomisp: move a debug printf to a better place
      media: atomisp: fix VIDIOC_S_FMT logic
      media: atomisp: fix enum_fmt logic
      media: atomisp: move atomisp_g_fmt_cap()
      media: atomisp: fix try_fmt logic
      media: atomisp: fix g_fmt logic
      media: atomisp-ov2680: use v4l2_find_nearest_size()
      media: atomisp-ov2722: use v4l2_find_nearest_size()
      media: atomisp-gc0310: use v4l2_find_nearest_size()
      media: atomisp-gc2235: use v4l2_find_nearest_size()
      media: atomisp-mt9m114: use v4l2_find_nearest_size()
      media: atomisp: allocate a v4l2_fh at open time
      media: atomisp: drop duplicated ia_css_isp_configs.c
      media: atomisp: drop duplicated ia_css_isp_states.c
      media: atomisp: unify ia_css_isp_params.c
      media: atomisp: cleanup ia_css_isp_configs() code
      media: atomisp: propagate errors at ia_css_*_configure()
      media: atomisp: sh_css_sp: better handle pipeline config errors
      media: atomisp: add return codes for pipeline config functions
      media: atomisp: return errors from ia_css_dma_configure_from_info()
      media: atomisp: get rid of ISP2401_NEW_INPUT_SYSTEM
      media: atomisp: set per-device's default mode
      media: atomisp: register first the preview devnode
      media: atomisp-ov2680: initialize return var
      media: atomisp-ov2680: properly set the vts value
      media: atomisp: only initialize mode if pipe is not null
      media: atomisp: check before deference asd variable
      media: atomisp: simplify asd check on open() fops
      media: atomisp: get rid of atomisp_get_frame_pgnr() abstraction
      media: ipu3: drop an unused variable
      media: atomisp-gc2235: drop an unused var
      media: atomisp-ov2680: uncomment other resolutions
      media: atomisp-ov2680: remove some unused fields
      media: atomisp-ov2680: adjust the maximum frame rate
      media: atomisp-ov2680: implement enum frame intervals
      media: atomisp: implement enum framesize/frameinterval
      media: atomisp: handle errors at sh_css_create_isp_params()
      media: atomisp: get rid of phys event abstractions
      media: atomisp: get rid of if CONFIG_ON_FRAME_ENQUEUE
      media: atomisp: shift some structs from input_system_local
      media: atomisp: ia_css_stream.h: remove ifdefs from the header
      media: atomisp: fix comments coding style at sh_css.c
      media: atomisp: Avoid some {} just to define new vars
      media: atomisp: drop two vars that are currently ignored
      media: atomisp: drop an useless #ifdef ISP2401
      media: atomisp: remove #ifdef HAS_OUTPUT_SYSTEM
      media: atomisp: drop #ifdef SH_CSS_ENABLE_PER_FRAME_PARAMS
      media: atomisp: drop #ifdef WITH_PC_MONITORING
      media: atomisp: remove #ifdef SH_CSS_ENABLE_METADATA
      media: atomisp: solve #ifdef HAS_NO_PACKED_RAW_PIXELS
      media: atomisp: drop crop code at stream create function
      media: atomisp: get rid of ia_css_stream_load()
      media: atomisp: unify ia_css_stream stop logic
      media: atomisp: drop ia_css_pipe_update_qos_ext_mapped_arg
      media: atomisp: drop a dead code
      media: atomisp: get rid of some weird warn-suppress logic
      media: atomisp: drop check_pipe_resolutions() logic
      media: atomisp: warn if mipi de-allocation failed
      media: atomisp: make sh_css similar to Intel Aero driver
      media: atomisp: get rid of #ifdef ISP_VEC_NELEMS
      media: atomisp: drop empty files
      media: atomisp: simplify sh_css_defs.h
      media: atomisp: sh_css_metrics: drop some unused code
      media: atomisp: sh_css_mipi: cleanup the code
      media: atomisp: sh_css_params: remove tests for ISP2401
      media: atomisp: sh_css_params: cleanup the code
      media: atomisp: remove #ifdef HAS_NO_HMEM
      media: atomisp: get rid of USE_WINDOWS_BINNING_FACTOR tests
      media: atomisp: get rid of #ifdef HAS_BL
      media: atomisp: get rid of sctbl_legacy_*
      media: atomisp: sh_css_param_shading: fix comments coding style
      media: atomisp: sh_css_sp: better support the current firmware
      media: atomisp: atomisp_cmd: make it more compatible with firmware
      media: atomisp: get rid of set pipe version custom ctrl
      media: atomisp: simplify binary.c
      media: atomisp: binary.c: drop logic incompatible with firmware
      media: atomisp: pipe_binarydesc: drop logic incompatible with firmware
      media: atomisp: frame.c: drop a now-unused function
      media: atomisp: add YUVPP at __atomisp_get_pipe() logic
      media: atomisp: cleanup qbuf logic
      media: dib0700: cleanup start/stop streaming logic
      media: dib0700: Only touch one bit when start/stop an adapter
      media: cx25821: drop duplicated i2c_slave_did_ack()
      media: ivtv: drop an unused macro
      media: cx18: drop an unused macro
      media: stb6100: mark a currently unused function as such
      media: mc: drop an unused debug function
      media: dvb-core: dvb_frontend: address some clang warnings
      media: cx25840: drop some unused inline functions
      media: marvell-ccic: drop to_cam() unused function
      media: omap3isp: mark isp_isr_dbg as __maybe_unused
      media: omap3isp: avoid warnings at IS_OUT_OF_BOUNDS()
      media: adv7842: get rid of two unused functions
      media: saa7134-go7007: get rid of to_state() function
      media: davinci: get rid of an unused function
      media: drxd: drop offset var from DownloadMicrocode()
      media: drxk: drop operation_mode from set_dvbt()
      media: m88ds3103: drop reg11 calculus from m88ds3103b_select_mclk()
      media: si21xx: report eventual errors at set_frontend
      media: solo6x10: mark unused functions as such
      media: si470x: fix printk warnings with clang
      media: si470x: consolidate multiple printk's
      media: radio-si476x: drop a container_of() abstraction macro
      media: lmedm04: don't ignore errors when setting a filter
      media: au0828-i2c: drop a duplicated function
      media: adv7604: mark unused functions as such
      media: adv7511: drop unused functions
      media: imx290: mark read reg function as __always_unused
      media: davinci: vpbe_osd: mark read reg function as __always_unused
      media: mtk-mdp: address a clang warning
      media: cobalt: drop an unused variable
      media: mxl5005s: drop some dead code
      Merge tag 'v5.16-rc4' into media_tree
      media: m920x: don't use stack on USB reads
      media: saa7146: fix error logic at saa7146_vv_init()
      media: si2157: move firmware load to a separate function
      media: si2157: rework the firmware load logic
      media: si2157: use a different namespace for firmware
      media: si2157: get rid of chiptype data
      media: si2157: add support for ISDB-T and DTMB
      media: si2157: add support for 1.7MHz and 6.1 MHz
      media: si2157: add ATV support for si2158
      Merge tag 'platform-drivers-x86-int3472-1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/pdx86/platform-drivers-x86 into media_tree

Ma=C3=ADra Canal (2):
      media: rc: pwm-ir-tx: Switch to atomic PWM API
      media: ir-rx51: Switch to atomic PWM API

Michael Kuron (1):
      media: dib0700: fix undefined behavior in tuner shutdown

Michael Tretter (1):
      media: imx6-mipi-csi2: use pre_streamon callback to set sensor into L=
P11

Mikhail Rudenko (1):
      media: rockchip: rkisp1: use device name for debugfs subdir name

Minghao Chi (1):
      media: vidtv: remove unneeded variable make code cleaner

Niklas S=C3=B6derlund (9):
      media: staging: max96712: Add basic support for MAX96712 GMSL2 deseri=
alizer
      media: dt-bindings: adv748x: Convert bindings to json-schema
      media: rcar-vin: Free buffers with error if hardware stop fails
      media: rcar-vin: Add check for completed capture before completing bu=
ffer
      media: rcar-vin: Update format alignment constraints
      media: rcar-csi2: Suppress bind and unbind nodes in sysfs
      media: rcar-vin: Disallow unbinding and binding of individual VINs
      media: rcar-vin: Do not hold the group lock when unregistering notifi=
er
      media: i2c: max9286: Use dev_err_probe() helper

Philipp Zabel (1):
      media: coda: fix CODA960 JPEG encoder buffer overflow

Qing Wang (1):
      media: i2c: ccs: replace snprintf in show functions with sysfs_emit

Randy Dunlap (1):
      media: correct MEDIA_TEST_SUPPORT help text

Ricardo Ribalda (4):
      media: uvcvideo: Set the colorspace as sRGB if undefined
      media: uvcvideo: Avoid invalid memory access
      media: uvcvideo: Avoid returning invalid controls
      media: Revert "media: uvcvideo: Set unique vdev name based in type"

Rikard Falkeborn (4):
      media: imx: Constify static struct v4l2_m2m_ops
      media: staging: media: rkvdec: Constify static struct v4l2_m2m_ops
      media: s5p-jpeg: Constify struct v4l2_m2m_ops
      media: staging: max96712: Constify static v4l2_subdev_ops

Robert Foss (1):
      media: camss: Remove unused static function

Robert Schlabbach (2):
      media: si2157: Fix "warm" tuner state detection
      media: si2157: Add optional firmware download

Sakari Ailus (4):
      media: max96712: Depend on VIDEO_V4L2
      media: Update Intel-submitted camera sensor driver contacts
      media: ov8865: Disable only enabled regulators on error path
      media: ov5670: Support device probe in non-zero ACPI D state

Samuel Holland (2):
      media: dt-bindings: media: Add compatible for D1
      media: cedrus: Add support for the D1 variant

Scott K Logan (1):
      media: s5h1411.c: Fix a typo in the VSB SNR table

Sean Young (9):
      media: lirc: always send timeout reports
      media: iguanair: no need for reset after IR receiver enable
      media: winbond-cir: no need for reset after resume
      media: igorplugusb: receiver overflow should be reported
      media: streamzap: remove unnecessary ir_raw_event_reset and handle
      media: streamzap: no need for usb pid/vid in device name
      media: streamzap: less chatter
      media: streamzap: remove unused struct members
      media: streamzap: remove redundant gap calculations

Sudip Mukherjee (1):
      media: sp887x: drop unneeded assignment

Suresh Udipi (3):
      media: rcar-csi2: Correct the selection of hsfreqrange
      media: rcar-csi2: Add warning for PHY speed less than minimum
      media: rcar-csi2: Optimize the selection PHTW register

Tang Bin (1):
      media: rcar_fdp1: Fix the correct variable assignments

Thierry Reding (2):
      media: staging: tegra-vde: Support reference picture marking
      media: staging: tegra-vde: Properly mark invalid entries

Tsuchiya Yuto (16):
      media: atomisp: add missing media_device_cleanup() in atomisp_unregis=
ter_entities()
      media: atomisp: fix punit_ddr_dvfs_enable() argument for mrfld_power =
up case
      media: atomisp: fix inverted logic in buffers_needed()
      media: atomisp: do not use err var when checking port validity for IS=
P2400
      media: atomisp: fix inverted error check for ia_css_mipi_is_source_po=
rt_valid()
      media: atomisp: use IA_CSS_ERROR() for error messages in sh_css_mipi.c
      media: atomisp: fix ifdefs in sh_css.c
      media: atomisp: drop luma_only, input_yuv and input_raw from ISP2401
      media: atomisp: remove struct ia_css_isp_parameter
      media: atomisp: remove struct ia_css_isp_parameter xnr3
      media: atomisp: remove polling_mode and subscr_index
      media: atomisp: make fw ver irci_stable_candrpv_0415_20150521_0458 wo=
rk
      media: atomisp: pci: release_version is now irci_stable_candrpv_0415_=
20150521_0458
      media: atomisp: add Microsoft Surface 3 ACPI vars
      media: atomisp: add NULL check for asd obtained from atomisp_video_pi=
pe
      media: atomisp: fix "variable dereferenced before check 'asd'"

Tzung-Bi Shih (1):
      media: mtk-vcodec: vdec: remove redundant 'pfb' assignment

Uwe Kleine-K=C3=B6nig (4):
      media: rc: ir-spi: Drop empty spi_driver remove callback
      media: s5c73m3: Drop empty spi_driver remove callback
      media: tua9001: Improve messages in .remove's error path
      media: cxd2880: Eliminate dead code

Wang Hai (2):
      media: dmxdev: fix UAF when dvb_register_device() fails
      media: msi001: fix possible null-ptr-deref in msi001_probe()

Xu Wang (2):
      media: atomisp: Remove unneeded null check
      media: mtk-jpeg: Remove unnecessary print function dev_err()

Yang Yingliang (1):
      media: si470x-i2c: fix possible memory leak in si470x_i2c_probe()

Yunfei Dong (1):
      media: mtk-vcodec: Align width and height to 64 bytes

Zhen Lei (1):
      media: bttv: use DEVICE_ATTR_RO() helper macro

Zheyu Ma (1):
      media: b2c2: Add missing check in flexcop_pci_isr:

Zhou Qingyang (4):
      media: dib8000: Fix a memleak in dib8000_init()
      media: saa7146: hexium_orion: Fix a NULL pointer dereference in hexiu=
m_attach()
      media: saa7146: mxb: Fix a NULL pointer dereference in mxb_attach()
      media: saa7146: hexium_gemini: Fix a NULL pointer dereference in hexi=
um_attach()

chiminghao (1):
      media: drivers:usb:remove unneeded variable

gushengxian (1):
      media: b2c2-flexcop-usb: fix some whitespace coding style

zhaoxiao (1):
      media: dib9000: Use min() instead of doing it manually

 .mailmap                                           |    1 +
 .../admin-guide/media/platform-cardlist.rst        |    1 +
 .../media/allwinner,sun4i-a10-video-engine.yaml    |    1 +
 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml |   64 +
 .../devicetree/bindings/media/i2c/adv748x.txt      |  116 -
 .../devicetree/bindings/media/i2c/adv748x.yaml     |  212 ++
 .../devicetree/bindings/media/renesas,jpu.txt      |   25 -
 .../devicetree/bindings/media/renesas,jpu.yaml     |   65 +
 .../devicetree/bindings/media/st,stm32-dma2d.yaml  |   71 +
 Documentation/driver-api/media/drivers/index.rst   |    1 +
 .../userspace-api/media/cec/cec-ioc-receive.rst    |   49 +-
 .../userspace-api/media/lirc.h.rst.exceptions      |    2 +
 .../userspace-api/media/rc/lirc-dev-intro.rst      |    8 +-
 Documentation/userspace-api/media/rc/lirc-func.rst |    1 -
 .../media/rc/lirc-set-rec-timeout-reports.rst      |   49 -
 Documentation/userspace-api/media/v4l/biblio.rst   |   10 +
 .../userspace-api/media/v4l/capture.c.rst          |   52 +-
 Documentation/userspace-api/media/v4l/control.rst  |    9 +
 .../userspace-api/media/v4l/dev-decoder.rst        |   17 +
 .../media/v4l/ext-ctrls-codec-stateless.rst        |  573 ++++
 .../media/v4l/libv4l-introduction.rst              |    2 +-
 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   15 +
 .../userspace-api/media/v4l/subdev-formats.rst     |    2 +-
 .../userspace-api/media/v4l/v4l2grab.c.rst         |    8 +-
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |    8 +
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |   12 +
 .../userspace-api/media/videodev2.h.rst.exceptions |    2 +
 MAINTAINERS                                        |   28 +-
 drivers/acpi/scan.c                                |   37 +-
 drivers/i2c/i2c-core-acpi.c                        |   22 +-
 drivers/media/Kconfig                              |    8 +-
 drivers/media/cec/core/cec-adap.c                  |   46 +-
 drivers/media/cec/core/cec-api.c                   |    8 +-
 drivers/media/cec/core/cec-core.c                  |    3 +
 drivers/media/cec/core/cec-pin-priv.h              |    1 -
 drivers/media/cec/core/cec-pin.c                   |   32 +-
 drivers/media/common/b2c2/flexcop.c                |   11 +-
 drivers/media/common/saa7146/saa7146_fops.c        |    5 +-
 drivers/media/common/videobuf2/frame_vector.c      |   15 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    8 +-
 drivers/media/dvb-core/dmxdev.c                    |   30 +-
 drivers/media/dvb-core/dvb_demux.c                 |   12 +-
 drivers/media/dvb-core/dvb_frontend.c              |   21 +-
 drivers/media/dvb-core/dvb_vb2.c                   |    4 -
 drivers/media/dvb-core/dvbdev.c                    |   12 +-
 drivers/media/dvb-frontends/cx24113.c              |    2 +-
 drivers/media/dvb-frontends/dib8000.c              |    4 +-
 drivers/media/dvb-frontends/dib9000.c              |    4 +-
 drivers/media/dvb-frontends/drxd_hard.c            |    8 -
 drivers/media/dvb-frontends/drxk_hard.c            |   23 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    6 +-
 drivers/media/dvb-frontends/s5h1411.c              |    2 +-
 drivers/media/dvb-frontends/si2168.c               |   43 +-
 drivers/media/dvb-frontends/si2168_priv.h          |    2 +-
 drivers/media/dvb-frontends/si21xx.c               |    7 +-
 drivers/media/dvb-frontends/sp887x.c               |    4 +-
 drivers/media/dvb-frontends/stb6100.c              |    2 +-
 drivers/media/dvb-frontends/stv0367.c              |    6 +-
 drivers/media/i2c/Kconfig                          |   12 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/adv7511-v4l2.c                   |   22 -
 drivers/media/i2c/adv7604.c                        |   18 +-
 drivers/media/i2c/adv7842.c                        |   10 -
 drivers/media/i2c/ccs/ccs-core.c                   |   12 +-
 drivers/media/i2c/cx25840/cx25840-ir.c             |   20 -
 drivers/media/i2c/dw9768.c                         |    6 +
 drivers/media/i2c/hi556.c                          |   70 +-
 drivers/media/i2c/hi846.c                          |   14 +-
 drivers/media/i2c/imx208.c                         |   82 +-
 drivers/media/i2c/imx274.c                         |  102 +-
 drivers/media/i2c/imx290.c                         |    2 +-
 drivers/media/i2c/imx319.c                         |    2 +-
 drivers/media/i2c/imx355.c                         |    2 +-
 drivers/media/i2c/max9286.c                        |    7 +-
 drivers/media/i2c/ov13858.c                        |    2 +-
 drivers/media/i2c/ov2740.c                         |   69 +-
 drivers/media/i2c/ov5670.c                         |   80 +-
 drivers/media/i2c/ov5675.c                         |   71 +-
 drivers/media/i2c/ov5693.c                         | 1537 +++++++++
 drivers/media/i2c/ov8856.c                         |  162 +-
 drivers/media/i2c/ov8865.c                         |  478 ++-
 drivers/media/i2c/s5c73m3/s5c73m3-spi.c            |    6 -
 drivers/media/mc/mc-entity.c                       |   22 +-
 drivers/media/pci/b2c2/flexcop-pci.c               |    3 +
 drivers/media/pci/bt8xx/bttv-driver.c              |    4 +-
 drivers/media/pci/cobalt/cobalt-cpld.c             |    5 +-
 drivers/media/pci/cx18/cx18-alsa-main.c            |    6 -
 drivers/media/pci/cx25821/cx25821-core.c           |    7 -
 drivers/media/pci/intel/ipu3/cio2-bridge.c         |  100 +-
 drivers/media/pci/intel/ipu3/cio2-bridge.h         |   16 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   27 +-
 drivers/media/pci/ivtv/ivtv-alsa-main.c            |    6 -
 drivers/media/pci/ivtv/ivtvfb.c                    |    2 +-
 drivers/media/pci/pt3/pt3.c                        |   58 +-
 drivers/media/pci/saa7134/saa7134-go7007.c         |    7 +-
 drivers/media/pci/saa7146/hexium_gemini.c          |    7 +-
 drivers/media/pci/saa7146/hexium_orion.c           |    8 +-
 drivers/media/pci/saa7146/mxb.c                    |   11 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c     |   12 +-
 drivers/media/pci/tw5864/tw5864-core.c             |    5 +-
 drivers/media/platform/Kconfig                     |   12 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/allegro-dvt/allegro-core.c  |    2 +-
 drivers/media/platform/aspeed-video.c              |   14 +-
 drivers/media/platform/coda/coda-common.c          |   16 +-
 drivers/media/platform/coda/coda-jpeg.c            |   21 +-
 drivers/media/platform/coda/imx-vdoa.c             |    6 +-
 drivers/media/platform/davinci/vpbe_osd.c          |    2 +-
 drivers/media/platform/davinci/vpif_capture.c      |   12 -
 drivers/media/platform/imx-pxp.c                   |   35 +-
 drivers/media/platform/marvell-ccic/cafe-driver.c  |    7 -
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |    4 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |    2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h |    1 +
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c |    6 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec_stateless.c |    1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  208 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c |    6 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |   10 -
 .../media/platform/mtk-vcodec/mtk_vcodec_util.h    |   45 +-
 .../platform/mtk-vcodec/vdec/vdec_h264_req_if.c    |    8 +-
 .../media/platform/mtk-vcodec/venc/venc_h264_if.c  |    9 +-
 .../media/platform/mtk-vcodec/venc/venc_vp8_if.c   |    3 +-
 drivers/media/platform/mtk-vcodec/venc_vpu_if.c    |    1 -
 drivers/media/platform/mtk-vcodec/venc_vpu_if.h    |    1 -
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |    4 +-
 drivers/media/platform/omap3isp/isp.c              |    3 +-
 drivers/media/platform/omap3isp/isph3a_af.c        |    2 +-
 drivers/media/platform/omap3isp/omap3isp.h         |    2 +
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |    7 -
 drivers/media/platform/qcom/venus/core.c           |   11 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |   32 +-
 drivers/media/platform/rcar-vin/rcar-core.c        |    3 +-
 drivers/media/platform/rcar-vin/rcar-csi2.c        |   23 +-
 drivers/media/platform/rcar-vin/rcar-dma.c         |   17 +
 drivers/media/platform/rcar-vin/rcar-v4l2.c        |   15 +-
 drivers/media/platform/rcar_fdp1.c                 |    7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |    2 +-
 drivers/media/platform/s3c-camif/camif-core.c      |    2 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |    6 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.h        |    2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |    9 +-
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c      |    1 +
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  |   12 +-
 drivers/media/platform/sti/hva/hva-hw.c            |    4 +-
 drivers/media/platform/stm32/Makefile              |    2 +
 drivers/media/platform/stm32/dma2d/dma2d-hw.c      |  133 +
 drivers/media/platform/stm32/dma2d/dma2d-regs.h    |  113 +
 drivers/media/platform/stm32/dma2d/dma2d.c         |  739 +++++
 drivers/media/platform/stm32/dma2d/dma2d.h         |  135 +
 drivers/media/radio/radio-si476x.c                 |    6 -
 drivers/media/radio/si470x/radio-si470x-i2c.c      |   20 +-
 drivers/media/radio/si470x/radio-si470x-usb.c      |   16 +-
 drivers/media/rc/Kconfig                           |    2 +-
 drivers/media/rc/igorplugusb.c                     |    4 +-
 drivers/media/rc/iguanair.c                        |    3 -
 drivers/media/rc/ir-rx51.c                         |   16 +-
 drivers/media/rc/ir-spi.c                          |    6 -
 drivers/media/rc/lirc_dev.c                        |    5 -
 drivers/media/rc/mceusb.c                          |    8 +-
 drivers/media/rc/pwm-ir-tx.c                       |   18 +-
 drivers/media/rc/redrat3.c                         |   22 +-
 drivers/media/rc/streamzap.c                       |  122 +-
 drivers/media/rc/winbond-cir.c                     |    1 -
 drivers/media/spi/cxd2880-spi.c                    |   13 +-
 drivers/media/test-drivers/vicodec/vicodec-core.c  |    2 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c       |   12 +-
 drivers/media/tuners/msi001.c                      |    7 +
 drivers/media/tuners/mxl5005s.c                    |   14 +-
 drivers/media/tuners/r820t.c                       |   24 +-
 drivers/media/tuners/si2157.c                      |  307 +-
 drivers/media/tuners/si2157_priv.h                 |   44 +-
 drivers/media/tuners/tua9001.c                     |    6 +-
 drivers/media/usb/au0828/au0828-i2c.c              |    7 -
 drivers/media/usb/b2c2/flexcop-usb.c               |   28 +-
 drivers/media/usb/b2c2/flexcop-usb.h               |   12 +-
 drivers/media/usb/cpia2/cpia2_usb.c                |    4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |    3 +
 drivers/media/usb/dvb-usb/dib0700_core.c           |   28 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |  338 +-
 drivers/media/usb/dvb-usb/m920x.c                  |   12 +-
 drivers/media/usb/em28xx/em28xx-cards.c            |   18 +-
 drivers/media/usb/em28xx/em28xx-core.c             |    4 +-
 drivers/media/usb/go7007/go7007-driver.c           |    2 +-
 drivers/media/usb/gspca/m5602/m5602_s5k83a.c       |   13 +-
 drivers/media/usb/pvrusb2/pvrusb2-encoder.c        |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |   41 +-
 drivers/media/usb/s2255/s2255drv.c                 |    4 +-
 drivers/media/usb/siano/smsusb.c                   |    4 -
 drivers/media/usb/stk1160/stk1160-core.c           |    4 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |    4 +-
 drivers/media/usb/uvc/uvc_driver.c                 |   13 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |    6 +-
 drivers/media/usb/uvc/uvc_video.c                  |    4 +
 drivers/media/usb/uvc/uvcvideo.h                   |    2 +-
 drivers/media/v4l2-core/Kconfig                    |    4 +
 drivers/media/v4l2-core/Makefile                   |    1 +
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  180 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |   20 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    5 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |   21 +
 drivers/media/v4l2-core/v4l2-vp9.c                 | 1850 +++++++++++
 drivers/platform/x86/intel/int3472/Makefile        |    9 +-
 ...472_clk_and_regulator.c =3D> clk_and_regulator.c} |    2 +-
 drivers/platform/x86/intel/int3472/common.c        |   82 +
 .../{intel_skl_int3472_common.h =3D> common.h}       |    6 +-
 .../{intel_skl_int3472_discrete.c =3D> discrete.c}   |   51 +-
 .../x86/intel/int3472/intel_skl_int3472_common.c   |  106 -
 .../{intel_skl_int3472_tps68470.c =3D> tps68470.c}   |   92 +-
 drivers/platform/x86/intel/int3472/tps68470.h      |   25 +
 .../x86/intel/int3472/tps68470_board_data.c        |  145 +
 drivers/staging/media/Kconfig                      |    2 +
 drivers/staging/media/Makefile                     |    1 +
 drivers/staging/media/atomisp/Makefile             |   24 +-
 drivers/staging/media/atomisp/TODO                 |  191 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |  119 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |  121 +-
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |  130 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |  313 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |  118 +-
 drivers/staging/media/atomisp/i2c/gc0310.h         |    3 +-
 drivers/staging/media/atomisp/i2c/gc2235.h         |    3 +-
 drivers/staging/media/atomisp/i2c/ov2680.h         |  207 +-
 drivers/staging/media/atomisp/i2c/ov2722.h         |    3 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |  248 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |    6 +-
 drivers/staging/media/atomisp/pci/atomisp_compat.h |    2 -
 .../media/atomisp/pci/atomisp_compat_css20.c       |   92 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |   43 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |   21 +-
 .../staging/media/atomisp/pci/atomisp_internal.h   |    7 +
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  312 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |   54 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |    4 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   33 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.h   |    3 +-
 .../atomisp/pci/camera/pipe/src/pipe_binarydesc.c  |   25 +-
 .../pci/css_2400_system/hive/ia_css_isp_configs.c  |  386 ---
 .../pci/css_2400_system/hive/ia_css_isp_params.c   | 3420 ----------------=
----
 .../pci/css_2401_system/hive/ia_css_isp_configs.c  |  386 ---
 .../pci/css_2401_system/hive/ia_css_isp_states.c   |  224 --
 .../atomisp/pci/hive_isp_css_common/host/gdc.c     |   11 -
 .../staging/media/atomisp/pci/ia_css_acc_types.h   |    5 -
 .../media/atomisp/pci/ia_css_event_public.h        |   17 +-
 .../staging/media/atomisp/pci/ia_css_isp_configs.c |  321 ++
 .../staging/media/atomisp/pci/ia_css_isp_configs.h |  119 +-
 .../{css_2401_system/hive =3D> }/ia_css_isp_params.c |   23 -
 .../staging/media/atomisp/pci/ia_css_isp_params.h  |    3 -
 .../{css_2400_system/hive =3D> }/ia_css_isp_states.c |    0
 drivers/staging/media/atomisp/pci/ia_css_pipe.h    |    4 +-
 .../staging/media/atomisp/pci/ia_css_pipe_public.h |   26 -
 drivers/staging/media/atomisp/pci/ia_css_stream.h  |    4 -
 .../media/atomisp/pci/ia_css_stream_public.h       |   19 +-
 .../staging/media/atomisp/pci/input_system_local.h |  134 +
 .../pci/isp/kernels/bh/bh_2/ia_css_bh.host.c       |    2 -
 .../copy_output_1.0/ia_css_copy_output.host.c      |    8 +-
 .../copy_output_1.0/ia_css_copy_output.host.h      |    6 +-
 .../isp/kernels/crop/crop_1.0/ia_css_crop.host.c   |   28 +-
 .../isp/kernels/crop/crop_1.0/ia_css_crop.host.h   |   14 +-
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs.host.c  |    8 +-
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs.host.h  |    6 +-
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c  |   28 +-
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.h  |   14 +-
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr.host.c  |    1 -
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr.host.h  |    1 -
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr_param.h |    1 -
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h |    1 -
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.c  |   16 +-
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.h  |    6 +-
 .../yuv444_io_ls/ia_css_yuv444_io.host.c           |   18 +-
 .../yuv444_io_ls/ia_css_yuv444_io.host.h           |    6 +-
 .../iterator/iterator_1.0/ia_css_iterator.host.c   |   11 +-
 .../kernels/output/output_1.0/ia_css_output.host.c |   69 +-
 .../kernels/output/output_1.0/ia_css_output.host.h |   42 +-
 .../kernels/qplane/qplane_2/ia_css_qplane.host.c   |   30 +-
 .../kernels/qplane/qplane_2/ia_css_qplane.host.h   |   16 +-
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw.host.c  |   38 +-
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw.host.h  |   22 +-
 .../raw_aa_binning_1.0/ia_css_raa.host.c           |    2 -
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref.host.c  |   30 +-
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref.host.h  |   16 +-
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c  |    5 -
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc.host.c     |   68 -
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc.host.h     |   33 -
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc_types.h    |   14 -
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr.host.c  |   33 +-
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr.host.h  |   14 +-
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr_param.h |    4 +-
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c     |   32 +-
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.h     |    8 +-
 .../atomisp/pci/isp/modes/interface/isp_const.h    |   14 +-
 .../media/atomisp/pci/isp2400_input_system_local.h |  126 -
 .../atomisp/pci/isp2401_input_system_global.h      |   12 -
 .../media/atomisp/pci/isp2401_input_system_local.h |   26 -
 .../pci/runtime/binary/interface/ia_css_binary.h   |    3 -
 .../media/atomisp/pci/runtime/binary/src/binary.c  |  513 +--
 .../atomisp/pci/runtime/debug/src/ia_css_debug.c   |    2 +-
 .../pci/runtime/frame/interface/ia_css_frame.h     |   24 +-
 .../media/atomisp/pci/runtime/frame/src/frame.c    |  116 +-
 .../atomisp/pci/runtime/isys/src/virtual_isys.c    |   11 -
 .../atomisp/pci/runtime/pipeline/src/pipeline.c    |    3 +-
 drivers/staging/media/atomisp/pci/sh_css.c         | 2047 ++++--------
 drivers/staging/media/atomisp/pci/sh_css_defs.h    |   58 +-
 .../staging/media/atomisp/pci/sh_css_firmware.c    |   16 +-
 .../staging/media/atomisp/pci/sh_css_firmware.h    |    3 -
 .../staging/media/atomisp/pci/sh_css_internal.h    |   36 +-
 .../staging/media/atomisp/pci/sh_css_metadata.c    |   17 -
 drivers/staging/media/atomisp/pci/sh_css_metrics.c |   25 -
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |  197 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.h    |   17 +-
 drivers/staging/media/atomisp/pci/sh_css_morph.c   |   17 -
 .../media/atomisp/pci/sh_css_param_shading.c       |   82 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c  |  249 +-
 drivers/staging/media/atomisp/pci/sh_css_params.h  |    8 -
 drivers/staging/media/atomisp/pci/sh_css_shading.c |   17 -
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |  131 +-
 drivers/staging/media/atomisp/pci/sh_css_sp.h      |    7 +-
 drivers/staging/media/atomisp/pci/sh_css_stream.c  |   17 -
 drivers/staging/media/atomisp/pci/system_global.h  |    3 -
 drivers/staging/media/hantro/Kconfig               |   11 +-
 drivers/staging/media/hantro/Makefile              |   10 +-
 drivers/staging/media/hantro/hantro.h              |   50 +-
 drivers/staging/media/hantro/hantro_drv.c          |   51 +-
 drivers/staging/media/hantro/hantro_g2.c           |   44 +
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |   92 +-
 drivers/staging/media/hantro/hantro_g2_regs.h      |  149 +-
 drivers/staging/media/hantro/hantro_g2_vp9_dec.c   | 1022 ++++++
 drivers/staging/media/hantro/hantro_h1_jpeg_enc.c  |    7 +-
 drivers/staging/media/hantro/hantro_hevc.c         |   79 +-
 drivers/staging/media/hantro/hantro_hw.h           |  131 +-
 drivers/staging/media/hantro/hantro_jpeg.c         |   31 +-
 drivers/staging/media/hantro/hantro_jpeg.h         |    4 +-
 drivers/staging/media/hantro/hantro_postproc.c     |   84 +-
 drivers/staging/media/hantro/hantro_v4l2.c         |   13 +-
 drivers/staging/media/hantro/hantro_vp9.c          |  240 ++
 drivers/staging/media/hantro/hantro_vp9.h          |  102 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c        |   58 +-
 .../media/hantro/rockchip_vpu2_hw_jpeg_enc.c       |   22 +-
 drivers/staging/media/hantro/rockchip_vpu_hw.c     |   12 +-
 drivers/staging/media/hantro/sama5d4_vdec_hw.c     |    3 +-
 drivers/staging/media/hantro/sunxi_vpu_hw.c        |   86 +
 drivers/staging/media/imx/imx-media-csc-scaler.c   |    2 +-
 drivers/staging/media/imx/imx-media-csi.c          |    2 +-
 drivers/staging/media/imx/imx-media-utils.c        |   42 -
 drivers/staging/media/imx/imx-media.h              |    4 -
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    9 +-
 .../staging/media/ipu3/include/uapi/intel-ipu3.h   |   42 +-
 drivers/staging/media/ipu3/ipu3-css-params.c       |    3 -
 drivers/staging/media/max96712/Kconfig             |   14 +
 drivers/staging/media/max96712/Makefile            |    2 +
 drivers/staging/media/max96712/max96712.c          |  440 +++
 drivers/staging/media/meson/vdec/vdec_helpers.c    |   10 +-
 drivers/staging/media/rkvdec/Kconfig               |    1 +
 drivers/staging/media/rkvdec/Makefile              |    2 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c          | 1072 ++++++
 drivers/staging/media/rkvdec/rkvdec.c              |   43 +-
 drivers/staging/media/rkvdec/rkvdec.h              |   12 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |   12 +
 drivers/staging/media/tegra-vde/vde.c              |  147 +-
 drivers/staging/media/tegra-vde/vde.h              |   18 +
 include/acpi/acpi_bus.h                            |    5 +-
 include/linux/i2c.h                                |   17 +-
 include/linux/platform_data/tps68470.h             |   35 +
 include/media/cec.h                                |   11 +-
 include/media/dmxdev.h                             |    1 -
 include/media/dvb_frontend.h                       |   13 +-
 include/media/rc-core.h                            |    2 -
 include/media/v4l2-ctrls.h                         |    4 +
 include/media/v4l2-mem2mem.h                       |    5 +
 include/media/v4l2-vp9.h                           |  233 ++
 include/media/videobuf2-core.h                     |    9 +-
 include/uapi/linux/v4l2-controls.h                 |  288 +-
 include/uapi/linux/videodev2.h                     |    6 +
 373 files changed, 15536 insertions(+), 11342 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50=
i-h6-vpu-g2.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/adv748x.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/adv748x.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,jpu.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,jpu.yaml
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dma2d.=
yaml
 delete mode 100644 Documentation/userspace-api/media/rc/lirc-set-rec-timeo=
ut-reports.rst
 create mode 100644 drivers/media/i2c/ov5693.c
 create mode 100644 drivers/media/platform/stm32/dma2d/dma2d-hw.c
 create mode 100644 drivers/media/platform/stm32/dma2d/dma2d-regs.h
 create mode 100644 drivers/media/platform/stm32/dma2d/dma2d.c
 create mode 100644 drivers/media/platform/stm32/dma2d/dma2d.h
 create mode 100644 drivers/media/v4l2-core/v4l2-vp9.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regul=
ator.c =3D> clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h =3D>=
 common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c =
=3D> discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_co=
mmon.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c =
=3D> tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 delete mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hive/=
ia_css_isp_configs.c
 delete mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hive/=
ia_css_isp_params.c
 delete mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hive/=
ia_css_isp_configs.c
 delete mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hive/=
ia_css_isp_states.c
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_isp_configs.c
 rename drivers/staging/media/atomisp/pci/{css_2401_system/hive =3D> }/ia_c=
ss_isp_params.c (99%)
 rename drivers/staging/media/atomisp/pci/{css_2400_system/hive =3D> }/ia_c=
ss_isp_states.c (100%)
 delete mode 100644 drivers/staging/media/atomisp/pci/sh_css_metadata.c
 delete mode 100644 drivers/staging/media/atomisp/pci/sh_css_morph.c
 delete mode 100644 drivers/staging/media/atomisp/pci/sh_css_shading.c
 delete mode 100644 drivers/staging/media/atomisp/pci/sh_css_stream.c
 create mode 100644 drivers/staging/media/hantro/hantro_g2.c
 create mode 100644 drivers/staging/media/hantro/hantro_g2_vp9_dec.c
 create mode 100644 drivers/staging/media/hantro/hantro_vp9.c
 create mode 100644 drivers/staging/media/hantro/hantro_vp9.h
 create mode 100644 drivers/staging/media/hantro/sunxi_vpu_hw.c
 create mode 100644 drivers/staging/media/max96712/Kconfig
 create mode 100644 drivers/staging/media/max96712/Makefile
 create mode 100644 drivers/staging/media/max96712/max96712.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-vp9.c
 create mode 100644 include/linux/platform_data/tps68470.h
 create mode 100644 include/media/v4l2-vp9.h

