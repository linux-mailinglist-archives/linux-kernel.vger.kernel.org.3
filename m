Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D94E3D16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiCVLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiCVLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:00:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163C66238
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:59:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o10so16600826ejd.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfghx/qEkC2ONfoEHoNhajwMqvVU/Rw6+xNqAELkwE4=;
        b=3ggq4f3T64nDuKSwbTf/6v4FwlZ/AFMKwVp+igZxWrKaF6n6Orwm1OAgFbA5Zm8EwI
         0MzsmZOeTGQRLC93xUoEqVOCa3qKL8W8N48Ph8Ci544dyke+Dgi95sgCezM+4d9GE1S2
         jdHBYObpDUd/YWJ34i0wcPkKigC2hEwzzakfhC7iGQPMQp+pkSJ1JyeSG4y1v0YfTcI2
         lWZsZb6H8h1GXh6cF3j3Z5z0xQi3RRycMyZxZM6TKTiWP5LZsoaaTRRsx0au5lm8SwUl
         /ijvmNlzSWC1LWRZd+mvBRfwFjPoyAJqN58Gdf0d5gW+KcJzXDHxLixGiS0qdmPADSm6
         WsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfghx/qEkC2ONfoEHoNhajwMqvVU/Rw6+xNqAELkwE4=;
        b=rBNqNBh80NoKxNngofdeleYssPHQS+5yqYjyElbXPdQ0wB4K+kh9HMNRiknQipdgp2
         WrtqDhGHUB5k2luTpUnR5HIkpGhAew9EUfu/JtbLMVrzPGgr6NsZkbFQf6YKoCmMqTxF
         utJktPevf5frdpqdN0r3xYMduXCsdz8c+HcCCcQj7VtBSrFh0+AQgHHvmKRWt1qCQ1IG
         A8LMw0Y5mLhjYLXyiLPUHMjMN2RPCnSmR2zU0GubvwR5vdkXD77g7+hflqKSxwaZuCD5
         zVBt/tY7sStII0CMYOLgxiRtQAB7I7udiRy5XmkvdVXjiqBmgivG6999uCu6nKdHq1E8
         sCQg==
X-Gm-Message-State: AOAM532TBGhMltzzvOV2JFjoDnCK2fjuH7vl4weq2fFtfns/qdNzzlX7
        Ewqt22AdlQztSFLnNMB1unBd+w==
X-Google-Smtp-Source: ABdhPJzmf1aOUH0Mk/vPLVvoQz/uaOiphL8+V2bJXKtiEls+synowm9ZyksG2v6vj+lPIw7QNwo2ew==
X-Received: by 2002:a17:907:7f88:b0:6db:c308:c247 with SMTP id qk8-20020a1709077f8800b006dbc308c247mr25177763ejc.300.1647946744330;
        Tue, 22 Mar 2022 03:59:04 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-57-cbl.xnet.hr. [94.253.144.57])
        by smtp.googlemail.com with ESMTPSA id b7-20020a056402084700b004190d2fc521sm6150240edz.89.2022.03.22.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:59:03 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org, marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/2] arm64: dts: uDPU: update partition table
Date:   Tue, 22 Mar 2022 11:58:56 +0100
Message-Id: <20220322105857.1107016-1-robert.marko@sartura.hr>
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

This won't break booting for existing devices as the SoC-s BootROM is not
partition aware at all, it will simply try booting from 0x0 of the
boot device that is set by bootstrap pins.

This will however prevent accidental or automated flashing of just U-boot
to the partition.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Update the commit description by adressing ABI breaking concerns
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

