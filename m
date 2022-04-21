Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989A509A93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386631AbiDUI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiDUI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:26:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF21DA5C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:24:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4DE3D3202254;
        Thu, 21 Apr 2022 04:24:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Apr 2022 04:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650529441; x=1650615841; bh=mr6/yNysRK
        Gd8H9fz/3NmMqTPBzrj57CSccM86kcPME=; b=VIma+8f/jMnVxvmpJBjeZS3wsE
        7WNCTDwHEgZOkcwzk2cs5sZDXVJbQ3OL/shhRoP9mDf+Mmm653jY3ztiTsyCjaCI
        OwchGtkQHzIcdvJx7k838oCmecexdkT4gfaSBkzGOWCSEHuFrc+T6OhgbjvxCjWo
        28sp4PAr8n5qwF/t/zqFRZZ3XPQYwrcUVZInviX6QtGKvwxCEiUFMXjUDk5Hbsms
        uT7qzOKdihSrkErhENc93iVajGjrhsJHpeq801SUQDArHHx1zm6Vf76EUin/Qmex
        z11krGVs0GYUPCujVlbfIRWeTKeKD/hf0/LcbODwbCpap9V3JxPmNuVwCF0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650529441; x=
        1650615841; bh=mr6/yNysRKGd8H9fz/3NmMqTPBzrj57CSccM86kcPME=; b=V
        YhUyeVImMDA1/5wVioG4M0Ip73hxGqOIR9HuXTpozM4wwsgo5I2K7RBLQXjuwiOc
        BvsOWUkjxxMmlfuMdJiSMLagNAS8Pup6ywJaqJ8MGY7H5r1+KG6UEX9YUHXtdiWh
        rqDOCpBLYnMaIJ0RUPaLqShwfdsq7/lv5soqpJrETzaB59bI8oR11i+uPlSh98m2
        urMsO855cv7vAz/8kaLk0xEUYhwOXL4FRgBTHXp7TlZmrLDLWLiyiCt5C/r4JC3C
        QJ8IfuMOTXFGztMgKmExbcuVNelPxD0o8Hh/F9FYTN0a8WJRD89EqKo/KRoLz16f
        sjzlE9GkvzlkNMEcmAr/Q==
X-ME-Sender: <xms:oRRhYrmnx6DbTxsGbIBrGungjD1IDW7X6yTgmv7WT1GHwClU8TCwxA>
    <xme:oRRhYu27NCpsHiskldqDd_ymYM6JBD8YkNvGcZmIPOWLpffmArezYQMzwPIfd8hYo
    Zo-jgccW_F0XarD4qU>
X-ME-Received: <xmr:oRRhYhpKJxXdNvxcupDa_WayLRZsenqqjmV9oNoqErpmXNrY8xrrdGR2v6JIYvMLakW5rfITBGBpUNogryxQH8s1ppt05v95WoIybko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:oRRhYjlVKW8GIvD2MSSHdcPJYtLugQkhUcv1-IAygHTYCyryvepghg>
    <xmx:oRRhYp1D-rGd7-KK1SnjDz7YesPlA4Q-7YuYkenQ4SAtWmcdI_LBUQ>
    <xmx:oRRhYit08JuUeMP2ETa5TEzYk5OmhBd_spiZlMkcTracCV62cF9sZQ>
    <xmx:oRRhYo2Te-9IFb1XMn3gUfzqRUlxngGshtXVgGWqkVetPKyW0YT5VA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 04:24:00 -0400 (EDT)
Date:   Thu, 21 Apr 2022 10:23:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or
 bridge"
Message-ID: <20220421082358.ivpmtak3ednvddrc@houat>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org>
 <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nuuowyjtkv725it4"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nuuowyjtkv725it4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> + Linus
> + Marek
> + Laurent
> + Robert
>=20
> On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > bridge")' attempted to simplify the case of expressing a simple panel
> > under a DSI controller, by assuming that the first non-graph child node
> > was a panel or bridge.
> >
> > Unfortunately for non-trivial cases the first child node might not be a
> > panel or bridge.  Examples of this can be a aux-bus in the case of
> > DisplayPort, or an opp-table represented before the panel node.
> >
> > In these cases the reverted commit prevents the caller from ever finding
> > a reference to the panel.
> >
> > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > panel or bridge")', in favor of using an explicit graph reference to the
> > panel in the trivial case as well.
>=20
> This eventually breaks many child-based devm_drm_of_get_bridge
> switched drivers.  Do you have any suggestions on how to proceed to
> succeed in those use cases as well?

I guess we could create a new helper for those, like
devm_drm_of_get_bridge_with_panel, or something.

Maxime

--nuuowyjtkv725it4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYmEUngAKCRDj7w1vZxhR
xcyNAQCQWG0wPTFJTHNnCb79v3w/0oq3K8NWFjJQdfhmMTMd0gEAluKjETuOog8r
01deImfsj34FpREypMQIqkuLR7Y8igw=
=cGpF
-----END PGP SIGNATURE-----

--nuuowyjtkv725it4--
