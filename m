Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE464E54CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiCWPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245000AbiCWPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2077.outbound.protection.outlook.com [40.92.47.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4174861;
        Wed, 23 Mar 2022 08:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc9QleTrEwu4sXQIyPhnJvUL21xqMFI6s+yweFzQtVK8X/voxbQcfC8zJXXqdJ46bNzCtYIRT3O2D+KZ6BIXcV9nxzoAOBWVXlh9Xk6lhZ2HGSUTaKRR4j2F61BYRhvv66AdcvMXudgfKHAcDB1LBphvoxj/SvRZKaUz2Nj5+oN7SYMHvaerykqaHDzj3qTobapeyMnsJk3rbohhIv4DxgWfMFq/FRV9Zx8I+M5o4RJkOwHO6KNBCrlXm9vIghV33a09aoBJnvtbohRMvIxw2ilhpqY8YOzYAGhlOwiM9um9ZwPpX1aY9WBIkv9qljqY5Dss6hL+uZJu7ABQ3kQQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7V6pEGMwgrnYm8UgQ4HGV2AM/nPBj7JxIB8R3LTicg=;
 b=DRSgp7T8qALvDNfoj+szu9gAFwf4Ax21fs2jLqNuRQ0IraGiUlaysM+4zaTw42aHAu5AHX328e7pp0ee6qA5g1YQMwWRFMSOzGoMdBu0p9uMjH6pwc3biO/1f/g8vBK0cbjjNXJMdUnW6NTVMu6N6T4w7MAPoUZKW/Vb9Oz1L71eJKQb1f7Z+g7EWJoPSz5VwO8R/bp2Zu2sLF5O7oyofJX/B5uplXLvqmuVGaukSYjEyMGtHc8izwOA0mvS3QlEXQOfiB2xAWsRlpwOLU4nbivpqYUHTRiZUZc1CTYppHyi8PN8ckvuecxgygbJk7ozcA3YaLImeXDYRNw5+IcZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:40 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:40 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 5/7] ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
