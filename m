Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5FE530A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiEWHWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiEWHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294960D3;
        Mon, 23 May 2022 00:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F00611B5;
        Mon, 23 May 2022 07:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1004DC385AA;
        Mon, 23 May 2022 07:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653289979;
        bh=/CuMBvSoFFZsGIQt85Xg6X/Do7kI4CuGxv2NW5fT54c=;
        h=Date:From:To:Cc:Subject:From;
        b=uK7IwQeCKUDbViygZTLxmM7TjFSuzNcMtka54PPfvvSxB/L8bMsqxSTYDZOLo9RDO
         KutcJLStfIh++HXl5AAqCM3jDtYU9Vt9prLjr2OM+PS1VyYU6D2BtNj4QupH7J4CSM
         P5vbw0XaIC1Z4hm74jodNuMa8F5FKs1D3hAX0YIjRLh2aVH0dTzNvGjL1ZqM8xjRAc
         d+IuBOe1TPGSql+CNy4v08r82F9OWp5itEO9Zaia0NLOjGLGa2bTVZvLgroExHij7D
         w2yLm/C5yxX2FGL90elR6B42hwNaHPi4bIbjN34V2nBpQkxlkYFw/jAQahCn252Sk8
         ZZMVec9OtrfJQ==
Date:   Mon, 23 May 2022 09:12:55 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.19-rc1] media updates
Message-ID: <20220523091255.058e306d@coco.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.19-1


For:

 - dvb-usb drivers entries got reworked to avoid usage of magic numbers to=
=20
   refer to data position inside tables;
 - vcodec driver has gained support for MT8186 and for vp8 and vp9=20
   stateless codecs;
 - hantro has gained support for Hantro G1 on RK366x;
 - Added more h264 levels on coda960;
 - ccs gained support for MIPI CSI-2 28 bits per pixel raw data type;
 - venus driver gained support for Qualcomm custom compressed pixel formats;
 - lots of driver fixes and updates.

Regards,
Mauro

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.19-1

for you to fetch changes up to 340ce50f75a6bdfe6d1850ca49ef37a8e2765dd1:

  media: hantro: Enable HOLD_CAPTURE_BUF for H.264 (2022-05-17 10:11:19 +02=
00)

----------------------------------------------------------------
media updates for v5.19-rc1

----------------------------------------------------------------
Benjamin Gaignard (5):
      media: hantro: Use post processor scaling capacities
      media: hantro: HEVC: Fix output frame chroma offset
      media: hantro: HEVC: Fix tile info buffer value computation
      media: hantro: HEVC: Fix reference frames management
      media: hantro: HEVC: unconditionnaly set pps_{cb/cr}_qp_offset values

Bingbu Cao (1):
      media: ov8856: apply digital gain by setting global gain control regi=
ster

Bryan O'Donoghue (4):
      media: i2c: imx412: Fix reset GPIO polarity
      media: i2c: imx412: Fix power_off ordering
      media: dt-bindings: imx412: Add regulator descriptions
      media: i2c: imx412: Add bulk regulator support

Chen-Yu Tsai (2):
      media: hantro: Implement support for encoder commands
      media: hantro: Empty encoder capture buffers by default

Christophe JAILLET (1):
      media: aspeed: Fix an error handling path in aspeed_video_probe()

Christopher Obbard (1):
      media: dt-bindings: media: rockchip-vdec: Add RK3328 compatible

Colin Ian King (2):
      media: platform: samsung: remove redundant assignment to variable m
      media: gspca: make the read-only array table static const

Dan Carpenter (2):
      media: bdisp: remove unnecessary IS_ERR() check
      media: davinci: remove unnecessary NULL check

Daniel Scally (20):
      media: entity: Skip non-data links in graph iteration
      media: media.h: Add new media link type
      media: entity: Add link_type_name() helper
      media: entity: Add support for ancillary links
      media: v4l2-async: Create links during v4l2_async_match_notify()
      media: uapi: Add IPU3 packed Y10 format
      media: ipu3-cio2: Add support for V4L2_PIX_FMT_IPU3_Y10
      media: i2c: Add acpi support to ov7251
      media: i2c: Provide ov7251_check_hwcfg()
      media: i2c: Remove per-mode frequencies from ov7251
      media: i2c: Add ov7251_pll_configure()
      media: i2c: Add support for new frequencies to ov7251
      media: i2c: Add ov7251_detect_chip()
      media: i2c: Add pm_runtime support to ov7251
      media: i2c: Remove .s_power() from ov7251
      media: ipu3-cio2: Add INT347E to cio2-bridge
      media: i2c: Extend .get_selection() for ov7251
      media: i2c: add ov7251_init_ctrls()
      media: i2c: Add hblank control to ov7251
      media: i2c: Add vblank control to ov7251 driver

Dikshita Agarwal (2):
      media: v4l2-ctrls: Add intra-refresh type control
      media: venus: venc: Add support for intra-refresh type

Dongliang Mu (1):
      media: ov7670: remove ov7670_power_off from ov7670_remove

Dorota Czaplejewicz (1):
      media: Documentation/media: Remove incorrect statement

