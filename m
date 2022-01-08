Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCF4884CB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiAHRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:05:51 -0500
Received: from ixit.cz ([94.230.151.217]:50974 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbiAHRFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:05:50 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 450512243C;
        Sat,  8 Jan 2022 18:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641661547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=txTVetdLfDhf1BnlS8MbqalOAZSWhec4Vi/tJkpvuWg=;
        b=UkzFum76xwpKeJqftK74rIRIXoS6HZxeYqRN7icGsfM4wCTcTRTZEmmYI48apEIhuYbwOF
        2w0wCO+YusTKotFpmy/DqXQf9Sy2DRP+3hSwqDJ9hM+XPk4L+Wi4NQyoJbk/ojIpBb4oC/
        iPZBUUIi3H7zfVNbgNF0m4MYjgPsnrc=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: apq8060: correct mvs switch name
Date:   Sat,  8 Jan 2022 18:05:45 +0100
Message-Id: <20220108170545.54127-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mvs0 doesn't exist in documentation nor driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index d664ccd454c5..68354ca76c5d 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -674,14 +674,14 @@ s4 {
 					bias-pull-down;
 				};
 
-				/* LVS0 thru 3 and mvs0 are just switches */
+				/* LVS0 thru 3 and mvs are just switches */
 				lvs0 {
 					regulator-always-on;
 				};
 				lvs1 { };
 				lvs2 { };
 				lvs3 { };
-				mvs0 {};
+				mvs { };
 
 			};
 
-- 
2.34.1

