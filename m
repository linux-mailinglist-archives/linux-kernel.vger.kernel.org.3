Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE84579FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiGSNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiGSNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:42:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE772BEA;
        Tue, 19 Jul 2022 05:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2990B81B83;
        Tue, 19 Jul 2022 12:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1D9C341C6;
        Tue, 19 Jul 2022 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658235349;
        bh=CU/Rv+N2c/Un1wrPFLZUNp+3x/slQkeI50PQId6Rinw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6IT8A90iAL6XN0wWBPhnvo1RUYBc9E+xmUbanJDF6Bc2fGQwCwkF3PyTbas6/Usd
         zGHt/3NkznXWZasXzSj8phfT8+owtxr7eUS66lus75U4S2/UB6lp6jRzZn3cDaHEbf
         fwbmLYkBpELREto1cHhi5TQFBMfI9PC3FQ0QlPPFmhn0XwFkhFKi0x5wiVr6W5ic5b
         5HGj1hlDTGkTr5d2Xq4ppAexQePaiErg0tnl6Uen3t8VGeaFGSFWQHJt9FSoVEPu0Z
         owpoJurQnjjPtX6iwa284dyzZsDRr1bgExwVWngqmw1m0k/F7qPxBpYJR8k4yDv7Ds
         zbqQJxxPSk1ng==
Date:   Tue, 19 Jul 2022 13:55:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 02/14] regulator: dt-bindings: Add TI TPS65219 PMIC
 bindings
Message-ID: <Ytapz6Qk/cMtTzY4@sirena.org.uk>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-3-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RXARdUd17SuWWt2W"
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-3-jneanne@baylibre.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RXARdUd17SuWWt2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 11:17:30AM +0200, Jerome Neanne wrote:

> +        properties:
> +          regulator-name:
> +            pattern: "^VDD[A-Z0-9_]+$"
> +            description:
> +              should be "VDDNAME_LDO1", ..., "VDDNAMELDO4"

This is broken, regulator-name is for board specific description of the
supply provided by the regulator and should both be optional and have no
constraints on the value.

--RXARdUd17SuWWt2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWqc4ACgkQJNaLcl1U
h9Cjnwf/V19zlQ9S5x/44ZRT30bkjcdflhWJCpZ5+biDSwyPIQpAHeymQqV6ZQ8h
YCMNDr5tBQgG05lxT9gKmRkDkmT8Adw+oVVn6aCmkbZxBXkAF7DOYi9EmdWRORFv
+dbF5znXmMEdIKBBMunOhgNjcHxmYaJvIatwUBUb3eFFmVWPhtzklH8F4aZ/OgxB
blT9BC8Nxvp/ih9bDqoSl60ES4iWvfRubLGWzc72XFdGopv8tz/+hf45bBukSkza
kKHe5Qined3xrGFX+Ziuxw+S9okWcxgkQNgZaOW8O4wTlSBP/yUVp+T6dck+n6+J
pTi8o+jV4K9cijjAyS4l2RPqYQYCrA==
=jtto
-----END PGP SIGNATURE-----

--RXARdUd17SuWWt2W--
