Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB994F887B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiDGUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiDGUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA031B15D;
        Thu,  7 Apr 2022 13:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0073F61EE6;
        Thu,  7 Apr 2022 20:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE944C385A4;
        Thu,  7 Apr 2022 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362776;
        bh=43Ks1+7o5QTBATLt2DKx9NXn0gmOmfKI+9QObBYvt+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAR6nSGhVobVRFdTbFqlysyIQ45czKeWhIZdIqEG6AKgjTG5pMk4BDP2Oez/W7DX0
         kNVb6yyY48fXEVEaflOiWZtiY9KEq5LaAlTCXjHkB/ZeKrhQkfjnVuUr9xYOBxI3ZH
         huFVK4+n0APpRsI3vtt/w/T4hQ8SqY1qN723gjlySk/knLWxksGiIp+tbPar2hj7na
         P6BwGJvL8gvjYEUR5YiTcjIntZf5vDz2weAJPT4XUQkDdTrJminIK0GXxIgBW5Aiw9
         gjK0LixxKCAYcGDjBaIwQJJFLOGH5ucR2IZnIFcChbR90a6eeZYU2SmV/3gC5JLDQ/
         U3lrABQftK9Ng==
Date:   Thu, 7 Apr 2022 22:19:33 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] clk: renesas-pcie: use simple i2c probe function
Message-ID: <Yk9HVQHrEyPQLILr@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-11-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aNPgm7TukXW16rov"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-11-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aNPgm7TukXW16rov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:31PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--aNPgm7TukXW16rov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPR1UACgkQFA3kzBSg
KbbZARAAjE9cZ9y/W2P31lrexCWxLDy9W5Sy6t5G5+rtXH1W0WZg3NcRE+gWNRGU
oLomSEavBtoKJSWDQntyJsX/Ztv6xsuRWmmc/Z7Q37SzzF90Pma+YqaD3xx3eZ+p
SzJI+nLz0LpKibaIObcQIWE2lI6US+2BremtUu18zZAHdkUMlysRAlo0DQcWtC/E
0KbxEJ0PAk4is8DZ6tqNL6IPaJ1al+IK2si14AmonGD3OGxQgxGLQBMxf0P1CPjM
Xes42wGbSsqvp/juh8i9jLOsZExJtD0nPJO9X/SBMQNLnXK+qU/2DH9Lo5obDhDT
0CBDlYSSxvP3g7YMizXf6DzHmecJw1NvYgF7gpSbT7aFbeINTR67P5oGhTHYGgQN
wdP7ILPOL4Ok4LzeiwBoyCgFDOqQixVz8EFKFk5HJqiHxvNQ0FXg/v5pmcG8MBZj
1lPHjxMFnIlkOrTSlmbY1ru6xT1y+ZPJTcBRDN+9RZpE5BxXpEZih/cFa0zgbFdi
cvzM7URKpyS+XjSyfEFszsBlGoxQ2LZjpZ+4COs6IifGuidZ4B0f6oJ8zORKsJGJ
R6RugQz7zRCJoX6bPsROw4+1G3LtJD0blfAHEkScNNCEs1bHSo3eLhGYf0LaTF8+
hLmRzQNBXxy/vZvXLcBJUjJnyEfOXHR/3YwFSwM/LscGG3sF+wc=
=EkIi
-----END PGP SIGNATURE-----

--aNPgm7TukXW16rov--
