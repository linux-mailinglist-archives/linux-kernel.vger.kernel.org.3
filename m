Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220224F7D77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiDGLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiDGLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F7E3EB87;
        Thu,  7 Apr 2022 04:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E866B82723;
        Thu,  7 Apr 2022 11:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE78C385A4;
        Thu,  7 Apr 2022 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649329358;
        bh=ORFRCbWj/EjWk7E0RjZgO03e0x3on7bow6Av33bkjT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uddIV8PLjQHuNS3bEbtmBzYq7XWxueW2ZlUmcSI+VdZw+SJRjnL1Krj/ofUQ0ovrc
         dfQRQOB3gEV5WKkUlwla/LhPC0S/Lv80fMe+MjrOAV34VbB2tmzwk8VxOD3GWCrNSr
         qNLdsvRfXzoMeGHFmFbfTkDBaM8lhlt45NaTrpI1cpGODDvsCzduHUZi7XS6GLkqFs
         seW5uXM4uc1CbZ3FJ/4xN59iyfVgZ2tQtFISKwJAkcYRww40QQ3L5nJtuuin2zPCKf
         Paw7lCd8xjK9glYz6xgfaU7BDopLEutsmCIQf+vbhrqA8o5uJGZ2eJq/qVyz4mFOcQ
         nomzEyCaNl4tw==
Date:   Thu, 7 Apr 2022 12:02:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Message-ID: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
References: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl+D9xSOnfbnTo44"
Content-Disposition: inline
In-Reply-To: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl+D9xSOnfbnTo44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2022 at 04:24:20PM +0530, Kavyasree Kotagiri wrote:

> @@ -19,6 +19,7 @@ properties:
>        - microchip,sam9x60-qspi
>        - microchip,sama7g5-qspi
>        - microchip,sama7g5-ospi
> +      - microchip,lan966x-qspi

Generally DT compatibles should be for specific SoCs rather than having
wildcards in them, even if that means you have to list a lot of SoCs.
Having used wildcards in the past doesn't mean it's a good idea to
continue adding them!

--sl+D9xSOnfbnTo44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJOxMcACgkQJNaLcl1U
h9D9FggAgc5pFn36W0ydx/B1WZBx3FF3Ku7q2SH56VgVypwvh1h6vvhFkLNiDRee
MwBh7/AZmQhxK9frdGJhVWJ4UWtcPFA71G8qWLEAPCnK3t/EDX675CtOo5zg63Sl
vAnlpHS2MN1TeV/ys48hVR383PQ/pqICHZ3x+Ul7n8lPJKgMom2e7AOpM4QSbOON
0RURSFVSctdeSKs/k5uAapS9kK5JsyOk+65MKtMCVHiRnu0PJCkr3ZxuelZntgbS
188yvdtjBylm/4qGsPncB0/VEh1JOhN0yPiZaWJ6Wb5vDxDvwrwwhsVuzfzeXkTH
ae4jeAjWZkfIXs1ixYoNw4Nh5pUAGw==
=1tb3
-----END PGP SIGNATURE-----

--sl+D9xSOnfbnTo44--
