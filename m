Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3A4664FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358507AbhLBOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:19:34 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:13287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358457AbhLBOTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daNoQZBnlZbbNUNBPWH5M+B8MgHsTqIJTXQr79NabtlyiFSTZ6bOLj4LQZOReF5xjUCPcEm/9SUh7/okY88vUDe0G7Cq/pM2ATkUqlHjNEoBwioJhbJV9hdFYtohn13m3gQrS+D+DTfzKGmYKoBTuY5alQ8Y+LioyGux+E6MS730AzQYn1FDIgHajdKXlKkKZtNZMctjDmNbQ2pvRuCQOapf+5oBWerLqvVfRip7PdRpyUzq+OyJDAzFeDR5rX7/fCNYXHTZ1Fo0X2pe86wNb5ygPtu39KfRjJJs0fw7Yq+Y3SNvpcLuuBZqOXnVz/U1Rew3lV7iIdH4nNGprlwkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYG/LC/TQqPoUWmRnySmE7K6BOnoJM0Nni9DTFEWiEs=;
 b=gzWWVpswqvr96sHjsnpceWkK4KNI9mhyFXP6EBJNj03v089M5GpZvNZmxOX3FtnSpw7mBoDe7hQjo+O+JV+rucUvhMSZkZ/2tr0B4r4tPYt9z8NtXoGuKc0tUvVpFdznmL4a0giaBQsPIt5SSnX4MUEuP0coYxRzsH7JHiA6gtTH5UQjynqZRn2hDOSjMu0+tzK+sDDQouzoxAPMlq2zYdZdHWph6hRQJuS+fHQaN1cqB0cDZBGhD31cbTTaDd3z28fQkg65GEF0n6XIUejJza5YpDeeavHdob9YNqCtA1gfB7gl5gcHG/QT2mkhsuEsRqUZclRGDkiKq5LZ5OCxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYG/LC/TQqPoUWmRnySmE7K6BOnoJM0Nni9DTFEWiEs=;
 b=UP+MgCEEra8PdbEXZ/HXVWfvTl8wgKpUnD5Btv8zJBpRyyNmN10dsGkSepbJBmyzyvRIknGXGgL+vuOT5C9pfOLq35cknwlyIG++zPMdw1s00UEASIxdztMrTz+oMEstwLWhi+bb0iD1SI5jH/KU8fNLEaNZsiSB+sSSYsCvJ9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:15:53 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:15:53 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 4/4] arm64: dts: ls1028a-rdb: update copyright
