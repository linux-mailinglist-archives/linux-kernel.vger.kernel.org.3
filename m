Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A763473A43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbhLNBil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:41 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244147AbhLNBij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONqFAy1DRLBxYua82I7IJhGPrr8bI2DLO3uExzwzYiBl9FPtDqbcq/iGwbVsuKAQ9hjAtJyCgvUcDW+CoGGIKzXaXg1cHWqWH6onShY+43bZySMs+Wdv9DGM4guhW5D8ph1Mxw4HHeipBia11VLnH1zHkYQwaZW4loUJQDAR/BSdJSi+2rK3jvifZKm/y/d1HNXVx+oLYACaKIBFCkU7KBRubyvFC8FBCtfmX9M/K42u+7fw7UEeJpvGnLomNNHZ9+Agz4u2FI4n3l3Fi6YpVIWRa70MNvSuTvwvIemNUhwqJRUrtqqPe2pIWals0UG54YgRrR5tyO7IorC9I9ux2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR5DbJvqwz/dV/DDZUbg+bzEufQBlSbdFL76fl4IvWY=;
 b=P8HM084RzFMfmRMV01B9YdzkDeljTjMlcEf1XTMbDY1NZLEBhgoY3Gii5EqjwKfkQRvTqFH0E2quJ0ok7Y4McTQcTWglEfmdIodJ7LewcJnrcdZVD2+YcSBz2AKo4uRWlc6X7MPryRLYBNwlJEmO8hwsJwclL36ox/gYcN4uKmS8j9MoTfJxUolOjI9tMmIqtMqp0GOIOe1mQu8I0fOIxp9JQY3yIsHlLNZlTwghO3prD9lwznnnv4CVEC53xKhAYlGNMB7NoYKbqnrLzY1PcsmtDyf7r4TJx4Dn0RTr8MCvqlWMdAZ+PGow1a1SSoMz4NVXLZXVQpagSQNiNhJDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR5DbJvqwz/dV/DDZUbg+bzEufQBlSbdFL76fl4IvWY=;
 b=md52KVZ6JkCtZuB6DIceG+aLLPTkruMgkJSGeyOJ+ZgLe95T1YgOWv6Nn/yxOfWkEHGefT/cqjakXynxYHULpX2MaK6k52FR1MXJ2BFjl3ezDfDPMaxUVpd5kJ4pCjTul/Pn0VDlHh3Z8Wh6r1XkTDHBg4iylecqbjuyMuVO3zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:35 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:35 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 01/10] irqchip/ls-extirq: rename "interrupt-map" OF property to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:51 +0200
