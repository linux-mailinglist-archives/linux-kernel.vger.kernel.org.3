Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D60565277
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiGDKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGDKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:34:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F83E0C2;
        Mon,  4 Jul 2022 03:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0DC8CE1370;
        Mon,  4 Jul 2022 10:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D08C3411E;
        Mon,  4 Jul 2022 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656930892;
        bh=VS/AYyc+ImwYSCRUDxdX3kVUKuEf+5x1uWoCR/Jw37I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnJxJbKncct82q2it3jfl8yPLN5Vl5Wz/BK1fPwb/yTgt7WEZq3w0zNLM/LbWkiPH
         n0kOiBJzrZNoOoER3EdZlwhf5cWw6vKZY/uVBlYUKc4z68mFmywcuyE1TmbqJTOuaG
         9L8++iXvUoN/tQzBlhWLoY9vWNQ3LvKkCJrYy9QsFiJ/JN2SFKOnihlmwdeCHUKSVi
         TpCSDoCDRZLuJSrKbBikGl/hxv2GMp1I5zX6PnDoAjTqw0TYLMbk1Js4w64s5SEXUt
         ssQ3VTVPWk5KEQtKEKmyW5nwaMZn3q+ExP9jUT9N1QvL9cBgfopUJCk2JFIRxNfnh6
         0/M4YezvGshAQ==
Date:   Mon, 4 Jul 2022 11:34:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] regmap-irq cleanups and refactoring
Message-ID: <YsLCRvuy8G6W6qku@sirena.org.uk>
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75VdjPVzOQ15S93GDnYz3cUFkHF-sF97f5GhoDEHdM+iFDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="po0Y6nYHTKzOgS/W"
Content-Disposition: inline
In-Reply-To: <CAHp75VdjPVzOQ15S93GDnYz3cUFkHF-sF97f5GhoDEHdM+iFDQ@mail.gmail.com>
X-Cookie: MERYL STREEP is my obstetrician!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--po0Y6nYHTKzOgS/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 03, 2022 at 04:27:49PM +0200, Andy Shevchenko wrote:

> Obviously you haven't rebased it on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/log/?h=for-5.20
> so it may not be applied.

Yes, please send incremental patches against what's already applied.

--po0Y6nYHTKzOgS/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLCwkYACgkQJNaLcl1U
h9BuNQf/cgZs3YjjaGb2PGTakFwrI3boro+UbBxrBJxcYGVqBy+ZjNzVActDW87f
BzDksUw3D935WSmod8q8r0EuJa8RYp8z/+Gl8s/EhzBWoqBf9/I0nZPFNbX18dJW
Hre3I4WGQBv73viStUwrzEmqJBYtLJv1VI3tnGvlDDvlp+b704HZntdT9eHvIVrm
XrQ2KEvmr4I/YU6g1rTSIl7//Qumy9hfiPloUFLeappKroCpzNgeYp+6Ujep2Cou
947r/bywxWfhg+GWwwYAowSqZpH5TtKOQCuzUWEXhPlT6kH9A9mhJE50qoBGbiCs
r1FhoYneE/mFesiBzJcN8s8MFR4yAQ==
=/On5
-----END PGP SIGNATURE-----

--po0Y6nYHTKzOgS/W--
