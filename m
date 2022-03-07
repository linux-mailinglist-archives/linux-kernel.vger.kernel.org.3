Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E64CFF88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbiCGNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbiCGNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:05:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07A8BE0A;
        Mon,  7 Mar 2022 05:04:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BFCAB8123D;
        Mon,  7 Mar 2022 13:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C7C340F3;
        Mon,  7 Mar 2022 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646658271;
        bh=KIhhcjMsShQiJTEPuxC4ZF1RG+Pce5774ukCbCnEdrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T43pC3kx2X7ZcmJkE9z82Z/4a5zZDVlAZnsuinl1c+b5WyUZ7xVHo2KYpv75nQXjc
         Lf5hrs0glC3ZTdmhTrxszPgA2lExJFORXGcqnGzyBepGb7xZ0zDrl6APMOOSRCJZmP
         gel6z8bjSNCEzcsDSQhaOc27sWGjDi9sksLX5PCweJw8e2BpHC9yQuzWvYNI/Tx1/0
         IsB2Pvd1pFaeofXTJw3mtdJyK879cOd0hAhwVbGlIZqizgc/AD353HKlq3l7jgUxqX
         Nt0oTXItWJ2zBH0NwF1n03hgGlQe4EjMfhpfEQPAPIWTWSrO2tMbyN3LJ/HQ2hm6Ko
         etcoOD2XQz+Fg==
Date:   Mon, 7 Mar 2022 13:04:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <YiYC2fQgf7d/QPSM@sirena.org.uk>
References: <20220307111342.105ce204@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sRa/4c5aU5v/6Tf/"
Content-Disposition: inline
In-Reply-To: <20220307111342.105ce204@canb.auug.org.au>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sRa/4c5aU5v/6Tf/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 11:13:42AM +1100, Stephen Rothwell wrote:

> Caused by commit
>=20
>   0e65e2e6abb0 ("drm/tiny: Add MIPI DBI compatible SPI driver")
>=20
> interacting with commit
>=20
>   a0386bba7093 ("spi: make remove callback a void function")
>=20
> from the spi trees.

The amdgpu tree can pull this tag and apply Stephen's fix as part of
that:

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
remove-void

for you to fetch changes up to a0386bba70934d42f586eaf68b21d5eeaffa7bd0:

  spi: make remove callback a void function (2022-02-09 13:00:45 +0000)

----------------------------------------------------------------
spi: Make remove() return void

