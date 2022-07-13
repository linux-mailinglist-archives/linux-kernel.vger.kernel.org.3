Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98D9573710
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiGMNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGMNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A426EF;
        Wed, 13 Jul 2022 06:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3FF61C0C;
        Wed, 13 Jul 2022 13:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EACC3411E;
        Wed, 13 Jul 2022 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657718083;
        bh=oYk6PAgMGiWtXcXkOteGGgjoV/CevK+hQrC/zso1/ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7s3VQUaUTgBEpZbTYQ/g9id58XYAj62kISYhHz4P0BPSxl+KoceK/qbP/KRdHrXF
         UocQcai75ia/i/SIPs5wsUmzWCz7zrc6qkF6BZn1RaCPhjg480pMf6rEl/gw1qGKKY
         J/3Xr3cpMqD0aA7RrIP1qOSUwPXcrrGyawWujdOsijq0OltFskrib24nNh8QWvfcZN
         pX8DWwedxRtHSQ10uVDWORCZgOISyjl/+egESBQDA4IIhBc7X6uVXfeajah8hH7PlH
         SRsGJxS9IeOOehA0udENI66mtj4fx4vIlp6s69RPnMRbujePKsQeQ0p2UTSE2NN8o0
         5W0e3YNmi2xtA==
Date:   Wed, 13 Jul 2022 14:14:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <Ys7FPt/KfRjgj3nL@sirena.org.uk>
References: <Yr18M9dzTOWL0m2c@google.com>
 <de1f3f33-0a8c-eb87-694c-16ebf2835720@quicinc.com>
 <Yr6oLlmfWRkiAZG7@google.com>
 <52c6ab15-1cd8-324e-4bcc-c449d8bceb19@quicinc.com>
 <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com>
 <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
 <08460c2a-8e21-f149-edec-ee3523f1b727@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fME9Yj+i5Rh9lYLw"
Content-Disposition: inline
In-Reply-To: <08460c2a-8e21-f149-edec-ee3523f1b727@quicinc.com>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fME9Yj+i5Rh9lYLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 11:20:43AM +0530, Satya Priya Kakitapalli (Temp) wr=
ote:
> On 7/12/2022 6:17 PM, Lee Jones wrote:
> > On Mon, 11 Jul 2022, Satya Priya Kakitapalli (Temp) wrote:
> >=20
> > > On 7/4/2022 6:19 PM, Lee Jones wrote:
> > > > On Mon, 04 Jul 2022, Satya Priya Kakitapalli (Temp) wrote:
> > > >=20
> > > > > On 7/1/2022 2:42 PM, Lee Jones wrote:
> > > > > > On Fri, 01 Jul 2022, Satya Priya Kakitapalli (Temp) wrote:
> > > > > >=20
> > > > > > > On 7/1/2022 1:24 PM, Lee Jones wrote:
> > > > > > > > On Fri, 01 Jul 2022, Satya Priya Kakitapalli (Temp) wrote:
> > > > > > > >=20
> > > > > > > > > On 6/30/2022 4:04 PM, Lee Jones wrote:
> > > > > > > > > > On Thu, 30 Jun 2022, Satya Priya Kakitapalli (Temp) wro=
te:
> > > > > > > > > >=20
> > > > > > > > > > > On 6/29/2022 8:48 PM, Lee Jones wrote:
> > > > > > > > > > > > On Wed, 29 Jun 2022, Satya Priya Kakitapalli (Temp)=
 wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > That's not to say that the v9 submission was the right way to go
> > either.  Everything in relation to:
> >=20
> >    i2c_add_driver(&pm8008_regulators_driver);
> >=20
> > ... should be moved into the Regulator driver itself.

> Mark/Stephen,
>=20
>=20
> Could you please share your inputs on this approach?

I don't have particularly strong opinions.  It does seem like the chip
should be visible as being a single entity in DT if it's a single
physical thing in the schematic and board.

--fME9Yj+i5Rh9lYLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLOxT0ACgkQJNaLcl1U
h9AIqwf/c822cuT8MEVNWVx2rTUwfteCeDrmeqoF8J1KMp7PSj/eyNcgDapREaTu
09uM6kYsnXaAhJp/beBtFFlkSsxthl5nNdD02+VV1Ynu7UQXzWqCJAls9CpQPYAk
dW2eSlhQfq2lgvWgJ+C821TpHEX1zTGPC1AnsntOxErTa/ojQeC4wtpW6gIC7qM6
nJpy2Uayl4VD0Ll02U//WYvXbHoaPK0k+6DMUIevfZLqHUDozfaszoUxN26oh6jl
94RVzmPA2WjC1E6NM2cTE9sRaBJOY6XGhCmT/YhrpfZh4yXXtb9UJVlU95PZjsVy
1Gc/djp0iZWyHhChDWnXt3S4khRFvw==
=Sr/t
-----END PGP SIGNATURE-----

--fME9Yj+i5Rh9lYLw--
