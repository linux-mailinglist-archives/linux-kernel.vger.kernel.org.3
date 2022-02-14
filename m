Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D14B48C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiBNJ6T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 04:58:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbiBNJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:52:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D367361;
        Mon, 14 Feb 2022 01:43:35 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9MQY8031392;
        Mon, 14 Feb 2022 09:42:56 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6thxexg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E9blfS031636;
        Mon, 14 Feb 2022 09:42:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3e64h9js61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E9gpJx44433700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 09:42:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7125A4051;
        Mon, 14 Feb 2022 09:42:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159F4A4055;
        Mon, 14 Feb 2022 09:42:51 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 09:42:50 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.60.190])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 99BD02201E5;
        Mon, 14 Feb 2022 10:42:49 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 09/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
Date:   Mon, 14 Feb 2022 10:42:30 +0100
Message-Id: <20220214094231.3753686-10-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QLbS7MTYhjvaSpSpPmWkytPeGaWNJ1H8
X-Proofpoint-ORIG-GUID: QLbS7MTYhjvaSpSpPmWkytPeGaWNJ1H8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1034 mlxlogscore=563 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these controllers support at least Dual SPI. Update the DTs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index f14dace34c5a..da211fbd8658 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -65,27 +65,32 @@ fmc: spi@1e620000 {
 			flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@3 {
 				reg = < 3 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@4 {
 				reg = < 4 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -102,6 +107,7 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7495f93c5069..804b66d32127 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -67,18 +67,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -95,12 +98,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -117,12 +122,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index c32e87fad4dc..542714c61a85 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -107,18 +107,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -135,12 +138,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -157,18 +162,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

