Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9E4EE271
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbiCaUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCaUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:15:02 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 13:13:12 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600212405AA;
        Thu, 31 Mar 2022 13:13:11 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 282DF409FE; Thu, 31 Mar 2022 20:24:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 282DF409FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1648751095;
        bh=HM+JIIo+Sjc4s1ZH/IHvcCj9K9AslqEBJ3ZPMW/zlfE=;
        h=Date:From:To:Cc:Subject:From;
        b=n7iHObiS2fj8B9VqzYo7AmbCF7rBZo4d9TA2ozwxGJk4JO1uvGxDsp/AO44Hbti2f
         2KMPqP/3EsossX3zRUPzziZBzfG5D6zOcVib6OC4H63H0nQL2ZbMzyl5b7rjjvsFn4
         3RfJAtgGcnObEezltkKTa+Sl3nnNu/h9y1/NvHRQ=
Date:   Thu, 31 Mar 2022 20:24:55 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Eduardo Valentin <eduval@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Terry Bowman <terry.bowman@amd.com>,
        Thanh Quan <thanh.quan.xn@renesas.com>
Subject: [GIT PULL REQUEST] watchdog - v5.18 Merge window
Message-ID: <20220331182454.GA14072@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v5.18 release cycle.

This series contains:
* Add support for BCM4908
* renesas_wdt: Add R-Car Gen4 support
* Improve watchdog_dev function documentation
* sp5100_tco: replace the cd6h/cd7h port I/O with MMIO accesses during initialization
* several other small improvements and fixes

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.18-rc1

for you to fetch changes up to 826270373f17fd8ebd10753ca0a5fd2ceb1dc38e:

  Watchdog: sp5100_tco: Enable Family 17h+ CPUs (2022-03-27 17:04:33 +0200)

----------------------------------------------------------------
linux-watchdog 5.18-rc1 tag

----------------------------------------------------------------
Alistair Francis (1):
      watchdog: imx2_wdg: Alow ping on suspend

Chris Packham (1):
      watchdog: orion_wdt: support pretimeout on Armada-XP

Daniel Bristot de Oliveira (1):
      watchdog: Improve watchdog_dev function documentation

Eduardo Valentin (1):
      watchdog: aspeed: add nowayout support

Linus Walleij (1):
      watchdog: ixp4xx: Implement restart

Miaoqian Lin (1):
      watchdog: rti-wdt: Add missing pm_runtime_disable() in probe function

Rafał Miłecki (1):
      watchdog: allow building BCM7038_WDT for BCM4908

Terry Bowman (4):
      Watchdog: sp5100_tco: Move timer initialization into function
      Watchdog: sp5100_tco: Refactor MMIO base address initialization
      Watchdog: sp5100_tco: Add initialization using EFCH MMIO
      Watchdog: sp5100_tco: Enable Family 17h+ CPUs

Thanh Quan (2):
      dt-bindings: watchdog: renesas-wdt: Document r8a779f0 support
      watchdog: renesas_wdt: Add R-Car Gen4 support

 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |   5 +
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/aspeed_wdt.c                      |   7 +
 drivers/watchdog/imx2_wdt.c                        |  27 +-
 drivers/watchdog/ixp4xx_wdt.c                      |  14 +
 drivers/watchdog/orion_wdt.c                       |  13 +-
 drivers/watchdog/renesas_wdt.c                     |   1 +
 drivers/watchdog/rti_wdt.c                         |   1 +
 drivers/watchdog/sp5100_tco.c                      | 334 ++++++++++++++-------
 drivers/watchdog/sp5100_tco.h                      |   7 +
 drivers/watchdog/watchdog_dev.c                    | 244 +++++++--------
 11 files changed, 409 insertions(+), 246 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

