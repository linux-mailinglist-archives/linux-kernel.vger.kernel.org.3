Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0B56C07D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiGHRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiGHRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:25:27 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0A4F1B1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:25:24 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id a184so12789034vsa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PtHKRPEI89RBiussynoEoQBwVKRqi9WwDOq/hTwvg08=;
        b=xZX5FasoYj3UWBf7c1OivQn7v4gD2OV3Fj/GNe/0sX2wRe6iaxYv+tkh/LfKWV88fy
         bX84F2/1Gevy+q/oSKjL3hV39t1f0Lq9b+tN+wbxX8qJo3kRx4maU03fZrbidrgkUkW6
         ESXxzLL6K0B5uQ/IkIwPOAVYGF/QT7FxemJN8JLkC1BLjyH301X6s7TA1kbRuC3vLpms
         lmHTpC7/LbI+Ws8HJLEcJDlBCpsXyR89vxh+RJBwEVBWJdg2IdYCzWWV0lXHIvr1v6NI
         jwpsDSV+rMRQKNnTO/xio4AQ7bWbzlDAk7jivQYQGuqGwyc2RbDfHGdUrzcZewYNyd+y
         6QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PtHKRPEI89RBiussynoEoQBwVKRqi9WwDOq/hTwvg08=;
        b=nCsOHT+6Uqaf21dIh/We31i1WmsqUUo5BCZ+Y7HGkj3bzDCTvW9nDuNRWW5q5VGefE
         CVRjdLySiTnD8SWSrAXu5x2eVQj7+33mZo8AY9XVevC1J035ckrfchCuErwrXa8pBtVd
         YTjR1xxqswaqksQfBjWxLenhvDkQYafZYYb7pEsDWQD8Uiq3UL1wf0tCwCryyUoLWplg
         KMYIIlHBZqZFP8veNow5r5pibh7XYth4UysEMjLP7nH7gSpzLQQZI2rR41tts6ZN3XvC
         hqbqcfL8M+/I/HmZlM9rM0XH0j1lcVvTsK/xZ3y+R53mifCOA6xlr+BxExDzYrAozUEJ
         k2hA==
X-Gm-Message-State: AJIora+E+Anjv6MtrA9oqlN99ZRH6aSuK/uLmN8lx4TdpahutKQ2Q1IZ
        mAkjHcKFHDkaR7vLUhPLITPeFg==
X-Google-Smtp-Source: AGRyM1uHUHWz1P7lT6OaSA/5Q7gXNyRjeEMJGRcx/jkExokTUSEA+uMtxRyCFR3AO0zHSzr/mjF6dQ==
X-Received: by 2002:a67:b103:0:b0:354:447a:93b0 with SMTP id w3-20020a67b103000000b00354447a93b0mr2217123vsl.56.1657301123099;
        Fri, 08 Jul 2022 10:25:23 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id r23-20020ab03317000000b00370fe98f896sm12572339uao.7.2022.07.08.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:25:22 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:25:16 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v13 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Message-ID: <YshofLPFd7Sp8iOF@eze-laptop>
References: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
 <20220708162156.815772-12-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708162156.815772-12-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 06:21:50PM +0200, Benjamin Gaignard wrote:
> The number of 'entry point offset' can be very variable.
> Instead of using a large static array define a v4l2 dynamic array
> of U32 (V4L2_CTRL_TYPE_U32).
> The number of entry point offsets is reported by the elems field
> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> field.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!
Ezequiel

> ---
> version 13:
> - Reword num_entry_point_offsets field and control usage (yes, again)
> 
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst  | 16 ++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c        |  5 +++++
>  include/media/hevc-ctrls.h                       |  5 ++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index c2e0adece613..c05c5553f0e3 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,6 +3010,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u32
>        - ``data_bit_offset``
>        - Offset (in bits) to the video data in the current slice data.
> +    * - __u32
> +      - ``num_entry_point_offsets``
> +      - Specifies the number of entry point offset syntax elements in the slice header.
> +        When the driver supports it, the ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS``
> +        must be set.
>      * - __u8
>        - ``nal_unit_type``
>        - Specifies the coding type of the slice (B, P or I).
> @@ -3150,6 +3155,17 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>  
>      \normalsize
>  
> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> +    Specifies entry point offsets in bytes.
> +    This control is a dynamically sized array. The number of entry point
> +    offsets is reported by the ``elems`` field.
> +    This bitstream parameter is defined according to :ref:`hevc`.
> +    They are described in section 7.4.7.1 "General slice segment header
> +    semantics" of the specification.
> +    When multiple slices are submitted in a request, the length of
> +    this array must be the sum of num_entry_point_offsets of all the
> +    slices in the request.
> +
>  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>      Specifies the HEVC scaling matrix parameters used for the scaling process
>      for transform coefficients.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index d594efbcbb93..e22921e7ea61 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return "HEVC Entry Point Offsets";
>  
>  	/* Colorimetry controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>  		break;
> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> +		*type = V4L2_CTRL_TYPE_U32;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> +		break;
>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>  		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>  		break;
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index a372c184689e..3a6601a46ced 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -20,6 +20,7 @@
>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 1017)
>  
>  /* enum v4l2_ctrl_type type values */
>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>   *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current slice data
> + * @num_entry_point_offsets: specifies the number of entry point offset syntax
> + *			     elements in the slice header.
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>  struct v4l2_ctrl_hevc_slice_params {
>  	__u32	bit_size;
>  	__u32	data_bit_offset;
> -
> +	__u32	num_entry_point_offsets;
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>  	__u8	nal_unit_type;
>  	__u8	nuh_temporal_id_plus1;
> -- 
> 2.32.0
> 
