Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B945717DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiGLLCq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGLLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:02:42 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55493AEF48
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:40 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-wZG3-wYNPKqevNpiF3vJYA-2; Tue, 12 Jul 2022 13:02:36 +0200
X-MC-Unique: wZG3-wYNPKqevNpiF3vJYA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0317.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:28::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 11:02:34 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 11:02:34 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: [PATCH v1 3/4] dt-bindings: iio: adc: stmpe: Remove node name requirement
Date:   Tue, 12 Jul 2022 13:02:31 +0200
Message-ID: <20220712110232.329164-4-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712110232.329164-1-francesco.dolcini@toradex.com>
References: <20220712110232.329164-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f46fb30c-d397-412f-de90-08da63f60635
X-MS-TrafficTypeDiagnostic: ZRAP278MB0317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: B+QLYnrX3PA11x/nW4UQVV7Gk8TDJGaSZbW1vmzdNMbHROYQV19SYQ42cjv/Q7NDgx8FliPc0AIT6YLrr0EKJF33WDmxdVA0y20cAynoVQqe2RRZvmcN81VszcEIbfJQfqzHXHsGVTjXMq60ZmgTv4wDKzr4cBLG7EnfXqPCCos6+jQ4Dx/PmpWGh2hddrrniIiiHqp6BdcFtIRhkgYBc2c6seDcDAWaykoKCOx+IsK4jhypkd7wYedmp6j3STBXLUuE67PVeAC8ngRT/4jMLZ8utdH3SkUGDXaQLQcdfxbH13OMN2LJsviJcIoREc9GvLRGW04zbV/uTfp82gU4BWCBkMLm3mNue4CFAvvW9bq4XlMj1eIrBYzP/htyPTgrBkvuTXrWhJVW2Fuk+psFJKS409Sbm2VkzdP1g/mkgZB79JmWO1qBhfVCqJtE4dzgheZxjdCQl3X2ExueeDQoYfbxQ30TIiCx+5GD6GnTd0AdMM64UNOvnjqk+NYEo0u0/fA+ouDZxBt6so/9QojJfrmAcLOr0VEzB76alZIvuGMNn10x2gV9I4V6XW98nU2n1UoCyOr5dWdXauEk81+LhDfUPlY1uUmGaxNN4TxeER3vR+ecqu+nM+Dbdz4gNX50fDRKtWV2Ka2KXsTrD/3lcQ6b5rMAVI4dZP5plf2YNRYB7Y2kznK+2cimaj1xL/THOlWI9XoEqmQ4MCtOOt8Gw6mW5eshOqhtdstWIKWl/7AVRyl5aP0jAIkDWM+4uWsGqiVlVKaebfFX1vAuGU03KzgxKZAKsnSEuWdUgwpASJ8pobVPz8ns4kqz9+cZM8OM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(66476007)(38350700002)(1076003)(52116002)(41300700001)(38100700002)(2906002)(186003)(6506007)(6666004)(44832011)(36756003)(7416002)(66946007)(316002)(110136005)(8936002)(478600001)(5660300002)(26005)(86362001)(83380400001)(66556008)(8676002)(2616005)(6486002)(6512007)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5hp3lCBY+T9sZGjgp4MjCqfR8ZZ2dYoe7v+9+gH2rhVJVsU8guDhcFJXg1f?=
 =?us-ascii?Q?iA6evZQ3YYtsMM5iYDP+WkrN06o8owNNxXBndzrsZySUgzt/UxX5MwubP/M6?=
 =?us-ascii?Q?5aG48g8r/dTJG5l74SK5KIxvAhON9wuQcNqvn7qNQuESTP7MHrrKcOC792CO?=
 =?us-ascii?Q?pa/jEm2SLoB7ARDa40RcQfgNS7vuHlZz5degPJW2T7cLvj90xlB1/eH0qRzF?=
 =?us-ascii?Q?1e1Pnv26CY88YfGvzsN8yHn1etecaaz1UjVSxcsk7bScT9s3VjdaZts8Wx/l?=
 =?us-ascii?Q?x9f26EEJLr2xW6TGX5DGx8tfICycfhzbEhfOBpNiIfm0IHpKmbBia9YFkJ0d?=
 =?us-ascii?Q?0I5oDOSAzcRv1IpnR/tA7IEp/iHFZs8y8iTUZNlVdDKIP5nTiMd4rvlIs9wQ?=
 =?us-ascii?Q?jr2OFKrjmsuwbl+Ogp/+nNF4qLpUvqVMULf32t6ucwh0JpaNoCPq9CECp2X9?=
 =?us-ascii?Q?AJWb4RYByzWnDn34VpPy2encneA0ccYWAdNaNHeLv48re7RlRlabjZaAp2Fi?=
 =?us-ascii?Q?1vociHA2e44mAPMbZvW3jLgUB9ysxY5xN53tFFQLLdhdoMpqtzLCF+6D5eYL?=
 =?us-ascii?Q?k/8wUSiEXjLbmwr1vbS3DG9HgfMwwkOGCXekTLLsZmknkjfnmm6RXjQ3EihD?=
 =?us-ascii?Q?Qj063hb0YQf173xZSI28hQOCLVHnYusPbd7gkkhJlGex3L7hyYSPmkM/7mF9?=
 =?us-ascii?Q?7PV65GrsE9nrhhM+oqV4Uk62n+eC4Jci7FPSCoxcBOLSevGC9bsDdT4P0+JW?=
 =?us-ascii?Q?aCcgS+OoQGRd8uG7BMow+g1/MM75buMStz+IerG3ijmOwL0dCe6DwApGVeKo?=
 =?us-ascii?Q?ZdEsiTkiZ6EQEUiK4LwWYckp5OYcz0EWfmooTHDm4Z5jFqnbSmfVhc+CF0B9?=
 =?us-ascii?Q?8x4HRm2aI9iWqwicbfdjuCIIdVPHyz7UggSV0aKF4UHzO2iZJajx84MgPOPS?=
 =?us-ascii?Q?JD24a4LnUYcuRer98qLxtOKaUKrxJc8tPjvyMre3Y1ZEx8myqdaoyG4OkXm7?=
 =?us-ascii?Q?iQ2x5L2kE0tJelICJwNt+MFG/BDOgp3fmCAK7bENXvRTurYWPlqycFAZFTTo?=
 =?us-ascii?Q?6YoIO40d6EhOd73oBek4GSuDLN3L2F+G1Gde6O4evvOBJvMDaSs10JMFglp7?=
 =?us-ascii?Q?Ie6k8bRuVTB2V7Vm3wJ3J++kH0TtiXyKbxgrR8UH00pWw5k7cc4Meiv7OLbD?=
 =?us-ascii?Q?ul1hJN31icfs1swEsLRPYMNVHtwqqnV5+3qRQVaj4kLed89SxB28X4bQjpPw?=
 =?us-ascii?Q?8qp3beX+YrEltjXTyw7MfBK/aOBN/tsFakkY0iurJPfSgUKbvg81I/2NxHNP?=
 =?us-ascii?Q?Y4iuWX75+nu9XMqjkwmwdX+dVMSPW3TsAFaXiUGWKPEhe2mSTvSF8YRaaK+g?=
 =?us-ascii?Q?7VpJeagTj6GZXp8TacaACtfzZgoP74NiSJlpPjMgvuy0Qf+1Y5U1L9gYPtg6?=
 =?us-ascii?Q?SwJuoNl9cC60Xn6Chiw41e+YO2DTtbm2oAWZiBwdWKRHYZbYZ9nY4aR8LgGn?=
 =?us-ascii?Q?IXJun4NzB+Ki+wAz6BP/X67jiEJymCtqOxQoBq4DqavuphaG7JqHtdb53pv4?=
 =?us-ascii?Q?3r+5Qp52QETPmtOetirsha7ME8KPU2SLbZId6Kc90IGqzvZX2cOK7C5+AdFR?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46fb30c-d397-412f-de90-08da63f60635
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 11:02:34.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAlbAdHQxokQeV8KSBduawvslQfXsHw+eJthIQ/BewH//vvnxeKIe9QZfRQCiZEGSyEBb/BxknR5ayCebClzWQGgrkbW5RH8BavEWhnI+R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0317
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
 Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
index 9049c699152f..333744a2159c 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
@@ -13,8 +13,7 @@ description:
   This ADC forms part of an ST microelectronics STMPE multifunction device .
   The ADC is shared with the STMPE touchscreen. As a result some ADC related
   settings are specified in the parent node.
-  The node name myst be stmpe_adc and should be a child node of the stmpe node
-  to which it belongs.
+  The node should be a child node of the stmpe node to which it belongs.
 
 properties:
   compatible:
-- 
2.25.1

