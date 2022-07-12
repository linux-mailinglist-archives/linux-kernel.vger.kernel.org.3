Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C215716FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGLKQc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGLKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:16:29 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A911AC040
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:16:28 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2046.outbound.protection.outlook.com [104.47.22.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-j_2QKmRrNkyIPOalFMeRSQ-2; Tue, 12 Jul 2022 12:16:25 +0200
X-MC-Unique: j_2QKmRrNkyIPOalFMeRSQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0165.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 10:16:24 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 10:16:24 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] dt-bindings: input: colibri-vf50-ts: Improve documentation
Date:   Tue, 12 Jul 2022 12:16:19 +0200
Message-ID: <20220712101619.326120-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712101619.326120-1-francesco.dolcini@toradex.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MRXP264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::31) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96aee72f-03f8-4bdb-01ba-08da63ef92e7
X-MS-TrafficTypeDiagnostic: GVAP278MB0165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: M0hd6B2y46reddcadtJNv7LDQ3i4jl/sORKx14NXwtllEQLHeUgvXlBI+mSg7XxjcWTgBZ4PglfOZBcowtlDtAboF7ujN4wwi8WDcexfJTZfAZrtHGlunlQP6rrWoEwpUtHNDLkvrCQgz2O2qbGyPTCTAh5vUL2yJyMJNnRfJIOq9bEygCwQbLcRUFlbZMavd/DGphYSVnD3lbgT65QiEAZBOsz77mf76b7UFXL9lI5StnmA7nCdcGZFGImMPUyKMG2w6sE0rIm2bMxFSOc+5GUN5V8XPQfbOHmKE6zCU0j+N0OVWAM2IOB817WPCo1XLDh5iLWTiY3PrD3IML0KjgpDWmJEuMiYf7hmjRzFO8xVTi0Tl1vXSx2B/jjZLQU2ShJflwrCTm2qKzTa1ItiGF//8nWEJJ7WQ9nrTZlM7vjrsrIuF3gwHcJcxoOJm7+BrOqRiynaHmSHRAaZutWYDmcGv5q5cFGTGQFUlPae2CnIT8Mn5UaxLoPZFKH3tODjHNXif+MS2+NuT9mE6knLupS74DF/03+xBr7W/UrQQ2R1K59OtDfklTRt/+KPo5csqn6+zlpe/fdROPsbnUZ6PYp9Ke99CPMVleudFkfHpVjSo13qA5rMuVrmQwvVzL7CeMn1eL1bons78Ig4iThq1qhl0f7N+UKWjmDr0eZ2/CsMEBDNmy3QzP0acLlmtyUpSieAY8Yl3nnwJv1DmsMH/7bocmGgA0soRbcEEBfWMdvrH5yRj5mCtk1WwBux00Qp+iDrNbS6Tee/9MqvfCTPnvn7MKndEAc591nGKABUMO/HO+Lnkhr2PHflNjTLW4Pz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(5660300002)(8936002)(86362001)(26005)(6506007)(6666004)(6512007)(2906002)(478600001)(52116002)(6486002)(41300700001)(44832011)(38350700002)(38100700002)(1076003)(2616005)(107886003)(186003)(36756003)(4326008)(316002)(8676002)(66946007)(66556008)(66476007)(54906003)(83380400001)(110136005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtDo2shKwCQGVq2p3jk31FlLoWIdXrJdSLVP6chDFCheOBjqX+vOtZJqyWLw?=
 =?us-ascii?Q?JwXCwkqjZLUU8m+VMkakgOkNURLPFTcSBx46e0Nv54WMP+6Y4YG+rDZ6zBzT?=
 =?us-ascii?Q?f47uKiTXXqP3FejL4H9gJnEnzfHlFodBufIk6Fq2BnS2u+bzeSVvPcIxrX8n?=
 =?us-ascii?Q?lldEOaZFyCyt3pGC6LT3D1eOpGWGeTcoZLpsZF7cV2fqqZWDV4uHu4jInP/L?=
 =?us-ascii?Q?o3Qc7Pz6vj51ygPlrizT19olDeZwvxwTRbDd4B9M7UzWr5rm/jMrcqSHmp21?=
 =?us-ascii?Q?RfxVraeTbYe68OTx6JfwoLCeC/kWB72MH8zp/k/5YDEs6oTGViHCUQQjZaGT?=
 =?us-ascii?Q?ICYNUBhn0vLdBsC8we9PyK6lQqqSq/0PsUQB2X8qAWHwZUbC4btM5iFWLy20?=
 =?us-ascii?Q?ARY7oggcw2L3j1he9oqFEg2PpF0OgY3Icnz4kQhnXNtxT3pcMKhsx/6Z5dAq?=
 =?us-ascii?Q?8Q/xZHmEup0OueHvbnycKaaZfgW1rEzF+WqDL4rQBTmh131bcbLFTO4XjlCq?=
 =?us-ascii?Q?3yCSY3roAyzFGA3zSVRDekx2TYUnjJXl5xzWRVW+x2a/QVcC5yRj6e2FTzSs?=
 =?us-ascii?Q?RtwB7eV7r8+H2N5u29prZRhCkJ6Em5QrMxnU8UsWfp+AJLQnCH0tcclXP1gM?=
 =?us-ascii?Q?e0LC3Qb6mPzDOFp6wfs07SyRxB6QUIkU4QBSEjUzFXLbBdD3lQd42EpX04J8?=
 =?us-ascii?Q?oWspAz1XjkX0a80wTHt64u//o90Y334h49qgJmwI0I9f6Vd6E/z8z/Yl4nk/?=
 =?us-ascii?Q?c8hvFbYv8OdzNozFPZs+DttdqcASScz2rB+Q2KL3ynNRf8Sr4gHIjQTo+XFN?=
 =?us-ascii?Q?pmb0Z965BLT6L8q0olE0dfT5bQke/sYsNWI8rF0zuvytql6Br+3q6Mf8M6hz?=
 =?us-ascii?Q?r6LO8OTSoN8vaZ890z+H86j1PHeVrDK7kskPCaq4ZJwbeQSQj692EXrjlb1j?=
 =?us-ascii?Q?iXY6AK8wwMIiOlP/mG+KWvhraEiLpBl3RJpEp48Pbd+0wZKqo1Jl0NYLVu5G?=
 =?us-ascii?Q?1P8n9SxvsPzMXln0LtlBfEoGMutwCD7ZlIMIuYag02afXPh6ZnfbV0lTq/1M?=
 =?us-ascii?Q?FEytRhrXv8B9BI2tYvn9SSc8J5cbaSPIY7dTftrcrzINHzHCAKcbrku7XTR0?=
 =?us-ascii?Q?KnOtAZ//JoddzwdMxtis4JCgQZJFtppmsVZSE/G/fm3lGxJdb+2jW0un4nXA?=
 =?us-ascii?Q?NIIaj4z73o8nC08O/c+SVblg+y5WqxGOLQR8fzAFMtmCmG13cz6DTJ+0qTK7?=
 =?us-ascii?Q?ioBS72FcIY9Tmkpb0sXCFWCiddVeJL8blK8rCuNXvfBv0cYNFYUtn2ShfnIn?=
 =?us-ascii?Q?4P1L2TNscVUbOftzPVvo3RfxegJgwgDUzNCUIA3RVmiCmhgD9V9cZU15HMz7?=
 =?us-ascii?Q?gcBxs/9pLIyMjGewoKo80y2mO1n6vgCUTdcQn9XGJZ5NWpQ9wxebTG6YBXug?=
 =?us-ascii?Q?T+VxgCj6R/BmEaQlybvfMRejDwvEwum2dXI5oD1zNcYMDPBfvEIeJZ2RFy1X?=
 =?us-ascii?Q?nS3OBdkXhOtxfoynhAIJmRSpvJ53Fxnc5h1JMAYD8reWrqBpB/1EB+3mvJWG?=
 =?us-ascii?Q?765Wltb6NHZidnwVb7LouyZf586W5+fZ0NYcZqK1PHdBOqxFsQWj2z4eHjqO?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aee72f-03f8-4bdb-01ba-08da63ef92e7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 10:16:24.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kyKydSbmY530u4a08PWptI295F4phB9E9m5RorYtVyzdACcL9Unx0i16LT6lw42qJWT+QybzxQWuoEWyecAAgi2/+ZQnnUgIWhbcwedN8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0165
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Clarify properties definition, drop unused pinctrl-2 state 'gpio'.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../input/touchscreen/colibri-vf50-ts.txt        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
index 2e1490a8fe74..ca304357c374 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
@@ -3,15 +3,16 @@
 Required Properties:
 - compatible must be toradex,vf50-touchscreen
 - io-channels: adc channels being used by the Colibri VF50 module
