Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227DD477366
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhLPNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhLPNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:43:55 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5FDC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:43:54 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d13f:527c:5504:a743])
        by albert.telenet-ops.be with bizsmtp
        id X1js2600K250X30061jsKf; Thu, 16 Dec 2021 14:43:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mxr32-005QIG-0O; Thu, 16 Dec 2021 14:43:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mxr31-009y7P-EO; Thu, 16 Dec 2021 14:43:51 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/2] dt-bindings: timer: sifive,clint: Miscellaneous improvements
Date:   Thu, 16 Dec 2021 14:43:46 +0100
Message-Id: <cover.1639662093.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two improvements for the SiFive PLIC DT
bindings.

Changes compared to v1[1]:
  - Split in two patches,
  - Improve patch description and document limit rationale.

Thanks!

[1] https://lore.kernel.org/r/20211125152317.162958-1-geert@linux-m68k.org

Geert Uytterhoeven (2):
  dt-bindings: timer: sifive,clint: Fix number of interrupts
  dt-bindings: timer: sifive,clint: Group interrupt tuples

 .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
