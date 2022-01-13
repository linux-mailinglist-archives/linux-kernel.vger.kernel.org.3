Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B201848D9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiAMOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:43:08 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52561 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233723AbiAMOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:43:07 -0500
Received: from [77.244.183.192] (port=64100 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1n81Jh-000DVY-AX; Thu, 13 Jan 2022 15:43:05 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] regmap-irq: Fix typo in comment
Date:   Thu, 13 Jan 2022 15:42:59 +0100
Message-Id: <20220113144259.355845-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a resource manager, it is a "Resource managed version of
regmap_add_irq_chip()". Fix the comment.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d2656581a608..d5604f497296 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -1053,7 +1053,7 @@ int devm_regmap_add_irq_chip_fwnode(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip_fwnode);
 
 /**
- * devm_regmap_add_irq_chip() - Resource manager regmap_add_irq_chip()
+ * devm_regmap_add_irq_chip() - Resource managed regmap_add_irq_chip()
  *
  * @dev: The device pointer on which irq_chip belongs to.
  * @map: The regmap for the device.
-- 
2.25.1

