Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B2584FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiG2MFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiG2MFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:05:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038C254;
        Fri, 29 Jul 2022 05:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63840B827A3;
        Fri, 29 Jul 2022 12:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3601FC433C1;
        Fri, 29 Jul 2022 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659096304;
        bh=jcgf15P25kPV3tz+Z7tn0n5Bd3MWQtID+T9e0qkTHDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRNSIb3RCKOFO+BdQ1LAAbpM9dANhTuIL1xI5wARGtx1JcxuKRNi5ze+DsJ5bIr3x
         NUcOCxxmqxwA+n1InVZ6voyTRDX6R0++SlFzBXkDj+xDCI2DPGi8D4X+qVGgKHOIV4
         iUmBWr33W9VV8PowvkICNhH5fN0kjwfZLeQSh/s+WlgQM5q5bibW62JV34OMLevkJE
         hGfQWe1MrHIEXjH+uYShu6tHoiupYwusRKX7jb8mg2zHhbdbwh1MYPFhmvV8oA0r3V
         L5rcq5p5JurSFl3+3/QSgOqGNBkjPvIvR261U0aGHugxCVj9iJZ3ljvdVqNM/EXlzv
         cQ6P94Z2Jwr+g==
Date:   Fri, 29 Jul 2022 13:04:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Message-ID: <YuPM6XqLBuA8A9eY@sirena.org.uk>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
 <YuEoLteLBgd+b8sg@sirena.org.uk>
 <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
 <YuJuzNiQczaYi1og@sirena.org.uk>
 <245f6090-9f92-8091-d8e6-735ab078c6c8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nHc4xhGciUg6IkvF"
Content-Disposition: inline
In-Reply-To: <245f6090-9f92-8091-d8e6-735ab078c6c8@gmail.com>
X-Cookie: Chairman of the Bored.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nHc4xhGciUg6IkvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 11:59:03PM +0300, Iskren Chernev wrote:
>=20
>=20
> On 7/28/22 14:11, Mark Brown wrote:
> > On Thu, Jul 28, 2022 at 02:14:10AM +0300, Iskren Chernev wrote:
> >> On 7/27/22 14:57, Mark Brown wrote:
> >>> On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:
> >
> >>>> Add support for some regulator types that are missing in this driver=
, all
> >>>> belonging to the FTSMPS426 register layout.  This is done in prepara=
tion
> >>>> for adding support for the PM6125 PMIC.
> >
> >>>> +	.set_mode		=3D spmi_regulator_ftsmps3_set_mode,
> >>>> +	.get_mode		=3D spmi_regulator_ftsmps426_get_mode,
> >
> >>> Why are set and get asymmetric?
> >
> >> Because the get method, only uses AUTO and HPM, which have the same va=
lue
> >> for ftsmps3 and ftsmps426 (so there is no need for a new function).
> >
> > This needs at least a comment.
>=20
> I agree, I think to add the function with the right macros, and comment
> that it is the same now but might change in the future if support for mode
> modes is added.
>=20
> >>>> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping sup=
ported_regulators[] =3D {
> >>>>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
> >>>>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
> >>>>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
> >>>> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
> >>>> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
> >
> >>> The changelog said we were adding support for new types but this looks
> >>> like changing an existing type.
> >
> >> The code, as written now does a different thing for BUCK, HFS430 (on
> >> mainline (ML) and downstream (DS) linked in the commit message). Since=
 DS
> >> only supports newer stuff, to be on safe side, I kept existing behavio=
r for
> >> rev 0-3 on BUCK(3)+HFS430(10), so at least DS and ML agree on pm6125
> >> completely.
> >
> > This needs describing in the changelog, probably you need multiple
> > paches here since you are making a number of different changes each of
> > which needs some explanation.
> >
> >> The commit [1] that adds support for BUCK+HFS430 might be wrong, or it
> >> might be right for the time being (i.e initial revisions had different
> >> behavior). I'm CC-ing Jorge.
> >
> > If that's the case perhaps part of this needs to be sent as a fix.
>=20
> The Downstream patch is adding 3 logical types:
> - LDO_510 -- these have new subtypes, so no existing PMICs are affected
> - FTSMPS3 -- this has a new subtype (0xb), so no existing PMICs are
>   affected
> - HFSMPS -- this has the same type and subtype (BUCK+HFS430) as an existi=
ng
>   mainline logical type (HFS430), both declaring 0-INF revisions.
>=20
> So if we fully trust the downstream patch, I can make a fix for the
> existing BUCK+HFS430+0-INF, so it uses the slighly modified mode values.
>=20
> Currently the set mode fn differs in LPM mode (5 in the common2 case and
> 4 in the common3 case), so if indeed downstream is correct it would mean
> this regulator (when turned off) was set to an invalid mode (5 has
> undefined meaning in common3 map) from 2019 onward.
>=20
> On the other hand, if we assume downstream is wrong, then their code sets
> 4, which actually means RETENTION (not LPM). I really don't know how this
> could cause trouble. In fact downstream does a bunch of weird stuff, it
> doesn't "just" set to LPM (like mainline), instead there is complex logic
> per logical type and "initial mode". Or they're just masking this mistake
> ;-)
>=20
> TL;DR Jorge's mail is gone, so we can't get info from the original author.

Jorge moved to foundries.io, copying him in in case he remembers
anything about this.

> Another issue is I can't really test any other PMIC (and even my PMIC
> I can't turn off most of the regs without loosing critical functionality,
> and the BUCKs are kinda important :)).
>=20
> So we can:
> 1. politely ask for somebody with access to the secret sauce to say what =
is
>    correct, at least according to the docs (with a timeout)
> 2. assume downstream patch is right, and fix the existing HFS430 regulator
> 3. maintain the current (patch) behavior, which likely won't affect older
>    PMICs, but is still adhering to DS patch, because it adds support for
>    this particular PMIC, so presumably it was tested and works with it
> 4. drop the pmic patch and rely on SMD
>=20
> Please advice.
>=20
> In any case if we go with 2 or 3, I can split out this particular (BUCK)
> part in a separate patch with more information/comments.

--nHc4xhGciUg6IkvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLjzOgACgkQJNaLcl1U
h9AmpQf+INnTaVp0RXX5oHyPeWAYLVev+MUkATK//puVsxRscEVwtTB8dsZchYYr
jMLL0tXoCtfM8TcWU+bHKaIMQagCzR6rBYN01DQEG7M43hAbINk0Zx3JSmVA95n+
d9hVAVGGIA9j1zJo3GVSUHH+HoxF8AawxV80YgvY392iPG6vi4Ksc/GAe1EfNM5C
C5K2RDz7OKBj/WfCLl+GwressdgcifG6rZqp9LnsFWGm4NzWjxkQuyF7NLJ1m5CT
C8h89p0m7xCq8C/GTgpk83d3nxw+yMw3gqZXpFsB5VH38fmZ0kc2cdCrvFdCd87R
pGtJSt0vZxL8eBYTMUUCbLZGLfzmGA==
=1ofS
-----END PGP SIGNATURE-----

--nHc4xhGciUg6IkvF--
