Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9454520D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbiFIQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E42127B25;
        Thu,  9 Jun 2022 09:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B05460BBB;
        Thu,  9 Jun 2022 16:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AC1C34114;
        Thu,  9 Jun 2022 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654792550;
        bh=nLV0GvHy/KQCKd/BLxkCqqI+MIgBK4mD0qJiit652bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0DX+M6GHhaVTxSNRfrenUrPcrKyVKIyaxOc8mh6FV1QFP33FNxx5J4Wp2izWBWbA
         QbQJ/fmKfazZgJYXTg4okVDZgX3qv5eglx4DLyGB18ouro5GwCkLbvCetMQea5n9vZ
         rYlUfxyxZNJs/gzMISsCVmBin/qnqZ0VsiO/7v5VrHvoI6X44TtmqdoCVQKIaF/lVl
         bS16JFaULKyFIM0lgk9voFtJoDde1zrujgymcYrbZqwP+IwD0KspgTQD+jPU+0k8/L
         RwQLz0cmmT9kzvNSnFAKWtq0PJLKZUnlecE0yQniAqzEcQZePRNachnrcVRZPoDxrD
         JtFRd0+FtAD2w==
Date:   Thu, 9 Jun 2022 17:35:44 +0100
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
Message-ID: <YqIhYPBpVcvz9iLQ@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <YqHylN3xba9XFrF8@sirena.org.uk>
 <0E611F13-96E3-41FD-9550-F900B2EFB00A@cutebit.org>
 <YqILv21K+tZ00Qhx@sirena.org.uk>
 <2A0422B8-8367-457E-A146-730F7C3DE66B@cutebit.org>
 <YqIWtzphzVGmbIOe@sirena.org.uk>
 <4DA6EE04-D23B-437B-8FBA-9223EAA71219@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8PA9aIQYrjMhOXsy"
Content-Disposition: inline
In-Reply-To: <4DA6EE04-D23B-437B-8FBA-9223EAA71219@cutebit.org>
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


--8PA9aIQYrjMhOXsy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 06:19:37PM +0200, Martin Povi=C5=A1er wrote:
> > On 9. 6. 2022, at 17:50, Mark Brown <broonie@kernel.org> wrote:

> > Can you say anything more about the use case?

> I can restate: The alleged use case is running userspace without sound
> server, but having playback switch transparently between speakers and
> headphones even mid-stream based on jack detection.

Sure, but why?

> > No, that works perfectly fine - you can enable or disable pins depending
> > on the jack state.

> Ah, I peeked into soc-jack.c. What about this then: If I understand what
> pins represent, they would be at the remote end of the DAPM paths. So if
> for the speakers I add something like

>    Headphones Codec Out =E2=80=94> Jack pin
>=20
>                        +--> Always-on pin
>                        |
>    Speaker Amp Out -> Mux
>                        |
>                        +--> Jack inverted pin

> and let userspace control the mux, it would in effect support the same
> use cases as what I attempted in the code so far. Sounds somewhat right?

Yes, that should DTRT.  If the mux is working properly with DAPM (not
sure it does with DPCM but ICBW) then you shouldn't even need the jack
integration since the mux would disconnect the unused output when it
gets switched.

--8PA9aIQYrjMhOXsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKiIWAACgkQJNaLcl1U
h9CPXQf/ZMQGcAD7+pTSBWR4+WU2VepcoHhnVLOflAgyJQjnRir5E8L3PN0OaI/D
dvAR3rvl9pttuZZCiK7Dr7xjWyep9qh3Wbh0Tv4CcR7fb88qYgSiZRzvDVDql24W
JYQusypBqzGCPadH2+XUnrI7jKGaagm46KTxNdnEEnnMEUosu+/bhnoFnOi8tBvP
ANAengNgcpTfFvbakGrHg7LL6EYTR9gsjNpPnd8nnhoMcJGylTbYwcWO2oSPJccF
Eu+W+HN2OGE3j3j5tW5jJ4fhOaXQ2b7R8ngc8VWHncgUKKFgtlXt5NF1PZ1x0XUh
yTN7VXtNkQRolvvX+GrjQk9uN9N08g==
=tdB1
-----END PGP SIGNATURE-----

--8PA9aIQYrjMhOXsy--
