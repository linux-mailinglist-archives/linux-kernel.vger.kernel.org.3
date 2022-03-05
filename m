Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B34CE49B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiCEL12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiCEL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:27:14 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC543F8BE;
        Sat,  5 Mar 2022 03:26:25 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id AE1CB60564;
        Sat,  5 Mar 2022 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646479583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAy+g86pSYjjn5it3aXzVtAlRS9cIWELtqRIuuhnMoM=;
        b=oaTL491z195TsUb55ZNq26DHCbxbtqD5d/1COKvJ+sVMdta7VNYKI/vAsDLgfBd5YDcBs/
        tr06evrij1izBklB2hixVD+b86JLcXh6TqR4duVnpXdo7ONadnVIVa4xC610mfz0mkxwrk
        qwCb+q4ZTsSAHve9h/YZp/27FcQCtCg=
Received: from localhost.localdomain (fttx-pool-217.61.157.101.bambit.de [217.61.157.101])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id BBE891007BC;
        Sat,  5 Mar 2022 11:26:22 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Subject: [PATCH v5 4/5] dt-bindings: ata: ahci-platform: Add rk3568-dwc3-ahci compatible
Date:   Sat,  5 Mar 2022 12:26:06 +0100
Message-Id: <20220305112607.257734-5-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305112607.257734-1-linux@fw-web.de>
References: <20220305112607.257734-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: bfb49fcd-9f41-417a-a608-f94191395798
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
---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 82be26ce4384..5766941305ef 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,6 +30,10 @@ properties:
               - marvell,armada-8k-ahci
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

