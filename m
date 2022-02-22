Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18D4BF6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiBVKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiBVKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:55:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB315723F;
        Tue, 22 Feb 2022 02:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EF4BB81964;
        Tue, 22 Feb 2022 10:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982DFC340E8;
        Tue, 22 Feb 2022 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645527279;
        bh=wIRTylDSbq6HNFsEKrJCzozVwSFnbvJ1TOl9tZAPoFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTGR21oPljJsMlXB9NwMH2jR4MA/2qUFE1AnLUILq/xm8lDV1Dy9QOm0kgixTQgDr
         IjU16kzMaO8H+sCMpNx1c9p6buXGmGsS0Wn9H5/G86WF6+94qSfxokV/rj2LPWf/2C
         kEwHE1P+aDtPJnl2JQUZEekETlrR/VyPlI/IiUIqikepF1UBenhMUUAo9/l4XUyrwf
         BOLqpYzJGT7OkIFvkAZNzm5yn5ZsYu0knKIZjHC9fxfittK+bDGpMjRs/y4zx9Wv6T
         LS9sVMGh7tEtG5xQ1phvYDc2plf8+alhylZdypAxX+8fPGvWkJUBt+vgO9hYIPIJLB
         f2I9rTUDjQcOg==
Received: by pali.im (Postfix)
        id 3BF31FDB; Tue, 22 Feb 2022 11:54:37 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] =?UTF-8?q?MAINTAINERS:=20Add=20Pali=20Roh=C3=A1r=20as?= =?UTF-8?q?=20mvebu-uart.c=20maintainer?=
Date:   Tue, 22 Feb 2022 11:54:06 +0100
Message-Id: <20220222105406.28894-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220214124808.31971-1-pali@kernel.org>
References: <20220214124808.31971-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pali Rohár as mvebu-uart.c maintainer

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24527789d933..4a0170718b67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11330,6 +11330,13 @@ F:	Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 
+MARVELL ARMADA 3700 SERIAL DRIVER
+M:	Pali Rohár <pali@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
+F:	Documentation/devicetree/bindings/serial/mvebu-uart.txt
+F:	drivers/tty/serial/mvebu-uart.c
+
 MARVELL ARMADA DRM SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-- 
2.20.1

