Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E357B693
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbiGTMh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbiGTMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:37:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293214D178;
        Wed, 20 Jul 2022 05:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX61y7Ah9d28fp+fe3TIYp0cnfswB3TZss1FwJJUa++1LzeIhincAzg8Idpk3B1btySSZQtgpWJVuAzOA0SbSAtt4QK/LEnL6FnnVE7g3BZmYedg5+hYQfWLuFAubhelGYD/UP6yyVKHYY6+VbmyAK6sw4LMtaqryCa3xu4tqGKw//ilwwYzJUKMOFBxrYd1hV1kysOY9R3mCE6NL0qucX/F0EVFUKGTFCsgevMRutmVf/wKPgv9F+dzJMtOYdms92xJnNfu/Ab45eC5HGySt37ZnhoW3DcQ1h4SuFkp1eh0jADJbTwUq7ee/G1NYslJhL1srJylhzAnG7HWoT61zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C41/IRngKs6LTJV1/XfPR9Oyc/CqLQoR4aH7qGpgoE=;
 b=Akn6Hx9fu9VnOWhGKgkN/kSeIqEuiOdpvzyh99wQkEsNb3eGYVfvcdiYMYDpvm6C5hscqzo/Mzv7IaEnbSZ+E7q/qgRWwgqE87qT0XE6SpLVXVhLqbZBS+vBu7h3ogLBvVMLZZDVxi+RaMWT6FX5OBocTTdAMnjyieWIDSc8e5dAx3dkAUWwmSg4Y2r5+maFAT7JZ3SMh4kU+TIbt29jkE6jpGFb1rnCKqHZlHuNc/LqNJ14gnzyCdpBSWPaDhsyn/ZCjqLR7wT2/3EmWv3UExiRJBGQzDN+fN+VnxhxqjDhWFcOHY8lsv/T5JeqjdpDpWrIL5hnCAh+uogIxRxHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C41/IRngKs6LTJV1/XfPR9Oyc/CqLQoR4aH7qGpgoE=;
 b=l012jmP6FQujazfWg8K1MxdaiuViSdPeR/Q0tkWbs8RgPNdn4ZiUTYHmamclE1I62wtTesYo/hgkJZ+efqllaxgUPDt6ETK5f1J2Nzd9EAwmyG8M+BtQREg7f8ubx5p6kxGnNkUu5cAV7xuWkro3EjvQa9CwtOejO5N6eWOJc4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from MN2PR16MB2781.namprd16.prod.outlook.com (2603:10b6:208:e3::30)
 by DM5PR1601MB1273.namprd16.prod.outlook.com (2603:10b6:3:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 12:37:52 +0000
Received: from MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::84d9:ad3:ef5b:166b]) by MN2PR16MB2781.namprd16.prod.outlook.com
 ([fe80::84d9:ad3:ef5b:166b%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 12:37:52 +0000
From:   Charl Liu <charl.liu@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci:Fix the SD tuning CMD parameter issue that the SDHCI_TRANSFER_MODE is cleared from read direction to write direction incorrectly
Date:   Wed, 20 Jul 2022 05:37:37 -0700
Message-Id: <20220720123737.117-1-charl.liu@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::12) To MN2PR16MB2781.namprd16.prod.outlook.com
 (2603:10b6:208:e3::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ba0dfa-bfda-4a62-545c-08da6a4ca99b
X-MS-TrafficTypeDiagnostic: DM5PR1601MB1273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sVr6RQheDDnbLUfD1AF2Fu2SEWDAqeqkkgJ1Eh0Ae/NapoeTVvDX0AmVihTUtMvzfkIr5YHfxFndduw1RQgf0Agyv7SzmfB0a9KXEbcRCZCb2pKyhih/JYLHgjrk+6+OWQ5D/DItCoBK+I7pRXzLukf3cCdnNuISZd/1TIRyWqRFGYGpHtTK09ucDZJrdNzNojlyPPSi1Affswsuv/HS2pnshODbiGL64Fxn8ghz41zwM7oqlVq0uEV54iq1pw5yhMaWsbv1FrWLOCBa0XR5Juw+pqM5DTN9K0lmm3zu/9Qyc1vYEH/x3i7JWe3qVqkMLbMYzu2RhoWrozEULtteP4wOuE9YnZuyxm63uMClErXPh507XUyC9dNK2+Cb5IPebepOUJ7Bwdeoh2LSMzXSK8vcvu7Lvt/0Pe3VwUDlWJBupQPRByQ7PhbajUDVA7qLZTmgrmMiXQiwBoubQfXFa3Kgk8LtbJW8RmYpAKjDJTGTmKz4inN75nFiO0YulYD+hIe3+PjrE2hoW/abf7VRD3/2eNeBIFOkJmL0IQzmnMELNZ8LMYUuag5N4cHAKADkXv2jtjBMyoaKO4xl8oXsslPHU3QQDTKpBLvr90XnNvhvvDutc0bLLCUCrpSWweIpOcmF68C11MExLIFuoOjKWp+uToOyrIxL/U0cZYhWjQU6ynVGO+IBZpfqR+n/ia/o3KoLzo/nKKtseaRD3a2HdzJnoTNgO+tDY1ibqVUoK/dQ/xEg8/k3GQinyQ/yLwa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR16MB2781.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(376002)(136003)(346002)(366004)(396003)(4744005)(316002)(6486002)(52116002)(44832011)(2616005)(107886003)(86362001)(36756003)(6666004)(66556008)(2906002)(8936002)(66476007)(4326008)(8676002)(66946007)(5660300002)(83380400001)(1076003)(478600001)(6506007)(186003)(41300700001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//k45XTWJd8t9MbjTBQTSjo66WwXg1Q0S9Kgz6hxk/syd4hLcGQlUmRAAiHN?=
 =?us-ascii?Q?w+5Y35CJ13U27pakKINC1zEpfWdsXe/bmB+HjZPkPKWkmeRAHzocknmMxTAS?=
 =?us-ascii?Q?bwXBteNfx5iAf1rStoW9ymXkVFT8LMAAVVEg9DocAiAikeKvD+BKVMWYP0cv?=
 =?us-ascii?Q?BaFb40Ad/Lih7WFg4R/yzG4f9UavkWdP2RbQkJCiVNCGaSI4JO5QC+vSpKfH?=
 =?us-ascii?Q?CGYHhA3nhK/bcs9g6Kq6AHweSHpEi5nGXsHpN/hwmPFZBpgwKl6PT4ov3Ocv?=
 =?us-ascii?Q?ek8jGR+Qi4an6+DonKVEySuqHgwwPAv9DtZuDy75O6vGZnktl1fk6bNVhVlQ?=
 =?us-ascii?Q?MLOOiR8Gn0MXlDUcCCy05DGHvMHBeTR8isP/7lLF4nBiyph2GhmNN5c9xUCr?=
 =?us-ascii?Q?h6ZDvaOb8zMvO2R6wFfTHiXJmnsnkZK4wrMgj4RjbVOyavB1ICsaWEGDIqiy?=
 =?us-ascii?Q?ILEMkKYkrxnEBjq+agahE8A2hnKUAW0xcajPiBxxWS4xtqeyQP7azkSzzSAO?=
 =?us-ascii?Q?7VyXQztZvkP6U0TAYhuy4aPAKwsLWMBdvX9C8xkKH92v26krULtWPbCWqwg1?=
 =?us-ascii?Q?mLDEd+BTRjGD3ltssZ4Gzq5/XBdjeM6XyNaYO3gN4plUxX+KVAtYi9D52Qp0?=
 =?us-ascii?Q?eWAhktjgivohJbLq+FNEpkrk4lYLfSipIzSauObUNqgx2dGlV8qbOxSbjov1?=
 =?us-ascii?Q?VTeeZhY2t1hFEatkwgKh7n8Ca1wk+jLjIJCkSc+JC6/gzeCLNMoy8L040OkS?=
 =?us-ascii?Q?7KSoufLnWM1M9Bj/yFoX90YJVKRk4iT0W+1EPyCvUijBNTRg5IAGyhovtA2C?=
 =?us-ascii?Q?JFDcCouZPN+uMW67+eNg/EqFhAm0UPnCnNk6aADnEL3vS0WwJMM45/IdasoP?=
 =?us-ascii?Q?ve6qC7aSj7b+xKec8IiWjVUH4qYui822jlX3JgQ0Sdv0G9fqsZJUx7/ISXFM?=
 =?us-ascii?Q?ugXnNZsQNFAPuU/aixbRyQnIL2y+mMQGv0m02cMX66xhK/SyHzfJoc4yMAmR?=
 =?us-ascii?Q?+7iU8tEnr87Y2TvrjnvVXInDixjQ1RnaOjNPoTus95rlRwsvI4uBb7bmpm4x?=
 =?us-ascii?Q?t6f2UEhB4j5SDYIHMtgX2J33kbFj6PO2BnA4VBz6u1ZC+5G7jhAJiTP9Q3+s?=
 =?us-ascii?Q?o8OhjOsMP7P50OyiHnv3HQ3lisq8zdwJw0msDwp9Xi+qfe4z+p5UmqUjRYzr?=
 =?us-ascii?Q?AGQ7m8t15bQZVpz7VW532A/d+MjKLFTMdGw7UkfEqiD5hMWZBMF6drG5nPQC?=
 =?us-ascii?Q?+im3HfWUh3ob5fIQ1T77kkFxh50lT2R/E8QglzYa3kpZZJVkRFcQFLaIHjY3?=
 =?us-ascii?Q?gZUrUldcrTUsELheIbtKm9KYFBMLRjczH3UNeDdXtR2gcW7MbBNo1qUL0wLC?=
 =?us-ascii?Q?5dTud8tLpDurPmUnq8OANH/bCl4MehbAlaVaRpeX9DQQGn1JAVg9qtbpfD8B?=
 =?us-ascii?Q?T7gOwbQ91XhLTSiTbsYGxAap4MGj+4Bk2kkXkxbjtNfQI7HoLQf4bsW5q6z8?=
 =?us-ascii?Q?Y9XwE0SqMHcHOBgdAHQjQTbdESUdEXBsMacwwI96dhUXOIeCJB7d38pjtM72?=
 =?us-ascii?Q?UpJ80EzUcEXgoqemftj48+OUN9kLlHNBgxTz+/TbFgW4QI2foESQOoYRCJTf?=
 =?us-ascii?Q?IgU4e8Rp8niuRSpLWjXqUj8Ag2+z1+L7mTtLp0bd1o+D1MIG3BDsChD6Tjmu?=
 =?us-ascii?Q?C6FVkQ=3D=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ba0dfa-bfda-4a62-545c-08da6a4ca99b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2781.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:37:52.5371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMtwsd4KfLnVGdk5WLjrDoVSZkp05ZOQRHv6p9IDid+zV8EhYmTb4OZp6bmxTLzhPQlvfZoQLf5VNoTjFQuGIQjJ2M1K+qCYpMqi+C/dsr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1601MB1273
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmd->opcode == MMC_SEND_TUNING_BLOCK, the SDHCI_TRANSFER_MODE
should also be kept

Signed-off-by: Charl Liu <charl.liu@bayhubtech.com>
---
Change in V1:
Keeping the SDHCI_TRANSFER_MODE when cmd->opcode == MMC_END_TUNING_
BLOCK
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22152029e14c..6a0f6725dadb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1430,7 +1430,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			/* must not clear SDHCI_TRANSFER_MODE when tuning */
-			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			if ((cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+			(cmd->opcode != MMC_SEND_TUNING_BLOCK))
 				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
-- 
2.32.0

