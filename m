Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22B580548
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiGYUOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiGYUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:13:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B886220CD;
        Mon, 25 Jul 2022 13:12:49 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PHfnNG016472;
        Mon, 25 Jul 2022 20:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=5Nqtewat4vMxrcQ6TY7HcJu0xAbODflxKUiru2oT7xg=;
 b=l//Y4Wz/KohfMHbM0b5m4GgyRg0qLYQQls3rL1xYdphv60A47HG3CK9OGwUFk6OpoE3L
 fC8RgCEL4mQurztR27YzLzKZj/06pKjoH396cnx5ACbrDJrsPSniq3+E1IzvCRdztBlc
 hzSdg77OmTvDFdljTLGtShtg0e0paNYy71BGrnPtc9CgXXQ/CLEmyPdBYTW6RVQK6oAr
 tDXDYJYdCr4zdIo+MTXx1tLYrkChNMkVJnExy2Pm4/GQb3KaoQpwG6x73vxYM44p/PFJ
 M9SCtE/PbjVNqYf6GqT9YPbO9BxzR6+zUaCD7gxIQwAsaGgHqbdgXgkWaiMTDaYCPDkd uA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hhs7uw51h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:12:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id AECC214790;
        Mon, 25 Jul 2022 20:12:21 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E35F58052E2;
        Mon, 25 Jul 2022 20:12:20 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v4 3/5] ARM: dts: hpe: Add spi driver node
Date:   Mon, 25 Jul 2022 15:13:20 -0500
Message-Id: <20220725201322.41810-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725201322.41810-1-nick.hawkins@hpe.com>
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: PQyT4ZPdFI-1V6IOa1KhQ0H0OgWTtI59
X-Proofpoint-ORIG-GUID: PQyT4ZPdFI-1V6IOa1KhQ0H0OgWTtI59
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=452
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250082
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the SPI flash interface on the GXP SoC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v4:
 *No change
v3:
 *No change
v2:
 *No change
---
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 58 ++++++++++++++++++++++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 21 ++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
index 3a7382ce40ef..d49dcef95c5c 100644
--- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -24,3 +24,61 @@
 		reg = <0x40000000 0x20000000>;
 	};
 };
+
+&spifi {
+	status = "okay";
+	flash@0 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot@0 {
+				label = "u-boot";
+				reg = <0x0 0x60000>;
+			};
+
+			u-boot-env@60000 {
+				label = "u-boot-env";
+				reg = <0x60000 0x20000>;
+			};
+
+			kernel@80000 {
+				label = "kernel";
+				reg = <0x80000 0x4c0000>;
+			};
+
+			rofs@540000 {
+				label = "rofs";
+				reg = <0x540000 0x1740000>;
+			};
+
+			rwfs@1c80000 {
+				label = "rwfs";
+				reg = <0x1c80000 0x250000>;
+			};
+
+			section@1ed0000{
+				label = "section";
+				reg = <0x1ed0000 0x130000>;
+			};
+		};
+	};
+	flash@1 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			host-prime@0 {
+				label = "host-prime";
+				reg = <0x0 0x02000000>;
+			};
+
+			host-second@2000000 {
+				label = "host-second";
+				reg = <0x02000000 0x02000000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..f28349bdeee1 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -56,9 +56,28 @@
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
+			ranges = <0x0 0xc0000000 0x40000000>;
 			dma-ranges;
 
+			spifi: spi@200 {
+				compatible = "hpe,gxp-spifi";
+				reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x8000000>;
+				interrupts = <20>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				flash@0 {
+					reg = <0>;
+					compatible = "jedec,spi-nor";
+				};
+
+				flash@1 {
+					reg = <1>;
+					compatible = "jedec,spi-nor";
+				};
+			};
+
 			vic0: interrupt-controller@eff0000 {
 				compatible = "arm,pl192-vic";
 				reg = <0xeff0000 0x1000>;
-- 
2.17.1

