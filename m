Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03249AD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444171AbiAYHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:19:32 -0500
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:47494
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1443330AbiAYHOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:14:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvC7L+RIw2crpM+YI4A/wqk0TOvAfgR+vlLvLdJa9KBv4DReN6yc71LHOqN+JCDOjRYyfMAy/pnckriCFZCoM5QfW8OQEZNfOe18oCL9PFj7VEYWdSOSE4VffGBWPpC7CClhJarJ3fvWLzlCVvhx5q9o8xxjHJvF9xQLggD+8n8inb72UnvEyPqVqVL0wobvnwxG98U5JLR5X1Gcu3TE8tCNdLSp4gv8fLtvfu7Z5M2vUl82e8UtzY9HoSCzh8FpAvxoM+DR/DsJL0HGx4R/o8cjgzF/HkOStjuTFAmIdWY//JOGc4+/dPeJ8eGSEeWV7TsJyILwFUyE3MGZX0JHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g0qxkkkzL4rqxXgXiBxVwsJpBKJzghy1LjsNrSdfBQ=;
 b=XIoGN0l4RfBmOX2K1xlbatXgq0DiMmvwcgM9unuUitFg0tg3pfhgxvh1oV9mJMGNb42lgzu2J3t0xW8Kov3CqHfzdpgbwJr/BSrxQTdRm7EmVXRDt3lj+He8uJl2VjUnlfi8GYNfr0MI5qVTbq9cAyFhYwH2tfeBKrwWrphUUZqk4rfo2Ithct5RSlQNUlhnSl9bbrjT7bxKknqT9yKKnRfOsJxaCjrZzdyrSgkm7k6S8vnXzHxT2VvdVF7NXb5NBmuVw5x7Aj4ToSPrx2IazvpYpNxKjao1FovSAdtVVm8U25f0oHUqsN4oT+tch9nqhsQnfaiyxaXMvc94SqwGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g0qxkkkzL4rqxXgXiBxVwsJpBKJzghy1LjsNrSdfBQ=;
 b=kxRAz0hkNHRZ7R5NKjpnsehDLLJyWq0Hx/h3JjgqBmce5+2Q7b4uOMdgWZjb5jul5wdHIxV8+IGMSczeC/Aaqx1RK6R+KjE1QgjiN3Jw02zJKBsFVx5/5iHpFp515krfZN+W7PyFAsZRj/hjDJUf2gau/z2s+r92XicSGSCdEpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6157.eurprd04.prod.outlook.com (2603:10a6:803:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 07:12:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:12:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Tue, 25 Jan 2022 15:11:29 +0800
Message-Id: <2f695f6a597a4372842d75105b654fba6db27d59.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326213b3-2dd9-4f61-56f0-08d9dfd21663
X-MS-TrafficTypeDiagnostic: VI1PR04MB6157:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6157F4344B224CF142287FB0E75F9@VI1PR04MB6157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa1GUHt3SDtobctRd0g7bcdGkbuzDrAODnHh3FEd6QUsrvLX9fFUQVpH2XWPmo+oqUPDpLjCod+4Qsck4e02+zKswD5iHKcxv+pykM8ywFK+KcGkEvvGfvItGKzocz/ctSKadiAsAM3GKLZiRnIvIccCp8mpetp3UObvhXSFkZ//Y+HtCqIoppTGxc8XhEOEx7zgX/rQ5WFDetMMQ/S9XaT16QsgKMZDFWPj6RObornb6Y356KsoMp/yVFZdAwJsy+O70SUT7VyAJxWr7knUZV9Gfq89XIf3hREClYggBacg+VJ/3umcDKm9AxYiZs6gS380iwxWG5XSFbrx/qrigPy7iQOvpxnWTIkY8YeMmJNNPqXL6oc+eRNBoFMK/gpCYhypwPf+bSp768pZJwvDHzVM5HVmkE0dcawkEArgTNX//d5FIoO+D4hdcJh7y4sEMpy5c0Kojzxzh43AUCB7SUWKEGxZ4793YL+n/r+2hB4gmvHjeNH6848U7sgw3MzAjgpjM824TX4EBNbXrJ3E0J141ZBtBEY+C8UFo//T2AyYu4cxdDrZ2uvXmfszn9WFaLsxfK4ylg0jgtCueFX9MHbmf+zx2fNeoSl4a+j4NaeebkoWECXdzZhKzULiPcwUVpWq8YRGtAs0XE9JaGGkBq2DqogSjeGQ1Q+Wr8GEz6Z6eIacvtPmRzU0jki99HNYTTOn2lBWMeFGyvV08ZQWQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(186003)(26005)(2616005)(38100700002)(4744005)(2906002)(66946007)(66476007)(66556008)(7416002)(44832011)(36756003)(8936002)(5660300002)(4326008)(8676002)(508600001)(52116002)(86362001)(316002)(6506007)(6512007)(6666004)(6486002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNkfndkeSYu4Mvig8ZuCZQy/NgJ3euqnBSUB1WaZgoSv0zpMsgIIYEwvFF5l?=
 =?us-ascii?Q?17heev85PhQblLJp1h/aU5MTbf6xbA7+L8mg33w9z47WgsLs5RPYUTtOiNmg?=
 =?us-ascii?Q?AbMZkPgQHfg+ikX+jr0OYxF/b5B0dF/cs4BZXvC805DOXs2FRmAnAiIyTXbT?=
 =?us-ascii?Q?e4odg5ekI7lQWp865iIsrw4fBG4pGHh5wJG0EbmV0AfCfLpHtRNKj7sdzO3I?=
 =?us-ascii?Q?hg5DnZafm8MgJXz08enh3kWSefRKYD3icvB1XGz579De3Sqdf3425rBM20V2?=
 =?us-ascii?Q?oyv2ma3BzobshQQHyglWJLueBotO1v8/xC6+PNOXpjAN1A/mvKlNVEgfY7uw?=
 =?us-ascii?Q?jIKhD/ZcPf3aqX63CGccga504C4Hpha15jwiq7rBq3H1iHrOQOX87SyYgKER?=
 =?us-ascii?Q?vWkLzx4DYteBp8F3995RQNfOV0afv66iijq0B/Wf6l0DxUVUqBP+xfWBimiN?=
 =?us-ascii?Q?95nXDCH8rw8u+ntcCq+Dgn5EV/bzn67wG4fiHQhTbl1hFd5A4LsXZnmTGyBy?=
 =?us-ascii?Q?wb09trmhtGSxfw5vDSP06Kd8OII0KI9hFXyQ+UclcDcZxwnGbhZcGwAysxZ8?=
 =?us-ascii?Q?EURmy8LxzrU/L4SCxWmzyk/tsvGDGUAgvVNI2viJIXswWPOnTZm6pObtfYbw?=
 =?us-ascii?Q?CUTtAt3Ni6o2RekttU0yGVw9mMe4Y8tWvoe5FJHEJCOq+cPHQ9r67HI4hY+9?=
 =?us-ascii?Q?+sFwPdOev9WhYJb8O7BlrOtvdB3fe7sAq6V09xmrRFj6kzL0l4D2U7h/ZFO5?=
 =?us-ascii?Q?hE7zHFR4ZYvBRdLUWMMpCfk65TyBiL2bwhHvtuT2o+dolRBMRIYXl2uXCvgq?=
 =?us-ascii?Q?exND5FWoIWYecQdT2vOnzhYG/r0CsOaEeLdkWzPyaRSVPVxbAe6gDk00qwCd?=
 =?us-ascii?Q?dP0JVw3rHdpPtJ+V89A2hCSZ3L7xLZV8wQ6I3uPxetq9XnkuXxckCNbHkXYo?=
 =?us-ascii?Q?+SfdTfmjRq0FiD9pmpwRuweLpNSakynd2Y7NuzEXHIscHhER3pSMIS2uy/+B?=
 =?us-ascii?Q?WIujnKW9LlzR62H+ReLiEDL+dM1jzyJx+uc+q7RgiiyNiqLGwCIRhypoOqK2?=
 =?us-ascii?Q?hb4GkSUCwi54jRgraR1DALo1nu+dV89t/KVY9AD8ywIKaAbbYN5BeJXJqmW6?=
 =?us-ascii?Q?KOJqiTqSeHMMAoa+Fq1HE6Pl0uN8E3hItQXbqiBSZ7NMU89m8FbrQp3iEaTZ?=
 =?us-ascii?Q?p9EhfJyViwqruHFAdYBmCkNZQEG6DUyHHT2wdpLeDtXNA4rW5s854dusxgwt?=
 =?us-ascii?Q?y/x1X473TbclnI8Id/ypFpY4nKC2a+xV5CTcZZh4Yd4ZvK5y0XMrLtAFr/Xs?=
 =?us-ascii?Q?5XYC81w5I8JGsgN/AweEETQRV4ydQLpGc/qrr+Qx8uSrz3CJ/rSR9QRHvo58?=
 =?us-ascii?Q?d6/3+sA4IBWeTT396mACAXcKF1LnWRup2RSq3L3Xthn6AMcossnFUrr/6Jze?=
 =?us-ascii?Q?+11dN4Us2IQ3mnAw9COWMp9ownkgHSPRfFFqS8xlQPhebj00KfB3ceRuXtDH?=
 =?us-ascii?Q?2sBRGr8ygOIwq14B0cBf1EmbPdwrqZaTaopYA0IpyUD89c8h9dEjBgA8id34?=
 =?us-ascii?Q?qtrydfldie+kWFJhVHT0zdoHKS1dLg0d20oQtedJiR0dIkMca87gicefBMr7?=
 =?us-ascii?Q?PRwVzddOzfqM1foi2RJVdwo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326213b3-2dd9-4f61-56f0-08d9dfd21663
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:12:46.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKPOpMJT3rJ/HmuK8cKVnTchcaz6nuMgE2d9IUcvB5q9+JN10wzxde8Zo3yNNz59bg2IrrFhbkddViL3p+NheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
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
index ea3e6c914384..69478da4f64a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13913,6 +13913,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
 L:	linux-hwmon@vger.kernel.org
-- 
2.33.0

