Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8B515EED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382966AbiD3P5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiD3P5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D4580C4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A0EB80025
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD74C385AA;
        Sat, 30 Apr 2022 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651334032;
        bh=XJqsGM5sH6UrXs5xpQhsK8UuhSfnW8B866To2KKbVzw=;
        h=Date:From:To:Cc:Subject:From;
        b=BVMA2QPjn20u0xY1VKEep2mWsrFdkpo00pNYolqo8E8YnS7CdzpYElx7VziJlSAfx
         ByFgvn0JPZbiUWi0vfn7zu+DunnBnGGDVvSPX6EitHJH2VnDxoBwZExE+BDsp9Fztl
         +GOkGMntTVm3J7SAcKi3b/mos9Wl69l6XlaoT67g=
Date:   Sat, 30 Apr 2022 17:53:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes 5.18-rc5
Message-ID: <Ym1bjfINnY89BvKQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc5

for you to fetch changes up to fda05730f62b9a53e7d415f5c607942afbdc1fd9:

  Merge tag 'iio-fixes-for-5.18a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio (2022-04-28 16:35:55 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.18-rc5

Here are a small number of char/misc/other driver fixes for 5.18-rc5

Nothing major in here, this is mostly IIO driver fixes along with some
other small things:
	- at25 driver fix for systems without a dma-able stack
	- phy driver fixes for reported issues
	- binder driver fixes for reported issues

All of these have been in linux-next without any reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alessandro Astone (2):
      binder: Address corner cases in deferred copy and fixup
      binder: Gracefully handle BINDER_TYPE_FDA objects with num_fds=0

Christophe JAILLET (1):
      phy: ti: tusb1210: Fix an error handling path in tusb1210_probe()

Christophe Leroy (1):
      eeprom: at25: Use DMA safe buffers

Dan Carpenter (2):
      iio: dac: ad3552r: fix signedness bug in ad3552r_reset()
      iio:dac:ad3552r: Fix an IS_ERR() vs NULL check

Fawzi Khaber (1):
      iio: imu: inv_icm42600: Fix I2C init possible nack

Greg Kroah-Hartman (4):
      Merge tag 'mhi-fixes-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-linus
      Merge tag 'phy-fixes-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-linus
      Merge tag 'icc-5.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-fixes-for-5.18a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio

Gwendal Grignou (1):
      iio: sx9324: Fix default precharge internal resistance register

Hans de Goede (1):
      phy: ti: tusb1210: Make tusb1210_chg_det_states static

Heiner Kallweit (1):
      phy: amlogic: fix error path in phy_g12a_usb3_pcie_probe()

Jonathan Cameron (1):
      iio: adc: ad7280a: Fix wrong variable used when setting thresholds.

Jose Cazarin (1):
      iio: dac: dac5571: Fix chip id detection for OF devices

Krzysztof Kozlowski (1):
      phy: samsung: exynos5250-sata: fix missing device put in probe error paths

Lv Ruyi (1):
      phy: ti: Fix missing of_node_put in ti_pipe3_get_sysctrl()

Manivannan Sadhasivam (2):
      bus: mhi: host: pci_generic: Add missing poweroff() PM callback
      bus: mhi: host: pci_generic: Flush recovery worker during freeze

Miaoqian Lin (4):
      phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
      phy: ti: omap-usb2: Fix error handling in omap_usb2_enable_clocks
      phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe
      phy: ti: Add missing pm_runtime_disable() in serdes_am654_probe

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Nuno Sá (1):
      iio: dac: ltc2688: fix voltage scale read

Stephen Boyd (4):
      iio:proximity:sx_common: Fix device property parsing on DT systems
      iio:proximity:sx9324: Fix hardware gain read/write
      interconnect: qcom: sc7180: Drop IP0 interconnects
      interconnect: qcom: sdx55: Drop IP0 interconnects

Tom Rix (1):
      iio: scd4x: check return of scd4x_write_and_fetch

Tong Zhang (1):
      iio:imu:bmi160: disable regulator in error path

Wang ShaoBo (1):
      iio:filter:admv8818: select REGMAP_SPI for ADMV8818

Zheyu Ma (1):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

 drivers/android/binder.c                        | 10 +++++++-
 drivers/bus/mhi/host/pci_generic.c              |  2 ++
 drivers/iio/adc/ad7280a.c                       | 12 +++++-----
 drivers/iio/chemical/scd4x.c                    |  5 +++-
 drivers/iio/dac/ad3552r.c                       |  6 ++---
 drivers/iio/dac/ad5446.c                        |  2 +-
 drivers/iio/dac/ad5592r-base.c                  |  2 +-
 drivers/iio/dac/ltc2688.c                       |  2 +-
 drivers/iio/dac/ti-dac5571.c                    | 28 ++++++++++++++--------
 drivers/iio/filter/Kconfig                      |  1 +
 drivers/iio/imu/bmi160/bmi160_core.c            | 20 +++++++++++-----
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++-----
 drivers/iio/magnetometer/ak8975.c               |  1 +
 drivers/iio/proximity/sx9324.c                  | 32 +++++++++++++++++++------
 drivers/iio/proximity/sx_common.c               |  1 +
 drivers/interconnect/qcom/sc7180.c              | 21 ----------------
 drivers/interconnect/qcom/sdx55.c               | 21 ----------------
 drivers/misc/eeprom/at25.c                      | 19 ++++++++-------
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c  | 20 +++++++++-------
 drivers/phy/motorola/phy-mapphone-mdm6600.c     |  3 ++-
 drivers/phy/samsung/phy-exynos5250-sata.c       | 21 +++++++++++-----
 drivers/phy/ti/phy-am654-serdes.c               |  2 +-
 drivers/phy/ti/phy-omap-usb2.c                  |  2 +-
 drivers/phy/ti/phy-ti-pipe3.c                   |  1 +
 drivers/phy/ti/phy-tusb1210.c                   | 12 +++++++---
 25 files changed, 148 insertions(+), 113 deletions(-)