Eugen Hristev (9):
      media: atmel: atmel-isc-base: use streaming status when queueing buff=
ers
      media: atmel: atmel-isc-base: replace is_streaming call in s_fmt_vid_=
cap
      media: atmel: atmel-isc: remove redundant comments
      media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
      media: atmel: atmel-isc-base: use mutex to lock awb workq from stream=
ing
      media: atmel: atmel-isc: compact the controller formats list
      media: atmel: atmel-sama7g5-isc: remove stray line
      media: dt-bindings: media: microchip,xisc: add bus-width of 14
      media: atmel: microchip-csi2dc: add link validation support

Fabio Estevam (3):
      media: platform: imx-mipi-csis: Remove unneeded 'default n'
      media: platform: video-viu: Do not select it by default
      media: i2c: adv7180: Add support for the test patterns

Hangyu Hua (3):
      media: mc: delete redundant code in __media_device_unregister_entity
      media: uvcvideo: Fix bit overflow in uvc_probe_video
      media: rga: fix possible memory leak in rga_probe

Hans Verkuil (21):
      media: cec: call enable_adap on s_log_addrs
      media: cec: abort if the current transmit was canceled
      media: cec: correctly pass on reply results
      media: cec.h: add cec_msg_recv_is_rx/tx_result helpers
      media: cec: use call_op and check for !unregistered
      media: cec: add xfer_timeout_ms field
      media: cec: add optional adap_configured callback
      media: ext-ctrls-codec.rst: fix indentation
      media: v4l2-subdev.c: kvmalloc_array -> kvcalloc
      media: v4l2-ctls-core.c: kvmalloc_array -> kvcalloc
      media: videobuf2-dma-sg.c: kvmalloc_array -> kvcalloc
      media: cx25821: request_irq -> devm_request_irq
      media: ccs-core.c: fix failure to call clk_disable_unprepare
      media: s5k6a3: add missing clk_disable_unprepare
      media: cec-pin.c: disabling the adapter cannot call kthread_stop
      media: cec-pin.c: don't zero work_pin_num_events in adap_enable
      media: cec-adap.c: don't unconfigure if already unconfigured
      media: cec-adap.c: stop trying LAs on CEC_TX_STATUS_TIMEOUT
      media: cec-adap.c: fix is_configuring state
      media: cec-adap.c: reconfigure if the PA changes during configuration
      media: cec-adap.c: drop activate_cnt, use state info instead

Husni Faiz (2):
      media: av7110: fix switch indentation
      media: av7110: fix prohibited spaces in switch statement

Ian Jamison (1):
      media: media-entity.h: Fix documentation for media_create_intf_link

Jacopo Mondi (6):
      media: imx: imx-mipi-csis: Add support for JPEG_1X8
      media: i2c: ov5645: Fix media bus format
      media: imx: imx-mipi-csis: Simplify mipi_csis_s_stream()
      media: imx: imx-mipi-csis: Drop powered flag
      media: imx: imx-mipi-csis: Protect mipi_csis_dump_regs()
      media: i2c: rdacm20: Fix format definition

James_Lin (1):
      media: uvcvideo: Add UVC_GUID_FORMAT_H265

Jiapeng Chong (1):
      media: platform: Remove unused including <linux/version.h>

Jonas Karlman (5):
      media: rkvdec: h264: Fix bit depth wrap in pps packet
      media: rkvdec: h264: Validate and use pic width and height in mbs
      media: rkvdec: h264: Fix reference frame_num wrap for second field
      media: rkvdec: Ensure decoded resolution fit coded resolution
      media: hantro: h264: Make dpb entry management more robust

Jonathan Neusch=C3=A4fer (1):
      media: docs: media: uvcvideo: Use linux-media mailing list

Julia Lawall (1):
      media: i2c: ov5695: fix typos in comments

Kate Hsuan (2):
      media: staging: media: ipu3: Fix AF x_start position when rightmost s=
tripe is used
      media: staging: media: ipu3: Fix AWB x_start position when rightmost =
stripe is used

Kwang Son (1):
      media: docs: Fix vimc default pipeline graph

Kwanghoon Son (1):
      media: exynos4-is: Fix compile warning

Laurent Pinchart (14):
      media: v4l2-async: Use endpoints in __v4l2_async_nf_add_fwnode_remote=
()
      media: imx: imx-mipi-csis: Rename csi_state to mipi_csis_device
      media: imx: imx-mipi-csis: Don't use .s_power()
      media: imx: imx-mipi-csis: Drop unneeded system PM implementation
      media: imx: imx-mipi-csis: Don't stop streaming at runtime suspend ti=
me
      media: imx: imx-mipi-csis: Simplify runtime PM implementation
      media: imx: imx-mipi-csis: Fix active format initialization on source=
 pad
      media: v4l2: mem2mem: Fix typos in v4l2_m2m_dev documentation
      media: platform: renesas-ceu: Fix unused variable warning
      media: cadence: cdns-csi2tx: Use mipi-csi2.h
      media: rockchip: rkisp1: Use mipi-csi2.h
      media: videobuf2-v4l2: Expose vb2_queue_is_busy() to drivers
      media: vsp1: Don't open-code vb2_fop_release()
      media: vsp1: Use vb2_queue_is_busy()

