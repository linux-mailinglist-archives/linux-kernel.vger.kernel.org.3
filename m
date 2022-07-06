Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE9567CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGFDsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiGFDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:48:31 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE9222A7;
        Tue,  5 Jul 2022 20:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrRvTN8LKu4+CRUvyNIK8H4JjSkYDRu7ImTP/Gby+uW7NQD9LBTVMRekkVgiy6AWh5S8qnfEEGPQGqpYt1sJtVEiMfl5Wfl7uuNI4gWAj2EuNPbyTVRwGEmOADc3mSiuf+YgSkaITNkwvYwP+4ScIBM6uBwxLnAIr3V7okCcn7EPIAfNBw3R0otUU8KfMLZsTGoUt0ki51q7FN9pq9LUd+rX4WDWxLUpEKtpkknCwncHVSoYIjh6J8NJF+xZSPIhq1O2V7ltfVtd89DpqELxoSLiMLH61emilLYnU8d1M3vAFWs8Esz6+2zCWcVRmQgvBGM3hdCP4E3fV61pCZwIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BZHYXU/Fz7/BAc4yrkgKaprgUmLn5W/VXjZX4E0Nl8=;
 b=AXfpHt+RZ4IUmKtkxag7gU2bYKb9uToudtWGV3mw9iMCtAz6sb8e4dWJE9kGVOslLRYFuH3PBe2sHG5yJE9DvKWrR+Fi2QiP1EJrhC9/QhcHi6Rsn7f9dEXuVMQv1QvDVuJe75LH08iEVx93wXkxbwvLDYIhv7Kvr+IwtHKBQymPHEhvK09vwykEqLJAg11Rai497bZJWXnR5THkh2+cJbRn9jFPBCizalqc68i6+zH+6DV1oZlkiD9rQj1ZwZWSmwZ7CyI/c9SeEOi1fR9BbliiTC2d0LHT/nb1p2uy4qK4EloLsBitVamcof8/dqdZhbYnEypPKIopZa4E6f/rJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BZHYXU/Fz7/BAc4yrkgKaprgUmLn5W/VXjZX4E0Nl8=;
 b=AFL2LEHcYN6Otrg869TVc4/gm3+utKoZfgCBYmbdBVJJjhJRfpr7zqe1x8INrC4HeZLZ4kAghdhpKsJyb9H1MCq5qi/d/lA5Ayj4ZjZwLTmXmQ59ONplDXlwfCaLhmTMoL8xwjN7S5St9R5dPlm1JBpYJeN0gqz10sJKOAJMaJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB6463.eurprd04.prod.outlook.com (2603:10a6:803:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 03:46:37 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 03:46:37 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
Date:   Wed,  6 Jul 2022 11:48:08 +0800
Message-Id: <20220706034810.2352641-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706034810.2352641-1-victor.liu@nxp.com>
References: <20220706034810.2352641-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfc99822-f7cb-482b-c272-08da5f022116
X-MS-TrafficTypeDiagnostic: VE1PR04MB6463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muORBY2HhGxxQ76ojq1ay/ZGt99XBG6ud3EhA1A9GW0VXmfHFd+c29m3IXYNlazrClPdSTgSmLPR+XQTxTHAu5CjieaDJd2oaMjO1fck8sz9xe4ndIzwlvXiXYwhwGhBw5nUwtBgHno8YYvkw50HbB8YTgNb0iZQlDW9G6PQcWYK9RVBU9sjZDBIqbQ2yVP/ziH52OM29stdyVpYai+N+Jt4fhIW4AKQ3IDanE5h/Dls1kAevRZoRenxTQo5SZ4B/qOfm7KtPDNZdA4QJ5OfDr4wp20yQ2RAiXK0ZilcNCaOzRJ1rwO92sVmq2q8vHSXTOPBa8rNbEJ8o0VHqriDZyx1NNiyOb8DbCjiePxX2BW7iCpTRxhvdMjYo9tlnPOptLdes3r580XUl+tjXsLL2GkBXpDTcUCBqrJXoCW/inG+0QiGG/XPm9DyJ/UKvmLF896FhuUbcT9qdzA1+Y+2OKOFnl6qVv4L9TKaKErS1Y0CJo2gwOwa01ka4o+XuqfE93HmWtmLyat8kT97Tp1VtIj5RuVuIs2NkU5ino0bcHAnRYxMEK5O130cxVQ+Xc7iazJ7LyIKDXfnpkIh0qUD1vXnwpCvh/8pstQHN1iwTq/epikh72j52U1HwyHiBkA+pBSrOiSm4S6yJfLkkstArKRDaVEvcKwYE1rEocTSndM4QWeQeslKJLs8guKpP5MbKeWVkCecGQO6Yv3HnwoKGqj4YQS5kmkYKd2luWtXdc/kbZbZ1KJDSCY6PYVgIKQiuz5VajVA+slAOPvj5b8Bb/Hn4SW6TjTalCyL5KpzW/n1/66LlzkQcpiIJ1a604Fc0FtYTspRWNks71sdri/lHh1MZsiccSm2oHAozYqCwk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(1076003)(8936002)(6486002)(478600001)(86362001)(38100700002)(38350700002)(66946007)(4326008)(6512007)(8676002)(66476007)(4744005)(66556008)(5660300002)(2616005)(7416002)(26005)(186003)(52116002)(36756003)(316002)(2906002)(6506007)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9LxNkX9X75culE0bfRIf/VGd70OOlqnnaL1quzir3Tv+KAhWKM9gPtU+69t?=
 =?us-ascii?Q?uxzW4j6TYBK7cY6C9olKD9qndOqLH6+uA8VvAPIHhH3Z7noCwXN/pXquCZnR?=
 =?us-ascii?Q?PtSdgkszaKleTLcj2LMzay1/NmdHKxcjpIGZCFlXwKjczeJwVViXuxKUKAtb?=
 =?us-ascii?Q?cXvPM0tVVR+uzo24e7sQYoq+5FJX9D2gNzRro01XNsAhm3iAprx0FQYomDeN?=
 =?us-ascii?Q?0z5f40by6MdPIOPSgVZ3YoHErpMttxZ8NQ2mxAr9fFC8fK+86Vil+NbGzrtX?=
 =?us-ascii?Q?AB5Phql2dDyojQRkEFj+yArjOzywgDXOoTked15mgYNIX4sgwCW3noweev/o?=
 =?us-ascii?Q?vPQVAApymacGOWJxngsIhllcHph/QlzzE0ruk0UqKGluUsbSDeGoOF+wiA7Q?=
 =?us-ascii?Q?MfHng48K9efgiXBy9+RkGbRGlDJ1r8WrV6BZfC5awiV+MqTczKfnoD8Z6lZC?=
 =?us-ascii?Q?5YlZbdfZhN0lVShtRSgFWrd0Zrhw6aVyopK8Dh21GTbfdaPPvG+r8u2WY0gB?=
 =?us-ascii?Q?pRO81JOwgNZPBRVb8Z3VLA1MiaJFf9E0e9AYAZqWcHx7xRO9JDNntKqJxN9S?=
 =?us-ascii?Q?C/P4LZJlZsFxX4eGEpeoMTEUy0RaxjydpSoiowBZW1uX0pvZSuEalbp35ypq?=
 =?us-ascii?Q?rsdteRlCRka8fZEuCUhtxnVV/D9MHaRPZSRwEHl/rskC3YymoSh2fBIr0rz0?=
 =?us-ascii?Q?r5o5A8vdcGUFNPP6P4ZaW1qdTFeGzIyj+g6YV0+YYZClIhv9f2sF9qk+dFXG?=
 =?us-ascii?Q?FZGhVXvujj26xGNKBz6uyemF3oM+84MLHyqVsTaAu3kGPMWHeMkSTMKwWxfS?=
 =?us-ascii?Q?vIQx/dhjCtyh0drReUKxJjSp+eZVrH/yBr9d1JYHyFA7YrT4AetFj8QQ84Hw?=
 =?us-ascii?Q?yY6xaIIwmrCWDULENoRdL5JFAk2qTrJjq2LEgzyWVho8SevSSgTT+j8zZOh1?=
 =?us-ascii?Q?gn3NjFd0NoXfihaGhDVoi88JN/PfC/OelJzEH2mYGb3Ud8WuvQBaB2yciEJY?=
 =?us-ascii?Q?lfp71Voyw7nThbEsEHx+XGm3hJORKUm3W9tF8ww5YvdGau8hHE4aw0XA1OBJ?=
 =?us-ascii?Q?XmW+bDfHadn6s4rNthe6ytfE6iH13XoQla/hugkyFzzPfQr5mOE+/AvbOunE?=
 =?us-ascii?Q?BiRZYEQdt9/t1WMRVchOP3TlzAwwKWLfAFg/bQyID+mPmE7ZDQ1voD7qCdCJ?=
 =?us-ascii?Q?/gS/KETZoLsLOYgpZnCkIWtk1T4MnLRuWdTN7KoghcJlVAUuLwdV6GEIga7q?=
 =?us-ascii?Q?ZXm9A3iWceY7H1RHmjkTSGb0TiV2+Z15jlOQF3md977B0Ff5EVKRH8W0H2C+?=
 =?us-ascii?Q?JNvyOCZJwXcqrtVR1dWya3Lwz6LZVBqjl1puFai5of9+LjnnZxgpBIbqIzG5?=
 =?us-ascii?Q?XBp/rIrYM9Gi6yVYtSGzNlkJ0egfgpqXK7mD68PQeF+NzIBl+C2o3Lk45YXb?=
 =?us-ascii?Q?+f4ba2zX8PlxYX1DnFjvDSrkjvIPBgOuIeMd+XQ3fpfsOI80vZ9zOKDfglDN?=
 =?us-ascii?Q?PjqW/FRICFocPYXDx75H3Yo8hofJJ6N6ycqiTTiUojvOtXZPD6sahXEr1DYw?=
 =?us-ascii?Q?J1grvf0PR37a1snclbF4fpfXLbjkKWPsHXA+//FD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc99822-f7cb-482b-c272-08da5f022116
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:46:37.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlslLYKa/01M0o3N9HxhK9qlObao0WbQpVKRA+sJWY52kjkyL96xAKteNl2gfoNwENlitNojtegr+sHnDz4cDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Mixel, Inc. (https://www.mixel.com).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* No change.

v2->v3:
* Add Krzysztof's A-b tag.

v1->v2:
* Newly introduced in v2. (Krzysztof)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6bb20b4554d7..bbce3b060710 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -792,6 +792,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mixel,.*":
+    description: Mixel, Inc.
   "^miyoo,.*":
     description: Miyoo
   "^mntre,.*":
-- 
2.25.1

