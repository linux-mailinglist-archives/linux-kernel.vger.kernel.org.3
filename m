Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39811574C90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiGNL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGNL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E422F649;
        Thu, 14 Jul 2022 04:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDDE61DC2;
        Thu, 14 Jul 2022 11:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A1C34115;
        Thu, 14 Jul 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657799772;
        bh=kbzF1kLHKSnjmvKzE1B04rfZDRLuGvWeaRxAyzu0zY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uioFVVvM4CuB8Cfy1Wnkf0bsSPSHmBvnbY490+p6SfkOQX6vhrUtS24R5msgi5usq
         cA3Xc1SA0NIvYeMeKdeXm0fZzsqjQUhSB5lh/0ZBrrknNeWEy+luAprEs+7k8P4FXC
         VEIdpUj1dX0hZ1/OYjjXwxoQ5wYAdMqv/uHCQCJWvNQiG3q2mA4TdMDKtpkiCsXbXA
         0CEE/mj7VbAn3XIDOdamhnWbM/aoAathcKyKQAWDboc28+B+khvq+yCBlrE3drLLD9
         VsF1WEzRCilGtsV8TLPoWiCrKtFetAVMx2AMyNXgrZmXgLbl9t93TqInfFIoSW4oTM
         t+StI/FtsJN/g==
Received: by pali.im (Postfix)
        id 5249C12EF; Thu, 14 Jul 2022 13:56:09 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] doc: gpio-mvebu: Add information about Armada 38x and Armada 39x
Date:   Thu, 14 Jul 2022 13:55:13 +0200
Message-Id: <20220714115515.5748-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220714115515.5748-1-pali@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armada 38x and Armada 39x should use compatible string "marvel,armadaxp-gpio".

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index 0fc6700ed800..3bc8f5caf328 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -10,7 +10,7 @@ Required properties:
     should be used for the Discovery MV78200.
 
     "marvel,armadaxp-gpio" should be used for all Armada XP SoCs
-    (MV78230, MV78260, MV78460).
+    (MV78230, MV78260, MV78460), Armada 38x and Armada 39x.
 
     "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
     SoCs (either from AP or CP), see
-- 
2.20.1

