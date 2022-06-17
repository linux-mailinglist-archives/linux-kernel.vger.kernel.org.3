Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802B354FA72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiFQPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiFQPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:39:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D444ECE1;
        Fri, 17 Jun 2022 08:39:50 -0700 (PDT)
Received: from mercury (unknown [37.80.217.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18081660179C;
        Fri, 17 Jun 2022 16:39:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655480389;
        bh=YANkBwwqv+C1GfMRnd9WWOzMvhipRqoSb8BjKUKaNhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JndddiKp4b+1OnhOiyhXN3DvvREL7XfGITMDMtLCueHqMYmt/FfVPKxVeR3yMDTti
         m6rCI9PI09T2POtgjdQHMtmucZ/tqxXLNEKFien9hHax+30496maOyKNhCnxJB7TDq
         aboFfWu27vuqXCI7sN2sTbAiE1Isf7xi6OpF6TW4amJzq56BfPeZcsHFTr/54oPiOr
         61aE8vRGM88vcT2wqaiGXExlsUQ5i5LLFxOl2qUx6g+sJKJ6Yj3d2hET5xf4Fn1ULm
         5IaMgLKgXUSt+HgrbHdHPUT513qzOJyWZEZ/tPbSEiw72FfEZnV8pU9gUVG4PqW9fQ
         bstLSDOM1Grkg==
Received: by mercury (Postfix, from userid 1000)
        id 60E26106031F; Fri, 17 Jun 2022 17:39:46 +0200 (CEST)
Date:   Fri, 17 Jun 2022 17:39:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] power: reset: at91-reset: add support for sama7g5
Message-ID: <20220617153946.b3ozflfh3ilw7isn@mercury.elektranox.org>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="euejnohhener5fms"
Content-Disposition: inline
In-Reply-To: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--euejnohhener5fms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 10, 2022 at 12:24:05PM +0300, Claudiu Beznea wrote:
> Hi,
>=20
> The series adds reset controller support for SAMA7G5 SoCs. Compared with
> previous version the reset controller embedded on SAMA7G5 is able to
> reset individual on SoC devices (e.g. USB PHY controllers).
>=20
> Among with this I took the change and converted reset controller
> bindings to YAML (patch 2/9) and adapt reset controller nodes in
> device tree files to comply with DT specifications (patch 1/9).
>=20
> Thank you,
> Claudiu Beznea

Thanks, I queued patches 2-8 (i.e. skipping the DT patches). The DT
patches can go through the ARM tree. In case you plan to use the
dt-binding include I queued the patches via an immutable branch
that can be pulled into the ARM tree:

---------------------------------------------------------------------------=
--

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/at91-reset-sama7g5-signed

for you to fetch changes up to a22c8e8834bcc55e44d0bae738f0915df7e6f573:

  power: reset: at91-reset: add support for SAMA7G5 (2022-06-17 17:20:00 +0=
200)

----------------------------------------------------------------
power: reset: at91-reset: add support for sama7g5

This adds reset controller support for SAMA7G5 SoCs. Compared with
previous version the reset controller embedded on SAMA7G5 is able to
reset individual on SoC devices (e.g. USB PHY controllers).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Claudiu Beznea (7):
      dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
      dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
      dt-bindings: reset: add sama7g5 definitions
      power: reset: at91-reset: document structures and enums
      power: reset: at91-reset: add at91_reset_data
      power: reset: at91-reset: add reset_controller_dev support
      power: reset: at91-reset: add support for SAMA7G5

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  15 --
 .../bindings/reset/atmel,at91sam9260-reset.yaml    |  68 ++++++++
 drivers/power/reset/at91-reset.c                   | 184 +++++++++++++++++=
++--
 include/dt-bindings/reset/sama7g5-reset.h          |  10 ++
 4 files changed, 247 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam92=
60-reset.yaml
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

---------------------------------------------------------------------------=
--

-- Sebastian

--euejnohhener5fms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKsoEEACgkQ2O7X88g7
+ppjig/+JP6jwyfcp/eLbAf1cRhW+QMNS5eLDyM7NjtMZZ71TNJP4Ce3psOKrJgY
m5TAk3PNgKLPxCXbGLMktTxE+4cxwv5UfXp+LUbp3IADYKxTMEg12U54GtM4q7/5
Ao2IV58Jld7+DYmCiJcRg9I8eeHYOjaU5zTMxSKVg4wBWnGSYGAZYwUEVY28XNjD
RfEJD/ddsUP3ksMFr67ZBdcY83mt2hTr+/+Axh6lrovrqr7X0EGENhUxLRPFQPWe
vGY4Af359FDlt0JtYXNr0D7WpnGOVEl1KfFkwdC9GmLq4wYdK/P0eF9jPqsW6S6l
+Gp7u05qej6AXSsYL39phaJ0pamJ6Sca7Ww+33h7I21GrZsfFwWq7RzSY+J9btNy
iIoA8ANTake18v8VAi6tyHSRhS8F5ii9ZTRreaRPd7BUB72N7CrjWhHmcftR9OR2
eBUnWmRFxMkCl8fzaFylVniYV/nj1z9VUzaIJIaLLYEHWHD1UO7YzJNzniBrucZN
xkEMDAKgpyxCifVGMUsqu2lO5+owED8lvTv4w0k5cVu2CFCeWKc/+iZactMWm3CJ
ZjeBpLWrmkXzW95n7MQmxyKIqyN0p7eB0+2iGgsvWrqxrYAWHDPv5SrU2QhSoWio
GyHCSi55EiSWbOWVsGvB0Nk6Nk6tDVWVbz+lfmHUJ977MZfjnuM=
=N0ad
-----END PGP SIGNATURE-----

--euejnohhener5fms--
