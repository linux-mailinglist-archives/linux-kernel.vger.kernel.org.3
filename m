Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11246AE76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbhLFXbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:31:18 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:28028 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377310AbhLFXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=1yeWtbQKA16U/4DtwdaL3D+xToU11fWNWT9PPXPJ9cc=;
        b=oPEOeEXCepYHp83F5WX/IjdUSBVFWiUEzaYxd1GeNKs4gx09C6I+1ORhYQZy9TfOih3U
        sttNjN9yALYBXfwhkLKcquZ3uZXmj0esopb0DsXwuG5pUyPkCV2PNoM80IV+fQYjKT9erY
        2WD0Jc9wbvzSE73Cwf/GBPoWHcmgrVgxpfrdaymUczjoUH5a9KjXww3bXFtNo7Tx2olXL3
        kI00S4unuXvcm1WUqo+MZJBV3irKS1gt3cxO6B18GaHQMv5wis27waQ2vL0lWxy3YozXjX
        A+FElrIiXCT/r5rjs/H3cfWAkqcjikTcirPWLnpXPtzlVLT5TivcqN+VcIist38g==
Received: by filterdrecv-canary-776d44b74b-grhrq with SMTP id filterdrecv-canary-776d44b74b-grhrq-1-61AE9C68-3
        2021-12-06 23:27:36.11826919 +0000 UTC m=+8379752.411627175
Received: from pearl.egauge.net (unknown)
        by ismtpd0064p1las1.sendgrid.net (SG) with ESMTP
        id 9cGHdJ5gSdiL9M3rm73uQQ
        Mon, 06 Dec 2021 23:27:35.886 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 65E8870016C; Mon,  6 Dec 2021 16:27:35 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH 2/2] wilc1000: Fix missing newline in error message
Date:   Mon, 06 Dec 2021 23:27:36 +0000 (UTC)
Message-Id: <20211206232709.3192856-3-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206232709.3192856-1-davidm@egauge.net>
References: <20211206232709.3192856-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvBrLXqrGP55smawYI?=
 =?us-ascii?Q?kooO0FRxDy6ykXHu=2FGLtf0a23Z9x7+W8kY=2F4a5W?=
 =?us-ascii?Q?4SxmnJUzRbiRaYX8Sv+hwJnE7HOUPMRSNTcYlLB?=
 =?us-ascii?Q?=2FYMt4nTljODXu2z1N09CtelIDcj2dNFAV6jDTw9?=
 =?us-ascii?Q?9mVFjo2LligiwP6SRCVGuW3h+kgPPdyqtwanu1m?=
 =?us-ascii?Q?oHTNuVUeF+Z5G2C3cmguw=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing newline in pr_err() message.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 690572e01a2a..633cb3a43f6a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -27,7 +27,7 @@ static irqreturn_t isr_uh_routine(int irq, void *user_data)
 	struct wilc *wilc = user_data;
 
 	if (wilc->close) {
-		pr_err("Can't handle UH interrupt");
+		pr_err("Can't handle UH interrupt\n");
 		return IRQ_HANDLED;
 	}
 	return IRQ_WAKE_THREAD;
-- 
2.25.1

