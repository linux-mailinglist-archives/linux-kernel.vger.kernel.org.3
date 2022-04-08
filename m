Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65EC4F92B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiDHKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDHKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:19:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37FBF50074;
        Fri,  8 Apr 2022 03:17:25 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CB5CD807E;
        Fri,  8 Apr 2022 10:14:58 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCHv2 0/3] TI timer changes for am6
Date:   Fri,  8 Apr 2022 13:17:12 +0300
Message-Id: <20220408101715.43697-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's v2 version of the timer changes for TI am6.

Regards,

Tony

Changes since v1:

- Change the new compatible to ti,am654-timer for the first compatible SoC
  as suggested by Nishanth

- Separate out the binding to convert it to yaml first as suggested by
  Nishanth

- Drop the header ifdefs by moving inline functions to the driver based
  on suggestion by Daniel

Tony Lindgren (3):
  clocksource/drivers/timer-ti-dm: Move inline functions to driver for
    am6
  clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
  clocksource/drivers/timer-ti-dm: Add compatible for am6 SoCs

 arch/arm/mach-omap2/Kconfig       |   2 +
 drivers/clocksource/Kconfig       |   8 +-
 drivers/clocksource/Makefile      |   2 +-
 drivers/clocksource/timer-ti-dm.c | 123 +++++++++++++++++++++++++
 include/clocksource/timer-ti-dm.h | 144 ------------------------------
 5 files changed, 133 insertions(+), 146 deletions(-)

-- 
2.35.1
