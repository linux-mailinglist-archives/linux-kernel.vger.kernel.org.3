Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DA4E9D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiC1RTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbiC1RTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:19:43 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8D263BC4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ilMcPBjUCXJWeW2dVgPW5uEUuNJPkXASfjLKkiNNkIs=; b=T+m65BH3m8iNnGqfbRdiWmAMiA
        trFg2yKWGqWUm5wBcKzDvtyri4OXqPn53c9WSF/uTjShv6yV+tIVD/IXPNgqMaUoURo5vHhn4Yjq4
        VEksJMCVhNm5Etic2RzIDePf8s4cjoTReycG1WycSJfKINPR4mT1oINBgGKXQ4sgtWvX1p70ORkzE
        ZVf6vuMenbeaplCsUScybdMuwHL06NMP+alz/e3R9RkJrPNoDsN7hoecRXJPRLjv2FdwpFHZ9iHwO
        OZ4fBd90lGZzmGvnreKv6kmD1hEmRGvjBWO3AqlehAKFfk6ENC7uZ9AOXXxaSrNG02qtg+eDzxWgn
        5lK0Yesg==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nYt04-0006lu-Qv; Mon, 28 Mar 2022 19:17:52 +0200
Date:   Mon, 28 Mar 2022 16:17:38 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jasdeep Dhillon <jdhillon@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: detach fpu operations from
 dcn10_validate_bandwidth in calcs
Message-ID: <20220328171738.iu5peqfcled2psv3@mail.igalia.com>
References: <20220326202448.2046077-1-mwen@igalia.com>
 <20220326202448.2046077-2-mwen@igalia.com>
 <1586f68e-c635-482f-9399-2b027b766543@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nck3fakny2nfpihg"
