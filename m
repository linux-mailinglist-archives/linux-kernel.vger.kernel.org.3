Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91558AA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiHEMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHEMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF061CB0E;
        Fri,  5 Aug 2022 05:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E07619E2;
        Fri,  5 Aug 2022 12:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE955C433D6;
        Fri,  5 Aug 2022 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659701467;
        bh=E5krPCIRZrK8/qq//dC7+fRo5E62XZPYtenh71CA28Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccp+C4RdU7KVktEp+wKhhLW1LKrW4eUkL30i1V+9K3Tr1ITQQxeQA3YsxNoqAQcSr
         A8L0rubj1d9lF+zOutO9/zp9A/KK+4p2GOvR7yhXlmk4Dh9dHqzdU2H50WI7f/pe4v
         NmySiLHv9esP5RN9WGLvC10iHz4/Zf9Nqa+NDPBjvauWi0wnQgjJhUb/RrER/vuXgK
         NKyQinfIfG92N4yOBlmKfi7F7dSTMQ1qA3psyxzCZbH9VxTi2xp9GAxofxcl7LDBFP
         5xhSDQS3yTfh8c8Xwc5Lapp4LLdmdtIbYrHtI9pg5BpVY9joGmW5Epk55vyrgxwfx9
         0v+e8Gzjo3vtw==
Date:   Fri, 5 Aug 2022 13:11:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     Nagasuresh.Relli@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Message-ID: <Yu0I1sxjC3SU5y3x@sirena.org.uk>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-5-nagasuresh.relli@microchip.com>
 <Yuz5jZlRLr3pBCcb@sirena.org.uk>
 <4054682e-fc97-377f-9ebf-da99d2f3ec5c@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iX3oYU7kPo5nO1Bn"
Content-Disposition: inline
In-Reply-To: <4054682e-fc97-377f-9ebf-da99d2f3ec5c@microchip.com>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iX3oYU7kPo5nO1Bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2022 at 12:07:57PM +0000, Conor.Dooley@microchip.com wrote:
> On 05/08/2022 12:05, Mark Brown wrote:

> >> +++ b/MAINTAINERS
> >> @@ -17146,6 +17146,7 @@ S:	Supported
> >>   F:	arch/riscv/boot/dts/microchip/
> >>   F:	drivers/mailbox/mailbox-mpfs.c
> >>   F:	drivers/soc/microchip/
> >> +F:	drivers/spi/spi-microchip-core-qspi.c
> >>   F:	drivers/spi/spi-microchip-core.c
> >>   F:	include/soc/microchip/mpfs.h

> > You should also add a pattern for the DT binding here.

> All of the bindings for the platform should have entries then
> right? I'll send a separate patch adding all of the missing
> bindings. I have a deferred change to the entry that needs to
> be sent to Arnd anyway so I can queue the two together.
> Nothing to be gained by waiting until this driver lands in 6.1+
> to have MAINTAINERS coverage of the bindings :)

Yes, it's better if everything has coverage - that way the platform
maintainers are more likely to see any changes that are needed for the
bindings.  Sending as part of a bigger patch adding the rest sounds
good.

--iX3oYU7kPo5nO1Bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLtCNUACgkQJNaLcl1U
h9ASgQf/YLOQsQWy0l9KBTK+PzxlGqGeEoDfP9rE6o3yBxc5lEdP5AgMZXWvoSwh
p3HDVbp7hPeYJECJGYYhY9nTaHhpC6Onxyk616H5Bvu0GtVY9djWStf9tiksQQQ2
i7nCunwQsPKI9uXnGaO6QYLEIZJPImKN5Tkv39ww/1Yn1L3uaryb8tMWz2yGILZf
JJMfE8GWJX7yQLC0beDmSLgWm5ieEUSxndQeMkQqFznGfzMT7jgzdaz/9muULbu9
JvGOjHoLlmwFezLgIlm3s9Kf+AS5+EexVskYKMOfGnZWgrIL9MAVVy2KgnhJDbW0
NtAF5WAeoAw+BQX44gLc3QQFTNp77g==
=QJAd
-----END PGP SIGNATURE-----

--iX3oYU7kPo5nO1Bn--
