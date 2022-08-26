Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF05A275C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbiHZMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiHZMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:04:20 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6FD75A3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661515459; x=1693051459;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0dFBX/x5uYj+dXuEVxNGXZ/1Lp9RfNucOLce+FQImnA=;
  b=Qmpo6gOdqgogVpxOthc30U7L1hpvr5r4yKaLqeKnisnjnk5Nu14f4dWp
   kiF0ztK6Gf3Ubtr5x0NU7tEEgzwsK4BGYGfIpCCPKc68zAKriDd7Fu0oU
   A2zCgk1YJ3H9j9lAZGVYUGa6Q4TuGxuXi+F/LzdqupZ7/rzVJgqzfMUSH
   ITrF1Eq6oy6hh0pTAvlmRCqBuQ02gFsARFek/Ft7Y7bqmYd2BejD4lR2Q
   qFuDtqnjfR/ZO8D+4KmhsfY3r1IikEogQy5a7ubDU2qQxJYjEUjyRbTQt
   72uus2i7XaArTzUkEcLb8t7gWA+ZW7ZBTzNgRaWNfm6Yp462hQ+gU36/t
   w==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654552800"; 
   d="scan'208";a="25828112"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2022 14:04:17 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 26 Aug 2022 14:04:17 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 26 Aug 2022 14:04:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661515457; x=1693051457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0dFBX/x5uYj+dXuEVxNGXZ/1Lp9RfNucOLce+FQImnA=;
  b=I4Q1gpM+HjIafKSuJr35iOBudtqCUjcfh9FnVv+Q+YcdqaLOYH1HNtr/
   awQ/VVbYFY47ILgvObHFXiRiZeEyv4xVBh3MhxZ2qr529YsX3Tpvh3XFI
   +pubctGtggsEgBotgQqnWlbeYivbnkSaMr+H1LKxCNnGSPd4zZsLeMwCJ
   vfWJtXUTSwByqcaXudhhwNY07FmJebQJDL9GnNxanVRX+wXQ1kiYMlDl7
   fFoqFqMwBgWPmFvZYrsermB6WM/HCpCFiDlT71S09999WgWjfLOCNCtUC
   wM73NDuNacswGJ3l1OK96tgiDaqucQ/2Mo+3kTQpW2792cfYCj6B4009v
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654552800"; 
   d="scan'208";a="25828111"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2022 14:04:17 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5239B280056;
        Fri, 26 Aug 2022 14:04:17 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
Date:   Fri, 26 Aug 2022 14:04:13 +0200
Message-Id: <20220826120413.712896-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the arm & arm64 module + board DT files as well as x86
platform GPIO drivers.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3837fe33e756..56b660d79b0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20622,6 +20622,20 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
 
+TQ SYSTEMS BOARD & DRIVER SUPPORT
+L:	linux@ew.tq-group.com
+S:	Supported
+W:	https://www.tq-group.com/en/products/tq-embedded/
+F:	arch/arm/boot/dts/imx*mba*.dts*
+F:	arch/arm/boot/dts/imx*tqma*.dts*
+F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
+F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
+F:	arch/arm64/boot/dts/freescale/mba*.dtsi
+F:	drivers/gpio/gpio-tqmx86.c
+F:	drivers/mfd/tqmx86.c
+F:	drivers/watchdog/tqmx86_wdt.c
+
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
-- 
2.25.1

