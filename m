Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81D4F829A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiDGPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiDGPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6171FAA16;
        Thu,  7 Apr 2022 08:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2719661E16;
        Thu,  7 Apr 2022 15:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB02C385A4;
        Thu,  7 Apr 2022 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649344556;
        bh=fkUDGcZMuwhIXlCoSk+tbUQ1xUG4zQs/G/1OVgPCREE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bd48Y7UHPAbBiKO0ZxHoZekW8iqfOCfz5umBb4NzHj0BSf65Aifrapao09r4GlVPZ
         hCJr38My9FpRDgkGzKj1Ddc8MNR9wVGlRZfsw6qAmjw4Vgkmg/x24oqWEey3Vm5wzm
         I1RLmhB5M40vf127g8Ih7qrwGrTiftLBTBwLkLb0ysl1u26kvMeplIAVSZzvBWyyPs
         phsAKZjzJGyKFWCG8wwfrjZpPOqPH6p0qgPNJPFUQ2WdddpSy7HDXBebN2P6bV+o/x
         axmpkWPxhsjh6Skc2+CVFPM7r8C53dwjSVZJcSpz5DgSrBijJXjcx5nx14NIAf7bgC
         60oAg8lqcWY4A==
Date:   Thu, 7 Apr 2022 16:15:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: align SPI NOR node name with dtschema
Message-ID: <Yk8AJcFRmYEryqra@sirena.org.uk>
References: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exxHKs3vl5yFGvsK"
Content-Disposition: inline
In-Reply-To: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
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


--exxHKs3vl5yFGvsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 04:34:05PM +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt | 2 +-
>  Documentation/devicetree/bindings/spi/spi-davinci.txt           | 2 +-
>  Documentation/devicetree/bindings/spi/spi-pl022.yaml            | 2 +-

Acked-by: Mark Brown <broonie@kernel.org>

but it would be easier to split this into per subsystem stuff.

--exxHKs3vl5yFGvsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJPACUACgkQJNaLcl1U
h9DhFgf/f0zclEq8qn8Edqu+LBr0uPAux3FUc79aJUiaw52UFqSsyCwAVD1XqJfB
6AWYVRrGg8ag/JiZSjxzzCQT8tCaZYgUv5FgBL0krLTu+UX9AFJtySLzv9Eh75P/
BxXn0lVp+eIfEuOKMgzoDbgfLDPANIdb2L6GlSecg1+SV5cfd1eS3xii/zo5woLo
5W9Z9rV5qACqdxC/7W1MTDk2qpHwM5onJgpslswaJ1j3kT72otXnKBTJNmk3jNO7
6bXycpaaSp2FfaVQD+L4JrVXJVHVtejlxAe1zRTYgPoLAY4Ga4N9u5dYw59AgY83
zC9tmaFzlEqB5ozAx2YSOPhf+IIkhA==
=8MWW
-----END PGP SIGNATURE-----

--exxHKs3vl5yFGvsK--
