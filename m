Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272A50FE40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbiDZNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiDZNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:07:33 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050833C4AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:04:25 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 684AE60006;
        Tue, 26 Apr 2022 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650978264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jCSFtDEXma9lbCkiIXY8JUDo2JfljVX+CBMPr5jBisc=;
        b=buMxvzg22fWSxg0PtK0DJ/qzXQBzywEz8VN533yw9Jo8rd69YDS/Bu8nR2XiT0KRC1Ywfp
        QqTu8hhLZIAfOnn3gytz8yFAdFM+9t+txysKl4pMGHDfiNt6ft3Ed8StggoMyAQoYkPsFR
        J0Ur4mGRbS6LxBQUFtmCZ3UCZ5PKWPDd6ufHLU8ATp+QbjR+1eYespWZ4ha5THthJF+yMZ
        tOi5uxSPbnO9Men1zs5iInduDnzSggG6N+kE1e1s2WMrm5+ModJKjN9HY9GD9FFBFT59t3
        LeYiPtG2LsqwzTFbfIWz5mfGlGy89P9Ek7zStjjYR72NEIZ1VehbNz/9336rAA==
Date:   Tue, 26 Apr 2022 15:04:17 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
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
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or
 bridge"
Message-ID: <Ymft0SM5GNHXjkVb@aptenodytes>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <YmfYi5G7hMKLAH3T@pendragon.ideasonboard.com>
 <YmfoiD0r8MD/kr1N@aptenodytes>
 <20220426125401.yyrhg6aeafdjw4ad@houat>
 <20220426125544.mroteu3hvyvlyb6g@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kp1fAdMNJwvUyuYn"
Content-Disposition: inline
In-Reply-To: <20220426125544.mroteu3hvyvlyb6g@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kp1fAdMNJwvUyuYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 26 Apr 22, 14:55, Maxime Ripard wrote:
> On Tue, Apr 26, 2022 at 02:54:01PM +0200, Maxime Ripard wrote:
> > On Tue, Apr 26, 2022 at 02:41:44PM +0200, Paul Kocialkowski wrote:
> > > On Tue 26 Apr 22, 14:33, Laurent Pinchart wrote:
> > > > On Tue, Apr 26, 2022 at 09:54:36AM +0200, Paul Kocialkowski wrote:
> > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > > + Linus
> > > > > > > > + Marek
> > > > > > > > + Laurent
> > > > > > > > + Robert
> > > > > > > >=20
> > > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > > >
> > > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has =
panel or
> > > > > > > > > bridge")' attempted to simplify the case of expressing a =
simple panel
> > > > > > > > > under a DSI controller, by assuming that the first non-gr=
aph child node
> > > > > > > > > was a panel or bridge.
> > > > > > > > >
> > > > > > > > > Unfortunately for non-trivial cases the first child node =
might not be a
> > > > > > > > > panel or bridge.  Examples of this can be a aux-bus in th=
e case of
> > > > > > > > > DisplayPort, or an opp-table represented before the panel=
 node.
> > > > > > > > >
> > > > > > > > > In these cases the reverted commit prevents the caller fr=
om ever finding
> > > > > > > > > a reference to the panel.
> > > > > > > > >
> > > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if ch=
ild node has
> > > > > > > > > panel or bridge")', in favor of using an explicit graph r=
eference to the
> > > > > > > > > panel in the trivial case as well.
> > > > > > > >=20
> > > > > > > > This eventually breaks many child-based devm_drm_of_get_bri=
dge
> > > > > > > > switched drivers.  Do you have any suggestions on how to pr=
oceed to
> > > > > > > > succeed in those use cases as well?
> > > > > > >=20
> > > > > > > I guess we could create a new helper for those, like
> > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > >=20
> > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > >=20
> > > > > > Yeah I agree that it seems like the best option.
> > > > >=20
> > > > > Should I prepare a patch with such a new helper?
> > > > >=20
> > > > > The idea would be to keep drm_of_find_panel_or_bridge only for th=
e of graph
> > > > > case and add one for the child node case, maybe:
> > > > > drm_of_find_child_panel_or_bridge.
> > > > >=20
> > > > > I really don't have a clear idea of which driver would need to be=
 switched
