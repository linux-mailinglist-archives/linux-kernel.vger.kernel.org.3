Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B450F0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiDZGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiDZGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A84140AD;
        Mon, 25 Apr 2022 23:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B5F61356;
        Tue, 26 Apr 2022 06:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2A5C385A0;
        Tue, 26 Apr 2022 06:30:15 +0000 (UTC)
Message-ID: <075dc19b-d7f5-3939-f736-766ed0aaad84@xs4all.nl>
Date:   Tue, 26 Apr 2022 08:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 0/6] staging: media: wave5: add wave5 codec driver
Content-Language: en-US
To:     Nas Chung <nas.chung@chipsnmedia.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dafna3@gmail.com" <dafna3@gmail.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "kiril.bicevski@collabora.com" <kiril.bicevski@collabora.com>,
        "lafley.kim" <lafley.kim@chipsnmedia.com>,
        Scott Woo <scott.woo@chipsnmedia.com>,
        "olivier.crete@collabora.com" <olivier.crete@collabora.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "daniel@0x0f.com" <daniel@0x0f.com>
References: <SL2P216MB1246AED88587FF94698653D9FBF89@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <SL2P216MB1246AED88587FF94698653D9FBF89@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nas,

On 25/04/2022 12:16, Nas Chung wrote:
> The wave5 codec is a stateful encoder/decoder.
> It is found on the J721S2 SoC, JH7100 SoC, ssd202d SoC. Etc..
> But current test report is based on J721S2 SoC.
> 
> The driver currently supports V4L2_PIX_FMT_HEVC, V4L2_PIX_FMT_H264.
> 
> This driver has so far been tested on J721S2 EVM board and pre-silicon FPGA.
> 
> Testing on J721S2 EVM board shows it working fine both decoder and encoder.
> The driver is successfully working with gstreamer v4l2 good-plugin without any modification.
> 
> Testing on FPGA also shows it working fine, though the FPGA uses polled interrupts and copied buffers between the host and it's on board RAM.
> 
> The wave5 driver will be updated to support various EXT_CTRL encoder interface.

Please note that for some unknown reason neither v6 nor v7 ever reached the
linux-media mailinglist. Can you try to repost, this time just to the mailinglist
and with a CC to me?

I have seen this problem before but it was never clear why linux-media would
reject it. If you have an alternative email address you can email from, then
you can try that as well.

> 
> v4l2-compliance tests from J721S2:
> 
> # v4l2-compliance -d0
> v4l2-compliance SHA: not available, 64 bits

You must compile v4l2-compliance from the v4l-utils git repo. You can tell because
the SHA will be shown. That way I can be certain you tested with the latest
v4l2-compliance.

> 
> Compliance test for vpu-dec device /dev/video0:
> 
> Driver Info:
>         Driver name      : vpu-dec
>         Card type        : vpu-dec
>         Bus info         : platform:vpu-dec
>         Driver version   : 5.10.100

5.10 is really quite old, is it possible to test with a newer kernel?

Regards,

	Hans

