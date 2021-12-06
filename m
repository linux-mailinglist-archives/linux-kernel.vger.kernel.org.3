Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD72469084
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhLFGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:51:17 -0500
Received: from cpanel.siel.si ([46.19.9.99]:43388 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237859AbhLFGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5w/TJryA/cWW+EL8XelUEuk9S77Liq/Se2Hvh6rnlRU=; b=pJ5VuKvJXR7p4qM2/SlVuPFLz1
        h+046geMgBy8GVcToA1ZPHLpi5xt5fXxcfqnZH9pwGuUT31YaXqYmE6clmtvWGczaNUskNjRT94SO
        O6eNA8mKe73H11ZqlhYYnZ0zSGkivUvhKwBZpmjeXvr230KUWNhNvlQ04VXPQvNFARlFzrO83Yy9E
        ia1h/jySj1v8fV+v1OF7fRkl693xpDFXqB2FUhwxuG4qjeFn+da76azGVsZ5o1ksao/5+LcjnCIWH
        nNyH8Pkuoc+iawZBXrQ99lt5+smThKooqYY8FkeGOituu5JsGAJCeVH2D7DJkRjZVg595rWile96q
        qA2FZy4A==;
Received: from [89.212.21.243] (port=40020 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mu7mf-00GJXR-0C; Mon, 06 Dec 2021 07:47:40 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com
Subject: [PATCH v5 5/5] ARM: dts: imx6: phycore-som: set watchdog timeout mode to shutdown
Date:   Mon,  6 Dec 2021 07:47:32 +0100
Message-Id: <20211206064732.280375-5-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206064732.280375-1-andrej.picej@norik.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
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

Enable system restart when the watchdog timeout occurs.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v5:
 - no changes

Changes in v4:
 - no changes

Changes in v3:
 - no changes

Changes in v2:
 - new patch, enable shutdown mode for phytec-phycore (da9062 user)
---
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
index a80aa08a37cb..743343e525cf 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
@@ -111,6 +111,7 @@ da9062_onkey: onkey {
 		watchdog {
 			compatible = "dlg,da9062-watchdog";
 			dlg,use-sw-pm;
+			dlg,wdt-sd = <1>;
 		};
 
 		regulators {
-- 
2.25.1

