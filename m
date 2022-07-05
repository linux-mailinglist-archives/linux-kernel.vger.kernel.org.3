Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB73566115
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiGECRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGECRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:17:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2033.outbound.protection.outlook.com [40.92.107.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A8F12627;
        Mon,  4 Jul 2022 19:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsWFsyOKYgNoHY1UzJj2+Re5JfZH2LPM4YR5bJph2YZaXzhNiFDHKSSo/rN5daWRoLh1C+hGh3NT3UzzmKl4oz5NVRvHayvwmC6f3xYqBsBc65KRfq2jdzYOgW6h16UIwxM90Ny8u9pkm3QNuOtAcm/kbuc1JbFk5c+fEkVobrsBJbx5eINXZ2hBUmHue4+4zB7B8LcuUSmWBcEGdd1TmLEuA06W2snI7SkBkSRlGv6y1a8XEaC7aBgDYCgKNOh/C1xGQfULdccfOdibXPpTG0n0FJYFdoOsiyErfivBadQZkUAFzhhFytGiWqOLyZxu0daHWwBRLqigbAhklM/46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93pJMAhfHO3dg1a2R1Fpw3DxqvkjeSrtUQFRWxEsj8o=;
 b=U2AcDL6tn+bpv4o7/PoFjygwrLa+I7wQA8KwncxlF+OyvYaBRZP841jO21A39WofXUIAtxRmkqm2iCPecsAEM+ReCufEzvYi+WkeJUk5hh+lKZk8YaQfTLtOcp6njpvUSewF++B25NYBQyMGlLdNIPGhaDcFRexETfp6cPDhKaofz0gEdX5eAb9IwL4xrNYmoFZzkFL7qwUxL+yfwnOpDjJHkj+qFETeTQ0EM/UTi8LY7WWDtn0SG5kHHoBiKuki52709YXU6CYySoFZmDW/ctAPnHxKpmFpg3Fv9HcWsofhOkLpusz2D1IHmVeRTiGjpzwisQqHzOf8wX/xLXjZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93pJMAhfHO3dg1a2R1Fpw3DxqvkjeSrtUQFRWxEsj8o=;
 b=HuyA/logSjNNoZSCuplRoUV5wYVWGZVBIgAWsKwmDd1j2ag12FMPHCwYDEozbOji47lpLS3AJiUjNUrBReA3EOCcMg7vD9ukznr9DqkHResowvkwGHEFyX3RNwi74osenCnqXVolSJg3kTgmC6ya/CZac81qTHgZQZxYZd/0rmyiVyTqndvpWxe7XOl6IpT/szKR/bTM4d5LQ6fxJ6DDivMj1F8dUX3xwiZGf6OUS4SR8BVKuIaTv7C7YOKnnuCQQKy1P+I2YH1vs+Pl+QDipNw4BJ93JxPtTCmwDukPGykqnC4V4haL+bqbe7yrT5hccmTOJRy8+14EeZlVL6Q40Q==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SG2PR03MB2877.apcprd03.prod.outlook.com (2603:1096:3:27::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.13; Tue, 5 Jul 2022 02:17:42 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.012; Tue, 5 Jul 2022
 02:17:42 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] [PATCH v2 1/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue,  5 Jul 2022 10:17:31 +0800
Message-ID: <SG2PR03MB50066400298F3B32658F8E19CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Zes8p96u3CfQco+MB1T3man/1ZqnNR9B]
X-ClientProxiedBy: TY2PR0101CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::16) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220705101728.1.Ie6e9ee9bf889abfdd1a44d9f7a61b62c0c5c97c3@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d21531-10f4-4202-cad2-08da5e2c8a51
X-MS-TrafficTypeDiagnostic: SG2PR03MB2877:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIOHXuH0aVW5J5bOlEFxJ1eVCflme27QFN32FfbK0++52Qezb7kJpUyRmDWClgAMjJWERGowVJpoNOWotnQHtpfVEYJRItKdZ7kkBLWcZTFQasm2p5xsjCsdnzsPETVaqHcdC10oz6s46NHFEbaL48WmoqPlAI6a0224gGbpjlh1dXh1IoU+jKdmaOjjvIMgW6MyLL9CifqzzW8oyFr01SZKcji9ChoWcimblo1u9/UyOgALU1ijY2k1MiaNN1yOJSUGnJ53Em0Hh4k+AUWmhFTgR0oqeedKHmVpYM4xO6RWqMVXDdn/IYUHm+qGEGM+HRWnE/RRSY31ka4GqN29Ew09j8rbyD6L3Mj73oMlreMvVW5sGnhyFXA/1I8M2CUYNz0exUp2xXO1aJGjMwH04lNyXOncZkcRPRHhegFskAUz91HLYsqZI8r/xT+i7AR/K/jEQOwsTvn/XRb0uOZKk99S8gOoxIOIXeXxIhXfQdOdB6YJVCOqOMbup3gnj31r6u+LNog2UlR6vBgSfJymE7/6vutBGt2TjBVKIdCgoiUSDVK9vG/0zz0zh1IXooM/iWH2cgGlL1/Km7Sistk/ozMiK9YAuZ9Q8IJZ1k5rwfpRc/5Qov7ixdNdUiEf8MQE9iigzemN+aFMnDVkQ6VnHw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FGTTB5TbLxROoRIDnn2QIYowApm+YHWrnbSUbJj6uWOpBCkKYwjdOKbUMC7?=
 =?us-ascii?Q?HWsL4emPhQqKJhLV1Byuk++TCEhjk6wH4+NKcq+jLqQZSNoooKgBtLZgAqaq?=
 =?us-ascii?Q?Fgo2OLQOz3UFpel8PW5mDinlpYXby34Vxbkf07UidB8Ne8gIf494rA17WMgE?=
 =?us-ascii?Q?K0Gdj2t8H8Ox7isKCvh0WVHqcWExJTmlFxzc16g1mE0qn51IkpAiPsVA36ke?=
 =?us-ascii?Q?9oua2bj2QRJJ6eHv2KseBlokGUB1i7UplLONzEgk7s4R3k90wcrXur1hj1zt?=
 =?us-ascii?Q?VzPblCfkV/VEq4O35Va4EdffogkFWFyIAOsDiuDiWhVznnwJ6SfvNhD4A3Op?=
 =?us-ascii?Q?x6waL/AWAB+Bmf4trXMqMPf/HjwtPRp/TGOFZyCusOtnkMSU9+DdBzdEg1QR?=
 =?us-ascii?Q?5PkMJy4prPDX84xv2laBke9tzAECw4n8gGArqK5aA2z/QZdiRwfPIzYWfLd4?=
 =?us-ascii?Q?d2lhvYMgU9qr3bLk0ds/MUaC0Fo+7UiO3RunIBAvhj9fuCN7AwXuLTbDEUnW?=
 =?us-ascii?Q?zvfZYyy9snb0RBI6prit1rDxsjwb5GHxZOP0WSpMwIl+gFKozOUSVeY03MP/?=
 =?us-ascii?Q?ksmBZ/RYjHnhoAdtf1k4trHgzqKmkxXBtWB2nC2vsovrM+PeR/vblXnWePbr?=
 =?us-ascii?Q?kmgUuyuU5dcthve8aUBQgQxaZQxkNx6qdcDf5ym4H/JsJ8Sy9/o4jazz6AAX?=
 =?us-ascii?Q?cmbkzr7Sm71sOEor5mOS5OJQvZMxB1vs2yNEFQp7wvuGGHielVI4CbM0UJOu?=
 =?us-ascii?Q?ZRVYOHJ8Hc3dAV/8TcBybkSU7PBIYm2vVhpgx6rUBJoSxjGFRGIbvrnZgF/4?=
 =?us-ascii?Q?uzAd2vOAFiouJNyO/UopgvGMxRWOJ8HIOUFjbdJZhZ81xYT4A5cMnNtCt488?=
 =?us-ascii?Q?rCHJsM8Av/hjKigK3o1NOtNRyeM5iYU49flhPDZC7+sMhY1iVrtr4dOwxgWw?=
 =?us-ascii?Q?yBhpk1BodD+Xwfm3nkB5SM/tQ0vxkSVr5NXweffXyk0NDlohfiLph6z5c2jz?=
 =?us-ascii?Q?iWsWyghaTWXEESN33Yy9dv2e2AyyOLAFrvtxvlMajAVi7jpH+1BOUGCbqAdc?=
 =?us-ascii?Q?/NihSlTO1sWZzoxhW2wil0nMtYE0CdM/ISjZIds+2LKiI5tIg+P0HfoumGuy?=
 =?us-ascii?Q?QEQQk4pz0d9VUyMFps9vGOzwlua/tSxfnL9sWfJfc9lH67UayanjW+zun21G?=
 =?us-ascii?Q?cxXUT/zh0ivkKq8tRhqncXT/ljSTVRm/CGhOZOQkeTQwQxE+qxNs4SVGUOTn?=
 =?us-ascii?Q?SbgfWBSQsaXJ1DurT9kHzHX4+MCcI4A36WqJYPptXA=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d21531-10f4-4202-cad2-08da5e2c8a51
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:17:42.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB2877
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

The format of the added items is based on the below document.
Documentation/arm/google/chromebook-boot-flow.rst

Changes in v2:
- Update the patch title and the commit message

---
 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b68..a136b1389c2ac 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -529,11 +529,26 @@ properties:
           - const: google,herobrine
           - const: qcom,sc7280
 
+      - description: Google Villager (rev0)
+        items:
+          - const: google,villager-rev0
+          - const: qcom,sc7280
+
       - description: Google Villager (newest rev)
         items:
           - const: google,villager
           - const: qcom,sc7280
 
+      - description: Google Villager with LTE (rev0)
+        items:
+          - const: google,villager-rev0-sku0
+          - const: qcom,sc7280
+
+      - description: Google Villager with LTE (newest rev)
+        items:
+          - const: google,villager-sku0
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.25.1

