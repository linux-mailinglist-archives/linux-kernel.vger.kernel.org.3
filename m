Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8B4927DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiARNz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:55:59 -0500
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:37168
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244637AbiARNzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:55:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyKNq0nAD0GesMjAHxYDn3x8BB0/AsBoBSOmPAce8Rk6xpG9jcBjwNjaAoFR1vQNRKBP6ciHvJg5ypo2A9AcneoKcCBJqMGbnFnc5SIblciHj8G4rh32hCEEy1Lo5napSmXy7xunJJ5APuP6YRd50yicwBCXkt7PV3F4A52v0HqS+ah+IB27OpeKr0mSI9etb4Fj2weugFx2Z58Lq+ls2vq22KMAFNvhXoILqOCRIc7GCQcVqsJ2CztjsV+xIEhEgkRZgitmN50rz2MCo41LlLHtDji+uL5eCMEGaYZ/S4/HXzxCwit0ano8JRv8M2mhm6oMKyhM1wInEi204t9STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVcdqF8zE0N89K00jvs6pr91Gzu4/IqaxCzlE3UusBs=;
 b=b+rM8RGY6U/83pzEo8qIYhqiOX5+t6biGmmmSxkDe/IvwZ2IM5eLpPmcEwBZZ9//JJIG+pqwrVQ90P8XTIZsxm0kdhFntEsNyxaONzLIXS5yYFkEtmnDJqa8SQR3LDF6VnbmMHn6/DGBblTqTchsJfz/opIh8frABQHpM9+xHGlWyaIGpdfGKYO2WrQn3f4WYLyddjngMVGkq0KnYSlwEEotUDZA9kfE3mr2xbzSkHTMQy2R5udaQqUBWPBWXAkj351+gJ8b6Q5XbH++4+aAHvJmAJtPqKfmLm9m9pW4a5TLDN4GnVIjviIPelTHYcg0LFTwBmLNHEHihbkp7nD6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVcdqF8zE0N89K00jvs6pr91Gzu4/IqaxCzlE3UusBs=;
 b=icOM01dJ+B0O9JsEjxwDDtoTeieKUgUdY1/ooBDUitLDi/MhCiWkvgtf0Wzdipr8kUYuDzErRLAI7MAH1opiGb3tKgjJheQMiE+RL5s2TxWOyzidYCcFktPckHRjVzbSK7y55da1+Dzf3QUCKkCpQAr2wncE77Q+oheM+y2u7VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 13:55:48 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:55:48 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum
