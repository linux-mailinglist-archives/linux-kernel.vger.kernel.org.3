Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD834E2634
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbiCUMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbiCUMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:19:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9C1621A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:17:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bi12so29474761ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gk1B3hBjSKKALLbMXPJzBO9u7PaCeN3YmxnZwj0te/Q=;
        b=Y5ZBInvrLKsctfPEN/yXexUNGkj0Fcj3fhlmk93UvxeJPgMALV5CGSZy6u+h/wcUCv
         xDsxIskcl52BSMzq9KDtExq44Y/QXKWiwgxcNwpMkDTqds/uRNuqD7q1LO8W7xtp0AN9
         S4e8/6CvVnCXbVJVsNpdjPGRc4IkNF+6VEr5IoFq0houh9lOiMdrkXEJUFioz02y+IF3
         QLerTQgAfucvHTo3LezrfMCTjmYYoOI2Dwa+qb0Sst6tlsUat8qg8OPAFqNgsur3m1bi
         oEAg+0sq8D4XHR2uqc60aiNzdnlVTFOa7DtUDvkC+UlAOEqUueawj3fYzv766afIULJM
         9bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gk1B3hBjSKKALLbMXPJzBO9u7PaCeN3YmxnZwj0te/Q=;
        b=Uw5PlIpGxQevj7L5M6upyOSSAcRsRPHQ53f161ekYN3hzWMFabdpUFWssadC6sR/XV
         qz0TVsQxR0gw3RTkx+ccsnobQClZ92ahPUcKzpElV/B/KG0XDT7enGt8HWBygWkczbmQ
         p9hxSr27Lmi1PENcz18h46myBIbCggFDbHMdCdikuIU8P17TrG2iEGm+yt7Ts5PrbiQP
         mTSA9aS/IuKd7gPxVSF9qlkZvpiz3lOr/cDzJa+I0UaFgyrTkgWHX/UBOeY1hcQRDIHP
         ChrL6TguIhpcPKmD/6BjO1laPjSteh4gghedQk9gU9t1yO8YQWLuTXAXxxhkeoBhcvjc
         S0oQ==
X-Gm-Message-State: AOAM532saRCmV1y8FWL077S3BXVi2vOSWVNq1mgbNwRI+JnhGEcz4zYT
        YcJJX94p8f07l/jKTMDG8nNIjg==
X-Google-Smtp-Source: ABdhPJzBcTTL0aQl8R5DyF7VDiOr/LEmvPfCW4xUYRGmKpuSu9pHiougpl2vJlKa0Jp4IScVwCNuIg==
X-Received: by 2002:a17:906:26c6:b0:6da:ecd5:fd48 with SMTP id u6-20020a17090626c600b006daecd5fd48mr19909043ejc.93.1647865053745;
        Mon, 21 Mar 2022 05:17:33 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-57-cbl.xnet.hr. [94.253.144.57])
        by smtp.googlemail.com with ESMTPSA id nc7-20020a1709071c0700b006dfe66694dasm2457100ejc.144.2022.03.21.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:17:33 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org, marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] arm64: dts: uDPU: update partition table
Date:   Mon, 21 Mar 2022 13:17:27 +0100
Message-Id: <20220321121728.414839-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partition currently called "uboot" does not only contain U-boot, but
rather it contains TF-A, U-boot and U-boot environment.

So, to avoid accidentally deleting the U-boot environment which is
located at 0x180000 split the partition.

"uboot" is not the correct name as you can't boot these boards with U-boot
only, TF-A must be present as well, so rename the "uboot" partition to
"firmware".

While we are here, describe the NOR node as "spi-flash@0" instead of
"m25p80@0" which is the old SPI-NOR driver name.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..ac64949bb53e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -99,7 +99,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_quad_pins>;
 
-	m25p80@0 {
+	spi-flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <54000000>;
@@ -108,10 +108,15 @@ partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			/* only bootloader is located on the SPI */
+
 			partition@0 {
-				label = "uboot";
-				reg = <0 0x400000>;
+				label = "firmware";
+				reg = <0x0 0x180000>;
+			};
+
+			partition@180000 {
+				label = "u-boot-env";
+				reg = <0x180000 0x10000>;
 			};
 		};
 	};
-- 
2.35.1

