Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27120492C37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiARRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiARRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:22:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C719C061574;
        Tue, 18 Jan 2022 09:22:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B806149C;
        Tue, 18 Jan 2022 17:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F7C340E0;
        Tue, 18 Jan 2022 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642526556;
        bh=nprtLpXrRfvglwbXoOGOQ6/KtgrFZDOqeMJxXlz0s0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TK4R4ujoiynCj4SK6WpD8pNaaMAAg1E7afe4kJAjp/SwXXskZVB7P7pfm42MyyhU5
         zIR+LqYy9RKz7cG08fXze2SfdT9cnp9J2oz2wPB9mCyUUg7L7QCaPn//bArAzOupZ1
         OLCNvKWWAJg3oRcBLCSgxFBP9D4uGmY8SNKv0aGbNen/jPdgpWVoHUe5ETbT3IHm7P
         SHe4/F0ZYGmohxfI7SiUlH/oSQDAnnz+tuvYj7uVFwBYtOxUqiSgwtUbgnryk+P/ct
         9FUdHcNrkvGhrezFy1ZTRL7bOQ5eF7jhOQA90iMfVUwGWu7kTRNDmszkU+QVa/L+R8
         4oAq7e+qRmxFw==
Date:   Tue, 18 Jan 2022 17:22:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: Re: [PATCH v2 2/5] dt-bindings: tlv320aic31xx: Define PLL clock
 inputs
Message-ID: <Yeb3VVmrUDIYw3AK@sirena.org.uk>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
 <20220117132109.283365-3-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tabkMTr0FaHh+1SV"
Content-Disposition: inline
In-Reply-To: <20220117132109.283365-3-ariel.dalessandro@collabora.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tabkMTr0FaHh+1SV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 17, 2022 at 10:21:06AM -0300, Ariel D'Alessandro wrote:
> Add constants for the different PLL clock inputs in tlv320aic31xx.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tabkMTr0FaHh+1SV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm91QACgkQJNaLcl1U
h9Culwf/RPr3IjTPjy4XtWKgvBrp1Pai0Yj0+dMs5dFSjw/0kFwL+B1+1VUoq3vI
h4UkHtRogVAXjQ+ciJgSGz6NRlSjg6rJbuZ3DcYse48EWDrbZj8y1MNwI4Y1AIkm
QjXhSubuj/ahL+jWDJD3R4hXmdP3HrJJehztN73R1/chIwJDmJAXg1zSgU2NBsXy
DXKQRc4meJcv8Poq9gtebfbz2prqrfbBc+GyJsPYPjMVwvC8JSJA0GYGJJG9vmj2
OvRKjjRymO4WEawTzpCydcMlPtnZjUwmPl2u/TE9JamAxFxJC5CCaeybLOOET8kp
Pww0euG+OUvlDiGuAyJ4du3StSJ5Mg==
=v5Cq
-----END PGP SIGNATURE-----

--tabkMTr0FaHh+1SV--
