Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAC545015
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiFIPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbiFIPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91146442;
        Thu,  9 Jun 2022 08:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 860CCB82E09;
        Thu,  9 Jun 2022 15:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5FC34115;
        Thu,  9 Jun 2022 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654787013;
        bh=ZGSUzWDwWXAmiQOo13GFnbChwNWQBClHSdybMstPJBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spG2dWJXt/OtibBPi8WHIfGHUXxfeyy5/Sm7zVjMItXwD0iVyfgYaWK8utduXnVFx
         7KhswRD3hP50E+mhKzh1thRj+VzxpgR4M3I7Rju85SZd9AxFEheO1CkK5J6TIy9DBK
         vtvWZvmd9pwSt/8DYskm74XRtCKyJT+cPqW2ntmMP9fbO2isWU2i4DOaQ9Q8tHyOQ9
         FjfsojDm+IPdwWfcNhhRhmMbcqerCSBQDlCMvLOxLqyQ9LndHfVbHxr4o0lf5PQUjC
         4okYtP2tiJqVIJc455B8a1DpNQmvZFlHZCgqGmozRMOjx4ehAzEpw4ZBlGGJPDMAyT
         ZCgeLLJWxS7rQ==
Date:   Thu, 9 Jun 2022 16:03:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
Message-ID: <YqILv21K+tZ00Qhx@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <YqHylN3xba9XFrF8@sirena.org.uk>
 <0E611F13-96E3-41FD-9550-F900B2EFB00A@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbGz0wp4L4rRy+b7"
Content-Disposition: inline
In-Reply-To: <0E611F13-96E3-41FD-9550-F900B2EFB00A@cutebit.org>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbGz0wp4L4rRy+b7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 03:42:09PM +0200, Martin Povi=C5=A1er wrote:
> > On 9. 6. 2022, at 15:16, Mark Brown <broonie@kernel.org> wrote:

> > As far as I can tell this demux is entirely software based - why not
> > just expose the routing control to userspace and let it handle
> > switching (which I suspect may be more featureful than what's
> > implemented here)?

> Well, userspace should have the other two muxes at its disposal to
> implement any routing/switching it wishes -- but in addition we are
> also offering letting kernel take care of the switching, by pointing
> the muxes to the demux.

> I assume (but I don=E2=80=99t know the extent of what=E2=80=99s possible =
with UCM files),
> that this will be of some value to users running plain ALSA with no
> sound server.

That's basically no userspaces at this point TBH.  I'm not convinced
it's a good idea to be adding custom code for that use case.

> > This should be integrated with the core jack detection stuff in
> > soc-jack.c and/or the core stuff that's wrapping - that way you'll
> > ensure that events are generated and status readable via all the
> > interfaces userspace might be looking for.  The ASoC stuff also has some
> > DAPM integration for turning on/off outputs which might DTRT for you if
> > you do need it in kernel.

> Aren=E2=80=99t all the right events to userspace generated already by the
> codec calling snd_soc_jack_report?

I wasn't able to find any references to snd_soc_jack_report() in your
series?

> I looked at the existing DAPM integration but I couldn=E2=80=99t figure o=
ut
> how to switch the demux with it.

Yes, it won't do that.  If you can't stream the same audio to both then
you'd need something else.

--vbGz0wp4L4rRy+b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKiC74ACgkQJNaLcl1U
h9CaSwf+K7qAgCHyPIBkRRBsmZJ9BXgtuDVApqNRqwM4iuIPyr9H8Ro7YZhyqNXv
iGc9p09J9KRFc8LdHqqe+WcUutRCIHrIEjkTmUlEN8I6hr2yWyVx8foGVKV9us8H
0ifiPXkXLbXph9C5KBM9ssKYB+Zcu+TnyVEQn68L6z0MRsirKK6t/aEWRgrCu9Mp
+P14CgDfGtI0WnudAYVYIbB4euQcqy/kNCPmBzCce6+0AWhRi5r84seF3pAtECkw
/aXfYtwposNztGqSsZe2ryWBdztM1VQdt6ZQ1TtPxaIllUigNTvqe0JRPkk3Ii3J
49VwyPQb1UL/MJYuO9hTxO04Iz8G9g==
=WcrN
-----END PGP SIGNATURE-----

--vbGz0wp4L4rRy+b7--
