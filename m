Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08750F7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiDZJkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347372AbiDZJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:14:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2653184F89;
        Tue, 26 Apr 2022 01:50:32 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:8ccc:428d:6d90:c434] (unknown [IPv6:2a01:e0a:120:3210:8ccc:428d:6d90:c434])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5B6521F432A5;
        Tue, 26 Apr 2022 09:50:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650963028;
        bh=18a60e/DwgY4enKZwDEyBFnNVeOwXwEzJ1HC9CbWJlk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=joBJi5gC5PsBMnd80pUct5A2XyeH/CkWCHoEGTT3Zeiqgg0/4MstrlrVikCErKRd8
         y1YQ6dlgFGmK7aJb9m+gBuJziQ37mSx4w9V/CdzPc/ZXQ3I2qXIIlAm7eg/9ZnQ8qK
         2AO8QE3mPeRL7Fi6wspO4JAVR9hvr7jHxjUlxJelSRcMnAnx/hyL874Em0W5/4y+3/
         M5aw0+jxmPJ34K6Z+nDV7nL6h87aJyeS+kWZxCx1GH7E986ZdZRab5ICZ++avl0Xnp
         RSU9G4bRYqUkc64DuhdW2Zk0woeWKGOOWpcYQyO7ZydLQw2ex1m05zTFtqFirAedB4
         Z+JQA7TRFg0WA==
Message-ID: <8e6977ac-53bb-53f0-3fdc-75aa2643cb77@collabora.com>
Date:   Tue, 26 Apr 2022 10:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 04/17] media: uapi: HEVC: Add missing fields in HEVC
 controls
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
 <20220407152940.738159-5-benjamin.gaignard@collabora.com>
 <20220425135449.oapsrqqyq34s2ii3@basti-XPS-13-9310>
 <d1ba4e57-2f13-ab3b-f79a-dc812cd4c2bf@collabora.com>
 <20220426075234.6gk72hzf2bgaxwqw@basti-XPS-13-9310>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220426075234.6gk72hzf2bgaxwqw@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 26/04/2022 à 09:52, Sebastian Fricke a écrit :
> Hey Benjamin,
>
> On 25.04.2022 18:16, Benjamin Gaignard wrote:
>>
>> Le 25/04/2022 à 15:54, Sebastian Fricke a écrit :
>>> On 07.04.2022 17:29, Benjamin Gaignard wrote:
>>>> Complete the HEVC controls with missing fields from H.265 
>>>> specifications.
>>>> Even if these fields aren't used by the current mainlined drivers
>>>> they will be need for (at least) rkvdec driver.
>>>
>>> s/be need/be required/
>>> or
>>> s/be need/be needed/
>>>
>>> s/rkvdec/the rkvdec/
>>>
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>> .../media/v4l/ext-ctrls-codec.rst             | 19 +++++++++++++++++++
>>>> include/media/hevc-ctrls.h                    |  6 +++++-
>>>> 2 files changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>>>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index 4cd7c541fc30..dbb08603217b 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -2661,6 +2661,16 @@ enum 
>>>> v4l2_mpeg_video_hevc_size_of_length_field -
>>>>     :stub-columns: 0
>>>>     :widths:       1 1 2
>>>>
>>>> +    * - __u8
>>>> +      - ``video_parameter_set_id``
>>>> +      - Specifies the value of the vps_video_parameter_set_id of 
>>>> the active VPS
>>>> +        as descibed in section "7.4.3.2.1 General sequence 
>>>> parameter set RBSP semantics"
>>>> +        of H.265 specifications.
>>>> +    * - __u8
>>>> +      - ``seq_parameter_set_id``
>>>> +      - Provides an identifier for the SPS for reference by other 
>>>> syntax elements
>>>> +        as descibed in section "7.4.3.2.1 General sequence 
>>>> parameter set RBSP semantics"
>>>> +        of H.265 specifications.
>>>>     * - __u16
>>>>       - ``pic_width_in_luma_samples``
>>>>       -
>>>> @@ -2800,6 +2810,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>     :stub-columns: 0
>>>>     :widths:       1 1 2
>>>>
>>>> +    * - __u8
>>>> +      - ``pic_parameter_set_id``
>>>> +      - Identifies the PPS for reference by other syntax elements.
>>>>     * - __u8
>>>>       - ``num_extra_slice_header_bits``
>>>>       -
>>>> @@ -3026,6 +3039,12 @@ enum 
>>>> v4l2_mpeg_video_hevc_size_of_length_field -
>>>>     * - __u8
>>>>       - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>>>>       - The list of L1 reference elements as indices in the DPB.
>>>> +    * - __u16
>>>> +      - ``short_term_ref_pic_set_size``
>>>> +      - Specifies the size of short-term reference pictures set 
>>>> included in the SPS.
>>>
>>> s/size of/size of the/
>>>
>>> Section 7.4.8 depicts that the st_ref_pic_set syntax
>>> structure can be part of the SPS or the slice header.
>>>
>>> I think we should mention that we talk about the size of the 
>>> st_ref_pic_set
>>> syntax structure from section 7.4.8 of the specification.
>>>> +    * - __u16
>>>> +      - ``long_term_ref_pic_set_size``
>>>> +      - Specifies the size of long-term reference pictures set 
>>>> include in the SPS.
>>>
>>> s/size of/size of the/
>>>
>>> Can we make this a bit more helpful? The specification doesn't contain
>>> a similar structure to `st_ref_pic_set` for long term pictures. So, 
>>> as a
>>> programmer this leaves me guessing:
>>> - Which syntax structure's size are we talking about?
>>> - Does this correlate to any of the existing sections of the
>>> specification?
>>> Because in the end, I feel like this documentation should be able to
>>> help a programmer to provide the correct data for the uABI.
>>
>> I will reword it like that:
>>
>>   * - __u16
>>     - ``short_term_ref_pic_set_size``
>>     - Specifies the size, in bits, of the short-term reference 
>> pictures set, described as st_ref_pic_set()
>
> Just ...
>
> s/reference pictures set/reference picture set/
>
>>      in the specification, included in the slice header (section 
>> 7.3.6.1).
>
> s/slice header/slice header or SPS/
>
>
>>
>> * - __u16
>>    - ``long_term_ref_pic_set_size``
>>    - Specifies the size, in bits, of the long-term reference pictures 
>> set include in the slice header.
>
> s/reference pictures set/reference picture set/
>
> Looking at the documentation it looks like: s/slice header/slice 
> header or SPS/
> (For example in section 7.3.6.1:
> ```
> if( long_term_ref_pics_present_flag ) {
>   if( num_long_term_ref_pics_sps > 0 )
>     num_long_term_sps
>   num_long_term_pics
>   for( i = 0; i < num_long_term_sps + num_long_term_pics; i++ ) {
>     ...
> ```
> )
>
> ... and then it looks very good!

