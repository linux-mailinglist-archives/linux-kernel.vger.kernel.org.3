Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8757CE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGUPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiGUPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E71A072;
        Thu, 21 Jul 2022 08:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 442F9B82563;
        Thu, 21 Jul 2022 15:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E0CC341C6;
        Thu, 21 Jul 2022 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658415967;
        bh=iEmEa1bghQME4Urn4Btl4Eo1lTevDlz0kqraFSy09hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riv6ZOqYjXfsw3vz7TWUc+dE1jas5CVrJ8sM2kOqp3U0S+3rILBVwGJEo/nSyix36
         KWA0iV/BZqHlzRcHiXqgn82fZPCspGJgHraeJu1rNdrHvkYClIxqU6NjVto/Z7BVZT
         bHRbsgAC2WbhotfT7/ppHJ5UQhl8ETOwfsy1nua1i2ML9X1kUPRuBMnoP8xl1NrGBj
         MjZTvhH9XQetIPDNb2Drsq2GF3jMWRh4cUCOrkriRXVyGLS6ya4iSIQYfnVQpaH6Ft
         CqHGnI/PFVFDvksibRC4kwK6tmOZeGyKpDs6LcgeDp5mXlMemkstH16TNSYJMSQ5kh
         ZyFAhyc0Xjg1Q==
Date:   Thu, 21 Jul 2022 16:05:59 +0100
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
Message-ID: <YtlrV5R+JMxb7Dlu@sirena.org.uk>
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
 <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
 <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4+965gYIfqnlK5HS"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W0m-x9JC=5hQ3urSNmUp8sY-u8YkNd66yrKfRNAH4rcg@mail.gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4+965gYIfqnlK5HS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 07:49:55AM -0700, Doug Anderson wrote:

> Every single LDO on Qualcomm's PMICs seems to be able to be set in
> "high power mode" and "low power mode", but I think the majority of
> clients only really care about two things: on and in high power mode
> vs. off. I think the amount of stuff peripherals can do in low power
> mode is super limited, so you have to be _really_ sure that the
> peripheral won't draw too much current without you having a chance to
> reconfigure the regulator.

*Generally* a low power mode would be mainly useful for low power
retention type states, not active use.

--4+965gYIfqnlK5HS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZa1YACgkQJNaLcl1U
h9C/YwgAggSqJZzhNITYTlghSm/AWQaIAIVhEGIeegfsi2pZcxO5KOqw/xYl+q4A
D2JtlyMbsXW5ca0/fk45/87qmjXS5UfIBQliyfda4upNtQ2lPbAUe9fpltwGmOPY
f3xRGPlyKZNXAtNya9RCUJwYcG9zi4QIplBvRF0rvNdd+hkvfsOqVUcD8f7xB+GN
aW67ivRaseeGqFewmetRGUj4QC8Gr8cZgkc1YYSAAHHFlKToY3G8WiF4v2Y2tfNh
I2DK6ADm/mkXCqqqNXcozM9994DU8jR0GK1Be1PGoxOFnYpwxR57CuP0NB+9v+n8
4sW5BhjQndCZ6vsuX8fHcwaH5PIU+Q==
=auZa
-----END PGP SIGNATURE-----

--4+965gYIfqnlK5HS--
