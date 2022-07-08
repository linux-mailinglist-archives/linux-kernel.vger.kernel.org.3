Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012156B825
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiGHLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiGHLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2109.outbound.protection.outlook.com [40.92.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF088F3D;
        Fri,  8 Jul 2022 04:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaZ6KIsSnKHOoBNq+wLsh9V0sBZQnSgfrO6O3FqQQo7qMSGHEzEAFspAjqU8+m/0wGJZVjyVgZha/VDNNb/3ewsLKI18U5UDHECeyKvIVmXY6U2IMkM7HiNjtc5COrYCJu3nwZgi0yhoVAj8QvlgJ7Q8YvXz+cN2PfC7hljFKFfa1su28TmBAqbxFkBynjEAvpRwbVxZK/dLtm6acBTsrQNGka3xMUqVx1BFxhBdPN4MCn17J283mVbuHMpI6i0wB82CyJtfLv/9/USRZUwPAyG7HkfWOlgNuFNykiXJLREFGMcSgPCPw96wpFbBW52wRVMmqiWWzSZ+wMOKJAYZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn2FeymYptwhD2it0oITGti/8m3kN6YdE1EjOIr0Yis=;
 b=QrKz6+CcAeNKx1uVAwvjoobZVSfK6mu3KE6E/HdJ8Z6K2P/sSWuIIj0xbh5RD9I9VdLTTh21kDsWQDjhiaGM/0NZJe6i1ON/9A06mK7mk69unp8jL8ot20MDdJjGrJVRFXchm5Cu7UNsXBK6yIQeVpvVqtude/r+EudZUUATZBPGKCDS22fNMOOvhUpOFV3hm9khrKVrjV8j4HNFc+0syR9gZydTVkRb3GUh1mP9HtAo508M4v6phtAGDOKHAH9O+nkhr9cHrF9fFz+Yt4in7XnvxK6lvRq57qIPhYnKTlQBpfdCJYP54fViGpumXL0pgKmt2CbMF0bX9sVDgqPsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:42 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:42 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce ebbg variant
Date:   Fri,  8 Jul 2022 16:42:06 +0530
Message-ID: <MN2PR02MB7024CC826A6E06BF0792495CD9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708111207.85249-1-jo@jsfamily.in>
References: <20220708111207.85249-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [eaf0fAKvCN+daEOUP0UBsf5R3HmoAuW0jaSOI6mx4iBDZhvMunY4GPA+uw5e9tU8]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-5-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c588141d-7927-44e6-d60e-08da60d2c69f
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zJ2f6cXCN7j/1Yn6XUWnJ/GmHt6Yz2WqnZ3ENTTzziqhGJoC/Up/fDGxtG4AnpGA3nPdqZdzFCF6/IVtY7bSZq+00z3h5+6McN0KMI8GRLifi1jmFuijjw7vHK0lGRlr+fW70MD/KjZAjde4ou81e5QtPNtcIN8Boytek8SpdfvoSk2QdBnEYdRRWTNToAfibvpNBMAYmzHaYzq1p+SPQ1llWgIjwqUY3/1UcMH96VV3c5FiSpV8kG0zpCrOT9YCv1/DFaSA99TgRSaAfDsqTwGZjS9wBKDlDjbsqOAg6AoRJzvy7lhqBwFiYncFoNMhg95yDTaRXX/kz9IhO/CtsXMOpUVFROGjJr44aphCDYRls7zPUIHq02AJXqBpR2QpdpZtmXvFiZ4vWSNBvh6OlRyNA4JKFH372OPMSQWuiVLgOvk48W2HmPoye/Huwjvtx0sSJcgX8NapFQ/S49VCmgWBWaXUtHd7H+uXFScuSpalcbdjBCGFGIL7Gl8dZfUIWA7QF17l51xHLJfG8Mgwkl1QyRHazFFdcKUEtt3srF3beZPNxMjjmgkonHV0/eD2sEMlueNGC9qoWrmGG7mmHQ5tcTYs6qtWU/IRwvyWAxqtr2eUwNDANSodKPvI9GgXfdIeckE7paGulWgDOtUyCR2LqCQ+snJT1E5ZBx/9qpz5zRp3h+/lVqyCLum8G539sa2LrsipNVkKP/mloTu2g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PcpS91u8StqvzzdaseLDxQGOKdO/eKetqxLWS6e6bo4ZryqJmj+rZE9Bi6L?=
 =?us-ascii?Q?SGGuLCqLsVtyvYlc4R5Yv/Tn4/ARLG/P5UUqkPFDMuZy9kXM8/CDGXvjVncx?=
 =?us-ascii?Q?a2fNDMT9jvuFR45U48KPD6ZfMAYrGyvVwi5Nk100X8qTvGlzub95dLz2xZW9?=
 =?us-ascii?Q?PqH/GWx6aYEDtFmSJ5sV0EFxmrpZiLmC7/NaeYGRSCeyB1nthgxBVxQiCLzl?=
 =?us-ascii?Q?dOVAVyJapr3CBSHBwYl21vs+gEKNq0wh7qa4RinBUZIUOU+tweI+yzZjnGlJ?=
 =?us-ascii?Q?vVrXPi/QI2NYARzcHEFUKFf0qJY/mE+5zJceKHimh2KDAQ57vEe/FscsRvj7?=
 =?us-ascii?Q?nfgCko2yk4/koeIvbBQfSmkTtzU7Sk/XFIgBNBGaPkHYCaNy0gpU1qOcz3zR?=
 =?us-ascii?Q?bcgIqZrTb0TTQDYNBti5V5Pbj6O+09jlSiSgqU5iQXuir3Dn5TnZfr4VpW0C?=
 =?us-ascii?Q?TwQ+xaczXPycylVYc/Nk74vKRhMVATFIaUIohmcSc8iE/GyrAz1Sxykk1HT6?=
 =?us-ascii?Q?mDt9kYtfmpTu+cMAj9O2LF1+xAypdF2sp4ue2qJvpv6ShB9R+fVl1A7dkcd9?=
 =?us-ascii?Q?kiyZ3qwJ/EMfNL8P+d9FZXndFA0SoLF5LtpPlOJT2EdBhv9UgkPyWx/0M1gQ?=
 =?us-ascii?Q?RnLUJBud1salVc+XCBnx30pUTnL6LVhboFICh6ypFymEPPMX0OUImfnAN3vO?=
 =?us-ascii?Q?UcW88MiGSlIjHza3G+v9u/FxOvpIX6u5c+Hm/ikNJl5VVc+zBsvyjuttgX6N?=
 =?us-ascii?Q?FF3kMyN/TR1jy7f4ZAHDIxUziWKLOQNlBQbmgMyknhpK3Er0Qu7AA5ztS4zd?=
 =?us-ascii?Q?EV//6jhmqWO8Ztk9QPqp3BKX2Ieh+wW2xQHFkpJPJxYGNUGcat/IfM2aSPj/?=
 =?us-ascii?Q?RL/BdYymRbSBPEIkU5X7mf21lZJ2qSGY8Nx29b+8nQ3TEOiWsAa5Mur4ldTu?=
 =?us-ascii?Q?ae4uaagKZ5eFlbqxVo11lQXM/bmNBIJn08lCeprexCsXfHYWPYnIs6TcCwiw?=
 =?us-ascii?Q?iY6jN92jTp4XNV3kCFwLSGL/QQcLev1hVuT6I54alERb/IDV+53eVjoAqAHA?=
 =?us-ascii?Q?O5AjPWrPb4Hp8oFKooni5Y1LmqajpGVcPP8KdRhY0blTO3xXx9d/AVP7hqco?=
 =?us-ascii?Q?J1OEtnLQgZMJFVEA7PtODx5Hh6dxfrQY+SaAQs/O9bTlHcaJ8A0ADCQIur50?=
 =?us-ascii?Q?oXXnKjQZV24vgFDTn5DjfTx/S0ntSkP3Wc0hfrVlng+C7eQgJInqG/mjQ1CV?=
 =?us-ascii?Q?vXT72s2u64CgaJS25JA7c+W9K1WsmNuGbp+3rODO7yqQ45NE6MnyY/XDlJs3?=
 =?us-ascii?Q?gNX2khd4OGixb7Q5FeBfFiX4?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c588141d-7927-44e6-d60e-08da60d2c69f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:42.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3879
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ebbg variant uses EBBG FT8719 panel manufactured by EBBG.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
new file mode 100644
index 000000000000..3716e16e79b1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	status = "okay";
+	compatible = "ebbg,ft8719";
+};
-- 
2.36.1

