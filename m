Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E2572101
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiGLQea convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiGLQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:59 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E63825C77
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:56 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-YhE3n9sQNaiEuQ0SLJnAOw-6; Tue, 12 Jul 2022 18:33:54 +0200
X-MC-Unique: YhE3n9sQNaiEuQ0SLJnAOw-6
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 16:33:49 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:33:48 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: input: touchscreen: stmpe: Remove node name requirement
Date:   Tue, 12 Jul 2022 18:33:45 +0200
Message-ID: <20220712163345.445811-6-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::33) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef14eb12-6841-4609-3fbc-08da64244c09
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: +OHKvMfKQtyjN5h7PV139KkarzLijwAPlwtrwS1sbqVXNLpqDN49j9REc9dx7F2HB6O3AFHY/RQyz1bcNKH/RV9Ws3am9/f/c7tI6TUxKflKq+Kx1R0KWJa8O+FXq79a8mve8XLQX+FUlSrIi8o21BCVHL3fQXIfpeGNt4Rm3wd+XzsHT6guJFMonHia5Vdx1cmOAi1Ft+Y0WWPviR1HRvlC6o6hCQ80jx9tVn6aKBscR4T/JQFypMZSO+spNNd+s4/ixxUqrtinl5z694XEZbOVOakXTe2/DWvi8iWkOPAYm6Wq3DILYmu8d4oVKxmYan/MBfc4/CV0BBJWKCUjv2uR3UD5DIJvuu5VrHHR8xz4V+jrXNcHCqJw9Habpljtdg8qnH+i961lxmUh9dxAO3xrtjpswVDyZXgThnLSaqk+pA3zfK7VUj6G3iZfKfeUZ5jM1F3Nf/IeIR5aNV1LTZERBZzN7JZnJNfrt9a36mMgk6Q0B2N13uIweDke+g+8B29Rrni7i0nHxE+/vvkZtCmNjnpGDHvEyntQdblZrdXVLitCTITUq/cUwDotKIpVcGJyiJCDaF/rniGVxoklEjQfXjM3ydL3J/dQ/umGRJkPl+GI7DVxw79NExyuWsBSc2H8xOwJONF2WhBYo5TLaqkow1YDkkYLpqmHfjTCRwcfjgpm01o2My+N52cTwYvojgeWDfL1SKD6dNfSu/XWUd2bRgszS0yzj2zaT6D3OvxXiqnLoWiQ9VYlJKZ4GKTcgUNyPQq5BEu2cnz+ccQMA6uBvz+o1ZoEQlmfBSRxmPjRnN7WYUwTSJONaxSNgfKe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(36756003)(6486002)(8936002)(41300700001)(83380400001)(7416002)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjPpBsTfWm/r3Y8NOlP30kSyZmEZn2nvlVWSvxOiCCnI3/sPbOZ+SwAdUP5k?=
 =?us-ascii?Q?1plglscyLOSj++6N/HQ/ZJSLkANS3yYwiBVQLTwqRVf6XM2BNRX2LX8NqUOn?=
 =?us-ascii?Q?SKhFrWdxcOuuF+L0gKLmgYRG+1nvpX78+uneQnsW39r5gHltvj4PQ6IXDiPb?=
 =?us-ascii?Q?vJqUa3EFDfq7UMlrTqeUbT5vmlk5r8wF2h8R5mWd5IQcpQLHvl9bKldn8AOU?=
 =?us-ascii?Q?oLLEPYoW9hezc4DFaVpyQIOylunKsFS0evNZXmCab4IZXBrpsXnEFc1ZV5n3?=
 =?us-ascii?Q?nSfb/AR0+XmECv3XNbB1Ng+NGEC7SAyRBfHinNCZ/5jF0HU31jZiVLDnKitc?=
 =?us-ascii?Q?uWpN5aKhMJwASCJQjttXWndK3BFfnrPIlJ5EmdUOr+spt0hHyuguiKjlVSUb?=
 =?us-ascii?Q?5Ncf3pP2ktfR4PlI/ixCn6Q96CPcURwmm2rxxV1YyIn9tKNl6p8XD1G6wxtU?=
 =?us-ascii?Q?CIjhUdZEB49MwRRDUOgAM/UVhCE770PcuqSwN/mIEMrqoO/S+ARM7jawz+XS?=
 =?us-ascii?Q?EMFQyGKFhMtZ7Sy4Mi/P1ss8M1wXfa2D6q3LAYLtd6jIIJh4eqTJELqpdr3M?=
 =?us-ascii?Q?0ca6cavq2zDNaT8I+NX8bkXvw402hGyc4VOkkdh5CNk9A9vB13z5HwKtpO8P?=
 =?us-ascii?Q?nmdxX/lcGgq28RLZtHvVZvjTMKQV4npPvthTB6gSlTboAJdnMRN/J1lZMx9w?=
 =?us-ascii?Q?d5i2PEY4NqOMuvwsmAW+mLmqACzLjq2LfIBI1GvFRIj+pVNg7Wt3VwXPM7vy?=
 =?us-ascii?Q?5VfYXEAOZOOBOazchbWCEl72JqzxkBOBx1bqf0e2NO3wI4N/mFzpbngLZ596?=
 =?us-ascii?Q?U66Mp26DoFiP6rmcWHRq+y1GyzUxINQQgNHF4fnXbxioNFZ/T5dTiLlFKaJW?=
 =?us-ascii?Q?l/sDIHClXV1HON4r3eVqY8poJHSRbkJyYIJjaw6FBHPBl/7vRA+EOURf6RN8?=
 =?us-ascii?Q?2XgiTaaGpzL8Ho+hcUD3rAcgnew6it5IxBF6tNDYoZQoTXv0T75o2xxn2iHv?=
 =?us-ascii?Q?3GQaPHn/lxgOp+RQu+PhLfEMCBtFkMZkUXyMymXyUcDM54EVqK+MsOVGvAtY?=
 =?us-ascii?Q?zB9UrnRGs3l8eITUps+aZBzzchEDr/qBu1YjAXvv6BM+O1nlu96xU+dTqsdr?=
 =?us-ascii?Q?qymWkOIxReEd7lT1a/Q516Kt5Yx7rtjtujC7W0DcqeXx7pUKo+sOJ+9Oplm1?=
 =?us-ascii?Q?w1pjjo4oOj0qoGAqcgKFkTFsT8PDxhHRmFhP5XejwA47LmG42Gs12gEQ0cxr?=
 =?us-ascii?Q?FzLdAsvuLcP5TyOtedGGGKGC2TOkPVlEIQce/oOxRxLM9y6rbK680BO6MdsC?=
 =?us-ascii?Q?uIv6D7uStDc7UihgtPIYFu7wYnwmW3kl4HxJCg/UZx6Vq0J6KRBqEXBEBmD4?=
 =?us-ascii?Q?KBfFj2tVn/mDfx2VsL1/MmGCLqB4NuvxR2vCXfKgFskzfv83pDz1cao10OwB?=
 =?us-ascii?Q?um8VdPl2WJKxi4NyBIp6Hd1kJ4RZwbQHpNdQOayWHpSqHJsu5UHvYnXjC4+e?=
 =?us-ascii?Q?rV03eDHA2u6hR247O/qOL0aU0a/+ptDSdWtz50/wquW/p/B9Kzit4M/WRNXb?=
 =?us-ascii?Q?/fvthzRzVcG8bGpAXacXzNFPY4RqgEvVo+XT4pd4HBFtl6Y9lHe06FnLCZZo?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef14eb12-6841-4609-3fbc-08da64244c09
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:48.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guYmCgSURjfA0WIhFTUIQbHbynKZCpkPMWD1SUNOSzi5EWLZ9+ASIXj7Jrwdrxgjik2whORtIFOhfFDUCoGRwwXdS7txJt8U5WluN1Bugco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0173
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 Documentation/devicetree/bindings/input/touchscreen/stmpe.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
index c549924603d2..238b51555c04 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -54,8 +54,7 @@ Optional properties common with MFD (deprecated):
 				1 -> 3.25 MHz
 				2 || 3 -> 6.5 MHz
 
-Node name must be stmpe_touchscreen and should be child node of stmpe node to
-which it belongs.
+Node should be child node of stmpe node to which it belongs.
 
 Note that common ADC settings of stmpe_touchscreen (child) will take precedence
 over the settings done in MFD.
-- 
2.25.1

