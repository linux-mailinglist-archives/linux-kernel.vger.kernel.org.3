Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A064C0194
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiBVSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiBVSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:46:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6DAF2139
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:45:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBAF61583
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5034EC340EF;
        Tue, 22 Feb 2022 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645555537;
        bh=1C8QDrO2OtgLwZNTF58GfOVs6sAo8lISdzMgO8lSpDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxTdUcfBN9saQxItgBeiesm0kmOdbDyQ635g22V0UnPDbnKibuF3JQcYi3sCBloTO
         IvpdzFQV959IqT+nXxwe5qZmdqnJMMxSfgnbbUUxZ0tWU+ep1q0n7AKLCw5L2jlt0V
         lhnQcjCDRAF0IdnsbCm18QJqNMvCj/dPG0RNSWrxLKX1b+YkI6arxd47zonFVEJGcf
         XoA5u7A0Net0w5ZzQ+0GKxiQPnSXkb2FoEoaMbPm3Me2vdyYOYez1skLNPRstSl0+W
         R2JYN26RCUjXwL6unwKicXVZXHKU4l9DA+aLjc8TDA8JYtuMVXQpMF2xEAeOOYDpQa
         cxWmG2+PrBA1Q==
Date:   Tue, 22 Feb 2022 18:45:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH v2 3/9] ASoC: codecs: tx-macro: fix accessing array out
 of bounds for enum type
Message-ID: <YhUvTF2QyL3Vh28k@sirena.org.uk>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
 <20220222183212.11580-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SgpHx0OWTw7XBEmR"
Content-Disposition: inline
In-Reply-To: <20220222183212.11580-4-srinivas.kandagatla@linaro.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SgpHx0OWTw7XBEmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2022 at 06:32:06PM +0000, Srinivas Kandagatla wrote:

> Also few return value of put functions, so that change notifications are
> sent correctly.

The unconditional change notifications are present in this patch and
I'm guessing some others as well (they were there in a bunch
previously):

>  	tx->dec_mode[path] =3D value;
> =20
> -	return 0;
> +	return 1;
>  }

--SgpHx0OWTw7XBEmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVL0sACgkQJNaLcl1U
h9BsTAf/euoTBL81jRbI5q8ZW7c/81L9UaPVST8lko3u0csVls06FN1P/6PP2CAv
WYokiT/HJhsWr1OgbjNFY+9wz6qy6cFctzEGeRbRU061v5y4CAvNeZJQ0S9Ke4pg
C997Fmx1ZNcE/MlleGq/Is529oFo/Z6hJnMErGV7x5hSORQhLv8FnnIO6PHfmWsn
0oF3mBft8Kylg3XozVTVC5CNK8XrJJUnxwgGx+Tx8J7lm/PLeARPQQznwumN4ZD2
CdLs5abTrvAn68uXUF9XWNSMotLsQGWcWZA9zqFRapxCi8dAhlqEm+RqvhUBh8Iu
9Gmsj4iEYOT7fLGh0nO2UzE1sXUvTQ==
=zEWB
-----END PGP SIGNATURE-----

--SgpHx0OWTw7XBEmR--
