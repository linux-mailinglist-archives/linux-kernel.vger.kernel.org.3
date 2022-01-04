Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F54841F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiADM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:58:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17AFC061761;
        Tue,  4 Jan 2022 04:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFD361365;
        Tue,  4 Jan 2022 12:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF50C36AE9;
        Tue,  4 Jan 2022 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641301101;
        bh=LzoQO2hf4XX3/HUBnlnFiJ5QFaegJBMT/iDpIg55KLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKJoLHTTmEcMJnHrPW9JVsdzyu90qTRxtyNl5F/lMBQJtN8ulY4u6vIukzde79TCV
         J4QR0S0itnKTOE1/zvGj25MnGLnaUCi3TWp+KIrFBvqGT5iHWgOWhGmIZerhmbTFbq
         Ts5cUaMZjeymrnu55bGJICQ4IqSn8vL7z+pi9ejitXo+gr5qOgkuYY1EwyowCgfwLU
         pw5tClChoi1X+I5VHX45+2ICt/GZ19KzSoJVTPbzVpOvTqQYJzTprF0StfN79uXokP
         jpxMLJGrUJgOFzIMunbGk9v9eH2/rqLoRGVbrAkoV7Uh3IAm0yrY8FcnfDUG1JUg0V
         WokZ2+skcXl3w==
Date:   Tue, 4 Jan 2022 12:58:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <YdREaCo5BXHqtoex@sirena.org.uk>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
 <20220101072548.GA28593@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcLhnphaPbaFosOE"
Content-Disposition: inline
In-Reply-To: <20220101072548.GA28593@wunner.de>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcLhnphaPbaFosOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 01, 2022 at 08:25:48AM +0100, Lukas Wunner wrote:

> This is especially important if there are slaves attached to the
> controller which perform SPI transfers in their ->remove hooks,
> e.g. to quiesce interrupts on the slaves.  Those transfers won't
> work the way you've structured the code now.

The client drivers shouldn't notice - their remove callbacks will have
completed before we start removing the controller.

--HcLhnphaPbaFosOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHURGcACgkQJNaLcl1U
h9AUEQf+Igyc/1O0NNplnnLghLj1kcy5L8WBE6CmUviTtGu0tXcIassqzUHE1j17
m1kWJnuCXsnuxOsY20S3GMhSKe/lXFcHu6pxkvoZI3FV4P+96RQ+FtWToKarAcDe
m7f0Ye4qN/TZiEZqtHTZDFiwiGj89YOKuW8CEoV7CVccxQHvF2YEGv5RaC0dJMT1
rDtrtTY7A7nuBRqfYcJJ4rojwcyty6bB53vXXQvG0z6XOtc6/SnkOFM9cTIKa0Yc
kwky409Rva0aXq7t4PK0ldoUknbewTuzjpVYkbuLl5SGl4VI41ywnWiIic2wEKNd
XYCyDO3RXPYTpvIKhtCsejqz1JeNww==
=jKXj
-----END PGP SIGNATURE-----

--HcLhnphaPbaFosOE--
