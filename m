Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E504C6711
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiB1KZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiB1KZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:25:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1B4BFDA;
        Mon, 28 Feb 2022 02:24:55 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:82d4:230a:70ff:cde0] (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BDB6F1F4381D;
        Mon, 28 Feb 2022 10:24:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646043894;
        bh=kA6wk9poQowj7pG8o/AcE0UkJDbBr/dkYvIeNp0XXWg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JhADHZpx2XchL7wRFhLx9u5AdEFzJyh4R4y2hmB/LFpilBHi0RF9NmQCSkY/Z3Fcg
         0viETfCyEKPIArjmwBA1drhd9DWUsjnHqdUdd1728mdY551ARSdD0yvKV36gOW1g9x
         z4dlhpdZa5dyhfT3QxFgbM9HpaJ8dGkgaVeGAOCP8reZLiphJKiaZfANLEPFMD2dAr
         W43+yfakSqTqkNYemMpsvKxZRdIOGqTyK2FozsbDTjGGzWgudE3xSmhut/0ObtQerK
         406AutADF3dKoEc16xMoiMQuVIDRILtR00w1hiSXLEsAGo7qxZ9GAhtWghaOLOLE70
         MlGDuKiKBqBDg==
Message-ID: <14bd4748-1b73-c102-e98f-933efa34cd3c@collabora.com>
Date:   Mon, 28 Feb 2022 11:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/14] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Content-Language: en-US
To:     John Cox <jc@kynesim.co.uk>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
 <4378293.LvFx2qVVIh@kista> <1884298.PYKUYFuaPT@kista>
 <7348885.EvYhyI6sBW@kista> <me5p1hpnrarnqqaefoofrtqb898afl0rsn@4ax.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <me5p1hpnrarnqqaefoofrtqb898afl0rsn@4ax.com>
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


Le 28/02/2022 à 10:47, John Cox a écrit :
> On Sat, 26 Feb 2022 19:17:46 +0100, you wrote:
>
>> Dne sobota, 26. februar 2022 ob 18:59:18 CET je Jernej Škrabec napisal(a):
>>> Hi!
>>>
>>> Dne petek, 25. februar 2022 ob 20:30:20 CET je Jernej Škrabec napisal(a):
>>>> Hi!
>>>>
>>>> Dne petek, 25. februar 2022 ob 17:45:55 CET je Benjamin Gaignard
>> napisal(a):
>>>>> The number of 'entry point offset' could be very variable.
>>>>> Rather than use a large static array define a v4l2 dynamic array
>>>>> of integer control.
>>>> I suggest we should be more specific and say U32 (V4L2_CTRL_TYPE_U32).
>>>>
>>>>> The number of entry point offsets is reported by the elems field.
>>> I did few more tests and these are my findings:
>>> 1. dynamic array can't be set over size, specified in .dims array
>>> 2. entry point offsets are per slice, so if we make slices dynamic array,
>> then
>>> entry points would become two dimensional dynamic array
>>> 3. num_entry_point_offsets must be part of slice control, because it can be
>>> zero, but size of array can't be
>> Clarification: num_entry_point_offsets is needed in any case, even without entry
>> point list.
> I thought that at least one decoder wanted the entry points or have we
> decided that we don't? Whilst they aren't required for decode, what they
> give you, if your h/w supports it, is the ability to decode multiple
> lines of CTBs in parallel (with a 2 CTB offset between lines), so they
> aren't useless.
>
> If we do decided we want the entry point offset control, now or later,
> then num_entry_points in the slice_param allows you to determine which
> offsets apply to which slices without the complexity of a variable array
> of variable arrays.
>
> But whether or not we end up supporting entry point offsets, the Pi h/w
> requires me to generate 1 table entry for each CTB line and
> num_entry_points is the parameter I need for that, so I really want it
> in the slice_params.

I'm adding a control (dynamic array) and num_entry_points field in slice
parameters in the next version.
See here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commit/6b4efa4dc54de069893f5203d885fea2c1347916

Regards,
Benjamin

> Regards
>
> John Cox
>
>>> 4. fortunately, not setting entry points doesn't impact decoding
>> correctness.
>>> This is in line what John told me about them.
>>>
>>> Hans, can you comment points 1-3? I might misunderstand point 1.
>>>
>>> In short, it seems like we don't really need entry points, even if they are
>>> used in BSP library. In both cases, I got fluster score 119/138 (10-bit
>>> excluded), so we can just drop this patch, although I'm a bit uneasy not
>>> setting entry points...
>>>
>>> Best regards,
>>> Jernej
>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>> ---
>>>>>   .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
>>>>>   include/media/hevc-ctrls.h                               | 1 +
>>>>>   2 files changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>>>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> index 44a268a948c0..71f7dc1c1ccd 100644
>>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> @@ -3128,6 +3128,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>>   
>>>>>       \normalsize
>>>>>   
>>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>>> Here you have OFFSETS (plural) ...
>>>>
>>>>> +    Specifies the i-th entry point offset in bytes and is represented by
>>>>> +    offset_len_minus1 plus 1 bits.
>>>> You probably mean entry_point_offset_minus1? offset_len_minus1 just tells
>> how
>>>> much bits need to be read for each element and it's not important for
>> actual
>>>> decoding.
>>>>
>>>>> +    This control is a dynamically sized array. The number of entry
>> point
>>>>> +    offsets is reported by the ``elems`` field.
>>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>>>> +    They are described in section 7.4.7.1 "General slice segment header
>>>>> +    semantics" of the specification.
>>>>> +
>>>>>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>>>       Specifies the HEVC scaling matrix parameters used for the scaling
>>>> process
>>>>>       for transform coefficients.
>>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>>> index 3016c1abb1d0..3f8a67924df3 100644
>>>>> --- a/include/media/hevc-ctrls.h
>>>>> +++ b/include/media/hevc-ctrls.h
>>>>> @@ -20,6 +20,7 @@
>>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE +
>>>> 1012)
>>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE +
>>>> 1015)
>>>>>   #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE
>> +
>>> 1016)
>>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET (V4L2_CID_CODEC_BASE
>> +
>>>> 1017)
>>>>
>>>> ... and here you have OFFSET (singlular). I suggest plural form to be used
>>> in
>>>> all places, including subject line of this commit.
>>>>
>>>> Additionally, it would be nice if control is initialized, like so:
>>>> https://github.com/jernejsk/linux-1/commit/
>>>> f938e162cd8dd77c9f6f1b248d80144840a37bce
>>>>
>>>> Best regards,
>>>> Jernej
>>>>
>>>>>   
>>>>>   /* enum v4l2_ctrl_type type values */
>>>>>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>>>> -- 
>>>>> 2.32.0
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
