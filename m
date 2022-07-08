Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE156B832
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiGHLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiGHLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:12:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2076.outbound.protection.outlook.com [40.92.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2B88F32;
        Fri,  8 Jul 2022 04:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJCSu62+NcP0QSYgSYVkPoOKSmk3sBNL9t+v/N2WlrTePZXXGdIeObHAU28PYZpMn52ussp1mdw1tXsfgz+gRlUeUDxo+5QG4UpAntZLWRYaxsG4IzhH2Fae1v0pAkkrLItfFa5Dr9PC7tLlrpPtxG/yI/ZYzrO+dJSp9HXI845H5V8jJveqHgmpPWuT8x9i0CMugLoJ/xgHJZsOs2qDW9jPMODlvSLWQFSxY3xf1ApRjBJG7FeBMD5uE8uuHCy325KwMNP/R1gKJ/10e8ZKEsAnPiGickAlaGeqkJd6cBkiJOBme+QBlYV2VEx8YoXQqr/oQNOxebqTZvJp5f46KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADzwW0U05ebyTkNpofJdIS3oVCXmUceOW/nhbkNyjtc=;
 b=Df3WagTXPg3I8cUALv5a1HbzhmWZKFQpFXEFY0fOakQ4Z0VQeU02ECu7nVrfrs8p+pYZZ5p0seivOsubo+XL6vJNMtqnGPJnyBRPbWZlgYtmmOmwMSRAqqmjVKiSSoycjt/BRfClsXRjgzpyrQEHh7/wBinW8UXhb2kHg+xFGwDYiqmQdKt6l32EevFc+I07DX3aQbyAAz7rssUT9LZkIw4TjtGLpczN3Dd6+qZYYMuq1y5E9Wo/4FWxus9SKRHWJsN4Eh8f6lNKZMOFUljfKfMiNjr3ROQfpRhgwFNIVodIZksKNoEr9dXfz2uzUu5ZLayVzdtbOtupK+7NYWjFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23)
 by DM5PR02MB3879.namprd02.prod.outlook.com (2603:10b6:4:ba::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:12:38 +0000
Received: from MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63]) by MN2PR02MB7024.namprd02.prod.outlook.com
 ([fe80::6c6e:45bb:b4cd:6d63%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:12:38 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 3/5] arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce tianma variant
Date:   Fri,  8 Jul 2022 16:42:05 +0530
Message-ID: <MN2PR02MB7024C9C547B6D51696EC379ED9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708111207.85249-1-jo@jsfamily.in>
References: <20220708111207.85249-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [iPtWtEdzE/RYN0MuDFdW4rZQv4uTagWuu7r6ufjuJpL2nvwn6ipu5+cbBP0CK211]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To MN2PR02MB7024.namprd02.prod.outlook.com
 (2603:10b6:208:205::23)
X-Microsoft-Original-Message-ID: <20220708111207.85249-4-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c4fdbb-d6db-4009-7f29-08da60d2c489
X-MS-TrafficTypeDiagnostic: DM5PR02MB3879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzWT5pCxiDvOkqM3rje/v5uDMGc+aBAMt4JvJ/PxG9yX0oxXkpH9zRViD/jSEPnZlxqQ+xxrC5V1EqswTsPHRyejdjsdGwso/rNfC4LNoo8evn2myvSJx83KH8kO+X/dLhTrALe+9Or6uckYgSssQjNP5aQ7XoDoDd3iz8uAtTru3IUHfsx6EDk3mj5dSr68LLneoE0LvVMrxd4jak2pRtTOC0TWLXhXaemdmGCzKjumASbPczBg+Xl2egWFmOqXwHK3QSDRB+2OIbE4YKAODBOuaYUDm688N7dclQsyDAsyJjmqrQU6F6BeWToM5Wv8AIekcKjCqLF0EzQhllcJZB+o53ib+XLVJoL/oG0fPVu7bcmyxFlBaCWOvR0JupZ8mcxxDVYvCJ0s334F/f+H29EPRgMLJ5Cj457YJEdlyDZ2rltNHkYHtMR4w3PGRiZ1NS352g/J3USnf2acMqzrJ90mC99YFhptZCsYh1RTLP98ZkWxhgrgcpdGpUVEOJacVaUIqAkv+pBnEUb7Mz1+pdiF+LAcjoRvSWGRVgL4bI7FpaJCx534UIRmDeXmXrly3DDd/dCdNApqVAyPgvjLaKn56KlLdX64g0QFaCCmD2eafCvAK2uRCF0KGpc3+z1eTWA2O/K2tOil9zjNI5umtPdH943cZpTqgiyrJowREO1MBsdU4G11d6VcrAR7cYjx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Z1pEa1AotgHQ7U1SfWgfBGsaFVuZ3BULnLlOPohUNEi3RHnaOMQGz/pXHAI?=
 =?us-ascii?Q?aOSbx8+P4IqqIrxNYUURk5oc1b5tUlzAh+cvgyKL7rCPXtgh1QiMQDFxxemp?=
 =?us-ascii?Q?wrMR3MuTRfXW9YJwuXaMF8AhBlZnmeoPh2GFETFi3tALihIUSncGYD8HXs5/?=
 =?us-ascii?Q?MVGSiPst1CrE7ql6e5C3eKE/UJRM2fJywEd6gOECo8rQkA8twhv5mAaRzX1H?=
 =?us-ascii?Q?Ns0SzJ12HNQxfNARuLWqbgqX+QXvn4Wce7wZuTZYNhJBfUosu2QiTST8BxAy?=
 =?us-ascii?Q?iQv67eNvQTOD6+dzdpgT5znvi+OwRGK+Zq49hk3HKYDhPAlxJ9vmUNOIkMgt?=
 =?us-ascii?Q?PCLs8y0FT+EnHfKFnJE/ZgEvEp5XiQRt0Ftp3U0YDm59g5qi1B/wp+IXrQ8A?=
 =?us-ascii?Q?jAZxYMUAuP4KEaCscysfHYSR96LxxDwEy9TPgg6Rv4TGyGBn5Pb98KIAjRZw?=
 =?us-ascii?Q?jkVyFj8MfWRdH6b63g8yZF45UJ2u5yM1yGTAXcyAaIMua/8obfQJLaZTn45U?=
 =?us-ascii?Q?YpaRG7skWxlLkIiCSu8YGeujK7lQfGiNF/tB7TfI8yUegr5RSE1d5wyl1Lcz?=
 =?us-ascii?Q?vwi/u9eBOnjJRtEwy/R1tg8SREvduEilhJlq5MYHulG4Og+SMBKGmQbgSPx8?=
 =?us-ascii?Q?5Z/alTkQQ4C2oqCyD+79piSeW1/T0gO1KBlwzhdiKyaqeOxLKD1QVEK2+GFC?=
 =?us-ascii?Q?YZ9r9Cu77cTyewo+sePWL9ZaeLBAkldiERL2ET2R5aBMEN7s7QE+xfxKbbCl?=
 =?us-ascii?Q?OmB7ZTJO2dVr5qfbGe5BBXUyNvOaYrOwFba0K7KsjVHmj7moc4AOIKnrOBtU?=
 =?us-ascii?Q?zye2/zeRCjaCgpWHOOLNPlOq/+kXNBPRuI6QYtaH8YT190z1r3lK2AUh/hbP?=
 =?us-ascii?Q?gfadm+9DpyZjxceppxG0qaz7Rhuy7Vo41oRXuQXn2WpyMQ3UVaQ6XbCikiZF?=
 =?us-ascii?Q?cYmJFddnlafLOKIaTbhDa7O8stkbnOTNI7ghWQr3azLiTC3ipaW6XAQ/J6Qm?=
 =?us-ascii?Q?a1xHUTUjMLuVOvF/dVVyCdtdXJsro6DvvzEklRODzOkhEd1+F/Df6s+s60DZ?=
 =?us-ascii?Q?+K40fZDm1LKm7PbfL5EN66WbhsjT97ufpcvwo0eMsYAbwopzagi1AzG4aRxd?=
 =?us-ascii?Q?NJlq6A3lM0wCvjZA9j9Q8VJ6tqFBlrDKiT+QFt9ggTD7qu9q/azXB/fF+smz?=
 =?us-ascii?Q?/YUb8Aa1fLEDwIzMOzIpND1qFaY377AaVkxqaiL3QnPameusi5HJ1kjZASu4?=
 =?us-ascii?Q?CAgxXq7/4VwoqvLzhQUUQlVBaAWPRTXLq1nB36EVyN114PbxwLH63Gw+TWkJ?=
 =?us-ascii?Q?mlYb3dFdLq/nbo30L7a/MvPQ?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c4fdbb-d6db-4009-7f29-08da60d2c489
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB7024.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:12:38.7151
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

The tianma variant uses the Novatek NT36672a panel manufactured by tianma.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
new file mode 100644
index 000000000000..97bfc1c67eaf
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	status = "okay";
+	compatible = "tianma,fhd-video";
+};
-- 
2.36.1

