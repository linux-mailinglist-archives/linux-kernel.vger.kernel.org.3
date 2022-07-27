Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80098582760
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiG0NJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A01F3C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EAD616E9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185CAC433D7;
        Wed, 27 Jul 2022 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658927393;
        bh=Skc+c+PFQVNtRmbU2XSMvMcVQ+RxCYd9R/8c6RYT5S8=;
        h=From:To:Cc:Subject:Date:From;
        b=gHFMgmEkQ0uWWT9XPoFxxbtnRelUGqcUB67ch60lL6nhvTa8a0W4sV8VftrLshkRu
         m/wYosz+8pNi4OLEfV4jn6/47PGTgwVwYJybNRmk9XCMbOR1S3y72vytBoimckNWLu
         YSv2elPc+9A2jk6jVPl0yexP76y00NHgBx3Aeo+b4avAkakEIxRJVXzxNAi6GNYf8n
         DNJpRmwjy8Xx5a/wsyQpbvEuCtP4sakSwSjhwLiXYerM4HHzi6/csblQgDwIM4Alz+
         H2cFkxtXXZfq5SF4u8INxs+Oe26HTHHvqMqoiLRgpRTqW1fabIaZNYR3y7azq/TFnI
         QNr5PwConiSbg==
Received: by pali.im (Postfix)
        id 984697C3; Wed, 27 Jul 2022 15:09:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
Date:   Wed, 27 Jul 2022 15:09:26 +0200
Message-Id: <20220727130926.1874-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows bootloader to correctly pass MAC addresses used by bootloader
to individual interfaces into kernel device tree.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index f4eb6898aa6b..d2afa466e29a 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -23,6 +23,12 @@
 		stdout-path = &uart0;
 	};
 
+	aliases {
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+		ethernet2 = &eth2;
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x40000000>; /* 1024 MB */
-- 
2.20.1

