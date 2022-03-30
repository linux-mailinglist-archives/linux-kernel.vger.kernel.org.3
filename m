Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303D44EBDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiC3JnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiC3JnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A4265E84
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88CDFB81B81
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ADDC340EE;
        Wed, 30 Mar 2022 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648633293;
        bh=d/yFGiB4cR7/kRD7YEtqlOefDYLnKi8DAvRDC/ISY1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=of2T2whnR/+5kI0FmjWQSdMQCdIuHulemzbNJQad+ZfJR0MIFOcZe0dpXHHcImz6W
         FeTAwfs9/kKOOsgPdGZaDcab/LmBok5PjBKaiED4WJiZFEzm1zX/yp3TnDjR8xFKTF
         UJZQ/8csDE4M4NY3VOG1hi9gVLHi7KjozxSUb5tGkLCVzxn0I5/1xwFCF+at8Gxctq
         6ipXz/b1AFl7JVmoZitNnTS1olhl7dsXXA+5aPEZHe3OqsCsYg4Q9tX6qKGxyzhXJy
         H0fXxDdu13C/NiLxf2fgkBHnQXFotQ86stXtRgVEsY2ClC2W3K+Iembf0H46OPJ3Aw
         ZZ8bhHCdt8/Wg==
Date:   Wed, 30 Mar 2022 11:41:29 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs*: use simple i2c probe function
Message-ID: <YkQlySr8xPOoZkfj@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220325170734.1216018-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y1UGgW5uriAaQZE4"
Content-Disposition: inline
In-Reply-To: <20220325170734.1216018-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y1UGgW5uriAaQZE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 06:07:34PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Looks good and builds fine:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--y1UGgW5uriAaQZE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJckACgkQFA3kzBSg
KbaGtQ//cRk4RjhsJ8BnvUitBz0t3loxGKs74bGQnZeIISpTnNPBSn3tXIN5mhQt
hVv9UO0W91/uU9LLXWYvt5cvtVU7XmdabQpDkhPQGY0JUNQrMNQBRI6loVAKm8Vt
ircnfMGibOP4cAhucRtpFMX/u2qhp1nfpvaDFokULWb/rs9oEI/DuwYTQGXHsKEj
ucHiNG8okwQHuTvhYIrFJGoA5J0y4wdxXCoNLPXzTZonFK+rfJoPl7GSyQTve+rE
F/vfFHDMNG+1k2Ag5mMJLJq0I2P8xSV/a+6CCfMDEh9jjs8XbALx9+2iZ4XOvXws
S0YS9DS+8mcAUmXpxSXrFBqDXM+JGm8JxCnKY0zI3d2WAx5W97mtZeirnWUQDk/3
ElxDP5ZcnhHn5PIbN5uVq/7Umv4BAk2izPQADvtENjIzipf0xGSSeJMmniFAxovX
Iu+/1ymV+s0/NObC/IHMAfcVQaZb3NvqGODkn7MPUGrCxv3ubXAJwWrrxPfbL+Jh
4ZeQaqskWbIrYUgKMDGSLBqnEVWAIL1z/vHNspXeMymuCIOaw6hjigMMyC7Js4U9
3hJ9023x4jRD4WbrUpaG9ENfhVk3Ex5SmHcVS9ZBdT6XzC0glSVkFqwCrjukDNO+
gVMQv2j4jEtQP4IE4QY8nijdeKQFzeLVuSfsTU7wTN7S7v4FX1w=
=dPad
-----END PGP SIGNATURE-----

--y1UGgW5uriAaQZE4--
