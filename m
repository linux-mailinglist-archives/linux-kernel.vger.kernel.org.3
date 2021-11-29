Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35109461614
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377578AbhK2NVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhK2NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:19:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F655C0613FC;
        Mon, 29 Nov 2021 04:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6BEDB80D53;
        Mon, 29 Nov 2021 12:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BCC004E1;
        Mon, 29 Nov 2021 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638187280;
        bh=vBptFj3aUeLExHyhRFb83+obbB6Bl97pRM+m9eY9FBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q72LQRu1mTEz+Jg5z90HKLdULb2cMXdwgRTsKMz52K35+buD2YNdkVuURuvv1+md2
         vmtq9veflhF0hJ14OpijEuNN532o/BnDXS79D+Ip58pbsHR3xWUUa7eWow7xJj1Fxq
         8iSNk00MYyPBz3rQAC4e5sflT5h8N9QIt4hZrq+IVW0yV13KB4m0HD6Jukvx4JDNGm
         6QqC9XTupUhvv5Zo/HlIb4nwftvwGIbvgXEOwJpSk8E9f6rMycyKvw8tI3hLaW0yFT
         0aXohm45Fodjbeh9z2UbW6RiQrt+F7EYLT7MQ5FZRZzEKCRGXddliuaJkHclzE9gM1
         mfVq2mU093pMw==
Date:   Mon, 29 Nov 2021 12:01:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi
 compatible
Message-ID: <YaTBC0Gw5BzE1qq0@sirena.org.uk>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
 <20211127141910.12649-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thPcABwJnBXBpjkW"
Content-Disposition: inline
In-Reply-To: <20211127141910.12649-2-frattaroli.nicolas@gmail.com>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--thPcABwJnBXBpjkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 27, 2021 at 03:19:07PM +0100, Nicolas Frattaroli wrote:
> This adds a compatible string for the SPI controller found on
> the RK3566 and RK3568 SoCs.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--thPcABwJnBXBpjkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGkwQoACgkQJNaLcl1U
h9C79Af/VkQzSokkKhu4i2rEQ3wVt1TXWw6OmUYThFsujeHoBzXRo3iUqgLnvegr
UhqQ9HI5E9eXRfd+EdYCsru73RDrXe2Jxs1/09RYMZHxb7In/FFRdyd1TUTv6PYu
bNUqnhdpnyGV/59n4FVsyt6zcifp9NGqSZhJW5lSQF9RMagaAa1iY+GOf0OTrUoO
Ib7evx1ALUZMtqE+CuQ5PW0EmjvqWk5hlAa63RUZUHkG3v2bE/nn79uHeWdB8mTW
tQVlPbFsFhiBH7pmWqjpEHERfAzSUj+wEcz1WJYqZ6EG/mTJQA6lMncn2RjbAPxY
BXDGGW3SsUs8RFRlFmBwihuE8Bh2iA==
=onyW
-----END PGP SIGNATURE-----

--thPcABwJnBXBpjkW--
