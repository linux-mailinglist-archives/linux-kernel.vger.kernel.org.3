Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D050F32A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiDZH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDZH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:57:47 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB1011C35
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:54:40 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CD370C0011;
        Tue, 26 Apr 2022 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650959679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbjUJF85j7VcoyUcJNo/0uHXS5A5nvA+sLUFvu2hF2Q=;
        b=kwo7M+YBinQdDLV406ejHk8p5PtP/AaEbfWC0rZwFh9ifHPfdKBpQftZlhZOllVQ8EvvU8
        76P4vb1Qx5UdbqctG5x7B/r6RQKLl3iYDCFFeT2ro1FTl9j0O7D1+4ne4HqKcTpWm+XACZ
        FQxEl/1PBrXOyJ6PZPuyn74xsQyh2pgCN9HiFAJJRLDEWZuiOz5XSrghdZslVT+w0ruNxI
        CGVED/ZVhoQ3RUVl++aAv9nIr7KTEbEmyVLXTN4P0InG1K0bnoTCx1yCPtG83Xam+kAvLe
        PvWbb3wnE+33gJcZjywQMiZ5I768A2ho/UnYgEmIud6ZYexVb2gy9vvBtNTYcQ==
Date:   Tue, 26 Apr 2022 09:54:36 +0200
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
Message-ID: <YmelPCcWCCjALtRU@aptenodytes>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Si6USORBDKWOev5w"
Content-Disposition: inline
In-Reply-To: <YmEdAVwZuA7Wo1Ch@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Si6USORBDKWOev5w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> Hi Maxime,
>=20
> On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > + Linus
> > > + Marek
> > > + Laurent
> > > + Robert
> > >=20
> > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > bridge")' attempted to simplify the case of expressing a simple pan=
el
> > > > under a DSI controller, by assuming that the first non-graph child =
node
> > > > was a panel or bridge.
> > > >
> > > > Unfortunately for non-trivial cases the first child node might not =
be a
> > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > DisplayPort, or an opp-table represented before the panel node.
> > > >
> > > > In these cases the reverted commit prevents the caller from ever fi=
nding
> > > > a reference to the panel.
> > > >
> > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node h=
as
> > > > panel or bridge")', in favor of using an explicit graph reference t=
o the
> > > > panel in the trivial case as well.
> > >=20
> > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > switched drivers.  Do you have any suggestions on how to proceed to
> > > succeed in those use cases as well?
> >=20
> > I guess we could create a new helper for those, like
> > devm_drm_of_get_bridge_with_panel, or something.
>=20
> Oh wow I feel stupid for not thinking about that.
>=20
> Yeah I agree that it seems like the best option.

Should I prepare a patch with such a new helper?

The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
case and add one for the child node case, maybe:
drm_of_find_child_panel_or_bridge.

I really don't have a clear idea of which driver would need to be switched
over though. Could someone (Jagan?) let me know where it would be needed?

Are there cases where we could both expect of graph and child node?
(i.e. does the new helper also need to try via of graph?)

Thanks,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Si6USORBDKWOev5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJnpTwACgkQ3cLmz3+f
v9FpNQf+PmdFzmDCc2lB70OeH1fQOTNlthZRA/ZDA9XQizGkSF7BFS5dJkp9FfWr
6fEanp5K7wl+z9FUcx+G+A36n7y82sWeZVk2HwNQuBei8DH/ZQrBAWZa8kpZ1RQO
5bec85tS8OimvJ/dNMUCXypf6p39mSiMLPj2y65p6KVn2fFE5XMllQqBifaQfbJX
yt+HjpH58GJz5GPSgeb4c2W2Lz43TxjfGzhMd+lKwWgnBkeQQ/2G8y3R+G0VNkTu
wuDWOl3BUGc2dtXkj8dHzzSqZJrQYdFU5ctJdhbibfAv0oNYdzM/RBQA9WYndO8Y
9eRdxvuj0o96p8BjFqxBZ33LUyhQIg==
=Bckb
-----END PGP SIGNATURE-----

--Si6USORBDKWOev5w--
