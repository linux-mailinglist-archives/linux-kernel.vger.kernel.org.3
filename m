Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136B4BF32F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBVIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:09:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BED14FBE4;
        Tue, 22 Feb 2022 00:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4A2612D3;
        Tue, 22 Feb 2022 08:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B342EC340E8;
        Tue, 22 Feb 2022 08:09:17 +0000 (UTC)
Message-ID: <0085d6c8-d3aa-7a5f-2dd8-c671b90d1594@xs4all.nl>
Date:   Tue, 22 Feb 2022 09:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v16 00/13] amphion video decoder/encoder driver
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1645422822.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming Qian,

I had hoped to merge this series, but I got a whole bunch of sparse/smatch
warnings that need to be fixed first:

sparse: ERRORS
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.c:204:22: warning: symbol 'imx8qxp_res' was not declared. Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_drv.c:213:22: warning: symbol 'imx8qm_res' was not declared. Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:64:27: warning: incorrect type in argument 1 (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:555:23: warning: incorrect type in assignment (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:556:24: warning: incorrect type in assignment (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:557:28: warning: incorrect type in argument 1 (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:693:25: warning: incorrect type in argument 1 (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_core.c:694:26: warning: incorrect type in argument 1 (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c:401:17: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c:556:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c:640:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cmds.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cmds.c:285:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cmds.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_cmds.c:287:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_rpc.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_rpc.c:167:22: warning: symbol 'imx8q_rpc_ops' was not declared. Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:46:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:59:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:71:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:76:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:94:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:106:17: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:111:17: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:118:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:143:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:148:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:154:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:164:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_msgs.c:169:24: warning: symbol 'handlers' was not declared. Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_malone.c /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_malone.c:470:32: warning: incorrect type in assignment (different address spaces)
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:1093:9: error: incompatible types in conditional expression (different base types):
SPARSE:/home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:1098:9: error: incompatible types in conditional expression (different base types):


smatch: WARNINGS
/home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vpu_v4l2.c:599 vpu_v4l2_open() warn: passing zero to 'PTR_ERR'
/home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/venc.c:422 venc_drain() warn: variable dereferenced before check 'inst' (see line 419)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:195 vdec_handle_resolution_change() warn: variable dereferenced before check 'inst' (see line 192)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:337 vdec_s_fmt_common() warn: variable dereferenced before check 'inst' (see line 334)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:470 vdec_drain() warn: variable dereferenced before check 'inst' (see line 468)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:735 vdec_check_source_change() warn: variable dereferenced before check 'inst' (see line 731)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:1239 vdec_process_output() warn: variable dereferenced before check 'inst' (see line 1228)
/home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c: /home/hans/work/build/media-git/drivers/media/platform/amphion/vdec.c:1287 vdec_process_capture() warn: variable dereferenced before check 'inst' (see line 1283)

So a v17 is needed.

Regards,

	Hans

On 2/21/22 07:10, Ming Qian wrote:
> Hi all,
> 
> This patch series adds support for
> the amphion video encoder and decoder
> via the VPU block present in imx8q platforms.
> Currently, support for IMX8QXP and IMX8QM is included.
> 
> It features decoding for the following formats:
> - H.264
> - HEVC
> - MPEG4
> - MPEG2
> - VC1
> - VP8
> 
> It features encoding for the following formats:
> - H.264
> 
> The driver creates a separate device node for the encoder and decoder.
> 
> This driver is dependent on vpu firmwares.
> The firmwares have been submitted to linux-firmware.
> The commit is 6342082c115e76ab5efe3f93c4c1ac6d01a3c7d0:
> linux-firmware: Amphion: Add VPU firmwares for NXP i.MX8Q SoCs
> (Wed Jan 26 13:48:05 2022 +0800)
> 
> You can get the firmware from <linux-firmware>/amphion/vpu
> 
> encoder is tested with gstreamer
> decoder is tested with gstreamer, but the following patches are required:
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1379
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1381
> 
> 
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
> 
> Changelog:
> 
> v16
> - fix some devicetree issues reported by shawnguo
> 
> v15.1
> - include linux/vmalloc.h to avoid build warning by kernel test robot
> - add entry in MAINTAINERS alphabetically
> 
> v15
> - fix issues detected by "checkpatch.pl --strict"
> - encoder add ctrl V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE
> 
> v14
> - fix some errors according to Hans's comments
> 
> v13
> - make a workaround that avoid firmware entering wfi wrongly
> 
> v12
> - support reset decoder when starting a new stream
> - don't append an empty last buffer, set last_buffer_dequeued
> - improve the resolution change flow
> - return all buffers if start_streaming fail
> - fill encoder capture buffer's filed to none
> - fix a bug in calculating bytesperline
> 
> v11
> - fix dt_binding_check error after upgrade dtschema
> - remove "default y"
> - add media device
> 
> v10
> - refine vpu log, remove custom logging infrastructure
> - support non contiguous planes format nv12m instead of nv12
> - rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
> - rename V4L2_PIX_FMT_NV12_10BE_8L128 to V4L2_PIX_FMT_NV12MT_10BE_8L128
> - merge two module into one
> - fix kernel panic in rmmod
> 
> v9
> - drop V4L2_BUF_FLAG_CODECCONFIG
> - drop V4L2_EVENT_CODEC_ERROR
> - drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
> - fix some build warnings with W=1 reported by kernel test robot
> 
> v8
> - move driver from driver/media/platform/imx/vpu-8q to
>   driver/media/platform/amphion
> - rename driver name to amphion
> - remove imx_vpu.h
> - move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
> - move the definition of V4L2_EVENT_SKIP to videodev2.h
> 
> v7
> - fix build warnings with W=1 reported by kernel test robot
> 
> v6:
> - rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
> - rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128
> 
> v5:
> - move some definition from imx_vph.h to videodev2.h
> - remove some unnecessary content
> - add some documentation descriptions
> - pass the lateset v4l2-compliance test
> 
> v4:
> - redefine the memory-region in devicetree bindings documentation
> - use v4l2's mechanism to implement synchronize queuing ioctl
> - remove the unnecessary mutex ioctl_sync
> - don't notify source change event if the parameters are same as previously established
> - add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format
> 
> v3:
> - don't make vpu device node a simple-bus
> - trigger probing vpu core in the driver
> - remove unnecessary vpu core index property
> 
> v2:
> - fix dt bindings build error
> - split driver patch into several parts to avoid exceeding bytes limit
> 
> Compliance
> ==========
> # v4l2-compliance -d /dev/video0
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/video0:
> 
> Driver Info:
> 	Driver name      : amphion-vpu
> 	Card type        : amphion vpu decoder
> 	Bus info         : platform: amphion-vpu
> 	Driver version   : 5.15.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateful Decoder
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> Interface Info:
> 	ID               : 0x0300000c
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000001 (1)
> 	Name             : amphion-vpu-decoder-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000002   : 0: Source
> 	  Link 0x02000008: to remote pad 0x1000004 of entity 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 3 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d /dev/video1
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/video1:
> 
> Driver Info:
> 	Driver name      : amphion-vpu
> 	Card type        : amphion vpu encoder
> 	Bus info         : platform: amphion-vpu
> 	Driver version   : 5.15.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateful Encoder
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> Interface Info:
> 	ID               : 0x0300001a
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x0000000f (15)
> 	Name             : amphion-vpu-encoder-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000010   : 0: Source
> 	  Link 0x02000016: to remote pad 0x1000012 of entity 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video1 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 20 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK (Not Supported)
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d /dev/media0
> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 493af03f3c57 2021-10-08 17:23:11
> 
> Compliance test for amphion-vpu device /dev/media0:
> 
> Media Driver Info:
> 	Driver name      : amphion-vpu
> 	Model            : amphion-vpu
> 	Serial           :
> 	Bus info         : platform: amphion-vpu
> 	Media version    : 5.15.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.15.0
> 
> Required ioctls:
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/media0 open: OK
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 	test for unlimited opens: OK
> 
> Media Controller ioctls:
> 	test MEDIA_IOC_G_TOPOLOGY: OK
> 	Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> 	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> 	test MEDIA_IOC_SETUP_LINK: OK
> 
> Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
> 
> Ming Qian (13):
>   dt-bindings: media: amphion: add amphion video codec bindings
>   media: add nv12m_8l128 and nv12m_10be_8l128 video format.
>   media: amphion: add amphion vpu device driver
>   media: amphion: add vpu core driver
>   media: amphion: implement vpu core communication based on mailbox
>   media: amphion: add vpu v4l2 m2m support
>   media: amphion: add v4l2 m2m vpu encoder stateful driver
>   media: amphion: add v4l2 m2m vpu decoder stateful driver
>   media: amphion: implement windsor encoder rpc interface
>   media: amphion: implement malone decoder rpc interface
>   arm64: dts: freescale: imx8q: add imx vpu codec entries
>   firmware: imx: scu-pd: imx8q: add vpu mu resources
>   MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
> 
>  .../bindings/media/amphion,vpu.yaml           |  180 ++
>  .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
>  MAINTAINERS                                   |    9 +
>  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   73 +
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   25 +
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/firmware/imx/scu-pd.c                 |    4 +
>  drivers/media/platform/Kconfig                |   19 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/amphion/Makefile       |   20 +
>  drivers/media/platform/amphion/vdec.c         | 1695 +++++++++++++++++
>  drivers/media/platform/amphion/venc.c         | 1365 +++++++++++++
>  drivers/media/platform/amphion/vpu.h          |  356 ++++
>  drivers/media/platform/amphion/vpu_cmds.c     |  436 +++++
>  drivers/media/platform/amphion/vpu_cmds.h     |   25 +
>  drivers/media/platform/amphion/vpu_codec.h    |   68 +
>  drivers/media/platform/amphion/vpu_color.c    |  183 ++
>  drivers/media/platform/amphion/vpu_core.c     |  871 +++++++++
>  drivers/media/platform/amphion/vpu_core.h     |   15 +
>  drivers/media/platform/amphion/vpu_dbg.c      |  495 +++++
>  drivers/media/platform/amphion/vpu_defs.h     |  187 ++
>  drivers/media/platform/amphion/vpu_drv.c      |  260 +++
>  drivers/media/platform/amphion/vpu_helpers.c  |  413 ++++
>  drivers/media/platform/amphion/vpu_helpers.h  |   74 +
>  drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
>  drivers/media/platform/amphion/vpu_imx8q.h    |  115 ++
>  drivers/media/platform/amphion/vpu_malone.c   | 1625 ++++++++++++++++
>  drivers/media/platform/amphion/vpu_malone.h   |   44 +
>  drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
>  drivers/media/platform/amphion/vpu_mbox.h     |   16 +
>  drivers/media/platform/amphion/vpu_msgs.c     |  385 ++++
>  drivers/media/platform/amphion/vpu_msgs.h     |   14 +
>  drivers/media/platform/amphion/vpu_rpc.c      |  257 +++
>  drivers/media/platform/amphion/vpu_rpc.h      |  456 +++++
>  drivers/media/platform/amphion/vpu_v4l2.c     |  720 +++++++
>  drivers/media/platform/amphion/vpu_v4l2.h     |   55 +
>  drivers/media/platform/amphion/vpu_windsor.c  | 1169 ++++++++++++
>  drivers/media/platform/amphion/vpu_windsor.h  |   37 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
>  include/uapi/linux/videodev2.h                |    2 +
>  41 files changed, 12111 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
>  create mode 100644 drivers/media/platform/amphion/Makefile
>  create mode 100644 drivers/media/platform/amphion/vdec.c
>  create mode 100644 drivers/media/platform/amphion/venc.c
>  create mode 100644 drivers/media/platform/amphion/vpu.h
>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
>  create mode 100644 drivers/media/platform/amphion/vpu_codec.h
>  create mode 100644 drivers/media/platform/amphion/vpu_color.c
>  create mode 100644 drivers/media/platform/amphion/vpu_core.c
>  create mode 100644 drivers/media/platform/amphion/vpu_core.h
>  create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
>  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
>  create mode 100644 drivers/media/platform/amphion/vpu_malone.c
>  create mode 100644 drivers/media/platform/amphion/vpu_malone.h
>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.h
> 
> 
> base-commit: 127efdbc51fe6064336c0452ce9c910b3e107cf0
