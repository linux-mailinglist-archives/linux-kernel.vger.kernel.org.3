Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2594707F7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbhLJSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhLJSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:03:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB7DC061746;
        Fri, 10 Dec 2021 09:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 658E6B82914;
        Fri, 10 Dec 2021 17:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D356DC00446;
        Fri, 10 Dec 2021 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639159173;
        bh=bBSxjH8QSMhD8e8s4DODPS6gWJiodf4WX7lpdz2HSMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiKf/ACo3eK481gfwEHBK3uNNsW40hy0NGBNshjiFMHwPpx6FlOehXX/TgmvrkOxQ
         K4LleamkRphnEtJgu85JApyoeL3gBO3kPypZMGPlFVGRZ2u3O4zgrJ0JW0rK8Hc/Ph
         sMD8XqcKGiFwGjudkNh2j316R0ZU6jnaew3f+kMxV7SU75i78UA0yaH+I/YbBOk7IF
         o+JOPtxpNDEV44KEWEOnKbq13+rCR4lrtmQf8xw73nH4i4HJ+ywvv53UaehUJaPW5n
         bE8oHNK8yNKlbEfGUP1Ka/zsWA3r80WZNnSK08tKkPLDJpvOyPF8SjfC52RnNKCjMx
         L5HJLmkBfYMEg==
Date:   Fri, 10 Dec 2021 17:59:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/6] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
Message-ID: <YbOVf5eGwCqJDgvv@sirena.org.uk>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
 <20211210154050.3713-4-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qOlWQJXGoEsgX6ji"
Content-Disposition: inline
In-Reply-To: <20211210154050.3713-4-sbinding@opensource.cirrus.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qOlWQJXGoEsgX6ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 03:40:47PM +0000, Stefan Binding wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>=20
> Moving I2C multi instantiate driver to drivers/acpi folder for
> upcoming conversion into a generic bus multi instantiate
> driver for SPI and I2C
>=20
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

You've not provided a Signed-off-by for this so people can't do anything
with it, please see Documentation/process/submitting-patches.rst for
details on what this is and why it's important.

--qOlWQJXGoEsgX6ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzlX8ACgkQJNaLcl1U
h9BVCgf/Q0C7sSyuSXNPjiKUn5rnye0V4Bkv3GXGXSTyI4fbTgAwNTN8b89uE+M/
yVAyerexUJ9PbtoerGU3mfsCVeVnZCpfDExkTzTGriphmnx+X7QrwAGcWEWiKihk
hcw1VXZzsxijPqJAPWAC7Vm22X61oB79lT33goMPNQyooklcsGqLVFKtXREx2tGw
qCWDZEu6OSqgOqJJxX9MiBUAzfRU2s57EXyYPZya8j+vqNdI9yzKuGoUkvWiB0aH
j1K/luBUzgmhlzj3zPkRdQs4dc8PGc8/tdYNaRaqKAqFbOoDlYO6q+CCkbJBgrNY
Gqhn32bNKvV9KUZpYGj4IdzHB+mbAQ==
=a2Q9
-----END PGP SIGNATURE-----

--qOlWQJXGoEsgX6ji--
