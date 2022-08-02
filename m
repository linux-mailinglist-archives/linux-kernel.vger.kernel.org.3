Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EEB587CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiHBNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:13:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DED2737;
        Tue,  2 Aug 2022 06:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F35C1B81EFC;
        Tue,  2 Aug 2022 13:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D47C433C1;
        Tue,  2 Aug 2022 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659445989;
        bh=nCaDyEtIbkjRMPVGtA72MurPtE7v7zbuYlbgSxCOwzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbZnIEPs5d5t6TfoNGHqIkchT4qm6G7Mkj4udtHDw1CKcGfezN8bBfmcEF+h9Bth1
         eAfTEFmw8/9EpbN0TP/2FteEi6XORFBMgZSqxU3T1b2v8zSg4Ph16aZPmGRDnpU+V6
         rehOjEvOY2QAPQFLOgeG1c91Pc0QiLs1GWNA+hEC9O9rspphdyQ0W5SMNy0Wf2YDGN
         +5R4RcNeIjXsBBsrcz9jBWrmiRxt+KbXV4BMyz1yUyUJE8oKmRdtaMV9Mf2ZYqtrAo
         PC07zmMh9z2Lp3rw1okcL/EvioI2OFx7StndikvU7NrE2Fs1Ioy1/yqRcmLwxrpZ2Q
         M0ewtz6H6c4sw==
Date:   Tue, 2 Aug 2022 14:13:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Message-ID: <Yuki3jpCSJDdXcWA@sirena.org.uk>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FG8oGUKVhgxoIQ9N"
Content-Disposition: inline
In-Reply-To: <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FG8oGUKVhgxoIQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:

> > -    enum:
> > -      - microchip,mpfs-spi
> > -      - microchip,mpfs-qspi
> > +    oneOf:
> > +      - description: Microchip's Polarfire SoC SPI controller.
> > +        const: microchip,mpfs-spi
> > +      - description: Microchip's Polarfire SoC QSPI controller.

> Useless descriptions - they repeat compatible. Just keep it as enum and
> skip descriptions. What value do they bring?

Someone not familiar with the full Microchip product line might not be
aware of the expansion of mpfs, it's not blindingly obvious.

--FG8oGUKVhgxoIQ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLpIt0ACgkQJNaLcl1U
h9COjAf/fxpLRWiWJdErAvsAeQsUJGuknUyrw2SIHq2AcHl3fZaG6JY7zA2qplg0
sMM/s6UW+GVyBhx2T8ghJcHWqu550wxYi2TVcBsktNnrGIZZN0VOad8BJggO9MOa
+nF1G6gIomc8Y1b9LpaWaxyNtjIwIKYPMJ8THcaiuBL5csuiQt4rDMrVjLJd+fUH
OJXaaGAjmJzm9Cutj43JdmA95h/qtcpRc3OhCj4A1inkPGFr4f3sNdKwPROstQq2
4xYMWLg9dinePs8LU2wK7S6cc65XAgJmJPJJf8+Q4TZWKfek23laLVZL+MXci7uL
Wi0Kj7DGa5QTdtaYOktYxZpT+TCeZQ==
=VsFA
-----END PGP SIGNATURE-----

--FG8oGUKVhgxoIQ9N--
