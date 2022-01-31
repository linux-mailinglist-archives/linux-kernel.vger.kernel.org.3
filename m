Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F54A4AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379694AbiAaPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:35:25 -0500
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:60817
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376980AbiAaPfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:35:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXgAq06POWCOz2eiwCcAmF3gCMayJHeN4MpPNTudvtEuug0N3YBtyIiWKriot2DHy8VWM/qiHkxErTC/g2ubBNHKe9i8pkFTmWBpT57tqT33c7uyqLxRDE53X3p7NAQ1PAblfvuN2rCjGLTx7gkAYzqQQedjDBQkFaJARzq/tCkj8RhLZnswdvaWZIryzG/YUmiKlWFEjgGVJ6Of/Osgb+evdCbUmxUNjL2GV79oTpq3SXXHduSX/cYw+XRFqizrPviTvWVDlFlZYEGheu+1N0aP15MJTqggIZApvuvobJ0hBOQO2WbUm4EJtldNyoM8WS/5LQjz1MpJANNgEu8v5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rzN/8RFYxPX21EsduT8nv+4T2w3SUW1XjolR1OURRs=;
 b=dPiXbo6ZTV7D3U9hzOwwSncP+ou2517OsjWL5At5eJLEmw9WZYg1AdfDpf8KPuTLETWkAXKyJTWZm3YX/2b9ZlXAc1wfp42uZsTQkNDoqh4lgx4bTZbKrGR/0zfVUgzu3DlGbx45I0fC57gZ05zuOKjlxXKwfkf6l12H7+bJIObhMKddiRu1RTJRjp0rx2CkRTrDbuSsYTL4/67/tVVT61woTmMoPWhzzTSoJ84eJZWCjtcM2zTVobK2mb9ZCX3bCPDe+/DYQMizjQyQ8piEh1UoGcToFMygmRhFKsVwgV1SIFkrig3HPA5Ex9qojyCyy8ImChOj6DrFnZu2kCoInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rzN/8RFYxPX21EsduT8nv+4T2w3SUW1XjolR1OURRs=;
 b=nLA3NXGxt8qJKUPxM/aBpoU6tbKlc37M19YGtqmC80X1aCaSjD3aS4LEsOzpfalGhSAmv6G9c1xp1jSSXT5mGDgZZu8C6LqDehOOO7nbey7veRLh+3XQ+oD7Eb0pNJQgGKiGy6+hfVxJS247g4ZwC7mh6NYJ10meNNAw8pEgwEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0802MB2267.eurprd08.prod.outlook.com (2603:10a6:3:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 15:35:17 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 15:35:17 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH] arm64: dts: rockchip: add the i2s3_2ch node to rk356x
