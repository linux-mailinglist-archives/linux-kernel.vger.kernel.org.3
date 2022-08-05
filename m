Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642758A9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiHELG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiHELF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F453D39;
        Fri,  5 Aug 2022 04:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E581D61956;
        Fri,  5 Aug 2022 11:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9F7C433D7;
        Fri,  5 Aug 2022 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659697555;
        bh=pNm8o60WcrpqZNQmthJuzqcUIWAspbQ1Az0XLlsbCR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJuZIZaVcxnq3R1zc+Mvxk5dM8hFDJsPpKo3jodqU1zm49gQxVbDXPEmgFMGYBmqz
         7K/edWHIQPqkQ+FrYyq0o7bESBNCzl4Eqed6X3DbRANZDckYsQQEW9AZVGwwPcslzy
         7dR3+ikfm4Iq27KSWHYzMYiIydgdmZ1z8GvOT+1Ae3ZOPePfiGABJaLJ6UBpAJugDx
         YPbgALIhD2mplZ+XkftNB1mikwQ5es9EBcxdgbXRabQ9zIARIy5A5ApQPU5NLM/TCl
         EVzaRBuK63jnAA5xdTAP7+lUVHbXz2qjwzdMDnfT/5Q3d1NlW9ZaIaJbUZ/LWQ6M5T
         qBc5wEl4QG2DQ==
Date:   Fri, 5 Aug 2022 12:05:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Message-ID: <Yuz5jZlRLr3pBCcb@sirena.org.uk>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-5-nagasuresh.relli@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywua4javZ5ErbPML"
Content-Disposition: inline
In-Reply-To: <20220805053019.996484-5-nagasuresh.relli@microchip.com>
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


--ywua4javZ5ErbPML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:00:19AM +0530, Naga Sureshkumar Relli wrote:
> Add the qspi driver to existing Polarfire SoC entry.

> +++ b/MAINTAINERS
> @@ -17146,6 +17146,7 @@ S:	Supported
>  F:	arch/riscv/boot/dts/microchip/
>  F:	drivers/mailbox/mailbox-mpfs.c
>  F:	drivers/soc/microchip/
> +F:	drivers/spi/spi-microchip-core-qspi.c
>  F:	drivers/spi/spi-microchip-core.c
>  F:	include/soc/microchip/mpfs.h

You should also add a pattern for the DT binding here.

--ywua4javZ5ErbPML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLs+Y0ACgkQJNaLcl1U
h9CoFgf6ApZqz/NcbJDelXqvJVLB4zcDCXYR3hznM9Ywkh5FznAF6LFolO0MK+zG
lds2OseI8K7Py83ogA5FPYyjhPiHXmKQTt8Xdpyh+MIhJy1oT4c8e9gvDyN2lP/Q
XW24FpDFPx2pHecSBaoxo+TjLBJuZoe8ugvTIQx6E9PnCkvkCp5KIpkLJeezFmRE
VAEu5LhY1JkECussTupRUUK+T3YXGoRmFQbWEPgnTUtR7cRr9dJu/x+0oKe/CJwp
bg8MKAuVA18VgQ3DUPR/b8hEe66fFcLzfIwG3W/uxegdkQgxKu04bDN/99QVV42p
dzsAoTdFJRngCH7AyaZ51fFnmutPJg==
=NfvA
-----END PGP SIGNATURE-----

--ywua4javZ5ErbPML--
