Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6856B9F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiGHMoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jul 2022 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiGHMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:44:03 -0400
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 05:44:02 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35B362CDF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:44:01 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-JerLr2i1NZOaqugu-aA0xQ-2; Fri, 08 Jul 2022 14:42:30 +0200
X-MC-Unique: JerLr2i1NZOaqugu-aA0xQ-2
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) by
 GV0P278MB0353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 12:42:29 +0000
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a]) by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 12:42:28 +0000
From:   Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 0/2] arm64: dts: imx8mm-verdin: update CAN clock and interrupt type
Date:   Fri,  8 Jul 2022 14:42:03 +0200
Message-ID: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 492d7b37-0e39-46e3-03a7-08da60df517d
X-MS-TrafficTypeDiagnostic: GV0P278MB0353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: KyjHoRGq3x/FALWfEYDbf3SaiRnqzT3az5Oa7+5Emc9pM7BmSEAolAXRC22dh8ce8uCFvip2LbUoGVuHfN2lDMXG15dANsP1h2zSFDklkkCUyvFTsAz0TN6z/Zd5R8BN0G1Jdl55M9QU9odr0kVlRBGbn0K25LXrKepy26DT7+bVIXnM9zSD7Nt2+1cYtD3ExDfxrmNdbBF7WK2XYbONCyRjLSJg0fhHllcpy3CAVuJM9pap+ukEy9t2N8tcRJvZML/5HPQSBcll2r0nPOhXVCFCSL8hqxzPrGtcNO2s33mds3tsPvhRTQ2o1YQqnjObiurO2EOfjToVHaKxidreN0B+U6RrPbixn2IJWEa8JzfH4awoDUsK/CxSZwb6nw5sLduIDvLqDMvAdWRFVxkJNAGRw76P2pbNXrR1ocVBtJpBdpLeCyOns85W83UZZG0i4HxUxBIyN4cQvpGagezea4VNfa4szgrDpiijenpTMZh1JZagBy6rB9k2mcdUOUz3qLBXglr0xcdQyrlAOfPnMg4frJ/woGi/sGEKpO4jOPnCLRVHRaF0rUzQK897nxodf9OAsjWYAFY+sSsfrr0C3bHvf3XTb6GqVx4C4ADK7CPUrzDlDIHrR1oefE4dnAIyPA2wpohnKyjB+LTwXQqsOxz0rT34tRK0Mcb0pB/H+7Q686NHQzGNs2ZVcysvlfZ/CK/Ybn9CjYPuPNAOQuKwOTNXxJ0EN085u51rI25oXKRcyfU8FpnACT3QqaUUV9SDvAS5SmwApXzTkyMvhVAVhpnVf/6JowyxRFWXHp/mkFiJu1sP6ygOxCxTxwjiNVPpBDuDm/ih7FoyJyezb5X4NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(186003)(83380400001)(38100700002)(316002)(110136005)(54906003)(4744005)(6666004)(44832011)(478600001)(8936002)(86362001)(7416002)(66946007)(107886003)(8676002)(6512007)(2906002)(2616005)(5660300002)(66556008)(1076003)(66476007)(6486002)(26005)(15650500001)(4326008)(52116002)(6506007)(36756003)(41300700001)(38350700002)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++MFkLq0ne7zX+uB7IDUkNoHNkbKTRpCnccu8MR/8UP03K2QmsOLM7glJaIr?=
 =?us-ascii?Q?gLCwyTxDYHA2kUsz+ONHDAue6tMG9uNcbEcxoxY7GJAvEwXTaXU1Q3x+01l5?=
 =?us-ascii?Q?bfR76kwLAL502xjoFfMXhQdPUGXXbgQEoXGk9eb55OIDrtlkRWqQSoheGMW/?=
 =?us-ascii?Q?0DDkqQW8ftQFUiS1JE/dJwRsAkKEuTqYXH2JJTsIrcOHnJpIRl6r+o91iMRe?=
 =?us-ascii?Q?ypLaeX+tvdiGspPNsgVd5Qf9lexNTDcJaxq77Ul5t3CTB+mWnajRpbHRSwvj?=
 =?us-ascii?Q?zLtDhhh08lZzuvdROwYfjuixl5sQ1lNOm0rTg7xqawp6G6VgKF8qUnevy1iB?=
 =?us-ascii?Q?QWVEfTafJ8bpFSAXUm+NXsmnxFGxAJJsjUpi2+SgyzFk6bB0fNvi0Q9z8O8Z?=
 =?us-ascii?Q?VEixr2hU37o7LT/3k6XtGmzu2Url709AZL+dhsL6RKC79ZK00kCd4ZPUolXW?=
 =?us-ascii?Q?ow9M15PC0mcreFd2J9Xl/fJsoDNSXN+urJPRXhrl3u9yyBMybjp7l5bxwlT7?=
 =?us-ascii?Q?Th1ZGAMM6OGxcSbtbhmYhhRcbQOD4q+DyqtBPHMEkTQgx5NyzqVX5jEJsGcR?=
 =?us-ascii?Q?ppoTWocLWYB2mHzzjs0zParnofF+66ZriZ9p9ZbFFcrH6aEVpgyGuJ4TQ1Im?=
 =?us-ascii?Q?CYjCpUZ7mKY8/5igBR/ADNMS28y+qrXuycifeC5qE25ctS22ufPdxOJg9rDC?=
 =?us-ascii?Q?voVUk+UYZnn0M9hWrJZsV0K9h3g5biw6LesVWV2qkfWSmVFi4TikDi/2pfUh?=
 =?us-ascii?Q?E4IbbKbZCCvOcN3VYiq7ASU7/h5QcWB81goGAv0N42Jj4nY8MYCE0qjYfEMm?=
 =?us-ascii?Q?eY5xEEbyusZ0LZn6HTM6PYt+EUYya0dQluHgXKOBCwRVAoIxAoriVcIG+r0+?=
 =?us-ascii?Q?4hxnhxzWpWR1og7qJBmOfsh95FvboV19XQulXahb6TUPBe6+BOQIh0k5P5QG?=
 =?us-ascii?Q?7trscyUg2VFNJ9C2OwA6qTKiZEzHBXL3ROQBPf+Et5ckBtVv4+DRzw1NOBQ1?=
 =?us-ascii?Q?jMLSnIuGG8HRDuaBh6aqTkitcumQJ2qDihoTXU+C2r92kwIU9MEm4LCu9PS/?=
 =?us-ascii?Q?LLt86Of+We5f3aMNCv6FW77mwuYxx2t1xyFqqakUEATIYtw/ODNOg0W5l19N?=
 =?us-ascii?Q?XFPFnzQR23K0lfaS78+d/ROnZi5FRWcsh3RRFZDdZlgu3zCKGa5dHYQzGIfE?=
 =?us-ascii?Q?5xdzAfETXHFMUdsB4Sd2t/ODPyLsddgagTpze8/w7zui3zOJpKrCoIEGcbqx?=
 =?us-ascii?Q?bsk0X6qF6tg/EPu0LK+MSigI96ydjVCX9SqUgMcwVJmL14U7rBvWgACXaKsU?=
 =?us-ascii?Q?E50CadHG57L2N/02Em464PBvWnO/YG0JvO579arpMyFRhJriWX+xbMfIG73S?=
 =?us-ascii?Q?E4PEpYZ1buWIiT4iyyDnh/1PCoIUuE1IEPFEvPIvkg2ZRWVbxpePW+i32BNQ?=
 =?us-ascii?Q?6ZgZp5qLFvPqZQrdmhUhm9CiZHgXikyoLl1aGzvGUxL1oHpWj1TMVUuazXdA?=
 =?us-ascii?Q?HNls15ggl6D0grRTsF7QTRY5dQ7PF55SuSnT5V1UtmFofEW4bAvL+w8rZank?=
 =?us-ascii?Q?JJLDK5F9wnMj448TVqnVz7xH23Ty9YrJFJc8cQM0VuiEdtjGsXnIcxj3wAaH?=
 =?us-ascii?Q?o+VlcwlScbvG6PBb4DN2F9k=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492d7b37-0e39-46e3-03a7-08da60df517d
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 12:42:28.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6el6ZYH56Hvsw7j97SPrdhnOAZGUpVyzTw1b4YJLnCQwDqUMfZk4tFXUZURYqJu+xkF9Ip1BU6Y/DcXU+Zs6ZRn3nDrMOnBcn6Ply8GI3QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0353
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=andrejs.cainikovs@toradex.com
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

This patch set updates CAN controller clock and changes interrupt type.

Andrejs Cainikovs (2):
  arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
  arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

