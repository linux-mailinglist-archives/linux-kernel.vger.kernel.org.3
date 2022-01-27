Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB649E135
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiA0LgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:36:00 -0500
Received: from mx.socionext.com ([202.248.49.38]:9862 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbiA0Lf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:35:59 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jan 2022 20:35:58 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 280FF205D901;
        Thu, 27 Jan 2022 20:35:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Jan 2022 20:35:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DF1A3C1E22;
        Thu, 27 Jan 2022 20:35:57 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] pinctrl: uniphier: Add some more pinmux settings
Date:   Thu, 27 Jan 2022 20:35:41 +0900
Message-Id: <1643283344-24911-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes changes to audio I/O pinmux settings and addition
to USB device pinmux settings.

- Divide audio I/O pinmux groups so that 1/2/4ch can be specified.
  The audio I/O function is available for LD11, LD20, PXs2 and PXs3 SoCs.
  In addition, add the missing pinmux settings for PXs2.

- Add USB device pinmux settings. The USB device function is available
  for PXs2 and PXs3 SoCs.

Kunihiko Hayashi (3):
  pinctrl: uniphier: Add missing audio pinmux settings for PXs2 SoC
  pinctrl: uniphier: Divide pinmux group to support 1ch and 2ch I2S
  pinctrl: uniphier: Add USB device pinmux settings

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 26 +++++++---
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 64 ++++++++++++++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 63 +++++++++++++++++++----
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 62 +++++++++++++++++------
 4 files changed, 172 insertions(+), 43 deletions(-)

-- 
2.7.4

