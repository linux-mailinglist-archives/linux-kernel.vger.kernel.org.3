Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6A8553890
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbiFURJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352201AbiFURJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B424F2B;
        Tue, 21 Jun 2022 10:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF3461569;
        Tue, 21 Jun 2022 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A5EC3411C;
        Tue, 21 Jun 2022 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655831345;
        bh=hoetdcZUDckCVz1LG7Suq/7P7r1pBVIFo0Mc9wsofSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuybSt0jNYMAYfRsWXHYhHsk+0ofBeXFoZvGmqCeMqMzipoVYqGmD/I7MRQtP6yZ/
         f2OrqFGZDKu2+YU5eEKKAxb/XnhnOW1ZiYTxI8BfYBDGIeWxc5rnfznR3+zzyBBWPY
         l+OI573tJCSGgKT0iuPnOaDTDKa2XFj58pb5RNTm6I6QqKTZghMu9Xt8SmlG7hFaB6
         T5JhW3h0TVGylxUTwooVthkO6xg+2d5FZexgNBSgeq+B7hKMbML8eZkTg23BR4PCys
         sd3hltj6VukI77Q0dhGBCVocjx6KSic5cZMNvVCk+TZokH4jRCz2nGKiRABmOsSiS/
         iivCrzf0kFV6Q==
Date:   Tue, 21 Jun 2022 18:08:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/49] regmap-irq cleanups and refactoring
Message-ID: <YrH7JurP2LAl1uYU@sirena.org.uk>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrIaw91LstEgu4tF"
Content-Disposition: inline
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
X-Cookie: Edited for television.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rrIaw91LstEgu4tF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 09:05:55PM +0100, Aidan MacDonald wrote:

> Here's a bunch of cleanups for regmap-irq focused on simplifying the API
> and generalizing it a bit. It's broken up into three refactors, focusing
> on one area at a time.

This series is very large and the way it is interleaving patches for
several different subsystems adds to the difficulty managing it.  As
you've identified there's several different subserieses in here, if you
need to resend any of this (I've not even started looking at the actual
patches yet) it would be easier to digest with some combination of
sending as separate serieses and reordering things so that all the
things for each subsystem are grouped together.  That'd help with both
review and with merging, both large serieses and cross subsystem
dependencies tend to slow things down.

--rrIaw91LstEgu4tF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKx+yUACgkQJNaLcl1U
h9ARhgf/d9WNHkTS7uOL1AjmOAryEB+Kl4XpvM2bPc6J1x3bJLQr0kY7ASfsP+sn
EovP2WnmZcMN+6QP3IXqYa66Zs0TNpF9a+kE+ZRtrR+CA0IU2h1F+hxxXQqj0qnW
mZN71F66k/6WM7N5ybsoQNBJpfE2nrPhFErbYaGlRX3XwNl3I2VKtR66QeX/wKUY
7ZQWLnzg5a3cQ+WrIffyuSsjXVDB91hdPSXy0OhvCImHKadkEIps/tppbRY63kNe
8jszRNa9Uwkkq2wLkt7L+8oxBdIoxui9RRaEPeUunjb63lzyzeCSv1ZYtUtU/dbR
kf3eYLXPbjwDpknw9n3EJz21ZUZ12g==
=maZ4
-----END PGP SIGNATURE-----

--rrIaw91LstEgu4tF--
