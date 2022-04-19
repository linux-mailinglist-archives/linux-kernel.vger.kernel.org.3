Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D44507126
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbiDSO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353722AbiDSO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438C3525C;
        Tue, 19 Apr 2022 07:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBF461584;
        Tue, 19 Apr 2022 14:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B45C385A7;
        Tue, 19 Apr 2022 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650380149;
        bh=AqW7BlXqIXXJk7SV1e1EapO0IjeR/BAOYBLYxGwHlUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swGQhkQ0wN/dmJsNY1g4Jf3PZEV8p5G2bWNyWXp6aQE9XQBqNU8uJJJ4cm4ZiZ2uE
         +iesXBhteb1hOx5+BXb+rpFJAPPVgMzPkx+3Nb4MajajaAZ4Sh24k44vPd2+GBbEIX
         P6Yeuegm0teTGSsfOBGzAtAZei/QA6dMA5NATeezm6e33TsHoOy/R8OWc3wst0G+sr
         MAfdofSzdHSfmmN5kyVx5gHSqXsFsjjLMAIxP5PGc/j5ws6nBRTFj54YyLkLXUw9O2
         N/60E42patg34BmLvC66PB1zBWM5H3vMHy9/Ubb2OEP+rGK3YshXsWXEDyJ9yvk/aT
         c6rynYHqwRD1Q==
Date:   Tue, 19 Apr 2022 15:55:43 +0100
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
Message-ID: <Yl7Nb0mNjt7kV3uV@sirena.org.uk>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n533obTi995x_rJG_ihUUquF3MQLJt6VMf7=oxyzMUL5DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgIXoV2XBfJmzGtV"
Content-Disposition: inline
In-Reply-To: <CAE-0n533obTi995x_rJG_ihUUquF3MQLJt6VMf7=oxyzMUL5DQ@mail.gmail.com>
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


--xgIXoV2XBfJmzGtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2022 at 05:25:49PM -0700, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-14 05:30:16)

> > +static struct platform_driver pm8008_regulator_driver = {
> > +       .driver = {
> > +               .name           = "qcom-pm8008-regulator",

> I'd prefer to use an of_device_id table here. That would let us populate
> a "qcom,pm8008-regulators" node that had the ldo nodes as children and
> avoid mfd cells.

That's encoding the current Linux way of splitting up drivers into the
DT rather than describing the hardware.

--xgIXoV2XBfJmzGtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJezW8ACgkQJNaLcl1U
h9CHlQf/SfDYm+bgiFNO/+eLj38zgXokwbbiT9deWgN2aYkZy60/A2Ps2Noi2dtT
bZ7untJiUelfBeNawv1WOu1iI1Gr4eRYBMK1r3stWu6gwLlQZKrou5B6Qfi7hEcI
/4P5co/b0g6XbKUYGfcTwmMDiCzcycwwmhK9CFL7wOuHaPseV9Zqy+AhzZL/A85W
TRqLznvoEfS3IMFxP0lnsEZkCpzKcOC8UK0qkFdUI7uPtRA73dEbQU8R5k8BAgXt
kvjcDWbUkVWNwr/tswF2oehY+OKlSTMlx2rlVJB/FCQpm/XvfCE1gHH/0nwa6qqb
OT/OxrogzuEuEtz7rmkyhzCF5lNIFw==
=lzLV
-----END PGP SIGNATURE-----

--xgIXoV2XBfJmzGtV--
