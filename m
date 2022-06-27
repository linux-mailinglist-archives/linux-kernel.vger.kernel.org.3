Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14F555CF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiF0WkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiF0WkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:40:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9A192BC;
        Mon, 27 Jun 2022 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656369595; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=7e2lsFGEULtsP9T93yoqJTdu2saIeqgwp9dJtuGRnXs=;
        b=kavfuw1+wEjWteLwesG40+Mk/78NO6WUEfXRuJ2vSX/DSgMd50agRO1XFt5EA8kPIBG64C
        LezXJGTLPotxwprsBJKgO4KKUYQPCzq4ox1diRhYcggAX4QqrQ1AaJeNNCrnQVCIZo0vq6
        QFgPeW2ilh5tn4j/+M6RT+lXRB+c4Bo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] docs: dt: writing-bindings: Update URL to DT schemas
Date:   Mon, 27 Jun 2022 23:39:50 +0100
Message-Id: <20220627223950.35748-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous URL was giving a 404 error.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/writing-bindings.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
index 5465eced2af1..1ad081de2dd0 100644
--- a/Documentation/devicetree/bindings/writing-bindings.rst
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -53,7 +53,7 @@ Properties
 
 - DO use common property unit suffixes for properties with scientific units.
   Recommended suffixes are listed at
-  https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-units.yaml
+  https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
 
 - DO define properties in terms of constraints. How many entries? What are
   possible values? What is the order?
-- 
2.35.1

