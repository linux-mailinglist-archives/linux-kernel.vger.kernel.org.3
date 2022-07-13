Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31100572C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiGMEYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGMEYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:24:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2055.outbound.protection.outlook.com [40.92.42.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D261D71;
        Tue, 12 Jul 2022 21:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiMEh5jOebWey0vPFbsgL4tzll7UDapm5ZVr0cX7TN1zO8UESfOOKrOQ1FYqEHlsPRuawLtPJ2QGil7b1jc+vKr0nBD0D5ui7GAnjwO3ZBZ8o8Ca327iL7jY9rr+hsSdKGzkARmrdQimkUnlAykWCaw3Y1pWQCzn7lHslwjkHQLjfm3F5fZvgiD7FyEHZ0ahCN5qGZ8tasCYp4WjSsmiiH7oIkbs9Xst4w6HYou6VR0M3eTuTCsi2iRy+bqDD6JE9Z/S12D8nI4XWqwF5vZqFoYkhiMfHzV3nU0W+Y1TORI8HdWPaWEebmMkLIWoBiToRrQOK4FrRaWM6MCJQ883nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1IXg/zNiqmj4k6zzOycq3rG76MvSt1UXRXBkHBhFlA=;
 b=bNoBfWusYvS1AKHAnHb9IvHgkHTHzwIKhDGatiOA4UyhccxJgEcYQVPjLDF3qHm8N08pDX4uOtaeSBs8sbjOYFtJreMJw/A+n4vW5dK4IBhZEPQDc6dChBohdMBpz7s+96PDJu2/VIWWkqPr3tUVF6fA2BLscDCF7YovT74iH20oq5Y2n57gY2DrVBODpP+Ry9vkYDsAbgqKaTXlv2TzCcsUNMGCJjNzNBYjcE3AejJSjlv92x40FJN4yV5wrXET8RnVPKZdPgdwr1uck7lyNNMYpDEsbifuijxCIF6w5Nvu5C+739VWbEZqiX1UXhnX2dRluoOp+xGTfqc/lguFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:24:19 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:24:19 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 5/5 RESEND] arm64: dts: qcom: Makefile: split beryllium into tianma and ebbg variant
