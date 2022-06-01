Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69452539F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiFAIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiFAIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:24:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02olkn2040.outbound.protection.outlook.com [40.92.44.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DC2FD;
        Wed,  1 Jun 2022 01:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9INKSJmgtm0rZdR20nFpm8QghaJzuUpV3Po/JDQ40asi3uDIqwWMAjrfPLOa6Ylz1UvZDT2OqyiX6zgYype2PE+UD/MVr7JIHgMhLWdn/L37lvYFhTHdxs0onlDdJQFGlEwRY39HJJq2h5LhV7sCLT2XqbtJDkAJ2c1q4vpgxTBix/jHIiHP8rX7WtqkeDrmuNJUnaoh/15FTpJqQeli1zlruS3oIqpYPieq9X/RLlC0R9aNQsdVIF5RCdBz1rEtEybXgTYH1hHRppjSQ5vcrY0AuBLhY7TzVdNm9o0q9WHsDXsPtUXydRJqffzYsM7BFkrGUfZestp7Qp4redGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei8gN+i9onrWCBLvKvFKiDHKHnuJ3+Z0/7MK5HP9My0=;
 b=dubXJxR07WSKBtmjwt0zTUO1IsD9Oh9HNooakyUjEl/P+48GY3ssQ0xKBrMr5XDW5oLP4jYUjSup7HxYlTe+1msnNR8QqvArmxaAxR12ZPIJZFhsMCTP3tPx49/zJBEJdfGTHsqWZdEn5Trz65eNCI+ywKW8GNLAiT5yuYmTIAaSs5Q8XCMi7SwoFEYSJebeU7GrWB5X9DkK5edQqJGc4u1tAbK3GuQTezWfIkzqCUvNyEEy4/orhvbVAY4lj8aQ6VcKK9BSmzeL28CGDFTQS6EX/AopR3tAd1JqFtPh/q67UbOLsKSdQ/Ph22UoAcyD/tPa6zI04m8yKWTfqg4nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM6PR02MB5708.namprd02.prod.outlook.com (2603:10b6:5:7c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Wed, 1 Jun
 2022 08:24:37 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e179:40c4:4269:70e]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e179:40c4:4269:70e%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 08:24:37 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add prefix for EBBG
Date:   Wed,  1 Jun 2022 13:54:07 +0530
Message-ID: <BY5PR02MB7009387E1E6C060864C03F87D9DF9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601082410.55266-1-jo@jsfamily.in>
References: <20220601082410.55266-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [z9q69T/4OqjQIr7M5MtqWFrwypKS12oV1t5HBEWD0c8xA8Qk4/caZ36vfGQq1EdL]
X-ClientProxiedBy: BM1P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::13) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220601082410.55266-2-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1786afec-e807-4d49-ece1-08da43a82a68
X-MS-TrafficTypeDiagnostic: DM6PR02MB5708:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEo29+R5PeDNMW5i/vnPNKy8JeT8w40u8ygisvteAkRxrYdNp8+5gmLOxfPOd7fYPcv8Jah5oCsAQYQ1lb5aPylFCYmFxDQf9olog0NW5PL58PZ2obDi5X3vlYz8rLubM5VGhwRvJCOhGrd9J1zNzcJ+DF0ouNWL62hWrtOmtKW2jlGBArf7c1Im6PpcjDT+7NhBBUf1rGMJ8gf2vx3Ng0B+C/54R0zGayrUgC7m0i6vqsSTJQ5Hide9rX+G/pIZNb5CaGQqML/5Mal2vKwxAtkhXvLEeX9ROP0tQSMeyRTeLZ8uQnDoBdtbIyMOmYXz38iJQyAQeqcLR8wO6E0QpGpP1lhHI64NpYrh7at3ichooO6gI/CsCuDRWyabIVOFFqexBsxvLdtQ32OyFpYO6Pk4dAqEyZ6Oaf6IQhnNYgx9T7+q0Ro+d3gbhDUnn+ewSzKLKrGLnEpK7T/6gKAOdfwayjNCVcGDOvhP+ruBMGaBYBqZ8iy/sneUhgPvugE+ANcGByhwavC0NJn0wf5oGQWvw37aEfj8dGlzo5upu4fs1Z4Cq3VKURR3+UQE1qAtkwy+WvKc/EGHEAndIB1M4A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lc4gEAWLa3ZGEtVAWxnxz+Jj4Kxc0iCvOulI64dubPnzC0RpTd/cbX581s2A?=
 =?us-ascii?Q?ZHGrQVDUlqXeUg4qGxn9ISE9UD7VOAC7xvkR7HgAooXHNmPlzk/KHRzO5Oim?=
 =?us-ascii?Q?ocsXqDt7AofL9punHP27xhwk73+E+/p2CeTw8UKCOSE9iklXxnR8VNaz4tfw?=
 =?us-ascii?Q?V+SqBTKj+OSVYeby+geteZP2y5o9QyPvU2IYryOJRkeV3qCYs+96LdWGBg7X?=
 =?us-ascii?Q?ltfghkBOQqEVxWXbqnnKSP30wxesxK6bBNx46bUyII8p6D5PRFYG6BhxMCmk?=
 =?us-ascii?Q?Pz0DNTLizaJHI2ok0aDFSSwvOzMaWeqZqCZDcJRXP4SXUcYw0TzXv9q0egD8?=
 =?us-ascii?Q?GbiKRbmibMPJ7odu2aCcFWwb1kIfbVG4BABpT4O5GWcoRu5nKxiYRQj6DgwC?=
 =?us-ascii?Q?nP6yTS+PUXIZi6gfcRPlxHu5Xrp5bmucCdJhw/oiaABCB57sU0ZpPpiaF12A?=
 =?us-ascii?Q?99YOD51BEWpCg2i1ojAfjWbhQEAttXxNP/l2twqJNqyVv1Ns8APGYfmWNuLy?=
 =?us-ascii?Q?nzDUsCZS0iVGsGe4JRnWZwi4DaEfbT1zqyx0ylugNmqtAUQAo0LDMzJrUxTp?=
 =?us-ascii?Q?FRXQaXl4q2/jyKIlh4Poq8qjkqDx5wDNJDa0M8E2gFoyU1oePQ9iN7kKfV1Z?=
 =?us-ascii?Q?HK3bpbb21aigFxNlut0ZfdTUSyAKljVcd6ATqq2POOTAPlCyN6LpBjwImLHc?=
 =?us-ascii?Q?Aurf2GsMzIWlOr1ggLoPcJCDoObfv9wNC8o35hA6o5NFR/QuqJOuUh22MsA/?=
 =?us-ascii?Q?+2XB1fqO1Q2f1hK92P2MNIa2Sv6XMlw48d0SYUrWr55YjlY80XqgnI3eSVZb?=
 =?us-ascii?Q?wzUPPma1xAcJQZBCnZIdARO3Twa3mz2//667tuj9jFmXeNDaDVFY6tMyNMkF?=
 =?us-ascii?Q?x2q4d2c7ZSY8m/hikQV3ShtZC8EjLyvO8+Um3Xi0Q5+v7JCPe/AQ6ehGVAJX?=
 =?us-ascii?Q?IfO1VpHzNefaSQfdeYP/nzQrJAZxGJUv9j8jsuAsfFy0pYOnN7AQ6nspzNsN?=
 =?us-ascii?Q?9EwF2t50818Br4pVfPTgo7duE8YsFUYAgC65h1TmdogvYRxc2V+8K8dp8qCO?=
 =?us-ascii?Q?YfJpAS9Ct4I/b5Ta6l0kOqr9oSzaRT0QC6x7ZaeQ2MjOSpiQ3zv04frQ9xJI?=
 =?us-ascii?Q?ifUzPi743ve6ivcPz3DY5PtjyDlON9Pol/+XJThJCcXQlKNgQuUDMVatFm8T?=
 =?us-ascii?Q?Ba13KX4Teu2iRU4tGoofKyuCYVbm2K8ypkBACgv33DjqWogeBzYGSoWO09dm?=
 =?us-ascii?Q?bkMF6ITxn6/46OL0M4j7NZWV3MjYqYmEak2aloZgiO3VGw1EX2SJuS3J979T?=
 =?us-ascii?Q?Uy1kQfMNtiRUemzDVVtVzMk3EGEQXvMWb1vSCIN/KLowdiy8Lt87nLxbYxLi?=
 =?us-ascii?Q?VTZ+jVEdCU2TpJ/4Cf/Lp/4lZvabEAgJbVVyZDUuV9A+27xRocnOmQ1tkZMz?=
 =?us-ascii?Q?/WOe55MEfl9uC8wiLy86UPn2diYCmNZy4y3mAPnNRX+BIfnjGV3dlg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1786afec-e807-4d49-ece1-08da43a82a68
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 08:24:37.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5708
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prefix for EBBG. They manufacture displays which are used in some
Xiaomi phones, but I could not find much details about the company.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 80e80fa53f8a..effd1cb995cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -337,6 +337,8 @@ patternProperties:
     description: Embedded Artists AB
   "^ebang,.*":
     description: Zhejiang Ebang Communication Co., Ltd
+  "^ebbg,.*":
+    description: EBBG
   "^ebs-systart,.*":
     description: EBS-SYSTART GmbH
   "^ebv,.*":
-- 
2.36.1

