Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2B550EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiFTDGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiFTDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:06:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E73659A;
        Sun, 19 Jun 2022 20:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI2xpKg7hLDwau0IA+Ig3umawG2Udsr4z6YAkgYdrIJtiZvZ98TzAZfxTCUtgx5dpIhICq6wEnImtkEeDTaYmkHFMmNJZd8MVvA1RlOpyc6MlWWPBWhcf0+Foh1fiY8requaYEcqnzX7sikEojKLfSIKaURhHEJzF8rylVsag4YjC7GRmdoKwxKmDY37U44Wy9p+PQCeO+kOzLeOySyZxYsE9XlJ00jVuotWeRjgwXADHsykfeBlqDaXe+3kaLHfY9rxhZiMGy1o0O81DQZPsX9HJ3qn5KY/lQNy5+CQiyUeVDTYEiIqHn8SR3GYNttqRTDglkqjrtlISjfZdgyTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2gfzsnvX8+r6OhQsmxd87h+i9UHI2z8kLH4MNeb+ps=;
 b=heYq7hLV5wzUNzby97w62hGXP+mnyNgwH/kcyur756V4X0gjNj2RDSIEV6gQZQXH14Ul7SygpO/nQkviEftrzCNLDiy4CiJg/sWWZfTr/l6mt14wZhrySZQmW1GVbEZ02W04tSoM2W9lr29dgpdbsd7gP5BnCX1N0wCSYoLGA55c802iq9ZRljvPo4FkDKXiAe9TJo987pmWls1r4AlZqvYVSzl8KwF0DM4Dy56tR2WY0Hf88ky7J+D+NyUNB7lSIndJsg54tZpXtJR7fQz1IeySvWX4rX5KB12E0hdR1lM9BXohxxX5iaFEE+RmLOSikYP19BUl4vOrziBINwCNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2gfzsnvX8+r6OhQsmxd87h+i9UHI2z8kLH4MNeb+ps=;
 b=T1t7E+TSKTn01VEqdcjPp//UpDdIlVTSS7PzHnpDLRfpCcqzDCzS8q731+DhWrywfofyf3A4zQnQfEB/Sc82sdTyWpdfa08+7cqewOpEx0+10O11QJfw5TVj5EBLx3RihtVAM2EEOXrVjZsX0tA2KU7G1uqA8ra34vqs6hVVHIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by HE1PR0401MB2602.eurprd04.prod.outlook.com (2603:10a6:3:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Mon, 20 Jun
 2022 03:06:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:06:28 +0000
Message-ID: <89a29795e918343583f45b0f8a65a002592f8b15.camel@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS
 PHY binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Date:   Mon, 20 Jun 2022 11:06:18 +0800
