Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8549A48E327
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiANEIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:08:13 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57208
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231851AbiANEIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:08:13 -0500
Received: from HP-EliteBook-840-G7.. (223-140-209-80.emome-ip.hinet.net [223.140.209.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 681D640002;
        Fri, 14 Jan 2022 04:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642133291;
        bh=3BTt7dRF1RcG7Bf2E9gOu4TD30A9Rt/FOfeHFCb9CMY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Khjnf3VecjEEWSqvQXvF9xvzw/KLwswVkToen+90dUS3MLV0hCl4ZzSHfZdBYGF9Q
         rEEvqi5g6px3PE2nnlj9/Cjia5x4Bc6ifbvQ9i8lA6OgKa41pzJU2H6kD1GlMQEkQ9
         FzW3fle441EEM1iOdou9+L0uuFjCvC2uDrxQ7hwt1Vm2Py319QqFSfQrAaeQapGHZo
         5T3K+Gq4ATOcYz/Eq6ryBHdhKsfYm8fJ8XfQT5tFn7eNIffvRcfjagPj4S6KUxK8kT
         Cmuke6es+1IttRSsdTgvhr+esKGubENqRu4Nlo8SAHA371nHzxJdhoFBMYx1y14ZWc
         7yX4SS0Z4yKaA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: marvell: Use BIT() macro for flags
Date:   Fri, 14 Jan 2022 12:07:53 +0800
Message-Id: <20220114040755.1314349-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT() macro to make adding new flags easier.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/linux/marvell_phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 0f06c2287b527..ea5995d9ad6c1 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -40,8 +40,8 @@
 #define MARVELL_PHY_FAMILY_ID(id)	((id) >> 4)
 
 /* struct phy_device dev_flags definitions */
-#define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
-#define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002
-#define MARVELL_PHY_LED0_LINK_LED1_ACTIVE	0x00000004
+#define MARVELL_PHY_M1145_FLAGS_RESISTANCE	BIT(0)
+#define MARVELL_PHY_M1118_DNS323_LEDS		BIT(1)
+#define MARVELL_PHY_LED0_LINK_LED1_ACTIVE	BIT(2)
 
 #endif /* _MARVELL_PHY_H */
-- 
2.33.1