>         Capabilities     : 0x84204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>         Detected Stateful Decoder
> 
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
> 
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 2 Private Controls: 1
> 
> Format ioctls:
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK (Not Supported)
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK
>         test Scaling: OK
> 
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK
> 
> Buffer ioctls:
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
> 
> Total for vpu-dec device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0
> 
> # v4l2-compliance -d1
> v4l2-compliance SHA: not available, 64 bits
> 
> Compliance test for vpu-enc device /dev/video1:
> 
> Driver Info:
>         Driver name      : vpu-enc
>         Card type        : vpu-enc
>         Bus info         : platform:vpu-enc
>         Driver version   : 5.10.100
>         Capabilities     : 0x84204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04204000
>                 Video Memory-to-Memory Multiplanar
>                 Streaming
>                 Extended Pix Format
>         Detected Stateful Encoder
> 
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
>         test second /dev/video1 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
> 
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 15 Private Controls: 0
> 
> Format ioctls:
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>                 warn: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-formats.cpp(1320): S_PARM is supported for buftype 2, but not for ENUM_FRAMEINTERVALS
>                 warn: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-formats.cpp(1320): S_PARM is supported for buftype 10, but not for ENUM_FRAMEINTERVALS
>         test VIDIOC_G/S_PARM: OK
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK
>         test Composing: OK (Not Supported)
>         test Scaling: OK
> 
> Codec ioctls:
>         test VIDIOC_(TRY_)ENCODER_CMD: OK
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
> 
> Total for vpu-enc device /dev/video1: 44, Succeeded: 44, Failed: 0, Warnings: 2
> 
> changes since v6:
> 
> * update TODO file
> * get sram info from device tree
> 
> changes since v5:
> 
> * support NV12/NV21 pixelformat for encoder and decoder
> * handle adnormal exit and EOS
> 
> changes since v4:
> 
> * refactor functions in wave5-hw and fix bug reported by Daniel Palmer
> * rename functions and variables to better names
> * change variable types such as replacing s32 with u32 and int with bool as appropriate
> 
> changes since v3:
> 
> * Fixing all issues commented by Dan Carpenter
> * Change file names to have wave5- prefix
> * In wave5_vpu_probe, enable the clocks before reading registers, as commented from Daniel Palmer
> * Add more to the TODO list,
> 
> changes since v2:
> 
> Main fixes includes:
> * change the yaml and dirver code to support up to 4 clks (instead of one)
> * fix Kconfig format
> * remove unneeded cast,
> * change var types
> * change var names, func names
> * checkpatch fixes
> 
> changes since v1:
> 
> Fix chanes due to comments from Ezequiel and Dan Carpenter. Main fixes inclueds:
> * move all files to one dir 'wave5'
> * replace private error codes with standart error codes
> * fix extra spaces
> * various checkpatch fixes
> * replace private 'DPRINTK' macro with standart 'dev_err/dbg ..'
> * fix error handling
> * add more possible fixes to the TODO file
> 
> 
> Dafna Hirschfeld (1):
>   staging: media: wave5: Add the vdi layer
> 
> Nas Chung (3):
>   staging: media: wave5: Add vpuapi layer
>   staging: media: wave5: Add the v4l2 layer
>   staging: media: wave5: Add TODO file
> 
> Robert Beckett (2):
>   dt-bindings: media: staging: wave5: add yaml devicetree bindings
>   media: wave5: Add wave5 driver to maintainers file
> 
>  .../bindings/staging/media/cnm,wave.yaml      |   73 +
>  MAINTAINERS                                   |    9 +
>  drivers/staging/media/Kconfig                 |    2 +
>  drivers/staging/media/Makefile                |    1 +
>  drivers/staging/media/wave5/Kconfig           |   12 +
>  drivers/staging/media/wave5/Makefile          |   10 +
>  drivers/staging/media/wave5/TODO              |   34 +
>  drivers/staging/media/wave5/wave5-hw.c        | 3405 +++++++++++++++++
>  drivers/staging/media/wave5/wave5-regdefine.h |  655 ++++
>  drivers/staging/media/wave5/wave5-vdi.c       |  260 ++
>  drivers/staging/media/wave5/wave5-vdi.h       |   81 +
>  drivers/staging/media/wave5/wave5-vpu-dec.c   | 1385 +++++++
>  drivers/staging/media/wave5/wave5-vpu-enc.c   | 1532 ++++++++
>  drivers/staging/media/wave5/wave5-vpu.c       |  381 ++
>  drivers/staging/media/wave5/wave5-vpu.h       |   73 +
>  drivers/staging/media/wave5/wave5-vpuapi.c    | 1049 +++++
>  drivers/staging/media/wave5/wave5-vpuapi.h    | 1144 ++++++
>  drivers/staging/media/wave5/wave5-vpuconfig.h |   91 +
>  drivers/staging/media/wave5/wave5-vpuerror.h  |  455 +++
>  drivers/staging/media/wave5/wave5.h           |   82 +
>  20 files changed, 10734 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
>  create mode 100644 drivers/staging/media/wave5/Kconfig
>  create mode 100644 drivers/staging/media/wave5/Makefile
>  create mode 100644 drivers/staging/media/wave5/TODO
>  create mode 100644 drivers/staging/media/wave5/wave5-hw.c
>  create mode 100644 drivers/staging/media/wave5/wave5-regdefine.h
>  create mode 100644 drivers/staging/media/wave5/wave5-vdi.c
>  create mode 100644 drivers/staging/media/wave5/wave5-vdi.h
>  create mode 100644 drivers/staging/media/wave5/wave5-vpu-dec.c
>  create mode 100644 drivers/staging/media/wave5/wave5-vpu-enc.c
>  create mode 100644 drivers/staging/media/wave5/wave5-vpu.c
>  create mode 100644 drivers/staging/media/wave5/wave5-vpu.h
>  create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.c
>  create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.h
>  create mode 100644 drivers/staging/media/wave5/wave5-vpuconfig.h
>  create mode 100644 drivers/staging/media/wave5/wave5-vpuerror.h
>  create mode 100644 drivers/staging/media/wave5/wave5.h
> 

