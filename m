Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AA4F9D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiDHSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiDHSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB9377C1;
        Fri,  8 Apr 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443086;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GdauujCPAC9XZ6laj4JhGHQ69T3VNNNoNVbfWmB49Iw=;
    b=N9LzsO6ENVHTWv34FY7+41nnacgKQ5LfNBMkQ4ihYh7E7FJhPRcEo3jvrKZxferRuL
    iLRaZEVdkVj8i1Xsd9hGAowOEMgieMrDFq4kSrasYoFt+my5CETobUuqvVQ1l65Mznva
    I5OxTXYXU+Qg9ikA0UcA1FLBzHgIs/tfzLYwHqp9ljvvrNmYeZSUBWXd+lZopw4GE06f
    Vd2xWXSQLUQesypdqoE0sS7KBAltmQrNtd37kLMqQrhixWjcIAe+em4RbfSl4eLkW8Xp
    9x8lauvaEtdzU520gT+Jo3zQHpbmpxbe0TJDqrIWA1As1CEe9ozmjHKEATm5xKKNDsNt
    RdnQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic6so6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:06 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 15/18] MIPS: DTS: CI20: fix fixed regulators as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:58 +0200
Message-Id: <f04ba92a958abe0051be7ce3202f6361cb0f05f2.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	From schema: python/site-packages/dtschema/schemas/root-node.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@1: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	From schema: python/site-packages/dtschema/schemas/root-node.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@2: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	From schema: python/site-packages/dtschema/schemas/root-node.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index cb5257d32b55e..c045c4f75895e 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -69,7 +69,7 @@ led3 {
 		};
 	};
 
-	eth0_power: fixedregulator@0 {
+	eth0_power: eth3v3 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "eth0_power";
@@ -99,7 +99,7 @@ ir: ir {
 		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
 	};
 
-	wlan0_power: fixedregulator@1 {
+	wlan0_power: wlan_power {
 		compatible = "regulator-fixed";
 
 		regulator-name = "wlan0_power";
@@ -108,7 +108,7 @@ wlan0_power: fixedregulator@1 {
 		enable-active-high;
 	};
 
-	otg_power: fixedregulator@2 {
+	otg_power: otg5v0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "otg_power";
-- 
2.33.0

