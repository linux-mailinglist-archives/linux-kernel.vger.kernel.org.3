Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644B589791
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiHDFxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHDFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:53:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189B606B5;
        Wed,  3 Aug 2022 22:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/YKB1WJy6lQGFpT7wM2lVaIW+fhw29Mlr7wJGhcQIfrDjPUFIrulMJvh9iiQHI1YIgTT3mo5p4QUgAt3BNllWCKQDTCMq5j4jNxWUGByBiPUQ9/8Wi6XfIdrxAIJcXv6OiOA2RjyaaqWUh0MLrC2oNABWMGJrruLDaAoml8AFCgruJpLDahh0UzOL4yh1OfFvOuhsehWomKX6PVEQgNs5P7xWCxN229rp/ArFQJx0dwCMoCWTMrm3cKrq45J2DOIzj6CjY6IVWDGjUr1LJN11W5utJSz0veiEYX810a710OLSG3yt3pbPEh2F8ctjjTAP2Nrxa0Z48nXF1XI4Mg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEZsQBuXjuG5AA8ECHkU1fFRZ2VSU0zyWFvIPeuoNQc=;
 b=MAgMKalWTDgc1Zoo3FwwiW1DcDnzviuPvbI8eWC8p9UKPI5PJeRCzrs3cKTSsTcETtfAzn9MlGC9zHRzmOz3F5+g2HHQlW4gIapS8oFWcSxUjBzS+m7fCz1jr4SQKnsA8FikrPZD+TyemKABXE+NYzzjm+M7ai88EbrfWk4hvC2Pcmp2vmaS1wXmpXzHVQl5oXUMLN9YKyBnKzfT/56z4QjKpXAZupSniLqmAanblLgYg60j2x7H9D1JfA1abaWnVdbG8XdrTxcAxncAY7in68aFV1jK2MkXAYWsVIa7PayWW3kqdHqzlkRklLayyteX9F3uxfQaif03qiXK622MBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEZsQBuXjuG5AA8ECHkU1fFRZ2VSU0zyWFvIPeuoNQc=;
 b=oOBDiY/HjNTfBiM7ibYq/o+xFOV3O3jPap1HPdfy4q/+hVWHW+xoF7eyyWzLxz6ixB1i+a0scJ245IYFp1kbX96e6TkNhFsymsJPRH/VgWLnlCsy5IfVFN1FoFTZqehitqwHb7D1mV2s/TYonSyuiAFhjwdSqj67ZhBip1URqpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6604.eurprd04.prod.outlook.com (2603:10a6:10:105::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 05:53:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 05:53:47 +0000
Message-ID: <7310519e9a9684f591bc0d58277ad7715881e192.camel@nxp.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
 link MSI bus binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Date:   Thu, 04 Aug 2022 13:53:37 +0800
In-Reply-To: <20220803233743.GA2813240-robh@kernel.org>
References: <20220803012421.3410226-1-victor.liu@nxp.com>
         <20220803012421.3410226-4-victor.liu@nxp.com>
         <20220803233743.GA2813240-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e541fc28-93ae-420f-fcf0-08da75ddb2ba
X-MS-TrafficTypeDiagnostic: DB8PR04MB6604:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9JoyxHLxwU1lg0m9BroveOuIsOHo54UIBv/Dnb/jI8trH0yNyEvJwTV/fzPi3wsU7SPz29Cfblr8XN7897tlEe+vKZ8LNubz1G7MY28szZbR7nYz9iHcMYkGxnLMR79y9LHexqJqgivOXesDQ+syRAa1Qiz5OSg8AARLP3Rrk4Xw16E0/bjR3pBzBHsgQL2oUbdusLQP2jdNYr98L8FiCIFEVTQozyLRs+5hBWkr+O8jKIJbM0dBFgCeTYTjPvFFC+2P6jyxF3jsIiP2OczwOL9Jq2N8kuLDp7vnv197wHzzpiXmrR+Fo+DRZgc5AKi3fewgbAINRrbTI5w+CEkxCB3YAuKnK3leQN8ctHPni9PwNQ9cQGhYlmtcVH2kfGAcYav7Jo/vkn9B+cK12zjDYwgCAKFQ5O2OEFY256Z8Pl3RuWI6XAuHgFnXWOnJcCE1VGCBCYgAGxWBvTBTusKufVkgVIZgyOvaiTeVijyPQDAfcP7RjqQ0Ax5L3sA+uOoSt7GV9nDrc59s+LIBsQN4G/oNacW+JG/5T9xYG66ZcLVpC8dvEI541+rDYrbafIVDCwSbzcTpWQgr5meA+EM1ItcNE1VZPTwnNFouEepbZxg3kqA6xig54agC+9pBblfKvpdJV9mpKksI9/WyO8FTr0RY8ybikSMrmlJLUv+4auycK/qsr/O+utndPpXG4B0T3XJ7rkZfcZW2ZRpYCebO2RPWhGZHb3nvTevx/0NNg7ixHOMARHo72uLVWm4NvJ9ypABgSV1TGvHt4zAflsQYJUGAKrqDAWrCCyEdG6SNEnjCE+lU1vyZFbFEiRSXVcqjAef5XP7Xg2pOLuOwNr//8WQhOCh6OirZSJTY8OSAuYgGMUOhPog6jhtRmaBGjclaw4zreFT/GOZqWyJDfx5ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(6506007)(6512007)(6666004)(2616005)(86362001)(52116002)(8936002)(7416002)(5660300002)(26005)(36756003)(966005)(6486002)(186003)(41300700001)(478600001)(45080400002)(83380400001)(6916009)(316002)(2906002)(38100700002)(38350700002)(66556008)(66946007)(66476007)(4326008)(8676002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpXSnVZVThnL0tIRGMxYVVxOGRFYTVxbEhYQUk1dG1nSENhc3VaYnlnOVMv?=
 =?utf-8?B?VTdtNW1sSHdZbEpGNllmR0pzZzIxWlRRZG5QcEJVQVhoY2lHQ1hDVkpFdjBL?=
 =?utf-8?B?cUE5anhzdG9SK3NEZW1sSHA5VUJrdjExQUU1ZHMyUXVQc3ppTFBlRHdxRHlB?=
 =?utf-8?B?VUNGK0ZFeHlmQkc1LzhRSys1U2x6WXJiN2JoVUxuQnVEaURQYjVoN0RaSm4y?=
 =?utf-8?B?L1BYZWt4Ukx6SUNnelpOenRkSDlrQnFPZUVVamlzeWNTQnVzbkNqSHQ4YVpC?=
 =?utf-8?B?a2JaMVJBV1QxYmtkZk85cWtpckpuQWNHYUt4RnFxODdtWHJIbXVXc1hCQVNS?=
 =?utf-8?B?cU9FUFQzaWtZczZmMFdXRmJnbzZQU0FKd0VkU2FGbkpJTFRyT0FXdFRMN2wx?=
 =?utf-8?B?QVJ3S2NNdkVOMURSRnZPNkZ1TmhQWWwwUXpZTjlKUEFvR0dSN2RDUC9lYzRZ?=
 =?utf-8?B?UjRsYnliRTVrOHE2aW9XcHhHVEljdm5ROWtxN2Q0SlZEZGx2cEF0KzFreDQr?=
 =?utf-8?B?WGMyc1k1cXArZWVhTnlpQ1hRNFhUUEdyMVBtWFc2dGZ0cGlRTDk4TXRhcWR5?=
 =?utf-8?B?NGdUdTNQenU5T3Y3Q0lPVU9tczZhc3pTVGtPMnpjOFR3NHdPR2MxOTVwZXlD?=
 =?utf-8?B?WjNTVmxBK2VMY25WRHhkcnRQb2lzMGVYbWhZZ0RRdHBmVnduMzdIWUQ4QkM1?=
 =?utf-8?B?MjdkTGRiNHUrZlhYZXpkYS9sTDNTTWNvM0tQdUhLeXNHcVZ5R3BzcTRZWksr?=
 =?utf-8?B?YlArWFhUUHFkeWxTYndnM2NUUGZqUEEzRVF1M3B3MDVmU1RWL3M2RERGcEhY?=
 =?utf-8?B?ZXg1TTZvU3g4cUlnTW1iSC9tZmN0SWV2ZGIvRHhqNmRnUzZSVDNQR05QT296?=
 =?utf-8?B?eE9XWElUZmhsVkRpMVl2aTNpYVMrU3dZaXE4SnQ0ZTFVVzFadUFmVkJkRzdY?=
 =?utf-8?B?c3JnQlNoQ3UvVlVBSytnazlPRkthUlY4WG5qRnF2dGl3ZWsyOTBac3A3cXM2?=
 =?utf-8?B?K2JRRXpnMUhaeDZoRXk2bEd5d1Y2SktRWmlZcEtRS0VINi9GbldYNGE5SG13?=
 =?utf-8?B?ZWhFeDNycHlhUVNoT2ZBeWwvZERaOEJraUZOSEZPY3Z3bUhQSWsvbFBIeTV2?=
 =?utf-8?B?KzZhVnJ0V0ZDRzdKdVVtNXFOeHg0QWJpZHFEM3kvTDdaaWpEWU5zMzhrMkVH?=
 =?utf-8?B?OS9QMjhNdFFnRE12SkZIanZxREdZaSs5aWRQczFBaC9YU3R6UHRIY3Vud01a?=
 =?utf-8?B?dHZ6MVhLUmRnMzBSVUk4R0ZDWjZTTHNRVUJ2Y3cxOTV6Q3RsY09MVWV2QjdT?=
 =?utf-8?B?akRkSVFZdXgvV0xuR0xGY0hTSUZkQUc5aUZ3SlBoZnMyc3Y3RUpReXBKK1Nj?=
 =?utf-8?B?OHl6Z1dVYjBLdW5UOWIwN0xVTGw1L0FrVC9nMUs4VlhvaDV3Z1dib01qY2JK?=
 =?utf-8?B?M2VaYW1aYmZITzVtVGZNZm5GMndQa1dqQTBHREg5eU1vWlR5N2hFTUpNY1cr?=
 =?utf-8?B?YXlXMytjNWo5N2M4bUJxU0Q4ZzAxdWo1b1krQXZ4OXBDTDBVS000MzhEK2Ni?=
 =?utf-8?B?RksvL0QvTmw0TnRhM3c1bi9iTVkvYzlRdXNGRnlqckxYYzVuUDlheS82SFJF?=
 =?utf-8?B?TVF2eXMycE50VXhRVUJGZGtMdVhoSTRmUG9WYnpKYVc5clFzaGh5WXlYSG50?=
 =?utf-8?B?K3R2b2FrdE5Qcmg5cWRwMVpoOVROSWN4ZUc2TTB4OVpKWERKeTVvVUllWi80?=
 =?utf-8?B?K1FyQ0EyRHM5Q3pwMUoyditaYkFGa0ZUQ3FEck13c2tIcGZYUkVXc0xOSnJ1?=
 =?utf-8?B?OFRZNHhOditMRzl3ZGFYTTVjNERQc2RqbnNlTDhnaFdyM1V2Q0NkazFsWkQ3?=
 =?utf-8?B?V3ZNcGV0UDZGUjJoL0hob1J2RXdmeEtUdXRpZ3FCalhueHZjU1hJMHJEQUhp?=
 =?utf-8?B?Z1dVbjI3WDRLNWZBQkV3NC9scXNnZ0Iwa0h6aUNCNGFvSkFsTzFrZWZBdCtu?=
 =?utf-8?B?RDh0SFRNUGhIMEpYVVpqL2RKeThyN3dsL2R3ck53cUJQaFU2VTJNOVRHY28z?=
 =?utf-8?B?VGc1RWpZQTZvalBjbTY1aUNha2JxbzBHKy81eWErVVJ6ZEtlZEpNOTlrRjlB?=
 =?utf-8?Q?32XCmyC3+vLlL13loe6LIOtLq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e541fc28-93ae-420f-fcf0-08da75ddb2ba
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 05:53:47.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6cXUvwYSVx/WyQR8l8p65H8scVELKkFZrgKHXZVcTqaLPNW4H+ynJN76VeyU+8nPJDkjV9HIJdmwlZYQh+/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-03 at 17:37 -0600, Rob Herring wrote:
> On Wed, Aug 03, 2022 at 09:24:21AM +0800, Liu Ying wrote:
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
> > v1->v2:
> > Address Krzysztof's comments:
> > * Add a select to explicitly select the MSI bus dt-binding.
> > * List 'simple-pm-bus' explicitly as one item of compatible
> > strings.
> > * Require compatible and reg properties.
> > * Put reg property just after compatible property in example.
> > 
> >  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 97
> > +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> > bus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-
> > pixel-link-msi-bus.yaml
> > b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> > bus.yaml
> > new file mode 100644
> > index 000000000000..358c032041e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-
> > msi-bus.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fbus%2Ffsl%2Cimx8qxp-pixel-link-msi-bus.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C3ce426916ec64ab9089708da75a92be5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637951666695217514%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=qKEVrlyUkszZ%2FQyYeTIF9AoEqYvCiJjwVTIflzYiyOY%3D&amp;reserved=0
> > +$schema: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C3ce426916ec64ab9089708da75a92be5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637951666695217514%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=hhwFjqe3xmBtdrbG0EwtpGv%2By3jD%2Bm6OXN3hK6WQw4A%3D&amp;reserved=0
> > +
> > +title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect
> > (MSI) Bus
> > +
> > +maintainers:
> > +  - Liu Ying <victor.liu@nxp.com>
> > +
> > +description: |
> > +  i.MX8qxp pixel link MSI bus is used to control settings of PHYs,
> > I/Os
> > +  sitting together with the PHYs.  It is not the same as the MSI
> > bus coming
> > +  from i.MX8 System Controller Unit (SCU) which is used to control
> > power,
> > +  clock and reset through the i.MX8 Distributed Slave System
> > Controller (DSC).
> > +
> > +  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two
> > input clocks,
> > +  that is, MSI clock and AHB clock, need to be enabled so that
> > peripherals
> > +  connected to the bus can be accessed. Also, the bus is part of a
> > power
> > +  domain. The power domain needs to be enabled before the
> > peripherals can
> > +  be accessed.
> > +
> > +  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX
> > subsystems,
> > +  like I2C controller, PWM controller, MIPI DSI controller and
> > Control and
> > +  Status Registers (CSR) module, are accessed through the bus.
> > +
> > +  The i.MX System Controller Firmware (SCFW) owns and uses the
> > i.MX8qm/qxp
> > +  pixel link MSI bus controller and does not allow SCFW user to
> > control it.
> > +  So, the controller's registers cannot be accessed by SCFW user.
> > Hence,
> > +  the interrupts generated by the controller don't make any sense
> > from SCFW
> > +  user's point of view.
> > +
> > +allOf:
> > +  - $ref: simple-pm-bus.yaml#
> > +
> > +# We need a select here so we don't match all nodes with 'simple-
> > pm-bus'.
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - fsl,imx8qxp-display-pixel-link-msi-bus
> > +          - fsl,imx8qm-display-pixel-link-msi-bus
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,imx8qxp-display-pixel-link-msi-bus
> > +          - fsl,imx8qm-display-pixel-link-msi-bus
> > +      - const: simple-pm-bus
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: master gated clock from system
> > +      - description: AHB clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: msi
> > +      - const: ahb
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +unevaluatedProperties: false
> 
> No child nodes allowed?

Should be allowed.

I'll add a pattern property to allow child nodes.

Thanks,
Liu Ying

> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8-lpcg.h>
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    bus@56200000 {
> > +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus",
> > "simple-pm-bus";
> > +        reg = <0x56200000 0x20000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        interrupt-parent = <&dc0_irqsteer>;
> > +        interrupts = <320>;
> > +        ranges;
> > +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> > +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> > +        clock-names = "msi", "ahb";
> > +        power-domains = <&pd IMX_SC_R_DC_0>;
> > +    };
> > -- 
> > 2.25.1
> > 
> > 