Laurentiu Palcu (2):
      media: i2c: max9286: fix kernel oops when removing module
      media: i2c: rdacm2x: properly set subdev entity function

Luca Weiss (2):
      media: venus: hfi: Add error message for timeout error
      media: venus: hfi: avoid null dereference in deinit

Lukas Bulwahn (5):
      media: MAINTAINERS: rectify entry for MEDIA DRIVERS FOR NVIDIA TEGRA =
- VDE
      media: MAINTAINERS: refurbish MEDIATEK JPEG DRIVER section
      media: MAINTAINERS: rectify entry for MEDIATEK MEDIA DRIVER
      media: MAINTAINERS: drop unreachable contact for MEDIATEK JPEG DRIVER
      media: MAINTAINERS: adjust entries to nxp driver movement in media pl=
atform

Lv Ruyi (1):
      media: amphion: no need to check return value of debugfs_create funct=
ions

Masahiro Yamada (1):
      media: media.h: remove unneeded <stdint.h> inclusion

Mauro Carvalho Chehab (28):
      media: dvb-usb-ids.h: sort entries
      media: dvb-usb: move USB IDs to dvb-usb-ids.h
      media: dvb-usb: vp702x: reference to usb ID table
      media: dvb-usb: Add helper macros for using USB VID/PID
      media: dvb-usb: a800: use an enum for the device number
      media: af9005: use the newer dvb-usb macros for USB device
      media: dvb-usb: az6027: use an enum for the device number
      media: cinergyT2-core: use the newer dvb-usb macros for USB device
      media: cxusb: use the newer dvb-usb macros for USB device
      media: digitv: use the newer dvb-usb macros for USB device
      media: dvb-usb: dtt200u: use an enum for the device number
      media: dtv5100: use the newer dvb-usb macros for USB device
      media: dw2102: use the newer dvb-usb macros for USB device
      media: dvb-usb: gp8psk: use an enum for the device number
      media: dvb-usb: m920x: use an enum for the device number
      media: dvb-usb: nova-t-usb2: use an enum for the device number
      media: dvb-usb: opera1: use an enum for the device number
      media: dvb-usb: pctv452e: use an enum for the device number
      media: technisat-usb2: use the newer dvb-usb macros for USB device
      media: dvb-usb: ttusb2: use an enum for the device number
      media: dvb-usb: umt-010: use an enum for the device number
      media: dvb-usb: vp702x: use an enum for the device number
      media: dvb-usb: vp7045: use an enum for the device number
      media: dvb-usb: dibusb-mb: use an enum for the device number
      media: dvb-usb: dibusb-mc: use an enum for the device number
      media: dvb-usb: dib0700_devices: use an enum for the device number
      media: atomisp: don't pass a pointer to a local variable
      media: ov7251: fix mutex lock unbalance

Miaoqian Lin (4):
      media: exynos4-is: Fix PM disable depth imbalance in fimc_is_probe
      media: st-delta: Fix PM disable depth imbalance in delta_probe
      media: atmel: atmel-isc: Fix PM disable depth imbalance in atmel_isc_=
probe
      media: exynos4-is: Change clk_disable to clk_disable_unprepare

Michael Rodin (1):
      media: vsp1: Fix offset calculation for plane cropping

Mike Pagano (1):
      media: i2c: ov2640: Depend on V4L2_ASYNC

Ming Qian (16):
      media: imx-jpeg: Add pm-sleep support for imx-jpeg
      media: imx-jpeg: Correct the pixel format of rgb
      media: imx-jpeg: don't change byteused of queued buffer
      media: amphion: fix decoder's interlaced field
      media: imx-jpeg: Refactor function mxc_jpeg_parse
      media: imx-jpeg: Identify and handle precision correctly
      media: imx-jpeg: Propagate the output frame size to the capture side
      media: imx-jpeg: Handle source change in a function
      media: imx-jpeg: Support dynamic resolution change
      media: amphion: decoder copy timestamp from output to capture
      media: amphion: encoder copy timestamp from output to capture
      media: amphion: handle picture skipped event
      media: amphion: free ctrl handler if error is set and return error
      media: amphion: ensure the buffer count is not less than min_buffer
      media: amphion: wake up when error occurs
      media: amphion: G/S_PARM only for encoder's output queue

Mirela Rabulea (1):
      media: imx-jpeg: Fix potential array out of bounds in queue_setup

Moses Christopher Bollavarapu (5):
      media: ov7640: Use ARRAY_SIZE instead of manual checking
      media: i2c: video-i2c: Move defines to the top of the file
      media: i2c: video-i2c: Replace constants with proper names
      media: i2c: video-i2c: Use GENMASK for masking bits
      media: i2c: ov5645: Remove unneeded of_match_ptr macro

