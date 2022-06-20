Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2532551869
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbiFTMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiFTMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:10:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781C1571E;
        Mon, 20 Jun 2022 05:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXgfYiHBy6jn7iucC80m/ieYk/zjeNr28l7s0hZkYTj5zOUcNSnHT+tCZ7M6+aR35LidJC74QwRUTrMGXw8hJM7bYqiZB1pLiPz3xW4nzFmljTrOGe8XdiGqOQU06xiMGjfw0m1gvFCKB8rDWIwqDjhIpWoPP6AFpKKRfbal3pS965Vcu7RGqXnf8e8HrPv5SGd/DenETvx+TQ6KakDvTyhibmgirGKLi+GM4eRbJe4B+FbIdyA1pg2x1Y+nGTI8HF45MwveI5Q4LkKadpD92JxKayWQJv+u0WBKmTmbeyIug7DI2pUyB0BRan6NayUg8e6EgltA587k3Ex4yaWjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XU/gKSgsGVIcgAwVZU3Lv+WUAJue046imzgtv6ZgFI=;
 b=UTdi1SNrTD1wJ2JpQLTAEtINkKal7eogRLtKKO3dHzia8Sb6Q1A6sTNvEhZu2GCnrLw52rvkw44HzcybEC5e9PTttJM1WPIzc/94CH4Q+/vUYDCknV9ocdkJsAY/oZ0kcfMw5ideMgjYi8EtTeC3W18JVoDhO5AlJgfxDVZvMaUHrapvCjzDyN0lyax36MT3hwbZ7EFklzlVa/nA9vZC2/LedHvfTNl9ZtnHUhbnC2FxkWeauyMIGfzYQmG4mddCkWeY/DC+ihS3vZo0054Mgnkv/t6mx1YNDhLq1QCzJ7mhEReiSCJr8RctUywq5NvcPMEgFYo59DXFsLMCmc3yPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XU/gKSgsGVIcgAwVZU3Lv+WUAJue046imzgtv6ZgFI=;
 b=WgqoZfuhMroN45FcBVci95fFiHt0O26Jsd6H9eBvOSPgiqFq24lvQ8NUWdwkMDvayj/GiIdfrcW36EtM80Ag8yA10TyiTvI5TOmifUd2LF21v6ZOfrD773xmcrkgR22oE2xRVy5+d51kYqWw2MLR0/EKMQKMJpg8NRfPtLKyUGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB6274.eurprd04.prod.outlook.com (2603:10a6:208:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 12:10:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:10:15 +0000
Message-ID: <3a632d2f314b525a54045ce2395ebfa09edc3e71.camel@nxp.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add Freescale i.MX8qm Mixel
 LVDS PHY binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Mon, 20 Jun 2022 20:10:06 +0800
In-Reply-To: <ca5834ea-701f-2260-da2a-84b22d4033db@linaro.org>
References: <20220620034533.4108170-1-victor.liu@nxp.com>
         <20220620034533.4108170-3-victor.liu@nxp.com>
         <ca5834ea-701f-2260-da2a-84b22d4033db@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5046ee-8e01-4b0f-309c-08da52b5d5f1
X-MS-TrafficTypeDiagnostic: AM0PR04MB6274:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB6274A62A7800C421B7D843E698B09@AM0PR04MB6274.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHj5ebabVHZiiHH8HQ3qtSnbA2nGuI7w8q96qWsQ1jK3EVssVDOwBxGGkrTAV0JamXrAymrYm4H0buF6rfaH5V2TUKVRzJNryUHXCgKwOKEgMVb9k6DgjPAVf6dfWXFOfIDJA572i+p56K9uSXQYzNFyClVifoTNUCAVrMvg3cXZV2sZ39LKRptV5xku+8wHmdNjdl3MRYi3ijK3lvlNNpVPsn49XIkUukBQYJ7IScJqguEw+ZJ/hhA78QR+G7Pz8VF/dwenECyukLrUSCk3WIAaR/5x94HoOWJ0jywE2/Gozpaxj2fehnNl9keYGMrSpx7NdjYsQbz839u87sU4txL/aotE7oVFgEXx4mJOAB0RODXpbFi3hLQzcrKmnwq/Gx1i4GHnFrTOJVLgDQMCDbwDy5EgK+K+SnorGxcXSIgcceif0SiF2gsfHHRe3YX09kghQlbTlmtLg2kexXWkT+0pYE8EBGpXTkC2W7VQZ2O+8bsdZOdXohMfHYzhuM/dMOpwse7fy2gXChH8fPB0cfjtKIYbVax4bUx9xg7yz5Pyw5neQICOSRH0jGGXmj2TsVOXC265OSmkNL7NUbqa3CqD5KuXzWSeStIR3kMmOo+BFUCIirHYzu57lE9Ms4r2GB1AKVB6uheoXwoVvpT8DGDLUoYC4JZJ6EA6elQSD6oLiE0B/qh397LEy8eL6qIAUZN9hZRnNVAb8tQTwcoUh4/1armkBQ26uMZBk7LYYjPJnFS4G4lE8LF0zJe2kekUKbryqUJTIjM93dAZ100BV8vdqQhlyTOsH5por88JNoce62FDTaoLpO6gHyjWTdQtrtNVaHmc5obSteNBQlIUc6WNJj8jk/+lXSRlO1MXQFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(6512007)(38350700002)(52116002)(2616005)(7416002)(45080400002)(38100700002)(53546011)(41300700001)(6666004)(6506007)(86362001)(26005)(5660300002)(66946007)(966005)(83380400001)(186003)(8936002)(66556008)(6486002)(66476007)(2906002)(4326008)(36756003)(478600001)(316002)(8676002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZrYmVKd0UyMmpzcWlqWFdVYVhiOEpEUlpNenZMTzFCRTlIZE9PVFlsTita?=
 =?utf-8?B?ZXREYmcrQmNQNzJZa0N6N3psbDM0eFFHNW1UQnhIYURMOU82N1F6eEpUck4r?=
 =?utf-8?B?dy9yS0lxQzd0ZWtuR0dzeHFlbGIzZERwU2pUbG1ET0syd1JEVnBqTW01T0VG?=
 =?utf-8?B?WjQzN2VvNndBNDhVSGROQStUb25ySHJYS3ozRDFjVXZwcWIxdDFvUVlqOXEw?=
 =?utf-8?B?SStOUDhJUnVBc0UwU0NXVzBKd0J2dHdjTEx6aCtKWWNkMkZDTlc0NFFSNVV6?=
 =?utf-8?B?akw2VmdJcEI1dno2NVFaTUZrZ0d4WU1FK1ZyYjF6QzJaVTZ3bmJpVjYvZWYr?=
 =?utf-8?B?MURXZ09JRVhZM2xMTEs1eHZ3Nmp0YWNncWFtWmM1ejVPd0VVTTZKaUdQTzl6?=
 =?utf-8?B?amMvN1JYcWlXVW4rQklTNmFvdkFlbWMxL25JUTM4UGVXRDNZZDNyWUFMbmxy?=
 =?utf-8?B?cnRVUC9DYWx5ZmtCMkFuVGdCU2JIUjVha2E3Z2toMDBQVGFxSndIWmxLSkNr?=
 =?utf-8?B?Snk3UW43UlJuOHl3VWdWVXUyTHpkMU5ZYjQ3N0VDdlZ0Vmk0Uno0aTBHN3hv?=
 =?utf-8?B?RE5iWEY4d0VLK3BBUjFCelBGVXgyZFRhY2JjU3lNNXVPTTRwUjJIMllseU9l?=
 =?utf-8?B?TnZncjVxRVN1THltY09WeGlxTEtSMjcrb3F4RVpzZ2x1ZklEMEZzZzR2Um4w?=
 =?utf-8?B?NWdkMHE3eUFGQVdPQjcwNm5zeC9VTitYa2IyTE90T0JkVUNBU0ZmVTdhNENv?=
 =?utf-8?B?d2lQL0Fkc3NLTUZnU2Y5THd5Qkd5dkRxRmcycFFibUs3dHl1alE5U2ZnNjF1?=
 =?utf-8?B?Mlc2U1FYTHhLNTIrWGJXNlpqWFFYM3ZGaUc1MFdBT1V6dEJHZW9JbjlWZDFr?=
 =?utf-8?B?OERJQmt2NEdnQUJ1MTZKNnB5ODk5STZ6UnhvblB3V1VnRDRpTldtLzV0WWRV?=
 =?utf-8?B?eWc2dnduQitVcnVxQlpiallHWjIxbkVaQjRGZ2psQlEycHZjazV5VXhyVitz?=
 =?utf-8?B?d2N1RCtwdFczalV2SUo2ZFA0MDg3YmFSSVM4Y1BBa2JwSVE2MzgzNW52c1BF?=
 =?utf-8?B?T1IyN0djN2ZFWVJYdTJuSHd5WE1PaXA2bldwYUpSNG9RWWs4Z1RHZEJReDYw?=
 =?utf-8?B?TlhmdXh1UHBCVlhQTTh1bitjM3Jta3RoazQ1OCtUVUhFZGF0YTRSMnZMdS9m?=
 =?utf-8?B?Vk8yUXc5QngyNmIvaE1ickJVS3VkcjhwM3AxTVZXOThyQ1RJVzRaakEyQ3lj?=
 =?utf-8?B?YnlJR1E5aWM2N0xhYmh0OEMvRzcvL1paeUZsR2p2dmsxZFFNUjVYakNUd0FX?=
 =?utf-8?B?K25OU25xU1dIb0pwNUhoNUxPYTBWYTBLUzkwS3VxSkZURmY1RWoxZi9XZGY4?=
 =?utf-8?B?eVIra3U3NUVIYjRudUZINGxUbDNSekRuT2RYNkNGdGhzZjBmUFhZL2FMeWNy?=
 =?utf-8?B?K0w1dUdVUWF4bVFMalhOVUpXTjEyd3Z0K3pPVktuV1MxVDc0Z29DaVowVnkx?=
 =?utf-8?B?WW9CK0lpQnlFaFpwYk9RSnl5YjNHREpONWdkeDMrTHJkRms0T200MXkyZC9T?=
 =?utf-8?B?d2lveEZzWmE5T2Z5L0xEMGt5bUhId0dhd3c1bHoyZXV0aG84OE9wcEQyOERH?=
 =?utf-8?B?K3JEUng3Qk44amZYUTRmblh2N3R1Uzh1TG9JblpCYkVlSSt1NCtUUTVmRGJi?=
 =?utf-8?B?YnQ0QlpQT1hDOG1uZSs5RDM5dGp2MmRWS1dvRThPYVFiclJTN241ZjRoR3N1?=
 =?utf-8?B?d1IwMXFseDg2SnAraFlhQzByQm1sZ1Q0eHJpQzN5UXNLckZLcjVMbUhzREF5?=
 =?utf-8?B?dkZNT095alhrVituNERTL1Y1SUZKWUhyZHh1aStWekl4aENOUTV6ZXZtb2Vo?=
 =?utf-8?B?Y1pPL01qQ3NjY2o1enNZdGtsNW1ISHFYY1FMU3VYV21CUnR0QWcxQm1XYnJF?=
 =?utf-8?B?WGJNSEM5Wnc5UTRkcGdubDFDU3hHTGJTaWtVdXQreVRuR25Ud01pRFZqM0Ez?=
 =?utf-8?B?K01zZUlQck1OckhaSTBDdnM1cXZGTDNrOFE1MVAzQSt3YWZvWXJxYk5za20x?=
 =?utf-8?B?d0c5RzhiMjNrUzJNZmNWM3B1aDZrdUgwcys2ZkY4b01lM3d4c2hvbkZUZXp2?=
 =?utf-8?B?TXZnU0pmV0dEU2NWS1ZxVUx2WVBSWi9ucjM1TGc3c2NEdjdLUklTM0pWWTBq?=
 =?utf-8?B?VEpycVp0TjdCSDNmakx4MlUvQnJlUVhqaVRSYWJtVCtyaWJIV1lGdUNuRlFB?=
 =?utf-8?B?b0F3UjYxUGhRZ2llRHY2Rk9GeHl4cWZBK2p0dVkwZ0pmUllTR3lYUHg2ajdt?=
 =?utf-8?B?U2lJMzBJTVJHS25PbVpQZXNSalA2b1hTMzZYTE40NDlaQ0xYaHlFdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5046ee-8e01-4b0f-309c-08da52b5d5f1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:10:15.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O7G6w5+sU42GvK30VWId58QjFj2uTf+TKgaeyZX/qstX34/mxfJ7d7C6etZdeEgZALLnKscm1SHyaQZS36l9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 12:32 +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 05:45, Liu Ying wrote:
> > Add bindings for Mixel LVDS PHY found on Freescale i.MX8qm SoC.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v1->v2:
> > * Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's
> > enum. (Krzysztof)
> > * Skip 'clock-names' property. (Krzysztof)
> > * Drop 'This patch' from commit message. (Krzysztof)
> > 
> >  .../bindings/phy/mixel,lvds-phy.yaml          | 61
> > +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-
> > phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-
> > phy.yaml
> > new file mode 100644
> > index 000000000000..4bfcc0dd987f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> 
> Name the file fsl,imx8qm-lvds-phy.yaml

Will do.

> 
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Fmixel%2Clvds-phy.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C8141f62511ab4e19e50708da52a835dc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913179660099686%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=467HslkQFKI%2FQxOyEpP2io%2BMeogqOTeArcq%2B2hS8W6Q%3D&amp;reserved=0
> > +$schema: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C8141f62511ab4e19e50708da52a835dc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913179660099686%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=v9tffg9QmyP150hLYv%2FLikQJNY%2FW51ViZsUKku2yTMs%3D&amp;reserved=0
> > +
> > +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
> > +
> > +maintainers:
> > +  - Liu Ying <victor.liu@nxp.com>
> > +
> > +description: |
> > +  The Mixel LVDS PHY IP block is found on Freescale i.MX8qm SoC.
> > +  It converts two groups of four 7/10 bits of CMOS data into two
> > +  groups of four data lanes of LVDS data streams. A phase-locked
> > +  transmit clock is transmitted in parallel with each group of
> > +  data streams over a fifth LVDS link. Every cycle of the transmit
> > +  clock, 56/80 bits of input data are sampled and transmitted
> > +  through the two groups of LVDS data streams. Together with the
> > +  transmit clocks, the two groups of LVDS data streams form two
> > +  LVDS channels.
> > +
> > +  The Mixel LVDS PHY found on Freescale i.MX8qm SoC is controlled
> > +  by Control and Status Registers(CSR) module in the SoC. The CSR
> > +  module, as a system controller, contains the PHY's registers.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8qm-lvds-phy
> > +      - mixel,lvds-phy
> 
> This is not specific enough compatible.

Will use mixel,28fdsoi-lvds-1250-8ch-tx-pll.

Thanks,
Liu Ying

