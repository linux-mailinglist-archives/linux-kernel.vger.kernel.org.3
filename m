Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3F4D6A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiCKWqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiCKWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:42 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C942AC7;
        Fri, 11 Mar 2022 14:21:22 -0800 (PST)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id CE2F7603D3;
        Fri, 11 Mar 2022 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1647032665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UipeGN/lk/TzTLQBE8U+msplr/bYO1V5yFkflbotwM=;
        b=cvqjTokRRKZjXjx9aF/ckduIIPg7J2HlPa+bWDbk6KsHO95HS/EbRhAv4pe2oEjR5jLFRZ
        7QAy0G8uPWIJK87IatoyfsRLMrTN98cLG5z/yRCsnYtl06tLTE+nFusrYQhYAVoBrJgZMe
        WIZbG00PJch45aPzwzZBz0YICkITdyw=
Received: from localhost.localdomain (fttx-pool-217.61.144.196.bambit.de [217.61.144.196])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B54BA40684;
        Fri, 11 Mar 2022 21:04:24 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v6 5/6] dt-bindings: ata: ahci-platform: Add rk3568-dwc-ahci compatible
Date:   Fri, 11 Mar 2022 22:03:56 +0100
Message-Id: <20220311210357.222830-6-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311210357.222830-1-linux@fw-web.de>
References: <20220311210357.222830-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c6cb62a7-76d4-402f-8b87-826c4e7c4312
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add SoC specific compatible for rk3568 ahci controller

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
v6:
  change subject to dwc instead of dwc3
---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index a02f6d12773e..c146ab8e14e5 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -49,6 +49,10 @@ properties:
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
           - const: generic-ahci
+      - items:
+          - enum:
+              - rockchip,rk3568-dwc-ahci
+          - const: snps,dwc-ahci
       - enum:
           - cavium,octeon-7130-ahci
           - hisilicon,hisi-ahci
-- 
2.25.1