Message-Id: <20211214013800.2703568-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fa852e5-b6dc-4a3c-58a5-08d9bea271fa
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6944FA11EBCA2C82DB021DCEE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: id0BPiFjsCRyFB+qSQnkwRjOsaLoXbIG+AjeFt935yQisZi3Nuf/rqKPMhrg15n1wZE7g4QE7q5aEgtd2t152UW2OsORRP4cbq5A6Rktf0cl9T4b1ZSYC12sHAKKazjiHmOHRMQApY4kMUpKcZxP8oUZs46JkcDcfrguQRbOerwLUyTxg1ield2p72TU1XaMyzldQSmc8uL+B+4j/P7wu0L/z6dXiV07R203shJfVGX98xrzDg1vtXYwvMzbz1hUQ78Eyos+wRB4vqJFcc1yxGmsaOowtA+S/VqRgwd0V9EVlbx6klS7HqOZE9OatvymOeNl77cffWX7U5EhvIcLNtsP561WSvXVhzDOMtjr8+iHH+CkUL5vk4d9VDMfG8jD52cFnP/Cy+HSV3E4iYNq1FeT+4CS3VkCgRHNBGWKO7YUwaImpBIrD8Yj8sUDseL5hs/fERduwMb/CweWOoYFEMd9o+Z0WVchRSejeqHwQQKlaDX/z+Lqu9Uy1S5F2aiueRWsX7aA1eSLqBWU7XxdF/vuXo2u5TXGybXvxmSf2hc7aG25ynD9dFlbJnB+Tsf+4op6jj2MZcvRulQPfkRAVfcF6IYF1TRfXkI1O3os3GFasUQbnyxas+88Na0OQ2/AuNhyDFN+OpHwbOy0ucQamQCluqwYjDSazLHLKIfhFzBf0+bFmUMQPkJt2qG7hX3AiuMHvEXMCjTwvN3Zwqt1I+QNzuo25g9GT5mEql3SZn1m1AaskrZedD2TZkXdVWzBhYmxvT5tRGdBL2JbCR52XHVqN+pwv2RfEWRFL0Wdh4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQjCepHuUl4F0i/q7xcBOrDq30bXvNWJQUBAFJlf4nIC9gFnq0vOXudDrf7g?=
 =?us-ascii?Q?XvvBUkrU7txUUEP7e/F9A+dlr7J9t5YamfXEM9srYIywuOop4o0dvd935z74?=
 =?us-ascii?Q?I4Y1KLkylz1DefTnQnYZvCE9MOWTuSDIK29Vtv+z4fv1/C1eT+wXvzg/qSvX?=
 =?us-ascii?Q?/Znhni6OR75xmLNxBhlWfgcaDxjISGALrcrWQ9tGL2/qmIAtTfaFxJWwZRuo?=
 =?us-ascii?Q?K8tOgoGOutzrS6WtIhR/3Rua5cPcEJR1wz60uDmP4bAi4a9Rhw+Um/Izi2Gx?=
 =?us-ascii?Q?hIR4LuLuOJ1DJ/Bs+iZCJK3pEXV0DIa/DYKibo6jK26HLYqQHwJ2xmhgx03O?=
 =?us-ascii?Q?CQdrnIVJu1XLxExUjupfL69HAcpQCE7ys2zzNgimLa+o8raIJ0WkNDhELZas?=
 =?us-ascii?Q?4ufZrKkCEr6M3UFyXsAsnSsKPPLyvCcn5Vf/X+vNd1w5TpMhqjABU53ImJ6W?=
 =?us-ascii?Q?daVUpprZWhdp77208T44r3hEtuK7Zm5FvczogW80Xpn+n0upBgEq//iCZ7K0?=
 =?us-ascii?Q?2nc86u+dBbNq+W6QNt58uZsWM29Z5kgM2Jx6GtOeMXyOhLuDAhcDFWsJQr9+?=
 =?us-ascii?Q?N0jCbes+afO7spNj9ARXgrvp2F9rdfZ5VbNgG7UsU+WnXkNsqQU8Ym3v3Zu4?=
 =?us-ascii?Q?QK6EZiMiUoAAOXYJFslBwznjd7V97Yx1nZkoWkeiWBfk82OSjjQcOFA4tdIh?=
 =?us-ascii?Q?k41LX5a/OD4Vw+RDeDTfJh7FdSjAc3I89QcxjAiN6RgOe1HIALPsypvrUUdr?=
 =?us-ascii?Q?OBkd/tTfxpSWkPe+WXRQKudoHMIcinn3bq4AyccEuj66JElE4GO8BBdvDrYk?=
 =?us-ascii?Q?b0DwjhP3gNUyDh8s+mCKVDRjpzenRdsPGiL3MoN+Tw4+KPB2AiB3jMvbIklZ?=
 =?us-ascii?Q?e5nBZB4fiSVm6my3fpDZnVLF1YhgsCxAf7qt6PSolHQBB6M2t8TURQccY+pP?=
 =?us-ascii?Q?1Y+5Zng3WSrW17NMZ1PEfw79ZBR3CdF/vhAjUgJmwHJue4ETdtpqzFSS/s/5?=
 =?us-ascii?Q?0a+vvhKZz04bMLM5Sk7tYCiKoHTvBzSbab8WqiokzPZelr4xeXufLHVL5Oao?=
 =?us-ascii?Q?QA6sLdEPn4UBkj+0kfchS6MiAPhNKUR3kwzUD+54vhmjQPoRA4GcBO3gGBFa?=
 =?us-ascii?Q?d8SSg29dugqH37DfhL28xxRgkUPgLytzv8PTjePzhoH3V1zlYCb5gIUKsFA5?=
 =?us-ascii?Q?M6S1WFwkMpn7oic/HAK7iasraYxQcycpL7POQpBEDTgkRcWkApP+q8rs9lza?=
 =?us-ascii?Q?i9eaSyeG5lAEzxdjd+xiC/G7viPPDY/CVPuuL1UaBUa2YPbPzBeucDusSva6?=
 =?us-ascii?Q?S9Vt4LX3hCVcsD9H/SYlH1iq+DCvnViZ7zHamk/FsjMSwlNBDFsC2sDRUX18?=
 =?us-ascii?Q?u3vZzx8hMaghcBB0TEz2TNragUtdkoZb1wgaF0T/3lBTUoaur9/4qiysgQOq?=
 =?us-ascii?Q?rwioPrUi7Td/kj/y7NCZQQi7zMLoSDPBjV6Q0WUqTXm1tDOixQwVUa2AbZ/X?=
 =?us-ascii?Q?Rkw7mgDzO16O2xPCZ1swwyxOIARPHvpPjqCmBa+jDNJD51t2GodOOen3ok4E?=
 =?us-ascii?Q?RnvVQMD3zMjBUV4NO1HDxIAtIURMSPQgdN0A8uHBpVXGWIPrXNFbcgDrqq/0?=
 =?us-ascii?Q?JcOtj5LVM7R5BrDIHfDhcLw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa852e5-b6dc-4a3c-58a5-08d9bea271fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:35.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAqq15aCAutNIelQmQ+xlvXZ9fuwrpgKiLujDt67lRz6BoPtO568CY5Z3SNKA1cAA0AVkwT9ZAXV6RJQ/FvrLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This OF property was supposed to be named "fsl,extirq-map" since the
