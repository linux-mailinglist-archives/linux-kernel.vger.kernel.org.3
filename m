Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F775AB564
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiIBPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiIBPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9442AE38
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836B761F70
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA4AC433C1;
        Fri,  2 Sep 2022 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662132321;
        bh=c2WhCMaCzXv8dJqz92IA6FMuatOhffa5TwWAUmWx1/k=;
        h=Date:From:To:Cc:Subject:From;
        b=Nnf7pBqaQOoonBixGumgKVOPY8H+FK+BBdvW4nkp0Pk7QsR4kNycHly2ffUhY0FT4
         JQuKbnPpKsYrxgCI3tlHmgvq81fJlIW1kU6HsaPIKVeQ7skk5vMfIOOF+uLZ0e60ba
         5FoIVwXyLltlqc3nHASbm8jbkME+p5mW0+jYIeRA=
Date:   Fri, 2 Sep 2022 17:25:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.0-rc4
Message-ID: <YxIgXZNrSK+us7Vi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc4

for you to fetch changes up to 0f022aaac9ff2ceff683231b43923c650c90b47e:

  Merge tag 'soundwire-6.0-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-linus (2022-09-02 08:59:45 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.0-rc4

Here are some small char/misc and other driver fixes for 6.0-rc4.

Included in here are:
  - binder fixes for previous fixes, and a few more fixes uncovered by
    them.
  - iio driver fixes
  - soundwire driver fixes
  - fastrpc driver fixes for memory corruption on some hardware
  - peci driver fix
  - mhi driver fix

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Carlos Llamas (2):
      binder: fix UAF of ref->proc caused by race condition
      binder: fix alloc->vma_vm_mm null-ptr dereference

Christophe JAILLET (1):
      iio: light: cm3605: Fix an error handling path in cm3605_probe()

Greg Kroah-Hartman (5):
      Revert "binder_alloc: Add missing mmap_lock calls when using the VMA"
      Merge tag 'iio-fixes-for-6.0a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'peci-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-linus
      Merge tag 'mhi-fixes-for-v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-linus
      Merge tag 'soundwire-6.0-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-linus

Iwona Winiarska (1):
      peci: cpu: Fix use-after-free in adev_release()

Johan Hovold (3):
      misc: fastrpc: fix memory corruption on probe
      misc: fastrpc: fix memory corruption on open
      misc: fastrpc: increase maximum session count

Krzysztof Kozlowski (1):
      dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins

Liam Howlett (1):
      binder_alloc: Add missing mmap_lock calls when using the VMA

Lv Ruyi (1):
      peci: aspeed: fix error check return value of platform_get_irq()

Marcus Folkesson (3):
      iio: adc: mcp3911: make use of the sign bit
      iio: adc: mcp3911: correct "microchip,device-addr" property
      iio: adc: mcp3911: use correct formula for AD conversion

Matti Vaittinen (1):
      iio: ad7292: Prevent regulator double disable

Qiang Yu (1):
      bus: mhi: host: Fix up null pointer access in mhi_irq_handler

Srinivas Kandagatla (2):
      soundwire: qcom: remove duplicate reset control get
      soundwire: qcom: fix device status array range

sunliming (1):
      iio: light: cm32181: make cm32181_pm_ops static

 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |  2 ++
 drivers/android/binder.c                           | 12 ++++++++++
 drivers/android/binder_alloc.c                     |  4 ++--
 drivers/bus/mhi/host/main.c                        | 19 ++++++++++++---
 drivers/iio/adc/ad7292.c                           |  4 +---
 drivers/iio/adc/mcp3911.c                          | 28 +++++++++++++++++-----
 drivers/iio/light/cm32181.c                        |  2 +-
 drivers/iio/light/cm3605.c                         |  6 +++--
 drivers/misc/fastrpc.c                             | 14 +++++++----
 drivers/peci/controller/peci-aspeed.c              |  2 +-
 drivers/peci/cpu.c                                 |  3 +--
 drivers/soundwire/qcom.c                           | 10 +++-----
 12 files changed, 74 insertions(+), 32 deletions(-)
