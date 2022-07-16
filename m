Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1EF57701F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiGPQ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGPQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:27:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9A19C27;
        Sat, 16 Jul 2022 09:27:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so13962466ejb.6;
        Sat, 16 Jul 2022 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cSbRrDfyD8mYPyFsquOKcfKAo9CPxKk0tzLTj6gXbu8=;
        b=VWnrrSA6N7wFVb37K0MGiAtQM+2zxTcFCVlXwH1U4k+VMsEwYydOoKVKX8R1IKybt8
         MHCuloGkXE30Q5WhePls81BBC1quaZwvonHpU2VVYZZjNcPdf6zRmaMfQENE1yvGAzss
         pJxARwbMGopXL2u1tqs7dNKY+bPXn8Yz6GJdNwvIOE/M0xTLpR5QyjWDruXFo0CCYim3
         IhG4O/IeFFG1aKZ7vms4Z6oR4yzAvmcmltLBkvR2vb5+cjB1RfEb15kk9I32Ew04pDyp
         VuK5Xiz9lnDx8JHSFPFe4tEl/xYTd+lLRN54x8p+vbce7rsmETUt3Hr7d6bIUTq/QmrO
         Dr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cSbRrDfyD8mYPyFsquOKcfKAo9CPxKk0tzLTj6gXbu8=;
        b=DOW3Buz+qswxntqps6xjLWgYo4HWEHeYfhic+grFg2t6GETR+mSiGLs9ZGPuseL8fC
         9PlBzSdULBrliUNHDUkyPulayVZjXauKKTYdqzb+nJnR21SAo5J5gftKvf248RHh93dG
         zvlU3y0z66WHx44V+xhXVx8rfsyWXArgV4Y4/8ehTSFbvPqSPp5Z0OhGIUfUMS2/7ybr
         4r4FBRbA0690oQNN3b7/gpB5dbFDI7B7vZb0kFZaNRagdeI7c1UbwaZq2irRYU5qRjWg
         X8XYKIPFscPSomqd3fn8E3K+3KSk3uDjtlfMzBDP8va6wuzc1NreEYacifcz2CBJP9Ma
         qCRw==
X-Gm-Message-State: AJIora8n4D8S2HVUoXO5ecZFlVHlVeaj2zM+CxFR/bJUUNOUnQNEEZeS
        9R22RONtE1FwI+SBDNlQFA==
X-Google-Smtp-Source: AGRyM1sO+RTTsqXiQq2lPyGyiZ9eZ8LzALSjZIyOA/1vtvujTE316Nw3ewmqRDzxQxlt/ntLGEbmow==
X-Received: by 2002:a17:907:2807:b0:72b:4530:29d5 with SMTP id eb7-20020a170907280700b0072b453029d5mr19034629ejc.69.1657988839049;
        Sat, 16 Jul 2022 09:27:19 -0700 (PDT)
Received: from ?IPV6:2001:9e8:b948:1100:598c:2a19:1408:7aa7? ([2001:9e8:b948:1100:598c:2a19:1408:7aa7])
        by smtp.gmail.com with ESMTPSA id g21-20020a1709063b1500b00722dcb4629bsm3421014ejf.14.2022.07.16.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 09:27:18 -0700 (PDT)
Message-ID: <20685980-dc81-8fc9-d049-f393071feb20@gmail.com>
Date:   Sat, 16 Jul 2022 18:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] RkVDEC HEVC driver
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, kernel@collabora.com,
        bob.beckett@collabora.com, ezequiel@vanguardiasur.com.ar,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20220713162449.133738-1-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

thanks a lot for your work on upstreaming this driver.

See some general comments below.

