Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2265720F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiGLQeF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGLQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:55 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4056E13DC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:54 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-lXjZf_bWMVmIFl8yF1cEaw-3; Tue, 12 Jul 2022 18:33:50 +0200
X-MC-Unique: lXjZf_bWMVmIFl8yF1cEaw-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 16:33:48 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:33:47 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] mfd: stmpe: Remove rotator block from probe
Date:   Tue, 12 Jul 2022 18:33:41 +0200
Message-ID: <20220712163345.445811-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::13) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c48593c-4c2f-409f-a9b2-08da64244b77
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: DzNsB8jgWf3EzASoAEC3cEf8DSQsDVIbh3M0iurdaDYGHFdcbjDHp5YUaFlNc4IF/TOsCJgxsuvLjYJ3V3pMjfeUP+DaOHiATyQOB7wEojrBhvlujU6KGJNkUjf/g2nQM2uH/41tZgLueOZb7s2ofDafgYLdDTi1U75ZSLiCugWelmyL7PWAYA3eKlD2QRGDE+LfTsgr0Lbv9bL+UzI3gnZ3xmCRmuXIdbv3B/muAMySlmolsd1iXqEodvoTNZA8P6FJo22ncDD3DkD7tvPYtvEGmNLCyownN8ONuFJxyESS3MNB3KeK6Ev1Em+nnjmRjzav8+hrs4bpCw0sGKYja06WFSV2xXvGFZCbijfVznAkqrZyMRrs4ps9GUG+/eu9sxXHJFRoZC538m9JdzEu3Rj1o0EuOrLmrl4qpex4FTS16qCpcdvw4P1oxCrC3iMGsfsUyGnzt4sMyeUIwc2rnNVFVG8p4dwL/Nd8kxvJPH5GM9HDKFgP1l5YNcx1kAhhIs6pJ3Bsq8+qUZ/KnuItptS1MlnErE96IuLvS6+ZmolesiJo75mSw+omT55wVzZFLCY9HySq2pKoIkIUjPUpUDmvwot+nbN8KWiUKk75MJ3QGo71UnKTaK8vx5YbhxxDoMm4reOptIRcsdrafVWgkd+jtbZAuWQW7W02yw3/W5BHAhvZNyBD4k4mYuyJ9amiT+9yRAO7Z6L11FZWIjm/zihJqIGLSFrXiniLpnUuP/NWKY85g8BypLpOzZtA2Otc88x/2ji8IWlcex2UzzTSxxU7bnZ3Yt7emSisTyRT5IsRP2AzIJN5M0q8x06biPSs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(4744005)(36756003)(6486002)(8936002)(41300700001)(83380400001)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tgYNDfB/hdOTNpML8YeG1s2TVu2uOHp+yrJU0rmCFBRa8OWpBIDgUQLheY3Y?=
 =?us-ascii?Q?XLZzmcJR5y6kjDef0YsjhYcN/+JMvp4CRIxvD0cq6zKp+mfuxje1R75Yx7s1?=
 =?us-ascii?Q?eJTbJPdbEnE9vVjLyWM4TWmzaNe+T5Ms81+luFqDnhGQgkYAJYu4L5DyVoIE?=
 =?us-ascii?Q?rkhg/CjgDc+bWpgLsEEAuyWLc/PmCyFjwQfXkCy/ghacKBGUMiZo2dew6ye/?=
 =?us-ascii?Q?ONqHF67WrF7Hz74HqbfCdtFfg/I8LRZ7toKqm4tM0i6FCwtkMLAKbc5W/avS?=
 =?us-ascii?Q?xWSPcpkt081pVtaqdWidvusGqzuUyVwJKjIEbucRDX5WAAywM/99/LYLB/hW?=
 =?us-ascii?Q?m42HfH6Sa/QAnzLdkibH8vUUzBavwW4gRR1cbQsC790k4BR8pH/DWxDoY9Aj?=
 =?us-ascii?Q?S09IbmV2faHpF1BSm7/kCxoadWA8QYVHaETziTlZIOfEx6MIiMzkqrbnR/qV?=
 =?us-ascii?Q?xawHcD5iubQ4vyx1t851CvUcd/yNZYsol2HvTX4L9jc4fBuDTnv6V8y+btQi?=
 =?us-ascii?Q?d5Z1G8BUNNFe/UKsMyV7rnJezdSmigZ8Q6lWIOwVHy9rKkwXdgVFKjA0GBZa?=
 =?us-ascii?Q?RmMSXyWFsccZhs3OzRrwdMRF81OH2l0xLllWdWEC9kfBR2X/2ICuaq4nGDm4?=
 =?us-ascii?Q?aXM+DuhYvT+7wnyWbTd5j6PpGgPHe8Lok+py1RUVGHs9saPQZtRdaOPFET/D?=
 =?us-ascii?Q?jNpZ3QuH9r8X2pn9mxijnnqSpx07X+lA5lfqp7jreNiYUXTIb/EkzUCudhe+?=
 =?us-ascii?Q?bptRv0U+BbuWZzeWjC6YFxB+hYUdgHbfsDeK/qEOJUdInnc2XnZkjNPDFv8T?=
 =?us-ascii?Q?5GIEdc9EQh36ZjFKWiV2lylHvzMCzmDzWQJP9Bc7qb6y4ZdLxWoUPvl5u0o6?=
 =?us-ascii?Q?zV5py/q78rKHvYIidL6ZR5S+Dw3zL502co3mJrv0hOO3n/kvAV9GHY3PSGbA?=
 =?us-ascii?Q?5/cZ+7PR+gabRiM+usoEPdwPPMH5f7L9X7yZeXA8xWiq+tJVnvhWBUuUjJzO?=
 =?us-ascii?Q?Pt0CsuHFqa/xRvuVzB8jC5O7EwZRI40hgZHeNTwuSCFIzB812deViUHA5NDF?=
 =?us-ascii?Q?jucQ/fs58Vf/ukzpU32TMIyv8/UnN7RcF1wzpQEEpBLs70vn0eDVWiEZ0DA/?=
 =?us-ascii?Q?QUMx3eje5844qYXt4ulx9f/SwoLkNbdW2CyHJ2/JHfIF5MwgHMmqH7qPUkS9?=
 =?us-ascii?Q?zvb3FN/bE7wFe/kRQJMdsjbGxGLVm5sApdREe6+yEIjivM2pi/pRCY/Dpf1o?=
 =?us-ascii?Q?2hkiQtKxfGtPEFBSbwsyeAcLlvTG5wdGcaV5Ch6MaUznvBUZ6T+xxrWq5Avm?=
 =?us-ascii?Q?MWDtNFUtRgl4/Dd4b4mfgTuknE38+l5hwDJ6nRhigVx6ZXhXd9KzqyLpxbih?=
 =?us-ascii?Q?dX+G5evJpmdrF1wpklqXfazrApFEDZYRHKn1ZJ0mpFJ1oN9qq/r8Hx4QHQUh?=
 =?us-ascii?Q?QAaosa1/vRjLi2EKU5DWCHZrUmNF28YNIs1lm25gwFaGy6Q+7/dEtqdtVKUW?=
 =?us-ascii?Q?qpP6R27K67AVSg93sxHaTZyM0XB//gtoTsQqq4M3wLlU5JqaLb6LxJm63tLF?=
 =?us-ascii?Q?m7nLLNWeSvjHcbL8BYk6m1FekCrJVZrUwhesWg/5my4vZpG/9BQMMNKeknOh?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c48593c-4c2f-409f-a9b2-08da64244b77
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:47.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEwaokeWcaSAoF0IYi9Jf0RwS8Vws0P+DzLr5Cenp+dT8NHzNhsdX2wV/yGmxtcQYY+KbKQPk0JEICalmxApNlETehPu5Kg8gVchJMMxZBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0173
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rotator block from probe, it is not used in any device tree file,
there is no related cell defined, it's just dead non-working code with no
of_compatible for it.

This is a preliminary change to allow probing by of_compatible and not
by a fixed name.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - new patch
---
 drivers/mfd/stmpe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index aeb9ea55f97d..4aa4ac2ff406 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1372,8 +1372,6 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 			pdata->blocks |= STMPE_BLOCK_ADC;
 		} else if (of_node_name_eq(child, "stmpe_pwm")) {
 			pdata->blocks |= STMPE_BLOCK_PWM;
-		} else if (of_node_name_eq(child, "stmpe_rotator")) {
-			pdata->blocks |= STMPE_BLOCK_ROTATOR;
 		}
 	}
 }
-- 
2.25.1

