Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAB2567907
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGEU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiGEU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CCE5F48;
        Tue,  5 Jul 2022 13:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DD6BB819A0;
        Tue,  5 Jul 2022 20:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02891C341C7;
        Tue,  5 Jul 2022 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657054719;
        bh=IbmVrAKlWijkdQ5ebbEp6oCPsHF0O8OlYtTkQZBGwDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0tanYVReDJ/ZO3qbCCJdXZxLAzHEhYecLdl4cTFAJCcumA8WnuIaFxmiNgHWWlX/
         0JFqhmWdmHMe+HDdpr3C6BCxTbT/5YmDHDZAZQf/Hjcw5hoQfSSrELhxJqxOSFOLPr
         uhtzLIiogtmCA/1AOHYV67r9coXgD0Z1e0QVWSePBK7aebmuJLiwcSP12djKDnVlL2
         j4/wJCZtiBABHXUXiwrpfiYSqxTAS0chZhHgj99BA5BqwSjfgIpDwxHQhykMNPJ/Pz
         DQyCMU1ET+zFkrHJVwqSVGncwD2fwfOMyGnCRARSUXcTqZTnx2c/RThtv9gyKSXzWg
         2N3L6GOpZPd6Q==
Date:   Tue, 5 Jul 2022 21:58:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     lgirdwood@gmail.com, samuel@sholland.org, wens@csie.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, arnaud.ferraris@collabora.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: Re: (subset) [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal
 bias support
Message-ID: <YsSl+JOmMpGLK1Xc@sirena.org.uk>
References: <20220621035452.60272-1-samuel@sholland.org>
 <165636279016.4185952.318954133536578049.b4-ty@kernel.org>
 <3139722.aV6nBDHxoP@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZVk6fcVA+73A5IXw"
Content-Disposition: inline
In-Reply-To: <3139722.aV6nBDHxoP@kista>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZVk6fcVA+73A5IXw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2022 at 10:12:56PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 27. junij 2022 ob 22:46:30 CEST je Mark Brown napisal(a):
> > On Mon, 20 Jun 2022 22:54:49 -0500, Samuel Holland wrote:

> > [1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
> >       commit: 24e0b04dd42be34ec4b18dc1a1e139d66eb572a3
> > [2/3] ASoC: sun50i-codec-analog: Add support for internal bias
> >       commit: 25ae1a04da0d32c22db0b018e5668129b91fa104

> Can you also take patch 3? You picked bindings change, so it's easiest if=
 DT=20
> change goes through your tree too.

I can if the sunxi maintainers like, but normally changes to the DTs go
via the platform tree.

--ZVk6fcVA+73A5IXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEpfcACgkQJNaLcl1U
h9DC5wf/RMKBqpKm/zHIhE2dv1fovXxq6NieGY7O8vL1kob6qMCw/aYUBbS1RVld
5qIgyC21wmo4MSF2QJJRcO+4N1zqfwqBG8kxyBVPKBi7bZGlDRUmDjAbRQh3fhjM
KE4Y83EURjzifgk1Vtk9LA/8X+XSiCkMD4m80bLHIzMChro6d8KMnwjc4MKY7lpu
rgwmztfYJHGXI+6vdfegXc5V8+OaIF7FwyEltTZvbnF2RO57oFmh25t1IJEpoRe4
RA4KhB2CPwYqP9sGZWVs9Xqx3NYxVJylXI5CDlxyHl4dDudj2PnpsV1PgNbca4Wj
dP1Wfstm+Na+EPYOvd8/+4tNjjS0rw==
=cr2k
-----END PGP SIGNATURE-----

--ZVk6fcVA+73A5IXw--
