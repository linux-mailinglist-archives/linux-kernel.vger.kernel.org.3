Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA44B6D52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiBONZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiBONZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:25:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10C106626;
        Tue, 15 Feb 2022 05:24:50 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c] (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EB6CD1F449A4;
        Tue, 15 Feb 2022 13:24:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644931489;
        bh=hF6RqNWPIf6kemqF5dvkZw9bQuC7lSX855MH4lfmnI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ynv4ugpYO8nS/XAc1LO/PNI6/X8naU88NxgCSMuCMfcW5WhDUUNzk/s6NxUFUlYXS
         E2qAjk04bZxDB1IGwEX5xSi4s9CIJ+7LWrV40qpWnJoY9NlS8lpH2A0gBOfV4JHLXy
         EHFA2fQ2Slzl3EfMeUncZg3uXbi/IYmySyhIeHOmZUhhkQqPRM22FYYWSt1TXzutOY
         czQlq6DowoA5V96r/0qNlj0hl2XvGhhtlzLQNQNgTGoSQGHSyZ9Yewfsxf/Nwcla3+
         PvFFgZEiJJkC938tFysoeo/5gttb4+hIOnORwwcKMZFS02fyl9dwSPBKbZj7W48vu2
         ApMe2dfr+omnw==
Message-ID: <d9f1923a-dfca-0b3a-bfd6-2d1144f9bcd1@collabora.com>
Date:   Tue, 15 Feb 2022 14:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v2 0/8] Move HEVC stateless controls out of staging
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
 <20220215130121.4ekixb457ot6zaqi@basti-XPS-13-9310>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220215130121.4ekixb457ot6zaqi@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15/02/2022 à 14:01, Sebastian Fricke a écrit :
> Hey Benjamin,
>
> On 15.02.2022 12:00, Benjamin Gaignard wrote:
>> This series aims to make HEVC uapi stable and usable for hardware
>> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>> and 2 out of the tree drivers (rkvdec and RPI).
>
> Why is rkvdec out-of-tree? It is in the staging directory just like
> hantro and cedrus? Am I missing something here?

I have made a shortcut here: HEVC part of rkvdec isn't in staging directory.
I hope that this series will enough to add it after.

Regards,
Benjamin

>
> Greetings,
> Sebastian
>
>>
>> The 3 first patches are from Hans to implement v4l2 dynamic control
>> feature which is need by patch 7 for 
>> V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET
>> definition.
>>
>> Patch 4 move the existing uapi to stable, including definitions renaming
>> and CID number change to fit with v4l2 naming.
>>
>> Patches 5 and 7 add fields needed for rkvdec and RPI decoders.
>>
>> Patches 6 is cleaning up the uapi of useless field.
>> Patches 8 change one field description and name to define offset by
>> bytes rather than by bits
>>
>> Benjamin
>>
>> Benjamin Gaignard (5):
>>  media: uapi: Move HEVC stateless controls out of staging
>>  media: uapi: Add fields needed for RKVDEC driver
>>  media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
>>  media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
>>  media: uapi: Change data_bit_offset definition
>>
>> Hans Verkuil (3):
>>  videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>>  v4l2-ctrls: add support for dynamically allocated arrays.
>>  vivid: add dynamic array test control
>>
>> .../userspace-api/media/drivers/hantro.rst    |   5 -
>> .../media/v4l/ext-ctrls-codec.rst             |  58 ++--
>> .../media/v4l/vidioc-queryctrl.rst            |   8 +
>> .../media/test-drivers/vivid/vivid-ctrls.c    |  15 ++
>> drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++++++--
>> drivers/media/v4l2-core/v4l2-ctrls-core.c     | 182 ++++++++++---
>> drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +--
>> drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>> drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>> drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>> drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>> drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>> .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>> .../staging/media/sunxi/cedrus/cedrus_h265.c  |  13 +-
>> include/linux/hantro-media.h                  |  17 ++
>> include/media/hevc-ctrls.h                    | 250 ------------------
>> include/media/v4l2-ctrls.h                    |  48 +++-
>> include/uapi/linux/v4l2-controls.h            | 224 ++++++++++++++++
>> include/uapi/linux/videodev2.h                |   8 +
>> 19 files changed, 640 insertions(+), 408 deletions(-)
>> create mode 100644 include/linux/hantro-media.h
>> delete mode 100644 include/media/hevc-ctrls.h
>>
>> -- 
>> 2.32.0
>>
