Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DD4EBB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiC3Grw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiC3Gr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:47:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2082.outbound.protection.outlook.com [40.92.40.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0E88B36;
        Tue, 29 Mar 2022 23:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4wqOJomVqciXq4vaIHWZDtU0t8jqtrz/BuyvMXJCehQig5Lsf76K1jpqu0ZDZrZ/5hbFqIZzjYT8WdzRyIKEE1nj3OK4pV0DwOa44YwODrmQb8w4e34BvjONgTI1wyBnX0RqTn1LTL8aJEVDJdBK+NWd49aIQBlIxNw8LfEEKi9sy8pLKylXL5l7j2h0MitxF5NwJH/2pGrlIEnSYr8fbtHXZOO7d+fmXosy+MSgCXIHuqxCU631WPpiSCeGH4m5Yr5ajyjbMTXw8wLKh1jYgAlfxeLXJ8fRca/tcLgJKTLaNJ4D+FpnTBDLJcZSmJcyhAPJglsmoJ1B80c46yToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1968Tz+CjRQuTeKHkmKqmrCPL9Qm/PcWCMnN9AzIKc=;
 b=HSA5YZ6Kb3c53jRrrzMLFiC3dxjXQtDrxfD3S3I1RCtWdk2Tqzh4PDa9G7mWqIhjwpv5L6KXIfSsIxxJGIRjZKyoqkqDGAWfiPoyBDsRHm563UFUN8M1NnJ7WtD76Se8NcMExEexD+EAQvKNhri7Q7TT4lPNo6PRgqW3pyNHZHHr9Lp6mL/OLTz8cQiHfKQiCqqOy9EmiByfoZdFKkAOV84OnrmD1jzFCT3pIDEVswNbZZpRPOmgwbGL04YfHM1Uzgb5Z0KLa5OMXk0lTUqqe8kq/5BZ/G/AZv5uFrFGfstd6l9TXE0JxMxzCit3EWgP6cn4vioaHmGz8fCroShMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:45:40 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:45:40 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable qcom ipa driver
Date:   Wed, 30 Mar 2022 12:15:03 +0530
Message-ID: <BY5PR02MB7009405D7C06C0B480974063D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330064505.243799-1-jo@jsfamily.in>
References: <20220330064505.243799-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [NkM0EGUOJrZkaCAKdb7EirygzwvLlxgMPe8P3+tkq3mXvE7Pk06I6Mrx0Bg6KBNe]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330064505.243799-3-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4447f9c-fd43-4069-0d03-08da1218e761
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8686:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obamXlYdOwXrBh1a1wAdQv5ffwVwzHetAO3kinJC13udpGnRrJ5Jg8Nkh5SU5qKH4wm26m9Ui40fC/ynq/s9GiEig8qAg8EqRE70lzZsGUUJjBQFQXBX7/6e8XfP7TD/NnIx/Pqj5JaZWY1v6XO5S8HvuqY1OqCqnWmNu34fxbavB9/tG8exyTBH2XQtT8Dmd4bW285L4k51KW6k2gLx/KECu2W4vye0t/2s9blipXKQaNTa5X5PwV4siS7E/DunMKuTQvCW3kH0JJm5l1Mao3Fhql2w3NvqCiqCoZFK7GZ5PRybWAs3fnrTLBKPRv6R69cqG93aVOTA/PUvQ9IoLv6FRMMenhTha141/F7pT7iiGBxgN/QC5c3lFoCzJ7uFUmaoM6j+YC8HJNVEt+ZQ2M7k69YlB8xogW1tUBXB7UcnK6gwT1E2ZwvNBVNv13jzqChmHkY0k72VhVi8QO8BXlYhlzu9F6GO8Ecqztnu3UKwx+Xg6U7mjgHyGza4dZDtzJjDC0aminbwFqDl8PnxqgIwBgaDNknzrS1oFgiZ6o7bXHQ6pvxqEBaLc+eWFXDwqOljyBt/e+KfGZHiqDOmag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTmgYAhBZLoi6dMLJxAJ6mGa5B1C5LIyuAG5Ht4n9cAst7LPEgYpvEOm1Lav?=
 =?us-ascii?Q?uEt5AxYLdPpgiGQl20Kt/OhI1qKkOJLr8o5WNENXWT59B4mTxaWrSjple00F?=
 =?us-ascii?Q?ThOJPe9+If5gcJ0QkY68Ss0BwEkm/V9mNfTgMuYJKarw4RUiP3LgWb3ii4Sw?=
 =?us-ascii?Q?34FmWFJCUfy/d/soYF+zga6skUgxRx1huXrmEb8xNR3SXsW4ByHYYqkoFoPL?=
 =?us-ascii?Q?ADM1T8ACPmeSAHcV4SO6xMU4OCrcE+05TCRkZYxUi9puStoC6RBLeemtbYT+?=
 =?us-ascii?Q?vMaU7bH0x1GR+jmWu/BSHhc2j3JNB0Mj8RhvWBa+TCTXDm+xQrs368F0rKX1?=
 =?us-ascii?Q?bj7CXQ/0PFxbl7i2ZabTISqp/eye5tcA8TGVibDgWp2ja2pjBTit22UkhqIs?=
 =?us-ascii?Q?8wMKOsSCGa8Bvc/wYcGYMpAeD5GjwHDeWeSRJqJddSB6mpUzTwqW8FzNC9A/?=
 =?us-ascii?Q?mq7i7Uy+wCmKebvrq8Wo4wRKAgF2Zch5WEXJGdEhlYdNa+o/IPkUWiF5ZQYS?=
 =?us-ascii?Q?1vUzyb+ZaXsg3lPjGJLsLCDr/4Fv+AEklh2r+LnsMxPrTLSg8IROUK/bWysL?=
 =?us-ascii?Q?hVwQXY0ItON7w4lInk5u0sTgXcuWTYY53W7hXZPIrJyfMG7fN4kJ9UlNiJy+?=
 =?us-ascii?Q?S2aOp8TIjFIB7ZC03UwkSzxc0fdnV0N6HXzuyB1LRR3ff4vtZPrqPdeVzcTr?=
 =?us-ascii?Q?767SNP/0nibBDzKckrpDJZd0XH9QF88FXz1YGb8YnwqLcPmC74ZCIXggVPp3?=
 =?us-ascii?Q?4/ErtSiUpA67BM2k8Ro7kW+aWdoxvhbek+2AiYfqtQNQtmTI+Gl0vefYcbLt?=
 =?us-ascii?Q?j74t9ZGEPdNe3caYXEVJH4fmcwizFuSHGpqD9KR0CkF+RvVF7JFOCccIFEGj?=
 =?us-ascii?Q?FQPNJGKIoYo4dXOmPaJ0FHYyiDjcsSohoUHTycRgdgU56v+sXv8rqbvqE9Id?=
 =?us-ascii?Q?L+ZvlLPAYZgkg9JCoqzUGqympMBWXVtV8qv9HXUnz3aG815Lke1boBpdHkxK?=
 =?us-ascii?Q?Ezgt7BFpdIWkCyBwg6VfRgsD6vXOKHJSekH5jBwyiwmKqx82ENoeuQDpAgxb?=
 =?us-ascii?Q?s1c2/s/qa1I6UJBPap5p4Ymx9T02H/n/JQTDUoy4p8doSXLe948imjZDubig?=
 =?us-ascii?Q?X9gROFSOfgHrj4gw8X96eRE9K/cVYYuJC8hT33U/+oBOC1guXBoiH+2aEIzT?=
 =?us-ascii?Q?oRzW8ZJqDmxFQix96mLVYU7XeZYPaQQ0G5OKkcw2SflmqZHtmWs9ClLYz4B9?=
 =?us-ascii?Q?9jHrv2WJ4f4BQOhNCxqwaz17JYNOpCiRHJv2FqNwRvx0aJc0YTXJLFzYwtGu?=
 =?us-ascii?Q?BskLuzu6goN7luhz7n/gAwNWqJWf824Y7x+Vz0giH9RVHxJQoZBO03e/nynq?=
 =?us-ascii?Q?M3jSf0ndJyVznO/I+H8u2iJ09UBWuJLBPzqetCVm5DSik4SSQ+9SPLjsnEuU?=
 =?us-ascii?Q?HX/NqZoBh47emKlcJm+JPBcbDi5gpPs/qGHqAF2PAf3Gl6F6xS9oqQ/X4GSQ?=
 =?us-ascii?Q?Z1wMJ2UspVYMPcM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b4447f9c-fd43-4069-0d03-08da1218e761
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:45:40.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8686
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm IP Accelerator (IPA) driver for mobile data functionality
which works by using ModemManager.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 27ba9ad1ad02..801b8c5984a3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -292,6 +292,12 @@ &mss_pil {
 	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
 };
 
+&ipa {
+	status = "okay";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
+};
+
 &pm8998_gpio {
 	vol_up_pin_a: vol-up-active {
 		pins = "gpio6";
-- 
2.35.1