Date:   Wed, 23 Mar 2022 08:03:09 -0700
Message-ID: <CY4PR04MB0567DC7336ECABC67A1EC78ECB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220323150311.26699-1-xc-racer2@live.ca>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [ez85+BoA3aQd0TkbjG1jXD0ePVIT6FV6ID4emsY5lk3dXCrH0RKTfeeHiqHecz2F]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b778504c-9921-4468-2697-08da0cde508e
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYVSFMYObrZHmHkFNj8wpTI7QyEgKbx64in1qvJx+/x8BPbaMNIxo86fucym5eZX7tm+GaXVI/o95PXAUdJiy7vuSKKDjCbT9O28jaGv3X0Bm64p1Si2xd156AxORVivg2Yu7/hq4wsZsSyETcnw/cK7Kvpeb37bhjBtdZahGjEVfsGFyqw0o4b5lh/ZeE6otvt0Ft7kU45Xoo0wIWeSzzD8kVeLF9MDDz45EJGjEzj48aMPlesYU58wysvXlNBTHrwVGlcN+gwdN3f+3ByTvNGsnP82ugrBWwIh/I5wKojaqq1IPCl/Dlh4dSHzxkvTpCgC0htTGwkVLwxPOS8yYrTyE9NJQEjMU5lpncUv2Jlclx5d96jMjWryZ84a0dF+24HvFZokDgv3j0wOJH9KnwqNX4o8Usl4LALtBaiJxmVN8DA5roqUXVHqDi3yJFR3BNW7eMQdKFLr8cavQRRVCohRcX+nT+pJFwjb7llBIWSquEs4+/2LoCq7k4sEXFRm3pLV0fn9Fn5sIZc4TLnc01myxAbb1o8ekYOAuRCwlK3WcVDVZuU1XnK6J8Fh54Q20Hf3b6V6R2b1wMNiXRjLYg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4N41RXrkjKJt8YdEifmZvfJP8/uM01XaopSxr4+ldBB0yW9jlPAEOfDw8b3?=
 =?us-ascii?Q?QLTkc1rBWMTo7pDRDR01AGE2bm6RSRzwBoT+x8A4NhZVYR5GhO6v9j7YdQra?=
 =?us-ascii?Q?mkSFlY2MD+aS5E45MlnYjYVbiW4UgESE9e7O//RiSAS+UXwGckv6Bob0C2Gr?=
 =?us-ascii?Q?LBWCe31vFf/J8hylBmrIEAEPTnNHyLCTTjxCDckphqSvZ4KJLSAyiOi4mrPk?=
 =?us-ascii?Q?YPcs4voEtsdT6CblVHhxwwFZxVtpb19cHllCRoSAvElfMNOU/39qgioum4D0?=
 =?us-ascii?Q?2g1mmQHTzaLfqQ4kChSwpwvBbaTK/vFBhII87sWBKIVBPD4ty8JwqEasCccl?=
 =?us-ascii?Q?QDnqpDkKHcS0HO1aUfQG+Nh9t9z32DpL1PqiUzg/qKNf2N7G8m2Zu88UfjUk?=
 =?us-ascii?Q?rZAzn1InL6Zo78IgoYilGW1VPiS6m0zU6YULc3U399DvPoVwT8I9E09StMKR?=
 =?us-ascii?Q?HTccHvhluyla57RVG8H23PEgUAGMAXfM6lDFyv1BXHA7Tr7RGg/I8w90mWXS?=
 =?us-ascii?Q?SWXPgpqLLGMcPXOHjEeRx8OXL+trtRN0fQfFfAhNLLFF2EsntBd5C18AJQ5l?=
 =?us-ascii?Q?+dqGa3SqN4QvmCK44zes+AkAkRsuE2fc8hSa8ecFEe5Ai0mItk8J6zJsxB9m?=
 =?us-ascii?Q?5SR8Sv/1hV4ezEYwHhcuBqc+hbj5LM+LZ6miOeMUQZTmAhwrwh4gacveqneT?=
 =?us-ascii?Q?Fl8yQcv9ManMynaOJj1Jb/eZoJH6OJ2Y0q4wbYgQhTTDu7bGRwFjnpYA2jOQ?=
 =?us-ascii?Q?JnxpkcXyXWGOh4o4TaejCZLq8kj9S32Q45NyybKyC91tuDcxo7aIygvwxWGG?=
 =?us-ascii?Q?TianXx7TLrbqYVSyPWg9m7H6dK69XWLokF6glZAHJHRTntby698m/+Foes9d?=
 =?us-ascii?Q?hVDWVFFW6ZBItU+nNTWmRSUj8mP7UJh0E2eKaGZsH21sxfPL0KhV49Kbboub?=
 =?us-ascii?Q?S08XxKtZWYMhexT0VJJOESURTvOVNBwbEI+DFX9UrQAbwR177MyUJleHMbrJ?=
 =?us-ascii?Q?mEFu3v/BF/3GPrkSdRC3kmQzh4jcyRXsY+SSRFq0tpud0k02jHJm5sM4WDrl?=
 =?us-ascii?Q?IPbuqHfV3HHmgXMPMqe3TqjcavqepII7JvBeu6IjBkM7LuNGt7/QqWCswrqU?=
 =?us-ascii?Q?0guwQkP5+yEHamcBOD7qXWMZKAHREHQa8K8WUT5CRo7HB8VzvKoOgNhHZxDX?=
 =?us-ascii?Q?49k3C8GXm0xSau3cfPDm+94Im9LVCMvTM+WRZA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b778504c-9921-4468-2697-08da0cde508e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:40.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the name of the bluetooth interrupt from host-wake to
host-wakeup.

Fixes: 1c65b6184441b
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index b5d625f12132..13a065f5df5e 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -902,7 +902,7 @@
 		device-wakeup-gpios = <&gpg3 4 GPIO_ACTIVE_HIGH>;
 		interrupt-parent = <&gph2>;
 		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
+		interrupt-names = "host-wakeup";
 	};
 };
 
-- 
2.20.1

