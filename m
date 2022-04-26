Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C450FF89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbiDZNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiDZNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:53:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707763B8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:50:32 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A9C4240009;
        Tue, 26 Apr 2022 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650981031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6XgvVh839fONZ5t6sjFwROaNYkFhyqssCOVqj2NRek=;
        b=FRlYSoX7l7fBxxPml5pNFkzRTDpZ6qW1fNZheabGwS00Kbpe6tjo4fyQTuRxutYkAqiOSi
        0S6h+JG5kNMoTRb6rHJ3y+MPeXHkWNoiiqEWo0LxOcT3fucBFvSERqHeIngv/X8neARb+a
        QEgugv7Ifo9poX0cgGnkw5SzLmtn6ySzhjzB67cOXS8Zgni/f2UEJZuxKhLSY7pbBVY+aQ
        wGVDn2HRUKDPwbN6Gb98CE38Nnzmw7Klrt+uyQWv2+wpMe/63lg4l0DXqtIutfXpaj+qHC
        vrpObd8GUfPNj8+Aa27IsB0QKorssHxsiaaELJ2l5oj/Rm8lIBGVRYY851qhVg==
Date:   Tue, 26 Apr 2022 15:50:22 +0200
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
Message-ID: <Ymf4nmQAkEciwyt/@aptenodytes>
References: <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <YmfYi5G7hMKLAH3T@pendragon.ideasonboard.com>
 <YmfoiD0r8MD/kr1N@aptenodytes>
 <20220426125401.yyrhg6aeafdjw4ad@houat>
 <20220426125544.mroteu3hvyvlyb6g@houat>
 <Ymft0SM5GNHXjkVb@aptenodytes>
 <20220426131944.b26rqqmk7gpcplbg@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4GhhnGEmAES0hXPy"
Content-Disposition: inline
In-Reply-To: <20220426131944.b26rqqmk7gpcplbg@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4GhhnGEmAES0hXPy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 26 Apr 22, 15:19, Maxime Ripard wrote:
> On Tue, Apr 26, 2022 at 03:04:17PM +0200, Paul Kocialkowski wrote:
> > On Tue 26 Apr 22, 14:55, Maxime Ripard wrote:
> > > On Tue, Apr 26, 2022 at 02:54:01PM +0200, Maxime Ripard wrote:
> > > > On Tue, Apr 26, 2022 at 02:41:44PM +0200, Paul Kocialkowski wrote:
> > > > > On Tue 26 Apr 22, 14:33, Laurent Pinchart wrote:
> > > > > > On Tue, Apr 26, 2022 at 09:54:36AM +0200, Paul Kocialkowski wro=
te:
> > > > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrot=
e:
> > > > > > > > > > + Linus
> > > > > > > > > > + Marek
> > > > > > > > > > + Laurent
> > > > > > > > > > + Robert
> > > > > > > > > >=20
> > > > > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > > > > >
> > > > > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node =
has panel or
> > > > > > > > > > > bridge")' attempted to simplify the case of expressin=
g a simple panel
> > > > > > > > > > > under a DSI controller, by assuming that the first no=
n-graph child node
> > > > > > > > > > > was a panel or bridge.
> > > > > > > > > > >
> > > > > > > > > > > Unfortunately for non-trivial cases the first child n=
ode might not be a
> > > > > > > > > > > panel or bridge.  Examples of this can be a aux-bus i=
n the case of
> > > > > > > > > > > DisplayPort, or an opp-table represented before the p=
anel node.
> > > > > > > > > > >
> > > > > > > > > > > In these cases the reverted commit prevents the calle=
r from ever finding
> > > > > > > > > > > a reference to the panel.
> > > > > > > > > > >
> > > > > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup i=
f child node has
> > > > > > > > > > > panel or bridge")', in favor of using an explicit gra=
ph reference to the
> > > > > > > > > > > panel in the trivial case as well.
> > > > > > > > > >=20
> > > > > > > > > > This eventually breaks many child-based devm_drm_of_get=
_bridge
> > > > > > > > > > switched drivers.  Do you have any suggestions on how t=
o proceed to
> > > > > > > > > > succeed in those use cases as well?
> > > > > > > > >=20
> > > > > > > > > I guess we could create a new helper for those, like
> > > > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > > > >=20
> > > > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > > > >=20
> > > > > > > > Yeah I agree that it seems like the best option.
> > > > > > >=20
> > > > > > > Should I prepare a patch with such a new helper?
> > > > > > >=20
> > > > > > > The idea would be to keep drm_of_find_panel_or_bridge only fo=
r the of graph
> > > > > > > case and add one for the child node case, maybe:
> > > > > > > drm_of_find_child_panel_or_bridge.
> > > > > > >=20
> > > > > > > I really don't have a clear idea of which driver would need t=
o be switched
> > > > > > > over though. Could someone (Jagan?) let me know where it woul=
d be needed?
> > > > > > >=20
> > > > > > > Are there cases where we could both expect of graph and child=
 node?
