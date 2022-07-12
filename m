Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A25720FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiGLQeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiGLQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:55 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7538324F26
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:54 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-1gN5Sj2RMx2D2_rj_tGOhQ-4; Tue, 12 Jul 2022 18:33:51 +0200
X-MC-Unique: 1gN5Sj2RMx2D2_rj_tGOhQ-4
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 16:33:48 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:33:48 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name requirement
Date:   Tue, 12 Jul 2022 18:33:43 +0200
Message-ID: <20220712163345.445811-4-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::7) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 707111fc-4bc9-4aad-a9b2-08da64244b77
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3Ln/9lwZwSVaMArEvyXG/rSmmURIur93y7g5BwNtZZmH2oLRIyFtOpyfx57ooEf/YI1CCQXKO+B3/9fW5Lpz24cZG1Qz0+USkhBXZipl/2u5XFEBG8M9ZYh//mCq2L4sFXGASpZjeJ+iYv33b5aK1hkXDBUqNZOS2L57kECot7rRs1FdOKvO1B1UrXE9ICGOertysGFL8n0oTNstD1NQET3MVPPORRcNY5lC1I/wjyr1Y2sSihvjQo9o0dm5e6rlWD9RQX6goOGBOCkE/AoEl4iaKb9jTPTDKhQJ6ouNcfK2o+md/XML+cBtY9Mj8QuZ9o0344KGRNX2DuwmWPVAIHTyEgIfd/zm5taI3dO8rBtD6gpRcNQKFtVwXX0vRJpYBFpyEYh/+Uk0SEho6E8buxfvv8DimvLFKE+rFw3rq3CmOdyDxDdAvGayIEDob2ZHCkP/kKHFSlbT6YHtlvINMjhFVDO2wgbZz6TQ2HURd8BPT5Zg5lMTraLn8H8bcIxMtYPrH5jn8tZmS0Sel5gYK7pC6OUX4Pxv55oBAZNeUg36Hmmu62Z6BB6qPyawlshOzaw/Zinc/JG/eodIpArPNGftIvLXvpxlwwpd5iNDq3i6GJuImdAd2K7YS3gMkHX4gvd3awPXa6QMQqmBOdWXOuJpaOpxHgBSotXNGoTb1f1wBfL22APfA0TyMc7POT38A/KxxIo/75KWU/MwnSA6g7y4pnjuiS1NWblr+MNWWvWESYa7D0982hmJDYnYCwcNxDGk0ldUESEh78p+nRROXq+jqaXLsLgly90m2XTiMBr8xxHI6pL39JQ8r+kkZL1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(4744005)(36756003)(6486002)(8936002)(41300700001)(83380400001)(7416002)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Or+D/Zuo++nlwvdkKnHTMaR/9ojgyjPk6wQGxQPhOdUD2F7k4kSnEj5xJqXW?=
 =?us-ascii?Q?SFXpod/VnzITByvZiUOXk9TRxcy7T3nP97FmgjJsT2W2NdzSyXNXEmTDwV+S?=
 =?us-ascii?Q?hf+My/1mLBG/j741ziOJbP19e5BhNxHAY0P74HqyxdrxlyZ83YONBo0FsHo5?=
 =?us-ascii?Q?+e1QkFB43ARnxkoiC5xBENhzpa0rEMqpOj906m+wXwiMeefGUDy8e0YbY9ON?=
 =?us-ascii?Q?gb9FZOlCeqgFRvf2zf6H6dyk0IKi32x0aU6Z+FDC6Msj2PtFOeo+JJLoJcUT?=
 =?us-ascii?Q?TzkXsPv6RpAb9WFN7d6u2u8SMYPlWfDYJSBvPAVeLDVdcAkhOb91HKH12Hrh?=
 =?us-ascii?Q?ruAnNgDlUS4FDSB0pKLZUB1vAWjLaOBLC3PgOiuuGzVroQmEgQ2UstwoQ+SZ?=
 =?us-ascii?Q?u0xnbSLcrDSMqIEmTARuf4FrkcFat6czWE0Cmvw9fHLPuX6y8YNi6R22pxej?=
 =?us-ascii?Q?xtz+rWWfXTDiFMSnje59UE10jV0ClTzwH9WCQxfV0jgAQ9zNYppQcegDFHO1?=
 =?us-ascii?Q?LESqzdhwTB4bHVf7VDdYfnA6+zxlXx3/JeGmti3Feuui68VC5T8MJh0irWQD?=
 =?us-ascii?Q?qbVRr7AOfxtRQDqSZXTKRZHU/wE/LFdbQpT/hm/lsR+3xUidhE6w5Zuf2AHS?=
 =?us-ascii?Q?4wvpjK+kAb7a/Cz7sHq0VtZjUH95z3TJWg67T8hsWjcpLsWBjotHkhJc2fUT?=
 =?us-ascii?Q?BcTMprkze7mBL2bRre84K24tb9fTlMVjD56Zi0waOYv+MPkrLJCu+czOenBB?=
 =?us-ascii?Q?ciR/hmr0EyiBKiLBktrJgv+A6iDNIGjrnGtt0iBv07ilBrZIllzw6FILWZha?=
 =?us-ascii?Q?l1PoXvIDqD4St78pvcEvXBfFIHDuSPvcEGHJeRYUqK+XTIABEh+c1EY6iDe9?=
 =?us-ascii?Q?9ZR5zROy00Vo4DiX/p5pnGPsy/m2i/XaBA3uZUmnoNHgxTWKA/7N9TWCrpMY?=
 =?us-ascii?Q?yoKvtjpeuQE2tNEvb33KbaarXX9lNtzdh7bJluqTOY/8glp10aFYlbjiDR5W?=
 =?us-ascii?Q?KCYQq71jjwVSb+T2r0vExnabCfBmg0IvMV0F1Ljoz+qXA67+RuPOqx6Hm/xM?=
 =?us-ascii?Q?Q/QkQi39a1rOAqPB/GUOZy+xyRR3bd0i0mScBZMt5NzyUqWUzXx+ceweBZLQ?=
 =?us-ascii?Q?wffuaxwQGgWls8IyH6exNKqA+zQiNtHC03rbkxsN8+4TRi/uI6rvEPLq2ZMz?=
 =?us-ascii?Q?45lOssAFH5i3HPRIi4PLKT7zzAZTGEoqJM5YD6STeUD2HlWn8QaW0rvl1CKm?=
 =?us-ascii?Q?fNbwnslzRKzrYOE4Q6iAP4lk/W6tftzInKyaXAEsr2tW5VyS4u/yEPfSRkM1?=
 =?us-ascii?Q?PXq2cNdKGNbT5bwp2ETi2WlueMgmsqdzhp5CJPgeLdCG1gqzT+//Pbc47KBx?=
 =?us-ascii?Q?XtpU4hk7KaUxr95VxxOG2xfu6b8VAXpQdChAK3FJJtz2/eoFduPuQvKeShg2?=
 =?us-ascii?Q?3RIJ7cyGdMMP5jOMK588PWOlqeMdFgheG3siMNEGPxwzMzXvYfU9nByWQKnB?=
 =?us-ascii?Q?/2iVFz1TtKcX6sBvgt/TpWETtePjoRQGqcsVvHyk4cLmZg3SuHujmzn+yiXF?=
 =?us-ascii?Q?YNebDJSIytNntFBjyWMa5l2DCzAiWsO6yBFfpivN5fUL/XYj+V9IqvmHM/TD?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707111fc-4bc9-4aad-a9b2-08da64244b77
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:47.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGf3P4U6dPMyX7jFZ1VfwRF+FQiJztfD2oaRD8CrODU7lie5JljKxGYn3YhQS2dIcnQW2LqFvhpiveBXlB6cDzNAJsbwU5xs/BlAnd3L/aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0173
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
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

STMPE driver does not require a specific node name anymore, only the
compatible is checked, update binding according to this.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/gpio/gpio-stmpe.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
index a0e4cf885213..b33f8f02c0d7 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
@@ -8,8 +8,7 @@ Optional properties:
  - st,norequest-mask: bitmask specifying which GPIOs should _not_ be requestable
    due to different usage (e.g. touch, keypad)
 
-Node name must be stmpe_gpio and should be child node of stmpe node to which it
-belongs.
+Node should be child node of stmpe node to which it belongs.
 
 Example:
 	stmpe_gpio {
-- 
2.25.1

