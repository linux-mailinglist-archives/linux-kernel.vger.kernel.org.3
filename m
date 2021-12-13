Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3EF473136
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhLMQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhLMQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:05:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8575C061574;
        Mon, 13 Dec 2021 08:05:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EB31CE1050;
        Mon, 13 Dec 2021 16:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDEDC34602;
        Mon, 13 Dec 2021 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639411497;
        bh=gYOJ0eE8CCvPr4jpfQ6mfS7kF4867UnqkkFizMYGLUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEHI0j2095rXs6qyE/vwCb7G7BeXofSW3mHQnzSYbR29Iwn7jCh6UkttvWGasKUJo
         DT8rfc2EYHgv45v/xZS50BYt7BSApRXQ1IbpfZlhHKX/5PyGSBPvqRq4MWGW0A7NLN
         CUQRM7EVsSh3Lv7dHK4gHd/RkaAQl2SZ+uGW4dazNJDZpE5I2Cq1UlOZH29aPLwLRt
         PQ2B3LgQxbhyw2rRBtIQXFES8UHgh45V1qGNLxgxNhTAtLTZMnucEKmUUR8gSP7CgD
         jwGwRR/QaVa+Ttfso4eNvjgkxKaY/UgNFkkaaPlS9ox5ZsG9e5V0Hf0wxk8iiR6yzP
         51MtX4PP9gyyA==
Date:   Mon, 13 Dec 2021 16:04:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, bgolaszewski@baylibre.com,
        sean.wang@mediatek.com, bayi.cheng@mediatek.com,
        gch981213@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 2/4] dt-bindings: spi: add new clock name 'axi' for
 spi nor
Message-ID: <YbdvIPq1hKPmKXXs@sirena.org.uk>
References: <20211211204014.8014-1-tinghan.shen@mediatek.com>
 <20211211204014.8014-3-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QwPrMVYnODoVzv3P"
Content-Disposition: inline
In-Reply-To: <20211211204014.8014-3-tinghan.shen@mediatek.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QwPrMVYnODoVzv3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 12, 2021 at 04:40:12AM +0800, Tinghan Shen wrote:

> Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
> for spi nor dma bus clock.

>    clock-names:
> +    minItems: 2
>      items:
>        - const: spi
>        - const: sf
> +      - const: axi

This will cause any existing DTs that don't have both spi and sf clocks
defined to fail to validate which doesn't seem great.  Given that your
commit message says this is only required for some SoCs shouldn't the
minimum clocks requirement depend on which particular SoC/IP version is
being used?  Not exactly sure how one specifies that in the YAML format.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--QwPrMVYnODoVzv3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3bx8ACgkQJNaLcl1U
h9Ay2Af/XYQhfVonsGxpzYrxDghq96zvyoZ2t9jIwoeVsBAchQw3sdWrmcW0wQNS
s7GcStbgA5Kp6T6BLVIeXBNPpH5MmROzcbMYSGksS1OhNfSbC2TxR6P6eETIedRP
4eZCrBxdVHUpBCbJANRPBu6/T8cidCWwuI6Jv+p3keelFFzDTqZlxN6ow+ixW9zj
lqwk84moD5vigyuEGObDgdRTG987ruGDPpJH8hBqLzU0DzP8Hy7yi3jcodhwNwur
QEOL/OYrFqarwAjYA5ozzzecflRBPcjZ/jJvcHRCJTAPldJmmgXZdbOqO3KiXP6i
haN52/C0PIbcRtr6Aab/VWbZ6jKjSg==
=8YG4
-----END PGP SIGNATURE-----

--QwPrMVYnODoVzv3P--
