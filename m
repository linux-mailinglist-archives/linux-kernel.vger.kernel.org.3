Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B557D0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiGUQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGUQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:06:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F73FA33;
        Thu, 21 Jul 2022 09:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA32B82579;
        Thu, 21 Jul 2022 16:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCAFC341C0;
        Thu, 21 Jul 2022 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658419601;
        bh=s8xeRnOct+FSrRLuDnVjoDrk1lcFnJ4sNmdHqdLZjyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8GxrIgrPevpvhKSj3MpdPSs883nobdr60tmmqptVY8xAwg1tZMWYU53td+TBqtIF
         92UbCLNtTLb+LO+uPtCi1hdjk6nBHzZtmgWIvVDpNtFEGA3RrkSNG4YpZcg0YvInsk
         4IkOMHjtmqe906fJiSYpERdKfJ3z/RLyhnhSHc95zqOz+VzksnemiTT+UkklIXmjHp
         IO8clZIg9437kflBhXNN6+xzT6YletRme11kZNicQ7VazO6FxL8n/2p8Mq/wg0sVZV
         0VQ1pPJXt+mxM3Dt+66mtmm619fR4AIL1X/4X94KjphqAeo6Qf3iVm54SBR/WOqOME
         xz09WKw54tXfQ==
Date:   Thu, 21 Jul 2022 17:06:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>,
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
Message-ID: <Ytl5icJyICD1fbzP@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
 <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
 <YtlrV5R+JMxb7Dlu@sirena.org.uk>
 <CAD=FV=XDOxy1R5ipD0errwi6GOFz-X6G3_WE34LGLqmWE6_iyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="797VOFF2drkIGdfE"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XDOxy1R5ipD0errwi6GOFz-X6G3_WE34LGLqmWE6_iyw@mail.gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--797VOFF2drkIGdfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 08:43:48AM -0700, Doug Anderson wrote:

> I guess I'd put it this way, though: how many drivers in Linux today
> have _two_ calls to regulator_set_load(): one for the "active" state
> and one for the retention state. Looks like UFS maybe. Any others? For
> most devices the pattern is:

Oh, I'm not saying there's sensible implementations in drivers.  In
general I'd say that as with voltage if a driver is not actively
managing the load during runtime it should not be setting it at all, one
time configuration should be left to the constraints if it's needed.

--797VOFF2drkIGdfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZeYgACgkQJNaLcl1U
h9Bitwf/T7m2MuB1BDNcYxER8zA/bmfsSd02RVjQBt889bIiIQndg6hsiAsYJDzL
YiHt3f0B5VwYWEYQ7qHJJNv2XTnkLyck+/KrZy9mzJifwbD9JuozXIquclLzsUse
NP5zX0uDOJBsNX23i0B/d6R650tJvYSHY3++cxMkHCPFxL7VgB/meefwMrpPdNAJ
DMSiihQNvJRcI8c+Iy41pA4lRJaEl6EG/B3my5nFYsj8+guxaNkLkIpWt8dq2VMl
a6jslx3UiscBq9BxK3MCAvhLON57wr9nnKlFJfaheIqqn1bXKYQ+ufJX2YxPpyXI
1WmQBt54MQiyiEAO777PA6jPhC021Q==
=HOZd
-----END PGP SIGNATURE-----

--797VOFF2drkIGdfE--
