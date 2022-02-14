Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D44B5810
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356905AbiBNRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiBNRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:08:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531CE81;
        Mon, 14 Feb 2022 09:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA47EB81240;
        Mon, 14 Feb 2022 17:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19448C340E9;
        Mon, 14 Feb 2022 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644858475;
        bh=/jr8rd1DWDK7a9tvps14kfnBjFyrLKH0qTwPFZLYYrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkzJunaXWHq0IrMdhiGzQrmnd8hllaMCV54iHDvFSxYNuarApVrKBdvfw5wItquhn
         vzSmtJBV8BFhCiDXgN8Om/1Hik3zillKrgnGOiguF9RnShFoEBNnoe9ixp5m+oQf4E
         J0Xc3r0g5xaEWjssYRpT0n7q6OrmpawbWYiJes930e8wlzr7vMy0y7P2X9uyHJX/GL
         yoTfyyMZXVs0MpLa9W0YE06MGf1Wv1C//JkRTovTJMBZLSG97pwlHt0qTcTAv96hRU
         U+145Cx73TCGM6g2/m1DDkztTQO51oUGV39E+O1wYNPQQOnB2E+MSsp94hz5lOTmnV
         6m6lpNsADJoxw==
Date:   Mon, 14 Feb 2022 17:07:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert
 to dtschema
Message-ID: <YgqMZhNhMRgO0V8t@sirena.org.uk>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
 <YgqGT999nsjUGp9Z@sirena.org.uk>
 <12c66ced-c4a4-3a4e-f84b-83edb9e3fc58@canonical.com>
 <YgqIiv8fZeqFFUHX@sirena.org.uk>
 <b0aaf1e6-c626-e68c-a0d2-4a7ff372b395@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVA94xP6DlMH9yMe"
Content-Disposition: inline
In-Reply-To: <b0aaf1e6-c626-e68c-a0d2-4a7ff372b395@canonical.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVA94xP6DlMH9yMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 06:01:17PM +0100, Krzysztof Kozlowski wrote:

> You mantioned new features - this approach does not change that. If you
> add new properties to common schema, you already alter bindings. Just
> because we use common part, it does not change the fact that it is a
> bindings change. Adding new features in common schema is the same
> binding change as adding new feature in the specific binding, except
> more work.

> I guess you though that work in scaling, so yes, this scales worse. The
> benefit is that this really restricts usage of regulator to what is
> supported, so allows to detect wrongly configured DTS.

We should have a way of specifying generic properties that doesn't
require us to go through every single user of a binding and updating
them all, then auditing by hand any new users to make sure they didn't
forget one of the generic properties.  This is just error prone and
miserable, especially when most of the checking is done by hand rather
than automated.

> Once coupling (or any other feature) is supported, each of such
> restricted regulator bindings should be independently revised, instead
> of adding this new feature to everything.

Coupling is already supported - it doesn't require anything on the part
of the driver, it's about defining the relationships between supplies
rather than anything the driver or device does.

--kVA94xP6DlMH9yMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKjGUACgkQJNaLcl1U
h9Crxwf+Lb8Rh23sPsLDiaGIIuNoLur++mpq/Djyf5Vozb8Zor6osxgyOiUS3F5t
PSfStwAChTiw0KXn+3+n6wm1OS16tMt9wMuUNuEN+fdDYy8BO+Jl8O8dyKhX456g
+e3KFJVkk8uqcCHNVCmnRn4rCnOqbWDxTWiaggH5wNaEKa0OC8w+t+5IgoeONr5F
2FRSIN87jb73g7Y9RG1OS8F3nMqthsebChr0ryZfUp1PnsWKOYXlVyG/Lknv5LBP
HL0wkQu7B394Mda2c6pg4/VxHkGzfz3VWZMpRlMNLbLVA48Wj77SxFjmCg+eG1BV
XZsdz6WQp5E/kbhmA4y78UTlWuEqwA==
=KX56
-----END PGP SIGNATURE-----

--kVA94xP6DlMH9yMe--
