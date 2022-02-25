Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02254C462A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiBYNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiBYNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B221BD077
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B682D61D46
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5618C340F1;
        Fri, 25 Feb 2022 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645795441;
        bh=Hap6qxLFfuq30qMLZhl0DVfnUHjOMHpNhsB6nESQJLs=;
        h=Date:From:To:Cc:Subject:From;
        b=hmAfB+dEOLG36c4UPibLkzEigBx5xDzso62nR+qd7/OxeAz6WPJD5ma7rQTUdQr7v
         i4aoxkm2RHsM0t5hhrIkh6KMhoBj6XhsSH6i4Q75KSb7dUYg0rfamvN/o6Bbo/YTeJ
         5X7ZppV9vQoh8up7kMazTAGOBJ7euN+0u8VbvDGE=
Date:   Fri, 25 Feb 2022 14:23:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.17-rc6
Message-ID: <YhjYbrtdhbp4HE+B@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc6

for you to fetch changes up to 6c7621890995d089a56a06d11580d185ede7c2f8:

  mtd: core: Fix a conflict between MTD and NVMEM on wp-gpios property (2022-02-21 17:59:25 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.17-rc6

Here are a few small driver fixes for 5.17-rc6 for reported issues.  The
majority of these are IIO fixes for small things, and the other two are
a mvmem and mtd core conflict fix.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path

Christophe Kerello (2):
      nvmem: core: Fix a conflict between MTD and NVMEM on wp-gpios property
      mtd: core: Fix a conflict between MTD and NVMEM on wp-gpios property

Cosmin Tanislav (3):
      iio: adc: ad7124: fix mask used for setting AIN_BUFP & AIN_BUFM bits
      iio: addac: ad74413r: use ngpio size when iterating over mask
      iio: addac: ad74413r: correct comparator gpio getters mask usage

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Kees Cook (1):
      iio: addac: ad74413r: Do not reference negative array offsets

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_oneshot

Miaoqian Lin (1):
      iio: Fix error handling for PM

Muhammad Usama Anjum (1):
      iio: frequency: admv1013: remove the always true condition

Nuno Sá (1):
      iio:imu:adis16480: fix buffering for devices with no burst mode

Oleksij Rempel (1):
      iio: adc: tsc2046: fix memory corruption by preventing array overflow

Sean Nyekjaer (1):
      iio: accel: fxls8962af: add padding to regmap for SPI

 drivers/iio/accel/bmc150-accel-core.c        |  5 ++++-
 drivers/iio/accel/fxls8962af-core.c          | 12 ++++++++++--
 drivers/iio/accel/fxls8962af-i2c.c           |  2 +-
 drivers/iio/accel/fxls8962af-spi.c           |  2 +-
 drivers/iio/accel/fxls8962af.h               |  3 ++-
 drivers/iio/accel/kxcjk-1013.c               |  5 ++++-
 drivers/iio/accel/mma9551.c                  |  5 ++++-
 drivers/iio/accel/mma9553.c                  |  5 ++++-
 drivers/iio/adc/ad7124.c                     |  2 +-
 drivers/iio/adc/men_z188_adc.c               |  9 ++++++++-
 drivers/iio/adc/ti-tsc2046.c                 |  4 ++--
 drivers/iio/addac/ad74413r.c                 | 17 ++++++++---------
 drivers/iio/frequency/admv1013.c             |  2 +-
 drivers/iio/gyro/bmg160_core.c               |  5 ++++-
 drivers/iio/imu/adis16480.c                  |  7 ++++++-
 drivers/iio/imu/kmx61.c                      |  5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  6 +++++-
 drivers/iio/magnetometer/bmc150_magn.c       |  5 +++--
 drivers/mtd/mtdcore.c                        |  2 ++
 drivers/nvmem/core.c                         |  2 +-
 include/linux/nvmem-provider.h               |  4 +++-
 21 files changed, 78 insertions(+), 31 deletions(-)
