Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A554DDD31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiCRPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiCRPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:45:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5364FA;
        Fri, 18 Mar 2022 08:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20E5AB823F0;
        Fri, 18 Mar 2022 15:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9472BC340E8;
        Fri, 18 Mar 2022 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647618244;
        bh=tkzn9vvttWuFtwPx1w9q8VeWeZ0ytcKBS5ZYz2BxRRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R37rEhpRPrbUzBd10uhKU5QHGlRgitjsW8MYpkYYe6FpxdgYMd5gMpD9Gz74WYT5G
         /TM2yj6EIrOpc6nBVnAphb7nYuY+f4tSJIPE8byT/DI5h41zi6zw+ap137yWG1riMw
         KFuDzpnw5oNH3WnNeAuSSnpsfxw4N+MqRzZZEoCSZ/q3UzOkdlSsMeiet4fsZTbEjy
         jtNcZzp7wXUqPV72lf3LhEKnbtrxNTGpuISb1+9EYEAEqympxj98PfHhok1A6YcipL
         abrNOsTlptmS4xwIQS8MqDy7DPmtf44VU4j8gg1rHbre+zlYYkg/tyhJDQKlvrv5lv
         aQ/I2BOeekkZA==
Date:   Fri, 18 Mar 2022 15:44:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: linux-next: Fixes tag needs some work in the spi tree
Message-ID: <YjSowNPTqUHDbLKE@sirena.org.uk>
References: <20220318081849.71228339@canb.auug.org.au>
 <OS0PR01MB5922ED18407C0728F09941A486139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="39r0frdUFiZnUkfd"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922ED18407C0728F09941A486139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Cookie: laser, n.:
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--39r0frdUFiZnUkfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2022 at 07:10:59AM +0000, Biju Das wrote:
> Hi Stephen and Mark,
>=20
> My bad, I have added Fixes tag at last minute and missed running
> Check patch with that change.
>=20
> Is it possible to manually fix this?

No, that'd involve rebasing.  It's fine, just remember this in future.

--39r0frdUFiZnUkfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI0qL8ACgkQJNaLcl1U
h9DkkQf+L8rOtYtxgfPnNsg7Oeqht5udr7cw3LFnz/M5MU/FK4cAIDssQ/hcAd/i
0WJOPjV6Chbvtu++DzRMVEJJg5/ZuKPVesdtjIri6eH6K7TnJWXj6RMRVpNaLHVE
APqNlKRXQW8+Wqkza++7AZBsAC+Fq3iWhvUaKI7SnH5qBdy3Qj3BVReMkEBIP3dT
ojIBrhc9p7A756DyCPIcDx7FtmFXUHrGLIkJ7FYDhGLQ8fGp6xKmIuPGOyShronS
2GMTIhkJSxpC4m4J2zM6T6tvk+LWOnqgEsRG3FB9s5NWbbYDVwqHdDr3beXAl5X9
oJ/3Z0JsE1AugvnoMEgsY5xrWp+F+w==
=HGyR
-----END PGP SIGNATURE-----

--39r0frdUFiZnUkfd--