first patch submissions, but at Rob Herring's suggestion it was named
"interrupt-map":
https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/

At that time, the "interrupt-map" was ignored by the core for OF nodes
that also had an "interrupt-controller" property, but that changed with
commit 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"), which made the consumer drivers of the
ls-extirq break. To work around this breakage, the OF bindings for IRQs
have introduced a table of "OF IRQ interrupt-map abusers".
This can be seen in commit de4adddcbcc2 ("of/irq: Add a quirk for
controllers with their own definition of interrupt-map").

To stop being abusers, let's go back to the original form of these
bindings, before Rob's review. Compatibility will be kept with the
current abusive bindings for a few more kernel cycles, to give people
some time to update. But to also give them an incentive, print a warning
that the support for "interrupt-map" will be removed. This will be seen
when running a new kernel with an old device tree.

While the breakage was introduced relatively recently, the device tree
changes are intended to backport stable kernels for quicker conversion
to an acceptable set of bindings, and this driver will need to support
the updated stable bindings.

Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/irqchip/irq-ls-extirq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..b6ecc5e3472f 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -101,9 +101,15 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 	u32 mapsize;
 	int ret;
 
-	map = of_get_property(node, "interrupt-map", &mapsize);
-	if (!map)
-		return -ENOENT;
+	map = of_get_property(node, "fsl,extirq-map", &mapsize);
+	if (!map) {
+		map = of_get_property(node, "interrupt-map", &mapsize);
+		if (!map)
+			return -ENOENT;
+
+		pr_warn("\"interrupt-map\" is a reserved OF property, and support for it will be removed. Please use \"fsl,extirq-map\" instead.\n");
+	}
+
 	if (mapsize % sizeof(*map))
 		return -EINVAL;
 	mapsize /= sizeof(*map);
-- 
2.25.1

