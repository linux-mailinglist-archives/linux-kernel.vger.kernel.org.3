Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C257C9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiGULUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiGULUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A2E41D2E;
        Thu, 21 Jul 2022 04:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEE861ADD;
        Thu, 21 Jul 2022 11:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE060C3411E;
        Thu, 21 Jul 2022 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658402431;
        bh=F94TfIE1knNCQ1PbA4Yel8RssqfFFH/6UvosT8/A/6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RN09Akc6l/4soLrnBxeLUOsLAGNZwZ5BRP6FiEh667Hp0V+9e+lwgO3lBSfBiBMnL
         aXJWKmfn4bajVh7eZtRno6RTPoKf5giMyjgDGBlMRq4+UyJAakD1LCXY1HhBE9Z0gi
         2UK1osBvwlJ9n2KsHnfGFIwLcRhd7DnzH3RkHlSHds1DGAVKJ9NtoYQpoPKM3Kmgia
         GgaeyMe0OSrqJbdwyJdLq4ZX1m1UntSC8dBMCxPBFc4ZHDcS2RtzWzO8o+98FCDN+X
         iP60VGBDtG3ulVNJbdJD3YaYVs+aIca57i1suuQg9QO18Iofq2QE5t0iZ8AUiQjNLS
         29GR5GdbXwf7g==
Date:   Thu, 21 Jul 2022 12:20:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
Message-ID: <Ytk2dxEC2n/ffNpD@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1DJx7/60zQ9pOY6w"
Content-Disposition: inline
In-Reply-To: <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1DJx7/60zQ9pOY6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 12:31:41PM +0200, Johan Hovold wrote:

If you're copying someone into a thread that's not obviously relevant
for them it's good practice to put a note about it at the top of the
mail to reduce the chances that it just gets deleted unread - people get
copies of all sorts of random stuff for not great reasons (like getting
pulled in by checkpatch due to once having done a cleanup) and are often
quicky to delete things.

> This series breaks USB and PCIe for some SC8280XP and SA540P machines
> where the DP PHY regulators are shared with other PHYs whose drivers do
> not request a load.

> Specifically, the hard-coded vdda-phy load of 21.8 mA added by this
> series, causes several RPMh regulators to now be put in low-power mode.

> I found Doug's suggestion to handle situations like this in regulator
> core:
>=20
> 	https://lore.kernel.org/all/20180814170617.100087-1-dianders@chromium.or=
g/

> but since that was rejected, how do we deal with this generally?

> In the above thread Doug mentioned adding support for load requests to
> further drivers and Bjorn mentioned working around it by adding
> regulator-system-load properties to DT.

> It seems quite likely that changes like this one affects other systems
> too, and the effects may be hard to debug. So a more general solution
> than playing whack-a-mole using DT would be good to have.

You could add a way to specify constant base loads in DT on either a per
regulator or per consumer basis.

--1DJx7/60zQ9pOY6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZNnYACgkQJNaLcl1U
h9C5rgf+MVZe9YmzqkRT4LQel+SV9Vlj1VQpA/dU9mHnpj8r4rEbG0pOqIYr4o6R
cpJPULleczotUgkT2/yF9qKYsAo51HFenpTc3/AAkYqAueTjgHOsZo2RyPs2adr4
DRthG2aRurta36wS8dtMtJqCUNOCOjwSCFJYklfpimdxz/7rMeR3U0z3FKHEcKAR
9EC0r+4Os8oAt4uh/+/fSpZJ3xiPh1J9t9dv8KEop9+ZEbUEz1rAYsZzWLZQi8b1
Sr737G8A0w+5xNdU/Ao00SsEeYU3u+is1wBQmcZGFVt+nvlf0bBYcsMv5pnUHJQ+
RSty8G6tyVlasuFBEcnGC3CnQZ1hjQ==
=jWVX
-----END PGP SIGNATURE-----

--1DJx7/60zQ9pOY6w--
