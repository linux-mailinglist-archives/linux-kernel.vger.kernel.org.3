Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB25342A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbiEYSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiEYSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F199C2EA;
        Wed, 25 May 2022 11:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E0961867;
        Wed, 25 May 2022 18:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CEC385B8;
        Wed, 25 May 2022 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653501845;
        bh=aXmnGc30QJGOKnN8QGtQjSLondicMdgxQV+6Gc9Sh/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxyodLmRuyCrpbMUZZNxFu5dlcR3qOO2YZwt9OlXqebqLiPLqG2eezzupIFfGuZYO
         JeUmLx8IgpsVAE7NPPZiTUcWgqlh4KBdOaKsLdDUu8qL+CGMjzHe/SxlnQDkMLq5xZ
         8y7kU1Kv179sSDj8/2yBOfKH+/O4aQjXBERYkAcFZndj2B3mXX8kVyqrDdUQMeRmIH
         ybYeqzZIPPCMsRbCwZdkXbw2zISzAHVseQq+XBnzeko/6VVLLLIYKT1yYD63k/rq2r
         fPyZZ11e9m5YQ6/kT6z3UYucAJOqc2Quj39F+HE2WnVj1IrJlUzS7YYBmMRHVmPTGu
         n+SfyN62v0yzg==
Date:   Wed, 25 May 2022 19:03:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lgirdwood@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v21 1/4] mfd: silergy,sy7636a: Add config option
Message-ID: <Yo5vjlsc0J1S70zN@sirena.org.uk>
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xb1VzQtLyCGCdeJs"
Content-Disposition: inline
In-Reply-To: <20220525115554.430971-2-alistair@alistair23.me>
X-Cookie: The revolution will not be televised.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xb1VzQtLyCGCdeJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2022 at 09:55:51PM +1000, Alistair Francis wrote:
> Add a specific MFD_SY7636A config option.
>=20
> As part of this change we can use MFD_SY7636A as a dependency for all
> SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> it no longer needs to be selectable.

Acked-by: Mark Brown <broonie@kernel.org>

--Xb1VzQtLyCGCdeJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKOb40ACgkQJNaLcl1U
h9CLMQf/SYOirRs4xevMFWKwchUx9dZjBAZGSX9cLlqyYVhhGte8LLyfNWGjO605
bbx8N4Q8Z0itYfpdSHmROf/zzzg3X8fBeyp0MGERDD1EVQ31jT72kdKQwG0c30EH
okNTey8mkegdzGNq0HnFc9ONLZNb2j1N7IyDlouLz4dfrLJ7cbAUoDGvm22hBBcT
qu17BREdc4Sk0xAYeVyrVB/bqKI+lFVjhZG5sY9rJ4zR1BQo48v4ldO62Mygg+fd
xZsupSjAH6puR6PbljGj1IHkDo29/HRuKu4ddXULcfrrrIJVIhY/+4nuCBIPTlNK
olabG3BZiqm3ZicYMKlP3ICmtIikuw==
=zAb/
-----END PGP SIGNATURE-----

--Xb1VzQtLyCGCdeJs--