I don't know the syntax to insert this kind of comment inside an array in the documentation
so it will remain as before :-)

Benjamin

>
> Greetings,
> Sebastian
>
>>      It is the number of bits in the conditional block if( 
>> long_term_ref_pics_present_flag ) {...}
>>      in section 7.3.6.1 of the specification.
>>
>> Benjamin
>>
>>
>>>
>>> Greetings,
>>> Sebastian
>>>
>>>>     * - __u8
>>>>       - ``padding``
>>>>       - Applications and drivers must set this to zero.
>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>> index 01ccda48d8c5..a329e086a89a 100644
>>>> --- a/include/media/hevc-ctrls.h
>>>> +++ b/include/media/hevc-ctrls.h
>>>> @@ -58,6 +58,8 @@ enum v4l2_mpeg_video_hevc_start_code {
>>>> /* The controls are not stable at the moment and will likely be 
>>>> reworked. */
>>>> struct v4l2_ctrl_hevc_sps {
>>>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
>>>> +    __u8    video_parameter_set_id;
>>>> +    __u8    seq_parameter_set_id;
>>>>     __u16    pic_width_in_luma_samples;
>>>>     __u16    pic_height_in_luma_samples;
>>>>     __u8    bit_depth_luma_minus8;
>>>> @@ -108,6 +110,7 @@ struct v4l2_ctrl_hevc_sps {
>>>>
>>>> struct v4l2_ctrl_hevc_pps {
>>>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
>>>> +    __u8    pic_parameter_set_id;
>>>>     __u8    num_extra_slice_header_bits;
>>>>     __u8    num_ref_idx_l0_default_active_minus1;
>>>>     __u8    num_ref_idx_l1_default_active_minus1;
>>>> @@ -199,7 +202,8 @@ struct v4l2_ctrl_hevc_slice_params {
>>>>     __u32    slice_segment_addr;
>>>>     __u8    ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>>>>     __u8    ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>>>> -
>>>> +    __u16    short_term_ref_pic_set_size;
>>>> +    __u16    long_term_ref_pic_set_size;
>>>>     __u8    padding;
>>>>
>>>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction 
>>>> parameter */
>>>> -- 
>>>> 2.32.0
>>>>
