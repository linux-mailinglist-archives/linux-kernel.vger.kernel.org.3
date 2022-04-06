Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21A4F6925
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiDFSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbiDFSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:02:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A93C31E6;
        Wed,  6 Apr 2022 09:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E37B824CF;
        Wed,  6 Apr 2022 16:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4BC385A3;
        Wed,  6 Apr 2022 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649262980;
        bh=uJJ15QEl4i49cXnHED3Xlrdez3bx0yxVBu7hrexjFrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svGCsTGl4ZOWZWYdxBdXG16//JiVZTVUhyC9Rbu5MA+xqd0NPtm9D069dTSNJm5O7
         B2ycWdCA7BIj2Xaru2871adyIKAt9oZ0NR8gtUCOU/iCoMHOPkHWgOnL2AHv+UZrOT
         FYNIZIXr3NePa18g/xhpZxXuFX0jwUPbfdt2hAQABMXzDmcgpYQNOnSc8w9vdBJnud
         DHv9+gLSzazk8yugn5ik7hKDQhVXBayE8Ivsz8qgBpswp325gt4xwyHNhu7W9Hjm+J
         +2Fqm9vzX0oOmAkdA+keRE9fux4sxrtcho/Lt/GXHFYemtowx4hw1p9NZMnNV1jT6s
         DUyL473heWm5w==
Date:   Wed, 6 Apr 2022 17:36:14 +0100
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
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Yk3Bfnxe/meBYokp@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk>
 <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
 <Yk21pdu16lyR8jXm@sirena.org.uk>
 <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IjoZWWSRSsGvnQ0d"
Content-Disposition: inline
In-Reply-To: <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IjoZWWSRSsGvnQ0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2022 at 08:51:48AM -0700, Stephen Boyd wrote:
> Quoting Mark Brown (2022-04-06 08:45:41)

> > There's a MFD parent for it, and if it's for an I2C device for a pm8008
> > why would it have a -regulators in the name?

> There are two i2c devices. One is pm8008 at i2c address 0x8 and one is
> pm8008-regulators at i2c address 0x9. Earlier revisions of this patch
> series were making it very confusing by redoing the pm8008 binding and
> adding the pm8008-regulator i2c address device to the same binding and
> driver.

> My guess is that this is one IC that responds to multiple i2c addresses.
> The "main" qcom,pm8008 address is 0x8 and that supports things like
> interrupts. Then there's an address for regulators at 0x9 which controls
> the handful of LDOs on the PMIC.

So it's like the TI TWL4030 and Palmas - in which case it should
probably be handled similarly?  Note that the original sumbission was
*also* a MFD subfunction, but using a DT compatible to match the
platform device - this is the first I've heard of this being a separate
I2C function.

--IjoZWWSRSsGvnQ0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJNwX0ACgkQJNaLcl1U
h9B29gf/VNgcnxgPqnUBjXYUmRjlkLvLPAHqv6zftYimYYvb2SoWRXx6AZoeWlTR
9khubNBnoLGcF4VrnvA1wKuBSmRZjeegoJ+OqHO4CT1zgiYj42A9hYIGOlN9UMGC
lkaZZE7FqXDdx63L017WeSbqZujG/iOA4WwZxiHR579W3hTyDOurZIZNgLoCIopk
T/1ne3aQJ9VxfxderMqNG1zAYTEcv5AHjsZC2D/gwU/3vatGn1DfPZElf5WJBzxf
MTpfbnChepAPkqV0GangV6eShTuD3XleqnEynWlYnaLRhvShLmsjjFjzB+eP88tm
GyDNGroU0qaFb/keMRy3z4S34Loxeg==
=utPk
-----END PGP SIGNATURE-----

--IjoZWWSRSsGvnQ0d--