In-Reply-To: <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
         <20220618092201.3837791-2-victor.liu@nxp.com>
         <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bbdad1-7f38-45d6-8f57-08da5269de5e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2602:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0401MB260248D9940DAEC3B958F0C098B09@HE1PR0401MB2602.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86Ief8pqaP7fZLrwN9kcD1psPKVaRFDEKy6lhHfY09fyHHP7b4IHBscm7QAbVhqegrDrNNqm3xm1EB/BTYJI666As75O7e6ucb2/1XfARbTgDo//WySCZMChFkVcppw9w35GiXq2n/fRCxL1tC/0hNyGo8NNF55tzwmhKXUYkyG40NUE9bTkzNs3cJgMH5EaVMtKHTfZMalbvR1Cn1ZlngY6AesGD9PBH1IPCFLluM5GUXr05vgQRhBlI61PzMVYTSeFPoq+OqRIrjmtZIWjH27HlOHUqn7eWeLVuegfsh5osn7k+iytg1SZxbBwSSwbTtah5cp6v+LJIsPLI8EzmU0qtFBDrRhHNGXIc64w+vX3r3rO32h8CGaEq2XQNFVaTYwmMsrnp77ckR1klU6ef9aJrU7jVbt18VSpjptS4dQj/FKSImMHe5s7H9MN9KtGpSoRdoCWj5JmBgyE+K3fySfz9PpVeNw4TLd432jB8WzSpK+Y1j8RT1YjND2mDzlCCwMz3VyqwutHhsdLkodY2oQAOkW19ICc5UIshGtTDVS1eiIXkGNbZevwIe21PIuMLsgfaNidJhbvmjnhGauDyYzLBxetQXu4/Vj15gMUly54jxg5zveBOBQ1Ebd4mdzOpoIBd1unMvU6PO9RrnPB2JZKkbft1Dt+eB6E85E07fo0lq3mf6KLas06eLpAHdYUWI7o+Pu/1cNoTOgtueJ3lrTl6T9bBTN0oi7Zu7FFfePi7DPnzHvu3qAKnN7F9Lz7EudRyKyg/AsPCeXCFtRVO4uWuSVy31ZHnCFvX9mQZ5mBYhm1j7D8wSRR+pY8YZtThRzzsqAAPYSK7xHHBt5ue0/GdalDa+vYY2rrape1OTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(4326008)(316002)(66946007)(36756003)(26005)(2616005)(7416002)(45080400002)(5660300002)(186003)(41300700001)(8676002)(83380400001)(6512007)(86362001)(52116002)(53546011)(478600001)(8936002)(38350700002)(6486002)(966005)(66476007)(2906002)(66556008)(38100700002)(6666004)(6506007)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhoMWFGcDZJVmpENWxCN2ZQcklHSXJWTW1GUHFVU3BqR1Q1NE02aW5mSkhZ?=
 =?utf-8?B?bmRrUTkyQTRHU0FOajk2WHVIbWpoZHZOZnV0dGthVkVjMWtpeFhwTzFmc2dB?=
 =?utf-8?B?dmp1NjVrbkJVdCtkY2JsWEJOZC80andJUHQ3S1JoYjlhek9FSmFOaHlDUWZW?=
 =?utf-8?B?SVZSTWdZR0J0N21WWmY5djdQbUViQSt0NUtObmtWSWVremN4S05STjBvNlJG?=
 =?utf-8?B?ZHFxODl1TWVsKzd6NFRpUEZ5Q1NHaldHQU1mOTJCWk9FWklLcm80QlB3cDd2?=
 =?utf-8?B?eHljMGtQZzFFZEowVDdPRUpQSWdScnNPYnpYS1liaVhjNEw5UGZ0aWNYcnc3?=
 =?utf-8?B?WUFsbGRBOGJqaThFdlJkR2FiTkZ5MHg5YWlWU25ZUkxxa0pEZnQwTTZMck9u?=
 =?utf-8?B?TlRmUlRESUEwbnZXWjVOcUlIUVpVZXJUYS8zdCsrVU92cng1STQyUURiUUc0?=
 =?utf-8?B?c2FHekE2LzZBSEdubHVZeWVubEZvMHA3Zm5ScWc2SitqWC90bXYrMnpuNWhv?=
 =?utf-8?B?RzgwMXRLenNqY1lSNnM3bzZDbXVuTEZYZlhKY2RuQW82YUNwaHBXWU8wQzY1?=
 =?utf-8?B?ajVTalkvUUdsWnJRcEUzOUI1bGxBMVEwNVNQOTlWSXdSQ2dFMjVxUDRDY3Bk?=
 =?utf-8?B?WW1ZeW5RUXd5aGRYeEJQWE5MT2pMV2tKUksyRlREd2JlWHZTRC85clU5REk5?=
 =?utf-8?B?S0NVdHhiRGRqeG5jbTV1THVtNWkybjY3SHVsQ3lka3RZWk1iVUV2eHEzditr?=
 =?utf-8?B?cGYxQSszNzA1MW1vTlFiNW1YV3JlYjN3c1U2T0RPdThSQ08yRk5NeEJBYXFy?=
 =?utf-8?B?Qzkvcmw2a1lxUUVXNFN5OHVlWlhnUForL2RaT1dpTU1UVk1hRWRpekpOY3lJ?=
 =?utf-8?B?eUo3MmFveEtLeVJNWHZUOVNRTDFDUFlNU0JVdWlXUGVXU3JRNXlDUUlaSGNP?=
 =?utf-8?B?RXFTeWx4SHRDZ3V6OFpaUm1oWWpXMUFQQ3BwWTFpcU1ncS8zMUhRT2JwR0pq?=
 =?utf-8?B?TWpITnh0Z2l3YnhFNk52Q3hZM0NRRi9XcEJuOEZSNmdVcXdkRUJjOXhKZlB3?=
 =?utf-8?B?L0o3dUQwcnRTVGFYTWp5S0luNVdCZHFpeVVmZktRVXA0Nzk4RDlndk5XWUJK?=
 =?utf-8?B?L2g1OUFHNjk5dnZSeER3OC9Fc0VIY2ZrcnJ3dlcrQnJLTjJJR2RPVmVBMnZB?=
 =?utf-8?B?N1EwSkxMN2orWC8wcFlxNGUwQ1BhUWhqaWJ0SWhmYnRxK0ZnUkdEcThoNVdj?=
 =?utf-8?B?V3pPeU5NSHhvYTN5cE5rVFV5WVdUektoQnVZWWwxbCtuRGhPS0dmUmRIODdT?=
 =?utf-8?B?eUUvVkRRY0lBejF5SDFJWFpvYlZQNzJxaDQ5Qko4ZVZVSFVvMmZQZXlhYVRu?=
 =?utf-8?B?Sk4zVjNhTGtYbzJKcmNtYjF3L3FudkdyNGNZbFJ6cTFta01ENHUzeVVoWmMr?=
 =?utf-8?B?anZqR0c4WmxvOHBNWEtnaHg3em1xQzdrQU1CR0RERVh0WjkzOGphY1pET05V?=
 =?utf-8?B?ZTdmdWdtT1pmc2M4R24wSm45QUFFSlJKZTYrM2VvVlp0d1BCVmhLT3UwWlR1?=
 =?utf-8?B?REtZeCtLVGc1emQrNDdlUHptK3hyYXlwMzBnQ2s2c0tNS2I5YjJCSHVXMmNj?=
 =?utf-8?B?NFdvNythLzFjSFU1U1Q4cHVoSUNUOTRaLzhBMkRvaG1FL2Yzam4vWlJPS3N5?=
 =?utf-8?B?blRHVjd4LzJ4R05KVUR5bHJUK0IwLzlMd3ZKRThobHlLaCtkMytkN2ZYUklE?=
 =?utf-8?B?Y1Fsb1puQnh2MFU0Q0JMcjA1VUhDM05yMDRvdFNHbG5BMGNoTHNKcFkzMmwy?=
 =?utf-8?B?MVptaGsyVnJrN2RiT215VlBCUkhoLzFtZ0YxTGx4WG1vUW9YOTB4K0NRVVVK?=
 =?utf-8?B?a0lFa2ZVRmJHejRVTTh4YS9odnh6c0dRWmVFMGNNZk1KQ1E0MEpjczZBbWU4?=
 =?utf-8?B?Yk1OTEMyZkJHZlV0aEYvdzdXQnpnNUpXTGovRjlYc3FmRE9ld2JKY0RvdzdW?=
 =?utf-8?B?MWpuTFNacCticktGK3FQM2Q0KzA1THFOdk9QT2lrZDJtWjBmb0JadW4zcjNK?=
 =?utf-8?B?cDE1cXBGMEFBYW1pVU9PMUdzb0VmWEIwSEdxbHJlalkxTUtzcWxLVGRHYk5v?=
 =?utf-8?B?S1VWNDJsaXg0U3NYOGJET0VTOUI4OWFzZ0NGZ3R4bUFJb3UwTmdLTGRVL2Nq?=
 =?utf-8?B?TktaUCtQeDNWU3JhbWFTKzNKeHkwSDRnQ2NLWE1tdEREZFFJUlJmMFhwclhi?=
 =?utf-8?B?eHlMblJHdGhrSUY3d0NWeVUwZDlSSkxrTDA0azhqY2d5cTRac2ZkSkYxbENl?=
 =?utf-8?B?RXg1L0hBWnZEVThpWWJHRHZ3Z1o0bDBtMWx6aDBPRlVvNm15aVdsdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bbdad1-7f38-45d6-8f57-08da5269de5e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:06:28.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCcrc1RmTLsI1jmONVwhVtOSWlxh3frYuoK3e7UaVIJNo7D27Jgf8EF/KKR5p4zW/YDiNXECECtZ2Lih2/NpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-19 at 14:11 +0200, Krzysztof Kozlowski wrote:
