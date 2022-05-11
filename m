Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB1523798
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiEKPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEKPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:43:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2900980A1;
        Wed, 11 May 2022 08:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg7ln+jlq41jpf7Aera1wR5oaMnGuQDrB/vdhHktSSh803WV4OaKD8Pabs2JFzp/Vsr5Oh0YPO1/G7JwmVUFJ3EAK1A0lL4r3hMStFz/7cY6otPqjg2HlOXxX43q+dP+3lwMeRAxzf3pGcBcMpSZJZzLiAUZSSwCMJ90IedzUrOzEJUiUWT8dsMcsAU2zw0w8dKapeOG2fyrDHZ5kcG/jl3uYuOEgibPyETd+pPAml96jfEojy9MgAgFhk2fe/YbyV/BzkkavKV9ExOJdBVFq00GaONpmFip/3I8dMPA15zV1KyMX96dgxnXaR/HjJMkZmIYz+tWguajcL0divjOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um5X2afmEyQDFUaEx5m7AvNaDjM9Rjlzh8sM7etlEMs=;
 b=mGRL2dqkPCZH0WSBGFhNugUWY6+37IAwSL4TrLkUBw/CN1thq0RBXFsuYg5ybAcS7ZQ+hNq0akw4H6bPwFFgXdZWnI4Lc9eedkQ+YjGAnSSI3yLD5NwFWHX0dFm48NQtnxez61tyCyod0EcwdRg7FzF1QgI931+n6Ct592JQnKZ61wuwy1RRxW1Z4iUuVVZuYFAvZXwwZSzsAPTz/5WWEqSJd583L8J5lHRA1E5fttWKAqPmkoJ6Pf/7zZZpjiYP3POIh2/IF7kY/u5rtdt1CPt2n670uD4TQMFFU/YouHsmdKQ5xvPktUhVa/etUahaHYEDGhmK5pwo6vh/IkCXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um5X2afmEyQDFUaEx5m7AvNaDjM9Rjlzh8sM7etlEMs=;
 b=dtixyGcnsVPk5DAp0Gzjmmv93XwodNYw7+ANCK9QOfFhj8NvJRy+6mt7vKr4ne58uRRt6+ZO72tWWVlLpnB+yhyC18t4MPwrjZam/PVNy3AJjsNfSkEcpnGLhkiiWCQ2O22GLdLBrMmKvO3c5DlVuFblRzuO9xhjNwHYHTMU2gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM6PR02MB5269.eurprd02.prod.outlook.com (2603:10a6:20b:88::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 15:43:36 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 15:43:36 +0000
Message-ID: <b0035c61-7327-adfc-6ff7-60f0f275b1f4@axentia.se>
Date:   Wed, 11 May 2022 17:43:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Content-Language: sv
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
 <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
 <CO1PR11MB4865915CFCBA2AA765B932A292C99@CO1PR11MB4865.namprd11.prod.outlook.com>
 <59288dbf-bea2-a12e-93d2-c7c95f5568f6@axentia.se>
 <CO1PR11MB486567066BE4499BA5D31DB892C89@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <CO1PR11MB486567066BE4499BA5D31DB892C89@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0006.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::6)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aefc3bb-6a20-4c70-e320-08da336502e8
