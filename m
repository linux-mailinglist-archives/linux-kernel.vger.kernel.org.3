Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2514DA48B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351964AbiCOVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351940AbiCOVWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:22:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AA5B3F3;
        Tue, 15 Mar 2022 14:20:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 0EB771F42BBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647379251;
        bh=vZXGUjEOoQ/hDl1/0up+a55Pw8LwwlkZJAbKDK6p7ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQ3dUMDo+U38x8tXlkVy+aOoIfivhouBoK4rUd5hAnnxlR8uqiJWObLdl/sPOAgnB
         0j1ZIdnPKux6r9hJLHbeSAWJZqA/g84oY+awqqGSBDJ7CNkjGewTCR05cngdJA6pex
         AztOP3wqTQPHp8dyhteUJMZGu5oA+IJKX0Q4j0veVaUGnL1Z92XLcmxpc/TlCH37Gh
         D4uBgW6dmpNib6Y9Z7raDIvnJjpYo75WoM3rI1uXFI8VMTwq9GLJswdV4oUd68Z35k
         Vni+s1kR0ivvrWpRpUT9sL5pFxq36AAyZk7D2k/uwWkEQqvg1YCFQs83YQsvi77Tvx
         J13eM8VJBZc9Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/4] dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property
Date:   Tue, 15 Mar 2022 17:19:35 -0400
Message-Id: <20220315211936.442708-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315211936.442708-1-nfraprado@collabora.com>
References: <20220315211936.442708-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mediatek,pull-up-adv property to the pinctrl-mt8192 dt-binding
to allow configuring pull-up resistors on the pins of MT8192. It is the
same as in mt8183-pinctrl.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index b52d8d0eb2d0..e27cbcc6e8f9 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -104,6 +104,17 @@ patternProperties:
             $ref: /schemas/types.yaml#/definitions/uint32
             enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
+          mediatek,pull-up-adv:
+            description: |
+              Pull up settings for 2 pull resistors, R0 and R1. User can
+              configure those special pins. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+
           bias-pull-down: true
 
           bias-pull-up: true
-- 
2.35.1

