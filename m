Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128B34635B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbhK3NqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:46:25 -0500
Received: from cpanel.siel.si ([46.19.9.99]:38776 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240974AbhK3NqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BprRzp7NTlqfFQGFNx7txt6EhUkXQQBm9V5lXLBQLcg=; b=MIKZ9EtUovRfza2Vuz86FTufpQ
        usm7nF3gMGHW8L1ju5kdcQmfqq54vtNfq3G7qHkOsaj6agsvI11RyPgCrTizcfUgBq+pI534g4Wgz
        +ai7TE1Dn3AiBeE8B9Vn4goBp4WP60DqlHNFyxCSnACa8sajCiGyacGNy0RzUOrufHWZhtpcHBhee
        tnCAkrng2T7Nk6TVwx+ipw6ptfRflGrWS/SQrDBzBJanmxGPcuZ6BY8hCKL2h5whkxe9nsGkhdiQX
        xNMAA3iuCC906vCVctKI9NeGy/qoteFOh9j8RjHoFZkq3L42Z2Mb2mJNtCDZ4KjdwN2ZCEyi7EUMn
        zgoZ2bYQ==;
Received: from [89.212.21.243] (port=49710 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3PJ-0039GW-6o; Tue, 30 Nov 2021 14:42:53 +0100
From:   Andrej Picej <andrej.picej@norik.com>
Cc:     andrej.picej@norik.com, support.opensource@diasemi.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] mfd: da9062: make register CONFIG_I writable
Date:   Tue, 30 Nov 2021 14:42:39 +0100
Message-Id: <20211130134242.3516619-1-andrej.picej@norik.com>
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
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Christ <s.christ@phytec.de>

Make the config register CONFIG_I writable to change the watchdog mode.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
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