> On 18/06/2022 11:22, Liu Ying wrote:
> > This patch adds bindings for Mixel LVDS PHY found on
> > Freescale i.MX8qm SoC.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  .../bindings/phy/mixel,lvds-phy.yaml          | 64
> > +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-
> > phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-
> > phy.yaml
> > new file mode 100644
> > index 000000000000..de964ffb9356
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Fmixel%2Clvds-phy.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cb68f9012ddcc44bc10cd08da51ece7f7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637912375188731290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=MdBILPYmfYeWeCXXNxy1mu1NcU0b6EW3QztYc294dd4%3D&amp;reserved=0
> > +$schema: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cb68f9012ddcc44bc10cd08da51ece7f7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637912375188731290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=MhHwku8rbDLAZAQh1T9CGFULMkk5MaNoj3LQnQJ6VXM%3D&amp;reserved=0
> > +
> > +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
> 
> If Mixel is a vendor, it needs it's vendor prefix documented and used
> in
> compatible. Filename should match compatible. If it is not a vendor,
> then filename should be "fsl,imx8qm-lvds-phy.yaml"

Mixel is a vendor. I'll document the vendor prefix and set
'fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum.
I'll keep the filename as-is.

> 
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
> > +    const: fsl,imx8qm-lvds-phy
> > +
> > +  "#phy-cells":
> > +    const: 1
> > +    description: |
> > +      Cell allows setting the LVDS channel index of the PHY.
> > +      Index 0 is for LVDS channel0 and index 1 is for LVDS
> > channel1.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: phy_ref
> 
> Maybe just skip the clock-names, it's not bringing anything useful,
> unless you expect some more clocks to be documented later? (but in
> such
> case question would be why they are not documented now)

I'll skip it, because it is the only clock required by the PHY IP that
I'm aware of.

Thanks,
Liu Ying

> 
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - "#phy-cells"
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    phy {
> > +        compatible = "fsl,imx8qm-lvds-phy";
> > +        #phy-cells = <1>;
> > +        clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
> > +        clock-names = "phy_ref";
> > +        power-domains = <&pd IMX_SC_R_LVDS_0>;
> > +    };
> 
> 
> Best regards,
> Krzysztof

