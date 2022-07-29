Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9476C58514C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiG2OIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiG2OH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:07:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0E2B2;
        Fri, 29 Jul 2022 07:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E56E4CE29C6;
        Fri, 29 Jul 2022 14:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988F6C433D6;
        Fri, 29 Jul 2022 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659103675;
        bh=cUXcZAT76ZabW6lC7i4r3goD7kw1XreIuadvSWS0sng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVItfyvIGROdWste07gaHkciQVKLZj2Wnu4y2OrU7JpKC/VY4NM65LXlENon0y+9+
         RGnVxxrrcwNQMrwI5xl/j1q2tiB0m56dyTwrE2P+jjrAuMHgaNH0EDFq0cjGAvZ9nN
         udvbxRL/YFB5otA8VdvffsLqO1xEHdLSY5pg3EBAaT/zcK1jNCxIWo23TI2PxrxjOr
         IE4mVZg3HQgNqgiiXXAza+Tu/8mkt1QFvnLbSi4d9/OoLob39WGZ4FMIisHvaV2LMo
         fDxc2Jzm2Xonnzh17zMdLEbNPyENcw+EQ0oaySgIGV3AmugxQSKqDnHmd1V7VokRYD
         tLoClKUIJZ+Jw==
Date:   Fri, 29 Jul 2022 15:07:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <YuPps+cvVAMugWmy@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
 <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
 <YuPiJWQ1/wQbkvD8@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMMlcIGCjceHAIpO"
Content-Disposition: inline
In-Reply-To: <YuPiJWQ1/wQbkvD8@hovoldconsulting.com>
X-Cookie: Dime is money.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lMMlcIGCjceHAIpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2022 at 03:35:33PM +0200, Johan Hovold wrote:

> I guess we just need to drop all those regulator-allow-set-load
> properties for now even if using DT for power-management configuration
> this way does seem to run against the whole DT-as-hardware-description
> idea (e.g. we may want to add them back when/if active- and idle loads
> are specified by the corresponding Linux drivers).

Well, there's also a question of if the hardware can usefully make use
of the facility - is there any non-suspend state where the regulator
needs to be on but is drawing so little current that it's worth trying
to select a lower power mode?

> But that doesn't address the problem that was trying to highlight here,
> and that you had noticed years ago, namely that using set_load only
> works reliably if *all* consumers use it.

> Shouldn't an enabled regulator from a consumer that didn't specify a
> load somehow result in HPM always being selected (e.g. count as INT_MAX
> load as Doug suggested some years ago)?

Possibly, but note that as well as the consumers with software drivers
you also have to consider any passive consumers on the board which may
not have any representation in DT so the actual numbers may well be off
even if every consumer is trying to keep things up to date.  You also
come back to the "let's just shove a random number in here" problem.

For ultimate saftey we probably want a command line option to gate the
feature which people can set to say they've audited their full
software/hardware integration stack.

> At some point in the discussion I thought Mark suggested removing
> set_load from drivers that don't actually manage active and idle loads.
> That would also work, at least until the day one of the drivers adds
> support for idle loads.

Yes, if the driver isn't actively managing loads it's probably not doing
anything useful.

The difficulties with this sort of system integration question is an
unfortunate consequence of DT, having to describe what's safe for an
unknown software stack is fundamentally hard.  I do question how much
effort it's worth putting into enabling this, especially in cases where
the regulator is shared - how much power is actually saved in the grand
scheme of things given that this is only taking effect when the system
is out of suspend and we tend to be talking about some percentage of the
power being drawn on something which is presumably already consuming
very little power for this to be at all relevant?

--lMMlcIGCjceHAIpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLj6bIACgkQJNaLcl1U
h9BSSQf/eAdvLr6Oa23fgbGkvVf3vFVUAXordLXh1s2WpGE7ULmzOAETnrSqD+y2
ZBiHcceuxWistf4AYnco7OZYGMeethjT0JUSU0gv6+C6H8oLuMZbI9/krqP8zwN2
Ld5PvOB/fc2KGy/0Ox31e+pnsj8hK0WBQUVwVtalxkM0ltx0n92rwvsJCYK97OP8
JNEt1aa4QEpnmocrB5KcsU1n1uJE4jrq7aZxxi1C+XlOwi8x4I+a6d9F7fnv+8Sc
C6wRxlVsmSTwE7G47dBrk2/jhQZTenfpXwRktn8lrHDvFFHKyx4Yx3N2dGO27nC1
zE9ytCAAJyTBkIPr+OniWH5PKcnfWA==
=tOZj
-----END PGP SIGNATURE-----

--lMMlcIGCjceHAIpO--
