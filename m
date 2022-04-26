Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13F50FEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbiDZNW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350826AbiDZNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:22:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA613C3F0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:19:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AD4795C0178;
        Tue, 26 Apr 2022 09:19:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 09:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650979187; x=1651065587; bh=lFz5ybVQNG
        7NA2bQK4ghrZXQUjs9p+HgINKjUniOd8Q=; b=PxlECZPGEo9Pa9HxMHqTFK77D1
        AJ5ZtX2UdSgX5pQf+f8HI+VFNCJXdPhoQDW9vyzZZr6+uj1HY1i+d90xRYkxQ7tT
        Y23sKgEQkll4MxtEp/8W/3fHHmAleBNeCLJJUNizXlLZFdVxmSgJDP+vL/lLh5JY
        /U96V63p+9m2ts1oHvB1DU20Um9ed0hdCOJQsogTRDqMRgpgzB0NEhYXS0M6zQQL
        k3R4JJYSMEG3mpJ8hMghJpFrdn1+06ZuhnSTAqsjxBpWtoi+a66QylAKw+ju2nuj
        jtjVz9TYgGCs+/WyX31kBKPb6r9Ys8YEeXsz53WityUCPmV2ju9qSyAm+reg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650979187; x=
        1651065587; bh=lFz5ybVQNG7NA2bQK4ghrZXQUjs9p+HgINKjUniOd8Q=; b=Y
        JUlYfj8tAZ0QWws4n0jr1axDdi3p0I8hD4cK7khvBazQ2q9zj1vDd+YSvutLjae+
        HAYbV0L7Yo5nDqtZhzPI1tiDV6pz1KEgSVzmlMialw41CCaQnVYcuQxDDR0Qlmm7
        O/lpwsayfhe5CLoG6C9JESATOvqTbiCAutjTmhHFWRiB8i+ZfijNEiJuFJlJSe5R
        4BSCZFvAkZMX5zfk8nYGFcKw4jTcPTy4P1vrRJ/WAK7RMUoFzuc22rnO9OD3bxZc
        yoPqYhw/KPZX3qqXL0sUB8JsFTzqXhboWxmV+hLFKy82ieZki+MoXumCf38bI8cX
        IRbA78D7OGEdIPKsYYP+A==
X-ME-Sender: <xms:cvFnYsvDl1hygx5Npw1Z2GUtLDHQdbOhn_5wwun6ICtLBPxY6ittLg>
    <xme:cvFnYpfboONyTz2h33kHvQl-R51D7a1MvtewmuX6ulL9U3sielXzxFA5U6WWCSHX3
    _VWbssbNJF6N4nwzR8>
X-ME-Received: <xmr:cvFnYnyBW8n17fxZ7zkIw3idrLsX4viyDk_nH62TtHqTSR01kwoM4JhAE_yVnnmQFYWU0zLTV7XYLQW3q5Lc5Parf1II8B7t3wo6SA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cvFnYvP1fh01Sn5fifYx0NbP6vt0EPlQgKV1RR7GRgsQzzp-rzNd7g>
    <xmx:cvFnYs_OTlJeqtQ5c41FxaQQzSX7h-1eb2k-pHFa9geumrLnYIKDoQ>
    <xmx:cvFnYnWkFoM3dE8iFkbPGvrr33KsVOZKeed8hYjStrXn2Ke0DcQCdA>
    <xmx:c_FnYmeQIZ2THvenUxb9hfJzQvNq7SnwW1drg_yegwCO8fi9a6iu5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 09:19:46 -0400 (EDT)
Date:   Tue, 26 Apr 2022 15:19:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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
Message-ID: <20220426131944.b26rqqmk7gpcplbg@houat>
References: <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <YmfYi5G7hMKLAH3T@pendragon.ideasonboard.com>
 <YmfoiD0r8MD/kr1N@aptenodytes>
 <20220426125401.yyrhg6aeafdjw4ad@houat>
 <20220426125544.mroteu3hvyvlyb6g@houat>
 <Ymft0SM5GNHXjkVb@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zjgg6sdvl66i23h"
Content-Disposition: inline
In-Reply-To: <Ymft0SM5GNHXjkVb@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zjgg6sdvl66i23h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 03:04:17PM +0200, Paul Kocialkowski wrote:
> On Tue 26 Apr 22, 14:55, Maxime Ripard wrote:
> > On Tue, Apr 26, 2022 at 02:54:01PM +0200, Maxime Ripard wrote:
> > > On Tue, Apr 26, 2022 at 02:41:44PM +0200, Paul Kocialkowski wrote:
> > > > On Tue 26 Apr 22, 14:33, Laurent Pinchart wrote:
> > > > > On Tue, Apr 26, 2022 at 09:54:36AM +0200, Paul Kocialkowski wrote:
> > > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > > > + Linus
> > > > > > > > > + Marek
> > > > > > > > > + Laurent
> > > > > > > > > + Robert
> > > > > > > > >=20
> > > > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > > > >
> > > > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node ha=
s panel or
> > > > > > > > > > bridge")' attempted to simplify the case of expressing =
a simple panel
> > > > > > > > > > under a DSI controller, by assuming that the first non-=
graph child node
> > > > > > > > > > was a panel or bridge.
> > > > > > > > > >
> > > > > > > > > > Unfortunately for non-trivial cases the first child nod=
e might not be a
> > > > > > > > > > panel or bridge.  Examples of this can be a aux-bus in =
the case of
> > > > > > > > > > DisplayPort, or an opp-table represented before the pan=
el node.
> > > > > > > > > >
> > > > > > > > > > In these cases the reverted commit prevents the caller =
=66rom ever finding
> > > > > > > > > > a reference to the panel.
> > > > > > > > > >
> > > > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if =
child node has
> > > > > > > > > > panel or bridge")', in favor of using an explicit graph=
 reference to the
