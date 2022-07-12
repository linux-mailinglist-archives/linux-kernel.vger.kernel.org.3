Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B360D572106
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiGLQeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiGLQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:58 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A6D25C45
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:55 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-E2mTeXWoMASY9MO6aM2sZw-5; Tue, 12 Jul 2022 18:33:53 +0200
X-MC-Unique: E2mTeXWoMASY9MO6aM2sZw-5
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
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: stmpe: Remove node name requirement
Date:   Tue, 12 Jul 2022 18:33:44 +0200
Message-ID: <20220712163345.445811-5-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::30) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca9073a-a894-4e67-4591-08da64244bcb
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: /NARff+3seUVefQDSsfvjyj+Sxo4CwbjbPpUyRY51yJmpib89/aSW39qokAz55y889i/pd3oiYcoQuUo9T4oZH3xWXbLHc/8UYat96TCuCu6MNA5JRpUsQHApXfMq/Ns+2W4pwhFQxg08oX8Cx/GIdU6cmSvyfMyZUG4i2FXzxCwiw4G+4Omn9ozkYCCwNFEAc0/cFImyYHszwOObH+Kpy2pxRu5Uy8RYocXZlvll52wTDuWJaCznaoR9ihH7OQLQVmNRaW56hNU6qUq+yPsiOuCJOVsyyvz4EROKZ4pbZ1yxPP5YzMnwqcdiUI0whJjCqy7n1nNCjQMZOWftJLsMvL4pFiqahDTMx+cjDATcNl2no5E5vUuxmughMpk7dwjXbreZNDY0G1eLRGpqqPtqpwOquIPv9YYi67+aXRkq7EH209ZhAQ2mNQFOILFO1VTPGo9uiX4/WrIjjyQTzekQ8L/0+xfwI6DyfNcG1XcWVBdN6/kN9Vwoqs6LNzhHR6hKYdWqZ66D3cb3DFFVuouYwbJ0nrxzg00ek1WYnLqa3te3QdlYxAwZPvN3E9BdFLxx65VGPL2DRh3T3qLqkOqbG9h2xJO2tCn9YnDRJR3hS6I6C9UE/q/TmgQ4JQwhCPsgSQcefv4ZO0C84N6W9/aV41YZWUPaXAv791jTEtNDvAvQSfIbyDZR8PAKLt+sy0R4FJxRWNUuGU+ykeYZZMd4K+WTt6mAW0nJ3BFbGhlHrXZo2+o+DigwoWCzJ04va6+h6ha26Fq5nuYBScVn70entk3uR5MIGTfFbFaNth8AZdzuBqhdIsM+n/J4rcC4hkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(36756003)(6486002)(8936002)(41300700001)(83380400001)(7416002)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKzFlUCz5XS+0Z7ndbK8K0o3Ww3NDNXjdwnyrwmB9FF3E/K7/UVXcjwnICoA?=
 =?us-ascii?Q?5B0DxBCnmGSicIzTBJqR+i7ushf7LQRfZJjBlF6jkGYajB/DJJ/c+XcUtm0q?=
 =?us-ascii?Q?5bnlo3TI3YimmIUh+sjQXcyzdf+zMMVGfvmUCJ7stvwQAfhA0CRcXarRTxAK?=
 =?us-ascii?Q?IKpNDCeyJ01n4PyQZ6vykwIdOcRlUaOEgYHblqBiAyNcNf+ZqNUvBMeo6SyI?=
 =?us-ascii?Q?qBf7xCOByRYmfKJf1+hisYOLJvRDSAxX3gKkCEM9MQlzMjYYd9zUtKKLSOzA?=
 =?us-ascii?Q?CcuTq5CkB7aYuE3crI+8Wvy6lvheoCmCbO1sGRoUuHtWj/hhVdWhs7QM5PhO?=
 =?us-ascii?Q?jokitaGnu96i3M1Ovezr6GI0PRekYolGTSl+wuANgLQgxBvdiT22+Ys3l2/h?=
 =?us-ascii?Q?uZ2nWRoi6I3+fWvhcuQqptyMWBM1Qb20e0wjZaz547PUkhyglmtlRZnG9s76?=
 =?us-ascii?Q?vs73w4dbly+vxLVKqxdqk4/QNkWploMxeFmMGQMb/DvyZlIbqB3oj9P2KzDN?=
 =?us-ascii?Q?VS2XXum4nw6FwOLN593KvrRs/W29orPfKrQzZu3NGWT4AFAhqo2pn/VTpTns?=
 =?us-ascii?Q?4wNmtvOm41iJlLWtMwK9URVBoVVUczjUvUbnRkK5VqEHCmORFl9ThdAwY7sC?=
 =?us-ascii?Q?D+n4EHamP/IPFX5tHUxMkr/5PmBJ39i+gLA8uJSbG3fPGZERlp+kMSpoVFYF?=
 =?us-ascii?Q?wFaNzUbnTcKPjTJn+OHfg8VuExgE4tbHuUxzY483HYuLQeH4SOTDtADLPM0N?=
 =?us-ascii?Q?OCh9HGLSCNMIFEsA4wTaj39R5iwBJLA9UQ8GcslgsPFyGEFea3J/Ty0rFSea?=
 =?us-ascii?Q?LG/eGkkoiw/5xZfJD23RMh4zdkIGgTgKJaD3XpheIwiMgJiY1NV9BtJnAIBf?=
 =?us-ascii?Q?uxKNkX3K7bRLA5xDuCdqYO8QT/Qd2kfrEbdLVwPjRJTpM9sz32lEgns4vC+j?=
 =?us-ascii?Q?NwS8hFT9B16OGSLF8LWtvBavy50DIu8nHQDE4hQptmfUBILsGH/VAubsl9IN?=
 =?us-ascii?Q?OEQffrxi7KXoIEDXxR/CRnfqJKopd8HTIZRR+QED46ir4nHZnH64Wu6BI4On?=
 =?us-ascii?Q?fqGzZ1mt5Q7J9FjYnr9BQ85zKUyR8J0IVoMbNx9go+GWUoBy9jIXknUlEpjs?=
 =?us-ascii?Q?XRioY75etZETN4EPD2w66FcJFDVZ4XHENG12eC0OD1PhCjSoRqAmZ2UtkDhX?=
 =?us-ascii?Q?yNf1lI1JfKeoENkesTP+zUjWzeIXygA7cpMVTXvHw8/+GYm1t/CK8RWi7z8Z?=
 =?us-ascii?Q?u8vWy9x3HnBwl8irRhECzFVTxAmUG4Yazlyr1KOR/si82eVjbXLL1flF/9TL?=
 =?us-ascii?Q?YFRfYnU1/4D2Z1GX+tcnjfIT44PDBvoWCsWh+cUcDHtXmUsQZ4FsDnIiyoI3?=
 =?us-ascii?Q?aYxJy0k5JBkv9nML6vtRk1s9Acq1lXS8/WnAKQU0oAFfgPqdnp5ycuYxhDde?=
 =?us-ascii?Q?smMy8t6YYm6Ea2fdNVWPZn6a2bFJtBJHiRO1G5ku3UDoMRw2O9teOhEkDhGa?=
 =?us-ascii?Q?D2Y4p7z3od2cJuYIcWXx6RoODyYzGKk5gniPWfv7olufNcsdF6wW8814H7gQ?=
 =?us-ascii?Q?8Fo7B6ctsGhiNe1nShqFEu+x5e5gtZYBkI+UlT+Q52t/7DRvjKpYN3Dfsbgb?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca9073a-a894-4e67-4591-08da64244bcb
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:48.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38Qgu08z1PXxgQnUHKJR/3lhsxp7SfuCWijrgcCS39zEfdXbLi61cK69ABCHzeXRGptexo9YfmMrLfiwSuL/qwXMupmbPjoh3TEERqjkI28=
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

