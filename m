Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B1569201
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiGFSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiGFSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:39:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48F13F93
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:39:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so28589634ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mJ6miwTFAnYDCk1OZK1bVi8RjNdC77tSfMF5/ZTKo8Q=;
        b=5cgz137pmQmV2lL5+tYiJZpzpFdBHWD63n5D+KN7A/rwjnlMy4ZJJLQGFah9HZlmum
         HOrMqURWAXUDqBkeoF+ipBuF47Q5kYU6MnMaarwHtiabzd/c4ZOG9oOU0iXayDViyaZn
         lFdciDdcp8mz+aL/FT2C+/4x9AjyUulYv4MhWd+Lmle5sC3+V7KfwXwpyrYvN1kxl21G
         PPcQm6xA9oayRMVF656Z7QITLSrJFRzQQixc5ndBc9pudkqWv3hlB36RO7DPc5c4Asqy
         3lEt4o5WDGndLxxoX2e/jw2w/8pVO9kPzisA61ystGFW3Q9y9F5c1N9XGXrvA4/tEGKB
         ZStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mJ6miwTFAnYDCk1OZK1bVi8RjNdC77tSfMF5/ZTKo8Q=;
        b=mOC3A4iKtYtuKJ1aE1KGFAcyivPH2Tzsugx+TNSJ2jVqUsZKph2SQCO/pJuNx3OYYU
         RAzh3unmKYfSthMSTr+7BzJhWSTFmcEaDWvg6Rq4rSSkNFhfXGfSbhfIowUw5LM75kWr
         DNmkbnx39Z59c/MC5t6G/OljqxI04cf3KaMCLGDiNtwxuouKS4fLjA/OnGzCGQaCoHWM
         JpCY8YzNauqW2KcYmGy7cLsVNZb6gVlzayvWtFqTyWmOr4Pfv8P3sFMNPC0I4kBLw1u4
         VfMP5ZYtBF3wLxX1vMXzK8LSdWlBmKGGha+3wtfry9PzHZ8F0vkm713c1noOiOgAT5+n
         G2oQ==
X-Gm-Message-State: AJIora+IAH8zpO3qwCaPh4uF2q2pOSnq9CBnjrSLOTT6rJlGpsooMTnX
        QddmQ81yuSQuwzNxSl5lke/1Pwd1ThqBpH0elGYeng==
X-Google-Smtp-Source: AGRyM1vGSt29pAHjnine8M0oy8MqEQ9dveh8rT4q0Js27wmu2VOP3XoBH8WVmxAxmFhqGJx6PMSysJL9XpRQun8grIA=
X-Received: by 2002:a17:907:7627:b0:72a:9098:e4d3 with SMTP id
 jy7-20020a170907762700b0072a9098e4d3mr28054629ejc.389.1657132792261; Wed, 06
 Jul 2022 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <YsRclobW7gL/Dtlr@eze-laptop> <6ae43dcd-9b1d-ce30-8c3e-a8c313ef5b0a@collabora.com>
 <4408380.LvFx2qVVIh@kista>