X-MS-TrafficTypeDiagnostic: AM6PR02MB5269:EE_
X-Microsoft-Antispam-PRVS: <AM6PR02MB526911341DA535BB604A0CF4BCC89@AM6PR02MB5269.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvatCFFM4IzQz3m/OcvC6yhO2hD2oM9GSxwR2ZvksaC4lpTPA09easPKwp6wkk6dYspR0YCDjfjy+Zz1LDnUvd9pBL+bIvbiN5IOJEjd3kOVmrkSyzb0pBHbEI/f1pedkkRChPB5/3piQhaalHxKQ4TPqzmf/EgKtW1OZrrq9oFajcLco8vLr0MP4tObx9hzy1CYcIiMeut55Q2LoYrareDleLtbBcBsik2vK5nCi8JSStOEi5+3Dh0xC3U/A/bN0hxnLrGlF75fUGgO4Hhrdk/Owrl5nIHPYfUyS/Ra4CIwNHVl4h/F2ZG2mxMbZc8yvt0nwhttVF4Ecs6cSQKGlcPFlvFQq5BIWC5nAnxZAQ4+6iqYqCjXn6zP8hLPHMJwJSjsjBpJOPspKpJRi2dpv0d9YFxRuzeMLDB6/s8LKRASDFTZwGJWoueoVpH33y8geao5CLFqeCyEgxBoFQz7dgcjTc7PUNYD7KiP71h7Y2gS8c+6qt52ytmvFYw6+sn4fnx4rk4KpN+qSrShcyKsTvd6W0tBXQMPiK8wTs14t5wiLKbJmgJANwecO4J+1ea+RX/BkuYnQz4gupROxyIEOjaBx1ONGCSNN8IJQBTXaTJgfMsIIZfvugh7VVE6GKYuAoxhloGgD4OTGFytct1a5XlJVzniBiAxRDdYDY9OZvoujE0Uas8BJZu6FLK+TcGlhCWcg8dtd07+m4QvtV0Aqt3xJUi9fNc2/UdH9OsHDTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(376002)(39830400003)(366004)(396003)(6486002)(186003)(2616005)(36756003)(6506007)(66946007)(66556008)(8676002)(66476007)(4326008)(508600001)(31686004)(83380400001)(26005)(31696002)(86362001)(6512007)(7416002)(8936002)(6916009)(38100700002)(5660300002)(30864003)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdlU1NlSGZXbEU1b1hXWHB1Vkc1ZWxKQ3dPc1pvejE4YnA0UnpPNEhFTXF6?=
 =?utf-8?B?NTNjTGl6T0NYRVBXbS9waitaVEJPcWZHTlg2Q3FpUzlhNlFYczJzWXA3YWJQ?=
 =?utf-8?B?cWR2QmtTRy9QV05jYm9iS2h0eTljVlpLQkdxS05LRndETVozeU5kYXFWWWZW?=
 =?utf-8?B?YWlkUVV4M21CdXN5SUZyVlpMUC91UDRjckhneEk0WFB1eFAvL042akpJeTVz?=
 =?utf-8?B?cmZ0ekdqZEdDWCtFcE5maFFZWmEwOU01QkUzdm83Y0QrSHRDYmdNOUlkcnJL?=
 =?utf-8?B?NnkrZzVnT3NDaXQ4THpINGUxekVQY0dKNDBXOE9pNWJOSGRJMmcyUmVjcE93?=
 =?utf-8?B?VDBTQ1pSQXBleFkxeEwwTzRLT3NIaUVLKytiWnNtNHJEU0xja3crK1Buc01H?=
 =?utf-8?B?bkN5Qkp5RjFzS0Z1OTJhc3lIWEd1NmZjUzRDZmpGQWt1ekl5OUpnNzdHMUUw?=
 =?utf-8?B?MFFNL2dXRnd1YWRlMWFwTWJGSE1kbjhPWUJiRDNHMzE1QjFLU2x1NDcrVHFh?=
 =?utf-8?B?QXpnam5oTUlJelYxd3RpekgrU3BmNlhHczB1dVpVR1lsem1uWURHU0J3M2lU?=
 =?utf-8?B?dkJDTkZPVlJWaTRTM0hweS9IWDUyb2FDYjU1ekZDdS8wc3lZaEsyNUF3TjZX?=
 =?utf-8?B?TUFUM0wvRm85OS9vMVJsUlFUS2JWdjhBWS9tT2didEYvRkt5dFdKVzh2ajdX?=
 =?utf-8?B?RmZyamo4YTVZcnF3aTNXeE0zaGJWMUx3UVY0c1lpeDZ0NVQyQzBLN25kMU13?=
 =?utf-8?B?cGxzNXJOMHpzTEJ5S21td1RDMjhYM1dWQ3psR09WbkgwUnhLbndTUW9nb21S?=
 =?utf-8?B?VngzQWZpSmh3OE00dnhyNlVHcUR3OGs4ak9lcnlKd3lOamJ6SmVxRTNEOVNt?=
 =?utf-8?B?RldUNjlIZCtYLzRZSXFqWG8vT3ZlcUFiYzdrc3ExRnRzNnc1NHI3M0NTN01I?=
 =?utf-8?B?cFNTc2pxbXpTelJ3UGQwTXVOU2Z4cGpwb2dSMDJTZ0hVN3B1dmVYUVNvU2xL?=
 =?utf-8?B?eG1VcllvR1dWWG96bENFeVBnNFB2dll4bTdiUmVQamtVL1dMRXRTSmNxeUcr?=
 =?utf-8?B?UFllbGNra0N1Qk9EbTRlcVZ5ZXZDTWdpRmVkTFo0dndoaE54cDFTYnEwMTVI?=
 =?utf-8?B?a2FFV09XVWJKdUlXdDVHOVFFRGc4YzBJbnZhVEtJWXo4czlVY1NiL09WcTVT?=
 =?utf-8?B?K3dOZTR5blpwSFhBcm5UU0RrUU1mN0lGSm9TcFFnT3lSQVBuamx3azZaTE82?=
 =?utf-8?B?TGFrbm43WVdaakVXRDVpclZzSFdvQlVJRVk4dGMraW1QV1dxbTVVUlF2R3FQ?=
 =?utf-8?B?dFA3cmZIYmtVaEJRUC91TjQwM0FVVmxzUGlOdG56THhvN3p5bURaMUZsaHJz?=
 =?utf-8?B?NUlsb1R4Z1JnWWYwdExORW8zZE0rTEx0ZW4zdzRBR1hteGVwYmJFZFRyRkZZ?=
 =?utf-8?B?WHl0eE5MRjZoNGNCRUFrU1dINm1NY0VneGc5Z0RmZGZhYmtkbUhCWFk2Zkcx?=
 =?utf-8?B?U2ltOUtMNW8xaDcvZEpGNjcxZnN5UlZwYlh4Rkh6c2thdk0wNWtOZXJGbHB0?=
 =?utf-8?B?UUNqS3JOWjJEallKR3cyakFUVythTnIzWkkySzgzaW8yWW9yNDZSUVpKTktC?=
 =?utf-8?B?VFhyTGtiN1B1NC9JbWlMNjltbFZDanlDeTI3TUlXaDduSEl6SnVZcTErc2o3?=
 =?utf-8?B?eTEvb3FDTFRDbzUrb0JPTnNFZTVFY0J0eUV3OHBYNEV5bFg1RzR6VUtkd0k1?=
 =?utf-8?B?cHEzK1M5b051ZXhsWnBFMDV1OXJmWUxsTDQvaEYwcW1RQWlaL3dhNDdLc3Z6?=
 =?utf-8?B?OHcwNFU3RURvMkx5S2lMK2hMSnVTUzJCTjRMWU5vaFJQb1dQTWlWSm1FVUZ1?=
 =?utf-8?B?NlVYVjR6T1I4WE9LWVlhZGJEeDFlc1JhazlIWVREdGw4M2l3V2htL0h4QzRx?=
 =?utf-8?B?aHBjbE1TQy9lMGJPWGFrWmxKUnBEc2FmZzI1TGJlS2NrUFdyUklSbkFyOWcw?=
 =?utf-8?B?eFJ5Rjk5UkFnTjErQUxYcHJra0JEU3gxN1crZ01MeG1tR09jTjVnOWxNeGYv?=
 =?utf-8?B?WkJVTElpWlVJUmZkWjlvNFFHWVpycUpsQjFZekZHTm5vNnRQT1U1Mm1iQmZN?=
 =?utf-8?B?cnBCbk13SzEybUtNdXpXWHFkdHp1dHdjZXg0SjNoQUdWbHFOOVJoYjB4SUlC?=
 =?utf-8?B?OGhkVitFTzVpRXBPZkgra3IrQWsyREJlRWdkTy9Mbzh5S2phR3hKVFlUSE0r?=
 =?utf-8?B?eE02bm9ZK2FwSGFaVklpcWpDVlRJRThkNkxYanlxdGVKeHFIeUdJbGFBTDRF?=
 =?utf-8?B?UDlmalpXMWYvS2FZSzZueXpwbkllMFp3cU9vRTdOeDBlUFBFRTlJQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aefc3bb-6a20-4c70-e320-08da336502e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 15:43:36.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnKvd0yr343za4hDYIk22KoiM73UuzAmUEB15/Z8I4Q25roQ2Q1SlAjz9GVswqqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5269
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-05-11 at 16:28, Kavyasree.Kotagiri@microchip.com wrote:
>> 2022-05-10 at 16:59, Kavyasree.Kotagiri@microchip.com wrote:
>>>>> LAN966 SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
>>>>> For each chip select of each flexcom there is a configuration
>>>>> register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
>>>>> configuration register is 21 because there are 21 shared pins
>>>>> on each of which the chip select can be mapped. Each bit of the
>>>>> register represents a different FLEXCOM_SHARED pin.
>>>>>
>>>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>>>> ---
>>>>>  arch/arm/mach-at91/Kconfig  |   2 +
>>>>>  drivers/mfd/atmel-flexcom.c |  55 +++++++++++++++-
>>>>>  drivers/mux/Kconfig         |  12 ++++
>>>>>  drivers/mux/Makefile        |   2 +
>>>>>  drivers/mux/lan966-flx.c    | 121
>>>> ++++++++++++++++++++++++++++++++++++
>>>>>  5 files changed, 191 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 drivers/mux/lan966-flx.c
>>>>>
>>>>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
>>>>> index 279810381256..26fb0f4e1b79 100644
>>>>> --- a/arch/arm/mach-at91/Kconfig
>>>>> +++ b/arch/arm/mach-at91/Kconfig
>>>>> @@ -74,6 +74,8 @@ config SOC_LAN966
>>>>>       select DW_APB_TIMER_OF
>>>>>       select ARM_GIC
>>>>>       select MEMORY
>>>>> +     select MULTIPLEXER
>>>>> +     select MUX_LAN966
>>>>>       help
>>>>>         This enables support for ARMv7 based Microchip LAN966 SoC
>> family.
>>>>>
>>>>> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
>>>>> index 559eb4d352b6..7cfd0fc3f4f0 100644
>>>>> --- a/drivers/mfd/atmel-flexcom.c
>>>>> +++ b/drivers/mfd/atmel-flexcom.c
>>>>> @@ -17,6 +17,7 @@
>>>>>  #include <linux/io.h>
>>>>>  #include <linux/clk.h>
>>>>>  #include <dt-bindings/mfd/atmel-flexcom.h>
>>>>> +#include <linux/mux/consumer.h>
>>>>>
>>>>>  /* I/O register offsets */
>>>>>  #define FLEX_MR              0x0     /* Mode Register */
>>>>> @@ -28,6 +29,10 @@
>>>>>  #define FLEX_MR_OPMODE(opmode)       (((opmode) <<
>>>> FLEX_MR_OPMODE_OFFSET) &  \
>>>>>                                FLEX_MR_OPMODE_MASK)
>>>>>
>>>>> +struct atmel_flex_caps {
>>>>> +     bool has_flx_mux;
>>>>> +};
>>>>> +
>>>>>  struct atmel_flexcom {
>>>>>       void __iomem *base;
>>>>>       u32 opmode;
>>>>> @@ -37,6 +42,7 @@ struct atmel_flexcom {
>>>>>  static int atmel_flexcom_probe(struct platform_device *pdev)
>>>>>  {
>>>>>       struct device_node *np = pdev->dev.of_node;
>>>>> +     const struct atmel_flex_caps *caps;
>>>>>       struct resource *res;
>>>>>       struct atmel_flexcom *ddata;
>>>>>       int err;
>>>>> @@ -76,13 +82,60 @@ static int atmel_flexcom_probe(struct
>>>> platform_device *pdev)
>>>>>        */
>>>>>       writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base +
>> FLEX_MR);
>>>>>
>>>>> +     caps = of_device_get_match_data(&pdev->dev);
>>>>> +     if (!caps) {
>>>>> +             dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     /* Flexcom Mux */
>>>>> +     if (caps->has_flx_mux && of_property_read_bool(np, "mux-
>> controls"))
>>>> {
>>>>> +             struct mux_control *flx_mux;
>>>>> +             struct of_phandle_args args;
>>>>> +             int i, count;
>>>>> +
>>>>> +             flx_mux = devm_mux_control_get(&pdev->dev, NULL);
>>>>> +             if (IS_ERR(flx_mux))
>>>>> +                     return PTR_ERR(flx_mux);
>>>>> +
>>>>> +             count = of_property_count_strings(np, "mux-control-names");
>>>>> +             for (i = 0; i < count; i++) {
>>>>> +                     err = of_parse_phandle_with_fixed_args(np, "mux-
>> controls",
>>>> 1, i, &args);
>>>>> +                     if (err)
>>>>> +                             break;
>>>>> +
>>>>> +                     err = mux_control_select(flx_mux, args.args[0]);
>>>>> +                     if (!err) {
>>>>> +                             mux_control_deselect(flx_mux);
>>>>
>>>> This is suspect. When you deselect the mux you rely on the mux to be
>>>> configured with "as-is" as the idle state. But you do not document that.
>>>> This is also fragile in that you silently rely on noone else selecting
>>>> the mux to some unwanted state behind your back (mux controls are not
>>>> exclusive the way e.g. gpio pins or pwms are). The protocol is that
>>>> others may get a ref to the mux control and select it as long as noone
>>>> else has selected it.
>>>>
>>>> The only sane thing to do is to keep the mux selected for the whole
>>>> duration when you rely on it to be in your desired state.
>>>>
>>>
>>> Yes, mux is kept selected until configuring register is done. Please see
>> below log where
>>> I added debug prints just for understanding:
>>> # dmesg | grep KK
>>>  [    0.779827] KK: Func: atmel_flexcom_probe ***** [START flx muxing]
>> ********
>>> [    0.779875] KK: Func: atmel_flexcom_probe i = 0 args[0] = 0
>>> [    0.779890] KK: Func: mux_control_select [Entered]
>>> [    0.779902] KK: Func: mux_lan966x_set [Entered] state = 0
>>> [    0.779977] KK: Func: mux_lan966x_set [Read] = 0x1fffef   <<<----- setting
>> mux_lan966x[state].ss_pin "4" which is passed from dts
>>> [    0.779992] KK: Func: mux_lan966x_set [Exit]
>>> [    0.780002] KK: Func: mux_control_select [Exit]
>>> [    0.780011] KK: Func: mux_control_deselect [Entered]
>>> [    0.780021] KK: Func: mux_control_deselect [Exit]
>>
>> You misunderstand. The mux control is only "selected" between the call
>> to mux_control_select() and the following call to
>> mux_control_deselect().
>>
>> After that, the mux control is "idle". However, in your case the
>> "idle-state" is configured to "as-is" (which is the default), so the
>> mux control (naturally) remains in the previously selected state while
>> idle. But you are not documenting that limitation, and with this
>> implementation you *must* have a mux control that uses "as-is" as its
>> idle state. But that is an unexpected and broken limitation, and a
>> much better solution is to simply keep the mux control "selected" for
>> the complete duration when you rely on it to be in whatever state you
>> need it to be in.
>>
> I am new to mux drivers.
> Let me try to explain why I have mux_control_deselect if there is no err from mux_control_select()
> For example, 
> 1. When I have one only chip-select CS0 for flexcom3 to be mapped to flexcom shared pin 9:
> As per previously shared log, FLEXCOM_SHARED[3]:SS_MASK[0] is being configured to expected value 
> even before mux_control_deseletc().
> 2. When I have to map two chip-selects of flx3 - CS0 to flexcom shared 9
> 						CS1 to flexcom shared pin 7
> FLEXCOM_SHARED[3]:SS_MASK[0] is set to expected value 0x1fffef
> I see console hangs at mux_control_select() if I don’t call mux_control_deselect 
> while mapping second chip-select FLEXCOM_SHARED[3]:SS_MASK[1].
> After reading below description from mux_control_select() :
> " * On successfully selecting the mux-control state, it will be locked until
>  * there is a call to mux_control_deselect()."
> Following this help text, I called mux_control_deselect() if there is no error from mux_control_select() 
> and then it worked. FLEXCOM_SHARED[3]:SS_MASK[1] is now set to expected value 0x1fffbf.
> 
> Please explain me if I am missing something.

You should wait with the deselect until you need to change the state
of the mux. I.e., on init/probe you set some variable to -1, like so:

	priv->mux_error = -1;

and when you later need to set/change the state of the mux, you do:

	if (!priv->mux_error)
		mux_control_deselect(...);
	priv->mux_error = mux_control_select(...);

and then you cleanup at the end of life:

	if (!priv->mux_error)
		mux_control_deselect(...);

Or something like that.

The mux api is obviously not a good fit for the use case of long
lived selects like you appear to have here. The api was designed
for short lived selects, along the lines of:

int
so_something(...)
{
	int err;

	err = mux_control_select(...);
	if (err)
		return err;

	do_it(...);

	mux_control_deselect(...);
}


> 
>>>>> +                     } else {
>>>>> +                             dev_err(&pdev->dev, "Failed to select FLEXCOM
>> mux\n");
>>>>> +                             return err;
>>>>> +                     }
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>>       clk_disable_unprepare(ddata->clk);
>>>>>
>>>>>       return devm_of_platform_populate(&pdev->dev);
>>>>>  }
>>>>>
>>>>> +static const struct atmel_flex_caps atmel_flexcom_caps = {};
>>>>> +
>>>>> +static const struct atmel_flex_caps lan966x_flexcom_caps = {
>>>>> +     .has_flx_mux = true,
>>>>> +};
>>>>> +
>>>>>  static const struct of_device_id atmel_flexcom_of_match[] = {
>>>>> -     { .compatible = "atmel,sama5d2-flexcom" },
>>>>> +     {
>>>>> +             .compatible = "atmel,sama5d2-flexcom",
>>>>> +             .data = &atmel_flexcom_caps,
>>>>> +     },
>>>>> +
>>>>> +     {
>>>>> +             .compatible = "microchip,lan966-flexcom",
>>>>> +             .data = &lan966x_flexcom_caps,
>>>>> +     },
>>>>> +
>>>>>       { /* sentinel */ }
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>>>>> index e5c571fd232c..ea09f474bc2f 100644
>>>>> --- a/drivers/mux/Kconfig
>>>>> +++ b/drivers/mux/Kconfig
>>>>> @@ -45,6 +45,18 @@ config MUX_GPIO
>>>>>         To compile the driver as a module, choose M here: the module will
>>>>>         be called mux-gpio.
>>>>>
>>>>> +config MUX_LAN966
>>>>> +     tristate "LAN966 Flexcom multiplexer"
>>>>> +     depends on OF || COMPILE_TEST
>>>>> +     help
>>>>> +     Lan966 Flexcom Multiplexer controller.
>>>>> +
>>>>> +     The driver supports mapping 2 chip-selects of each of the lan966
>>>>> +     flexcoms to 21 flexcom shared pins.
>>>>> +
>>>>> +     To compile the driver as a module, choose M here: the module will
>>>>> +     be called mux-lan966.
>>>>> +
>>>>>  config MUX_MMIO
>>>>>       tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>>>>       depends on OF || COMPILE_TEST
>>>>> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
>>>>> index 6e9fa47daf56..53a9840d96fa 100644
>>>>> --- a/drivers/mux/Makefile
>>>>> +++ b/drivers/mux/Makefile
>>>>> @@ -7,10 +7,12 @@ mux-core-objs                       := core.o
>>>>>  mux-adg792a-objs             := adg792a.o
>>>>>  mux-adgs1408-objs            := adgs1408.o
>>>>>  mux-gpio-objs                        := gpio.o
>>>>> +mux-lan966-objs                      := lan966-flx.o
>>>>>  mux-mmio-objs                        := mmio.o
>>>>>
>>>>>  obj-$(CONFIG_MULTIPLEXER)    += mux-core.o
>>>>>  obj-$(CONFIG_MUX_ADG792A)    += mux-adg792a.o
>>>>>  obj-$(CONFIG_MUX_ADGS1408)   += mux-adgs1408.o
>>>>>  obj-$(CONFIG_MUX_GPIO)               += mux-gpio.o
>>>>> +obj-$(CONFIG_MUX_LAN966)     += mux-lan966.o
>>>>>  obj-$(CONFIG_MUX_MMIO)               += mux-mmio.o
>>>>> diff --git a/drivers/mux/lan966-flx.c b/drivers/mux/lan966-flx.c
>>>>> new file mode 100644
>>>>> index 000000000000..2c7dab616a6a
>>>>> --- /dev/null
>>>>> +++ b/drivers/mux/lan966-flx.c
>>>>> @@ -0,0 +1,121 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * LAN966 Flexcom MUX driver
>>>>> + *
>>>>> + * Copyright (c) 2022 Microchip Inc.
>>>>> + *
>>>>> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>>>
>>>> Looks like it is based on mmio.c?
>>>>
>>> Yes, I took mmio.c  driver as reference.
>>>
>>
>> So, then the above copyright and authorship info is not complete.
>>
>>>>> + */
>>>>> +
>>>>> +#include <linux/err.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_platform.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/property.h>
>>>>> +#include <linux/mux/driver.h>
>>>>> +#include <linux/io.h>
>>>>> +
>>>>> +#define FLEX_SHRD_MASK               0x1FFFFF
>>>>> +#define LAN966_MAX_CS                21
>>>>> +
>>>>> +static void __iomem *flx_shared_base;
>>>>
>>>> I would much prefer to store the combined address (base+offset)
>>>> in the mux private data instead of only storing the offset and
>>>> then unnecessarily rely on some piece of global state (that
>>>> will be clobbered by other instances).
>>>>
>>> Ok. I will try to see if this is relevant and change accordingly.
>>>
>>>>> +struct mux_lan966x {
>>>>
>>>> Why is the file named lan966, but then everything inside lan966x?
>>>>
>>>>> +     u32 offset;
>>>>> +     u32 ss_pin;
>>>>> +};
>>>>> +
>>>>> +static int mux_lan966x_set(struct mux_control *mux, int state)
>>>>> +{
>>>>> +     struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
>>>>> +     u32 val;
>>>>> +
>>>>> +     val = ~(1 << mux_lan966x[state].ss_pin) & FLEX_SHRD_MASK;
>>>>> +     writel(val, flx_shared_base + mux_lan966x[state].offset);
>>>>
>>>> This reads memory you have not allocated, if you select a state
>>>> other than zero.
>>>>
>>> Ok. I will return error condition in case of trying to access none existing
>> entry.
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct mux_control_ops mux_lan966x_ops = {
>>>>> +     .set = mux_lan966x_set,
>>>>> +};
>>>>> +
>>>>> +static const struct of_device_id mux_lan966x_dt_ids[] = {
>>>>> +     { .compatible = "microchip,lan966-flx-mux", },
>>>>> +     { /* sentinel */ }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, mux_lan966x_dt_ids);
>>>>> +
>>>>> +static int mux_lan966x_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct device_node *np = pdev->dev.of_node;
>>>>> +     struct device *dev = &pdev->dev;
>>>>> +     struct mux_lan966x *mux_lan966x;
>>>>> +     struct mux_chip *mux_chip;
>>>>> +     int ret, num_fields, i;
>>>>> +
>>>>> +     ret = of_property_count_u32_elems(np, "mux-offset-pin");
>>>>> +     if (ret == 0 || ret % 2)
>>>>> +             ret = -EINVAL;
>>>>> +     if (ret < 0)
>>>>> +             return dev_err_probe(dev, ret,
>>>>> +                                  "mux-offset-pin property missing or invalid");
>>>>> +     num_fields = ret / 2;
>>>>> +
>>>>> +     mux_chip = devm_mux_chip_alloc(dev, num_fields,
>>>> sizeof(*mux_lan966x));
>>>>
>>>> I might be thoroughly mistaken and confused by the code, but it seems
>>>> very strange that a subsequenct select is not undoing what a previous
>>>> select once did. Each state seems to write to its own register offset,
>>>> and there is nothing that restores the first register offset with you
>>>> switch states.
>>>>
>>>> Care to explain how muxing works and what you are expected to do to
>>>> manipulate the mux? Is there some link to public documentation? I did
>>>> a quick search for lan966 but came up with nothing relevant.
>>>>
>>> LAN966 has 5 flexcoms(which can be used as USART/SPI/I2C interface).
>>> FLEXCOM has two chip-select I/O lines namely CS0 and CS1
>>> in SPI mode, CTS and RTS in USART mode. These FLEXCOM pins are
>> optional.
>>> These chip-selects can be mapped to flexcom shared pin [0-21] which can
>> be
>>> done by configuring flexcom multiplexer register(FLEXCOM_SHARED[0-
>> 4]:SS_MASK[0-1])
>>> Driver explanation:
>>> "flx_shared_base" is used to get base address of Flexcom shared
>> multiplexer
>>> "mux-offset-pin" property is used to get cs0/cs1 offset and flexcom shared
>> pin[0-21] of a flexcom.
>>> state value passed from atmel-flexcom is used to configure respective
>>> FLEXCOM_SHARED[0-4]:SS_MASK[0-1] register with offset and flexcom
>> shared pin.
>>
>> Ok, let me try to interpret that. You wish enable a "fan out" of these
>> two chip-selects for any of the 5 flexcoms (in SPI mode?) such that
>> these 10 internal chip-selects can be connected to any of 21 external
>> pins?
>>
>> If that's correct and if you wish to interface with e.g. 20 chips,
>> then it would be possible to have 20 states for one mux control and
>> then reach the 20 chips using only CS0 from FLEXCOM0, or it would be
>> possible to have 2 states for 10 mux controls, one each for CS0/CS1 of
>> all five flexcoms and also reach 20 chips. Or any wild combo you
>> imagine is useful.
>>
>> Is that correctly understood?
>>
>> Assuming so, then you can have a maximum of 10 mux controls, and for
>> each mux control you need a variable number of legitimate states. Each
>> mux control would also need to know at what address/offset its SS_MASK
>> register is at and what pins/states are valid.
>>
>> But your code does not implemnent the above. You allocate num_fields
>> mux controls, which is what confuses the hell out of me. num_fields is
>> the number of states, not the number of mux controls! And you also
>> need to specify an individual offset for each state, and that makes no
>> sense at all, at least not to me.
>>
>> So, instead, I think you want to have:
>>
>> struct mux_lan966x {
>>         u32 ss_mask;
>>         int num_pins;
>>         u32 ss_pin[];
>> };
>>
>> And then do:
>>
>>         mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_lan966x) +
>> num_pins * sizeof(u32));
>>
>> (or however that size is best spelled, I haven't kept up)
>>
>> The set operation would be along the lines of:
>>
>> static int mux_lan966x_set(struct mux_control *mux, int state)
>> {
>>         struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
>>         u32 val;
>>
>>         if (state < 0 || state >= mux_lan966x->num_pins)
>>                 return -1;
>>
>>         val = ~(1 << mux_lan966x->ss_pin[state]) & FLEX_SHRD_MASK;
>>         writel(val, flx_shared_base + mux_lan966x->ss_mask);
>>
>>         return 0;
>> }
>>
>> Because, one mux control should only ever need to know about one offset,
>> as it should only ever write to its own SS_MASK register. And you will
>> need some private space such that you can keep track of which states
>> are legit.
>>
>> I would also separate out the SS_MASK offset from the mux-offset-pin
>> property and have one property for that value and then a straight
>> array for the valid pin numbers in another property (no longer named
>> mux-offset-pin of course).
>>
>> Or something like that and assuming I understand how the FLEXCOMs work
>> and what you want to do etc.
>>
> 
> Thank you for your comments
> I agree, I will change number of mux controls to 1 in devm_mux_chip_alloc()
> I would like to use mux-offset-pin property because 
> each chip-select must be mapped to a unique flexcom shared pin.
> For example, 
> mux-offset-pin = <0x18 9>, /* 0: flexcom3 CS0 mapped to pin-9 */
>                                <0x1c 7>, /* 1: flexcom3 CS1 mapped to pin-7 */
>                                <0x20 4>; /* 2: flexcom4 CS0 mapped to pin-4 */};
> I want to use mux-offset-pin property to be clear about which offset is mapped to which
> flexcom shared pin. Here, 0, 1, 2.. entries represents state passed from mux_control_select(mux, state).
> 
> Please provide your comments.

It seems you want to just use the static info from the devicetree
to program your registers once and for all? That's not a problem
that a mux driver is aming at solving. My thought was that if you
have one SPI device with chip select on pin-7, another with chip-
select on pin-9 and a third on pin-4, then you /could/ use them all
from e.g. flexcom3/CS0 by reprogramming that SS_MASK register
at the time you want to access one of the three chips. You could
then of course not access the three chips in parallel, but the
muxing of the accesses to three chips like that is the problem
that the mux subsystem helps with.

I.e. pretty much exactly as is described in

	Documentation/devicetree/bindings/spi/spi-mux.yaml

but with a mux node bringing your new driver into the picture
instead of the "gpio-mux" in that example (and the "CS-X" signal
and the "Mux" block in that picture would be internal to the SoC).

If you are content with just programming a fixed set of values to
a couple of registers depending on how the board is wired, some
extra DT property on some node related to the flexcom seems like
a better fit than a mux driver.

Having said that, the mux solution above would solve this static
case too. You would just need to configure a mux with one state.
It would be a couple of extra nodes in the device tree, but it
would certainly work (and also cover the more complex case when
someone pops up and needs that).

Cheers,
Peter

>> Cheers,
>> Peter
>>
>>
>>>>> +     if (IS_ERR(mux_chip))
>>>>> +             return dev_err_probe(dev, PTR_ERR(mux_chip),
>>>>> +                                  "failed to allocate mux_chips\n");
>>>>> +
>>>>> +     mux_lan966x = mux_chip_priv(mux_chip);
>>>>> +
>>>>> +     flx_shared_base =
>> devm_platform_get_and_ioremap_resource(pdev,
>>>> 0, NULL);
>>>>> +     if (IS_ERR(flx_shared_base))
>>>>> +             return dev_err_probe(dev, PTR_ERR(flx_shared_base),
>>>>> +                                  "failed to get flexcom shared base address\n");
>>>>> +
>>>>> +     for (i = 0; i < num_fields; i++) {
>>>>> +             struct mux_control *mux = &mux_chip->mux[i];
>>>>> +             u32 offset, shared_pin;
>>>>> +
>>>>> +             ret = of_property_read_u32_index(np, "mux-offset-pin",
>>>>> +                                              2 * i, &offset);
>>>>> +             if (ret == 0)
>>>>> +                     ret = of_property_read_u32_index(np, "mux-offset-pin",
>>>>> +                                                      2 * i + 1,
>>>>> +                                                      &shared_pin);
>>>>> +             if (ret < 0)
>>>>> +                     return dev_err_probe(dev, ret,
>>>>> +                                          "failed to read mux-offset-pin property: %d", i);
>>>>> +
>>>>> +             if (shared_pin >= LAN966_MAX_CS)
>>>>> +                     return -EINVAL;
>>>>> +
>>>>> +             mux_lan966x[i].offset = offset;
>>>>> +             mux_lan966x[i].ss_pin = shared_pin;
>>>>
>>>> This clobbers memory you have not allocated, if num_fields >= 1.
>>>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>> +
>>>>> +             mux->states = LAN966_MAX_CS;
>>>>> +     }
>>>>> +
>>>>> +     mux_chip->ops = &mux_lan966x_ops;
>>>>> +
>>>>> +     ret = devm_mux_chip_register(dev, mux_chip);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static struct platform_driver mux_lan966x_driver = {
>>>>> +     .driver = {
>>>>> +             .name = "lan966-mux",
>>>>> +             .of_match_table = of_match_ptr(mux_lan966x_dt_ids),
>>>>> +     },
>>>>> +     .probe = mux_lan966x_probe,
>>>>> +};
>>>>> +
>>>>> +module_platform_driver(mux_lan966x_driver);
>>>>> +
>>>>> +MODULE_DESCRIPTION("LAN966 Flexcom multiplexer driver");
>>>>> +MODULE_AUTHOR("Kavyasree Kotagiri
>>>> <kavyasree.kotagiri@microchip.com>");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>> +