Nicolas Dufresne (20):
      media: coda: Fix reported H264 profile
      media: coda: Add more H264 levels for CODA960
      media: doc: Document dual use of H.264 pic_num/frame_num
      media: v4l2-mem2mem: Trace on implicit un-hold
      media: h264: Avoid wrapping long_term_frame_idx
      media: h264: Use v4l2_h264_reference for reflist
      media: h264: Increase reference lists size to 32
      media: h264: Store current picture fields
      media: h264: Store all fields into the unordered list
      media: v4l2: Trace calculated p/b0/b1 initial reflist
      media: h264: Sort p/b reflist using frame_num
      media: v4l2: Reorder field reflist
      media: rkvdec: Stop overclocking the decoder
      media: rkvdec: h264: Fix dpb_valid implementation
      media: rkvdec: Move H264 SPS validation in rkvdec-h264
      media: rkvdec-h264: Add field decoding support
      media: rkvdec: Enable capture buffer holding for H264
      media: hantro: Stop using H.264 parameter pic_num
      media: hantro: Add H.264 field decoding support
      media: hantro: Enable HOLD_CAPTURE_BUF for H.264

Niklas S=C3=B6derlund (2):
      media: rcar-vin: Add check that input interface and format are valid
      media: rcar-vin: Remove stray blank line

N=C3=ADcolas F. R. A. Prado (1):
      media: dt-bindings: mtk-vcodec-encoder: Add power-domains property

Oliver Neukum (3):
      media: imon: avoid needless atomic allocations in resume
      media: imon: fix timer racing disconnect
      media: imon: drop references only after device is no longer used

Pavel Skripkin (1):
      media: pvrusb2: fix array-index-out-of-bounds in pvr2_i2c_core_init

Philipp Zabel (12):
      media: video-mux: Use dev_err_probe()
      media: coda: disable encoder cmd ioctl on decoder and vice versa
      media: coda: disable encoder ioctls for decoder devices
      media: coda: disable stateful encoder ioctls for jpeg encoder
      media: coda: assert bitstream mutex is locked in coda_fill_bitstream
      media: coda: consolidate job_finish calls on decoder prepare_run fail=
ure
      media: coda: add JPEG downscale support
      media: coda: jpeg: set buffer error flag when header parsing fails
      media: coda: jpeg: improve header parse error message
      media: coda: jpeg: start streaming without valid header
      media: coda: fix default JPEG colorimetry
      media: coda: limit frame interval enumeration to supported encoder fr=
ame sizes

Piotr Oniszczuk (2):
      media: hantro: Add support for Hantro G1 on RK356x
      media: dt-bindings: media: rockchip-vpu: Add RK3568 compatible

Randy Dunlap (1):
      media: make RADIO_ADAPTERS tristate

Ricardo Ribalda (3):
      media: uvcvideo: Fix memory leak if uvc_ctrl_add_mapping fails
      media: uvcvideo: Simplify uvc_endpoint_max_bpi()
      media: uvcvideo: Undup use uvc_endpoint_max_bpi() code

Sakari Ailus (15):
      media: ccs: Use %u for printing unsigned values, remove extra debug p=
rint
      media: ccs: Use unsigned int as index to an array
      media: mc: Remove redundant documentation
      media: mc: media_device_init() initialises a media_device, not media_=
entity
      media: mc: Provide a helper for setting bus_info field
      media: mc: Set bus_info in media_device_init()
      media: v4l: ioctl: Set bus_info in v4l_querycap()
      media: staging: media: ipu3-imgu: Request specific firmware binary
      media: Revert "media: dw9768: activate runtime PM and turn off device"
      media: dt-bindings: Convert Dongwoon dw9807-vcm bindings to json-sche=
ma
      media: dw9807-vcm: Add "dongwoon,dw9807" compatible string
      media: Add bus type to frame descriptors
      media: Add CSI-2 bus configuration to frame descriptors
      media: Add MIPI CSI-2 28 bits per pixel raw data type
      media: Documentation: mc: Add media_device_{init,cleanup}

Sean Young (1):
      media: gpio-ir-tx: simplify wait logic

Sebastian Fricke (4):
      media: staging: media: hantro: Fix typos
      media: staging: media: hantro: Update TODO list
      media: staging: media: rkvdec: Update TODO list
      media: docs-rst: Append HEVC specific term

Stanimir Varbanov (6):
      media: v4l: Add Qualcomm custom compressed pixel formats
      media: venus: helpers: Add helper to check supported pixel formats
      media: venus: Add a handling of QC08C compressed format
      media: venus: hfi_platform: Correct supported compressed format
      media: venus: Add a handling of QC10C compressed format
      media: venus: vdec: Use output resolution on reconfigure

Tetsuo Handa (1):
      media: imon: reorganize serialization

Tom Rix (4):
      media: i2c: cleanup comments
      media: cec: seco: remove byte handling from smb_word_op
      media: platform: return early if the iface is not handled
      media: stkwebcam: move stk_camera_read_reg() scratch buffer to struct=
 stk_camera

Tomi Valkeinen (11):
      media: v4l2-subdev: fix #endif comments
      media: v4l2-subdev: drop extra #ifdef
      media: subdev: rename subdev-state alloc & free
      media: subdev: add active state to struct v4l2_subdev
      media: subdev: rename v4l2_subdev_get_pad_* helpers
      media: subdev: pass also the active state to subdevs from ioctls
      media: subdev: add subdev state locking
      media: subdev: add locking wrappers to subdev op wrappers
      media: subdev: add v4l2_subdev_get_fmt() helper function
      media: Documentation: add documentation about subdev state
      media: ti: cal: use frame desc to get vc and dt

