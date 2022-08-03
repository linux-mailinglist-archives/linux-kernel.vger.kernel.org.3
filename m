Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D275888DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiHCIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiHCIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:50:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C26453;
        Wed,  3 Aug 2022 01:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00AE0B8218A;
        Wed,  3 Aug 2022 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C428C433D6;
        Wed,  3 Aug 2022 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659516620;
        bh=lcBBGQP1cMln4snVW0FD2LaDsPlFtDJyczxrGwOfe/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrIYoUrDNQaIPpBy3vKM446Otlu8KmxoDb7pEMlvauKF7D1Xab/3fdFp1iRDL9kRC
         IM1rVrmCLTUhG5FKX2RFndcSUocoe9fCExwYM0ebi5Hjqbw3DhF+nNrep+i0zz/DPj
         FAIaudx1LT9qDJ1gRdke5kiieCNY3cE3llwzr8aiyNih2Bbw1ISDo0O7ws0RQ0y3Hu
         a0asIBkOeA6fGE0bWLLp0smArL+b7RQ0ovxEqKC6yFwywVyi3AikPnKKQfxsLuI4Lc
         osLerpkW0Mxk6ErF5Wc19cwB8OVlFdZ7VVTekDd+nIQjkw45PLTbTYBlEkx3pIbCfI
         djPijGU1gqHtw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJA5O-0007O7-Fj; Wed, 03 Aug 2022 10:50:38 +0200
Date:   Wed, 3 Aug 2022 10:50:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
Message-ID: <Yuo23sdBe6tI7g5K@hovoldconsulting.com>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
 <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
 <YuPiJWQ1/wQbkvD8@hovoldconsulting.com>
 <YuPps+cvVAMugWmy@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YTsIOlOo8860ehFK"
Content-Disposition: inline
In-Reply-To: <YuPps+cvVAMugWmy@sirena.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YTsIOlOo8860ehFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2022 at 03:07:47PM +0100, Mark Brown wrote:
> On Fri, Jul 29, 2022 at 03:35:33PM +0200, Johan Hovold wrote:
>=20
> > I guess we just need to drop all those regulator-allow-set-load
> > properties for now even if using DT for power-management configuration
> > this way does seem to run against the whole DT-as-hardware-description
> > idea (e.g. we may want to add them back when/if active- and idle loads
> > are specified by the corresponding Linux drivers).
>=20
> Well, there's also a question of if the hardware can usefully make use
> of the facility - is there any non-suspend state where the regulator
> needs to be on but is drawing so little current that it's worth trying
> to select a lower power mode?

Good point.

> > But that doesn't address the problem that was trying to highlight here,
> > and that you had noticed years ago, namely that using set_load only
> > works reliably if *all* consumers use it.
>=20
> > Shouldn't an enabled regulator from a consumer that didn't specify a
> > load somehow result in HPM always being selected (e.g. count as INT_MAX
> > load as Doug suggested some years ago)?
>=20
> Possibly, but note that as well as the consumers with software drivers
> you also have to consider any passive consumers on the board which may
> not have any representation in DT so the actual numbers may well be off
> even if every consumer is trying to keep things up to date.  You also
> come back to the "let's just shove a random number in here" problem.

Right, but some of that could be captured in DT with
'regulator-system-load'.

> For ultimate saftey we probably want a command line option to gate the
> feature which people can set to say they've audited their full
> software/hardware integration stack.

That sounds like it could be useful.
=20
> > At some point in the discussion I thought Mark suggested removing
> > set_load from drivers that don't actually manage active and idle loads.
> > That would also work, at least until the day one of the drivers adds
> > support for idle loads.
>=20
> Yes, if the driver isn't actively managing loads it's probably not doing
> anything useful.

Ok, thanks for confirming. Perhaps we should drop the set_loads() added
to the PHY driver by this series then.
=20
> The difficulties with this sort of system integration question is an
> unfortunate consequence of DT, having to describe what's safe for an
> unknown software stack is fundamentally hard.  I do question how much
> effort it's worth putting into enabling this, especially in cases where
> the regulator is shared - how much power is actually saved in the grand
> scheme of things given that this is only taking effect when the system
> is out of suspend and we tend to be talking about some percentage of the
> power being drawn on something which is presumably already consuming
> very little power for this to be at all relevant?

I tend to agree. Thanks again for your input!

Johan

--YTsIOlOo8860ehFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYuo22gAKCRALxc3C7H1l
CArBAP4+W07nkP4v5zuEdV1LepVpAWJtpTTVnGwdfkVwnr5FAgD+I8xjWidPc2Kq
nD+BAXuccWyyiOPlBuyM2GD/ZXjL1wQ=
=ehiB
-----END PGP SIGNATURE-----

--YTsIOlOo8860ehFK--
