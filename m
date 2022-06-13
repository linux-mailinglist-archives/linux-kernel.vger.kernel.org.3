Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D0548D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiFMMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357911AbiFMMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:40:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633D5E765;
        Mon, 13 Jun 2022 04:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A92F0B80EAB;
        Mon, 13 Jun 2022 11:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A13AC34114;
        Mon, 13 Jun 2022 11:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655118612;
        bh=ysTzCSVV24kvBgFjlX37clypDz+WRKQW7bm6VX99N10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+3XFoKIFhQ5IRWE2YKcIEKmkDj65GURycRWtlKhP6Oa6O9W6aHk/KNvdBFm1Vruw
         12tCPj7tlVyHiQpYNrXRZEcpldtcMcdqrbkOGiOPqUqJgBr5qN6qRlwiRnAt6pQ6+p
         CickUkUhWokIQhG70B869TI/Efx/rdNOpkT2hRv6eujimd/HU4pxACA1k05mdQxsMU
         illFBOfWe6g32VoeTkUw+z0pJe7Z2CSwIzCvpsnFVowTBfAu3x3X0eAjX7LRydIpGO
         67x4ezUn3JXwTbpujxEAyRanPOsdjI6bLu6NNzr/QOj7obO+QT2kwwyeQNzbqCQfaQ
         sg32Fq7sBw54A==
Date:   Mon, 13 Jun 2022 12:10:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: rt5120: Add PMIC regulator support
Message-ID: <YqcbDfceSusNea6v@sirena.org.uk>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com>
 <Yp+gS6r5Kpi33Ags@sirena.org.uk>
 <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
 <YqB19O/HYvEAxdiM@sirena.org.uk>
 <CADiBU390XRXZ2yx5CT2NxhN3aROHXcxs7w2d-xhB6+EYn+uTfA@mail.gmail.com>
 <YqMlDVMlukNAns5S@sirena.org.uk>
 <CADiBU383BxOttuoLdF2GjXHasoPMc634wsMr3zLC=v74OBGUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kKAeemGxMnyjw3U9"
Content-Disposition: inline
In-Reply-To: <CADiBU383BxOttuoLdF2GjXHasoPMc634wsMr3zLC=v74OBGUmw@mail.gmail.com>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kKAeemGxMnyjw3U9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 09:49:31AM +0800, ChiYuan Huang wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A

> > > Not just buck2/3, buck2/3/4/ldo/exten all need the dynamic handling.

> > Why do the others need it?

> Sometimes, for this kind of general purpose PMIC, it need to provide
> the flexibility.
> Cause buck2 and ldo can already be fixed by the external resistor,
> buck3 and buck4 seems to be fixed by IC default.
> So there may be the same part number and use the postfix to be
> different like as 5120'A'/5120'B', etc...
> And use it to define the voltage for the different IC default for
> buck3 and buck4, and exten behavior.
> That's due to the different application use the different power on
> sequence and default voltages.l

Variants should have separate compatibles, and if the code is doing
something fixed then it shouldn't make any difference if that fixed
thing is written in code or as a data table.

> > > If I put 'of_parce_cb' to make core handling it, the input parameter
> > > 'init_data' is declared as const.
> > > I cannot override the 'apply_uV'.

> > > Right?

> > Yes, that's by design.

> I have traced the code for 'of_get_regulator_init_data' and
> 'set_machine_constraints' in regulator register.
> If I cannot overwrite apply_uV variable, it will cause the
> regulator_register return -EINVAL.

We have a very large number of fixed voltage regulators in use on
various systems which manage perfectly fine without this.  If the
constraints are trying to set something invalid then they're what=20
should be fixed.

> Is the below flow that you suggested?
> 1. of_parse_cb to check min_uV and max_uV, and fill in the fixed_uV in
> regulator_desc

No, the device should just know what voltage the fixed voltage
regulators in the device have.

> 2. provide the duummy set/get voltage  to make set_machine_constraints
> not return '-EINVAL'.

No, people just shouldn't be trying to set the voltage for fixed voltage
regulators.  If the regulators are configurable in hardware then provide
DT properties for whatever is configured (eg, resistors).

--kKAeemGxMnyjw3U9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnGwwACgkQJNaLcl1U
h9CZTQf+MOr5Tyexj1+FN015faiQEB0fmG1qwq3H8bJuCG4cXNbat74r3mZUHc9R
9vgt/GYZln2pSsYaqUZvwUCJCpVJ1fUYmZBeadw9ECnIzKYr6Y8d3C0+YwKOSUGQ
soD0Mh7OPgJfgpnGQMadJfhgddOeWaMGdTT4MMOLaHoyV/kCtakyDmHX+VLq5xC7
r98sZqQXxP2VVLB9Ij6DwNOEHFhwZmgKUR9jzH0xJ8DMgpCMSbw9K/ny823RW9DP
EcN2dzFLEWndO2nzlv1KBTAXJjiZBuh7X6xT0QX476rDymRslI5yz/zRMH9vqAeA
SKR8ryOaNcglNAljdt3CIQgubFOqVw==
=Jknu
-----END PGP SIGNATURE-----

--kKAeemGxMnyjw3U9--
