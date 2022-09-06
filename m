Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809195AEF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiIFPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiIFPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:54:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23E8B98E;
        Tue,  6 Sep 2022 08:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FB8B81919;
        Tue,  6 Sep 2022 15:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1405CC433C1;
        Tue,  6 Sep 2022 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662477155;
        bh=bD0yKhphSmBVVLUyMPYKB5NUPKImxamaOv37wNGzfVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/X1/ApvsqezV4eN1BIndC2/MAwkQm3YupuJBYQmD8izTSnTp/lrI35aWbBr4zeVc
         RrxtZze9J3pTr5iwZMJWvEqU/rnzOxj7jVk2RnBIEPpBmvqamYQx7zcu17ut67cWKi
         dRkfKWk30sRB8xj2AMRr3lzlVMbw9RHW09kJ9OnBYyEv7uLfy5xocv6HsKALoGXySt
         ejOOkisZ96Ucfu1HHjJyLbB2sFPZm+NZfhiDksAp2OHDMd0cdYkr/6ne1hIpcUHcF0
         Oge3E055C3Eev1I0kGxKPo51kJb7A/FLEOfwa+U13HiT1y0+KWMg6nK0jsTahy6JDx
         rK3LGPYULPHmw==
Date:   Tue, 6 Sep 2022 16:12:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA
 related properties
Message-ID: <YxdjW2HXcneKvP3c@sirena.org.uk>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-2-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RiykofuyQSrEwF40"
Content-Disposition: inline
In-Reply-To: <20220906135511.144725-2-sergiu.moga@microchip.com>
X-Cookie: divorce, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RiykofuyQSrEwF40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2022 at 04:55:00PM +0300, Sergiu Moga wrote:
> The DT nodes of the SPI IP's may contain DMA related properties so
> make sure that the binding is able to properly validate those as
> well by making it aware of these optional properties.

Acked-by: Mark Brown <broonie@kernel.org>

though it looks like perhaps this could just go separately?

--RiykofuyQSrEwF40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMXY1oACgkQJNaLcl1U
h9CFSwf/f2WJjlGGmV0h/sjORBcMhneYZgMVZLsU1og4qFz2YDAOtYmPZnu9DQ+0
Kra8RSJuu24fqcKgfjibNu9WMF9rhWVJCCW4Y0loHGBWWUf5ZFOXTLB0zor5WZjg
nUodeAOO6krDC1SL5lmly3FP9DCEuYQoJ2PxH3Rh/3Vrvb0PWNbdGV6gJ8+KitmB
eFlcVGlxggLpFxM7AZrpTY7cNt8XBmP3jQfo76+14nGSX5UsRIvvBt3To3ml3yyd
wHF17Rb401msATbqq2sIy0GtR2ouz4KB42jNKYz7IF45cu8V053xJNwFY4P/5Epj
XqqBL2HP7BaE5e8g7rqEqHrVv+jdXQ==
=GClE
-----END PGP SIGNATURE-----

--RiykofuyQSrEwF40--