Date:   Thu,  2 Dec 2021 16:15:28 +0200
Message-Id: <20211202141528.2450169-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
References: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AM0PR01CA0110.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 14:15:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 635a151c-971e-4c22-cf04-08d9b59e400c
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3838B8478FA21E36E1D54B46E0699@VI1PR0402MB3838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlz4oUoj7fiZgcqpOBer8aT5AZcKDEuTKyVA+p5fdqsDRru0aHGJl9UosmYOVktn/XWOW89LA5kLjlrzHHZ9XdckeJWf9X/p9Pkl9v0qJE3wj4NwjgYSqgJv/svUh+iUUKFwyqtDnMAwrOd05/TSyIkberyG2WbNzv/Py9roHHvDdvS5yk48VTnAmFat/BQIAZTnDGCx1aCcQenzKOT5aZckl8QphV9DPuVwFBzh5mUQQ9wMB2sGpv3ZdTEI7YhdmBy6++3FIIGj/5TajvCAhtJU27rxwcQ6Hled/FH/aEWthxSfnaMoy6YWq7TH7iFUPa6GWqGzMt5wEFh8b32A9zjL/a/9Exb7poIDkZLMxcPbcZES/huyDaxem7qNJnZtqjTOnPppmG7njSR+roNK6ld+mIAC6d7NrMyrW/05KEm39n+a7QpZuO4SnIUr7eEDttLGSW7nHexWccbmAJSJA89KV448EQ5cjURSBBq7gwkX7LWNYMajims8FxBq4jZRXjCqf7vlf8unqu7nWR/Hb9VxSGu9+OjxvL/zwuYuxLYl2tjejreVEoFQ7oXdSqz952HAbz/wxxe+OWhO/CEIksHCezL5UcefByP6qrwu7j8jldPI8Yj1ql1L29wYmOHnEIZcl53EN2POzc8DCLxVXFRSdUw9pYRuZW1XaPjs2EuyvN8CSDSv6uU9lhEoXcTtx7WaxyXsNe1m9iF5pBjzkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(1076003)(6506007)(4744005)(15650500001)(38350700002)(6486002)(44832011)(83380400001)(6666004)(186003)(66946007)(52116002)(956004)(316002)(26005)(508600001)(8676002)(36756003)(6512007)(5660300002)(54906003)(38100700002)(2906002)(66476007)(2616005)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSPoUqPDmRusSFE/E6z+ocRt8SiapwcR0JS9ND9J06w3ktwb4SIxZuIrNg8n?=
 =?us-ascii?Q?h0q2y32hGx9ocPz4bHAhEV3L8QO7zRFnPd7IqjxEwCQ/5H3Z/HSuTFQ4v1g/?=
 =?us-ascii?Q?gKQ758MVeJaO///nLShCKYlDkWzx3EjBOFCPk84AzFnKQj8pFLfxyd7m1OAo?=
 =?us-ascii?Q?ArmIdb0Wnhpvb9Vf48uFA+GTnBkk5tjmsGTCxHRit9siweJSVu7bFH/FYq7y?=
 =?us-ascii?Q?d91MhAkCRWi4JyeKhCO7oDLAgaKcT08/kYzXsKxNqi/ps34Qr/jAwDYivgiv?=
 =?us-ascii?Q?Jfh4R4zFIi9rIaB0Nz6UJmJMhFc1H+hlGTF4ro3TuD6C2VJhVcZjq3L6KaUc?=
 =?us-ascii?Q?9fUe8dniM1DVsBjkf0+QdbQnhjjT++LgTlPyHKmR8ZjdtvAr/5beUJbxv5LZ?=
 =?us-ascii?Q?Cx3f1cmAOSVR+4VWgSrikeQfLqpsr8IOeTPwP/oNHYONKR4wEIO8pDBYGFDR?=
 =?us-ascii?Q?ABjo3VXY8ugXIxzLQo5SpiSXmx8Pjwi7w+iLNg9owNodl9p4fc/4WoSygt/1?=
 =?us-ascii?Q?DhE+fY9r8VKllLRFo20EDhzaGUAaoE1ZhOb54hA05QN5yPM9IzDVaOeHLnwo?=
 =?us-ascii?Q?74p52S57KmxBrycowaraanRbeE9nyiM+f6dy8xKTWeAwkCcUtAk9n1Wo4Gk9?=
 =?us-ascii?Q?gsOFLUJyj7I+myc/CeZUYvFqTrcMGOjDigKXf/7Rd8N+ikjjWz0O46nRsbai?=
 =?us-ascii?Q?WwKueyK9tt76pjnBenicRLgC/R/qHaz52WWhYMSEtEeAbe7UsFwLGZ3+C76y?=
 =?us-ascii?Q?GIkjgvhCPbEnS+vZ8KWJn5I7D9kF1nIEGdmI9wcM2WhKNRin3EJ/g+Wu1ufM?=
 =?us-ascii?Q?bbYVBhkUMxWkxbXdkoTnL82CDD9WpHfByUdoRbcn/n0lxyVo5WAc4oitSlZx?=
 =?us-ascii?Q?izCAZs9W/PyeOPQnj85TMCwCfKWP0PNZflRKDWFRPAhtnAS6Jzi47LhsZMQH?=
 =?us-ascii?Q?ymAyxKboHEFX3cyEvTvLO3lFcbLcHd5070aHXc5Txzbb5KuWlYDMPFp1qM0H?=
 =?us-ascii?Q?eKrLTeBLqudfebUbfWufAXxZBhR//BZTzN4uwBM1sz7Uqasx14vcRH2N+Dno?=
 =?us-ascii?Q?oAEl5efLC/LY2kLTISqttzxv+8W6Pl5JuCoG9uYhk5xQQ/74T/e5VFyR38tk?=
 =?us-ascii?Q?EN6GKrPGdcPl73WgLTMvR80WKLET4IPSLCMta3Mu49cAabotGoceuCz4Kwhx?=
 =?us-ascii?Q?Ox7BJyWnsw5T1Xe+6zMc7C0w3Vr48gnZx28MP5nrkJt/Pa/z56L08O85sib4?=
 =?us-ascii?Q?wQoP1CSRk7ISyOPgR1H/vTRvQ/figNemZcYfqGtT10jOAGoL2g3XoRvl1xfg?=
 =?us-ascii?Q?2mKH6tALkQJw1xcni/lFP6B8nAnmmOJXzPj17PtuGOtviS4SF2pF8XD2qKnT?=
 =?us-ascii?Q?WfkPg5Lkc9kuKEdxo7hDS+iNc3gf52p/j93I70zYsiB0qJyfUr1wcvJ2bS86?=
 =?us-ascii?Q?RiojWd9S/RfgoKvPxDKVcxoJj28B5tz4QEzNdCcNyUfHUM5gI3cyTIK5vZ+4?=
 =?us-ascii?Q?Ruayag22WCMaeZbjL7x5bgzXY+t0VqMiwELuv+JWrXNjU348LvxycYdaTLGP?=
 =?us-ascii?Q?xrqS6Aj/HPzjRlsJLgyrpUeQP9x0YdOJkXBtx2PwuI3gR9f3Mi2q730GlsjA?=
 =?us-ascii?Q?K8zZcziByp49D+N6tgZsbAQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635a151c-971e-4c22-cf04-08d9b59e400c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:15:53.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8dma0t/nvp64JBO/q1HBTBctX8kHO9rzxZnJMlqWrgl3sCPcKUunx7ou4No5XNQRKrjg68bflLQZRrdoEEnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Company policy requires that copyright is updated when a file is
touched. Keeping the copyright change separate to reduce the noise in
other patches.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 79d7e7cf5403..639f40740d56 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for NXP LS1028A RDB Board.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2021 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
-- 
2.25.1