Date:   Tue, 18 Jan 2022 15:55:35 +0200
Message-Id: <20220118135535.2118720-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0265.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::38) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee525793-1f4c-4ecb-ab3b-08d9da8a3b45
X-MS-TrafficTypeDiagnostic: VE1PR04MB7487:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB748751135B2687F7EB8CECDFF6589@VE1PR04MB7487.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mR3BUe5/Anb/cyv34cgBUuxeZ0+//jq2hEF5Ip+YgReUpy6qPuFS7suPdZVW9QoFu/ODknNtW7KViykVjkW1Lg/6qAA5XrhfLwc05RdfwrDsd66/wmU2KbYLe4w+v/UqjOwZjJevwVVGACr7HQHS/QsPXm7gh5lyGVEm7IBB79w/q4hx5zjQw1JgB6DGA/vzbJxt/vxRwI2iXmMjLC9VKTyHUbmtLd8WcZbymH8xPXDtrwuO4RI4PJclRteZmQ5a46HFc20+O0ImjGZn6DRbPROZcFArSjN2cUuJubsP7JSFCFGyfFzu2ouVMu0x7lHCAC8Z6xOplLOsPkRFAAT3avbV39iAuf0tAKIjWIRs33LPekRXADJanBNpYbBlxCDV3VbVSxwrppqYib9vQI7D7dIuD7encHB5mUcBFWXokkw6u9JLYrt9RylSmp+JfJhVfl29rHXkmZ2SUEscyrnx8EbPEI98rFFNqikSOTy67XsLg6ViTAti7IxLzhzHbtbBY0L5Ml47oRKMMCqd1ZUOc3CXYISwO3HBH8+vZqzdJgfvHgwVm02pz8qXJJOGC8GG5SCOSt/OXKfGf6nb3E4RFp/FpuijNwR5Ko5PBy3+qRhglMgKyd3UDpZ5hmCvntVcOm3woDXjbRO07HPdfqv+ZzfStHOavQXww4ek76MzPgpGxarZkQHPd71GoMC3w0wTfRZM5NdJP3zu/aLiWQ+G6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(2616005)(5660300002)(83380400001)(6506007)(2906002)(8936002)(44832011)(52116002)(38350700002)(38100700002)(86362001)(66556008)(26005)(66476007)(508600001)(66946007)(316002)(36756003)(4326008)(6512007)(6666004)(110136005)(54906003)(6486002)(4744005)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/qcEyQviKHhI2V0xubB3Bih0uMB31FDjX65Ex9mAB0VniOhIQjjMhpNlcmN?=
 =?us-ascii?Q?V3sZI5QQ7w/nnKh6y+8JPh6GR6XMvhLXoJSCauMiihniliBC7ZbVqK3/35rh?=
 =?us-ascii?Q?BqBHATLm9NIMYSAmNuktaLhDgAK9JY93+9Y1Ci1yGhJsOE6wmq/zKqxIf7dU?=
 =?us-ascii?Q?jjHMXv1SQbo5f9zhOKBHfoMGVoGOA7RrGzqnRM03KzOLP3o8IrzeHC9oSTIy?=
 =?us-ascii?Q?4t0TdniWa9wILuA7XE+D3DOg8Wk6/Ig70Mo6J2UPBF8UOVnYpY/bt8f6dtLJ?=
 =?us-ascii?Q?68XQ9zlxOW/dg27L1umyY7C9o/+ltpuT2UvzbTQU5bCmcNalB473pO0z+ByY?=
 =?us-ascii?Q?kfBflR4ugD5P1P+3lkbTr3JnNgkK3e+cUydrCi/b1RmZpt9k9UkO/07w4/FD?=
 =?us-ascii?Q?H14uCbT49dyXp2BBMa0BEiLiG9GIDAPCoIFrXU5Ayea9t+UzxhVgAZLQacYX?=
 =?us-ascii?Q?q0CfEzumwJKBaltQGPOgUqGcKjCtaL1r8xqfGrp805gjLOA2UJOTriaatofC?=
 =?us-ascii?Q?gGz57xjSNnm6IyYKNMv3+iLV9dQE/R72ehXVljLBO1spmk5d1rjkSWfqaZCi?=
 =?us-ascii?Q?gN5z+kpcbjGNsv8vFmBM+46VErr4xo/1Ko5R8fR6ksaojYXtkuPPSxY7jgDz?=
 =?us-ascii?Q?Prpcd4pqTyy7VQkDzgb8ejL/m90jR7lBOEWu+J/+HBcBrv9GKnl4/Ob+RYUe?=
 =?us-ascii?Q?ye8otP/Od2b7xXMC/dnJs0N5YkJysgHvcArXL+uBFlb3Z8Zq2Qkj2NMAj8mX?=
 =?us-ascii?Q?u8Zm5caZvdcOyazLjIOwLpmuwTX6WkSDwFnCdt1COQkoMB4mJltPLzrY7/i1?=
 =?us-ascii?Q?QGE7GhfhqF2VarRd+kKhWHE1KNrjRzSlfQ5dU9l857ifXQlcgltYW9UWL859?=
 =?us-ascii?Q?W9TbPUGt0u4wrWYLPAaBH8nLe9McakbEpP3MxiFKTqS68Y5y3WKSvh3Um5cA?=
 =?us-ascii?Q?NZjuRQrwx/0K9mA65WvwhMynnD3z0NHcwa9Bnw01bEPPD9GiOKKbIzL8ATVe?=
 =?us-ascii?Q?G0getYvIEXefbn/ED+ollQObHJPQ3wrqZbUM9BCdPHTaSBr2LQs5wjPekzM9?=
 =?us-ascii?Q?gnYU0tjdvorg5vfh0OJjOEZ1C1V7z/w0YD5JYWbIWsuMAodW/Cy4H/bNSEBn?=
 =?us-ascii?Q?gu0xsf1ywtv90Fzu3Sq4V3Y2EVdZepO0dovBBAWaq5C77vgqZyP+iWsn8MPa?=
 =?us-ascii?Q?W/l0GH7oeggVBtRlChovtiwe5aT8n/heQNcfYAa9HraW0WHlzDmBaNNjnBWh?=
 =?us-ascii?Q?yStWyFQgR9EVFhBzByGqVZbcTYGc5PtJ1UbAasWHMw4CJNfVq33YRux3r8gx?=
 =?us-ascii?Q?3tkfqqWOCBAG0aWyJ2rJPxswA9BOnrP++ccpukOnpT5NUT8/ViE6fqxV3GxR?=
 =?us-ascii?Q?OesVokuEkFvCCAKifzwLS2DS65gowSGM+g6mtZhXN/HSu93NzgDEeA811Mhn?=
 =?us-ascii?Q?SXOHCllrDRhISQSmnFXbXnUAIYuZIuw7UwfBwSA4tfEiSYteN+GzWidncubS?=
 =?us-ascii?Q?LK58R5FoQkFRqka/lnoXVWg3qpUKWnVpIePkqAFs8bKlRdyr9FeWpMln0vRa?=
 =?us-ascii?Q?saw1xAbw4QApAgeex2MPuHUN08L48VKgiRs6WbLTzK07Q6P5dWYUAXRofvGb?=
 =?us-ascii?Q?Haj4QM0MWoNUQZKxEEcP874=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee525793-1f4c-4ecb-ab3b-08d9da8a3b45
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 13:55:48.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVgDAeDII7Y0yIHiM8S9plXVBO47tU0fvYe5ft5TAV4YdXmIA0JP1chYN89M8cOf+rf/c35jcDie0zhj6BU0lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QM lpuart is backwards compatible with i.MX8QXP, so lets remove
the single match from enum. This will force nodes to have both compatible
strings, since there is alreaady an 'items' entry for that.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index c33e3af1b5ea..aa83cbf56d59 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -20,7 +20,6 @@ properties:
           - fsl,ls1021a-lpuart
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
-          - fsl,imx8qm-lpuart
           - fsl,imxrt1050-lpuart
       - items:
           - enum:
-- 
2.31.1

