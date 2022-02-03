Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550A4A80C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349662AbiBCI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:59:48 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47041 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231764AbiBCI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:59:46 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id D3D522B001B8;
        Thu,  3 Feb 2022 03:59:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 03 Feb 2022 03:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=EpiBukeZdut+hZos8noJKKPPM5H6pXyi49s4av
        h90GE=; b=FGthVDX4E3XqAjsaiHeS6t0+CXoYuhpvNRcmAadJqU5whNjlZ4gmjW
        HM/mSrCzy4awZEqbq9vObAMnPUor+v+sZcxTsO79/3CuUeH/XoCn4cop/1d8xo1X
        6/Q1EMQmCU0ujPt0WEf1FQRY9uzxfVoldYXt7kejfLNDCb+dHRjvCaQ9QEKeX0SQ
        x93bBKsAXlwTAHCoduvXzURUuNJkfFv+4pmx9iIhAjixcUIQXfpu3CBqj36QZtn+
        cl2R3HC1L5ziOU7WAH1+UED44o8GAKJvJYnjzv+AEQpD2pTquHXR0vo0fLp6SB5p
        cJEDoum7C0fmLqK1U2G/Hq0CNKGb2ddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EpiBukeZdut+hZos8
        noJKKPPM5H6pXyi49s4avh90GE=; b=BsVLeaW8ue9DnkT/ZI/Ny4lWr/YHYf7fP
        qtc+yQXp7WdUt12lBCreKQ0B4fFUqpG7X5lihWO6sgeGoEBgyr3OThpTkWdOrop/
        HOv2gsvYryCRzMXMt2Z7kVskpO0f587vwkrWHnrwkfMYuV8Z2vx2Q66EzwLnhPZL
        Y3P/0q7/qXgLspm/29Fm1N27NjlIyMXnSTqjjeEpeaLfTTUpRueIz1g947eq90EG
        +AE3rkHjwOc3aGl93LowNsK9uOIMuOY3kvEvkCaJ9ztl7iK9AKAlaWRZJtP6fnSb
        mJEKegVRLeVukB9wHFdfN9P3lWTClj9SaDuSsQmSj3WtcQn9x/hYg==
X-ME-Sender: <xms:f5n7Ya2bJ1nASG3TvNMhJ6CtwYsDo03NPkLRY3S8ncxJMEMqg5sXdQ>
    <xme:f5n7YdHSLF2uXOJO8GN1UeSlqGvakVm5dX468kZSM0NN9CSwrBkybV-I6k-dGG2dy
    GkKZRW1BTu9R_a7Q-A>
X-ME-Received: <xmr:f5n7YS7hiX9YTd3N1VAKdpiy8iKKHw_cwiX-eAAACEN7jF5m3APHp6wy-QuEnaIcKlAi7sqeKtjKRpVl0s2PYMp32kmdBPttCjTWERs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:f5n7Yb2gT-1Qo1Ep3v9yq36XLZFeTwCCK2HqkjSkQEXDngC6mk30Yw>
    <xmx:f5n7YdEC0eV-G9DJxhnZD5a4uVffWrJgYxcTVWY1EZLCEcA2Uoss1g>
    <xmx:f5n7YU-VGPqHOE76yfknmf87qol4lQoT8V2JSecD4zdjESRb3mc0Rw>
    <xmx:gJn7Ycf6Ef3MfyHrNjbOo9SkEbQhDPIDEKWIuQ_foiglWPnACJz5eK2UKxI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 03:59:42 -0500 (EST)
Date:   Thu, 3 Feb 2022 09:59:40 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: sun4i-i2s: Support for Allwinner R329 and D1
 SoCs
Message-ID: <20220203085940.3mxixfnduerez5fd@houat>
References: <20220203020116.12279-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rv5b6xkp6hnwyq66"
Content-Disposition: inline
In-Reply-To: <20220203020116.12279-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rv5b6xkp6hnwyq66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2022 at 08:01:12PM -0600, Samuel Holland wrote:
> This series extends the sun4i-i2s binding and driver to support some
> newer versions of the hardware. Each instance of the hardwar now has
> multiple input/output pins, and channels can be muxed between them.
> Since so far the driver only supports a "default" linear channel map,
> the driver changes are minimal.

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--rv5b6xkp6hnwyq66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfuZfAAKCRDj7w1vZxhR
xTI+AP9ur9oPoumWyy6gsTnPceqJd66z4Nz316mJUbstvHP2OgEAqUNDn2LQognL
CuzIrK19HzCMrHHLTynsRk75+ZrYvg4=
=3wn8
-----END PGP SIGNATURE-----

--rv5b6xkp6hnwyq66--