Content-Disposition: inline
In-Reply-To: <1586f68e-c635-482f-9399-2b027b766543@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nck3fakny2nfpihg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/28, Christian K=F6nig wrote:
> Am 26.03.22 um 21:24 schrieb Melissa Wen:
> > dcn10_validate_bandwidth is only used on dcn10 files, but is declared in
> > dcn_calcs files. Rename dcn10_* to dcn_* in calcs, remove DC_FP_* wrapp=
er
> > inside DML folder and create an specific dcn10_validate_bandwidth in
> > dcn10_resources that calls dcn_validate_bandwidth and properly wraps th=
at
> > FPU function with DC_FP_* macro.
> >=20
> > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > ---
> >   .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  | 14 ++++++++++++++
> >   .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |  5 +----
> >   drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |  2 +-
> >   3 files changed, 16 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > index 4048908dd265..1587a060b55a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > @@ -1141,6 +1141,20 @@ static void dcn10_destroy_resource_pool(struct r=
esource_pool **pool)
> >   	*pool =3D NULL;
> >   }
> > +static bool dcn10_validate_bandwidth(
> > +		struct dc *dc,
> > +		struct dc_state *context,
> > +		bool fast_validate)
> > +{
> > +	bool voltage_supported;
> > +
> > +	DC_FP_START();
> > +	voltage_supported =3D dcn_validate_bandwidth(dc, context, fast_valida=
te);
> > +	DC_FP_END();
> > +
> > +	return voltage_supported;
> > +}
> > +
> >   static enum dc_status dcn10_validate_plane(const struct dc_plane_stat=
e *plane_state, struct dc_caps *caps)
> >   {
> >   	if (plane_state->format >=3D SURFACE_PIXEL_FORMAT_VIDEO_BEGIN
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/dri=
vers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > index e447c74be713..c25023f7d604 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> > @@ -764,7 +764,7 @@ static unsigned int get_highest_allowed_voltage_lev=
el(uint32_t chip_family,
> >   	return 4;
> >   }
> > -bool dcn10_validate_bandwidth(
> > +bool dcn_validate_bandwidth(
> >   		struct dc *dc,
> >   		struct dc_state *context,
> >   		bool fast_validate)
> > @@ -790,7 +790,6 @@ bool dcn10_validate_bandwidth(
> >   		dcn_bw_sync_calcs_and_dml(dc);
> >   	memset(v, 0, sizeof(*v));
> > -	DC_FP_START();
> >   	v->sr_exit_time =3D dc->dcn_soc->sr_exit_time;
> >   	v->sr_enter_plus_exit_time =3D dc->dcn_soc->sr_enter_plus_exit_time;
> > @@ -1323,8 +1322,6 @@ bool dcn10_validate_bandwidth(
> >   	bw_limit =3D dc->dcn_soc->percent_disp_bw_limit * v->fabric_and_dram=
_bandwidth_vmax0p9;
> >   	bw_limit_pass =3D (v->total_data_read_bandwidth / 1000.0) < bw_limit;
> > -	DC_FP_END();
> > -
> >   	PERFORMANCE_TRACE_END();
> >   	BW_VAL_TRACE_FINISH();
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h b/drivers/g=
pu/drm/amd/display/dc/inc/dcn_calcs.h
> > index 337c0161e72d..806f3041db14 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
> > @@ -619,7 +619,7 @@ struct dcn_ip_params {
> >   };
> >   extern const struct dcn_ip_params dcn10_ip_defaults;
> > -bool dcn10_validate_bandwidth(
> > +bool dcn_validate_bandwidth(
> >   		struct dc *dc,
> >   		struct dc_state *context,
> >   		bool fast_validate);
>=20
> Just for the record: That's not really usual kernel coding style, but tha=
t's
> not topic of this patch set.
Yeah. I didn't change the code style to ease any version conflict managemen=
t.
>=20
> The series is Acked-by: Christian K=F6nig <christian.koenig@amd.com>

Thanks!
>=20
> And it would be really nice if we could make the DC_FP_* macros somehow f=
ail
> in the dml folder.

And if we include a kind of dc_assert_fp_disabled() in the dc_fpu_begin()
(DC_FP_START) - more or less the reverse of dc_assert_fp_enabled(). Does
it meet the `make the DC_FP_* macros somehow fail in the dml folder` ?
It is not restricted to the dml folder, but I think it would work
similarly... Does it make sense?

Melissa

>=20
> Thanks,
> Christian.
>=20
>=20

--nck3fakny2nfpihg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJB7a4ACgkQwqF3j0dL
ehwrzA//QJ6AXYIDEi3GqSLj5lCIMmah8UIxpKgnr8qwFlwj7C/PjnJyOTGe0snd
dTwfd7G0rsmfcYkS/YtqKT+/9Vbfv596xSNOBVAZoQxJ2+ffNdG854aKEM1Mx512
OL3X5/3oOb0uc6Z3xjOa2vYRc0RssXdUwvU6DaKFsAx2tYLN5M62E/k6WP83B1wR
hphGK3wj81ihN6hmyucmhvQI88eHCyayrTWKyUlDCjMUJFr+7A5F0jbbg73fahVQ
o73TCuuThqRT+Irp42o3/HmPsvyjaPhH1wnkfjsZeXBiw0FB8GkZmAYGPx4A5rXK
8b3OlT9jIQ99cLojzWh5voRWKZsQ9Tu0/HFIqayseg70d4I24zt8Sn9XtZTOVCvl
aFPQc3RUhKPjgbgb/1BUX9NPd+uB6Db8UdpcTM5vA+tf2rzpFFgIqbLfmM82fhkp
wjUDaI8iN0NVIkMy/BZ/t6DQ6BfYJCly3d68BDfpcNnlWl8EAqjW5X3LcEwaqtZ0
F96jQ6MbqhX9I6Xvn0rMVQQuyWGW6/cJzgCqq0UsKXg7SKJmqP4dtK6mrgP5RvVk
gTU9FjmowMVGuFiGN/i1QPHN8eCc0FVmFjs4/uEWWWkCFbjxJLu1VJmiMBLhUpun
XfyfThUfwoj//5unmAqYryRL4V3KRdluzAti6iDjLAzi5q+I8+M=
=jExT
-----END PGP SIGNATURE-----

--nck3fakny2nfpihg--