Date:   Mon, 31 Jan 2022 16:34:57 +0100
Message-Id: <20220131153457.391460-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f027715d-eae0-4ba9-6b27-08d9e4cf47e7
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2267:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2267500DB5FA3BD79C1381D8F2259@HE1PR0802MB2267.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNhkVbu0EL07JDBUeKvsBSjtAJXb6lQPpjqm6ZpkxYPHrYRxIIiDL+9zdb7Gu84KdONer0Orb61FznTI3gn3RtX+hXYH/ZJXIeV3lKuL51PO0/pHKmg29ISmP0mONTNAPoWF2Y8h9bDCB3KBZJHxRgQKerHiQMxGCfRNsMEDVFTolWzF5AOz2S4LC6Gj99ZjOFvuWmMtxDd85q91QsDeiIDWZEi8CFvMBy+2yF1n5awjwp2H096G0ARiIRE1VEvK70GRU/+gJ92wBf2NwBBZtKFRpAaptRav24zAJwrSBCvpya6slHeYU+gCSJVq8fCp3Z3Ei8JOCmtlSd7C/yNHhitBWcz7j8TP6F7m+S6+pUBWERIGGer4F5P1hpDIEC+s50m3dR7Q6rjDJplC77rmXZz1oOFBUCvt2ojc/GVAZly8V5iPAyfXexYncoAjVNK75/TdWaRfCDJo9hgnpTBd74VOAaP9LykMHwImZZVtaYXWmVLHqHUY5LQJqC8ESEpGE2JYtSFkf0VO37w47sHWrb6gXGcVew639XzkDSguV1//y3ivPc7I9egYzUrCGZqYsfWrwNL2a59G1+O5VxReStcroqiMh0zgmXUw/GH69764iVYkIHp525G7iOnDP0Ul+psRpd/rkrL9HanZYUOnxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(44832011)(52116002)(6512007)(6506007)(83380400001)(186003)(1076003)(107886003)(2906002)(54906003)(66476007)(66946007)(38100700002)(6486002)(86362001)(508600001)(6666004)(36756003)(4326008)(8936002)(66556008)(8676002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hiBlwBuKTKjzh6gOyGvb9prpZ6MI/8l1DkURS3PIWyK8uDBaVJ6GwCKCjAAm?=
 =?us-ascii?Q?GVYri73yl5XYSJwIITcibran5swkyi7/mjElA38tcAWkU1X3ou0xm0Rbbvov?=
 =?us-ascii?Q?+N00S6f9mjXbXk4/z8OhBD8OX2+Kokjdqa8j8NoNaGTvA9xKzIBWZU860Y1W?=
 =?us-ascii?Q?3KYcMT0126lyUimoLC6z1Fd2pO/GPZ8JZQu9SKOgAKUUdD2sdYNapoksH7Zw?=
 =?us-ascii?Q?Nh8VN5SEFikYSxXvCjiMj0mhEgjmrTSPKNXiOc9roR9dUKumYVtz2D6doIY6?=
 =?us-ascii?Q?C85yNOUcQaCswOhRZuVkllsvGqSCJ8kUHK93COjL38KVF2Pr8nlPG4Ifuitu?=
 =?us-ascii?Q?svM9lAaalWYTNeyEx8w8z0b3c13cgfNCQ2FezxzY+yfoqHCKv6xUDejs/AhT?=
 =?us-ascii?Q?ETv33U0H3CR4WGFkyWejqyC6uHaFmkXcxLBeV4ia1NW10w/24zVqJtdsWc65?=
 =?us-ascii?Q?yiZAJa+uyspAMWSf52TdQsSqW2Hdf+L8GZ+HbQ4GZMLgv2t9LSpUaEuvOLAR?=
 =?us-ascii?Q?vmSyj/ZA676l2lM3p0DfA54a5u5S/8uRF7ttBmAQFZGAeGrMhWGdFSN1NCWe?=
 =?us-ascii?Q?7XU6qc2lr57GbLdkVdI/z1AUMI3k2i3GjdukZ9eJrrwaD5rnjV/JrHMj51Lp?=
 =?us-ascii?Q?fs2AcJDInqLUEMX1OH8Nj+UcgUJdoAN1ChDjRYNRAa6c5lVdK0nwUOcY/lch?=
 =?us-ascii?Q?RUAv2u/hVvYj00O3JevD1ILnM9QrLJMyTQkD3acaRKKAAx43zPdF9aYvFbFN?=
 =?us-ascii?Q?7WEClbDFIjHNRDDTtMnBynzWglJSIWSjZJ/2ASoDI0W2EeRpC7yQeXVWjmNl?=
 =?us-ascii?Q?svtewCk+vuBtXjHCRAi/h+BzkYKDCDLkWYF2njeSbx2kRLApxGrG5qQBqbat?=
 =?us-ascii?Q?gbitVhoiGRk4kvNkrg4JCMSKj2rVaPM0Byx8xwL+3grR9rxuyWhRVECuKyIQ?=
 =?us-ascii?Q?3ZerYKUITf30I3fghA0Z9wLps+3v+wdgZTbrR1x2B5jjCPAUipXONC5BGX0M?=
 =?us-ascii?Q?Be+YqrOHwOu/WPdtC9GJwmhRY90SWRfa+tNqwUlTE9jmrQ5GtdUBY0ddW5VL?=
 =?us-ascii?Q?7hJ1/6FZ+3X1NPv6KncT1A1PBq7ZCU9rVixX1Ayfd4N2oOggeYIgv3roVU6K?=
 =?us-ascii?Q?z9USxgVVrsW07fvL8Cs+42PIarSrbmu9VbBCIfx4ENqmqu5CNuwksxhJP3NA?=
 =?us-ascii?Q?MLMRh9jQ8nl25yd0zRuFM8j6nQ22U1jLxzJ56jNHrbFGtoJptWMNk7tGlyu6?=
 =?us-ascii?Q?THIpfo/S35ju+g7Dtz2PMEzQbCbApZva5Uz5J1pNvXOsnUr2p8VqbKO3PpSE?=
 =?us-ascii?Q?oKCBKppOw2b8Xk+wXIsgJPzmrET+GPjn74JlcmRjeEx0SV//2xjzuuu5cSU7?=
 =?us-ascii?Q?KFt8dgKsR0qmYzTsMQ1h0+V/8RmDLVvot1KhKrcQhDThSHqNSBOFWpJcoDJr?=
 =?us-ascii?Q?nbURuXpFZjCZvHlIFFimQf67Ry8aCczJlodDFWg1EfRDhnf0uEpelW9y9fwR?=
 =?us-ascii?Q?/YQR6dvewXv2qQesUppLn0pUiXjkd/BVhShZ45oYmNUMDDu2mErr6DR5wIAl?=
 =?us-ascii?Q?b1RQVvf+T76JBkS7qaWZz+vMA4wSDTuvk5JSgAA3zZBu7zPXq+2+nTTS9ROP?=
 =?us-ascii?Q?+SOJEAxBQgpThGLn3CjzZbis59MNINai1ld880mQ61oeRQSjO/REYr808g3g?=
 =?us-ascii?Q?h9mdTVQsyOPTkgM8L/51iHn/62S/Ivww8W94t/mxtisuh39xGQG/lgffbhGH?=
 =?us-ascii?Q?GcJ1fSMjyiyJi479w7W5s/Sb5Hifa7Q=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f027715d-eae0-4ba9-6b27-08d9e4cf47e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 15:35:16.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDC/KE4M0PPn3wwAGeAAqlrMyN5yqAkN1Mj5CWxZeCCicTqf4bbIirHtgfq04y2Nx9qJphG6oevZGDRMhF01Gs4HneXyyesr5vwPAqP5NwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two-channel I2S controller I2S3_2CH to the rk356x device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
Tested the I2S input on a modified RK3568 EVB1.

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index a68033a23975..b1a43dbeeb83 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -651,6 +651,22 @@ &i2s1m0_sdo0   &i2s1m0_sdo1
 		status = "disabled";
 	};
 
+	i2s3_2ch: i2s@fe430000 {
+		compatible = "rockchip,rk3568-i2s-tdm";
+		reg = <0x0 0xfe430000 0x0 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru MCLK_I2S3_2CH_TX>, <&cru MCLK_I2S3_2CH_RX>,
+			 <&cru HCLK_I2S3_2CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac1 6>, <&dmac1 7>;
+		dma-names = "tx", "rx";
+		resets = <&cru SRST_M_I2S3_2CH_TX>, <&cru SRST_M_I2S3_2CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	dmac0: dmac@fe530000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xfe530000 0x0 0x4000>;
-- 
2.30.2

