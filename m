Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7011D49C1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiAZDLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:11:22 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:13102
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236975AbiAZDLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:11:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY0p1GBOB8trFSQvvel9akpq7Xr0p2xvop0+l13vxdv81QHGqzvmDVJnRJ0fPfSHuPhp9G61E02GkW6AjWdtmFHfOMSuc9tpQVi3fz7TYZH3GctRcrtWEFIG2E2f96X/Drs0ZlWaq/NcuWw8REA9kuFBb4N/iKV1oDp4kmdTodFoFKKr+Ih7ZLOZuurrIKV9apFmRqJqncEW6/S+MpLdPNVb0Y30Y0Xsz+qOmXmh+RksLBHhDYSxhfbegNxC+6w4dsjm6SeI26KZDsF4gCWww5I8efKyNbXsFki0saYi/QrCxAWSFDhdh3c0j4+M6t9j+1/JIh5d+Hq8HCDW38rsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n28rS0Fd8JNwou/uVb69Hpd2c9bgZbAmlqiUrrb2Bqw=;
 b=Vpgy2QmXYGbxC9ZF9ny6F3hgEvu8t9wb8CVkVX8gDrcwT0AJMKz1VNp5o6UUSDt/zZbL9S4x5e+iz2+EJOJGob2S4nOKg6LCgrpmpu1Uw7DhJcvsK0hGsnHGZUrNxf31zY+a6doXL54hMUjdkdnNNbabz7dzCo4NWJ9HjTYapvo1PxM5cdUKap4fILWy++ol7X+YESQRGik9AITkS96lWBegoOIs53OkogjB7NwpnjuVpmQaAqZ8Ov0q/tMN/gqpZNPWnzwchvgO9NJYGPlijUR/xcUikbf0aKHJoX/LTTbHdl0OZ9ndD2htta9q7/AIqS3oYW8CDZrI6bGfR38l3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n28rS0Fd8JNwou/uVb69Hpd2c9bgZbAmlqiUrrb2Bqw=;
 b=HWME5U0xbC/kkMMVqkURjoB5EsdyghUcvStLr04EAqf08XBus8ZM/vvMXDvhFkSU9dKKo/2GMkgc+hpQ3ZZDZlY5WFDx8NCGmRjMjYzTz6MnqRvvT6nDNYkcK0I1xRrj0D8NBj2fnSKuIr7LnX+f5sNCQf7IjBkQrjdiePFTPVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5248.eurprd04.prod.outlook.com (2603:10a6:803:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:11:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:10:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15.1 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Wed, 26 Jan 2022 11:09:32 +0800
Message-Id: <e42f0160e4affea33127fa6b175a4b522899f219.1643165765.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643165764.git.ming.qian@nxp.com>
References: <cover.1643165764.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8413f7-2af5-45b2-7b92-08d9e0797a38
X-MS-TrafficTypeDiagnostic: VI1PR04MB5248:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5248E55978527738169CCA1EE7209@VI1PR04MB5248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2wKcHNo+ZGO9vOt53EBKLMg/joN7XVtVqDuglL8DftXXhuSjwMQ7Lt9PYpvCDV02GD7+CH311aHIm+RVz1/EmpB7yJdPL2of2MVK4Mceh7kjnsfLp2SkUYqL7WWFXSUjv0r5PSxvhTjUg4995ttoZ78TU/jb0VGdgu960lrQDpSYC8Klb8YaQaR9PToy+EVzooZO9oNJH7YAm4HHN87j4UgJOegz3h2Bzid8v/H+/y4c1h9mQ56RLWTfkoNnvwQwW7hT+Suoe6KOMpIz4zSi0FSVivmUn0a+HSr2Mf4rnju3iFkwKvQ1sCdX3lkz2BBm9ex58JPlU7sVYejAykR53ONHYuFU70xaGB6oyONlPaSKSSfbe2bujnTEFl/wWQw/X33PtCCh3QOSZmyExGBD544yht553NfETJ3idrInc5iyEFgKMsHa2/aOwWztC2UftZ6PjuB6M4to2s6b6mnFP43y19hK24uxFmszCHUj52wMfcsfPh3/0YU/d8bC75x0a71ObP/6lIeHUG2ZPYhE91t2ZA0Y3X2+adWymk8JSdBHULehrVN1bpzcGNbo14o5A3cBlmjleFo4/oWW6Wyu/0x6i6DCbHjPG7goZOJV90KQJlGK+lX1Gtcrgi5MZAPkXSKT6K8CQ8Gyv5enpAKV0GBrijWNy0EhBuR6TRJeEM3N1NMeNX45EZryOSgm3Eyy4SNA/WyIrwse6t73cvA0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2616005)(186003)(26005)(38100700002)(66946007)(8676002)(66476007)(7416002)(4744005)(2906002)(8936002)(66556008)(5660300002)(44832011)(36756003)(4326008)(86362001)(52116002)(6506007)(6512007)(6666004)(316002)(508600001)(6486002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yo563IqCA+5/tqbHIL/9bf0BFSZ0odJdgdmdUJk42J9FRkgV6mosMeYPMru3?=
 =?us-ascii?Q?GcnEAIjp4tnAxYphnL632ZNTxOsqR5kXvEP03CX5Iih+YbfdPutLlHy5MUon?=
 =?us-ascii?Q?ay2/tyaOiiDKpXENgHvveX+raKHXeRiIdCSeZAeJ0ZsXRlkMF0O4EYgeuQhP?=
 =?us-ascii?Q?J0ir/nEhu3BkzfGM0xj0aJjVkriBiFNP7z2FRtLRn+mjrN4uXmtEEqtc9FLj?=
 =?us-ascii?Q?IV1ZtvnR02yAMUCPj8ItLPWa4aWOA0Eyik1Lv0EjTvLwzdSv82nio5ViGj9k?=
 =?us-ascii?Q?NKu99R/+b4d7d7qDuqW7sW6VajzIdDfZukq2yLBz0v1AGtAculo0Ukv1LYQ7?=
 =?us-ascii?Q?sq46Y6GIxtcSc+qF+5jTFx6eftyKjd4kIN5+PgQjC1nz2gZLvZtTkNiDFqL2?=
 =?us-ascii?Q?XDe31sy9pqme5i/3NyZTIPbhy72LUaoe1lRcl+jUzHUUf0ALmcGKiBMJ2wgr?=
 =?us-ascii?Q?+JAvg/DWRuXwXYDbGMZSfSAE/y4e4KKqm4KdHxdy29JyMlR7AtktZEthCT2v?=
 =?us-ascii?Q?Nq9nmottX6Huo62tNStJ3rImuZ35YhI7gbHaU+dpGXVzNP97cc5h9Kzi3zqJ?=
 =?us-ascii?Q?ObxqLcF7SG63kHLaSCMe6uWg8RaNvgiW0GDO0/TwsLC/VeqRxkGoYNd4Ljf9?=
 =?us-ascii?Q?6U4RMwBKsgXxhBi3K1WryYqmOxdrn2lp9y0A+eiPcXI6MItuSBJsLLd5Jszr?=
 =?us-ascii?Q?jK6XMMHfCqhPYQOUNl9xpspFGNrvAld78r0lNjfOD+i6yjFwG0tBCTkD+qmF?=
 =?us-ascii?Q?yp1SXI8KFiYZRPlde/DTr8ln4udrLHnDk5ZH9qCrU2oX1o8QfaLkgoGg3ueq?=
 =?us-ascii?Q?vZyGVBQAEr+kFyibyWq9k9g+yVoq6ojuBvF7iVZ/aFhRlkJNR4ZW2yI9y+Du?=
 =?us-ascii?Q?gFNAjzvNPwj+o/tsVVvkqTUNAwu/fFfDetVOjQRvsO8scv8eLhnf7z+DuFMp?=
 =?us-ascii?Q?E31dg9LhS6yOOvpb7LvP13A5xhmuQVUmys6QC9RfLZBRTzHR3eYvVuI7gCuz?=
 =?us-ascii?Q?lizErI0QsShkZLNoslnwvgRm9KKRqix6V4VQdyGZBO0y0g+FRCGHZM4rp6If?=
 =?us-ascii?Q?USIoO0IyHcGQw6BF7uzPepwumvhkZHYyyGSepf0nHRXYUSZZA7TqI+xdKV9q?=
 =?us-ascii?Q?5/YT+y4FRqmrhktGVLBeIk/XD20PpRuRjPj/pP7rHvmootX1TyAf2Nl0Bi3Z?=
 =?us-ascii?Q?2Elj3GD7CYji+R3QEqNL9s0gd2VIXVd4d3MKXDxo150k/poptZxG12ND4ra+?=
 =?us-ascii?Q?OJg2jjpJrGU0nXXDXHOEhUNcu4QLnMXqQ9TB4jxV+dXA5iEEmdQQYFEBduK5?=
 =?us-ascii?Q?tjUEz+8CYWPzwS/D0PhKaBY7bHUWp1US+bizEF0LPslbCBxxYbXIDcGj/JCW?=
 =?us-ascii?Q?skCNwLjz0sYVjgpfNc9WOKCcE6f9wbq/JF/YtQIIEyHm+shmJAl/vX3QQIFu?=
 =?us-ascii?Q?rMLIXBCRfwk5Y3829wdm2wwsyFY4h6ZkJ2w+8e8qBwM7PiH1C8N7Sgxz8NcS?=
 =?us-ascii?Q?li3PzdGRywjHCwTCX6EOSJ+OndXecWb6sEiu9zn8QuSJLFKZRPGuVJfPrn8N?=
 =?us-ascii?Q?9ABBrIfI0vUALIHAKxdwyAAhWjydKz0KhJLEREVukOMrDfLAM0G0odW1WuHj?=
 =?us-ascii?Q?INyGXR8DlrtqkaiYJ1c5fpM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8413f7-2af5-45b2-7b92-08d9e0797a38
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:10:59.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhwFRa+WsOLaweEL2d3u2Hn4jljm1s1+MrqBnaaI8Nq9A55SGBBOSAi2M631+MRAQVE2dCwBDkgxDyehzPl4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMPHION VPU CODEC v4l2 driver entry

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..c89dfc45c1c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,15 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
-- 
2.33.0

