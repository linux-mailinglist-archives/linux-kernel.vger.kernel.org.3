Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E559D308
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiHWICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbiHWICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:02:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E37659CF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:02:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oQOrt-0002w0-OX; Tue, 23 Aug 2022 10:02:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oQOrs-001Svc-Au; Tue, 23 Aug 2022 10:02:36 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oQOrp-00ALZf-9J; Tue, 23 Aug 2022 10:02:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v3 14/17] net: dsa: microchip: remove unused port phy variable
Date:   Tue, 23 Aug 2022 10:02:28 +0200
Message-Id: <20220823080231.2466017-15-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220823080231.2466017-1-o.rempel@pengutronix.de>
References: <20220823080231.2466017-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is unused. So, drop it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8795.c    | 1 -
 drivers/net/dsa/microchip/ksz9477.c    | 5 -----
 drivers/net/dsa/microchip/ksz_common.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index f020d9f402845..bd3b133e7085b 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1251,7 +1251,6 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 		if (i == dev->phy_port_cnt)
 			break;
 		p->on = 1;
-		p->phy = 1;
 	}
 	for (i = 0; i < dev->phy_port_cnt; i++) {
 		p = &dev->ports[i];
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 2982c8cb0983c..bfefb60ec91bf 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1081,13 +1081,8 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
 		p->on = 1;
-		if (dev->info->internal_phy[i])
-			p->phy = 1;
 		if (dev->chip_id == 0x00947700 && i == 6) {
 			p->sgmii = 1;
-
-			/* SGMII PHY detection code is not implemented yet. */
-			p->phy = 0;
 		}
 	}
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 769b3ec45a3b5..5b4970072c380 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -72,7 +72,6 @@ struct ksz_port {
 	struct phy_device phydev;
 
 	u32 on:1;			/* port is not disabled by hardware */
-	u32 phy:1;			/* port has a PHY */
 	u32 fiber:1;			/* port is fiber */
 	u32 sgmii:1;			/* port is SGMII */
 	u32 force:1;
-- 
2.30.2

