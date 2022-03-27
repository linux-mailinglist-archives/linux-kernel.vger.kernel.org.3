Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8B4E8935
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiC0SK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiC0SK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:10:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2024.outbound.protection.outlook.com [40.92.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308934656;
        Sun, 27 Mar 2022 11:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5wf/+W+9wFIEm4fr5QhC4ywC8Hw4FPJ+VpZxHAZdBwIpDD6KzETt193/OnIHIBk/dzWkrMU4BkhZm4A5byNPToVf53O8mU+fCWkuTQijkS0JT9wjcSNsp4SbPxohATMha3H3F5KZlcCSFjU5zr879XLKbf8kh1mRNq7et5HIlhu3mDihyMeDtzvCiiissziuOZnKSXf+Na93ScUPqjYpwr26x4Innpk9DAru01oaA+Jub/SlUgZtdyUB+nOnxSYeuXuUID7fzKMxLW57rlNQk0cLERTFPp0biJoYdxoVyFUnOKMiHfNPl3JnXSSOBvMFIsL566MiJeH39GTel6IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDWbkechiUts43t6wdEreqPDHHI83SXUQOY4PCkZFIY=;
 b=DBWQB86kZHqAvZdvsTn7Htc9llA7HRI4gsMZzMOEe6iYlay4Vr3Pw9VKwk3EJuFlvYdGA8H8Nr0m/++WQCBYxpvNUWVAcZUrxKe1NruOBYV51DaFityXzNUaBHTCQuk5dOh6Nm3wb+iApF938ZHgiAxTnMcrNp9YcDjWH2fgcKlXiemElZ2Mr/slAVq4k2qJ9AqWz4psKITo0kjSPaNmk3u+gUmicqohKObTCe4j2K8oKdQo6gt51wK3bf5blmEUBOLAKA203vNnbEMuctWHmgaeMevgDp3rU1788cE9EUq7X/A3KmK4xV6yQnPq5Kipnbteoo7h3VwIuvRKcb4gmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN8PR04MB5778.namprd04.prod.outlook.com (2603:10b6:408:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 18:09:15 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 18:09:15 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 0/5] ARM: dts: s5pv210: Bugfixes, features, and improvements
Date:   Sun, 27 Mar 2022 11:08:49 -0700
Message-ID: <CY4PR04MB056763D8667AD2BC418B7026CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Eo975Aw8e/dQAFcwK+fgKEDSUZWwNn7oTePv3IqWxr/i3AO7Fzr78yTJgF6up4UZ]
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220327180854.4857-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1385b75-abfb-4b1a-aba0-08da101ce712
X-MS-TrafficTypeDiagnostic: BN8PR04MB5778:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u70eNHGRgbDLZ3MvjntQipQaRK9c/qr7HJjVmLROhPtImzVwJK6FHddO6shdqTCN+oKHTMvF2HT0VmoZ9O/X0DKJQvSAOb+kqDE3rQ/Y6wnJZ6Ti6Olr5MqKM1W0LugXLhnYVIRiI58Sb2y0yKNGJX9u+IxWqnF+Txqx+Q3Ak1q1z24jcCyjfkOSZNArO9b/cRIGv9BD8cXU+/iBQ5Sd4T4qRsNBm9UZGGWfvCyBZ3CxlMwQThb0MLK3JmdzyVGljeKQWR2Z1/hGuAxAvFxwmR/TJNuako3QWpHmb+IMXhuESsBDeJ3n/cgV7rBCv7ieHdJNbvfn1ft1OePXXXa/00Rf29ktlJ65OvYgBg26wK4HMN23Yg6vHJAbGjYrTUA7qoxOGexoDq7/qnl0uIlqF8ZErJE8IonbVM158aAugaJ73/uMKcnWm9ABmU8u9lMFtvHlu8h+AKwtnzUHUT5h7p0KWmYYcQrk6XUGRnrvtH3DdD1N/Gwbks26wErNoWnD//vNmdiVDdcq1HyZFiMt3U+VlYCSQbz4893PVAWc4Ekd/MccXUSYCLjlbZPCwcEy8yh4fYjyzpV6gDgomKr/Pw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vauFwV9fLxVIc08+8K9ttrmsBQgSxzv64xDjebCx2vl6FoMZuv7YZu3EolbT?=
 =?us-ascii?Q?fatyVHW3My5TzL9qvzz0jyCh1+d7wanZwmZBam8uAEVaH8wvFB/vuZFQDKro?=
 =?us-ascii?Q?VlRSW3poqFvrDk3jKrlouaiZ1dHWINY7IP1p8e03dEf+/OhdzXRjn49faiYn?=
 =?us-ascii?Q?x3zId3jFXB350t+roSwUaDGZbL68YRVTD1OB4B6gDv+jZbv9c1epbx11vGdD?=
 =?us-ascii?Q?C9ITzbM9Icd29nrOR1Nf5UP/dULSGmfAJXDKpMRu2Kj9QcuL98XmV+l5MAiF?=
 =?us-ascii?Q?6oJ7hoVW8HJni14NBnAS9DjTKw0DgzMAIHcOY+IPaPhINOve6NeDtJGhKx/w?=
 =?us-ascii?Q?9bAKaIJfyakQnEtR/nQmCGrk1S68ppYL50yUn3WQ3MbOO3tdx4rTqNDGImD6?=
 =?us-ascii?Q?yopZEqSZlZHan0bhhVW9hA+Fq9yqLe8rD1ANx6TKOlLD7CzdMy81BZMZpaHm?=
 =?us-ascii?Q?rTHyJnO1NGDiTm9MupheOaWhoV1BFvlefPNZzGx9K2KDZ88rOyzwaDAgEUeU?=
 =?us-ascii?Q?DehdzJpuB7PWOK8mDy2+4T9bm+laEQaCWFGoqq85F0hF13ZrAk0ViNlfPNaE?=
 =?us-ascii?Q?n5D8EUK0QmVtwDHAU4m2w3KGikVkxCN7tqat7z2N2k5Zt0VhWq2oPSux6rgP?=
 =?us-ascii?Q?5ecoz62B+3RrebpY/yyD0lfqIjBOOOdPR3nenlpwGfUg8uHdA+jCVlQ3tbe+?=
 =?us-ascii?Q?TV7dSplw8mwGkrqtPv/njOuY2T67qO3nabNHDVIpt5vci3BOFfQPkDsFEe1B?=
 =?us-ascii?Q?nUNahh9/xYjEhJUqtQPAD0GDUD8r06CVeGvpncxnV0h0+O2/JnsWo5zMINgu?=
 =?us-ascii?Q?IGzKQI3Piy2ubD84kuBpVl/cFoTdPapGIj2AKzBMZCDhjSFestWF7X2DvPlq?=
 =?us-ascii?Q?6YHbvMo+S9BpP8BAn7wgupHACGgiDyYEjs0QIYSf3eGDFUDSjatnjdRU9eBX?=
 =?us-ascii?Q?KyeJuaOzsSyPPYs3aSza+aNgLx6gQ2Y9/N4rcObRoijocqTpK+gkiBBwVgRC?=
 =?us-ascii?Q?iZlfsP+vE8I7K3FJh0+/LUqchbGhU01f6jd14apKm9SLupbm5g4A5gtdbSH2?=
 =?us-ascii?Q?svfLy+56ESKA37HBckXxQQqS3vqfjLJTyowZ2fYuQ+PjoxXZf1v3Xv4qT2TN?=
 =?us-ascii?Q?ettmmUKrIkx+wPmsMU2AjP6CYvQ6GmY3vUm5XEuGT0+qfixPBiNCcjETxHW1?=
 =?us-ascii?Q?Vo2Cs/pSeo7r91o7jM9xjmGOcVymXViKLLeUorSId+74MXR7gILeCVqBKMUz?=
 =?us-ascii?Q?wfOBUzxvspKETah11SegmCTzf1bBkQqbO5/AoLiu9aXJPrA3vQqJG3eldnLs?=
 =?us-ascii?Q?kM+ZZmD++LRCGQWc+Ix467S04ZMOQCoFNLHF58BROKkCaPT/1poQE3gwj3mF?=
 =?us-ascii?Q?GYOHvbNTAGrpHhQzFbQhJPUVUEmIoVxPj7rhNU5478fG+NDRI6Lu6DIQ0qZv?=
 =?us-ascii?Q?VadNbMkjbDAFCXgvQj+m2aAprmXBwOOMbWxAkwHLcVEFS0F41k+WyBIwgb8l?=
 =?us-ascii?Q?RJozV/t0W9r+nUU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d1385b75-abfb-4b1a-aba0-08da101ce712
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 18:09:15.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5778
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups to fix warnings when running make dtbs_check are included,
as are bugfixes for the panel CS pin and bluetooth interrupt name on Aries.

Changes in v2:
- Re-ordered patches to include bugfixes at start
- CC Stable where appropriate
- Drop sound-dai-cells changes
- Drop charger-manager and related changes
- Adjust memory reg entries commit to retain one node per device

Jonathan Bakker (4):
  ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries
  ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
  ARM: dts: s5pv210: Adjust memory reg entries to match spec
  ARM: dts: s5pv210: Adjust DMA node names to match spec

Krzysztof Kozlowski (1):
  ARM: dts: s5pv210: align DMA channels with dtschema

 arch/arm/boot/dts/s5pv210-aquila.dts |  3 +--
 arch/arm/boot/dts/s5pv210-aries.dtsi | 11 +++++------
 arch/arm/boot/dts/s5pv210-goni.dts   |  6 +++---
 arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
 4 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.20.1

