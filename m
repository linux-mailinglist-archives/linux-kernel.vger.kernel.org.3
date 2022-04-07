Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B064F888F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiDGUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDGUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F884898B2;
        Thu,  7 Apr 2022 13:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8404161E42;
        Thu,  7 Apr 2022 20:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740B0C385A0;
        Thu,  7 Apr 2022 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362481;
        bh=nFMrAtUPPaCHomT6JLKSuZ4IJiLqRKp10zNiu+A1TE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5k3c0vzZQKZrZ81T01/9OBFsblOxWb0Fj+MJ2zrCA3apMyLgXrX/sx+ZTXeX99cq
         Bo+sLcD8BQH1c/5aHzts70kr0zFBNM3uzOgSVrHlYzq/3GQFWy+shjqRAGx5NtgrRC
         gB7wrRYDwVDOsXLS00S/xxZ1dMw9DM5Eis6YdTCkNLY51yhzBm03t3tTdPEobsfC7W
         LHf8ium0YQRZ+JJ+WMMW0RTb/x4wQ1YPb5vHUcabkhsYlADVHXZ/QW6BNYYKmarC4N
         UQesMwvfcxugjQtuXROAV+n0lBfm+wwTGKk4P1BFnUhSCbHxNW8gZlZU7TkSxP0D2Y
         xV79XyaV6fZIg==
Date:   Thu, 7 Apr 2022 22:14:38 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] clk: si514: use simple i2c probe function
Message-ID: <Yk9GLj9YD7u/sIv9@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-6-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VxAQcXxq88U68ZkA"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-6-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VxAQcXxq88U68ZkA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:26PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--VxAQcXxq88U68ZkA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRi4ACgkQFA3kzBSg
KbbKyA//SS9Ibq36h9SQHkYbdkMwqZ83V96bsg5XpDQMo2XfZIe2QkcmRmdCTvvA
WOutHp/H+7Bfk3HqMIbMyPI7mHUbrQJBeCftsjm8+wokKxOetFMFbpI7sLIFSB4h
vdhQLBCoFHwNWeKTirjocTIERXtf05UOk4oyEyh33OLFrkWd1KzTModgZYMtI0TW
2kj1hj359SMX54OCUm3758e2mb/azzp+1Y8p580G1D3bkd+Ao8WP8aM0n6Ur7ThL
ZufAEClxoYbpPKvAp3Lsddr6lE2ZcGyqMRIXF2pzd1DzGiJ4yYu2yHg83E63NUSt
KxG4kPZu7+U1taxzmGGbLaoxpPnfFjNdRlFUYYp4dOzU5D4ybUfuaiOCl3AmY5Fk
8NK7MJbvTHRcll74O2FsoDIE0pT7DRD2BbzvN/NVJJBlY9IYgFGk/Xt3Fhf4rBV4
F6UxgsOQZnFZ+YLL1PRHaiQHMm1zWOC0k1fjfqC+c6op5aZk3MPB93TTkjvqF+bL
/HkAgj80xYzJaO3dFiR+9ER65JfxFIkBDD2Wt7r8D5DOV7He75UJJdoZV+NsROMU
Lhq+5AhhpCaxPD9+D8V6WlXXwXP72sDCKdpVFQimycdyGMcIu6tyywwXjEehnNh/
oldPpvOfh9PczrMX0ujoHvDSJ6S2kKeQnxL0i1o0Lsq2BkucUP0=
=2O/1
-----END PGP SIGNATURE-----

--VxAQcXxq88U68ZkA--
