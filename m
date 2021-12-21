Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7147BCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhLUJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:13:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40662 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhLUJNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:13:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AEBE9201266;
        Tue, 21 Dec 2021 10:13:48 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7682D2019CE;
        Tue, 21 Dec 2021 10:13:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E6C13183ACDE;
        Tue, 21 Dec 2021 17:13:46 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add i.MX sdhci maintainer
Date:   Tue, 21 Dec 2021 16:44:48 +0800
Message-Id: <1640076288-32714-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add myself as the i.MX sdhci driver maintainer.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 210bded08641..1e72f46b43b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17283,6 +17283,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-omap.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-imx@nxp.com
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-esdhc-imx.c
+
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 M:	Revanth Rajashekar <revanth.rajashekar@intel.com>
-- 
2.25.1

