Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A552A2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiEQNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347327AbiEQNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:14:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5F41F9B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:13:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 185so14485686qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=v6eTvLUEvVevBWajX03I9738Bo9HdDYIbURMPVLgI3o=;
        b=oPZVvcPwz2accgrfPbP8mek4jw2FV2aLaLaxNt5GLBRqCXua49jJzrW3dz1IBGnbyN
         AYy7zqnYY7qbbHb1M3VEpydqgzIJpFfwMXe1KXdTpgTLocSEh9VP5Xb9Ep8M2f5HO2Xc
         BjTU3XVNv3v90gDgvmInVAskIVEmIcSbyf+9EWGIDJd+ea6EtBa82IT176L+rMyL7SlG
         9mgzenSuE2H87Mp/RGA0+TpyXDz6rvUwO8AzCRjaH9PQCSoyecL5V1Igz6Ab/tEtKrfU
         6XUlICw3kR/t0/hfqSy3QVv5K+DIiarqKOuUKdDFl/Bpj9XmVq73hNz9RP1VaZ8c4y/n
         to5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=v6eTvLUEvVevBWajX03I9738Bo9HdDYIbURMPVLgI3o=;
        b=S1JgIrx/AyX5RMPHiyiyTW21q6cSomJZ9kmRBCy8xJAYxazyR99CkxLJ0fhZy8VL1W
         0V3ID6gyx7DItmqUEFkRi9u68UWKjrRyJ0BRPo4P8+JeDgFakl7xoYoFPfkJOYdH9azQ
         OOMB5Drhvsz9FKD98Hjgw08rj/EIArYGdaS24kXtFaxpp15KWZMw3+JsG5SsdzZUtIc/
         j0enphwZChylbi/6DeOIbgLAecpWOv6mGVUcEjCHZBeBlFAINmkTeSdPhlvXZvJj0Bcd
         2ORe8UrIX69thD42iO3aXtqcNHWxR9Ztc/f4xuSCYDwkezkNh8JR2jcwX1fBE7cMju3E
         v1hg==
X-Gm-Message-State: AOAM531BH6/bh9p4tfFO+ard3EDqkZQgrHIWdNafTX1wsMj8Rhla7JL8
        IPhQC/Oel6nvOZ+qpINr82dlWg==
X-Google-Smtp-Source: ABdhPJzJUTu/kZOXxe6D9v/M0+MMu75gVhSgga0bLUrSZDERONsTz3Yb4XB6GpX3qEgbObri26puKQ==
X-Received: by 2002:a05:620a:2792:b0:6a2:eb8d:70e1 with SMTP id g18-20020a05620a279200b006a2eb8d70e1mr7535050qkp.574.1652793238985;
        Tue, 17 May 2022 06:13:58 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y68-20020a37af47000000b0069fc13ce1f3sm7860925qke.36.2022.05.17.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:13:58 -0700 (PDT)
Message-ID: <44a151e1cdbba8dcf3dfe7dfe00b6ee49c99bcfb.camel@ndufresne.ca>
Subject: Re: [PATCH 06/20] Documention: v4l: Documentation for VP9 CIDs.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
Date:   Tue, 17 May 2022 09:13:56 -0400
In-Reply-To: <20220517125548.14746-7-smitha.t@samsung.com>
References: <20220517125548.14746-1-smitha.t@samsung.com>
         <CGME20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1@epcas5p4.samsung.com>
         <20220517125548.14746-7-smitha.t@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Smitha,

Le mardi 17 mai 2022 =C3=A0 18:25 +0530, Smitha T Murthy a =C3=A9crit=C2=A0=
:
> Adds V4l2 controls for VP9 encoder documention.
>=20
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 4cd7c541fc30..1b617a08f973 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2165,6 +2165,16 @@ enum v4l2_mpeg_video_vp8_profile -
>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>        - Profile 3
> =20
> +VP9 Control Reference
> +---------------------
> +
> +The VP9 controls include controls for encoding parameters of VP9 video
> +codec.
> +
> +.. _vp9-control-id:
> +
> +VP9 Control IDs
> +
>  .. _v4l2-mpeg-video-vp9-profile:
> =20
>  ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> @@ -2231,6 +2241,163 @@ enum v4l2_mpeg_video_vp9_level -
>      * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
>        - Level 6.2
> =20
> +``V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP``

The class was recently renamed V4L2_CID_CODEC... for a reason, can you rena=
me
MPEG_VIDEO with CODEC, specially for VP9 CODEC were MPEG makes no sense. Th=
is
applies all the doc and the defines in the other patch.

thanks,
Nicolas

> +    Quantization parameter for an I frame for VP9. Valid range: from 1 t=
o 255.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP``
> +    Quantization parameter for an P frame for VP9. Valid range: from 1 t=
o 255.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_MAX_QP``
> +    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 230 to 255.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_MIN_QP``
> +    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 1 to 24.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE``
> +    Indicates the number of evenly spaced subintervals, called ticks, wi=
thin
> +    one second. This is a 16 bit unsigned integer and has a maximum valu=
e up to
> +    0xffff and a minimum value of 1.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD``
> +    Indicates the refresh period of the golden frame for VP9 encoder.
> +
> +.. _v4l2-vp9-golden-frame-sel:
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_golden_framesel -
> +    Selects the golden frame for encoding. Valid when NUM_OF_REF is 2.
> +    Possible values are:
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_PREV``
> +      - Use the (n-2)th frame as a golden frame, current frame index bei=
ng
> +        'n'.
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> +      - Use the previous specific frame indicated by
> +        ``V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD`` as a
> +        golden frame.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE``
> +    Allows host to specify the quantization parameter values for each
> +    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
> +    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the control
> +    value to 1 enables setting of the QP values for the layers.
> +
> +.. _v4l2-vp9-ref-number-of-pframes:
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_ref_num_for_pframes -
> +    Number of reference pictures for encoding P frames.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_1_REF_PFRAME``
> +      - Indicates one reference frame, last encoded frame will be search=
ed.
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> +      - Indicates 2 reference frames, last encoded frame and golden fram=
e
> +        will be searched.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER``
> +    Indicates the number of hierarchial coding layer.
> +    In normal encoding (non-hierarchial coding), it should be zero.
> +    VP9 has upto 3 layer of encoder.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE``
> +    Indicates enabling of bit rate for hierarchical coding layers VP9 en=
coder.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR``
> +    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR``
> +    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR``
> +    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP``
> +    Indicates quantization parameter for hierarchical coding layer 0.
> +    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
> +    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP``
> +    Indicates quantization parameter for hierarchical coding layer 1.
> +    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
> +    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP``
> +    Indicates quantization parameter for hierarchical coding layer 2.
> +    Valid range: [V4L2_CID_MPEG_VIDEO_VP9_MIN_QP,
> +    V4L2_CID_MPEG_VIDEO_VP9_MAX_QP].
> +
> +.. _v4l2-vp9-max-partition-depth:
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_num_partitions -
> +    Indicate maximum coding unit depth.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_0_PARTITION``
> +      - No coding unit partition depth.
> +    * - ``V4L2_CID_MPEG_VIDEO_VP9_1_PARTITION``
> +      - Allows one coding unit partition depth.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT``
> +    Zero indicates enable intra NxN PU split.
> +    One indicates disable intra NxN PU split.
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER``
> +    Indicates IVF header generation. Zero indicates enable IVF format.
> +    One indicates disable IVF format.
> +
> =20
>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