> Implement the HEVC codec variation for the RkVDEC driver. Currently only
> the RK3399 is supported, but it is possible to enable the RK3288 as it
> also supports this codec.
>
> Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821cc6b8
> and the HEVC uABI MR by Benjamin Gaignard.
> (https://patchwork.linuxtv.org/project/linux-media/list/?series=8360)
>
> Tested with the GStreamer V4L2 HEVC plugin:
> (https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079)
>
> Current Fluster score:
> `Ran 131/147 tests successfully               in 278.568 secs`
> with
> `python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j1`
>
> failed conformance tests:
> - DBLK_D_VIXS_2 (Success on Hantro G2)
> - DSLICE_A_HHI_5 (Success on Hantro G2)
> - EXT_A_ericsson_4 (Success on Hantro G2)
> - PICSIZE_A_Bossen_1 (Hardware limitation)
> - PICSIZE_B_Bossen_1 (Hardware limitation)
> - PICSIZE_C_Bossen_1 (Hardware limitation)
> - PICSIZE_D_Bossen_1 (Hardware limitation)
> - PPS_A_qualcomm_7 (Success on Hantro G2)
> - SAODBLK_A_MainConcept_4 (Success on Hantro G2)
> - SAODBLK_B_MainConcept_4 (Success on Hantro G2)
> - SLIST_B_Sony_9 (Success on Hantro G2)
> - SLIST_D_Sony_9 (Success on Hantro G2)
> - TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
> - VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
> - WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
> - WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)
>
> Not tested with FFMpeg so far.
>
> Known issues:
> - Unable to reliably decode multiple videos concurrently
> - The SAODBLK_* tests timeout if the timeout time in fluster is lower than 120
> - Currently the uv_virstride is calculated in a manner that is hardcoded
> for the two available formats NV12 and NV15. (@config_registers)
>
> Notable design decisions:
> - I opted for a bitfield to represent the PPS memory blob as it is the
> perfect tool for that job. It describes the memory layout with any
> additional required documentation, is easy to read and a native language
> tool for that job
> - The RPS memory blob is created using a bitmap implementation, which
> uses a common Kernel API to avoid reinventing the wheel and to keep the
> code clean.
> - I deliberatly opted against the macro solution used in H264, which
> declares Macros in mid function and declares the fields of the memory
> blob as macros as well. And I would be glad to refactor the H264 code if
> desired by the maintainer to use common Kernel APIs and native language
> elements.

I fully disagree here: That way the code is much less 
read-/understandable - your are putting  bits at some random hardcoded 
positions with not relation to the codec/hardware and expect everyone to 
read and understand that huge docblock - the code should be more 
self-explaining and we should at least try to get rid of those hardcoded 
positions which, btw, will differ for newer versions of that hardware block.

I'm also not sure what makes you call that a "blob": It's configuration 
of the hardware which in that case isn't put in registers, but in memory.

> - The giant static array of cabac values is moved to a separate c file,
> I did so because a separate .h file would be incorrect as it doesn't
> expose anything of any value for any other file than the rkvdec-hevc.c
> file. Other options were:
>    - Calculating the values instead of storing the results (doesn't seem
>    to be worth it)

I'm not sure "not worth it" should be argument for not doing doing 
anything in general; especially not if it can explain the relation 
between the standard and this driver.

Looking at  tables of ITU-T Rec. H.265 "9.3.2.2 Initialization process 
for context variables" and comparing to the first elements of that huge 
array: It should be doable.

>    - Supply them via firmware (Adding firmware makes the whole software
>    way more complicated and the usage of the driver less obvious)
>
> Ignored Checkpatch warnings (as it fits to the current style of the file):
> ```
> WARNING: line length of 162 exceeds 100 columns
> #115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
> +               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
>
> ERROR: trailing statements should be on next line
> #128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
> +       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
> ```
>
> v4l2-compliance test:
> ```
> Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, Warnings: 0
> ```
>
> kselftest module run for the bitmap changes:
> ```
> $ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/test_bitmap.ko
> [   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 1750
> [   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
> [   71.751787] ', Time: 6708
> [   71.760373] test_bitmap: set_value: 6/6 tests correct
> ```
>
> Jonas Karlman (2):
>    media: v4l2: Add NV15 pixel format
>    media: v4l2-common: Add helpers to calculate bytesperline and
>      sizeimage
>
> Sebastian Fricke (4):
>    bitops: bitmap helper to set variable length values
>    staging: media: rkvdec: Add valid pixel format check
>    staging: media: rkvdec: Enable S_CTRL IOCTL
>    staging: media: rkvdec: Add HEVC backend
>
>   .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
>   drivers/media/v4l2-core/v4l2-common.c         |   79 +-
>   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>   drivers/staging/media/rkvdec/Makefile         |    2 +-
>   drivers/staging/media/rkvdec/TODO             |   22 +-
>   .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 +++++++++++++++++
>   drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
>   drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
>   drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
>   drivers/staging/media/rkvdec/rkvdec.h         |    3 +
>   include/linux/bitmap.h                        |   39 +
>   include/uapi/linux/videodev2.h                |    1 +
>   lib/test_bitmap.c                             |   47 +
>   13 files changed, 3066 insertions(+), 67 deletions(-)
>   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
>
Regards,

Alex

