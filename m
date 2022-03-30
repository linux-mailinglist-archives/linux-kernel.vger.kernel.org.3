Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D94EBDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbiC3JjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiC3JjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613AE38DBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1855611D6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91FEC340EE;
        Wed, 30 Mar 2022 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648633038;
        bh=jrAd4RX7GD61oozbs8pg8KIS5psRzqsy//PUxm4yPGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ii0Z8B5jrw51lJfUobTCeK0VRU/1Xldz3BFP9JlmKEtle8EM/izjnEk+mxd27S/hw
         rqKpg/paA9TpbzgrQS3F6Th8B2b1SjbqWyoR2vzG3nrfGULvxYOw1WpoOQ7gzz2h7H
         99zlNbUJetooZSJTQFFnGkuH9FQgvMz5xusUeLO/FlqVcpY1ngIBmhXtkK39mmBVci
         pSf8/I72KyLKFxdbbfqGrkWxCHkDTErLHjayjuFTa+PdTTnw6LYQVCvgIVVOWo7EpN
         WiDTzqAfrmCvd3BkPYQqmIlmAYaEUlfphFIEfVeefhYHkFmzlyOaJtfKco6J8ZPup1
         UwUrr+K/fSTAA==
Date:   Wed, 30 Mar 2022 11:37:15 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
Message-ID: <YkQky6v1Ow0vlE6Z@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20220325164828.1209201-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V5eY8UnXk98LR+O7"
Content-Disposition: inline
In-Reply-To: <20220325164828.1209201-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V5eY8UnXk98LR+O7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 05:48:28PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Looks good and builds fine:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--V5eY8UnXk98LR+O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJMsACgkQFA3kzBSg
KbZiIxAAoZi+5SRmj+GJV18g7qDEba81Zb9IGW+R+WFfnDKzzMkAqPQpvgohj/e/
M6sPrrMpNyZVK8TX1qjNgMviAzV6qKAoKIRskoFPhTIwHKT7zFu4XLibcaVv+bbt
E0b40rS/97sSoX3k8FEywEkxXx7IpQ0AEBXYDOMK0j6Zd99CvUEotSH0Hm+/m2Aa
dxa2PHADiwfMwSMRB62BkY0ShoPOsJ1loQVY6PANbP8KqDl+A52Yn3vgDVXEtN7r
7Xav4lmhbVx8Jqqm55owwz7LueGslOYkzhT9C7DphB+sPGrVzXCQjQwewvBe6NWF
plwy84jii+g2ynZ6my21+kZXn6Ct/91dx3+BR5WDlZIe78rfe0y9XA7aPR0jvrKu
CNdUmmyXXZ6T+bC3rdDJZ2ByNpS0CvMR6Y2ShkZGreAuaPpqjR7wnQLcVYTBlc9Z
VoiUB+P7Km+usZwunjkgZ2mU6aMmlXUVjTfA8BBDYhE8CohmRqfMTFM48eNG/3It
uSLYMODZhOkaWrPqMZ4oe2M3By4gwlp1OZ9erVM9g77CrFBxF92cFurZEgPJ71kZ
xoMCD9qhdMZlmlvP8dUn7jd+TV+hlWiB2yIWVLDQP/5M5x+6/0GSZ73sKojN4YV+
67+2uyNN3TSVUrlC+FfZeJV7JbtvghgswXF+1cc4KKPgm2acJWU=
=+Z5s
-----END PGP SIGNATURE-----

--V5eY8UnXk98LR+O7--