+    IIO ADC for Y-, X-, Y+, X+ connections
 - xp-gpios: FET gate driver for input of X+
 - xm-gpios: FET gate driver for input of X-
 - yp-gpios: FET gate driver for input of Y+
 - ym-gpios: FET gate driver for input of Y-
-- interrupts: pen irq interrupt for touch detection
-- pinctrl-names: "idle", "default", "gpios"
-- pinctrl-0: pinctrl node for pen/touch detection state pinmux
+- interrupts: pen irq interrupt for touch detection, signal from X plate
+- pinctrl-names: "idle", "default"
+- pinctrl-0: pinctrl node for pen/touch detection, pinctrl must provide
+    pull-up resistor on X+, X-.
 - pinctrl-1: pinctrl node for X/Y and pressure measurement (ADC) state pinmux
-- pinctrl-2: pinctrl node for gpios functioning as FET gate drivers
 - vf50-ts-min-pressure: pressure level at which to stop measuring X/Y values
 
 Example:
@@ -26,9 +27,8 @@ Example:
 		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "idle","default","gpios";
-		pinctrl-0 = <&pinctrl_touchctrl_idle>;
-		pinctrl-1 = <&pinctrl_touchctrl_default>;
-		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
+		pinctrl-names = "idle","default";
+		pinctrl-0 = <&pinctrl_touchctrl_idle>, <&pinctrl_touchctrl_gpios>;
+		pinctrl-1 = <&pinctrl_touchctrl_default>, <&pinctrl_touchctrl_gpios>;
 		vf50-ts-min-pressure = <200>;
 	};
-- 
2.25.1

