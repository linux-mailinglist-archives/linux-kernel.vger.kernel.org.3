Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6B534833
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiEZBdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiEZBdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:33:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21060DE93
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1F1AB81EAA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB2C34117;
        Thu, 26 May 2022 01:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653528786;
        bh=pQbwgINLxI21GXXyGtGVeUNfYP2Q2AzNFVmF3Cd0PNM=;
        h=Date:From:To:Cc:Subject:From;
        b=pR/NjBZ4wpBqm8YpbrG2oteKBFh9ISJ1Lsqy9sVDxIkoWWhbmk+tjrl0OYyLRwwBc
         KPQjrE2ffov3+OnxnTcZC/e6o/Dj2bT0IlUgkeJJa3SLDXc/SaUAKarDYB1FhNHheo
         EEnxfmK4ata+XjIFrezl5mgM3PPaPkPGwtUA9YCP6a8xsXbRvqsrEozx2lY1s/U9lR
         CsqPYAgwUj3eq1X0kgxy7dU+hnpre9LlGq2PJ1tKGZ9afqdR1cI+6LxswVqQDQToMe
         Hxl8tBBduHomnnGRIubC+8bEx5NDb2QW4mwqxxk9DStk8cqqxm3oq+NCcTX4KdZAlB
         LITR1wXkHHB4A==
Date:   Thu, 26 May 2022 09:33:02 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        tzungbi@kernel.org, chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v5.19
Message-ID: <Yo7YztZklByTINZp@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mIqwI4HpAZfVtEbQ"
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mIqwI4HpAZfVtEbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull chrome-platform updates for v5.19.

Thanks,
TzungBi


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ tags/tag-chrome-platform-for-v5.19

for you to fetch changes up to abd4fd43f2af03e2e852e6b1b98faeee9e3eae55:

  platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI descriptions (2022-05-24 08:46:21 +0800)

----------------------------------------------------------------
chrome platform changes for 5.19

cros_ec:
* Fix wrong error handling path.
* Clean-up patches.

cros_ec_chardev:
* Re-introduce cros_ec_cmd_xfer to fix ABI broken.

cros_ec_lpcs:
* Support the Framework Laptop.

cros_ec_typec:
* Fix NULL dereference.

chromeos_acpi:
* Add ChromeOS ACPI device driver.
* Fix Sphinx errors when `make htmldocs`.

misc:
* Drop BUG_ON()s.

----------------------------------------------------------------
Akihiko Odaki (1):
      platform/chrome: cros_ec_typec: Check for EC driver

Bagas Sanjaya (2):
      platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs ABI
      platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI descriptions

Dustin L. Howett (2):
      platform/chrome: cros_ec_lpcs: detect the Framework Laptop
      platform/chrome: cros_ec_lpcs: reserve the MEC LPC I/O ports first

Enric Balletbo i Serra (1):
      platform/chrome: Add ChromeOS ACPI device driver

Guenter Roeck (1):
      platform/chrome: Re-introduce cros_ec_cmd_xfer and use it for ioctls

Tzung-Bi Shih (12):
      platform/chrome: cros_ec: fix error handling in cros_ec_register()
      platform/chrome: cros_ec: remove unused variable `was_wake_device`
      platform/chrome: cros_ec: determine `wake_enabled` in cros_ec_suspend()
      platform/chrome: cros_ec: sort header inclusion alphabetically
      platform/chrome: cros_ec: append newline to all logs
      platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in prepare_packet()
      platform/chrome: correct cros_ec_prepare_tx() usage
      platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
      platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_get_host_event()
      platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
      platform/chrome: cros_ec_spi: drop unneeded BUG_ON()
      platform/chrome: cros_ec_spi: drop BUG_ON() if `din` isn't large enough

 .../ABI/testing/sysfs-driver-chromeos-acpi         | 137 ++++++++
 .../firmware-guide/acpi/chromeos-acpi-device.rst   | 363 +++++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst        |   1 +
 drivers/platform/chrome/Kconfig                    |  11 +
 drivers/platform/chrome/Makefile                   |   1 +
 drivers/platform/chrome/chromeos_acpi.c            | 257 +++++++++++++++
 drivers/platform/chrome/cros_ec.c                  |  36 +-
 drivers/platform/chrome/cros_ec_chardev.c          |   2 +-
 drivers/platform/chrome/cros_ec_i2c.c              |  12 +-
 drivers/platform/chrome/cros_ec_ishtp.c            |   4 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  49 ++-
 drivers/platform/chrome/cros_ec_proto.c            |  63 +++-
 drivers/platform/chrome/cros_ec_rpmsg.c            |   2 +
 drivers/platform/chrome/cros_ec_spi.c              |  15 +-
 drivers/platform/chrome/cros_ec_typec.c            |   3 +
 include/linux/platform_data/cros_ec_commands.h     |  10 +-
 include/linux/platform_data/cros_ec_proto.h        |   6 +-
 17 files changed, 914 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-chromeos-acpi
 create mode 100644 Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
 create mode 100644 drivers/platform/chrome/chromeos_acpi.c

--mIqwI4HpAZfVtEbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCYo7YywAKCRArxTEGBto8
9MO5AP0YOKlZzovTiBkkpIvTjEymnWL7BZUUyhsvRZ4nPq2+RwEApP4zGGqHEpWQ
l78mr0S2+GZ/+L9P9U8h/kLv37rahwE=
=iNyh
-----END PGP SIGNATURE-----

--mIqwI4HpAZfVtEbQ--
