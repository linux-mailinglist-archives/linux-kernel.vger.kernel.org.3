Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50BF49F5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiA1JEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiA1JEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:04:04 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C503C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:04:04 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by michel.telenet-ops.be with bizsmtp
        id o9402600S04fKGS06940hR; Fri, 28 Jan 2022 10:04:00 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAm-00Bjt9-4B; Fri, 28 Jan 2022 10:04:00 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAl-005pod-GP; Fri, 28 Jan 2022 10:03:59 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 0/2] dt-bindings: interrupt-controller: sifive, plic: Miscellaneous improvements
Date:   Fri, 28 Jan 2022 10:03:56 +0100
Message-Id: <cover.1643360419.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two improvements for the SiFive PLIC DT
bindings.

Changes compared to v3[1]:
  - Use architectural maximum instead of practical maximum of 9,

Changes compared to v2[2]:
  - Add Acked-by, Reviewed-by.

Changes compared to v1[3]:
  - Split in two patches,
  - Improve patch description and document limit rationale.

Thanks!

[1] https://lore.kernel.org/r/cover.1639744106.git.geert@linux-m68k.org/
[2] https://lore.kernel.org/r/cover.1639661878.git.geert@linux-m68k.org
[3] https://lore.kernel.org/r/20211125152233.162868-1-geert@linux-m68k.org

Geert Uytterhoeven (2):
  dt-bindings: interrupt-controller: sifive,plic: Fix number of
    interrupts
  dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples

 .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
