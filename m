Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3D4980EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbiAXNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:19:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37486 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiAXNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:19:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A583AB80FAB;
        Mon, 24 Jan 2022 13:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B266C340E1;
        Mon, 24 Jan 2022 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643030341;
        bh=+MVWVjmHsnFdqdROLxwGRRRLpP1Y39im19Biy0aR7pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+5b48gFcOvXNA1kPuEgkWwiohSql6bvOlD4rcDMp1k0RgUBRwGF2R5h8hrbgw2Yj
         nWkq1CsdUA7gf3tEeHUtiDtKd1ZH/ERYW4cPVpy9YPXGEol6MdKwVNPcB/sK0DVot9
         C/M9xvOvyoUNTFipB6if0+s79oKaV5YuAYxOSqB2QTO0RRjnYUq7K9AYzNc1ER9aZc
         KOjxx9IBUruoUfm/XbKe1L/TTtEG+7e1gbyyhjm5dK3TSoSCcQXK5tV0/ErwDquH0U
         beQu+Em2O21CVew9Ps2Sj3p6klvoKU0FnJfNvcJMQUkj6jXgUyyit9/PrrkV3vwtfv
         akzESg1XC7vdg==
Date:   Mon, 24 Jan 2022 13:18:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V3 1/2] dt-bindings: spi: Convert spi-mt65xx to
 json-schema
Message-ID: <Ye6nQIVoti5TKh+k@sirena.org.uk>
References: <20220124061238.7854-1-leilk.liu@mediatek.com>
 <20220124061238.7854-2-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2cofXUm2ThNHvf8"
Content-Disposition: inline
In-Reply-To: <20220124061238.7854-2-leilk.liu@mediatek.com>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2cofXUm2ThNHvf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 02:12:37PM +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Master controller binding
> to json-schema format.

Please make any YAML conversion patches the last patches in a series -
there's frequently a backlog in reviewing them so having the DT binding
patches first blocks any progress on everything else in the series.

--v2cofXUm2ThNHvf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHupz8ACgkQJNaLcl1U
h9B8ZAf5AZ25SlrujmxJNnJRmptUEyQU9a2j8mJ0o6DR8eQGjMHE3n1/ppct/BEv
LwNcF2C7W0lNKIILFQ+oa0hdHcj74wVsvvKECMD/CqgJxG93v1KlD+KRVQHbAiTJ
g8kXyvqwsN+YiUkqhbZ1tiHOUVNeB2sLu70wQHXPCLZ2UTz8QAY9Qi5eZ+3XxVDf
RysYKB8Gfvi3nXwN4UA6ygBWc6W8Ax0r5I1K+GPUqsFjWwatfgVZwIxW2N1+5JHL
eaQrA5Rg6kg+NINBAtWjhQU+C/QmR2fHj35qJbkjWfY0Yr5P7f02NSl4epEI3FHd
JuKzOkcS7o8XB29ERzpWfkskxIfbXA==
=k9qL
-----END PGP SIGNATURE-----

--v2cofXUm2ThNHvf8--