This series from Uwe Kleine-K=F6nig converts the spi remove function to
return void since there is nothing useful that we can do with a failure
and it as more buses are converted it'll enable further work on the
driver core.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (5):
      staging: fbtft: Fix error path in fbtft_driver_module_init()
      staging: fbtft: Deduplicate driver registration macros
      tpm: st33zp24: Make st33zp24_remove() a void function
      platform/chrome: cros_ec: Make cros_ec_unregister() return void
      spi: make remove callback a void function

 drivers/bus/moxtet.c                               |  4 +-
 drivers/char/tpm/st33zp24/i2c.c                    |  5 +-
 drivers/char/tpm/st33zp24/spi.c                    |  9 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |  3 +-
 drivers/char/tpm/st33zp24/st33zp24.h               |  2 +-
 drivers/char/tpm/tpm_tis_spi_main.c                |  3 +-
 drivers/clk/clk-lmk04832.c                         |  4 +-
 drivers/gpio/gpio-74x164.c                         |  4 +-
 drivers/gpio/gpio-max3191x.c                       |  4 +-
 drivers/gpio/gpio-max7301.c                        |  4 +-
 drivers/gpio/gpio-mc33880.c                        |  4 +-
 drivers/gpio/gpio-pisosr.c                         |  4 +-
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c       |  4 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |  4 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       |  3 +-
 drivers/gpu/drm/panel/panel-innolux-ej030na.c      |  4 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |  4 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |  4 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |  4 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |  4 +-
 drivers/gpu/drm/panel/panel-samsung-db7430.c       |  3 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |  4 +-
 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c      |  3 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c  |  3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |  4 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |  4 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |  4 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |  4 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |  3 +-
 drivers/gpu/drm/panel/panel-widechips-ws2401.c     |  3 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |  4 +-
 drivers/gpu/drm/tiny/ili9163.c                     |  4 +-
 drivers/gpu/drm/tiny/ili9225.c                     |  4 +-
 drivers/gpu/drm/tiny/ili9341.c                     |  4 +-
 drivers/gpu/drm/tiny/ili9486.c                     |  4 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |  4 +-
 drivers/gpu/drm/tiny/repaper.c                     |  4 +-
 drivers/gpu/drm/tiny/st7586.c                      |  4 +-
 drivers/gpu/drm/tiny/st7735r.c                     |  4 +-
 drivers/hwmon/adcxx.c                              |  4 +-
 drivers/hwmon/adt7310.c                            |  3 +-
 drivers/hwmon/max1111.c                            |  3 +-
 drivers/hwmon/max31722.c                           |  4 +-
 drivers/iio/accel/bma400_spi.c                     |  4 +-
 drivers/iio/accel/bmc150-accel-spi.c               |  4 +-
 drivers/iio/accel/bmi088-accel-spi.c               |  4 +-
 drivers/iio/accel/kxsd9-spi.c                      |  4 +-
 drivers/iio/accel/mma7455_spi.c                    |  4 +-
 drivers/iio/accel/sca3000.c                        |  4 +-
 drivers/iio/adc/ad7266.c                           |  4 +-
 drivers/iio/adc/ltc2496.c                          |  4 +-
 drivers/iio/adc/mcp320x.c                          |  4 +-
 drivers/iio/adc/mcp3911.c                          |  4 +-
 drivers/iio/adc/ti-adc12138.c                      |  4 +-
 drivers/iio/adc/ti-ads7950.c                       |  4 +-
 drivers/iio/adc/ti-ads8688.c                       |  4 +-
 drivers/iio/adc/ti-tlc4541.c                       |  4 +-
 drivers/iio/amplifiers/ad8366.c                    |  4 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  4 +-
 drivers/iio/dac/ad5360.c                           |  4 +-
 drivers/iio/dac/ad5380.c                           |  4 +-
 drivers/iio/dac/ad5446.c                           |  4 +-
 drivers/iio/dac/ad5449.c                           |  4 +-
 drivers/iio/dac/ad5504.c                           |  4 +-
 drivers/iio/dac/ad5592r.c                          |  4 +-
 drivers/iio/dac/ad5624r_spi.c                      |  4 +-
 drivers/iio/dac/ad5686-spi.c                       |  4 +-
 drivers/iio/dac/ad5761.c                           |  4 +-
 drivers/iio/dac/ad5764.c                           |  4 +-
 drivers/iio/dac/ad5791.c                           |  4 +-
 drivers/iio/dac/ad8801.c                           |  4 +-
 drivers/iio/dac/ltc1660.c                          |  4 +-
 drivers/iio/dac/ltc2632.c                          |  4 +-
 drivers/iio/dac/mcp4922.c                          |  4 +-
 drivers/iio/dac/ti-dac082s085.c                    |  4 +-
 drivers/iio/dac/ti-dac7311.c                       |  3 +-
 drivers/iio/frequency/adf4350.c                    |  4 +-
 drivers/iio/gyro/bmg160_spi.c                      |  4 +-
 drivers/iio/gyro/fxas21002c_spi.c                  |  4 +-
 drivers/iio/health/afe4403.c                       |  4 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c         |  4 +-
 drivers/iio/magnetometer/hmc5843_spi.c             |  4 +-
 drivers/iio/potentiometer/max5487.c                |  4 +-
 drivers/iio/pressure/ms5611_spi.c                  |  4 +-
 drivers/iio/pressure/zpa2326_spi.c                 |  4 +-
 drivers/input/keyboard/applespi.c                  |  4 +-
 drivers/input/misc/adxl34x-spi.c                   |  4 +-
 drivers/input/touchscreen/ads7846.c                |  4 +-
 drivers/input/touchscreen/cyttsp4_spi.c            |  4 +-
 drivers/input/touchscreen/tsc2005.c                |  4 +-
 drivers/leds/leds-cr0014114.c                      |  4 +-
 drivers/leds/leds-dac124s085.c                     |  4 +-
 drivers/leds/leds-el15203000.c                     |  4 +-
 drivers/leds/leds-spi-byte.c                       |  4 +-
 drivers/media/spi/cxd2880-spi.c                    |  4 +-
 drivers/media/spi/gs1662.c                         |  4 +-
 drivers/media/tuners/msi001.c                      |  3 +-
 drivers/mfd/arizona-spi.c                          |  4 +-
 drivers/mfd/da9052-spi.c                           |  3 +-
 drivers/mfd/ezx-pcap.c                             |  4 +-
 drivers/mfd/madera-spi.c                           |  4 +-
 drivers/mfd/mc13xxx-spi.c                          |  3 +-
 drivers/mfd/rsmu_spi.c                             |  4 +-
 drivers/mfd/stmpe-spi.c                            |  4 +-
 drivers/mfd/tps65912-spi.c                         |  4 +-
 drivers/misc/ad525x_dpot-spi.c                     |  3 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |  4 +-
 drivers/misc/lattice-ecp3-config.c                 |  4 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c             |  4 +-
 drivers/mmc/host/mmc_spi.c                         |  3 +-
 drivers/mtd/devices/mchp23k256.c                   |  4 +-
 drivers/mtd/devices/mchp48l640.c                   |  4 +-
 drivers/mtd/devices/mtd_dataflash.c                |  4 +-
 drivers/mtd/devices/sst25l.c                       |  4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |  4 +-
 drivers/net/can/spi/hi311x.c                       |  4 +-
 drivers/net/can/spi/mcp251x.c                      |  4 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  4 +-
 drivers/net/dsa/b53/b53_spi.c                      |  4 +-
 drivers/net/dsa/microchip/ksz8795_spi.c            |  4 +-
 drivers/net/dsa/microchip/ksz9477_spi.c            |  4 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |  6 +-
 drivers/net/dsa/vitesse-vsc73xx-spi.c              |  6 +-
 drivers/net/ethernet/asix/ax88796c_main.c          |  4 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |  4 +-
 drivers/net/ethernet/microchip/enc28j60.c          |  4 +-
 drivers/net/ethernet/microchip/encx24j600.c        |  4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  4 +-
 drivers/net/ethernet/vertexcom/mse102x.c           |  4 +-
 drivers/net/ethernet/wiznet/w5100-spi.c            |  4 +-
 drivers/net/ieee802154/adf7242.c                   |  4 +-
 drivers/net/ieee802154/at86rf230.c                 |  4 +-
 drivers/net/ieee802154/ca8210.c                    |  6 +-
 drivers/net/ieee802154/cc2520.c                    |  4 +-
 drivers/net/ieee802154/mcr20a.c                    |  4 +-
 drivers/net/ieee802154/mrf24j40.c                  |  4 +-
 drivers/net/phy/spi_ks8995.c                       |  4 +-
 drivers/net/wan/slic_ds26522.c                     |  3 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |  4 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |  4 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |  4 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |  4 +-
 drivers/net/wireless/ti/wl1251/spi.c               |  4 +-
 drivers/net/wireless/ti/wlcore/spi.c               |  4 +-
 drivers/nfc/nfcmrvl/spi.c                          |  3 +-
 drivers/nfc/st-nci/spi.c                           |  4 +-
 drivers/nfc/st95hf/core.c                          |  4 +-
 drivers/nfc/trf7970a.c                             |  4 +-
 drivers/platform/chrome/cros_ec.c                  |  4 +-
 drivers/platform/chrome/cros_ec.h                  |  2 +-
 drivers/platform/chrome/cros_ec_i2c.c              |  4 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  4 +-
 drivers/platform/chrome/cros_ec_spi.c              |  4 +-
 drivers/platform/olpc/olpc-xo175-ec.c              |  4 +-
 drivers/rtc/rtc-ds1302.c                           |  3 +-
 drivers/rtc/rtc-ds1305.c                           |  4 +-
 drivers/rtc/rtc-ds1343.c                           |  4 +-
 drivers/spi/spi-mem.c                              |  6 +-
 drivers/spi/spi-slave-system-control.c             |  3 +-
 drivers/spi/spi-slave-time.c                       |  3 +-
 drivers/spi/spi-tle62x0.c                          |  3 +-
 drivers/spi/spi.c                                  | 11 +--
 drivers/spi/spidev.c                               |  4 +-
 drivers/staging/fbtft/fbtft.h                      | 97 +++++++++---------=
