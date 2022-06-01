Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00C53AAE3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356071AbiFAQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356059AbiFAQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:21:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94967939B;
        Wed,  1 Jun 2022 09:21:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E62581F443BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654100466;
        bh=E4FJUmMAl8Mh7E9Z5cNlbSozATjPpKyz0sy+o9BoOYw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B8HOs0uWx/cB0v1FqSf8WnIOe1v4nUaBA7oS/8aP/HN5vTsdUjuQhtzKFwDYyQr33
         3Rw+jhZtcpXoTP9f2vH+TZFE16VfPrIvaovjbRDcUC00s9H4t0IYN+PMQ+XWdQNq1b
         9XbQojRLNl1tCKc7/2Tea4tbbWaXMsklluscD6qxM27AznZ8MSZHFQR7iJr7jbPUKn
         YBAE7qvTPES/otVfp9O//OQXPj7ZFX2npCIu1AsFEqabRWEffFv5QyZHpMuZvBgovK
         pXYb/PIO/SXXQZ/jBBWwu6kcomll2MSIruaUXuA2kzaQNfkJUCnUCv8DFlEOezXTLM
         COX7FJW+RrsCA==
Message-ID: <95261aa18425e8f5571888a41ee03d9dfd2814b9.camel@collabora.com>
Subject: Re: Re: [PATCH v6 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, andrzej.p@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Date:   Wed, 01 Jun 2022 12:20:53 -0400
In-Reply-To: <2102878.irdbgypaU6@kista>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
         <5824953.lOV4Wx5bFT@kista>
         <b398272b-daf8-7499-b4fd-8a6f2af30053@collabora.com>
         <2102878.irdbgypaU6@kista>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 31 mai 2022 =C3=A0 20:20 +0200, Jernej =C5=A0krabec a =C3=A9crit=
=C2=A0:
> Dne torek, 31. maj 2022 ob 08:58:46 CEST je Benjamin Gaignard napisal(a):
> >=20
> > Le 30/05/2022 =C3=A0 23:24, Jernej =C5=A0krabec a =C3=A9crit :
> > > Dne ponedeljek, 30. maj 2022 ob 15:49:57 CEST je Hans Verkuil napisal=
(a):
> > > > On 30/05/2022 11:18, Hans Verkuil wrote:
> > > > > On 29/05/2022 08:40, Jernej =C5=A0krabec wrote:
> > > > > > Hi!
> > > > > >=20
> > > > > > This series looks very good and I plan to test it shortly on Ce=
drus,=20
> but
> > > I
> > > > > > have one major concern below.
> > > > > >=20
> > > > > > Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard=
=20
> napisal(a):
> > > > > > > The number of 'entry point offset' can be very variable.
> > > > > > > Instead of using a large static array define a v4l2 dynamic a=
rray
> > > > > > > of U32 (V4L2_CTRL_TYPE_U32).
> > > > > > > The number of entry point offsets is reported by the elems fi=
eld
> > > > > > > and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_off=
sets
> > > > > > > field.
> > > > > > Slice control by itself is variable length array, so you would =
actually
> > > need
> > > > > > 2D variable array for entry points which is not supported. Howe=
ver,=20
> easy
> > > > > > workaround for that is to flatten 2D array to 1D and either hav=
e another
> > > slice
> > > > > > control field which would tell first entry point index for conv=
enience or
> > > let
> > > > > > driver calculate it by adding up all num_entry_point_offsets of=
 previous
> > > > > > slices.
> > > > > >=20
> > > > > > Hans, what do you think?
> > > > > If I would support 2D variable array sizes, wouldn't that be more=
=20
> elegant?
> > > > >=20
> > > > > The current implementation doesn't support that, but as the commi=
t log=20
> for
> > > > > patch 1/17 says:
> > > > >=20
> > > > > "Currently dynamically sized arrays are limited to one dimensiona=
l=20
> arrays,
> > > > > but that might change in the future if there is a need for it."
> > > > >=20
> > > > > Let me know if you agree, and I'll try to implement this. It's be=
en a
> > > while
> > > > > since I last looked at this, so I'm not sure how much work it is,=
 but it
> > > is
> > > > > probably worth a shot.
> > > > Digging more into this made me realize that this doesn't actually h=
elp=20
> for
> > > this
> > > > particular case.
> > > >=20
> > > > I would lean towards your second suggestion of adding up all
> > > num_entry_point_offsets
> > > > of previous slices.
> > > Just one question/clarification about dynamic arrays - does driver ne=
ed to
> > > reserve maximum amount of memory for dynamic array control at=20
> initialization
> > > time? If so, this would still be problematic, since there cound be a =
huge
> > > amount of entry points in theory.
> >=20
> > When adding the control the driver could set .dims field to specify
> > the max number of accepted slices.
> > I have added '#define V4L2_HEVC_SLICE_MAX_COUNT 600' that you could use
> > for this field. It is the value we have found when using slices with RK=
VDEC
> > driver.
>=20
> Is this maximum value applicable only to RKVDEC or is universal? Anyway, =
this=20
> means maximum offset points control for Cedrus would be 600 * 1024 (max. =
offset=20
> points supported per slice) * 4 ~=3D 2.4 MB, which is a lot for one contr=
ol, but=20
> I can live with that...

I believe its defined following "Table A.8 =E2=80=93 General tier and level=
 limits".
With the assumption there will never be a level 7 (which I think is fair). =
If
anyone saw other reasons for this limit, let me know.

This is a worse case scenario, this is quite unlikely in practice, so while
performance might be a disaster if your craft a stream for that case, I don=
't
think it will ever happen in real life.

>=20
> Best regards,
> Jernej
>=20
> >=20
> > Regards,
> > Benjamin
> >=20
> > >=20
> > > Best regards,
> > > Jernej
> > >=20
> > > > Regards,
> > > >=20
> > > > 	Hans
> > > >=20
> > > > > Regards,
> > > > >=20
> > > > > 	Hans
> > > > >=20
> > > > > > Note, it seems that H265 decoding on Cedrus still works without=
 entry
> > > points,
> > > > > > so this problem can be solved later. I'm not sure what we lose =
with=20
> that
> > > but
> > > > > > it was suggested that this could influence speed or error resil=
ience or
> > > both.
> > > > > > However, I think we're close to solve it, so I'd like to do tha=
t now.
> > > > > >=20
> > > > > > Best regards,
> > > > > > Jernej
> > > > > >=20
> > > > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora=
.com>
> > > > > > > ---
> > > > > > >   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 =
+++++++++
> ++
> > > > > > >   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 =
+++++
> > > > > > >   include/media/hevc-ctrls.h                            |  5 =
++++-
> > > > > > >   3 files changed, 20 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-=
codec.rst=20
> b/
> > > > > > Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > > > index 0796b1563daa..05228e280f66 100644
> > > > > > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.r=
st
> > > > > > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.r=
st
> > > > > > > @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_lengt=
h_field -
> > > > > > >       * - __u32
> > > > > > >         - ``data_bit_offset``
> > > > > > >         - Offset (in bits) to the video data in the current s=
lice data.
> > > > > > > +    * - __u32
> > > > > > > +      - ``num_entry_point_offsets``
> > > > > > > +      - Specifies the number of entry point offset syntax el=
ements in=20
> the
> > > > > > slice header.
> > > > > > >       * - __u8
> > > > > > >         - ``nal_unit_type``
> > > > > > >         - Specifies the coding type of the slice (B, P or I).
> > > > > > > @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_leng=
th_field -
> > > > > > >  =20
> > > > > > >       \normalsize
> > > > > > >  =20
> > > > > > > +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> > > > > > > +    Specifies entry point offsets in bytes.
> > > > > > > +    This control is a dynamically sized array. The number of=
 entry
> > > point
> > > > > > > +    offsets is reported by the ``elems`` field.
> > > > > > > +    This bitstream parameter is defined according to :ref:`h=
evc`.
> > > > > > > +    They are described in section 7.4.7.1 "General slice seg=
ment=20
> header
> > > > > > > +    semantics" of the specification.
> > > > > > > +
> > > > > > >   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> > > > > > >       Specifies the HEVC scaling matrix parameters used for t=
he scaling
> > > > > > process
> > > > > > >       for transform coefficients.
> > > > > > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/driv=
ers/media/
> > > v4l2-
> > > > > > core/v4l2-ctrls-defs.c
> > > > > > > index d594efbcbb93..e22921e7ea61 100644
> > > > > > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > > > > > @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return
> > > > > > "HEVC Decode Parameters";
> > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return
> > > > > > "HEVC Decode Mode";
> > > > > > >   	case V4L2_CID_STATELESS_HEVC_START_CODE:		return
> > > > > > "HEVC Start Code";
> > > > > > > +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return
> > > > > > "HEVC Entry Point Offsets";
> > > > > > >  =20
> > > > > > >   	/* Colorimetry controls */
> > > > > > >   	/* Keep the order of the 'case's the same as in v4l2-contr=
ols.h!
> > > > > > */
> > > > > > > @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char=
 **name,
> > > enum
> > > > > > v4l2_ctrl_type *type,
> > > > > > >   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
> > > > > > >   		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
> > > > > > >   		break;
> > > > > > > +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
> > > > > > > +		*type =3D V4L2_CTRL_TYPE_U32;
> > > > > > > +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
> > > > > > > +		break;
> > > > > > >   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
> > > > > > >   		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
> > > > > > >   		break;
> > > > > > > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-=
ctrls.h
> > > > > > > index a3c829ef531a..1319cb99ae3f 100644
> > > > > > > --- a/include/media/hevc-ctrls.h
> > > > > > > +++ b/include/media/hevc-ctrls.h
> > > > > > > @@ -20,6 +20,7 @@
> > > > > > >   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS=09
> (V4L2_CID_CODEC_BASE
> > > > > > + 1012)
> > > > > > >   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE=09
> (V4L2_CID_CODEC_BASE
> > > + 1015)
> > > > > > >   #define V4L2_CID_STATELESS_HEVC_START_CODE=09
> (V4L2_CID_CODEC_BASE + 1016)
> > > > > > > +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS=20
> (V4L2_CID_CODEC_BASE
> > > +
> > > > > > 1017)
> > > > > > >  =20
> > > > > > >   /* enum v4l2_ctrl_type type values */
> > > > > > >   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > > > > > > @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
> > > > > > >    *
> > > > > > >    * @bit_size: size (in bits) of the current slice data
> > > > > > >    * @data_bit_offset: offset (in bits) to the video data in =
the current
> > > slice
> > > > > > data
> > > > > > > + * @num_entry_point_offsets: specifies the number of entry p=
oint offset
> > > syntax
> > > > > > > + *			     elements in the slice header.
> > > > > > >    * @nal_unit_type: specifies the coding type of the slice (=
B, P or I)
> > > > > > >    * @nuh_temporal_id_plus1: minus 1 specifies a temporal ide=
ntifier for
> > > the
> > > > > > NAL unit
> > > > > > >    * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
> > > > > > > @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
> > > > > > >   struct v4l2_ctrl_hevc_slice_params {
> > > > > > >   	__u32	bit_size;
> > > > > > >   	__u32	data_bit_offset;
> > > > > > > -
> > > > > > > +	__u32	num_entry_point_offsets;
> > > > > > >   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> > > > > > >   	__u8	nal_unit_type;
> > > > > > >   	__u8	nuh_temporal_id_plus1;
> > > > > > > --=20
> > > > > > > 2.32.0
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > >=20
> > >=20
> >=20
>=20
>=20

