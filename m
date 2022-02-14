Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456754B5092
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353637AbiBNMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:48:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBNMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:48:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C004A908;
        Mon, 14 Feb 2022 04:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE134B80E84;
        Mon, 14 Feb 2022 12:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE15C340E9;
        Mon, 14 Feb 2022 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644842916;
        bh=5VBRcMnozVVrgeg8YNsAkECBk8HhPpFaMQX/fh7rLzU=;
        h=From:To:Cc:Subject:Date:From;
        b=Bp75UOy/RMIn9ZsLM+1TjajFRbrQF5ASoYY75AZRt1uJwi1mFZkmCCM2c7hOqmpu+
         3j4Gu/Lmo3ksQy2cTqP9AbUCD4oqaeY8Ty0rou5Uei5RFyUfm6nVVmq44BNZYbNTdR
         ZTf1teR9yLZNyEFf3MsUIXIqy4UhZTeUOhh2KBzjHMYTwp4/YQFwm20dNrsL+lYSS3
         6tLOxWMRsoUo6jj5PpLi2PpwOGPpqY1RtknxNIHCqQqaUhRjvlU9V28l79Qk5tQfOG
         g+qCGY/Ju59IqGIAhZStug+KOoWR7L5Sks1cYKPhSzNFsJeTvxblvVw/f5b9Z2ZmYs
         gjTxMbOpU76ig==
Received: by pali.im (Postfix)
        id BFEA5CAA; Mon, 14 Feb 2022 13:48:33 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20Add=20Pali=20Roh=C3=A1r=20as=20m?= =?UTF-8?q?vebu-uart.c=20maintainer?=
Date:   Mon, 14 Feb 2022 13:48:08 +0100
Message-Id: <20220214124808.31971-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

