Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F26465E13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355689AbhLBGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:15:37 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:50156 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355667AbhLBGPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=37vJnGk4Mtptef4EuYW6NSZcAfmwkjD5WBzGBHLUA8k=;
        b=P0dXWcCqr6pESCCSx9v1JBgG/MC6yoZfvGUK8NkFUTT7VPeOFxLNltahQPim9MvTx8QbmYkDKXLN/
         Tf7NF7scdG+75E5BxZk4G3GYROmzLfe1jttFOk3V/V2FBbx077T69iGzW9wnkJm2T2Eef3mQeX67tP
         XKsbE1WZz/YCWhKvGOgbZdRBHh/rnwNiP4nfTyEqo4t/nsjuBZ9TDC2PMrt+rJpo7Bv6V88mq1tVOA
         +EpFr8yqOJ3kMdPtSjOo2rwuSHguNzrBPfUmF++06ruHxYDbE7SGahDH14H1WpnsnvGHukV/pmtE2/
         o0TJ4ya50Yvsf9GviDs1FHdYKTy6VHw==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=AWL: -0.278, BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW,
        TOTAL_SCORE: -1.943,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 2 Dec 2021 09:11:57 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, system@metrotek.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: bus: imx-weim: add words about continuous bclk
Date:   Thu,  2 Dec 2021 08:57:24 +0300
Message-Id: <20211202055724.4416-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
References: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document continuous Burst Clock option. With this option Burst Clock, if
enabled, will output continuous clock, otherwise Burst Clock will output
clock only when necessary.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/devicetree/bindings/bus/imx-weim.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index 1b1d1c5c21ea..e7f502070d77 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -48,6 +48,11 @@ Optional properties:
 			devices, the presence of this property indicates that
 			the weim bus should operate in Burst Clock Mode.
 
+ - fsl,continuous-burst-clk	Make Burst Clock to output continuous clock.
+			Without this option Burst Clock will output clock
+			only when necessary. This takes effect only if
+			"fsl,burst-clk-enable" is set.
+
 Timing property for child nodes. It is mandatory, not optional.
 
  - fsl,weim-cs-timing:	The timing array, contains timing values for the
-- 
2.32.0