Umang Jain (2):
      media: staging/intel-ipu3: Reset imgu_video_device sequence
      media: staging/intel-ipu3: Cleanup dummy buffers via helper

Uwe Kleine-K=C3=B6nig (1):
      media: i2c: dw9714: Return zero in remove callback

Vikash Garodia (2):
      media: venus: do not queue internal buffers from previous sequence
      media: venus: vdec: ensure venus is powered on during stream off

Wan Jiabing (1):
      media: saa7134: simplify if-if to if-else

Xiaomeng Tong (1):
      media: uvcvideo: Fix missing check to determine if element is found i=
n list

Xin Ji (2):
      media: media/v4l2-core: Add enum V4L2_FWNODE_BUS_TYPE_DPI
      media: dt-bindings: media: video-interfaces: Add new bus-type

Yan Lei (1):
      media: v4l2: fix uninitialized value tuner_status(CWE-457)

Yang Yingliang (4):
      media: dm355_ccdc: remove unnecessary check of res
      media: dm644x_ccdc: remove unnecessary check of res
      media: isif: remove unnecessary check of res
      media: i2c: ov5648: fix wrong pointer passed to IS_ERR() and PTR_ERR()

Yihao Han (1):
      media: meson-ir-tx: remove superfluous dev_err()

Yunfei Dong (21):
      media: mediatek: vcodec: Fix v4l2 compliance decoder cmd test fail
      media: mediatek: vcodec: Add vdec enable/disable hardware helpers
      media: mediatek: vcodec: Using firmware type to separate different fi=
rmware architecture
      media: mediatek: vcodec: get capture queue buffer size from scp
      media: mediatek: vcodec: Read max resolution from dec_capability
      media: mediatek: vcodec: set each plane bytesused in buf prepare
      media: mediatek: vcodec: Refactor get and put capture buffer flow
      media: mediatek: vcodec: Refactor supported vdec formats and framesiz=
es
      media: mediatek: vcodec: Getting supported decoder format types
      media: mediatek: vcodec: Add format to support MT21C
      media: mediatek: vcodec: disable vp8 4K capability
      media: mediatek: vcodec: Fix v4l2-compliance fail
      media: mediatek: vcodec: record capture queue format type
      media: mediatek: vcodec: Extract H264 common code
      media: mediatek: vcodec: support stateless H.264 decoding for mt8192
      media: mediatek: vcodec: support stateless VP8 decoding
      media: mediatek: vcodec: support stateless VP9 decoding
      media: mediatek: vcodec: prevent kernel crash when rmmod mtk-vcodec-d=
ec.ko
      media: dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings=
 for mt8186
      media: mediatek: vcodec: Support MT8186
      media: mediatek: vcodec: add h264 decoder driver for mt8186

Yunke Cao (1):
      media: entity: skip non-data link when removing reverse links

Zheyu Ma (3):
      media: i2c: dw9714: Disable the regulator when the driver fails to pr=
