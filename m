Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63E514FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbiD2PuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiD2PuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:50:09 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315B338AD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:46:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A55A9320092B;
        Fri, 29 Apr 2022 11:46:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Apr 2022 11:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651247208; x=1651333608; bh=/d5J8Yluhs
        WZqBasVmfZfu+Hpk3XUUKrCMi3sFOjTuA=; b=isxxs8gPLBcp/opk9Jo3aCAskk
        dh79sDj/bqi9/7zBcupVL/4U4Qwuon7+87/r3l91RgYfiI3SeFJW9atga+bjHNqq
        PCWljj2izlX6uV123ZdHLMmDTXNqoNNXpe5qYXPU30ba4Wxq2lMCDCPY41CyY6dL
        8YilIFkiFsXHvA2rRjofjqLwaT79MBZWQxs2yNRC7L9B4MzejYq2gTPLI73vXuVe
        JgsIn33Zdji3cERQwFexqmJYc/rl+JZOTwVo8bnOW97qit7XMhrtylTPCEVQIe2a
        Jld+YmUgDdl9rg45bSW/gFRTb1ofZNz/7UYt/qpjToGg+FrwE996Evp5+1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651247208; x=
        1651333608; bh=/d5J8YluhsWZqBasVmfZfu+Hpk3XUUKrCMi3sFOjTuA=; b=C
        VHxqQLDsuOCsD5TpfGhnjkoi9txSQM2pnLc6U4SWugN9Rpa9XaR3yCeb3ftR0YLO
        vhWfVN5npdA/N40jLxxqYCHemcIubCkbJ/LuRrrlWeLNGZ2YhoEluMi8eNMBw0RU
        CKUcaZBNMU6TzGeE3O4irkSJKVzhWBmudLK7LAiomH74XGuQ2jE3HfPYg1OXikWZ
        8WwlSTdOtsXPhHqpw5OTzv10zWYEHq0n5gQ6rkwqyjnkHIvaLs2SzPGyjTVB0/wl
        S78GZS32fixhvcge/KDzMJIrwfY4hLrIe+yxTJLdbSIaUSiN4IpeQnIA8QxlBicD
        gVcxSCdshJ6aABXqrYqCA==
X-ME-Sender: <xms:ZghsYhjxYocn1atEsHAPnScDfrGtn30pMCejDGTr-9OayRJJhiZnDg>
    <xme:ZghsYmBT0uPmkIU4DVClgflKiKClI4fr-0WfQdlhvEgqIqip5dgj9fTtaLLvl8HVm
    el9tG9eZD2OQA5LVf8>
X-ME-Received: <xmr:ZghsYhEYVgs31vGE3mUCw2wjUm06wcZ0U1wEgSwGTujX21ceqf73djUlTj21TwCw7KXsIuWyxqWgj37kL2s3QH4St0P1VpslqZvUXg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZwhsYmTx1l-Q-ydM1y7IyA5VpzdR62mXEEvujQp9ydDqLJX9_8KzCA>
    <xmx:ZwhsYuxj2GdWWHn4EUVNFFGoXEz_cCFHmABC_UIHyRg_FHhQ3yApdg>
    <xmx:ZwhsYs4vX-dmO8ldHrl5XpxuF8bMpO-yBEKwd-waBTme6IizMgKsmw>
    <xmx:aAhsYiiUE0I-fgqRrtoLPrVPo8DfkmXwUPNDEpzziJIA5pszRc_WyA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Apr 2022 11:46:46 -0400 (EDT)
Date:   Fri, 29 Apr 2022 17:46:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
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
Message-ID: <20220429154645.47tsii47vjxqklca@houat>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
 <20220427143410.bectqumq62qmlv5x@houat>
 <CAMty3ZDk-M3hW97_GY4-z=f+cKs1Sg4Jbq5L7L4zHgXURhFuZA@mail.gmail.com>
 <YmsSdmOEpSz4okt2@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghqgl77x4k7agxtg"
Content-Disposition: inline
In-Reply-To: <YmsSdmOEpSz4okt2@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghqgl77x4k7agxtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 01:17:26AM +0300, Laurent Pinchart wrote:
> Hi Jagan,
>=20
> On Thu, Apr 28, 2022 at 02:09:42PM +0530, Jagan Teki wrote:
> > On Wed, Apr 27, 2022 at 8:04 PM Maxime Ripard wrote:
> > > On Tue, Apr 26, 2022 at 01:40:31PM +0530, Jagan Teki wrote:
> > > > On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski wrote:
> > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > > + Linus
> > > > > > > > + Marek
> > > > > > > > + Laurent
> > > > > > > > + Robert
> > > > > > > >
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
> > > > > > > >
> > > > > > > > This eventually breaks many child-based devm_drm_of_get_bri=
dge
> > > > > > > > switched drivers.  Do you have any suggestions on how to pr=
oceed to
> > > > > > > > succeed in those use cases as well?
> > > > > > >
> > > > > > > I guess we could create a new helper for those, like
> > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > >
> > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > >
> > > > > > Yeah I agree that it seems like the best option.
> > > > >
> > > > > Should I prepare a patch with such a new helper?
> > > > >
> > > > > The idea would be to keep drm_of_find_panel_or_bridge only for th=
e of graph
> > > > > case and add one for the child node case, maybe:
> > > > > drm_of_find_child_panel_or_bridge.
> > > > >
> > > > > I really don't have a clear idea of which driver would need to be=
 switched
> > > > > over though. Could someone (Jagan?) let me know where it would be=
 needed?
> > > >
> > > > sun6i_mipi_dsi
> > >
> > > It doesn't look like sun6i_mipi_dsi is using devm_drm_of_get_bridge a=
t all?
> >=20
> > Correct, patch for this on the mailing list.
>=20
> I've lost track of how we're solving the fallout of this for v5.18. I
> have received a report that the original commit (80253168dbfd) also
> broke the rcar-du driver. Could you please provide a git branch (based
> on drm-fixes or drm-misc-fixes) with any patch that you plan to get
> merged in v5.18, to let me test them locally ?

Was that report about 5.18 or drm-misc-next? It appears that all the
drivers conversions are in drm-misc-next.

Maxime

--ghqgl77x4k7agxtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYmwIZQAKCRDj7w1vZxhR
xUSxAP0W8CT7NRIxaS0BWav4gaH703LpfB2h2UXNaxJd0YlZxQEAs6gyeTVM2A9o
JpaWNJeWb2uCFoDefSFhbzQgf8xfFQI=
=5sis
-----END PGP SIGNATURE-----

--ghqgl77x4k7agxtg--
