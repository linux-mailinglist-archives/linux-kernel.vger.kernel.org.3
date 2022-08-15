Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD055927ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiHOC4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHOC42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:56:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B513E17;
        Sun, 14 Aug 2022 19:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtYIUrI61gIGNhw1oK8iFI4G53/qdL3n6O1cyKHBS4D47KuBUHFzMUxmAPX7PR9mlFf9P2Koza8R2VjVd4PxLkYLvpFksotBlbW8hP40egBDYNITKdkct2JNuyV9cHkjntDhDaBvpXAnFvBZihr9AiZGIUgU4fzlquRj2T7nXtS/BUSpZmGkdh0B7LJjSJKeCkbdOOimsEDsT+A0TTAQ0CUeAuY1TJHS7qAnLkTaFL/+1op5WyILEqi7l+bnhUc2VJIkNMl09YKJ0q9Sj5i2C8C3ajUFutGd+JOmqtcrKCIoqLtq4yigwpnz0MILXZK5dUTRwjWXk6mx1U49Bv+esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6Mz9sfHqFcjcFGrx/HjiSlNv6mxefDv7rb6EYkPjmI=;
 b=CqiMx3TumiMOjSVHfm3NijL4yL94PxrB5vHsPk+VtC0UvssuzCbJhGYo2eI3Mwuo0n3vKqBpLCerlPQ9aZDV02xuJQDG5TaFH2Rnq2PFiIrD1268NYyMuzZwpBBwUH0EqCcWAwRcqPYSIFrLdM1d6dwydECLFMLRbLxFmWmGdd7a4yWNcu9/hEEkYETHVz4yA207tN08c4AJplhf4Yoi5TKMzmNnX7T0ghyRmGw+qEqWGIRSchr2L0WSr0QEk229CgqmbU7oMt5E3bJqKh7SzG+H5HBPNFUr4YXvQ2zMynZo2yzKYNV82UtWGJYT7bJH2uqrPZXkuJ/ZH8yjsExmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6Mz9sfHqFcjcFGrx/HjiSlNv6mxefDv7rb6EYkPjmI=;
 b=nUdidOZgzfHBTNWY9QzWIPQ8IJjBAXIqvFGYL0vH4XE4jYyYLgxMEeXlz3SXmFBmM3qmcgYWg33A92arBBD3IKqbKGnysuq2jr1W1RRT1/7SJ4Ug2ObGMbwQCGkSSAa3iZuotCnHZun+xLBCOuIn5eZvwbGOsLTg3noNxbLM2L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB4803.eurprd04.prod.outlook.com (2603:10a6:208:c7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 02:56:24 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 02:56:24 +0000
Message-ID: <130bc9c5d5da94b25e2ee456039b1818225f7bef.camel@nxp.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: bus: Add Freescale i.MX8qxp pixel
 link MSI bus binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, festevam@gmail.com,
        krzysztof.kozlowski@linaro.org, saravanak@google.com,
        geert+renesas@glider.be, robh+dt@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org
Date:   Mon, 15 Aug 2022 10:55:58 +0800
In-Reply-To: <1660502102.287520.546324.nullmailer@robh.at.kernel.org>
References: <20220814074338.453608-1-victor.liu@nxp.com>
         <20220814074338.453608-3-victor.liu@nxp.com>
         <1660502102.287520.546324.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fb96e8-0e6a-4cc1-7f9c-08da7e69bd66
X-MS-TrafficTypeDiagnostic: AM0PR04MB4803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pInMBlUOQUY2Wk2ZffswwYUFAYo1x4NZn9y0vXrUBf42RYQrJgRVGqxVkCYhIGJNUk2TXnXHBMFEQyClcSp4+zXLHzfnv+X1DukZw/yQ+HzALrftJZG8k+YfIuZM3HNeNPPRoRsrz1DYVFU6Iua2Yx40nH1GdMM+wpxoZBKq47/kGkDzJ0obQ7m3NALKc9A0dbj7zO8tRvGvKaaRJh9WQ9W8uEfuM2r6cuAWt0AIksak6xd38gmKlg1o39BqZF7rKKvrdsk9HomsWr2MIeUk1Oi6UtYe1EbJFgCGPZ6+OcI3l+rZTDiCUosvoMHYpMp3PQR+3u7oeLCmdo4ofYwPUxQuVr6yZjx6fJcwlAxIk5zzWYVfDCfYn8Np4cef3LrUWGQNISaF6E+NsTw7NJ4Zp6lCfSugTYoOnJodSvlwX7zVzBXmipzuMuw8ulESpLzlJ50vUBKGCkugkQX+uwwmbi214aG4Bbkvi7bT8u8TVkIltSeXTLoDP0zjimlw0a2nCMmflgG7RRre3yZr/DehFT7j6N++61Cp1e50ZvpVhn1VGLEEUimp8T+GBLygjAsrGTGy5TbCs5Ub/kDV3WjViIFp9QbtrWS+ov4wAgMhajoTzjeGbCNmvgHYzXRa+DCy31xjnUVPZNM6ZCcTzoO77zkgulVzPoqm/3h/hb3ZNUxFKa+SpP/ma5BhwfC7mAkrEzdxoYCGEuMjKWxR42oV9xKt1yCbnhG3CQsKOhbBS7rh9TacCNiS1NDgcgaQapiws+WJFhNxR/4g7ozHvGf3/fr9YhqMGCJnxpBIZr/m73R9iyoIcLjPZkHcqgceie2rQ+xxgOxoMiXOj/cRCnydBwV0CsFZvBuABImWUIqRfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(6666004)(26005)(6512007)(52116002)(6506007)(966005)(6486002)(41300700001)(478600001)(83380400001)(2616005)(186003)(2906002)(8936002)(7416002)(5660300002)(6916009)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(38350700002)(38100700002)(36756003)(86362001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNjUlRpV0s5dUNhajNZNWJVQkdiWEloYmMzYUUzVWtjNGUvZmQ1Mkh5a2JQ?=
 =?utf-8?B?YlhqeEhjVHBLaEtsODY3L1FoQ3VkbTN2N1RvdCs0bGM1ektJYll1YWdNWEp1?=
 =?utf-8?B?cStZYlFFbXMwZmNSSDJEbzZ5T1dPTUtTMlQrMSszS0JueS8zRmtZZ0NudVU1?=
 =?utf-8?B?Nys1eEI3NDJvVVlqRkN6dnVmM2YzYWk2ZlFCQlhjWTUzZmJnSDdGTTBCRkZ1?=
 =?utf-8?B?TytlNUswL2JZcEZqSkpsTUVES3dtNERON2xicnZqd29pQXFTdzZuN1N0aE93?=
 =?utf-8?B?eVE1MzdvRmkrTUR5YlcwYUVGelVBc2pYTFg4eWc1SGtFZGx6TTBNbW5TbFJx?=
 =?utf-8?B?QlREVUVObXBaUXNTQS9ocGVYVlhxaDd5MXVKOUs5SWpXUFB4azl0SkV2aXdS?=
 =?utf-8?B?ZkJSSFBBaW85dzRvU2NmZnFoQ1k1VVhBbXZ3emIrN041Kzh3TERWWjFHN1VR?=
 =?utf-8?B?emx5Wno2MTRkK1FaSVRFZFN3K3Q4aWpvYXZSdlhIdE01c0JsVWhjdVEvV2lS?=
 =?utf-8?B?OVlGYUZ2djVSNUt5UU44SU9ObWtxS3FNdHd2Sm0raUxUZlZSYlRlRE43SW9L?=
 =?utf-8?B?SUxJclhHajBIdlZzSis3T2tjQjBUejVrbGJtd1U2ZjhHeEVSS2gyNlc5MHE2?=
 =?utf-8?B?R09kQVhBRngxc2gybHUrQnZVL2lWVDRTNVRCQ2s1UlV0TlB3QkEwc2FHMTVz?=
 =?utf-8?B?S09Gd3hWb3hwdk0wRnVwUGFKc0pWYWdhdFJsYWZ1bEx5NGNiMms3bzc2Skt3?=
 =?utf-8?B?aTEzaFRvWEQ5T3ZEVzBmSitPemVFd0dqWWtqVjFiM0ZTSmhjSnlraGgvZVA1?=
 =?utf-8?B?dTVMcVA4Y01KbjUyV1Q4YWNqTWlJclBZN3pUNko3SXBURjdMak9UNnRVaXM0?=
 =?utf-8?B?ZU5QWkdtdUNEUUFOQTRoTlI2b1MxbStQWmlSczlvTTE1LzlUS29McjBhZzNt?=
 =?utf-8?B?Y1U4OHJUNzYyZ3R0eG5ucE9ZN2ZiVEkzaUttS3RvS0xQRXUzcWo1ZE54MnNZ?=
 =?utf-8?B?aGRpS0hydFF3TFExOTZ5QmhIdlJyL285MitkMC9CVjFqOEJEM2MrR1BzdzVN?=
 =?utf-8?B?TjdDbWo1Mzd3dnBrU3ZEUUxtendkRVlPYWw3SWV6WXBXR0VER1c1Nk9NYkFk?=
 =?utf-8?B?a2pqdDBIbXNiS2VjcUp4VEdVTFROMmZCbnpJM29kVllyQWZWbEJFT1JuYWtF?=
 =?utf-8?B?Wm5lMFFPOHVMdGJjSlJUa0c0UlNiVjlXYlRJTTk4Y1JvTytPWmQ5VGRqMzJw?=
 =?utf-8?B?cHcxZXBOazh4dy9XU2tqdk5YUEtBYVF1RVdLQm9XNHU0Q3h5OUJmWkdObUNr?=
 =?utf-8?B?clVUUXFoSkZod1djYTRvMEtOaHo5K0NBRm0vRDdsYmY0dkM2UFhjV0l2Tzlt?=
 =?utf-8?B?VDlRYTFHU1dtUytjeTVQdDcrNTdaNDZDMWZoRUVwQW9jMmRyWHlreWlQL0NU?=
 =?utf-8?B?YUZDS1VGZFhoVkx3Tk5EeWhLL0NsMmdOc3hscUJ2aTlPcEk1NWRGSGEyYUZx?=
 =?utf-8?B?RVIrWEROamM4cFAyL2xrQWtON1F0OHA0MExvdEJMYXhPb1ZsOUQvK3lvcFFj?=
 =?utf-8?B?Nk5CTUdNUWNFYWlzZE0yWDAxYjdsSG1xbVNNNitlcFl0L2QvZFhYYlM5aFhR?=
 =?utf-8?B?SnBoZC9MMy9JeFRVMVNyOE5ndTB4ZmZIcHU4Mzl6cExPT2cvSGZWY2NkU05K?=
 =?utf-8?B?dGJBSW5DWmdSMUJSSUkrcTB4QnRVWkNvdFE0b3JjVGt2Z2d5ZSs1YWxyRjFG?=
 =?utf-8?B?bDB6eDI1ZytEZnplcklIR3ZYdkwzSjJWenZJelpTV0I5SG4vdVlSam5UNDVz?=
 =?utf-8?B?RVBVRzJCRUlLTWFEQ2g4VWNSR3ZjVnNJWk5aZkdsbHlvOGIvb3d5VkE3cFo1?=
 =?utf-8?B?ZW4ydXJIZU4yR3BIK0pVU1JtWmd5aHJqS1JzMmZIQU83K1ZaWkZoOC9vL01r?=
 =?utf-8?B?NE5HZ1hkZDFIdHI0QWgxUzMrcmV2S2ZvR0EvYVQ3Umd0TzJsM2UzSmdjdkRu?=
 =?utf-8?B?QmVCVTA1eDVHY0hqb0pPUHdhV3hEVXU4QmFvL09JNExlMkVMaDJFaTB3MG5o?=
 =?utf-8?B?ZE1MTHZqSmdrZGRlbytFZlhBTGVyU1VwYit2em1NL0NWUEtobVQzZXorL1N2?=
 =?utf-8?Q?o/Togz+5FqBEXpB/C/lle65R9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb96e8-0e6a-4cc1-7f9c-08da7e69bd66
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 02:56:24.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRyavqW+aYbn6NneBZnI3T1QjL7YqpOCfgxI78UDHbjLOJspzZAZMXkInmg6N3Nl2iHu/JwyLSBa9WnJqQbWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-14 at 12:35 -0600, Rob Herring wrote:
> On Sun, 14 Aug 2022 15:43:38 +0800, Liu Ying wrote:
> > Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped
> > bus.
> > It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> > DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> > MIPI DSI controller and Control and Status Registers (CSR) module.
> > 
> > Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> > link MSI bus specific bindings.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v3->v4:
> > * Add child nodes in the example MSI bus node of the MSI bus dt-
> > binding. (Krzysztof)
> > 
> > v2->v3:
> > * Add a pattern property to allow child nodes. (Rob)
> > 
> > v1->v2:
> > Address Krzysztof's comments:
> > * Add a select to explicitly select the MSI bus dt-binding.
> > * List 'simple-pm-bus' explicitly as one item of compatible
> > strings.
> > * Require compatible and reg properties.
> > * Put reg property just after compatible property in example.
> > 
> >  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232
> > ++++++++++++++++++
> >  1 file changed, 232 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> > bus.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000: failed
> to match any schema with compatible: ['fsl,imx8qxp-mipi-lvds-csr',
> 'syscon', 'simple-mfd']
> Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000/pxl2dpi:
> failed to match any schema with compatible: ['fsl,imx8qxp-pxl2dpi']
> Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000/ldb:
> failed to match any schema with compatible: ['fsl,imx8qxp-ldb']

I sent this a bit earlier than v6.0-rc1. Now, v6.0-rc1 is out and there
is no error if the base is v6.0-rc1.

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.

Yes, there are dependencies if the base is v5.19-rc1.

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Do I need to re-submit? Or, you may run "make DT_CHECKER_FLAGS=-m
dt_binding_check" upon v6.0-rc1?

Regards,
Liu Ying


