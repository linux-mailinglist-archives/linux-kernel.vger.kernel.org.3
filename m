Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BDB46303A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbhK3JxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:53:20 -0500
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:23616
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240561AbhK3Jwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNQXfsjCBbYyTg+vq9RetXuUq68r8cJ/7tK2isaWjEZZvneXcdpVA5PIJJy6jPkyjZHDRCgy9wzRJDj4dVnesED1W3KHcs7iIn0JtLFidXM+thnCTq/dr+WkHj095NmSpwQSU65Ff8wMsPgzfSz+2yX602g3/1K+8u+BsZtdZzX7TIjx/R5yjCbOfjwfX4NleiJrhFW8NUUfgGzuhive7qyQZtzqSVnRxTfqTwRXRD0ppk2vucN6/+w5/Rh9UA0ebt6CSyJFulbV1RTkEynxVSsBZybS6wGgMcn7lJTK5Qp/PSjYzg2qUC3oHD/78Yifhx56u+hJOXPhmzIWC+2Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1yuTm8ltuOBKEJp+clavNMjLapwbUoi8mg34j31yw4=;
 b=CYFvoXvswnzHnogSdT8kJpLHMeP7RkLPq74F2E4Dx+DltYisMMJY7S4mGqhctwMtYv+KxZJQSpAg6yAWFlKqrpdSujzmGV8xHpe+ehJSv+sdWKcgcS1udhro8BD0lEce0P/alriCwvGVWGzdpgyIYPjyW40HxBd6VVe9tWMWcxKBwBAHO8wt23zvPti8hQ8UbCoAmZlmvJpwPq8fV+Bn3ZkATqnQ0D6NbDAVBPHGbPp5V57ftyy1G5Xj0Jcotz93Vxj4t4ndfSPlV04HviF6SnlI2cv4JIu4hdFZfVc5/SyBZD25ELe8/Dhavnv6HSUwbVA9Vwvu/1dVtuCaWxGFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1yuTm8ltuOBKEJp+clavNMjLapwbUoi8mg34j31yw4=;
 b=LCJqGVx0BYR7cUKTl+MkXCAm0S4QYv7uFDnZ/EFZ2bC70PfMYd2WoTDVvmyS9jqA5ONQ9bQIOI9Esnczn1/fvRvuiZuQGYEfeB0p9C+cW9ZCvU6RbFZHeq5cp36WVAGTQ0LCw0Yo2htr534o0q5KeTzVPXsW9rzYVqUmhlUwD/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4583.eurprd04.prod.outlook.com (2603:10a6:20b:1f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:49:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:49:32 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Tue, 30 Nov 2021 17:48:14 +0800
Message-Id: <00a98e7c40ee758be04d01dd46a51a27044df183.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638263914.git.ming.qian@nxp.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:49:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a47a57d-5649-43ba-8675-08d9b3e6b59c
X-MS-TrafficTypeDiagnostic: AM6PR04MB4583:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4583998C73E8A7298DFF8369E7679@AM6PR04MB4583.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJoQ/n3nZkwdAUjN7nQedJTUdPrb3lPL59Y0fxjjyLMo0fJOj8l2fE+gd1JHeAbpWUPMbWnjZbNbtzUGsgpw/CBRWWhpLeYJVLVWdMRbCk8Bkzgz1Pbi01ba3h/hqB6RY52xFp1OFj7s0ZCf4liKYRjrtWgc/ABiMciHQnzV0ZSphKVuo2Y5IcjwJ5k0B2ObWTA1MzoGYcQrJE06qT64ZCiHWwGE0E126xd5w3cggVlQ/xo9ogIeg167MWu6/ttrxXL9bXALdK9ktNEoqX8BmlMu4f1vCJzTHcR+EhCywLagmp1X9v106O2weOhB/WXxpsoRuRClHRUEn98+6UdfDBy9PSg4jo6hU63MV76tNyvvlJ0tcfX3BKMpW9PaVK47Ee+98E83OjlnxX347Bt8ma4s+GHRmyjXAArTC0BZjIa3/bw8yPkfTryIvu2l+qIoarmnrZLO9JRo7dZn0aqWW2ZN3sOaxahpEhqt8QRU5O/bqFF923Pa8UGNYYsM8KjOujazNHYqBIMOPhwOeYcHJ3eg9OBkz9AS0TO1rP4lU/oZ3DcCP6lPSHLeHa4pLPaSZg/AnOIhnbpTogSbAFmyZHsQrcbG8zmvh6YOZGI06+tEmNsCsg/EnCRfxfEk59QQpOMwoAjER9JK0CnBjTidsh6rGEkVzstOI1FYHZpHP4+taZQRKZLAhM88rz03nTe8AaUA35HFSbol67n4TGCwXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(44832011)(6666004)(508600001)(66476007)(66946007)(4326008)(4744005)(956004)(2616005)(7696005)(26005)(186003)(2906002)(6486002)(316002)(86362001)(8676002)(7416002)(52116002)(38100700002)(5660300002)(38350700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NxgAbwJMQnPa+ROw3na4b0HbXPyBhzVfkRJvVnh20qprRSZwjxSPl2JVY50Q?=
 =?us-ascii?Q?tLb9hMVRAofLt8i74m/NgCI24y6y2RBo3W4088F3v16me3pDh+JS/SjJyGxM?=
 =?us-ascii?Q?EfsliI3sefghMviExMiod2oPwHfLIPhDHb/n71FmMxc4sXQmfrqVOi1LBR4/?=
 =?us-ascii?Q?Gm3GVUF1k2xb2bdID18ExduX0gpyAFOFgW7zSOEJxU98O0CciOn+UsLW17FW?=
 =?us-ascii?Q?Y1DS4dqQaslSVmYnZNTiRIPGZaitwWO5cRvpWM+FGKA8sTQH1+2hgJkWx2M0?=
 =?us-ascii?Q?p8eYEakQ9KTKHbxRYQouAd9cjTLi+zmbpskV2648SFbGv8muO4ImyGdEUbwi?=
 =?us-ascii?Q?AxcXYN+b0XHTQTFolFreEDK18JzhlOPfZ7rZyShM43mSuOicfOy2NKZOltfl?=
 =?us-ascii?Q?ZtprbCJBjbP2nDkwZIl/slW8T5iwtMmazxbAO8VE85XSiEeq/7vA6Xk7ACwU?=
 =?us-ascii?Q?ukMX0O+gxbmHxdq/MRdV6kI3Q1Cb7Pr557o7byEDsrvoLZ1ofYbobicqgQTX?=
 =?us-ascii?Q?TZT8CmXto+8Uc1XgaZ5RS2lhWJXYvPMfroXW4AC6tTDn5SQO/9leLo55vkul?=
 =?us-ascii?Q?MXy+Bw3XyW4QTXQLejxeDxBs2zzd/HzdfelVTyAZtsOdPUiwcMNjhGQvxVLz?=
 =?us-ascii?Q?jmTt/0KslsaWMMnS6KpRB/lKaPI+gvbeVXj+3pNeYITHX1LvSHFd5aR6VXpu?=
 =?us-ascii?Q?5Hd3fjmRlQ/Vicqnw+UeeRp7sDcTu73GaqGOIqhzbBt4jCS/1s29vVqxEDxg?=
 =?us-ascii?Q?ABKjSpqNK3ckpBIL7tG7LtgcEvZDsfxMYqH3FO2eQNIymkKiVqgebv79U4xB?=
 =?us-ascii?Q?vt0JkB3VGFjDrWsvyfSdt5lTYMGTc02jm1/9/eEa2UQvy6hUvCKUjdBIzO75?=
 =?us-ascii?Q?6XEu6un05GQhlyWCN4WfdaRjcGw///jm0WdrycgRktNoyoNJAOh5KXO4Khx3?=
 =?us-ascii?Q?G63Uy0GvsRuO2wMrMyVS1PtyxAFBF/In/6XxkIWWsUXWKti+GgYDHR+2XndI?=
 =?us-ascii?Q?h3hcOadUPmoO8tRG50Gr6+Fe4faCRnLM7sRPOj/YYyVYt0GkJe1ElNDB0MqX?=
 =?us-ascii?Q?Mugy48Rulvkay9H5eyiuFpQnIPoxiTO2rHRioAkTf8kRBRkHW1mmKsq6H47D?=
 =?us-ascii?Q?gHm5fcyfWqKiKSpj0eFitJY67DwnrZGmPGHSs5kj2TzCgmhJ4TnLazDoNLSp?=
 =?us-ascii?Q?29rtcYM3i48uzNciipo2iPhTxJbeEjUFGA2fP7aBiPzv3I67IHxKehEJlJHF?=
 =?us-ascii?Q?g9YNaXIz3utXsfJk9K9DJbg+keSCpYh5CqqgANg0jcs7OirH25qQbI0+GTTf?=
 =?us-ascii?Q?xi7yczd8+q5RTsblt2jwtGvSruh1Sm9WE4hzV8JAzED+k3MqIzLWx/IhEhGL?=
 =?us-ascii?Q?vM+LLbVed/0Kl39iVIA5M0JW6iLDQ5TzegXZcDp7KzCYIoBOQO6LR8xCpKJQ?=
 =?us-ascii?Q?1wFerAZGHQOqrdC5R3suMbSCHc9EkAJCy8FZ2X1rxT783fvYaRr7OzD+7dPf?=
 =?us-ascii?Q?Ij1jOgLkxdFkKZ92yPZCarHLaO+unUm0CCIMzBWzh/IRTyNmlPafuVDYz2/U?=
 =?us-ascii?Q?+8AhQxNRzIJU+v96uQ+Tw6cdKVwyad0Et74BRV7VoeEb2giqbdMyfJRrSy5j?=
 =?us-ascii?Q?khOJyWz+/c9ok1HmbSD5G9E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a47a57d-5649-43ba-8675-08d9b3e6b59c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:49:32.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvbk6WeWLEA58Gb3yEn673K1w9LSW0HOfY2kxIb+wIw2XXKDYm1oZt+HYxO+p6Xl3pm3009gHN9dLeq6vQAX4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4583
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
index 8eea24d54624..a20fafc832da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13775,6 +13775,15 @@ S:	Maintained
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

