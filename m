Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32F946787E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352489AbhLCNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381182AbhLCNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:37 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C432C06179E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:35:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by albert.telenet-ops.be with bizsmtp
        id RpbA2600G3eLghq06pbAi1; Fri, 03 Dec 2021 14:35:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-002LQW-RS; Fri, 03 Dec 2021 14:35:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8iT-000kka-5i; Fri, 03 Dec 2021 14:35:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Input: gpio-keys - Interrupt-related fixes
Date:   Fri,  3 Dec 2021 14:35:05 +0100
Message-Id: <cover.1638538079.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two interrupt-related fixes for the gpio-keys
DT bindings and driver, and a small clean-up.
The first two patches can be applied independently.
The third patch, which is marked RFC, depends on the second.

Thanks for your comments!

Geert Uytterhoeven (3):
  dt-bindings: input: gpio-keys: Fix interrupts in example
  Input: gpio-keys - Use input_report_key()
  [WIP] [RFC] Input: gpio-keys - Fix ghost events with both-edge irqs

 .../devicetree/bindings/input/gpio-keys.yaml  |  2 +-
 drivers/input/keyboard/gpio_keys.c            | 38 ++++++++++++-------
 2 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
