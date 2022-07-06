Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932E568C14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiGFPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiGFPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0B25281;
        Wed,  6 Jul 2022 08:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7295B81D4D;
        Wed,  6 Jul 2022 15:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1CC3411C;
        Wed,  6 Jul 2022 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657119602;
        bh=xMhHwHC2uDhzW2m9VK7V430Th2RabuW1pYiaKT+7YyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9Knr1fSrztlox+P2erTEsftzSm/87Oh8sdpPzAc8SXotb6pNfbahBpRO/+Uv9D5j
         oEFUsDccUhv61TLzHMapttaiKzXrnnBflxLtAWgpfjQCrI1JNUoMOy3TARBdFMEZsc
         5HdLkHE4ePKWBk6Oc8E8yzUZirz74lXWF6EKm4NZN9PpVVPyEoCYjMDG3tLNoprlni
         eLuHeVGEbXfh41dohcUu+Vhn02bFvk9KBn4dz/JN9mbRQzNLPEtAefpnp0zqCaB1zD
         iGP5vOngsbpoQi85XCBIIT9V/m30gHnHWiKx4kD9dZb6f7uWT1LibyAPeV6e61EQi4
         jl0W9ch65YwHA==
Date:   Wed, 6 Jul 2022 15:59:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Cc:     "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Message-ID: <YsWjbPKsXJ1c5XAv@sirena.org.uk>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-2-nandhini.srikandan@intel.com>
 <YsV4yU42in8qqQrw@sirena.org.uk>
 <SJ0PR11MB5816A2F6C1F517E2E332778885809@SJ0PR11MB5816.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b9zIUXi3ZquH2FrJ"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5816A2F6C1F517E2E332778885809@SJ0PR11MB5816.namprd11.prod.outlook.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b9zIUXi3ZquH2FrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2022 at 02:56:30PM +0000, Srikandan, Nandhini wrote:

> > wrote:
> > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > >
> > > Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions
> > interface")
> > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

> > What is the problem and how does this patch fix it?

> The macro was introduced by Serge Semin in the patch set (2cc8d9227bbb) b=
ut it was unused.
> It is used by one of the patches in the current patchset and without the =
fix it leads to compilation error. I had included this in v4 and Serge Semi=
n had asked me to add the "Fixes: 2cc8d9227bbb" tag and keep it at the top =
of the series. So, I have kept it as first patch in this patchset series.=
=20

This is information that ought to be in the changelog.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--b9zIUXi3ZquH2FrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFo2sACgkQJNaLcl1U
h9D2bQf8DuxNzwllw5VZK9szYInYDDLmW17HvwgCa9gGQMuP3DmOjytIxlYEaDK0
gdtnIFda84uJ6c6Cx3TkJoWO0JcSbWCAY/DUCFfh6RJrPqO+Qnjrkom5/rBgD8Pz
mdM0IQYHGKRflT+p4LNaw8HkpDU2YQg89GzhCYAhQRIn/HoLGlAs8u6W0ry5wVJe
sBpRgnoTlt4X+f/Z1tMGZlmdPpu+81wzKkZzQAYx+R3cqqlxorfXstTmxQ76o/sj
BznKJa25OUdegYJQRJUqwHhf7T7hHzFtHfWF84NsIXYs/ZOuUuqBHV1tn9MHI2h1
ZER6KX2lOlk/HeZPupqjgNpersZduw==
=UTmw
-----END PGP SIGNATURE-----

--b9zIUXi3ZquH2FrJ--
