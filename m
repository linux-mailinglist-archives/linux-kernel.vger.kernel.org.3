Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30DF541F06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384681AbiFGWlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380045AbiFGV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348F228F76;
        Tue,  7 Jun 2022 12:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E92556179F;
        Tue,  7 Jun 2022 19:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D33EC385A2;
        Tue,  7 Jun 2022 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654628538;
        bh=/+dp9c2qOp96PowTujprNETvCD+Um2YXJ5ZDF5/Qbss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvahdXaAUjV8mP4ZDViCZu/dMkQAdB0AvljXKcXObCNtgsKwqpm+2HBUO/sIBfhr9
         F0PlvmIB5ugN5ekSQ0rZglUANXuek3jiYRRBDrgIBRucfigdyZdayUo0vV7xZNZBeH
         yvL45oQB28Z+jkA+YhHm9dXE8zj2QWo8tfij3DqrmGrJYVdES9qs1KmG25nAcftQ20
         d036hYoB3LK0xEDeV2OQhauxrhBFInv36ETB+d1HC/6sZlEmU58IsblZh62hsi/P31
         PJ7+sr1W2oYK2w844GGqgR81qFTlFxvUXsFnvyqj+4ln7gmTpd5m9QcIzloOU2zecZ
         2Vkqs+sCWB+Rw==
Date:   Tue, 7 Jun 2022 20:02:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-binding: mfd: Add Richtek RT5120 PMIC support
Message-ID: <Yp+gtJju1H+j88lE@sirena.org.uk>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GhgJliQVyO1woWPn"
Content-Disposition: inline
In-Reply-To: <1654581161-12349-2-git-send-email-u0084500@gmail.com>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GhgJliQVyO1woWPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 01:52:38PM +0800, cy_huang wrote:

> +  richtek,enable-undervolt-hiccup:
> +    type: boolean
> +    description: |
> +      If used, under voltage protection trigger hiccup behavior, else latchup as
> +      default
> +
> +  richtek,enable-overvolt-hiccup:
> +    type: boolean
> +    description:
> +      Like as 'enable-uv-hiccup', it configures over voltage protection to
> +      hiccup, else latchup as default

Why would we not want to have these enabled?  Unless there's some cost
to having them on it seems safer and more helpful to look for problems
with regulation all the time, it might help debug a system.

--GhgJliQVyO1woWPn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfoLQACgkQJNaLcl1U
h9CghwgAhKQP332Duy+3Mo0gptG0yFMJ8gqHIDJs+CdT0ySHCfs2UbGKLcwqX2dh
f27AiBrqexCG8V69PERvcQ9R+cl8hfqXHaU2RHEgLxn+ZAk5aYTxEkdXgEBR8ETb
KCyDNuoRL3nwXXgFAP5G63fQBm/y5ZnjI7yLhrs6WJ/mKjuwW62WSJj+19/sRizO
MaPGokov7fdjc9j7VIouUFu8uy0OToqLBteNICDjrixFQ8jeb9CaHjHhLYuYuLnT
N0cKI1pxV4b16vJQW174/ZG7EjusYXs6odzkv8JpP0pEcdYa1EDMGKo2rYpx2DEN
qRJNQ7ubpVDwad4URK5JKk1nHxw5tA==
=PnDB
-----END PGP SIGNATURE-----

--GhgJliQVyO1woWPn--
