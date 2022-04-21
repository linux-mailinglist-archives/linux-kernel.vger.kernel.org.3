Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79307509B90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387184AbiDUJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387212AbiDUJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:02:41 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7CE10A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:59:50 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 62417C000D;
        Thu, 21 Apr 2022 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650531589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yp2t6r1/cJizv8gsAVbZcbB593pExBxNPqD/pz6SF3A=;
        b=a4ZelfyURHzewJJxbSdtZQ7wVzoFn6O/9NRSQpgxNecSPRR6Iv8s/MSED8PxLSXOnxDKLb
        bNROM/QlpNQKraMw31BF7hi+1iKi/TVfm82jQl/hJWJxQLJIG/ZTaFRcLwAle6EiIRAggO
        K5cT/5nxvi7i+GC+p9Go57/mwLCPuXbSgCJ+tJN/Q7KrNB5jBeSr2uWIDQwZ4U25jCPeq4
        Ji1eq31LJz0lJDCpl0EjHJw1tbMcmXwVGPeEjZ93xDz4uwYx731ATggwppREZU8S92gdX+
        Xqopk5P0M6w9SfMHzyzcQFwf0oTGAlQJwwXYv5c3dRvjwYDvTGCVoI4GmsyRdw==
Date:   Thu, 21 Apr 2022 10:59:45 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or
 bridge"
Message-ID: <YmEdAVwZuA7Wo1Ch@aptenodytes>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t+LLIQxZOAuVSMSL"
Content-Disposition: inline
In-Reply-To: <20220421082358.ivpmtak3ednvddrc@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t+LLIQxZOAuVSMSL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > + Linus
> > + Marek
> > + Laurent
> > + Robert
> >=20
> > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > bridge")' attempted to simplify the case of expressing a simple panel
> > > under a DSI controller, by assuming that the first non-graph child no=
de
> > > was a panel or bridge.
> > >
> > > Unfortunately for non-trivial cases the first child node might not be=
 a
> > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > DisplayPort, or an opp-table represented before the panel node.
> > >
> > > In these cases the reverted commit prevents the caller from ever find=
ing
> > > a reference to the panel.
> > >
> > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > panel or bridge")', in favor of using an explicit graph reference to =
the
> > > panel in the trivial case as well.
> >=20
> > This eventually breaks many child-based devm_drm_of_get_bridge
> > switched drivers.  Do you have any suggestions on how to proceed to
> > succeed in those use cases as well?
>=20
> I guess we could create a new helper for those, like
> devm_drm_of_get_bridge_with_panel, or something.

Oh wow I feel stupid for not thinking about that.

Yeah I agree that it seems like the best option.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--t+LLIQxZOAuVSMSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJhHQEACgkQ3cLmz3+f
v9HoLwf/aITXqerkQmlMKMLUwRbfs60fUvHgKCB/zJv4ZIgY+J04iY1D3CLA7l0s
MyVO/iMlDEbTJG3kGYdN5p+JMPGikC1ClwSH71lNRfARjmV5qe/feOrS4XulGeW1
f8yG8ar9ySlnJe/zyyCP2KiyVditZxCK9dnL0qye1XPpWXhJYdaNH1+EGS/e62oC
b6+HSJ/s0cEXkxQ/iOwWY4TAeDni8/3a9khj5s21BpZNDYvPWEYYScPJlHk55Z3x
6Vbrkps3mzLfNYpjXhU8LDTQFW2Hgk6c8SFMV0Kp4cPZZ/pddcLh4gyQq4XFt/41
coUD7Xf/kpqWXdaeAqoMgzzpcyYIIw==
=rxg5
-----END PGP SIGNATURE-----

--t+LLIQxZOAuVSMSL--
