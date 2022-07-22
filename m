Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14C57DBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiGVILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiGVILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:11:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2078.outbound.protection.outlook.com [40.92.107.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37419CE05;
        Fri, 22 Jul 2022 01:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyS6883C72EcsYirR2SR3UbONC6l2ymlZ74XcPDYhl0urxq7vrdLfWTjEZqXHwiv5kV8VRzWi6p8Qvd7lFKsqWUjmSv2RX9qOwLaeKNmBgt3PiXJ+DIm8BJnLzICd3F8qXpJ6KXvLR32Wpvdjk6zugYAwX4vplBMtB1TZrEgY5SrlR1VC/U1l52m4UPSOs5zwSdmW+PJGyk2+jWWT0LhVdgDR5qdT0kI2dZ5o56pqfGa4HO7TIolXoumi1Is1p35gYfJmm7nb95zEmyBClCkNSMo2O/uQvEjRtTXoFOThptnxJXYUge9aJmAMZ2Lmu701Gqy8erEWiombl1JJ4wXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6Z2oZEQwS+pKSRF+cGeRwuyHeLPAT6YASCkT76On0=;
 b=RsIyOZaOua1YZwriIBcLhXogmdE5hoazxhu9ZVmwmSFD0TNvFCRv77CSp2oYEJULVULy25y+r9ePS2RD6q+O0/JtyRhh4CQFah91psmM6SZa2r5QFRerSvG/W/+tcbxMQOBxkGll61VeEU4RiCJZtv9Olfr87BnjRu/xTCzks1PoR3aBVw3kjKKY8/0vLuoCnb4SLr1qxHFJUaSjE/cGoujzNaHwFN+LDlMcY3QLGd2tLp75CxhD9TCSU4NfRtCIorTCbvE1XPihI09daxnY7/uzMd2owksgxEwcBtAQFGQD5uMepves0o8Vy0dgex83ldk5qUB+GzcXk76G9GGl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6Z2oZEQwS+pKSRF+cGeRwuyHeLPAT6YASCkT76On0=;
 b=IkUq5PNfuRQY0JBNaTcjAEYJYuuDZAtWirmaDMUjn5JerZ9eAlmVO4X+fkjqk0as5W23tvcS2FcqLwsCzcVFEODuS9z0Clmr2x7szAeRM/OlWGwUU/UuQGzA/scp4tlPd1G8XthKsPOlm9RM5BGMi5Ci9UwEpb9vsKQtQiCN865ygTE1A+yC76tYjqbqcbccpstM95dsrCyrZjAI+5QYBaWhh8Qdx1/jij3fH0hecZ7ClEw9z/dJolyB7yFRPkadi6XN98J0Cp7ecMwGKqa6aUgUN8obVUvwSbJlLVCQEZslFIjxyUcI9gLWiBMXY2FlbMe0HIp8+yVhsCbdmdXZHw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB4889.apcprd03.prod.outlook.com (2603:1096:300:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Fri, 22 Jul 2022 08:11:39 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 08:11:39 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 0/3] Add new board revision and LTE SKUs for sc7280-villager family
Date:   Fri, 22 Jul 2022 16:11:24 +0800
Message-ID: <SG2PR03MB50065D57C3D89C39FA90AC08CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FPDRIrxEqtRqu3F7y2QNYmVTl3BWocav]
X-ClientProxiedBy: TYWPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::13) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5091fd93-f34f-4af2-0d9a-08da6bb9cd20
X-MS-TrafficTypeDiagnostic: PS1PR03MB4889:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzPTxH58gpPg+MLkAngZG0JrkcfjL2f/pjMLX0W3Pp/aSpK2Pdx6O0InTL80j5xKyw5skoe4cBzI4KozuF6sANOPyf/nWus5zr8Th/VOUBk1sj0/aTkRlmoGASC2SqPm/+bg7hNiRc8h62f9hnKGOctpp11cPZUjQ3colMpCnA1F2RHlsnsvUkCiTucZbb4WsMjxQEw28MPNMC+Im5ILnSsTdQhcnE9q9oZr9/S0Hsp0jVgJ7TDSUgooYrZ7TWX/H09K14yuaLcU6TUmlfYUuqyN2eRCX2Yh+2rMSnIYTu6wP1cKsKvOBU9gaQxY6ysRbl4nl0ABd+9Bx06cFMFcp07YK6bX61phcLxEJaqNqg+QkmsglCQDbSZ4hLgcFfR3C6zS8ndDPgbUxnXOiD/CG0YWHpA7BfzReFoBONxlFsExYEsndcHFYBdFBA4ptYFOpy4MJVVwlVl5HoQI2ox4qWpfDR83ubVch5HUkexdDS1g3wLPueKNAB8fqVQM8Y0oJQdK9uesJmyYtd3qAnNBVHlvvwLMndqctAk5BWxPItOBySwBqC7oYzmiChL53/uZPp9ITNuaItIiFcxRqnPMtJquyc+3xgH3SeDJjmDIETV2n/44pmHNj4b/Jui0aX3GnftsyMCVHZwmse6L0UYhSDobVOVPqJ/3Ja6XrG+IX+c=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Gy8XtNVT/niMstDxpa6NZegnBJgkzbkCd3pTB39ase9KTggjJYkBaD+YwQy?=
 =?us-ascii?Q?ZjnQwK3x5uIFEKBA8tMLHW3UH9lD88c1pnSk7rbcBJVVyit3p/t+Iu+6YoL6?=
 =?us-ascii?Q?rwC2QvL3jm7lWDrV+hmU3V2GZ3VrUDqTzYEl7JpCKeC2Su7sPHErNT1j2Zvy?=
 =?us-ascii?Q?YPtRkwyecPYu7M3QNcGKXLq/WIBzpaXYSTOMn8ZTL0pQDld/wxe8NhBZoAPx?=
 =?us-ascii?Q?pPdvnFmKAE7Bqr++AF8VHJcU+7dBHaKKn38skoq5XC+dnsZlBTTRSZcopHLU?=
 =?us-ascii?Q?cApDFduTGjd4QkEAmzai1w+7mCczg8MpqI9r9zhD4z2rMVdojyy04FVXKlp5?=
 =?us-ascii?Q?t7ouNqTlrtd/C9gdT7TaHtmQDULQSmpXk/w4EPCp9WdpTjsWanCenva5q/yW?=
 =?us-ascii?Q?hE0G6mlOJ77raWDW0ZbrONi0AOWojRxASk7Q4+KS+WR9kDLgdcA06bRiIDnk?=
 =?us-ascii?Q?2A1SaHeY63CZR9K0xahv2Li3rLZ6pOBHTAxNz5R7/My0gd9qssDOAFDE+rTX?=
 =?us-ascii?Q?/LiJXI84vTyNTGS9ouOs+pbVGHSZgu8FuncIcmFr9J4pFaU7BQ+0celfj0K1?=
 =?us-ascii?Q?jW+eAEDw69+aFHl18pdbsiP/zVjoXafsc9kDcT7QPqxjGlaCH6pu8WVMu4mR?=
 =?us-ascii?Q?f/1w81gobE/6wkyPnLJ3vLPLOAgPDmc7GyieVpMFXk/IlfUsZiY/bKr1ZReC?=
 =?us-ascii?Q?Am1kmuNysXdIwlw/MaQBY71mXC8aBeLW18m+Hh+1hoqgaHDEi6DTaj4aoibz?=
 =?us-ascii?Q?dWIEilIBpkTime+pQo417KGFZ6KsgR16xBcBbAG2K44e/AVqVOAdmPf8s7MJ?=
 =?us-ascii?Q?vJyVARKhXb55ZeEEIbrtFIGuiCMExl53CXlZqt9HrnNAX/YX6yedCQS3WCEp?=
 =?us-ascii?Q?KyfepJTuTegm/xGTP78VjM7Ihh14dK5uOQW0wHeUQ1xxFP9hDAKB1niY4cWc?=
 =?us-ascii?Q?o5230P74eYNhR9I9sVw8ffcflJdcMYRXIeBZa81J0fcUxtZjdNjtE+3CFtms?=
 =?us-ascii?Q?erX2xsqrNiRZdFgKZd5E3Pg6OL3SYihj7CjWkSxpnjVgN7wLQRw4nE6FqERv?=
 =?us-ascii?Q?uCwoYvjsh6w5sLz8BtQTACUKSLk6GV74wTknzdwo58q+elXzHAGIUlH1hWoN?=
 =?us-ascii?Q?vl0ZPJWt5IMkBOsTMDGyjPRqtQ1zM1plNn0qQE3dIBUh36tlMSH2ckHaiasY?=
 =?us-ascii?Q?t2dYz2zkPbmO0ojjno3hI2y68ylxnms8w1XyRzRuXG+scAx5fELnSPwZIyLU?=
 =?us-ascii?Q?ZhoTf0cs3UASlX6VUGMpTXL3U8Inx8BFX4McX9qtQQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5091fd93-f34f-4af2-0d9a-08da6bb9cd20
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:11:39.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB4889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add a new board revision for device Villager, and add
new LTE sku for both board revisions.

yaml issue has been clarified in [1] and [2], and 'status' has been
reordeded last since v4.

[1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
[2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/

Changes in v7:
-Revise typo in Makefile in ptch 2/3

Changes in v6:
-remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts in patch3/3

Changes in v5:
-Update subject and revise Makefile

Changes in v4:
- Add patch 1/3 and update patch 3/3

Changes in v3:
- Update patch format

Changes in v2:
- Add patch 1/2

Jimmy Chen (3):
  dt-bindings: arm: qcom: document sc7280 and villager board
  arm64: dts: qcom: sc7280: Add herobrine-villager-r1
  arm64: dts: qcom: Add LTE SKUs for sc7280-villager family

 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/Makefile               |  3 +++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
 .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0.dts   |  4 ++--
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 11 files changed, 82 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

-- 
2.25.1

