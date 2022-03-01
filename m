Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B34C8965
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiCAKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiCAKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:37:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046D580F0;
        Tue,  1 Mar 2022 02:36:18 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:b77d:712d:f725:41b3] (unknown [IPv6:2a01:e0a:120:3210:b77d:712d:f725:41b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E2ABA1F44332;
        Tue,  1 Mar 2022 10:36:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646130977;
        bh=X6YktsVu7FdBgPhu9qFKuminbFyWDXyYaI65mzEEF9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f6RW5QpzWm5aYdPSbPgRh5G4W0Iy/BFCYPiRSSp/ezONLr5d7mvdwoaynWHXsrvIn
         5fqetasbxlaisfNDB13U3oKHEqJekf6+wlvMgAHxi1BPLtswYG7rhu0EqGYuhnuZvF
         C079H/eYqFNV4ghxAfFoLdJIXvxQcq40ewHVtzlrXB31IDsz+j1GLr9pVH42GE8//j
         dfL6rBxtgC/sZ0TewOv8iPoGtzX/28Wh371yNPOWCNhbsvvYrYH1SziIc58yWwMosN
         aGZ+OrHcf2jA+Hl4uhAdAX8m5EFb11xcYMyrkjhxmfRXE7anQWNwQKaG4X7cnTdj92
         od/mPyKP13LxA==
Message-ID: <e021c39f-bee4-e850-d56c-60a5e0a4b59f@collabora.com>
Date:   Tue, 1 Mar 2022 11:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 04/15] media: uapi: HEVC: Add missing fields in HEVC
 controls
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <20220228140838.622021-5-benjamin.gaignard@collabora.com>
 <20220228165757.sjqxdxb3toxkcasl@basti-XPS-13-9310>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220228165757.sjqxdxb3toxkcasl@basti-XPS-13-9310>
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


Le 28/02/2022 à 17:57, Sebastian Fricke a écrit :
> Hey Benjamin,
>
> On 28.02.2022 15:08, Benjamin Gaignard wrote:
>> Complete the HEVC controls with missing fields from H.265 
>> specifications.
>> Even if these fields aren't used by the current mainlined drivers
>> they will be need for (at least) rkvdec driver.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> .../media/v4l/ext-ctrls-codec.rst             | 22 +++++++++++++++++++
>> include/media/hevc-ctrls.h                    |  6 ++++-
>> 2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 4cd7c541fc30..d096cb75993a 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -2661,6 +2661,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>     :stub-columns: 0
>>     :widths:       1 1 2
>>
>> +    * - __u8
>> +      - ``video_parameter_set_id``
>> +      - Specifies the value of the vps_video_parameter_set_id of the 
>> active VPS
>> +        as descibed in section "7.4.3.2.1 General sequence parameter 
>> set RBSP semantics"
>> +        of H.265 specifications.
>> +    * - __u8
>> +      - ``seq_parameter_set_id``
>> +      - Provides an identifier for the SPS for reference by other 
>> syntax elements
>> +        as descibed in section "7.4.3.2.1 General sequence parameter 
>> set RBSP semantics"
>> +        of H.265 specifications.
>>     * - __u16
>>       - ``pic_width_in_luma_samples``
>>       -
>> @@ -2800,6 +2810,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>     :stub-columns: 0
>>     :widths:       1 1 2
>>
>> +    * - __u8
>> +      - ``pic_parameter_set_id``
>> +      - Identifies the PPS for reference by other syntax elements.
>>     * - __u8
>>       - ``num_extra_slice_header_bits``
>>       -
>> @@ -3026,6 +3039,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>     * - __u8
>>       - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>>       - The list of L1 reference elements as indices in the DPB.
>> +    * - __u16
>> +      - ``short_term_ref_pic_set_size``
>> +      - Specifies the number of st_ref_pic_set( ) syntax structures 
>> included in the SPS.
>> +        The value of num_short_term_ref_pic_sets shall be in the 
>> range of 0 to 64, inclusive.
>> +    * - __u16
>> +      - ``long_term_ref_pic_set_size``
>> +      - Specifies the number of candidate long-term reference 
>> pictures that are specified
>> +        in the SPS. The value of num_long_term_ref_pics_sps shall be 
>> in the range
>> +        of 0 to 32, inclusive.
>>     * - __u8
>
> I would like to argue that the names for these fields are not optimal.
>
> The are quite similar to the ones from the specification:
> `num_short_term_ref_pic_sets` & `num_long_term_ref_pics_sps`, while
> they actually do something different. (Which means that descriptions for
> the fields are sadly incorrect as well)
>
> Looking at the code from the H265 parser in GStreamer:
> ```
>       READ_UINT8 (&nr, slice->short_term_ref_pic_set_sps_flag, 1);
>       if (!slice->short_term_ref_pic_set_sps_flag) {
>         guint pos = nal_reader_get_pos (&nr);
>         if (!gst_h265_parser_parse_short_term_ref_pic_sets
>             (&slice->short_term_ref_pic_sets, &nr,
>                 sps->num_short_term_ref_pic_sets, sps))
>           goto error;
>
>         slice->short_term_ref_pic_set_size = nal_reader_get_pos (&nr) 
> - pos;
> ```
>
> We can see that the `short_term_ref_pic_set_size` is calculated by
> gettting the difference between the nal_reader position before calling
> `gst_h265_parser_parse_short_term_ref_pic_sets` and the position of the
> nal reader afterwards.
> The variable `num_short_term_ref_pic_sets` is used as part of the short
> term reference picture set parsing process, but it is not directly
> related to `short_term_ref_pic_set_size` (otherwise a direct
> transformation of `num_short_term_ref_pic_sets` ->
> `short_term_ref_pic_set_size` would have been way easier)
>
> Further when I look at a patch from Alex Bee for RKVDEC that uses these
> fields (actually the only user) 
> (https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch#L3007)
> I can see that he describes them as bit offsets.
>
> So, to avoid confusion, I would argue that we should rename these
> (They are not part of the specification anyway)
>
> s/short_term_ref_pic_set_size/short_term_ref_pic_set_bit_offset/
> s/long_term_ref_pic_set_size/long_term_ref_pic_set_bit_offset/
>
> These names describe the purpose and the content a bit better and avoid
> confusion with existing values.
>
> Additonally, I noticed that calculating the bit offset for the long term
> is a bit tricky. I wasn't able to find a direct reference in
> 'non-vendor' code.
>
> The process for parsing the short term reference picture set is 
> depicted with a lot of detail in
> the specification, but I wasn't able to find the something equivalent 
> for the long term
> reference picture set.
>
> Having a switft look into mpp, I can see at:
> https://github.com/JeffyCN/rockchip_mirrors/blob/mpp/mpp/hal/rkdec/h265d/hal_h265d_com.c#L512 
>
>
> That they do roughly the same short term is simply the read bits by the
> BitReader - the read bits before the operation on the short term
> reference picture set. (so very similar to what the h265 parser does in
> GStreamer)
> The bit offset for long term is equal to short term unless the
> `long_term_ref_pics_present_flag` is set. In which case, we perform some
> operations on the long term reference picture set and add the amount of
> used bits to the bit offset.

I think the names are correct, these fields provides the size of short and long term ref picture.

It isn't an offset as you explain your self it is the diff between end and start of reference picture in the bitstream.

The documentation is incorrect, I will fix it in the next version like this:
* @short_term_ref_pic_set_size: specifies the size of short-term reference
*				 pictures included in the SPS
* @long_term_ref_pic_set_size: specifies the size of long-term reference
*				picture include in the SPS

Thanks,
Benjamin

>
> Greetings,
> Sebastian
>
>>       - ``padding``
>>       - Applications and drivers must set this to zero.
>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>> index 01ccda48d8c5..a329e086a89a 100644
>> --- a/include/media/hevc-ctrls.h
>> +++ b/include/media/hevc-ctrls.h
>> @@ -58,6 +58,8 @@ enum v4l2_mpeg_video_hevc_start_code {
>> /* The controls are not stable at the moment and will likely be 
>> reworked. */
>> struct v4l2_ctrl_hevc_sps {
>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
>> +    __u8    video_parameter_set_id;
>> +    __u8    seq_parameter_set_id;
>>     __u16    pic_width_in_luma_samples;
>>     __u16    pic_height_in_luma_samples;
>>     __u8    bit_depth_luma_minus8;
>> @@ -108,6 +110,7 @@ struct v4l2_ctrl_hevc_sps {
>>
>> struct v4l2_ctrl_hevc_pps {
>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
>> +    __u8    pic_parameter_set_id;
>>     __u8    num_extra_slice_header_bits;
>>     __u8    num_ref_idx_l0_default_active_minus1;
>>     __u8    num_ref_idx_l1_default_active_minus1;
>> @@ -199,7 +202,8 @@ struct v4l2_ctrl_hevc_slice_params {
>>     __u32    slice_segment_addr;
>>     __u8    ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>>     __u8    ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>> -
>> +    __u16    short_term_ref_pic_set_size;
>> +    __u16    long_term_ref_pic_set_size;
>>     __u8    padding;
>>
>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction 
>> parameter */
>> -- 
>> 2.32.0
>>
>
