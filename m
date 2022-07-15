Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C2575DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiGOIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:45:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2024.outbound.protection.outlook.com [40.92.107.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8074C814AF;
        Fri, 15 Jul 2022 01:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW4w1OPI6D+KKmOHAFJr9YIUdXSkTwfo2v1aXMuuhjkuDUgxzcniaQOns8XU6ckJ5VTkQ4w0wIXzQngh45NxhQ0wGIhhPCHOeITAb5mcaqKRS07/X507ZYosxtQShRVfkzixhllTjshdMZu/3cqn6vwjPG8Eydc0WQSVeXa6uE8eLQnStR9lMIUavs8LX8v62v+qImlGfJVl0EZ0PyfZUZyQKmI+dfWFymddpz8PTzHJ9z8wsdevUiZ8ts9W937Ah3PGMvLLOEwMotYFW5GRYlem8Fxpx8QOwBO0gwZGLOE02e26CZmv1jEuCSCoAYArmbm5oZhCVCOQ2xir+kBubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwtdlGY9kDOvw43ujMDCLhdsTvmkiB9923SmQwKsWxU=;
 b=UIv+n9aBkNm2dUEe1Yd0WGrXUiH5SbjsgbyaZNO0KDfoeS8EmGzpnOHNiedG+MormvV7SbFYAinzIjecJgDJ6z1H4BkExSgMCrxk0abE+igJ0/EG2cnuPHcDMDvkUEdl7JWQilPkwdl3VUZanPejp1UtR0qeD7u8Bf7UUG7W3fRMVIA4PV+m89GWVuwbTiwO7ppiEWr6p/37zXE0O6rFJt3vtMct/L86sPaVMQlJLeFrb0vYn+LYQDTiofDiO5BQR9oab1aObbucs036PMVne4Dfn8y2uQUYX9oAjeGsnew8xIfmce4DTBTMujU4iMZXQhs00GZlqRDcq7B2FVouoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwtdlGY9kDOvw43ujMDCLhdsTvmkiB9923SmQwKsWxU=;
 b=KyS7AW1g81gOpEKtN/FxwdG6w+o6p7DH3j8AXgK8RNnhUo1WIJmqzVxUKJLz3z8tjdffeVzM+ljxMZL+bwNeB2Gt/DWTx5/cR/uoha+RPJ6jPx+sSlX1AfSASTy7bw/z28SkUEjU2fgxsyXnuPcbmZxrZ2ErZKlgb7IwkUi1JioPnRRQ4IIGc/Y3TSqzY2ok6lS592G9qhAMgFJeFV7DtpcfdQRkd+bdWluz0YYhsoX+mLui1Tsq1zw+0iu5kgaOzhS/FhSZ6UNqJ0bDAmvMxxKv5NC2QI0CdXqzr8dWcXejaOJTvmY73gWvHtxPnOiuIbLOxDSsnvPOO4x8kEV6qg==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TY2PR03MB3421.apcprd03.prod.outlook.com (2603:1096:404:31::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.10; Fri, 15 Jul 2022 08:44:54 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.007; Fri, 15 Jul 2022
 08:44:54 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/3] Add new board revision and LTE SKUs for sc7280-villager family
Date:   Fri, 15 Jul 2022 16:44:39 +0800
Message-ID: <SG2PR03MB500650CEB05F33953972C162CC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5Y83nVPQoBLeVAeygEETdsIZfRK6gA+b]
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e3876d4-d1c1-4198-9da2-08da663e4a0a
X-MS-TrafficTypeDiagnostic: TY2PR03MB3421:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTL3/6j6yb0Po5fuK2NfZtx/uYfEEnmBvH6uFnvorQugDztejPvyexUD77xBEIQee8IJIdd0vZgJpODxXFv+rsKPRIiT22LsUiM0b/7AJblq7zluFeS0Q0AwqT3oQN4R/qvYrrUZRmXCNiihj0iAD9Yo1LRSufGlqEEX792OFoYeofhPSEUsyfY43PTQTJcSuKM5k04CDY2Xfj1puAYa/ierwgACGpQykREMC9UTm3ZSHWawhhhbGvr1RT4wOz5aaHmrD9OKKsDizCeKutQ2dItcZJAKNF5D884YZbQAp+Z4BZQRsrbG9ynLjEIzgvJa0TPFbkqer0Q9gvS3cIROZ9xGGx487t7pHs72zzhqoNYzDMSEN7FV5sFZE1z7kaFFcExi6lxfeHQ23PtLozMuGXzf5fAOLcXr45I2QFpE8Emn75GntjNZPkpdfzlOmE4ISvm/LuFYXQq44hBk+KjJGOkdbUzYzhM9cDLhKmT5rPKl+N6vABJ3DWplsse5+SVWXi+gZ2KVm3cWG+uiRNqxq8q9KYvwwbxwn6pFhvRyn8elhQPFJq4a1JMm7Pl9SFe8Tul3rF81toF0aB6zY1EwLakAhkx35AL23KTZk+rmtqKMTGGsSRuhsInkuvirAVpSjjJOmYyqNkNmJ3aMgD/G/zljJRzstPbh1/l3Z5MLs8dIIqM6CQ5YszhEixh2hCbE875adBPTnFz6VZION1XcGVNNJGXJ0sFJHJdTUIkD8PI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrHm/UN490nBhX+da7B3tGiBEPGXJYpSvJv27hL2TvJPU6zNIkP8qPuvZLxV?=
 =?us-ascii?Q?WxucM1Hbwwd0UUhKcTMRTf2BH+gwZp69KwymmSfkF2EJ4xm8cTyiV2pY0TKR?=
 =?us-ascii?Q?iEgCBxYcjckzAW0sGj+BqFdB/oJeR0nVFDZZ+5G6aDpfKjvnmpysBOCwXr8h?=
 =?us-ascii?Q?KNNlIke3qkzmrcjwD2W9QvajaWN9+VbG+Lq4SERTYlboJjzjcE9lpzgM5OnY?=
 =?us-ascii?Q?ikescb7m0FRV3qIm7w3wkhReMHab1V+jf2uRLflRYFf3Rml0KU8Gs22kBsX0?=
 =?us-ascii?Q?R+QyxDpDEiQZdngrpMX3wfFYmXrUfdvJpTAFaxyDIJDeFGpEpU6wJAmMCZrU?=
 =?us-ascii?Q?NnMYHoH3v4tlV3GqjU1RRlEoH8EjiLpvqxhW5VTz/MVBTmbl5ji1+CVvAKiq?=
 =?us-ascii?Q?pF91L9B65d5X2kwNkTZCkYDtO/YpWZnehaM96904CaaPinO3Y7LWpgQ6NV8s?=
 =?us-ascii?Q?lj8ceyoZCSaGb3pqh5w6TwPzStF56GMwWWAN/nODphFeOfUJexQBKrJF6Ty9?=
 =?us-ascii?Q?In9VPvlkiUk6iyyccSA31j+SkylM6nB7WTihEg9Ba/dVEdYqwO1NO491oVus?=
 =?us-ascii?Q?k3rfafiVxMc4ZRZezH+g6+59T5X21uzqtjtIZ5ZCI45ihmdIT0yv3qJy0qb9?=
 =?us-ascii?Q?nDHC9jS2Aywumvwnw09CVnXLs7XpvsVA1CV6aMahopoQNaGdZqUJbVnBLoTl?=
 =?us-ascii?Q?Ib+yWiDqE2/FLmtbME5E7l4oWTYViiyQkbp+ZlECKU/Rk6UzdALrZ5r/vfYB?=
 =?us-ascii?Q?eJcgc5jMi6Cbi4TUbJ69YlJ4RQ8QbaqsuYNee8wE1+1GJU/ZD08ilimOF2xL?=
 =?us-ascii?Q?5/LaX16jZO38LZCfEGuawlLKAB+PwUyfub6BgVgOAT00MNMAnl27lcmldEea?=
 =?us-ascii?Q?0b70OVKgHtUXUxfXsCtYuG7cOIi8NBbtlV10fvPi9hlPWd6AANMwL8jldlNE?=
 =?us-ascii?Q?mPMQMr6bIa12DO2SUajImLsJQnDPjH324G0/dblglOa19hVexUBYo6tt6lQ9?=
 =?us-ascii?Q?E4KgXjtlMxY3JH+jaEkeo3ykghvV5ZLGDHfMGLk1drF4eKJip4ok0xZtfEUu?=
 =?us-ascii?Q?PjJX5hL46uFK5viUwOeOo6lXFAG53B7IGgcDt4Ol+pxs+Hf4W4RqtXn/uM8P?=
 =?us-ascii?Q?PWx2KK+n8PzR5/JFoqmH5ShrkIeBWWip/+OUjvdsUeyinXFjlWc4zZtiaC2N?=
 =?us-ascii?Q?wwhJUmbwOkaGNaROyjs70PWIAQ3Lo5eFblxIumRBZMsfQ3e7+duKUPcbh0LS?=
 =?us-ascii?Q?82FlFVAl+nEC4Af1TgI1MVnfZIgp09CSgKhNkKFlnw=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3876d4-d1c1-4198-9da2-08da663e4a0a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:44:54.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3421
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
 .../qcom/sc7280-herobrine-herobrine-r1-lte.dts  | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0.dts   |  4 ++--
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 12 files changed, 96 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

-- 
2.25.1

