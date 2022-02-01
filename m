Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483C74A62B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbiBARl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:41:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiBARl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:41:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E5C6123B;
        Tue,  1 Feb 2022 17:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF857C340EB;
        Tue,  1 Feb 2022 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643737287;
        bh=xqurn0aMLg9LPORst7+QOsFe67TLB0BWbKrD5lJaEUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhHJogGxV9fLNWcbgdHNbs4+6IXOssN8O5a+LqiuEY6P07FpWmF/V00NmNuNAgUqO
         kKdSLwkI8CmW+4H9dbwuJc+ABJUEQvo2E2N/uoDRkYkT3ZPJuyFbZu43Q3gd+OnsQw
         fYB5RWS7G5erqCaqn5LNsGO0YnZun6GjONge/RFt/ej5tHy1NHmWd1yfxfTooCHPMQ
         OxurKPbSFYwaXOqklMaETsz+0+Y70jMdTuHpjFJfqSEenTNQhmwiodDdNrv1FlQKH+
         p+tQhFU0RQ6NVojA19GGX4+lq6bNYZvNCDlQ1qGcjiwQmqywzurGJ5DlSKTLTiV7w0
         tKZYDzdCKiHyw==
Date:   Tue, 1 Feb 2022 17:41:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v6 0/9] Support Spi in i2c-multi-instantiate driver
Message-ID: <YflwwWD85CmSzlgT@sirena.org.uk>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f9iEEYctSRFMQhBo"
Content-Disposition: inline
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
X-Cookie: All's well that ends.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f9iEEYctSRFMQhBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 21, 2022 at 05:24:22PM +0000, Stefan Binding wrote:
> Add support for SPI bus in the i2c-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-acpi-helpers

for you to fetch changes up to e612af7acef2459f1afd885f4107748995a05963:

  spi: Add API to count spi acpi resources (2022-02-01 17:38:48 +0000)

----------------------------------------------------------------
spi: ACPI helpers

This patch series enhances the ACPI helpers to cope with multiple
resources being available and exports them for use.

----------------------------------------------------------------
Stefan Binding (4):
      spi: Make spi_alloc_device and spi_add_device public again
      spi: Create helper API to lookup ACPI info for spi device
      spi: Support selection of the index of the ACPI Spi Resource before alloc
      spi: Add API to count spi acpi resources

 drivers/spi/spi.c       | 137 ++++++++++++++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  20 +++++++
 2 files changed, 141 insertions(+), 16 deletions(-)

--f9iEEYctSRFMQhBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH5cMEACgkQJNaLcl1U
h9Ck2gf9GYw5kRyywJi8CHAE4s6w7WHL0sKrCSwxkn0svqktdSthmB1eYeKBXKma
PaNBJ6aN6PwmUTN7O3qaw03HbPbXX6m7/6B3nYLCm7DV2GcCK/eGhvVeOQfPeAvj
Ydh1Xv7G6BYCPpAy4gYTQb8qZ4okCpe/bAhvqjFE44I04psrXSaByp502BJ32o7G
DfAZa6Tp2OwOmdtveUBFyu7KciNDLre9taSfKd6yaCnWrAJIuwWxdmgFlSXUqAg2
J4x2i0/tCvxCyDBa4XlGpAJ+56QCMIQLakeJruDF7lSA5qOe36MLDwJ8ONRMClNw
5NmIEME3mIGVUtw43zzwdmAoBezAjQ==
=zFNW
-----END PGP SIGNATURE-----

--f9iEEYctSRFMQhBo--
