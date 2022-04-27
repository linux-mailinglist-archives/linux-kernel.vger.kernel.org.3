Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD1511A25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiD0Ohk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiD0Ohc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:37:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9F26ADC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:34:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7423E3200978;
        Wed, 27 Apr 2022 10:34:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Apr 2022 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1651070054; x=
        1651156454; bh=FtJrU1EbszNWBwqkx3ib5bBVfQhZW4k3uAa5FnjezIc=; b=O
        U+ACzroxdPCtLq+GumJRSDGx2/+gqPjoCmKSAqSCH4EtnecH7xCMbrgzDcV8BCUE
        1rPpC2aeaRAFQT0sOFH0cxNBxyeY7B30JDGKVbOcHsWNG3cGPRRF7/YT8XSG/L3Q
        rks3DkscISkpJXqrvHuGGFOTnbdrL8Nh3pYzA6QQClASkHdnofJ7LygS/uTWe8D1
        q2PLIHoT9uqAj/FcsP48KwbSwWK0PfVgXj3pd5W6n9iwwBIT75ui0sUn+2UiLmnC
        61+XKxNHTSjr2OMa8/orV8VwgAnju3d2djkQ6znTDeFke7coy/MJ91tzlcjm7XbD
        pl2YgdpUpWCaVstR0j3YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651070054; x=1651156454; bh=FtJrU1EbszNWB
        wqkx3ib5bBVfQhZW4k3uAa5FnjezIc=; b=pwitmNVg4OtpkFhu6srhM17v0ehQq
        gXxF0fIccCbJtuIh6UaAf5+uraeh3mELup+kBN3hxNuWu7TTMp8H3Fve/p49mrq7
        0OXhz/bmPu5FQCMzefZkJGxkWqcUsA9X1ibKNn3Vfh0ZwZgfSiNpDofdonI4r0Lr
        VvhH6HFNGm2xTshjN+nH+2tJ95ZHptAHd8voJdWnL+HhH0Wj3ADzPZND+BgI7bW4
        10fhEpNpMt98t+ItRaYTw6buwFNBYBxMu4VjoR9AFTF4SabN4HgMBmZalMcXG43h
        VXOFq4w2Yloirw8+MnUETQGmeQihM31AaeSMBoGqPPCu/+n2UKaNo5W4Q==
X-ME-Sender: <xms:ZVRpYktnsPmwGpeuUbkDFnJ0A31xJXY0yb7Z0M_2KMj5DlVTAsfMDg>
    <xme:ZVRpYhd5A1i8OQZOeAJQIbEtCao3u6no7XhzIA0HDzkMvku7cQxfOhxNQgxloMgLB
    7ZlwctHVYqR5mGPR-I>
X-ME-Received: <xmr:ZVRpYvyQ2SLZh6XPLgqvKeKakohFA0xO3cTls9PYfIzN56hB7UtJ-7JFdt5fokV__FlvezGfjYjISXwfVPFx1WvaoTuCl39UElkHFqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeuteef
    teefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZVRpYnOPGMS4Gz8qgk4Ez0CgkqmgC97-43lsVmsK7VlweYfJp7HQjA>
    <xmx:ZVRpYk8qnsMrSKPPIunaJEp3olfcBzdaI2Zo7LSQtfepzwGwgPwZuw>
    <xmx:ZVRpYvWZFWjXelPHbcVyOyTwF_EUR9dLyJYztBQE7mvCsoi2vgC-9Q>
    <xmx:ZlRpYuehGtsXes9hh-EDShI8y060KE0FN9QNI9m8kqXT0-M2LqfEzQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 10:34:13 -0400 (EDT)
Date:   Wed, 27 Apr 2022 16:34:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
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
Message-ID: <20220427143410.bectqumq62qmlv5x@houat>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:40:31PM +0530, Jagan Teki wrote:
> On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Hi,
> >
> > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > Hi Maxime,
> > >
> > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > + Linus
> > > > > + Marek
> > > > > + Laurent
> > > > > + Robert
> > > > >
> > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > > > > <bjorn.andersson@linaro.org> wrote:
> > > > > >
> > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel =
or
> > > > > > bridge")' attempted to simplify the case of expressing a simple=
 panel
> > > > > > under a DSI controller, by assuming that the first non-graph ch=
ild node
> > > > > > was a panel or bridge.
> > > > > >
> > > > > > Unfortunately for non-trivial cases the first child node might =
not be a
> > > > > > panel or bridge.  Examples of this can be a aux-bus in the case=
 of
> > > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > > >
> > > > > > In these cases the reverted commit prevents the caller from eve=
r finding
> > > > > > a reference to the panel.
> > > > > >
> > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child no=
de has
> > > > > > panel or bridge")', in favor of using an explicit graph referen=
ce to the
> > > > > > panel in the trivial case as well.
> > > > >
> > > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > > switched drivers.  Do you have any suggestions on how to proceed =
to
> > > > > succeed in those use cases as well?
> > > >
> > > > I guess we could create a new helper for those, like
> > > > devm_drm_of_get_bridge_with_panel, or something.
> > >
> > > Oh wow I feel stupid for not thinking about that.
> > >
> > > Yeah I agree that it seems like the best option.
> >
> > Should I prepare a patch with such a new helper?
> >
> > The idea would be to keep drm_of_find_panel_or_bridge only for the of g=
raph
> > case and add one for the child node case, maybe:
> > drm_of_find_child_panel_or_bridge.
> >
> > I really don't have a clear idea of which driver would need to be switc=
hed
> > over though. Could someone (Jagan?) let me know where it would be neede=
d?
>=20
> sun6i_mipi_dsi

It doesn't look like sun6i_mipi_dsi is using devm_drm_of_get_bridge at all?

> exynos_drm_dsi

If you reference 711c7adc4687, I don't see why we would need to switch
it back to the old behaviour. It wasn't iterating over its child node
before, so what does the switch to drm_of_get_bridge broke exactly?

> mcde_dsi (as of now)

Yeah, we do need to revert 3730bc6147b0 and 3d7039e1e649

Maxime
