Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B5587F39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiHBPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiHBPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FA21E00;
        Tue,  2 Aug 2022 08:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLPFv41FMfOaRmyl4Wgx6UgJrql5TpkU7lu3gxed5J9M9q0SaNrC6ENOKqUxm4kXgwzT24SZElWXlW0xrLOTCDHiMHDuE+trXIqzdvjWETFBdHXQjLT4TbzBAKzp++iCCPbO0EJN4bwVLtrb7dyI3uZMo/ezv/ntWcxIdvs9XNpAou7ozQeWUj8OkU+oPgFR2qUfygoAFI4E8N0Z13rm+BWM+8uyODZvGFbwJPS3bCpv7/G/gXUsqFrC9uuFIlDpeC8qs6sRuPWfln5fkmrNWetKuEDuafV9543nRZW426e6K3DATLw0Ipnluiqou13UOIU12fOdsQTNyTbDgTS3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK66M12Y+BIyV19WXZYXayygl7ByIcbJrGbJUdus814=;
 b=bOaHPKxILOxP/t5DstP4McFcWrH+HhMeSesKHPlb3JOTZGerxcXS+Cd5JGqHHxGJ9+6itwVJn86O6l6ZCNBmlTuprSY+/J/DEw3YS3YAIP/HSi1eqOhFqIlwfvy7s1p9rh0h28+dytIgGnaOyX6CXV5MtUKz/swcB3MwFxh97k3vdTz22/XfID5BhewxgHprAh4MczyrQCJrYIdvwmzFlGALaKZqcYwkUcjBxroHq3CJAmCQNLAEAmCEuqvmprRHcyfmHUgMFq+X/3VoSyRt3XSdUT/zQIbmreEeD+fMlmQhsJ2yb30YwxF4Gms0/oCC+D9aVt73loBUXSSVJdfnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK66M12Y+BIyV19WXZYXayygl7ByIcbJrGbJUdus814=;
 b=jesODWaK1FqsXh3+elQYdqEvlmx0KJiiL38rX0ZKidMaDg2Y3lHf9Tb4muXA9RBPt3/xcbUMsALl/imnrH5iO4ENp454kVrTxqlcQpvaGjziBT+PuHAb1GHx4E279i1zMnl0MikLWwrkCxATJJCOQupxiMEcRTd6n4QK7Ugow1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 15:47:14 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 15:47:14 +0000
