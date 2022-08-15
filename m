Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624E593189
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiHOPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiHOPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:16:39 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BB1F252B0;
        Mon, 15 Aug 2022 08:16:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="131484180"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 00:16:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 95AE040108F7;
        Tue, 16 Aug 2022 00:16:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 7/8] MAINTAINERS: Add entry for Renesas RISC-V architecture
Date:   Mon, 15 Aug 2022 16:14:50 +0100
Message-Id: <20220815151451.23293-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Renesas RISC-V architecture support will be for the
RZ/Five SMARC EVK board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* New patch
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3058091899f..b03763ed649b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17562,6 +17562,16 @@ F:	drivers/spi/spi-microchip-core.c
 F:	drivers/usb/musb/mpfs.c
 F:	include/soc/microchip/mpfs.h
 
+RISC-V/Renesas RISC-V ARCHITECTURE
+M:	Geert Uytterhoeven <geert+renesas@glider.be>
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
+C:	irc://irc.libera.chat/renesas-soc
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
+F:	Documentation/devicetree/bindings/soc/renesas/
+F:	arch/riscv/boot/dts/renesas/
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.25.1