In-Reply-To: <4408380.LvFx2qVVIh@kista>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 6 Jul 2022 15:39:41 -0300
Message-ID: <CAAEAJfDNHSBtJD_chSV0_UMTJWztyPFxjORRn0+dSrtcZCoYwg@mail.gmail.com>
Subject: Re: Re: [PATCH v10 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
 control
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Tue, Jul 5, 2022 at 1:11 PM Jernej =C5=A0krabec <jernej.skrabec@gmail.co=
m> wrote:
>
> Dne torek, 05. julij 2022 ob 18:03:28 CEST je Benjamin Gaignard napisal(a=
):
> > Le 05/07/2022 =C3=A0 17:45, Ezequiel Garcia a =C3=A9crit :
> > > Hi guys,
> > >
> > > On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
> > >> The number of 'entry point offset' can be very variable.
> > >> Instead of using a large static array define a v4l2 dynamic array
> > >> of U32 (V4L2_CTRL_TYPE_U32).
> > >> The number of entry point offsets is reported by the elems field
> > >> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
> > >> field.
> > >>
> > >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > >> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > >> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > >> ---
> > >>
> > >>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++=
++++
> > >>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
> > >>   include/media/hevc-ctrls.h                            |  5 ++++-
> > >>   3 files changed, 20 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.r=
st
> > >> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
> > >> db0df7d9f27c..8df8d7fdfe70 100644
> > >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > >> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
> > >>
> > >>       * - __u32
> > >>
> > >>         - ``data_bit_offset``
> > >>         - Offset (in bits) to the video data in the current slice da=
ta.
> > >>
> > >> +    * - __u32
> > >> +      - ``num_entry_point_offsets``
> > >> +      - Specifies the number of entry point offset syntax elements =
in
> > >> the slice header.>
> > > This looks underdocumented. Somewhere in the docs it should be mentio=
ned
> > > that the field 'num_entry_point_offsets' is linked to the control
> > > V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.
> >
> > This field is here because some drivers would like know the number of
> > entry point offsets without getting the entry point offsets data itself=
.
>
> Yeah, this field must be set even when entry points offset control isn't =
used.
> Additionally, if entry point offsets control is needed and if submitting
> multiple slices at once, length of entry point offsets array must be sum =
of
> num_entry_point_offsets of all slices in that job. Not sure where to put =
this
> explanation.
>

This confused me a bit: so you mean that this field (called
num_entry_point_offsets)
must be the sum of "num_entry_point_offsets" syntax elements for
slices in the request?

If this is the case, then perhaps it will be a mistake to name our V4L2 fie=
ld
exactly like the syntax element, since it this sum meaning.
Otherwise, developers would tend to get confused by it.

What do you think?

Thanks,
Ezequiel

> Best regards,
> Jernej
>
> >
> > Benjamin
> >
> > > Thanks,
> > > Ezequiel
> > >
> > >>       * - __u8
> > >>
> > >>         - ``nal_unit_type``
> > >>         - Specifies the coding type of the slice (B, P or I).
> > >>
> > >> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_fiel=
d -
> > >>
> > >>       \normalsize
> > >>
> > >> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> > >> +    Specifies entry point offsets in bytes.
> > >> +    This control is a dynamically sized array. The number of entry =
point
> > >> +    offsets is reported by the ``elems`` field.
> > >> +    This bitstream parameter is defined according to :ref:`hevc`.
> > >> +    They are described in section 7.4.7.1 "General slice segment he=
ader
> > >> +    semantics" of the specification.
> > >> +
> > >>
> > >>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> > >>
> > >>       Specifies the HEVC scaling matrix parameters used for the scal=
ing
> > >>       process
> > >>       for transform coefficients.
> > >>
> > >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > >> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
> > >> d594efbcbb93..e22921e7ea61 100644
> > >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > >> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > >>
> > >>    case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:             return
> "HEVC Decode
> > >>    Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
> return "HEVC
> > >>    Decode Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:
> return "HEVC
> > >>    Start Code";>>
> > >> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:       return
> "HEVC Entry
> > >> Point Offsets";>>
> > >>    /* Colorimetry controls */
> > >>    /* Keep the order of the 'case's the same as in v4l2-controls.h!
> */
> > >>
> > >> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name=
,
> > >> enum v4l2_ctrl_type *type,>>
> > >>    case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> > >>            *type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> > >>            break;
> > >>
> > >> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> > >> +          *type =3D V4L2_CTRL_TYPE_U32;
> > >> +          *flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > >> +          break;
> > >>
> > >>    case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> > >>            *type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> > >>            break;
> > >>
> > >> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > >> index a372c184689e..3a6601a46ced 100644
> > >> --- a/include/media/hevc-ctrls.h
> > >> +++ b/include/media/hevc-ctrls.h
> > >> @@ -20,6 +20,7 @@
> > >>
> > >>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS
> (V4L2_CID_CODEC_BASE +
> > >>   1012)
> > >>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE      (V4L2_CID_CODEC_B=
ASE
> +
> > >>   1015)
> > >>   #define V4L2_CID_STATELESS_HEVC_START_CODE       (V4L2_CID_CODEC_B=
ASE + 1016)
> > >>
> > >> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC=
_BASE
> > >> + 1017)>>
> > >>   /* enum v4l2_ctrl_type type values */
> > >>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > >>
> > >> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
> > >>
> > >>    *
> > >>    * @bit_size: size (in bits) of the current slice data
> > >>    * @data_bit_offset: offset (in bits) to the video data in the cur=
rent
> > >>    slice data>>
> > >> + * @num_entry_point_offsets: specifies the number of entry point of=
fset
> > >> syntax + *                      elements in the slice
> header.
> > >>
> > >>    * @nal_unit_type: specifies the coding type of the slice (B, P or=
 I)
> > >>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier=
 for
> > >>    the NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> > >>
> > >> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
> > >>
> > >>   struct v4l2_ctrl_hevc_slice_params {
> > >>
> > >>    __u32   bit_size;
> > >>    __u32   data_bit_offset;
> > >>
> > >> -
> > >> +  __u32   num_entry_point_offsets;
> > >>
> > >>    /* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> > >>    __u8    nal_unit_type;
> > >>    __u8    nuh_temporal_id_plus1;
> > >>
> > >> --
> > >> 2.32.0
>
>
