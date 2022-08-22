Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC959B925
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiHVGUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiHVGUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:20:05 -0400
Received: from atl4mhfb03.myregisteredsite.com (atl4mhfb03.myregisteredsite.com [209.17.115.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996C252AA
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:20:03 -0700 (PDT)
Received: from atl4mhob11.registeredsite.com (atl4mhob11.registeredsite.com [209.17.115.49])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 27M6Ikqi003353
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:18:46 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by atl4mhob11.registeredsite.com (8.14.4/8.14.4) with ESMTP id 27M6IhKE009607
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:18:43 -0400
Received: (qmail 3384 invoked by uid 0); 22 Aug 2022 06:18:43 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 22 Aug 2022 06:18:42 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-leds@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.meerwald@bct-electronic.com
Subject: [PATCH 2/2] dt-bindings: leds: pca963x: Add support for PCA962x chips
Date:   Mon, 22 Aug 2022 08:18:38 +0200
Message-Id: <20220822061838.8212-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822061838.8212-1-mike.looijmans@topic.nl>
References: <20220822061838.8212-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCA962x family shares the same I2C register layout and functionality.
This adds support for the following chips:
PCA9623 4-channel
PCA9624 8-channel
PCA9622 16-channel
PCA9626 24-channel

Tested only the PCA9624. Other devices based on datasheet information.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 Documentation/devicetree/bindings/leds/leds-pca9532.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pca9532.txt b/Documentation/devicetree/bindings/leds/leds-pca9532.txt
index f769c52e3643..50a340cbbb49 100644
--- a/Documentation/devicetree/bindings/leds/leds-pca9532.txt
+++ b/Documentation/devicetree/bindings/leds/leds-pca9532.txt
@@ -5,6 +5,10 @@ The PWM support 256 steps.
 
 Required properties:
 	- compatible:
+		"nxp,pca9522"
+		"nxp,pca9523"
+		"nxp,pca9524"
+		"nxp,pca9526"
 		"nxp,pca9530"
 		"nxp,pca9531"
 		"nxp,pca9532"
-- 
2.17.1