----
 drivers/staging/pi433/pi433_if.c                   |  4 +-
 drivers/staging/wfx/bus_spi.c                      |  3 +-
 drivers/tty/serial/max3100.c                       |  5 +-
 drivers/tty/serial/max310x.c                       |  3 +-
 drivers/tty/serial/sc16is7xx.c                     |  4 +-
 drivers/usb/gadget/udc/max3420_udc.c               |  4 +-
 drivers/usb/host/max3421-hcd.c                     |  3 +-
 drivers/video/backlight/ams369fg06.c               |  3 +-
 drivers/video/backlight/corgi_lcd.c                |  3 +-
 drivers/video/backlight/ili922x.c                  |  3 +-
 drivers/video/backlight/l4f00242t03.c              |  3 +-
 drivers/video/backlight/lms501kf03.c               |  3 +-
 drivers/video/backlight/ltv350qv.c                 |  3 +-
 drivers/video/backlight/tdo24m.c                   |  3 +-
 drivers/video/backlight/tosa_lcd.c                 |  4 +-
 drivers/video/backlight/vgg2432a4.c                |  4 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |  4 +-
 .../omapfb/displays/panel-lgphilips-lb035q02.c     |  4 +-
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  4 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |  4 +-
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  4 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  4 +-
 include/linux/spi/spi.h                            |  2 +-
 sound/pci/hda/cs35l41_hda_spi.c                    |  4 +-
 sound/soc/codecs/adau1761-spi.c                    |  3 +-
 sound/soc/codecs/adau1781-spi.c                    |  3 +-
 sound/soc/codecs/cs35l41-spi.c                     |  4 +-
 sound/soc/codecs/pcm3168a-spi.c                    |  4 +-
 sound/soc/codecs/pcm512x-spi.c                     |  3 +-
 sound/soc/codecs/tlv320aic32x4-spi.c               |  4 +-
 sound/soc/codecs/tlv320aic3x-spi.c                 |  4 +-
 sound/soc/codecs/wm0010.c                          |  4 +-
 sound/soc/codecs/wm8804-spi.c                      |  3 +-
 sound/spi/at73c213.c                               |  4 +-
 198 files changed, 248 insertions(+), 617 deletions(-)

--sRa/4c5aU5v/6Tf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImAtgACgkQJNaLcl1U
h9AUZgf/TYc1umKtM5xcdoy61vLJ0FOw4HTpIXEDGy8erbhIn5z09cA1cBYMBx9D
yByAxw3bvBDGWtaXWHHUN6nRMrwAkQV0eXMbWJZrSZKBXQmTU1LcwEfNEQ/4zU6W
xWODTrnekSFYEPcqZ3p5C/4H5RR0FR2aT29odRHgD1BbRjtDQ13bc0k+BG5+mnQg
Eyem2X84jMmce8nbbPwQJYCzV7oIHGPuMn7je7o3kitrGns4zMhmhuk+4njYRV52
K86eWDnOQZ/8Rr/g4eOJWJvkCBgzPHq1xJHl+HRuUzVLZafODER4G/NhjTnKsnhO
R2p9W70zRzysvxuqq2Rq0UMbPfHYUw==
=uodL
-----END PGP SIGNATURE-----

--sRa/4c5aU5v/6Tf/--