obe
      media: pci: cx23885: Fix the error handling in cx23885_initdev()
      media: cx25821: Fix the warning when removing the module

 Documentation/admin-guide/media/vimc.dot           |   14 +-
 .../bindings/media/i2c/dongwoon,dw9807-vcm.txt     |    9 -
 .../bindings/media/i2c/dongwoon,dw9807-vcm.yaml    |   41 +
 .../devicetree/bindings/media/i2c/sony,imx412.yaml |    9 +
 .../bindings/media/mediatek,vcodec-encoder.yaml    |    3 +
 .../media/mediatek,vcodec-subdev-decoder.yaml      |    4 +-
 .../devicetree/bindings/media/microchip,xisc.yaml  |    2 +-
 .../devicetree/bindings/media/rockchip,vdec.yaml   |    4 +-
 .../devicetree/bindings/media/rockchip-vpu.yaml    |    1 +
 .../bindings/media/video-interfaces.yaml           |    1 +
 Documentation/driver-api/media/cec-core.rst        |   13 +-
 Documentation/driver-api/media/mc-core.rst         |   13 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |   69 +
 .../userspace-api/media/drivers/uvcvideo.rst       |    2 +-
 .../media/mediactl/media-controller-model.rst      |    6 +
 .../userspace-api/media/mediactl/media-types.rst   |   17 +-
 .../userspace-api/media/v4l/dev-decoder.rst        |    9 +-
 .../media/v4l/ext-ctrls-codec-stateless.rst        |   10 +-
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |   22 +
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |   19 +
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst    |   14 +-
 .../userspace-api/media/v4l/vidioc-streamon.rst    |    3 +-
 MAINTAINERS                                        |   12 +-
 drivers/media/cec/core/cec-adap.c                  |  294 +--
 drivers/media/cec/core/cec-api.c                   |   24 +-
 drivers/media/cec/core/cec-core.c                  |   18 +-
 drivers/media/cec/core/cec-pin-priv.h              |   11 +
 drivers/media/cec/core/cec-pin.c                   |   72 +-
 drivers/media/cec/core/cec-priv.h                  |   10 +
 drivers/media/cec/platform/seco/seco-cec.c         |   22 +-
 drivers/media/common/saa7146/saa7146_video.c       |    1 -
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    3 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   26 +-
 drivers/media/i2c/Kconfig                          |    1 +
 drivers/media/i2c/adv7180.c                        |   46 +
 drivers/media/i2c/ccs/ccs-core.c                   |   43 +-
 drivers/media/i2c/dw9714.c                         |    2 +-
 drivers/media/i2c/dw9768.c                         |    6 -
 drivers/media/i2c/dw9807-vcm.c                     |    2 +
 drivers/media/i2c/imx412.c                         |   39 +-
 drivers/media/i2c/max9286.c                        |   19 +-
 drivers/media/i2c/ov5645.c                         |    8 +-
 drivers/media/i2c/ov5648.c                         |    4 +-
 drivers/media/i2c/ov5695.c                         |    2 +-
 drivers/media/i2c/ov7251.c                         |  750 +++++---
 drivers/media/i2c/ov7640.c                         |   33 +-
 drivers/media/i2c/ov7670.c                         |    1 -
 drivers/media/i2c/ov8856.c                         |   23 +-
 drivers/media/i2c/rdacm20.c                        |   10 +-
 drivers/media/i2c/rdacm21.c                        |    2 +-
 drivers/media/i2c/s5k6a3.c                         |    4 +-
 drivers/media/i2c/video-i2c.c                      |   61 +-
 drivers/media/mc/mc-device.c                       |   21 +-
 drivers/media/mc/mc-entity.c                       |   80 +-
 drivers/media/pci/bt8xx/bttv-driver.c              |    2 -
 drivers/media/pci/cx18/cx18-ioctl.c                |    2 -
 drivers/media/pci/cx23885/cx23885-core.c           |    6 +-
 drivers/media/pci/cx25821/cx25821-alsa.c           |    4 +-
 drivers/media/pci/cx25821/cx25821-core.c           |    2 +-
 drivers/media/pci/cx88/cx88-blackbird.c            |    1 -
 drivers/media/pci/cx88/cx88-video.c                |    1 -
 drivers/media/pci/dt3155/dt3155.c                  |    3 -
 drivers/media/pci/intel/ipu3/cio2-bridge.c         |    2 +
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   11 +-
 drivers/media/pci/ivtv/ivtv-ioctl.c                |    1 -
 drivers/media/pci/meye/meye.c                      |    1 -
 drivers/media/pci/saa7134/saa7134-video.c          |    4 +-
 drivers/media/pci/saa7164/saa7164-encoder.c        |    1 -
 drivers/media/pci/saa7164/saa7164-vbi.c            |    1 -
 drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c     |    3 -
 drivers/media/pci/solo6x10/solo6x10-v4l2.c         |    4 -
 drivers/media/pci/sta2x11/sta2x11_vip.c            |    4 -
 drivers/media/pci/tw5864/tw5864-video.c            |    1 -
 drivers/media/pci/tw68/tw68-video.c                |    3 -
 drivers/media/pci/tw686x/tw686x-video.c            |    2 -
 drivers/media/platform/allegro-dvt/allegro-core.c  |    5 -
 drivers/media/platform/amphion/vdec.c              |   84 +-
 drivers/media/platform/amphion/venc.c              |   59 +-
 drivers/media/platform/amphion/vpu_dbg.c           |   12 -
 drivers/media/platform/amphion/vpu_defs.h          |    2 +-
 drivers/media/platform/amphion/vpu_malone.c        |    4 +-
 drivers/media/platform/amphion/vpu_msgs.c          |    8 +
 drivers/media/platform/amphion/vpu_v4l2.c          |   68 +-
 drivers/media/platform/amphion/vpu_v4l2.h          |    3 +
 drivers/media/platform/aspeed/aspeed-video.c       |    4 +-
 drivers/media/platform/atmel/atmel-isc-base.c      |   34 +-
 drivers/media/platform/atmel/atmel-isc.h           |    8 +-
 drivers/media/platform/atmel/atmel-sama5d2-isc.c   |   58 +-
 drivers/media/platform/atmel/atmel-sama7g5-isc.c   |   61 +-
 drivers/media/platform/atmel/microchip-csi2dc.c    |    5 +
 drivers/media/platform/cadence/cdns-csi2tx.c       |    5 +-
 drivers/media/platform/chips-media/coda-bit.c      |    4 +-
 drivers/media/platform/chips-media/coda-common.c   |  155 +-
 drivers/media/platform/chips-media/coda-jpeg.c     |   24 +-
 drivers/media/platform/chips-media/coda.h          |    7 +
 drivers/media/platform/marvell/cafe-driver.c       |    1 -
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |    2 -
 drivers/media/platform/mediatek/vcodec/Kconfig     |    1 +
 drivers/media/platform/mediatek/vcodec/Makefile    |    4 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |   75 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.h      |    1 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |   15 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.c   |  166 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.h   |    6 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   19 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |  276 ++-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |   41 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |    5 -
 .../media/platform/mediatek/vcodec/mtk_vcodec_fw.c |    6 +
 .../media/platform/mediatek/vcodec/mtk_vcodec_fw.h |    1 +
 .../mediatek/vcodec/vdec/vdec_h264_req_common.c    |  323 ++++
 .../mediatek/vcodec/vdec/vdec_h264_req_common.h    |  277 +++
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c        |  447 +----
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |  808 ++++++++
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c         |  437 +++++
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     | 2030 ++++++++++++++++=
++++
 .../media/platform/mediatek/vcodec/vdec_drv_if.c   |   37 +-
 .../media/platform/mediatek/vcodec/vdec_drv_if.h   |    3 +
 .../media/platform/mediatek/vcodec/vdec_ipi_msg.h  |   36 +
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |    2 +
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |    2 +
 .../media/platform/mediatek/vcodec/vdec_vpu_if.c   |   53 +-
 .../media/platform/mediatek/vcodec/vdec_vpu_if.h   |   15 +
 .../media/platform/mediatek/vcodec/venc_vpu_if.c   |    2 +-
 drivers/media/platform/nvidia/tegra-vde/h264.c     |   19 +-
 drivers/media/platform/nxp/Kconfig                 |    2 -
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h  |    4 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  315 ++-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |    6 +-
 drivers/media/platform/nxp/imx-mipi-csis.c         |  669 ++++---
 drivers/media/platform/qcom/camss/camss-video.c    |    4 -
 drivers/media/platform/qcom/venus/core.h           |    1 +
 drivers/media/platform/qcom/venus/helpers.c        |   85 +-
 drivers/media/platform/qcom/venus/helpers.h        |    1 +
 drivers/media/platform/qcom/venus/hfi.c            |    3 +
 .../media/platform/qcom/venus/hfi_platform_v4.c    |    4 +-
 .../media/platform/qcom/venus/hfi_platform_v6.c    |    4 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |    4 +-
 drivers/media/platform/qcom/venus/vdec.c           |   37 +-
 drivers/media/platform/qcom/venus/venc.c           |    6 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |    8 +
 .../media/platform/renesas/rcar-vin/rcar-core.c    |    3 -
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |   25 +
 .../media/platform/renesas/rcar-vin/rcar-v4l2.c    |   13 +-
 drivers/media/platform/renesas/rcar_jpu.c          |    2 -
 drivers/media/platform/renesas/renesas-ceu.c       |    8 +-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |    2 -
 drivers/media/platform/renesas/vsp1/vsp1_entity.c  |   10 +-
 drivers/media/platform/renesas/vsp1/vsp1_histo.c   |    2 -
 drivers/media/platform/renesas/vsp1/vsp1_rpf.c     |    6 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |   16 +-
 drivers/media/platform/rockchip/rga/rga.c          |    6 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |   34 +-
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |   11 -
 .../media/platform/samsung/exynos-gsc/gsc-m2m.c    |    5 -
 drivers/media/platform/samsung/exynos4-is/common.c |    2 -
 .../media/platform/samsung/exynos4-is/fimc-is.c    |    6 +-
 .../platform/samsung/exynos4-is/fimc-isp-video.h   |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    4 -
 .../media/platform/samsung/s5p-jpeg/jpeg-core.c    |    2 -
 .../media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c  |    1 -
 .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.c   |    2 -
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.c   |    2 -
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c   |    3 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-common.h   |    1 -
 drivers/media/platform/st/sti/delta/delta-v4l2.c   |    6 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |    2 -
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    2 -
 .../media/platform/sunxi/sun4i-csi/sun4i_v4l2.c    |    4 -
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |    2 -
 drivers/media/platform/ti/cal/cal-camerarx.c       |   27 +
 drivers/media/platform/ti/cal/cal-video.c          |    4 -
 drivers/media/platform/ti/cal/cal.c                |   51 +-
 drivers/media/platform/ti/cal/cal.h                |    2 +
 drivers/media/platform/ti/davinci/dm355_ccdc.c     |    3 +-
 drivers/media/platform/ti/davinci/dm644x_ccdc.c    |    3 +-
 drivers/media/platform/ti/davinci/isif.c           |    3 +-
 drivers/media/platform/ti/davinci/vpbe_display.c   |    2 -
 drivers/media/platform/ti/davinci/vpif_capture.c   |    2 -
 drivers/media/platform/ti/davinci/vpif_display.c   |    5 +-
 drivers/media/platform/ti/omap3isp/ispcsiphy.c     |    3 +-
 drivers/media/platform/video-mux.c                 |    4 +-
 drivers/media/radio/Kconfig                        |    4 +-
 drivers/media/radio/radio-maxiradio.c              |    2 -
 drivers/media/rc/gpio-ir-tx.c                      |    7 +-
 drivers/media/rc/imon.c                            |  109 +-
 drivers/media/rc/meson-ir-tx.c                     |    4 +-
 drivers/media/usb/dvb-usb/a800.c                   |   18 +-
 drivers/media/usb/dvb-usb/af9005.c                 |   19 +-
 drivers/media/usb/dvb-usb/az6027.c                 |   45 +-
 drivers/media/usb/dvb-usb/cinergyT2-core.c         |   10 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |   88 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |  428 +++--
 drivers/media/usb/dvb-usb/dibusb-mb.c              |  165 +-
 drivers/media/usb/dvb-usb/dibusb-mc.c              |   88 +-
 drivers/media/usb/dvb-usb/digitv.c                 |   13 +-
 drivers/media/usb/dvb-usb/dtt200u.c                |   56 +-
 drivers/media/usb/dvb-usb/dtv5100.c                |   11 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |   84 +-
 drivers/media/usb/dvb-usb/gp8psk.c                 |   36 +-
 drivers/media/usb/dvb-usb/m920x.c                  |   51 +-
 drivers/media/usb/dvb-usb/nova-t-usb2.c            |   18 +-
 drivers/media/usb/dvb-usb/opera1.c                 |   15 +-
 drivers/media/usb/dvb-usb/pctv452e.c               |   22 +-
 drivers/media/usb/dvb-usb/technisat-usb2.c         |   11 +-
 drivers/media/usb/dvb-usb/ttusb2.c                 |   36 +-
 drivers/media/usb/dvb-usb/umt-010.c                |   18 +-
 drivers/media/usb/dvb-usb/vp702x.c                 |   23 +-
 drivers/media/usb/dvb-usb/vp7045.c                 |   28 +-
 drivers/media/usb/gspca/spca561.c                  |    2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |    7 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |   11 +-
 drivers/media/usb/stkwebcam/stk-webcam.h           |    2 +
 drivers/media/usb/uvc/uvc_ctrl.c                   |   10 +
 drivers/media/usb/uvc/uvc_driver.c                 |   11 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |   28 +-
 drivers/media/usb/uvc/uvc_video.c                  |   16 +-
 drivers/media/usb/uvc/uvcvideo.h                   |    4 +
 drivers/media/v4l2-core/tuner-core.c               |    4 +-
 drivers/media/v4l2-core/v4l2-async.c               |   33 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |    5 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |    9 +
 drivers/media/v4l2-core/v4l2-fwnode.c              |    4 +
 drivers/media/v4l2-core/v4l2-h264.c                |  275 ++-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    7 +
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    9 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |  219 ++-
 .../media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c |    4 +-
 drivers/staging/media/av7110/av7110_av.c           |   46 +-
 drivers/staging/media/hantro/TODO                  |    8 +-
 drivers/staging/media/hantro/hantro.h              |    2 +
 drivers/staging/media/hantro/hantro_drv.c          |   18 +-
 drivers/staging/media/hantro/hantro_g1_h264_dec.c  |   38 +-
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |   36 +-
 drivers/staging/media/hantro/hantro_g2_regs.h      |    6 +
 drivers/staging/media/hantro/hantro_h264.c         |  134 +-
 drivers/staging/media/hantro/hantro_hevc.c         |   46 +-
 drivers/staging/media/hantro/hantro_hw.h           |   21 +-
 drivers/staging/media/hantro/hantro_postproc.c     |   53 +-
 drivers/staging/media/hantro/hantro_v4l2.c         |  107 +-
 .../media/hantro/rockchip_vpu2_hw_h264_dec.c       |   98 +-
 drivers/staging/media/hantro/rockchip_vpu_hw.c     |   14 +
 drivers/staging/media/ipu3/ipu3-css-fw.c           |    4 +-
 drivers/staging/media/ipu3/ipu3-css-fw.h           |    4 +-
 drivers/staging/media/ipu3/ipu3-css-params.c       |   20 +
 drivers/staging/media/ipu3/ipu3-v4l2.c             |    1 +
 drivers/staging/media/ipu3/ipu3.c                  |   25 +-
 drivers/staging/media/rkvdec/TODO                  |    4 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c         |  157 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   35 +-
 drivers/staging/media/rkvdec/rkvdec.h              |    2 +
 drivers/staging/media/tegra-video/vi.c             |   10 +-
 include/linux/remoteproc/mtk_scp.h                 |    2 +
 include/media/cec.h                                |   14 +
 include/media/dvb-usb-ids.h                        |  632 +++---
 include/media/i2c/mt9t112.h                        |    2 +-
 include/media/i2c/wm8775.h                         |    2 +-
 include/media/media-device.h                       |   51 +-
 include/media/media-entity.h                       |   21 +-
 include/media/mipi-csi2.h                          |    1 +
 include/media/v4l2-fwnode.h                        |    2 +
 include/media/v4l2-h264.h                          |   31 +-
 include/media/v4l2-mediabus.h                      |    2 +
 include/media/v4l2-subdev.h                        |  279 ++-
 include/media/videobuf2-v4l2.h                     |   23 +-
 include/uapi/linux/cec.h                           |   20 +
 include/uapi/linux/media.h                         |    4 +-
 include/uapi/linux/v4l2-controls.h                 |    5 +
 include/uapi/linux/videodev2.h                     |    5 +-
 269 files changed, 9657 insertions(+), 3557 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw=
9807-vcm.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw=
9807-vcm.yaml
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_r=
eq_common.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_r=
eq_common.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_r=
eq_multi_if.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_re=
q_if.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_re=
q_lat_if.c

