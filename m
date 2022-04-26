Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5D50F36E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbiDZINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbiDZINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:13:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71558111;
        Tue, 26 Apr 2022 01:10:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:3:7d2:2277:ba57:a2c0:3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 893721F40485;
        Tue, 26 Apr 2022 09:10:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650960601;
        bh=i+FUcR1yvMR0JAh3EWthKUWKQAVviGQ0EBgzu83bkeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEX8AtMHUqkK901YYtQWvEpja2AB+QNqVrVNoaxRSY54EhLsIfsUyrx7nj/0okXOU
         tomUaws7UWBWilioZnaoECwy/eu4DqogNNLiJyISvrSCYy2AgeSiKBd/muMm4RgxGt
         rzaFis0dGPtJstQm4G0HNcQG6Nggh8HMiIzG+R1G2RO/JtCeTOpkXQsOoyOB4PTtZo
         8uZ0gcTlNaeTWqxbQPNfxWn4AtSJFB3XVMahtqaRKvSEH/nnCoehkdGqF09rHHTo7A
         p5l/yIltwyCkYF1Dp/Mw+dqYdMrukinXju7PhGvXp3GvNZ01/JafOgLUURhfNcC8vw
         qo1YhxRKwqxhg==
Date:   Tue, 26 Apr 2022 10:09:57 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Message-ID: <20220426080957.2x3ci4tx6bsaiuwc@basti-XPS-13-9310>
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
 <20220407152940.738159-12-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220407152940.738159-12-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benjamin,

On 07.04.2022 17:29, Benjamin Gaignard wrote:
>The number of 'entry point offset' could be very variable.

s/could be/can be/

>Rather than use a large static array define a v4l2 dynamic array

s/Rather than use/Instead of using/

Greetings,
Sebastian

>of U32 (V4L2_CTRL_TYPE_U32).
>The number of entry point offsets is reported by the elems field
>and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>field.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
> drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> include/media/hevc-ctrls.h                            |  5 ++++-
> 3 files changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>index 1aaf3b84b584..a604dedce17c 100644
>--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>@@ -2988,6 +2988,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>     * - __u32
>       - ``data_bit_offset``
>       - Offset (in bits) to the video data in the current slice data.
>+    * - __u32
>+      - ``num_entry_point_offsets``
>+      - Specifies the number of entry point offset syntax elements in the slice header.
>     * - __u8
>       - ``nal_unit_type``
>       - Specifies the coding type of the slice (B, P or I).
>@@ -3125,6 +3128,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>
>     \normalsize
>
>+``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>+    Specifies entry point offsets in bytes.
>+    This control is a dynamically sized array. The number of entry point
>+    offsets is reported by the ``elems`` field.
>+    This bitstream parameter is defined according to :ref:`hevc`.
>+    They are described in section 7.4.7.1 "General slice segment header
>+    semantics" of the specification.
>+
> ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>     Specifies the HEVC scaling matrix parameters used for the scaling process
>     for transform coefficients.
>diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>index 4b68cbe23309..48d385b776b1 100644
>--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>@@ -1180,6 +1180,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> 	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
> 	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
> 	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
>+	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return "HEVC Entry Point Offsets";
>
> 	/* Colorimetry controls */
> 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>@@ -1508,6 +1509,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
> 	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> 		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> 		break;
>+	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>+		*type = V4L2_CTRL_TYPE_U32;
>+		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>+		break;
> 	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> 		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> 		break;
>diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>index 00abbf930235..97e049ccb966 100644
>--- a/include/media/hevc-ctrls.h
>+++ b/include/media/hevc-ctrls.h
>@@ -20,6 +20,7 @@
> #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
> #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
> #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>+#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 1017)
>
> /* enum v4l2_ctrl_type type values */
> #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>@@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>  *
>  * @bit_size: size (in bits) of the current slice data
>  * @data_bit_offset: offset (in bits) to the video data in the current slice data
>+ * @num_entry_point_offsets: specifies the number of entry point offset syntax
>+ *			     elements in the slice header.
>  * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>  * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
>  * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>@@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
> struct v4l2_ctrl_hevc_slice_params {
> 	__u32	bit_size;
> 	__u32	data_bit_offset;
>-
>+	__u32	num_entry_point_offsets;
> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> 	__u8	nal_unit_type;
> 	__u8	nuh_temporal_id_plus1;
>-- 
>2.32.0
>
