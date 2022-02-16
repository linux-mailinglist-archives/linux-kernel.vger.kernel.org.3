Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B64B89BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiBPNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:23:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiBPNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:23:15 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38C2AB50A;
        Wed, 16 Feb 2022 05:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2OpuV6nqWBx59HXy2tKOMoUQboqklEgcTRccpZlGVT3hg3Vp+me7zyAt9NaJUox6Njx6YjISwa0wXfjeunu3B1gxVHUuYbv2ARHbpS0+3sqvhz1u/PwkxB6JEJ0aAWBI7RaTPoQfLe+noeTNlJZtyT3mU73PQ3mUhT6MUi6oCE/tDSRzaokCOasJFx6+lchcqj/b/uGCJ8HJuOedcNgSG+bIThTvBhBr5obJshl6zwsoO3O6TIH3z4p7cn1YiyyZ4DeENHxKWVKzPrRPsaAKBznJ1Wq+qjbnVUmeD7oth/Fl2CgF1Q5Sp3gJDPme/E5KUw0jHg62RVFZGv21Hoa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIVrQMocBmS2+OWOUHjVQh7x2+pmv8vRRqAoFlJ1WRs=;
 b=jWNI6u0S/GYowesv/DnN84gHGXklwpzUhYv4hu1h+AJ4PGQCAEJvmY9rB0aVL1TkV90LCJE5Xsfe/JaMdAuEUijh8n+TgsO8fHZ5dDFRXpQL9tqL3kk474WE0sGrF1qVxmHAOD8gY6BEWloROOIS3ok/vwo/jcxf3+xSkaHt2S3z4LrTajYcMcIB997H4gvL5dWSArEJKKvpPLxwjTYwmXENRCF8R8a6L/R/qS4toNqpdpUglWVVKN5pu8DZ38M/9Nb1lSK5kClqy9pv1t7kc7QrW6cpUqgGK2AQBEynPDWr79lOFIVgqNelyCKr4BVF/zTjAxPqrZsVCdh3hmBmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIVrQMocBmS2+OWOUHjVQh7x2+pmv8vRRqAoFlJ1WRs=;
 b=qFSnG00f7NxL2ZoyUuN2P427+0JnmzVXGg6NG9Dit3Y0KInROKObEfvim4JN9rcOO15z/NpkfxM2++Uvro7Fvdm0G4xfuIdHdIaTvRQLKPz3qvtwvBH2I+S03gbEjbKMWI71jHLy0e8rlJJcRQuVVLnt7cUkNgASX22HYtvVkLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB4738.eurprd04.prod.outlook.com (2603:10a6:208:cc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 13:22:44 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 13:22:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: clk: imx: add git tree and dt-bindings files
Date:   Wed, 16 Feb 2022 15:22:14 +0200
Message-Id: <20220216132214.258865-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0116.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::18) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903f7d33-f5bb-4225-512b-08d9f14f6aba
X-MS-TrafficTypeDiagnostic: AM0PR04MB4738:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB47384334C6A0631E015B9FABF6359@AM0PR04MB4738.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0hjyKmmyaDx6y0QpSD0f2HWLPcQoO6iH5XD4iYwvAhyjAcZ2onX0X8/9wUX4Pqqxryc+xuKtywTa2Uyg3Z0Ep3erOegAx1JhSkRkifvXOJzW/ZLG2CJuT77vtQBRYi7J3bImIPcnk29fk0LEaIila+ulde9JRsa83xSK+L7z970pM04tvhClreebT/iiHCP2GomlNbqreadDv56x9Mu1fE0zEe3VlDWh2aSd6q+1auF+fONsl0qVe4mgqDc1dzMqzw3YbOaaz9xzet257Uo6INAqj1isMxIaXExRE2Lsn2nBojaL3vE2R4x3pNyILcdrxnd3kRhBp8gOxtI+D0oePaz+tEfn9CnIKpcZWWO/RyAu+a/g0rUX51ZeVwscr8JyjRqMYmxgBgvjyB7cuoTk0EjVN72CjJd6j2d6NrbvZ55zdsmaQBjxjzZF766YpDhrr+zBeNmFaKJc/M+kwymx1dPwGLvdJflugKvetTLmGo4Y/8+FE2HeqcEJSQDW9HPLyrhX89v7enzRs8rq06uxuksPS0EEIUTiFbzukCwjwtqR8CCbwtPETmqnluNs7U/ZZ6IDyPR19jSEc9KcTpKniWY1EBRoCufSVPU2Z4K/BPGO+ufTDq+K+xPdZ652PkQJ6H8UH4amqywpvIegeQxyCMkbmxvYRgupeVa+XSfE71VcwNuEKnFzvZKOJO39ZA92nqbRC5HzJXeZbl6LPygkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(508600001)(186003)(86362001)(6486002)(36756003)(66476007)(83380400001)(54906003)(5660300002)(4744005)(316002)(1076003)(26005)(66946007)(2906002)(8936002)(8676002)(6666004)(66556008)(4326008)(44832011)(2616005)(6506007)(52116002)(38100700002)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxcYY1kJvw68YaYoa+Mh20v2c9HFhEwyLVZURNxKjuGXM3ep/45Nb4DvSTBT?=
 =?us-ascii?Q?WTQL0ZTELDT268Vr3vDPp7YrYXshE24ewJm8TPP/GwpLPy+DkkgkYwiBYcGZ?=
 =?us-ascii?Q?B63DdJlUA8ETQhAqwq9gop6KWPcEU7y7/zv4oYl+ACTkPO3lMeH1n3/ZCf3S?=
 =?us-ascii?Q?fEDOk6M+iF6wB6vutastsTCxcOPxDRmsCQcOKRRyxr/7wea/i8MC3ksEcdYC?=
 =?us-ascii?Q?euZJbpp5ILkO0KvMHZa9xK5SxRycbxkHBkaP46muwZMzOmMXm8EOx68/voFT?=
 =?us-ascii?Q?6mNVByAtwNbt4aZxiIIXqODl7IgbbprxlCdau5s9czeeHOtQGMoerHp4i3DQ?=
 =?us-ascii?Q?yhQ6pQ4vlyZ1uRTGJZ2IPA5+3r+O2I7jZC1I5ntgE+8QwgrogChHHPjOeiMR?=
 =?us-ascii?Q?2er/13X3M5nko5PUwiKZUSQXRqK1Ag/a1z53a5CeoysOq276zfWVRMl2v/U9?=
 =?us-ascii?Q?etnIKvsOkL0y7CDXR23zFXqTDuAycbH/oNgEKCtsoXvfwiCcVuJxRtZcPcXW?=
 =?us-ascii?Q?45TF/qE9h0vqTb0IJZw/9YHvQOMSisHBO9ITNnpnwQ30Afb5bdu6HdXF8xVV?=
 =?us-ascii?Q?U6priIeQ0mtNnlmsWdLyTrSgi7WVpmtFZzWG9jbDZES/ZnXrDDuSc1nqvrZz?=
 =?us-ascii?Q?gPfBdlRFF57B+fP/DIuSTVIcxQoC7vobOMSXVf/QMfNBHD6mCGNCC/AgN09i?=
 =?us-ascii?Q?RPplFo2vuAleX0FI8zl7f1uo5cfcCrTjUcPK6EBOr2ysV8kRTLLyHHJ+O3dz?=
 =?us-ascii?Q?/L35eK7vW5F98YQVjgtr125bDMbAVy4+k6vIkvt5K6zVcCt5w3vofbD1M2h4?=
 =?us-ascii?Q?WrEz8Is04wn19kkKL1KYpUrEDrc9R5sk3YTx43FTyR5e4i7pwqOARVh1+W5T?=
 =?us-ascii?Q?7Jcn3xpiQbt4OGvBEsBdXfNtPoPpQfvs+43IxNG+crsOnEQDDrwSxBOlEuSk?=
 =?us-ascii?Q?Ka40BPjYnRzwDpK/GCXILn2ihldOWI9UNRAxfSL6N+AVIGqlPcXe1iOt63oy?=
 =?us-ascii?Q?esfUTeqJh1Q+wFCqulfOwXC/PdxlatUOB1MGAWzxrEUc/Vj8PvgxN5w+qRaP?=
 =?us-ascii?Q?qId8Qvz76ei3E7i8FjM9KBOE93uMJwLGENb6AyKEEhyyOrDF2BRorsQu3K+W?=
 =?us-ascii?Q?rcLoP1qNwE9VNkIULPINpMiptuQcu/3xz6KMUbbGXL17syQbqH3sh9D1eaNs?=
 =?us-ascii?Q?eaVX/pSRWIIDmvGAgE3YYE4bpWgrYIpBjvufsdI3ecwaec/uU/OFyVRXMMjJ?=
 =?us-ascii?Q?BYrdvoi6hwcbYXAINWMIjcUF1idX7TkukUlWIWCsmx9U45tXQM/vfo71ev4n?=
 =?us-ascii?Q?xjfHVNhet80DJerTPLDME+uaEO9IaJQHADCVZMOkbjex7s5ubUcDzaLyZdYM?=
 =?us-ascii?Q?Bdr3dxxyrq7wa5xyIP++FuOzLxWo9rDy+ncuMo7w4lmzHpXBVfZdDfoM8XM8?=
 =?us-ascii?Q?RzpX1zz5OVFuxtw5KgxLeq+EomoEIxHbXC+wprXrwas1SL2QxNTpET6FxHZY?=
 =?us-ascii?Q?FWxSc5+WDZ+zBBOOZp+OGYcA+XgHomwkzYpHdbO8bvwcKjDfhTF1MdJC3m+T?=
 =?us-ascii?Q?CYNz+weEInSZSDncMwN/DyY3WaLGCh+plPebdTMMpazxkTu/VT6gDd9mIsIM?=
 =?us-ascii?Q?GDYA34reYMGTR83EZSRkiYw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903f7d33-f5bb-4225-512b-08d9f14f6aba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:22:44.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzjHjZQjIopedmkp8/kY++khR/+fKmP5MljutFSO41pNQNNC1aGABlxpcRUkbZq2RsZU0SdO/HiSLB1LSjVeug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX clocks dt-bindings are going through the same tree as
the drivers, so add them to the same entry. Also add the git
tree and branch used.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66aa3a589f6a..277d5626702a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13954,7 +13954,10 @@ M:	Abel Vesa <abel.vesa@nxp.com>
 L:	linux-clk@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
+F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
+F:	include/dt-bindings/clock/imx*
 
 NXP i.MX 8MQ DCSS DRIVER
 M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
-- 
2.34.1

