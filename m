Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9546496C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbhLAITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:19:02 -0500
Received: from cpanel.siel.si ([46.19.9.99]:54120 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347890AbhLAISw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ajvHKaf0+LgO7cQ6eDi53nI2uxKkWsWNL99lhHLwFXQ=; b=UEq6+zMDDxyoHd5XFekh30hfX5
        tYp9ePkTomqGlxaWpQXqUj0a5wyo+09gb0SW0D3nVA8+4SeSEqG5e9LxHIJBdmJ8gmIALuN+Ia8pt
        3T8B0K47atN8eBKUw61cqEb6QcldJTv5umdEBMskQmOT2qSc9os8xdxICBWXFyd8AijsYeHbECXtB
        6Rt2Pn7WwZ6bljMyvnFJKs8HCGQctCUY29nuMmrmaTeGgg2eIwTgQg5AxcxGar/72JMl+p5KANLDY
        2oikykbLP2eYX4OpbN/DfN+RqWD1NbgnGCfMsCgGCY9mgZYeEh8at28vIN826iv9rdsE48ZWW1tRJ
        Duulrjjw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:60688 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1msKls-007fXk-AT; Wed, 01 Dec 2021 09:15:27 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] mfd: da9062: make register CONFIG_I writable
Date:   Wed,  1 Dec 2021 09:15:09 +0100
Message-Id: <20211201081512.3580837-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Christ <s.christ@phytec.de>

Make the config register CONFIG_I writable to change the watchdog mode.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
 - no chagnes

Changes in v2:
 - no changes
---
 drivers/mfd/da9062-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 01f8e10dfa55..7041ba53efb4 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -556,6 +556,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
 	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
+	regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
-- 
2.25.1

