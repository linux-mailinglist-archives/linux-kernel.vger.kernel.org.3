Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5557B591
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiGTLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGTLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:32:45 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F81054073;
        Wed, 20 Jul 2022 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kpaaj
        BOfzbbOFFRZjzLDHiiY7kFjuDP7fC09D8d0oNI=; b=iMAFCEKniiWSXZ/eBbf3e
        lAOwsd5xNcp3MCvthqDIRvcgtSeYT6wwcOw8yydC60usiIJCDqFS8udp5eM1xjpc
        rgvgoZRJry2oJ6tU5rMGd2rF/+yzlvt016raK8DhOZjWkBuh0rtrLVJx6cSB2FDO
        nVVaK2f4y9IDUVGqF8KWtI=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp4 (Coremail) with SMTP id HNxpCgDH6bKc59did5_bPg--.847S2;
        Wed, 20 Jul 2022 19:31:43 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     david@lechnology.com, nsekhar@ti.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] dt-bindings: clock: Fix typo in comment
Date:   Wed, 20 Jul 2022 19:31:39 +0800
Message-Id: <20220720113139.17982-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH6bKc59did5_bPg--.847S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAF4UAr18Xr4xKr4DJwb_yoWfKrXEg3
        WxJF4v9rsxAFyagan0vFWIya4Iyr17CFW0vF9Fqwsay34IqFZ0kFykJ343AF1rCr429rnI
        9r4kJr9rXrs7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREbAwDUUUUU==
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDR9EZFaEKAQ2mwAAsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
index 36998e184821..c9894538315b 100644
--- a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
@@ -15,7 +15,7 @@ Required properties:
 	- for "ti,da850-pll1", shall be "clksrc"
 
 Optional properties:
-- ti,clkmode-square-wave: Indicates that the the board is supplying a square
+- ti,clkmode-square-wave: Indicates that the board is supplying a square
 	wave input on the OSCIN pin instead of using a crystal oscillator.
 	This property is only valid when compatible = "ti,da850-pll0".
 
-- 
2.25.1

