Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB856BF42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiGHQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiGHQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:28:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BA20B;
        Fri,  8 Jul 2022 09:27:44 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b] (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD7BD66015BF;
        Fri,  8 Jul 2022 17:27:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297663;
        bh=M2XcgqYs6U+1Gi7Jie82t46uoCuX+14uCwhy1mBpf+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d2km7C3FWFcz1KTim3I9/kIUdFITsY+FuaSR8gBCBJAfljtekinzQ0OzUVNyjua2q
         /A4wTU80QYAD7JrR8LVMZkMwpooLuSp/jpvgv9m1nc1Z8DI3jBr3qqb5dQbbTVkYgJ
         32HyiO486LLwBRY5eB/CYt/YcWhiiwUzLvthcObej84XGW3sRNk4OZ017mV0ncmBVp
         l7WAf1P88rnD8NMstdzMwqABH71kyyEYJ8L7PTvl08bdzDyZJpT+mfMbx7GVwco7Rx
         kQQNT15xNA5JpXc/yMqqDdG7ZAfNHxAyd7etOKrAfwwQDnGe0DJkgJiGvS7X27R3BB
         NZGtgtBAR94Iw==
Message-ID: <7041df2a-e248-56d4-da6a-343b610de8b4@collabora.com>
Date:   Fri, 8 Jul 2022 18:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220708120554.495495-1-benjamin.gaignard@collabora.com>
 <2106581.irdbgypaU6@jernej-laptop>
 <5e346689-5a0c-8fc7-129d-53a6f28e5349@collabora.com>
 <4604967.rnE6jSC6OK@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <4604967.rnE6jSC6OK@kista>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/07/2022 à 18:11, Jernej Škrabec a écrit :
> Dne petek, 08. julij 2022 ob 18:00:24 CEST je Benjamin Gaignard napisal(a):
>> Le 08/07/2022 à 16:02, Jernej Škrabec a écrit :
>>> Hi Benjamin!
>>>
>>> Dne petek, 08. julij 2022 ob 14:05:48 CEST je Benjamin Gaignard
> napisal(a):
>>>> The number of 'entry point offset' can be very variable.
>>>> Instead of using a large static array define a v4l2 dynamic array
>>>> of U32 (V4L2_CTRL_TYPE_U32).
>>>> The number of entry point offsets is reported by the elems field
>>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>>>> field.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>>> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>> ---
>>>> version 12:
>>>> - Reword num_entry_point_offsets documentation
>>>>
>>>>    .../userspace-api/media/v4l/ext-ctrls-codec.rst     | 13 +++++++++++++
>>>>    drivers/media/v4l2-core/v4l2-ctrls-defs.c           |  5 +++++
>>>>    include/media/hevc-ctrls.h                          |  5 ++++-
>>>>    3 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
>>>> c2e0adece613..0cd967126fdf 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -3010,6 +3010,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>
>>>>        * - __u32
>>>>        
>>>>          - ``data_bit_offset``
>>>>          - Offset (in bits) to the video data in the current slice data.
>>>>
>>>> +    * - __u32
>>>> +      - ``num_entry_point_offsets``
>>>> +      - Specifies the number of entry point offset syntax elements in
>>>> the
>>>> slice header. +        When the driver supports it, the
>>>> ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS`` +        must be set.
>>>>
>>>>        * - __u8
>>>>        
>>>>          - ``nal_unit_type``
>>>>          - Specifies the coding type of the slice (B, P or I).
>>>>
>>>> @@ -3150,6 +3155,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>
>>>>        \normalsize
>>>>
>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>>> +    Specifies entry point offsets in bytes.
>>>> +    This control is a dynamically sized array. The number of entry point
>>>> +    offsets is reported by the ``elems`` field.
>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>>> +    They are described in section 7.4.7.1 "General slice segment header
>>>> +    semantics" of the specification.
>>> You forgot to update above description per Ezequiel comment.
>> No it was num_entry_point_offsets which was needed to be updated
>> not this control.
> Both needs to be updated. Ezequiel said:
>
> "I would add Jernej's clarification about the length of the control
> here, where the control is documented."
>
> ""
> This control is a dynamically sized array. The number of entry point
> offsets is reported by the ``elems`` field.
> This bitstream parameter is defined according to :ref:`hevc`.
> They are described in section 7.4.7.1 "General slice segment header
> semantics" of the specification.
> When multiple slices are submitted in a request, the length
> of this array must be the sum of num_entry_point_offsets
> of all the slices in the request.
> ""

I have totally miss the last part.
It is fix in v13.

Thanks for your review.
Regards,
Benjamin

>
> Best regards,
> Jernej
>
>> Regards,
>> Benjamin
>>
>>> Best regards,
>>> Jernej
>>>
>>>> +
>>>>
>>>>    ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>>    
>>>>        Specifies the HEVC scaling matrix parameters used for the scaling
>>>>
>>>> process for transform coefficients.
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
>>>> d594efbcbb93..e22921e7ea61 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>
>>>>    	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return
>>> "HEVC Decode
>>>
>>>> Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return
>>> "HEVC Decode
>>>
>>>> Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:		return
>>> "HEVC Start Code";
>>>
>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return
>>> "HEVC Entry
>>>
>>>> Point Offsets";
>>>>
>>>>    	/* Colorimetry controls */
>>>>    	/* Keep the order of the 'case's the same as in v4l2-controls.h!
>>> */
>>>
>>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,
>>>> enum
>>>>
>>>> v4l2_ctrl_type *type, case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>>>    		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>>>    		break;
>>>>
>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>>>> +		*type = V4L2_CTRL_TYPE_U32;
>>>> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>>>> +		break;
>>>>
>>>>    	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>>>    		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>>>    		break;
>>>>
>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>> index a372c184689e..3a6601a46ced 100644
>>>> --- a/include/media/hevc-ctrls.h
>>>> +++ b/include/media/hevc-ctrls.h
>>>> @@ -20,6 +20,7 @@
>>>>
>>>>    #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	
> (V4L2_CID_CODEC_BASE
>>> + 1012)
>>>
>>>>    #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE
> +
>>>>    1015)
>>>>    #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>>>>
>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE
>>>> +
>>>> 1017)
>>>>
>>>>    /* enum v4l2_ctrl_type type values */
>>>>    #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>>>
>>>> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>>>>
>>>>     *
>>>>     * @bit_size: size (in bits) of the current slice data
>>>>     * @data_bit_offset: offset (in bits) to the video data in the current
>>>>
>>>> slice data + * @num_entry_point_offsets: specifies the number of entry
>>>> point offset syntax + *			     elements in the slice
>>> header.
>>>
>>>>     * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>>>     * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for
>>>>     the
>>>>
>>>> NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>>>> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>>>>
>>>>    struct v4l2_ctrl_hevc_slice_params {
>>>>    
>>>>    	__u32	bit_size;
>>>>    	__u32	data_bit_offset;
>>>>
>>>> -
>>>> +	__u32	num_entry_point_offsets;
>>>>
>>>>    	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>>    	__u8	nal_unit_type;
>>>>    	__u8	nuh_temporal_id_plus1;
>
