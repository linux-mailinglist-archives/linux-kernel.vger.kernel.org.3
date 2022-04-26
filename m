Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1150F2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbiDZHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbiDZHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:38:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24343BE38
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:35:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njFjB-00056t-0H; Tue, 26 Apr 2022 09:35:17 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1njFj8-005InZ-Nc; Tue, 26 Apr 2022 09:35:13 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1njFj5-004roq-U5; Tue, 26 Apr 2022 09:35:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] dt-bindings: net: silabs,wfx: add prt,prtt1c-wfm200 antenna variant
Date:   Tue, 26 Apr 2022 09:35:09 +0200
Message-Id: <20220426073511.1160119-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426073511.1160119-1-o.rempel@pengutronix.de>
References: <20220426073511.1160119-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for wfm200 antenna configuration variant for Protonic PRTT1C
board.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/staging/net/wireless/silabs,wfx.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
index 105725a127ab..ce107fe45d7c 100644
--- a/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
+++ b/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.yaml
@@ -39,6 +39,7 @@ properties:
   compatible:
     items:
       - enum:
+          - prt,prtt1c-wfm200 # Protonic PRTT1C Board
           - silabs,brd4001a # WGM160P Evaluation Board
           - silabs,brd8022a # WF200 Evaluation Board
           - silabs,brd8023a # WFM200 Evaluation Board
-- 
2.30.2

