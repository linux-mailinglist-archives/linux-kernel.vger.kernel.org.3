Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72EB551849
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiFTMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbiFTMIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:08:52 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50062.outbound.protection.outlook.com [40.107.5.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD7213E08;
        Mon, 20 Jun 2022 05:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW0c89ae+2HgNk6ahWrts40hcQA674ryEY0nAP+p+3dcxEGJbrtW16gigc+NBiB78fyjLCQMv1obYw9+Ucf/H9q+T/MRRAMozOg3bb2wgorzibBAkciSPLBIzcuCgR+qGwwA80/sgf9yp73pv3eMZ4/yMyW0iWR3vPapASTOz+WXbRZj7Kuri+DzWDfMveKtijK+xWWM2sngCYO+kLEtK6hLR5YTG4GOrNpNyIJPoI5w3i6gFNXFa9UB1gTOf7hL74RIsvgamjW0MdqQOsDkBccrve+ueZSXrpirYnerRZib0xjH+nVe/9igTrFk98LLA3/EUYjy4zCNBYSSFnh3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAu12xdVxw+GOhi1bBmjZVoDtl3Gt5OuOWnKSVE7jHo=;
 b=gJ/xB9ORX86B4y9vNX7PxLS6QEgmJ5fSRNnf2lmulhxAaI5ueRBbeHppKardtixwLX0RmiHEt2ey99X6hyqUBa5VCWcVaHRTqrn/cn7F1lFWuDYnMWHlaAqMMxpzf/v5nYW1pG8wGg21SW/W3hRr/gJUds8V85I6P4F3lsCN3kt4SdnY7FbxYnxJKaW1LtdjOS7qzWftCLzR8dHYzFFiwcDyYlB/dtvqrT1PwhA92BE0pUe8FRbAd/QcNP0idWZ4JYtCfKYVqmjVXORIkL5oPJYbKhrld1xYi4C3ze9hMPcW5x3jrw1T9aiTXGTfZHu68GuF4b8AQ2PokI0Hwrf1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAu12xdVxw+GOhi1bBmjZVoDtl3Gt5OuOWnKSVE7jHo=;
 b=BQVsaxyrNNJhm+8LoRsUjkqaOPUsg0TKQJtOQo+/HBdwsIs/oyUOU77R2SX+bMwGtDcgU4Zw9o9FpmVB5wAapWBiH98FwwOCXdMA+nlap1Gu7oZ2orIsSuAS8ysbVkxYeEJsPQdMCj3M6eDciIr4DPQqQiB+a7SVM1QzsOX+H1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM9PR04MB8399.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 12:08:41 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:08:40 +0000
Message-ID: <b067735796b36730e3ca4e63aa1be8cd899b9cac.camel@nxp.com>
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
Date:   Mon, 20 Jun 2022 20:08:30 +0800
In-Reply-To: <7c47bab1-cd64-cde1-a4cd-cca6514bc57f@linaro.org>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
         <20220618092201.3837791-2-victor.liu@nxp.com>
         <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
         <89a29795e918343583f45b0f8a65a002592f8b15.camel@nxp.com>
         <3f805983-47c0-9be1-f221-4cd23b847018@linaro.org>
         <d8af25c1d5e81d6b308c3162aae670f091b59bd4.camel@nxp.com>
         <7c47bab1-cd64-cde1-a4cd-cca6514bc57f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1503adfb-1e34-4b04-75c2-08da52b59d37
X-MS-TrafficTypeDiagnostic: AM9PR04MB8399:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB8399CE13B4F87D2FFC18537098B09@AM9PR04MB8399.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bIwU/5cj/PoFk2OZEetTZDXzPRbALTzfr7hxBr2yfzkj/8VP5aJBpBkuwS1MiacMUqehca/4QtfX2brHPOIOjXOOe0FzryJVeXcKjoXNpPaQCDIqLkzQMlRLFCUs8/8A6VUfeHjitle8SPTU4fSkualnNiCZKmdu00/ppz5D+37eA7cTJrk4KDoNVWuv9fnhPbaHG77uRkeuNztpLfy07G+5fqUe35HFzPTFBMrQg1IxS5I6yH027w1WbH9bZUGhGh/Jgb+uGrTvA15Zi4EPw2xAg6jPE6TDo5l/g59doMY8/CBojQ82T6LWDIGOyw0ojZ/VnzbbNOFT5Z3+r0tNkydk3rNqoBx7hbOByE87C8QRSd8C/9P/UaBNhD0zXpY6l/+QlrNTUalaUh19lGoqrdLBWG6lRT/nsqsKKsC0BRVn5HvWflFta2pIAfjCL8lq+IqgItVp4cmra05vFPaw5rvsdgvSeGmCV26dv6PoR1EUXhc+G9WZSXCX2SCeebiykC62y91H8V3/NMmD08VQX+jjZNo/T6zXk9M2N0fs3rPrTEJOCro0PM8onSmljocfRvDth+17YImvlMvetF/sINJylxsQtlelggwJAVqb2QdmChVuyKbWAeJFxXGek9H3PYdOe0oofo7T/UT2bLxReil0DxWI3/Qi6WlqIUtlovbWbDIK2YyEi6+dQlUeU5hVELuqNMNxTx56OcZoq4BLiolPVeK0SkbK8MItcNPhvdL5fxzRpI+AgdejnlYJrQeeOkyjLHIQfkT+uoX1cymVp8WoMwmN1jPtDboo93MfiFtspB6VK8BWT7hZTT3Kzdbi+O2ULbRzI9cDtBKIcp3TcPLWbTgub+a0kCewDSbY9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(6486002)(966005)(45080400002)(6506007)(41300700001)(2616005)(8676002)(4326008)(36756003)(5660300002)(6512007)(8936002)(478600001)(7416002)(66476007)(2906002)(86362001)(316002)(66946007)(66556008)(38100700002)(38350700002)(53546011)(186003)(6666004)(52116002)(26005)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhLV2tzTGlWTk1mR3M1eEx2M2RtYzVHNTVrZXF3WWpwa0RBSGc5bzNrUFg1?=
 =?utf-8?B?QjFBY3NHWW44TnlaZllHZ3dZS3ZIWkJQWTdFU2NabHBwVjFscVVDSGxuRTFu?=
 =?utf-8?B?blhWamtjSTZqN2JWZEpBOXE3NmEwUzdUT052Q0szbXBrNjV4MDZZOHE1YVQ0?=
 =?utf-8?B?dXNpMjdDWSs5YzJzTzZxeGIvaEpVR2lKK0xZWFdiTXlXMGpNL2ozK2NIYXdW?=
 =?utf-8?B?SHdaQkFxSGNIVFdMRzg4WCtmSGkvQjJGTklGUG1BQVk2VUZ6R2p2MmlvZDZ0?=
 =?utf-8?B?VFJ1cXBzUWUrQmVkRVRwNkFoTFBBbGYvZDg0VUZNWThxekpUTnJENFNMZHVk?=
 =?utf-8?B?Yi9zS1o3L0owb3JuaVUwZUlpcFpuSFFuTllmdlZTRjYwaDJHNlV3NXlxaS9P?=
 =?utf-8?B?OWk1bnc3UEc0aFlYNTNWck1pdHFrWG1UYmoxL2lNNDZYSjdENFlFK3NoVHRh?=
 =?utf-8?B?ajhpRGlrcGFQYldYcHB6ZlNGU1JZTS8xRUdEZk1lTElxejFKaDFJd2FVSXMx?=
 =?utf-8?B?eHBYWWxiR2xBOVA4MGVxeWdXRHJFMFdFWFVlQkFWMThhTGx2aThNU09FbUxy?=
 =?utf-8?B?SmlKOG1nQ3VvUEZSR2hYam9YNWtQd3ZWVTYrcFh0YWwwUDllc1JmMXdBdDE4?=
 =?utf-8?B?MDNqQTJFLzVhMUx5cTRrUmhQLy84T2FiVUNhZHlvclMzUXIzaENNVUNrMkRs?=
 =?utf-8?B?UjFNQnVjeDZOVW9QQkRXd1JIWTB6RFJnZzVuMnNKQ2ZuSEZwSmwrUFlKbVVl?=
 =?utf-8?B?WGxLRDFCalJXa0FIbEVWUEMzbnN2RituU2hlcEsxMHg2YStKWlkwU3BMa1lX?=
 =?utf-8?B?WHowU3pFUElkcnFQOU40bW1lZk1OM3lDVFRTSVkvNWxRM01hRnhuaklqWTkz?=
 =?utf-8?B?ekVGN0x3OEl0eU1MZTlwSzhnci9oTWZBUXlPKzlScHExVGJ2UGJZV2plUDN2?=
 =?utf-8?B?UzFYZWJrekFBL1p1WHBXUTlad3FtNXdVSkhpMVVkcDJKS0IwVEg4eDNTUGt4?=
 =?utf-8?B?OVlqbXFRQ21zSVBFU3RaY2ZvSWFkK1M5aDZodE55Tmx6V2YyZWlMbHZLRzhE?=
 =?utf-8?B?UmplcmhQdi9URmNOM1dVaEM5c3oxZTdnd1pDWXhjbjRzWWFkamNIQWphTHEy?=
 =?utf-8?B?ZUUvSmY5TjRUdXIwMDY1T1hLTWZaNW0yajVjcE56OGtML3dvL25tcEhSa1Vx?=
 =?utf-8?B?RWozc2pDRkd4UkJwTlNzUmRGQ0J2R2R1ZnJaMUg2d2ZJeG82MFRjVTl2VGho?=
 =?utf-8?B?Z1NDUkdQWmV1dGlqNmJpMDhDczYzVFEwNmd6YkZiV1MyTng3bzRxWXlPaElK?=
 =?utf-8?B?QU05Ym9KWDNhTWdSS3VFWU5iM3V6dEFtQVhWNlNNZjYwZGd4UStYRlV3RlA2?=
 =?utf-8?B?QzBzUWViUHpwUEIrcWtva0kwR3M5TkJXK0FqVVZCSENSdFk1L1V5a2l4cVJ0?=
 =?utf-8?B?dHgwSlUrV2g4UWh6Ny9Pc0MwejNkSW9jaW9XcTJSaEFoOWtmaGQ4ZVk1R2ha?=
 =?utf-8?B?aUNmMkZDL05DS3p3ZjdlV0IwOVdNS3c1UGpRc2lYeTJaRkZiK1dwNDhYVHN3?=
 =?utf-8?B?VWtrcnNqZEJzS01idzB4UEpKS0Q0N00wZitZSk5vUm00NldnampvaVRGK0ZX?=
 =?utf-8?B?aVlXSlRFODl5RS9QSUYxS2Y0SlNEdHkyRjZxVjZrOW9ZUlRQN1VlM3FMVXF1?=
 =?utf-8?B?bFE2dkVVMkVYdkpEZGJxL2FiaWJuODJ5V0xNd1o0WEtwS3pjR1VWb0ZsWG9v?=
 =?utf-8?B?aXZiVjRUYzVHL0NpUSsyc2krK3VMU25aeG5ycU1jNEkreTdFUlBYdUg3eUQx?=
 =?utf-8?B?aDJkWnkwR3Z0R2J2d21PeGdDNjhDSC90SWF3bkVNdk93OXd1OFhaNmlCVURx?=
 =?utf-8?B?NmhXQ0lMbm5KbUROZXI0NlhkNExwVkhpV3Z6dy9QSkdBZEkxOUt2S1BMN3Y0?=
 =?utf-8?B?cWJ4ckNmazZsdm9GejZrb3JyNzl0MHJCTmVUTUx5aDNXUjRRNzlGcEt4VVhn?=
 =?utf-8?B?emtvcU5rdWhJajRyMkNRYnJYejR3RHJxNFYzLzIxcmtWWG5CRFVRRHhmOUo1?=
 =?utf-8?B?SDltbzZSdGl2WnhHQ0paa3lCaG9IcU5tQWVXTWZ5dTF5MTZXTnZEbnF1eHBV?=
 =?utf-8?B?cy85RVIrR2JUTytTYXVEbWg2MU1zOTJzdnRKVGJWeXNVUUFVZjFNL3p5aG1N?=
 =?utf-8?B?Wk1mVXNVcjJwMjJYMjA2Q083TVJncFRmdk94ZDk0RFgrcDBXcmhLSE4wenA1?=
 =?utf-8?B?UGNydzcvQ2crdFE5R0pYYXZHd2YyREIxTmZzVlYyMVdNVlNhZFQyYzVYcW1K?=
 =?utf-8?B?T2lwN3R1UzM1czkzZmN1SmExZk5iaHB6eGdwTmVCVHZDVzFKbUhudz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1503adfb-1e34-4b04-75c2-08da52b59d37
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:08:40.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRXFK53Dv7bIPzHusNhqQNP8U5ktzYg6oybffd5Ry7vw83oti+ebPPae83S32x5Yoelaqh6N2wcRXuNnVa+akw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 12:38 +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 09:56, Liu Ying wrote:
> > On Mon, 2022-06-20 at 09:35 +0200, Krzysztof Kozlowski wrote:
> > > On 20/06/2022 05:06, Liu Ying wrote:
> > > > On Sun, 2022-06-19 at 14:11 +0200, Krzysztof Kozlowski wrote:
> > > > > On 18/06/2022 11:22, Liu Ying wrote:
> > > > > > This patch adds bindings for Mixel LVDS PHY found on
> > > > > > Freescale i.MX8qm SoC.
> > > > > > 
> > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > ---
> > > > > >  .../bindings/phy/mixel,lvds-phy.yaml          | 64
> > > > > > +++++++++++++++++++
> > > > > >  1 file changed, 64 insertions(+)
> > > > > >  create mode 100644
> > > > > > Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/phy/mixel,lvds-
> > > > > > phy.yaml
> > > > > > b/Documentation/devicetree/bindings/phy/mixel,lvds-
> > > > > > phy.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..de964ffb9356
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-
> > > > > > phy.yaml
> > > > > > @@ -0,0 +1,64 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: 
> > > > > > 
> > 
> > 
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Fmixel%2Clvds-phy.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C968d5a1e2f5c4ccdd77908da52a9148d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637913183390683087%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=h8JmjvGBnTcMn2Uk3CVgq%2BB4%2BlbCBA5iDD7OhtFZyZo%3D&amp;reserved=0
> > > > > > +$schema: 
> > > > > > 
> > 
> > 
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C968d5a1e2f5c4ccdd77908da52a9148d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637913183390683087%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=bLsmtGPC8tzZSHPqblHOhx0gnsgFHlKVu0P8dN6G15s%3D&amp;reserved=0
> > > > > > +
> > > > > > +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
> > > > > 
> > > > > If Mixel is a vendor, it needs it's vendor prefix documented
> > > > > and
> > > > > used
> > > > > in
> > > > > compatible. Filename should match compatible. If it is not a
> > > > > vendor,
> > > > > then filename should be "fsl,imx8qm-lvds-phy.yaml"
> > > > 
> > > > Mixel is a vendor. I'll document the vendor prefix and set
> > > > 'fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's
> > > > enum.
> > > > I'll keep the filename as-is.
> > > 
> > > mixel,lvds-phy is not a good compatible (and filename) because it
> > > is
> > > not
> > > specific about component version. Please use specific compatibles
> > > only
> > > thus also specific filename (filename should match first
> > > compatible).
> > 
> > All the information about component version I can find in the PHY
> > IP's
> > data sheet is '28FDSOI-LVDS-1250-8CH-TX-PLL'. '28FDSOI' looks like
> > the
> > technology name. Do you think the compatible name can be
> > 'mixel,lvds-1250-8ch-tx-pll'? Or, any better option?
> > 
> > If the compatible name is ok, does the below compabitle property
> > look
> > ok?
> > 
> > ===================8<==============
> >   compatible:
> >     enum:
> >       - mixel,lvds-1250-8ch-tx-pll
> >       - fsl,imx8qm-lvds-phy
> > ===================8<==============
> 
> 
https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmixel.com%2Fwp-content%2Fmixel%2Fpdf%2F2018%2FMXL-LVDS-1250-8CH-TX-PLL_SS_28FDSOI.pdf&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C968d5a1e2f5c4ccdd77908da52a9148d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637913183390683087%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PWK82Pf%2FbBti6PXNq9wvFbjM6QmnZWcj7bWSh2FYAzA%3D&amp;reserved=0
> 
> mentions entire name as a device name, so with 28FDSOI, but your
> choice
> is also good.

Will use the entire name with 28FDSOI.

Thanks,
Liu Ying

