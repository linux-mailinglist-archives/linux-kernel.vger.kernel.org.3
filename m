Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA3478B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhLQMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbhLQMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:38:13 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D271CC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:38:12 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d13f:527c:5504:a743])
        by baptiste.telenet-ops.be with bizsmtp
        id XQe82600Q250X3001Qe8YF; Fri, 17 Dec 2021 13:38:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1myCUy-005Yqi-AC; Fri, 17 Dec 2021 13:38:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1myCUx-00ASTI-U6; Fri, 17 Dec 2021 13:38:07 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 0/2] dt-bindings: timer: sifive,clint: Miscellaneous improvements
Date:   Fri, 17 Dec 2021 13:38:02 +0100
Message-Id: <cover.1639744468.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two improvements for the SiFive CLINT DT
bindings.

Changes compared to v2[1]:
  - Add Acked-by, Reviewed-by.

Changes compared to v1[2]:
  - Split in two patches,
  - Improve patch description and document limit rationale.

Thanks!

[1] https://lore.kernel.org/r/cover.1639662093.git.geert@linux-m68k.org
[2] https://lore.kernel.org/r/20211125152317.162958-1-geert@linux-m68k.org


Geert Uytterhoeven (2):
  dt-bindings: timer: sifive,clint: Fix number of interrupts
  dt-bindings: timer: sifive,clint: Group interrupt tuples

 .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