Message-ID: <030ccd250378b0bb870890a41e431ddeb01aa318.camel@nxp.com>
Subject: Re: [PATCH 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel link
 MSI bus binding
From:   Liu Ying <victor.liu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
Date:   Tue, 02 Aug 2022 23:47:03 +0800
In-Reply-To: <8f04b8c8-620c-3b32-ce4a-2d4b1aa484d9@linaro.org>
References: <20220802071310.2650864-1-victor.liu@nxp.com>
         <20220802071310.2650864-4-victor.liu@nxp.com>
         <8f04b8c8-620c-3b32-ce4a-2d4b1aa484d9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 115c48ad-79e8-4d98-1a07-08da749e451c
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7HM7+biUs6xOicx1hkrYrNkl9t1lMks2lEeam093qrh7uOWEf7oOQnzoM7Of7HxzpelxWMPW47vEtQF5Noyq/oMaiECj7gWBwWrhQDvO6heBbbI/H4LAhBCL+L5HWRnc+OLsZY7SHGPxsC6GvN6FJauU7MnlE/EiRfU9AhQa5+ypJiqI54j6WVgLYYjcOIpkfcHU02mKERawLRpAM5Wjxr90yAiVXbQUHbnpqENxniPH0ehsmYBck1VkV/+eeprH800+tqxFR7bCH1PdPgMAlYAvpWAD2/6wtMwWxJHUFCuyIAXUN1tNs+80RGY0qWl1q0lGzj7344Rp7dUK2aHi7EwTDVB8FTOLZ9BDSsMcEB4np9gLL6TxcZthe4nQn+PioxZ8saVqc8z9T5U/mo0hCIY9dNURpcLm0oyIGAhHLAyuXTY7XOjbw2zw64JZts5bZD0CV2gPgg13Vh4ws+qny16aYIXtmaqu2xKhMhf1E6pHlEgCm/KQ3s21DHyEs8otcH6uH+AyqqypffkXTjnt6TZdqtDg43FbEil80cNI7NGlf8gvTfHrzc1SLyY/poQYowHzOqsVqudt0ph17x9T4OiysDuftXM/ecl+tH42hSxp4p6KjXJuk3y2l5z2o1afnuefHRo82e3TlCtLpfFiiFrj7cr52gciHDi1ax9GKidxr5S9n1E1oGiwbqH2akShnzCDTYBP8F/2zxIrGVyrhcjyNkJIVlyZEU61ay04gOjiDyh2yT5HinaKoSnAPTZVLYx/ofq8xcPq7SwUjreK9USf8oJRngSN2abD1/r6VAEDdbytaHJvXZSqx5UsP5ZcRho6yDeHW2/JFaA9FiFhRWhlpLlNlYgRVJA7VSTxd7Ln29SRDmOZccQauO2QJdLu3xiT3g9Lv8q8SaIucr7Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(6506007)(6512007)(52116002)(53546011)(41300700001)(26005)(45080400002)(316002)(478600001)(86362001)(966005)(6486002)(38350700002)(38100700002)(2616005)(186003)(83380400001)(36756003)(2906002)(8936002)(7416002)(66556008)(66946007)(66476007)(5660300002)(8676002)(4326008)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ljR1VOZ1dtaGNibGVWdDFSNGtuUm5sZ3RVVU9qWVpZSldBUVk4NkgvRXZw?=
 =?utf-8?B?d01lRk5laTA5V0xwbkM4ZWVBOTl3Ymt0S1prbTlicTJEOVJDaE1hVSs0VXdj?=
 =?utf-8?B?WkRmU2tWeU5GT2FOVFcycVFXbDVWLzY0eVlKL0cyUGNnd2R3OEN0ZWo2N2p6?=
 =?utf-8?B?dlROWFRocG9RbTFCUUllcFNpRDR5b2J5T2JlaTN3dGNlZFVDZW1PMSt0TXRi?=
 =?utf-8?B?cHRxb1RFWDY5UG1GTWZ2Z2ZCK2FXbjgvRUVMbFpqQ0pOcGFmdDVwbnpWaVVL?=
 =?utf-8?B?NkliTjZTR3RHTGtONks4RDMvNktTeVBYNXpKZjFTNEI1ZituZHJ2NXA3MTBJ?=
 =?utf-8?B?NzlpKzJRZ3J6ZGhqT0FOVi9qc2Q3NGZ0dVBlS2VJVFRBbHFFZmFCd0FkNXc0?=
 =?utf-8?B?QUR4UDlpZGdFSFQxRDErYkFINGNqQk54U3JGYWhjcCsyMzJwZjZadjBNb2NW?=
 =?utf-8?B?L1o3T1NSeklwcFlJS0I2R0xOVHF1KzdseEtEUU9jQTgzbk82dGY0WEV1UjFO?=
 =?utf-8?B?WjZta1BzeFNpaWJHVUVZVXAyaWJXL3Y5SEc5ak5qdlBBMnhQYjFqak03UzFB?=
 =?utf-8?B?ZktsZ2psR21nRk53OGt3YU9zSkxOWi9EVmpsQXEvL2FMNkFxTmJybkg5dXJC?=
 =?utf-8?B?NllkTkQxZ3FlSnRNZFNvKzEvcHRRMnQxOUY5amtoQ0p2MEt0V1pVLzJOVzE2?=
 =?utf-8?B?SzUyRTdPdDQ3bjdIcTJmUDh0ZWFUMk1EZTk4T2I5OS82MEtORndmTkFIS20w?=
 =?utf-8?B?OWl0VDhhaktuZWxDbjBXNVBhQy95d2ZyYlArQUV0azgyajFmWlhTVzhLS1o1?=
 =?utf-8?B?MFJBTW5WWGxzMmlTWjJaSFpScm1QTUh5M2gyMDBvNzFpSG9VUUpsMWk5ZEYv?=
 =?utf-8?B?aC84V2hrK21pN1N1cXRvb1VRdkQ2SElNeUR1TUlJaEh2d0hYSW5KYXd0dDZR?=
 =?utf-8?B?VHREUlpNZ0ZpMVkrRzV3Z2VzZG5VLzBlNEpud21SSG40eUwzTmgwOWlTNkYx?=
 =?utf-8?B?MGxTb1JySklPR1AwdE13U1AxZHVNbXRwNS9RTnE3Qll1ZDhjZ0pwVE9Yd2M0?=
 =?utf-8?B?VUY2RGZwNWRXcU55Tjg4Y1NVcEZOakw5N3B5YUttR2xWTEhJNXN2TG5TSWZG?=
 =?utf-8?B?a2IvT093Q2p5MHlEay9lWWpPWS8xZG4zc0FmWDMxdVdUaFVHRTJONXNrWnBW?=
 =?utf-8?B?dks4SjQ4blBNLzFONG1FclpZbWl1WTR5NS90d2srYTBwNG5vT3BoVFFmZjFU?=
 =?utf-8?B?MEZUeTYwOVhJczFPN1Y4Tko2Q1NMTVNmVTVuaFFISExsSXN6SnVvOHRTYVZy?=
 =?utf-8?B?bXFGUjVhZ0U1NzlmSHFRa0J3SVdNRUwvTk9JbTJ4eGVPTllxNWFNeHZ5eTlR?=
 =?utf-8?B?aWJBRXBMOU8yVmZzK1ZWNzkvWEQzZmkzbTVlQnZOYW1jWDNXYmlvRjlMSmZi?=
 =?utf-8?B?NG9WTk5zSVowb04zamFyeURITE5KVWdMNTZvY0RROWVDT29sVFdwWTExRzdk?=
 =?utf-8?B?ZW9wdDNkaHFsSVZGTlI0ZVBEektJL056eWxFc2pCQSs5SlFwWWxiVjNHcFFY?=
 =?utf-8?B?K1FWYVRpT1dsV01JRDFtRHpzUTNMNFVQeUJjY2gvVkVJRFpZVzgxSjFqbkRv?=
 =?utf-8?B?UmxnakRDd2RSbkc1MWdXRjF2YnlNN0I4Z1FFbHV6bEprait5dDNQUDlkd2Fj?=
 =?utf-8?B?ZC9XUk5NSGFNaThwdzdDVCtaUmJKKzUyMTIwQ2VCTVhSMTNqU0NNY3pmRVBx?=
 =?utf-8?B?eXJTeHBGWUcvOVB6bHM5UjAyYk9wU3hhV3hHNTUyTzBZN2NELzV5Z3g3dS9L?=
 =?utf-8?B?czVpQmtMUTMzNDFPbmd6T3h6T2orQ2RoUjBIbnh2MWZoTEdKc3F3QWcxeHoz?=
 =?utf-8?B?WmV4Z2xlS3hJd1VWUHlsQmFYUjRqcVJaUWduWGxmbGh1Q0tHeVJzWmg0Qm9x?=
 =?utf-8?B?QlRZT1Y5MUNVTWltV2ZIelpoeXByakQ0UHlWc0xIcm5vMmNSMWVGdlpUYjFQ?=
 =?utf-8?B?NHo4ZnBwdE0yTnZKTEdiZmRtS1NsZWp0aitLZVZMaWhacUxDS0l4cVdhM3Er?=
 =?utf-8?B?c3RtZDROdnBkL0p4OVZ0ci8wT1ZoN2grUWdGMEJkdUVENVl2Mm1aTXVpd25W?=
 =?utf-8?Q?mxk/SSbIz4sb7dg7BbDk0hKVJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c48ad-79e8-4d98-1a07-08da749e451c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 15:47:14.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEv55VRNosxUl36AE7GYQe3VzVTEAdhTqAczjU31NVsbMIfEZ5ssm+4vgKPFKzYs1jPlt28eFd1pWktODHZVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-02 at 13:04 +0200, Krzysztof Kozlowski wrote:
> On 02/08/2022 09:13, Liu Ying wrote:
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
> >  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 84
> > +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> > bus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-
> > pixel-link-msi-bus.yaml
> > b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-
> > bus.yaml
> > new file mode 100644
> > index 000000000000..24f50535f5c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-
> > msi-bus.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fbus%2Ffsl%2Cimx8qxp-pixel-link-msi-bus.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C7ee06e5e179b4cb8529308da7476be70%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637950350594434521%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=GsZgqUmEsVm2If6bvx%2FrVOFWnaiJp2zFVERvzWP%2BecM%3D&amp;reserved=0
> > +$schema: 
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C7ee06e5e179b4cb8529308da7476be70%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637950350594434521%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=v6x0rQDqg%2FrLshXZvKdeM97IdOWtnu9O5o0Dz3%2FQID8%3D&amp;reserved=0
> > +
> > +title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect
> > (MSI) Bus
> 
> Shouldn't this be interconnect, not a bus? Not only located in
> interconnect directory but actually being proper interconnect?
> Although
> you mentioned that the firmware controls it, so maybe that would
> explain
> this being only a resource provider.

Linux kernel just enables the power domain and the two input clocks
for the MSI bus, then the MSI bus starts to work. All other stuff is
totally out of Linux kernel's control, which means SCFW doesn't expose
any direct or indirect MSI bus control interfaces to it's user. So, it
looks like the MSI bus fits into the simple power-managed bus category.

> 
> You should be sure of it, because later if you want to add proper
> interconnect properties (e.g. bandwidth voting, paths) *you will not
> be
> able*. Ever.

There is really nothing more than the power domain and the two input
clocks that can be controlled for the MSI bus by Linux driver. I don't
expect to add any other properties.

> 
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
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,imx8qxp-display-pixel-link-msi-bus
> > +          - fsl,imx8qm-display-pixel-link-msi-bus
> > +      - {} # simple-pm-bus, but not listed here to avoid false
> > select
> 
> simple-pm-bus must be here. You need to sort out the select instead,
> just like we do it for other devices (e.g. primecell).

Will do.

> 
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
> 
> compatible and reg as well.

Will do.

> 
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8-lpcg.h>
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    bus@56200000 {
> > +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus",
> > "simple-pm-bus";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        reg = <0x56200000 0x20000>;
> 
> put reg just after compatible.

Will do.

Thanks for your review.

Liu Ying

> 
> > +        interrupt-parent = <&dc0_irqsteer>;
> > +        interrupts = <320>;
> > +        ranges;
> > +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> > +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> > +        clock-names = "msi", "ahb";
> > +        power-domains = <&pd IMX_SC_R_DC_0>;
> > +    };
> 
> 
> Best regards,
> Krzysztof