> > > > > > > > > > panel in the trivial case as well.
> > > > > > > > >=20
> > > > > > > > > This eventually breaks many child-based devm_drm_of_get_b=
ridge
> > > > > > > > > switched drivers.  Do you have any suggestions on how to =
proceed to
> > > > > > > > > succeed in those use cases as well?
> > > > > > > >=20
> > > > > > > > I guess we could create a new helper for those, like
> > > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > > >=20
> > > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > > >=20
> > > > > > > Yeah I agree that it seems like the best option.
> > > > > >=20
> > > > > > Should I prepare a patch with such a new helper?
> > > > > >=20
> > > > > > The idea would be to keep drm_of_find_panel_or_bridge only for =
the of graph
> > > > > > case and add one for the child node case, maybe:
> > > > > > drm_of_find_child_panel_or_bridge.
> > > > > >=20
> > > > > > I really don't have a clear idea of which driver would need to =
be switched
> > > > > > over though. Could someone (Jagan?) let me know where it would =
be needed?
> > > > > >=20
> > > > > > Are there cases where we could both expect of graph and child n=
ode?
> > > > > > (i.e. does the new helper also need to try via of graph?)
> > > > >=20
> > > > > I still think we should use OF graph uncondtionally, even in the =
DSI
> > > > > case. We need to ensure backward-compatibility, but I'd like new
> > > > > bindings (and thus new drivers) to always use OF graph.
> > > >=20
> > > > I just went over the thread on "drm: of: Improve error handling in =
bridge/panel
> > > > detection" again and I'm no longer sure there's actually still an i=
ssue that
> > > > stands, with the fix that allows returning -ENODEV when possible.
> > > >=20
> > > > The remaining issue that was brought up was with a connector node, =
but it should
> > > > be up to the driver to detect that and avoid calling drm_of_find_pa=
nel_or_bridge
> > > > in such situations.
> > > >=20
> > > > So with that in mind it feels like the child node approach can be v=
iable
> > > > (and integrated in the same helper).
> > > >=20
> > > > We might still want to favor an explicit OF graph approach, but not=
e that
> > > > dsi-controller.yaml also specifies extra properties that are specif=
ic to
> > > > MIPI DSI and I'm not sure there are equivalent definitions for the =
OF graph
> > > > approach.
> > > >=20
> > > > What do you think?
> > >=20
> > > I don't think Laurent's point was to move the child node away from its
> > > DSI controller, that part doesn't make much sense. The panel or bridge
> > > is still accessed through the DSI bus, so it very much belongs there.
> > >=20
> > > What he meant I think was that we mandate the OF graph for all panels,
> > > so for panels/bridges controlled through DCS, you would still list the
> > > output through the graph.
> >=20
> > Also, we're already in a bit of a mess right now. I don't think rushing
> > that kind of patches in a (late) rc is making much sense, but as I said,
> > if you want to start working on this, then I'll take a revert for the
> > next rc, and then we can work calmly on this.
>=20
> As I understand it we either have some broken stuff because of the revert=
 of:
> - drm: of: Lookup if child node has panel or bridge
> - drm: of: Properly try all possible cases for bridge/panel detection
>=20
> because the child node is already used in places, or we can have broken s=
tuff
> because with the patches because with these two patches -ENODEV is no lon=
ger
> returned.
>=20
> Now with the extra patch that I sent:
> - drm: of: Improve error handling in bridge/panel detection
>=20
> we get -ENODEV back, except for the connector case but this one should be
> handled in drivers directly and drm_of_find_panel_or_bridge should not be
> called in that situation.
>=20
> So all in all it seems that all the pieces are there, unless I'm missing
> something.
>=20
> What do you think?

If Bjorn and Thierry can confirm that it indeeds work in their case,
I'll be happy to apply those patches as well.

Maxime

--4zjgg6sdvl66i23h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYmfxcAAKCRDj7w1vZxhR
xXTnAQCJQL37aio+AW8MPPlWvueBRDrDrzKrkVZrXEjuVRKXpAEAvizvqXcfDOdu
lW+hb+lWvkpwLOaOiUMk/M6tF73g4go=
=5ld1
-----END PGP SIGNATURE-----

--4zjgg6sdvl66i23h--