> > > > > > > (i.e. does the new helper also need to try via of graph?)
> > > > > >=20
> > > > > > I still think we should use OF graph uncondtionally, even in th=
e DSI
> > > > > > case. We need to ensure backward-compatibility, but I'd like new
> > > > > > bindings (and thus new drivers) to always use OF graph.
> > > > >=20
> > > > > I just went over the thread on "drm: of: Improve error handling i=
n bridge/panel
> > > > > detection" again and I'm no longer sure there's actually still an=
 issue that
> > > > > stands, with the fix that allows returning -ENODEV when possible.
> > > > >=20
> > > > > The remaining issue that was brought up was with a connector node=
, but it should
> > > > > be up to the driver to detect that and avoid calling drm_of_find_=
panel_or_bridge
> > > > > in such situations.
> > > > >=20
> > > > > So with that in mind it feels like the child node approach can be=
 viable
> > > > > (and integrated in the same helper).
> > > > >=20
> > > > > We might still want to favor an explicit OF graph approach, but n=
ote that
> > > > > dsi-controller.yaml also specifies extra properties that are spec=
ific to
> > > > > MIPI DSI and I'm not sure there are equivalent definitions for th=
e OF graph
> > > > > approach.
> > > > >=20
> > > > > What do you think?
> > > >=20
> > > > I don't think Laurent's point was to move the child node away from =
its
> > > > DSI controller, that part doesn't make much sense. The panel or bri=
dge
> > > > is still accessed through the DSI bus, so it very much belongs ther=
e.
> > > >=20
> > > > What he meant I think was that we mandate the OF graph for all pane=
ls,
> > > > so for panels/bridges controlled through DCS, you would still list =
the
> > > > output through the graph.
> > >=20
> > > Also, we're already in a bit of a mess right now. I don't think rushi=
ng
> > > that kind of patches in a (late) rc is making much sense, but as I sa=
id,
> > > if you want to start working on this, then I'll take a revert for the
> > > next rc, and then we can work calmly on this.
> >=20
> > As I understand it we either have some broken stuff because of the reve=
rt of:
> > - drm: of: Lookup if child node has panel or bridge
> > - drm: of: Properly try all possible cases for bridge/panel detection
> >=20
> > because the child node is already used in places, or we can have broken=
 stuff
> > because with the patches because with these two patches -ENODEV is no l=
onger
> > returned.
> >=20
> > Now with the extra patch that I sent:
> > - drm: of: Improve error handling in bridge/panel detection
> >=20
> > we get -ENODEV back, except for the connector case but this one should =
be
> > handled in drivers directly and drm_of_find_panel_or_bridge should not =
be
> > called in that situation.
> >=20
> > So all in all it seems that all the pieces are there, unless I'm missing
> > something.
> >=20
> > What do you think?
>=20
> If Bjorn and Thierry can confirm that it indeeds work in their case,
> I'll be happy to apply those patches as well.

I still think we'd need a fix for Bjorn's connector case though.
Not sure I would be confident providing that one without the hardware
to test with.

Bjorn, what do you think?

Paul


--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--4GhhnGEmAES0hXPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJn+J0ACgkQ3cLmz3+f
v9H5Vgf+I++FTKqFLaW7F8J3wu8JAMRDMDNZg4hF8rmIFXGxVxM7Ij5hMu3rK0ga
gXhrN1IQohZqykmrib/YjQGImtwo1e7Nao4Wg8QJ3MCh3uNfLYkIBzrUN5/Q3KXb
q29FXbgyrCDtEHLby7vw7K/DZ4VWk1/YOfymWUXBaje7+KaYhtWJY1tzBrPjeDHT
cwb7Vgn15TGDjAElXzCAdiVgKEexXdKKrVCl5/4i/EcuD+2iaGbk+eaNx6LhSEP6
GPTsVHCjpVaM2YpJh38GkSpdk0i/bxnHsXmTabNyEC+/FzpFSd8yZCvdC7lFAFYY
6GaAuN2uX3beq+at6vzl4gQEbImA2w==
=27vu
-----END PGP SIGNATURE-----

--4GhhnGEmAES0hXPy--
