Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B14FE412
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356717AbiDLOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356710AbiDLOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FF1A385;
        Tue, 12 Apr 2022 07:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15A16121A;
        Tue, 12 Apr 2022 14:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF7C385A5;
        Tue, 12 Apr 2022 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649774669;
        bh=YyPkSFZiPX3tnEpDjqAxgRTFOfvX9ykB7Fn4cGX0UF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4CjaZCdZr2FGW4dvCzKA6B5OoP0Bw0Y49pdxU6rDrWXooOAZTh7Lz8u1zvbVNLqt
         1GNtieW8swxtB2nS57K5wxHfV9NeIicW9+3Qa5235UU5q2+ZPyoR8xlG9C3E5EyMDm
         3VXFOAZx6xsgHOmlFpVknJrs1S7Y2WTPLywPcRGI7hy1LfryAmpPyuO79kf8qMW5Kx
         skrKovaCSHTRUzHFDH8iqcHYmKo8ujtHhW3JQPeFoKGkrbR86QKTshtwOmlSR9RQ1w
         uW7uXN92Nw4pjKmLrG3nRuIrZy6yDtREn36uycaAlQKYlZbAkcRsis2stKoMlG10R3
         xGRIEukoJO1Fw==
Date:   Tue, 12 Apr 2022 15:44:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 15/16] ASoC: cs35l41: Document CS35l41 External Boost
Message-ID: <YlWQR2HGvNpyJ27o@sirena.org.uk>
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
 <20220409091315.1663410-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YyI4QGHGKlhb6Lxr"
Content-Disposition: inline
In-Reply-To: <20220409091315.1663410-16-tanureal@opensource.cirrus.com>
X-Cookie: Approved for veterans.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YyI4QGHGKlhb6Lxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 09, 2022 at 10:13:14AM +0100, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
>=20
> Document internal and external boost feature for ASoC CS35L41.
> For internal boost the following properties are required:
> - cirrus,boost-peak-milliamp
> - cirrus,boost-ind-nanohenry
> - cirrus,boost-cap-microfarad

Acked-by: Mark Brown <broonie@kernel.org>

--YyI4QGHGKlhb6Lxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVkEYACgkQJNaLcl1U
h9APmAf+Oc6df07jMKCq7Uy9X5T/UpeuFAbNlxlJrhBs3qmc3imCjQ7IbNif7acx
1hVgpkLKcIacnvfi8enP8nOBZN37BBrSVFjl7V4NGwXRs9lSPEC78WGI8PjWkkQK
OI2TCSLtf7FaecYvZHeyyUiG4+XQewym6W5NcFExVYle96xLHSoUEz1MeMd068ge
fN9dHp0FtZeWvbFlkjEEBYO0X5o8yuGjk+D+ObxUgxW2S/IyaybfI4PgFhBWs3c2
1HVA8Ns7vb5j4D+VuRo2uK7RDX133lcJ/9kx1p1rwWS6HDMSXK2HIC76R5Zii5i2
PGWXmB57juLdVqOJgdISZ9tejXtB5w==
=3njN
-----END PGP SIGNATURE-----

--YyI4QGHGKlhb6Lxr--