Date:   Wed, 13 Jul 2022 09:52:49 +0530
Message-ID: <BY5PR02MB7009E1905A1DA82EDCF07F3ED9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713042249.31421-1-jo@jsfamily.in>
References: <20220713042249.31421-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [4D7qTAnLbar5hdrcU34i+G/Vk7Qz8Hptr6W7K032ZUl8zqmS8trApm/ZljF3rjYr]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-6-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69757746-ac97-450b-2980-08da64878e0a
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtr0SrtYoaNivYO/jbhhKEubxvHYLHVCl0HKhl3Zx2Vx3NpiCVelksOa1dOk8AscweLDme/RlRzWglgFJ+rbBgdAdO12OP7ICNz9/QCOl2d1egloI5yqn+RszubdmQltlAys/OYyseaJa5CRwWzDVGSmMy/e0y2jo4+t4PiI6MrfBy8iBXfbABDQkhHfFQbZM7DFaBPzaB22zZWQqTBwTzlLfs37locLeWa+yyuQS0MP+Tgn1CPHG+LgCz6fcBhFzbpuQDvrl7keiQv/cHfAN7z8pVKXn+H10F1fCruot9k57uM1lxosRORFAWlbVmqmzi0k/vBtFlXtPCyEOAbJxKw2WY6SxiuiKGS+ogSeLwPCKPU62WEc/P4Uq4INCLS4hj5rQuSXtGuYxBxzIaAzSZ+h2Io4EYgB+civdMtwtEEvGP7yf3mWsq5tI+NWqdf7QJThNYX1qjE4Oideacuo25vayr/hyhORc/jPdNJQgXNh7SFcLnELBiZPPZ4QP3IShkz4Z/XRorIJCE+gm4jZrAHBok+nBoQyK+RHVcavTbvLELC3y45+eJqKmvxxD0jgM4iO0zeqdIfSZ+7m+r4k8DLAjK50IBcadxcYuAST3riX1wQwN7ZLxBcRG11P5ihZMImTCDF8F9NgblqfPQl61FMeRnZyjtcDumrhtRyF34ybO7wdxa5Wtw+PtvXApVUCyK5pAwdd7kMnCj5iE1oClA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyxHmrfUFaS8EC4poHJJtpnehy4mTRActcVYWZ1bc6S034kJzezQwE636grd?=
 =?us-ascii?Q?G58FOeoD6Oqo15wt++cyrKngxoPTEr63+0sTNFQhrMdzvsgBQrqLOGomWAqp?=
 =?us-ascii?Q?8LWmLXqxx64ayjNJZvL73Q2yzHhBBZnPs6JT3FctSx3fXqG/yO9koblLZtt+?=
 =?us-ascii?Q?EAKI//rgAl6uZbswhCwNuQpOY7pMh7f8bwQMybWLifXo18TGeve2QSjF99Xi?=
 =?us-ascii?Q?2w41iyeqKtbAD0qUP61i1knDwCwCSJwP83sOLV/EGIPnTIvN8vUcKJpLcobg?=
 =?us-ascii?Q?OTRfdoi5muikPLtsGGQT8GvLM8jfkqmJ+Y2tEIJB2x+PVwlHCzdH5ff9kq/D?=
 =?us-ascii?Q?lJsUNvGs/HBCl6RH3XMN5fd6xv0dXAuQfboszbc6mwot/CDJkKxel1x7uboD?=
 =?us-ascii?Q?uGNs49n/pB+hrWCZOXz6EF9uIUrgItB7+VLW64tWxkcR1NrEW/dTLXsoPEo0?=
 =?us-ascii?Q?OqY4OboGZTofIGhLw8XeRj0pd3TV6XWLyTT4wYntumArigE0dpgr/9cbGT4S?=
 =?us-ascii?Q?tCX9pGhxgryp3hmx4l49iG0kYNgIfb+FjV5s/olNBWtE2fIc+nGOoqqsZeMB?=
 =?us-ascii?Q?S5q3aYsJX4Myq0+YHhsjXtFG1d7VvlsnhqiO9+8/pUPr1jx/9NKqsX3tOCrO?=
 =?us-ascii?Q?ZvCjBXaSUVRLtSls7xyMpm1m7Eyg9lbSgnJAmxpg5peRk8+VxCEyMMEnlvzO?=
 =?us-ascii?Q?IWGAtj0IDApx4tNPDo7koGZRc8au31Pu72OkWTKynMQdQjAQ8e+6VQTd0KJ2?=
 =?us-ascii?Q?YWQpz0b7Q/x+2NWbfH2BcgoVhWUWAVj2nR/Oufg/Vla4OngEBJmreCfHcMkE?=
 =?us-ascii?Q?zZvI9+TaTFG5DAqhQHcHysXpg1LYzjUb6k3D6KYWR5BTaJi2fpVeQCIF2Lfl?=
 =?us-ascii?Q?7Q8gnUe2MN8s4tPXHFrjsaKOIXJu1PZhSrmEa9NXutQHjHXvjLCqA7vtbtIl?=
 =?us-ascii?Q?zpsPDatc/IpwI+wCWE0RgVkBPgAV5+VuvL59SDRRxGO1/3qmovn6WrHg0+bF?=
 =?us-ascii?Q?ow4meC1pgwuUHgCBhjrd9kkybN9X2opqK8nqeCAQ2xG4sSL0+YPuaFgI1hmF?=
 =?us-ascii?Q?inkg8x+SaFzn7ikFLi6BKS5HVp5XIje+Qqwn1oU1M6Sh/PIz1mxR80kPZPLF?=
 =?us-ascii?Q?inNoTVRRSd6X+RY1PpFZtNj5M6T76swOdbuSQwxSV9nrogVKZxNTxDUMNTJS?=
 =?us-ascii?Q?LO6Ji6EvJ8tz3vQPJepc1bix/y+e/30vNYI8FC7Digi4a3HPPqqd2lhzB+U+?=
 =?us-ascii?Q?X5CwSZ+OiEm8pVkgy10xRvYHkoxOASAKxM+cog9TC5c3MC4XSFU8uX+JtW3+?=
 =?us-ascii?Q?dPhDy/VeOUxL+XfikR6yKOZL?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 69757746-ac97-450b-2980-08da64878e0a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:24:19.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old beryllium dtb and compile the new tianma and ebbg variant dts.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..5cc165dfbc94 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,7 +106,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
-- 
2.36.1

