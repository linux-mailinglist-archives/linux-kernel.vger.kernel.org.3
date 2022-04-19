Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EC50758E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348165AbiDSQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiDSQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:46:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8A3AA45;
        Tue, 19 Apr 2022 09:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46443B81BFC;
        Tue, 19 Apr 2022 16:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BFDC385AB;
        Tue, 19 Apr 2022 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386653;
        bh=HlZzHRRiIXxiYIb7unE9D9JRkVehcUg4A5ffaHMyoGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc8zCW3dJAEjPQAJs+LwmynTREYE96xW0kZPfKMMmVcY1AOJIvJ3q/ycpzIiXNKjm
         9f4pPxSH3rR3YW21RwsvhYYXROgol4QFAbX2s9sRKtt3nsC07FFLGCAABuo/IPrHSc
         reW7SzLtZLTysbKnIL1gaujuzqWhXqRx37R1IunGzqpsAKyxRWvJ1ZJ+y9OUbDXUCX
         wivEJxceHwey1Hkz2QfMkxUIgRV8Ar9J98wiQZej2EcVGc+1neAwYYG2rOPiTaZxok
         PqybMH7WvbH2zSHsDGgX66JJ7x2fpLWqFWnJVfgs2S+CChR6LoREWoBW7xZ1QqJziL
         +mGW/aP06F8ZA==
Date:   Tue, 19 Apr 2022 17:44:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V10 7/9] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Yl7m1z4rriMBkeFJ@sirena.org.uk>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n533obTi995x_rJG_ihUUquF3MQLJt6VMf7=oxyzMUL5DQ@mail.gmail.com>
 <Yl7Nb0mNjt7kV3uV@sirena.org.uk>
 <CAE-0n53zWdrT7S6MKM_aktnj=AwjUKH0XKySwSkfkX8vTv2w9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V9rR58ILWLSg9Vro"
Content-Disposition: inline
In-Reply-To: <CAE-0n53zWdrT7S6MKM_aktnj=AwjUKH0XKySwSkfkX8vTv2w9w@mail.gmail.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V9rR58ILWLSg9Vro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 08:45:47AM -0700, Stephen Boyd wrote:
> Quoting Mark Brown (2022-04-19 07:55:43)

> > > > +static struct platform_driver pm8008_regulator_driver =3D {
> > > > +       .driver =3D {
> > > > +               .name           =3D "qcom-pm8008-regulator",

> > > I'd prefer to use an of_device_id table here. That would let us popul=
ate
> > > a "qcom,pm8008-regulators" node that had the ldo nodes as children and
> > > avoid mfd cells.

> > That's encoding the current Linux way of splitting up drivers into the
> > DT rather than describing the hardware.

> The DT binding has a subnode of the pm8008@8 node for 'regulators'.
> There's also a subnode for gpios (see qcom,pm8008-gpio). The gpio node
> has a reg property, so I'm confused how we can even have the regulators
> container node at the same level as the gpio node with a reg property.
> Every node that's a child of pm8008@8 either needs to have a reg
> property or not.

That seems unfortunate if it's a limitation of DT :/

> What benefit does it have to not describe secondary i2c addresses as
> nodes in DT? I think it's necessary because the reset gpio needs to be

This is a platform device, not an I2C device.  Converting it to an I2C
device and describing the second I2C address as a separate device would
be much less of a confusion here (and I suspect may well reflect the
underlying physical implementation).  I'm mostly concerned about these
platform devices.

The other option would be to describe each regulator the device supports
as a separate IP which does have some hope of being reusable since it
reflects the actual IPs here.

> deasserted before i2c read/write to either address, 8 or 9, will work.
> Otherwise I don't understand. Having the reset puts us into a small bind
> though because child nodes sometimes have a reg property and other times
> don't.

Right, that's an issue and does tie the two I2C addresses of the device
into a single thing.

> What should the final result be? Dropping the regulators node would end
> up with the same problem where ldo1 has no reg property. Adding a reg
> property to ldo1 might work, but it would be a register offset inside
> i2c address 9 while the binding makes it look like a register offset
> within 9. The binding for the container node could get two address
> cells, so that the first cell describes the i2c address offset?

Yeah, I think we want reg properties on the LDOs. =20

> 	i2c {
> 	  pm8008@8 {
> 	    compatible =3D "qcom,pm8008";
> 	    #address-cells =3D <2>;
> 	    #size-cells =3D <0>;
> 	    reset-gpios =3D <&tlmm 23 GPIO_ACTIVE_HIGH>;
>=20
> 	    vdd_l1_l2-supply =3D <&vreg_s8b_1p2>;
>=20
> 	    gpios@0,c000 {
> 	      compatible =3D "qcom,pm8008-gpio", "qcom,spmi-gpio";
> 	      reg =3D <0x0 0xc000>;
> 	      ...
>=20
> 	    };
>=20
> 	    ldo1@1,30 {

This looks sensible to me.

> We don't make a node for each gpio so I don't know why we would make a
> node for each regulator. The above could be changed to have the
> regulators node and a reg property like this

GPIOs tend to be one IP block with one set of registers that provides a
bank of GPIOs.  Regulators tend to be a separate IP block for each
individual regulator, typically repeated multiple times within a single
chip.  A binding that describes the regulators within the device should
generally be describing these individual regulator IPs rather than just
saying "there are some regulators" which doesn't add any information or
promote reuse with other PMICs sharing the same IP.

--V9rR58ILWLSg9Vro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJe5tYACgkQJNaLcl1U
h9D2TAf9FnCeTsouIlxLgzaaesbdlN0c8afCYGJYrSKF7yMHP7yxJIZSzB+I9JBI
VmcnIzMkTanOi/Pv344J0pCpcgWmWO8XeJ06clB9c6A8f2L93PRGnHIqi5BozysS
AMHP5V8Uxr0nB8yj6In3ILqA/xJAJc6YFkkM8KWU0PfdgEEqzX1LCx+oZQ6kcxK+
WNMiQsYFdZ719uWxOInewZiPJJgKQ56QQtxdu/vFOR2k9eNrFX+WJsmNJhK9GKJG
PQKrh1+F8f6cCa4J0DMdOsNpogxDEnMrv7PR+MKHzvnR3sO5x6a3c0I7RP6MqfU8
6dxLfhg4QI4i4kZYBL1LmEgV++pmHQ==
=YO3C
-----END PGP SIGNATURE-----

--V9rR58ILWLSg9Vro--
