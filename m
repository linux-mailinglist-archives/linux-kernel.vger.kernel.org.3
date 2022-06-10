Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE468546504
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbiFJLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiFJLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C58150B76;
        Fri, 10 Jun 2022 04:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762AA620B0;
        Fri, 10 Jun 2022 11:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF01C34114;
        Fri, 10 Jun 2022 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859026;
        bh=d3teMe1GHQS7aV22K7pnFmgNykOeozpCHzcj+b1esUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6rwH1pI5WnoAJBikK/Gkfp0iy/f681q40OO+ZCdaFWTpZJNPmiY1HJ2rR8l+SH7J
         O3HQQ7tHRL/e5habe3Az5C+V4dDGg64woxqedw8uo76RFXdmxkLHWw9G7vCrJ00spa
         EsUBStRaWENyWf+GPPLa6Hjwf50uimZsAtu95vElovjO2uhaoHXx8h7FxCnI1ocTLK
         s4I9/NfViIr5DkHGEvncBm0L+xiaiECtrQLvGgzIrgxWnmYkH7XidaL/US20nja5pW
         ZOjCsfBGhSR6Cg1rQjQwd4sdaxhQlRVV7BMmOgnBVMQetPBiHJNeIqRubLE92rq7tc
         3NOWBgFdKDlHA==
Date:   Fri, 10 Jun 2022 12:03:41 +0100
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
Message-ID: <YqMlDVMlukNAns5S@sirena.org.uk>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com>
 <Yp+gS6r5Kpi33Ags@sirena.org.uk>
 <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
 <YqB19O/HYvEAxdiM@sirena.org.uk>
 <CADiBU390XRXZ2yx5CT2NxhN3aROHXcxs7w2d-xhB6+EYn+uTfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eWHlLQ5aB+zBDiA"
Content-Disposition: inline
In-Reply-To: <CADiBU390XRXZ2yx5CT2NxhN3aROHXcxs7w2d-xhB6+EYn+uTfA@mail.gmail.com>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eWHlLQ5aB+zBDiA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 02:35:07PM +0800, ChiYuan Huang wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A
> > On Wed, Jun 08, 2022 at 11:15:56AM +0800, ChiYuan Huang wrote:

> > > My excuse. let me explain it.
> > > buck1 voltage range from 600mV to 1393.75mV.
> > > buck2~4/ldo/exten is the fixed regulator.
> > > buck3 and buck4 is fixed by the IC efuse default.
> > > buck2 and ldo is fixed by the external resistor chosen.
> > > exten is designed to connected to the external power.

> > > That's why I cannot directly declared it as the static regulator_desc.

> > So buck 2-4 need some dynamic handling then but the rest can be static -
> > that would be a lot clearer.  You could also have a template for the
> > ones with some dynamic values and just override the few fields that need
> > it.

> Not just buck2/3, buck2/3/4/ldo/exten all need the dynamic handling.

Why do the others need it?

> > > > Drivers should never override constraints passed in by machine driv=
ers,
> > > > if there's validation needed let the core do it.  The same probably
> > > > applies to providing a voltage range for a fixed regulator though t=
hat's
> > > > not modifying everything so not such a problem.

> > > Please check the above explanation about each power rails.

> > I'm not sure what you're referencing here?

> Sorry. Let me explain it.

> You mean 'of_parse_cb' must not override constraint.
> But if the regulator is fixed and dynamic, after
> 'of_get_regulation_constraint', apply_uV will be true.
> The is referring to 'fixed.c'

fixed.c is a special case due to legacy issues and being generic, for
normal fixed voltage regulators in a device where we know what they're
fixed to they can just have their voltage hard coded in the driver.  If
there's issues with the machine providing invalid or nonsensical
constraints the driver should just let the core deal with them.

> > > > This is all open coding stuff that's in the core - just provde an
> > > > of_parse_cb() operation and let the core take care of calling it.

> > > Ditto

> > Or here.

> If I put 'of_parce_cb' to make core handling it, the input parameter
> 'init_data' is declared as const.
> I cannot override the 'apply_uV'.
> Right?

Yes, that's by design.

--9eWHlLQ5aB+zBDiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjJQwACgkQJNaLcl1U
h9BwbQf8CDon0DOTyygjzDQP19A8QQ9eIkDydN4RwUztGzO1oZZqgyPddsborEnm
enToWNLNXMvBEUM6ybjKDOi4Ac5UxHfxPW5tci2AOWfX6/LREJFiQR/ekmLPhgj9
Cizn5N/0HstZFFm5g/lfsEYtxyCtVdd6StaeLXsGI2LD282RMqLhuyuq+1gmmv4v
AOVc1KfT3CWAsiA1yYGY8TOugdKahJmuNAmAE9kH/JduhtPJMSG0jwhrlY9zHr46
m/9ePyvPYkStQ28gQEgogcC6kUGHL/gZ9aEy/wCpKAUNtXw49bFDgImT1bmiVE3O
vtsKqJOL7LmZ2pIyfeIKDPPiBJAUAQ==
=xKE/
-----END PGP SIGNATURE-----

--9eWHlLQ5aB+zBDiA--
