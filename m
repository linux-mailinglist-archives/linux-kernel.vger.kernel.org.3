Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5E5A6BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiH3SE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiH3SEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3831839B;
        Tue, 30 Aug 2022 11:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B3F61535;
        Tue, 30 Aug 2022 18:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63639C433C1;
        Tue, 30 Aug 2022 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661882646;
        bh=SXz9foGOCKalc8a9oyokHuKsEKQfaVSfN6xJ/rlclUs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=et7qx/6viOP9ZfFCNmKB1pya+dCeR8RdTtPfZf+hM0yDEUArV+P53n5/rhMFffFqm
         WlupHOg/XxI503UryqCIBbUxtN77RP8ZvEPxqC7ZShsj10XZwSWznh0A+vfJBLHYuG
         sWL1YvhAg3ZzPzJzrL1CELN4ZhOMcKIXXv1qYYbuOpL8Hq3LzIm3Kx8S/0IbvD1BeN
         xRQi0w9u+OMyRzPbqEekqDcCo48AApb4XJnpyIVFeGnpGxG3IVg1bPa6xWcVvZcJrh
         YNkWhOD8TeO18hiI/SH1yL1Ui9QlAp84v/CZyDhsIKjfU/vSbB8CiFHEaLKvRoGRIi
         U5aPsTZlIkzPQ==
Date:   Tue, 30 Aug 2022 19:04:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0
 support
Message-ID: <Yw5RFX3rFeM/xwLb@sirena.org.uk>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
 <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
 <Yw3WDjj7MzQjG8z6@sirena.org.uk>
 <Yw3Wm9D+9zGWlB67@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N23qGugilPz27T8e"
Content-Disposition: inline
In-Reply-To: <Yw3Wm9D+9zGWlB67@shikoro>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N23qGugilPz27T8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 30, 2022 at 11:21:31AM +0200, Wolfram Sang wrote:

> > Not sure why you didn't CC me on the cover letter for this?

> After I got cover-letters rejected because of too much CC (but the
> paaches itself went through), I wrote a script to only include lists on
> cover-letters.

That's very unhelpful, nobody is seeing your cover letters if you
do that.  You should at least be copying the people you expect to
apply your patch, and it seems only sensible to copy people who
are getting every single patch in the series.  You can always
copy patches@lists.linux.dev if all mailing lists are rejecting
your CCs.

--N23qGugilPz27T8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOURQACgkQJNaLcl1U
h9BlgAf+LXnQoJNgkH8wZwKzLVjtilu+sGddJk+Rmpd/CFS5kK//tWlPPmHliCBD
dJWKWcmNcnJGgUMrc1vbI46fX/OwlA4Kg0Pn2QqpCNOTHlp4BABhHYNY74wUxSTc
jytN+9MvhpmYOuVqB1hKnxyMcQQ9h1VM0SFTx6AMHVutEIA0Xy1HBgrN2nk2QZQ4
pIDmiliMvJRGfJK2k0yjzBkHWH2SOhW2fkLBb0QTEBH1D8FPYQbP1RX+kgWZk0Bb
VDxlArIG3tltXxq5wDZihf8Mlg+p9853QtRlbgC57pUSkLvCaWWk9s+nWCS2tZp2
D6ymx/TZ4DuhO7fL4B3EKEGhdrZdGA==
=x+hX
-----END PGP SIGNATURE-----

--N23qGugilPz27T8e--
