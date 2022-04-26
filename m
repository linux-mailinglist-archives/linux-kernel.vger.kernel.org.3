Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6F50FDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbiDZMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350208AbiDZMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:54:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5017B9AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:51:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 90E195C0106;
        Tue, 26 Apr 2022 08:51:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Apr 2022 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650977483; x=1651063883; bh=bkzAlLIoQS
        awEUnz7mkXtxaOlW4qcmEvjLrJFPw9Xr0=; b=hpeRNI523p/syAbZiXp6FOclQP
        lLtz+Q4WAxippoCu9gR9rdrdf/xjboZTwVso9WzoIs5Drn9Tis5EflPM5ftqatNY
        96sMLT4Gb6PxRNT34TkFRBo1ZX6VrZhKieugfWgoK0zPESt5Rv1e3GRICBBwTLu9
        cPAWuR2iONTelV15YbOeA7CSR39GJUlIZ4IvRumAiYatdPeyGGza2eCtBGnD3BUM
        M8nXNAMHEpABQgSg/pSklIJtCY//3IQjYmDxswz3Aiv89+m+WrpVDBASCZRtxnsx
        g2hf0jp3SeBE74q5Ad/avbLdR1m8Jb73BYU/KGh2ryT8t3ZD5gmZYO6eFMtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650977483; x=
        1651063883; bh=bkzAlLIoQSawEUnz7mkXtxaOlW4qcmEvjLrJFPw9Xr0=; b=e
        PW2B72iQGyE7nHjCnOKFjZymHCBp2J7lo2+bgf47WeJqB9aioNmziq6n+gHjHHhj
        H+R2rpC9e9BgM7oGQQ4ue+NrSeQAlALKHeeNC2ofFgAf2Vzej7delJeD+pTx2M6l
        q/Jv3GrZLiyS2lSPVZa8uJfRQDh2kEsk3xTJsZ7XFb1W3Dxk78XagJ6xrz8QofFG
        lzPbnPtLeuJ6Ti3a/8XWR+wAWzvtFRQ9QKFrEmzuKanAbviUgSOwyxx8htEQ507v
        CKSMfAEvSf/HsSToskSyHwcl2zTMFiz9Qsu/gKWoSTfmxpGfuiRZJnCH4lnHjnlK
        7FN7cRhfeyfnIqwwcZD7w==
X-ME-Sender: <xms:yupnYh806ZifturwVJSouGNKN86GoN1YasTVxz88GrDlaz0sCP4z_Q>
    <xme:yupnYlsnqdZ9iYA_CUm6YIW44msxkyNkS6JogitowAnTajB4LAcBPDecPWUq9AZt3
    mqySHu2aDW-c5gS45Y>
X-ME-Received: <xmr:yupnYvDbpYgmNXGbUSXiv3CbOYZT4asmGXCxZrUWjkirxwVwJ6vccImujFMlvEQBJTaJ2lRVfPy9NdQ8U_6e2YYgrJyjpeKU1YLJNZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:yupnYlexW1ihRzQTWxAB5BxHi376tD0s872x3wL5w5SAEVJJPgcTkg>
    <xmx:yupnYmNw1ir75-pNOvv0x_8i37tRjp3GY9diiASpqwMCEPtjIWiQAg>
    <xmx:yupnYnlocdxzCCES9HEsBCuev-2669NVLFo5HHY8d0nSBgmJWbtuOQ>
    <xmx:y-pnYgvPkmxr-dLXk-q7WZA-RhACNozMQYXI4Jlk2IWdfbH5MJN2dQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 08:51:22 -0400 (EDT)
Date:   Tue, 26 Apr 2022 14:51:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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
Message-ID: <20220426125120.igco26jgedqbg7gq@houat>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6hd5dy5ajyjrsut"
Content-Disposition: inline
In-Reply-To: <YmelPCcWCCjALtRU@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c6hd5dy5ajyjrsut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 09:54:36AM +0200, Paul Kocialkowski wrote:
> On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > Hi Maxime,
> >=20
> > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > + Linus
> > > > + Marek
> > > > + Laurent
> > > > + Robert
> > > >=20
> > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > > > >
> > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > bridge")' attempted to simplify the case of expressing a simple p=
anel
> > > > > under a DSI controller, by assuming that the first non-graph chil=
d node
> > > > > was a panel or bridge.
> > > > >
> > > > > Unfortunately for non-trivial cases the first child node might no=
t be a
> > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > >
> > > > > In these cases the reverted commit prevents the caller from ever =
finding
> > > > > a reference to the panel.
> > > > >
> > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node=
 has
> > > > > panel or bridge")', in favor of using an explicit graph reference=
 to the
> > > > > panel in the trivial case as well.
> > > >=20
> > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > succeed in those use cases as well?
> > >=20
> > > I guess we could create a new helper for those, like
> > > devm_drm_of_get_bridge_with_panel, or something.
> >=20
> > Oh wow I feel stupid for not thinking about that.
> >=20
> > Yeah I agree that it seems like the best option.
>=20
> Should I prepare a patch with such a new helper?
>=20
> The idea would be to keep drm_of_find_panel_or_bridge only for the of gra=
ph
> case and add one for the child node case, maybe:
> drm_of_find_child_panel_or_bridge.
>=20
> I really don't have a clear idea of which driver would need to be switched
> over though. Could someone (Jagan?) let me know where it would be needed?
>=20
> Are there cases where we could both expect of graph and child node?
> (i.e. does the new helper also need to try via of graph?)

Yeah, we should figure it out this week. I mentioned this to Dave, who
in turn talked about it Linus, so the fastest it's figured out the best.

The helper would probably be best, but if you don't have time to do it
by then, we can always revert those 3 patches until a helper is there.

Maxime

--c6hd5dy5ajyjrsut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYmfqyAAKCRDj7w1vZxhR
xZ+5AQDbkLpeptrXStRJGMAtSC9Yfh9x5WW8JZmaZY84TKASJgEAzE4K4iW2BTVX
LgxJn8QMF+AdINUAVerCZbtqkP3HDA8=
=g5uI
-----END PGP SIGNATURE-----

--c6hd5dy5ajyjrsut--
