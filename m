Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97D757D4A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiGUULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:11:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2A80505;
        Thu, 21 Jul 2022 13:11:13 -0700 (PDT)
Received: from localhost (dynamic-089-204-139-174.89.204.139.pool.telefonica.de [89.204.139.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DA4D6601AB7;
        Thu, 21 Jul 2022 21:11:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658434271;
        bh=HX74rMrwl3/mjXPznGGm+HnMToWpb+58tVMjKAe5Obo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBl1puqm+oV9S3qoM0YX4447q8xWbUkOuXfxWCSPfRlxx6p7f8A1sDDlhDG0Ligzl
         XhHyK2NJfvV9ZsG7TS2L6d28hz1N1XG/QpArLWgu8lD/27lJD9HRnQSiunWhMJmLFW
         1/+86a/qV9zJ9NfOEJYmqmnqhIcCfRcA+UNb42An5Vi9azZZZdPCbYxoJ8NkR17ujC
         Y/Dygi/9c3D8AhGtf9MwBBmZevB89GXR2lYrmf0pdRDy49ie+e6D2/3PZZsNNJa2Q4
         P9qLApAOlr4KhJZYm9IBBnzHKx+4XuuVEV3p77hmuDlFfPrWdcDsFN1yuSAH73eBnR
         9+0ACHLp6MHDg==
Date:   Thu, 21 Jul 2022 22:11:06 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/6] RkVDEC HEVC driver
Message-ID: <20220721201106.5a7keup2c6laymzk@basti-XPS-13-9310>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
 <7be996ee-9977-129b-08e2-12bde7ac9cd7@arm.com>
 <f05896551f8545af3c7352a6bd38248e038b61d2.camel@collabora.com>
 <20220721161609.zyhhg3smbusl6koz@basti-XPS-13-9310>
 <CAAEAJfB1JCrVTVBMs_kFnuM1NrUi=j5+N9WAi6N5PUH5L6tHfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEAJfB1JCrVTVBMs_kFnuM1NrUi=j5+N9WAi6N5PUH5L6tHfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ezequiel,

On 21.07.2022 13:18, Ezequiel Garcia wrote:
>On Thu, Jul 21, 2022 at 1:16 PM Sebastian Fricke
><sebastian.fricke@collabora.com> wrote:
>>
>> Hey Nicolas & Robin,
>>
>> Thanks for the feedback.
>>
>> On 15.07.2022 11:36, Nicolas Dufresne wrote:
>> >Le vendredi 15 juillet 2022 à 12:04 +0100, Robin Murphy a écrit :
>> >> On 2022-07-13 17:24, Sebastian Fricke wrote:
>> >> > Implement the HEVC codec variation for the RkVDEC driver. Currently only
>> >> > the RK3399 is supported, but it is possible to enable the RK3288 as it
>> >> > also supports this codec.
>> >> >
>> >> > Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821cc6b8
>> >> > and the HEVC uABI MR by Benjamin Gaignard.
>> >> > (https://patchwork.linuxtv.org/project/linux-media/list/?series=8360)
>> >> >
>> >> > Tested with the GStreamer V4L2 HEVC plugin:
>> >> > (https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079)
>> >> >
>> >> > Current Fluster score:
>> >> > `Ran 131/147 tests successfully               in 278.568 secs`
>> >> > with
>> >> > `python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j1`
>> >> >
>> >> > failed conformance tests:
>> >> > - DBLK_D_VIXS_2 (Success on Hantro G2)
>> >> > - DSLICE_A_HHI_5 (Success on Hantro G2)
>> >> > - EXT_A_ericsson_4 (Success on Hantro G2)
>> >> > - PICSIZE_A_Bossen_1 (Hardware limitation)
>> >> > - PICSIZE_B_Bossen_1 (Hardware limitation)
>> >> > - PICSIZE_C_Bossen_1 (Hardware limitation)
>> >> > - PICSIZE_D_Bossen_1 (Hardware limitation)
>> >> > - PPS_A_qualcomm_7 (Success on Hantro G2)
>> >> > - SAODBLK_A_MainConcept_4 (Success on Hantro G2)
>> >> > - SAODBLK_B_MainConcept_4 (Success on Hantro G2)
>> >> > - SLIST_B_Sony_9 (Success on Hantro G2)
>> >> > - SLIST_D_Sony_9 (Success on Hantro G2)
>> >> > - TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
>> >> > - VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
>> >> > - WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
>> >> > - WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)
>> >> >
>> >> > Not tested with FFMpeg so far.
>> >> >
>> >> > Known issues:
>> >> > - Unable to reliably decode multiple videos concurrently
>> >> > - The SAODBLK_* tests timeout if the timeout time in fluster is lower than 120
>> >> > - Currently the uv_virstride is calculated in a manner that is hardcoded
>> >> > for the two available formats NV12 and NV15. (@config_registers)
>> >> >
>> >> > Notable design decisions:
>> >> > - I opted for a bitfield to represent the PPS memory blob as it is the
>> >> > perfect tool for that job. It describes the memory layout with any
>> >> > additional required documentation, is easy to read and a native language
>> >> > tool for that job
>> >>
>> >> Can I point out how terrible an idea this is? The C language gives
>> >> virtually zero guarantee about how bitfields are actually represented in
>> >> memory. Platform ABIs (e.g. [1]) might nail things down a bit more, but
>> >> different platforms are free to make completely different choices so
>> >> portability still goes out the window. Even for a single platform,
>> >> different compilers (or at worst even different version of one compiler)
>> >> can still make incompatible choices e.g. WRT alignment of packed
>> >> members. Even if you narrow the scope as far as a specific version of
>> >> AArch64 GCC, I think this is still totally broken for big-endian.
>> >>
>> >> The fact that you've had to use nonsensical types to trick a compiler
>> >> into meeting your expectations should already be a clue to how fragile
>> >> this is in general.
>> >>
>> >> > - The RPS memory blob is created using a bitmap implementation, which
>> >> > uses a common Kernel API to avoid reinventing the wheel and to keep the
>> >> > code clean.
>> >>
>> >> Similarly, Linux bitmaps are designed for use as, well, bitmaps. Abusing
>> >> them as a data interchange format for bit-aligned numerical values is
>> >> far from "clean" semantically. And I'm pretty sure it's also broken for
>> >> big-endian.
>> >>
>> >> This kind of stuff may be standard practice in embedded development
>> >> where you're targeting a specific MCU with a specific toolchain, but I
>> >> don't believe it's suitable for upstream Linux. It would take pretty
>> >> much the same number of lines to use GENMASK definitions and bitfield.h
>> >> helpers to pack values into words which can then be written to memory in
>> >> a guaranteed format and endianness (certainly for the PPS; for the RPS
>> >> it may well end up a bit longer, but would be self-documenting and
>> >> certainly more readable than those loops). It mostly just means that for
>> >> any field which crosses a word boundary you'll end up with 2 definitions
>> >> and 2 assignments, which is hardly a problem (and in some ways more
>> >> honest about what's actually going on).
>> >
>> >Thanks for the feedback, in multimedia (unlike register programming), we don't
>> >really consider bitstreams as bitmap or bitfield. What we do really expect is to
>> >use bit writer helpers (and sometimes a bit reader though we try and avoid the
>> >second one in the  kernel). Its more of less a cursor (a bit position) into a
>> >memory that advance while writing. A bit writer should help protect against
>> >overflow too.
>> >
>> >When writing lets say a chain of 8 bits from a char, a proper helper is expected
>> >to be very explicit on the ordering (write_u8_le/be or something better worded).
>> >I would rather like to see all these blobs written this way personally then
>> >having a cleared buffer and writing using bit offsets.
>> >
>> >Perhaps I may suggest to start with implementing just that inside this driver?
>> >It isn't very hard, and then the implementation can be reduced later and shared
>> >later, with whatever exists without deviating from the intent of the existing
>> >API ? I do believe that having this in linux-media can be useful in the future.
>> >We will notably need to extend such a helper with multimedia specific coding
>> >technique (golomb, boolean coding, etc.) for use in stateless encoder drivers.
>>
>> I currently design a general bit-writer API to handle the mentioned
>> issues correctly. I'll post it as part of V2, due to my current workload
>> this will happen in 3 weeks at the earliest.
>>
>
>I wonder if this is really the correct approach.
>
>Introducing a new API and adding HEVC support at the same time,
>sounds like scope creep to me.
>
>How about you first introduce HEVC and then we move to the new API?
>A generic bit-writer API might really take a long time to get mainlined.

I'll do it that route then, I'll revert to the RPS & PPS handling as
found in the rkvdec-h264 codec variant and will post a 2nd series to
introduce a new generic bit-writer API and change the bit writing in all
applicable codec drivers.

>
>Thanks!
>Ezequiel

Greetings,
Sebastian
>
>> >
>> >Nicolas
>> >
>> >>
>> >> Thanks,
>> >> Robin.
>>
>> Greetings,
>> Sebastian
>>
>> >>
>> >> [1]
>> >> https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#bit-fields
>> >>
>> >> > - I deliberatly opted against the macro solution used in H264, which
>> >> > declares Macros in mid function and declares the fields of the memory
>> >> > blob as macros as well. And I would be glad to refactor the H264 code if
>> >> > desired by the maintainer to use common Kernel APIs and native language
>> >> > elements.
>> >> > - The giant static array of cabac values is moved to a separate c file,
>> >> > I did so because a separate .h file would be incorrect as it doesn't
>> >> > expose anything of any value for any other file than the rkvdec-hevc.c
>> >> > file. Other options were:
>> >> >    - Calculating the values instead of storing the results (doesn't seem
>> >> >    to be worth it)
>> >> >    - Supply them via firmware (Adding firmware makes the whole software
>> >> >    way more complicated and the usage of the driver less obvious)
>> >> >
>> >> > Ignored Checkpatch warnings (as it fits to the current style of the file):
>> >> > ```
>> >> > WARNING: line length of 162 exceeds 100 columns
>> >> > #115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
>> >> > +               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
>> >> >
>> >> > ERROR: trailing statements should be on next line
>> >> > #128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
>> >> > +       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
>> >> > ```
>> >> >
>> >> > v4l2-compliance test:
>> >> > ```
>> >> > Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, Warnings: 0
>> >> > ```
>> >> >
>> >> > kselftest module run for the bitmap changes:
>> >> > ```
>> >> > $ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/test_bitmap.ko
>> >> > [   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 1750
>> >> > [   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
>> >> > [   71.751787] ', Time: 6708
>> >> > [   71.760373] test_bitmap: set_value: 6/6 tests correct
>> >> > ```
>> >> >
>> >> > Jonas Karlman (2):
>> >> >    media: v4l2: Add NV15 pixel format
>> >> >    media: v4l2-common: Add helpers to calculate bytesperline and
>> >> >      sizeimage
>> >> >
>> >> > Sebastian Fricke (4):
>> >> >    bitops: bitmap helper to set variable length values
>> >> >    staging: media: rkvdec: Add valid pixel format check
>> >> >    staging: media: rkvdec: Enable S_CTRL IOCTL
>> >> >    staging: media: rkvdec: Add HEVC backend
>> >> >
>> >> >   .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
>> >> >   drivers/media/v4l2-core/v4l2-common.c         |   79 +-
>> >> >   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>> >> >   drivers/staging/media/rkvdec/Makefile         |    2 +-
>> >> >   drivers/staging/media/rkvdec/TODO             |   22 +-
>> >> >   .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 +++++++++++++++++
>> >> >   drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
>> >> >   drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
>> >> >   drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
>> >> >   drivers/staging/media/rkvdec/rkvdec.h         |    3 +
>> >> >   include/linux/bitmap.h                        |   39 +
>> >> >   include/uapi/linux/videodev2.h                |    1 +
>> >> >   lib/test_bitmap.c                             |   47 +
>> >> >   13 files changed, 3066 insertions(+), 67 deletions(-)
>> >> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>> >> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
>> >> >
>> >>
>> >