> > > > > over though. Could someone (Jagan?) let me know where it would be=
 needed?
> > > > >=20
> > > > > Are there cases where we could both expect of graph and child nod=
e?
> > > > > (i.e. does the new helper also need to try via of graph?)
> > > >=20
> > > > I still think we should use OF graph uncondtionally, even in the DSI
> > > > case. We need to ensure backward-compatibility, but I'd like new
> > > > bindings (and thus new drivers) to always use OF graph.
> > >=20
> > > I just went over the thread on "drm: of: Improve error handling in br=
idge/panel
> > > detection" again and I'm no longer sure there's actually still an iss=
ue that
> > > stands, with the fix that allows returning -ENODEV when possible.
> > >=20
> > > The remaining issue that was brought up was with a connector node, bu=
t it should
> > > be up to the driver to detect that and avoid calling drm_of_find_pane=
l_or_bridge
> > > in such situations.
> > >=20
> > > So with that in mind it feels like the child node approach can be via=
ble
> > > (and integrated in the same helper).
> > >=20
> > > We might still want to favor an explicit OF graph approach, but note =
that
> > > dsi-controller.yaml also specifies extra properties that are specific=
 to
> > > MIPI DSI and I'm not sure there are equivalent definitions for the OF=
 graph
> > > approach.
> > >=20
> > > What do you think?
> >=20
> > I don't think Laurent's point was to move the child node away from its
> > DSI controller, that part doesn't make much sense. The panel or bridge
> > is still accessed through the DSI bus, so it very much belongs there.
> >=20
> > What he meant I think was that we mandate the OF graph for all panels,
> > so for panels/bridges controlled through DCS, you would still list the
> > output through the graph.
>=20
> Also, we're already in a bit of a mess right now. I don't think rushing
> that kind of patches in a (late) rc is making much sense, but as I said,
> if you want to start working on this, then I'll take a revert for the
> next rc, and then we can work calmly on this.

As I understand it we either have some broken stuff because of the revert o=
f:
- drm: of: Lookup if child node has panel or bridge
- drm: of: Properly try all possible cases for bridge/panel detection

because the child node is already used in places, or we can have broken stu=
ff
because with the patches because with these two patches -ENODEV is no longer
returned.

Now with the extra patch that I sent:
- drm: of: Improve error handling in bridge/panel detection

we get -ENODEV back, except for the connector case but this one should be
handled in drivers directly and drm_of_find_panel_or_bridge should not be
called in that situation.

So all in all it seems that all the pieces are there, unless I'm missing
something.

What do you think?

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--kp1fAdMNJwvUyuYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJn7dEACgkQ3cLmz3+f
v9HVtAf/f7tPiKRGygWE348IHEtpyq8KZmd80iWQyy9BC0PpLZznaCxmjllp0Ws0
OX5E/9VNep4QlCqwZJPGoNaocukhJgdoQqk6u5cI4Llq8gsdjVGkP2X5mybJAS0w
z9glcVQbPTQMbUy9t2cvM1F4df9HfMHvBxXbW4HCsF+JsuqT7Xk00c36qcH8wgoT
i0a3SZ0tHcgK2FVbE0IVOpKf3tlCLQp/IQJzB+Te/HwBHYeXvAL7F+NXaQvUBNex
0TPa7N+wh+VhRIcDPzwxf2kAGN+qGNi38LbEKqOEsN0fNbFzsOhhAP1xIXoEM+6S
eUcBEDd1IV30JcKMh+8VmZgHZsz8cQ==
=RTlr
-----END PGP SIGNATURE-----

--kp1fAdMNJwvUyuYn--
