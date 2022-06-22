Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4D554317
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbiFVGcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiFVGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:31:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC32F64A;
        Tue, 21 Jun 2022 23:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doSmGPgjessqF4tohhW8cXZ60XW/49AEq5HmrInSoiI8KGOBAidFgm/LMnFe2R0me5jDdKrMvJn0kKaMtOe2OoD5E5ZaJZhDeY+sfpqYQAPFi+uyxtVQ7r86j8aHVboi/yc4bRQCQjosyQkaSg+VAfJ0csRDaD183unjZPYD327KyK+PTCQhtv2m0jiBfxkAaCRxp8USN/dgyP5+xTjZhdVceB8p52mlVXpr8RGA1JqdMtWlAIy+a0odCIl/GknYtR8iY7VkjelSLwSS2ru6Cxe6CRRXzWQwzJn5B7p01HpB4VVSDMZP2MXgIqxLvry4ID6MjwTicxGnp/mC61FD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDpxvBujlGue2HJkcCjljzExp3jR5I81CiprRb7cV5Q=;
 b=V33j1fElJibRvor4RQCssOCb/uLbfsru+Zb8YODxjmng/J633KjiuTFtXHx3KvfoBsRmzAT8pYbkEdfSTA6BscATWZXMV3vfNP6F+NJYTI1CKHlGR44D/OgjoMuDrivnUTSOdnpdV+kIkEgbANWgTnX1Oi42LNrPZWyFLu9EE4kxnBQu81guMBAb3Tbu1OBtNhW+lZwTgXBBJPYTmbJ3CMZFfNU4rClS1dqx0nGc/2MIFYOJN3hfOVcvxqy7s1YThb00wDZySQhGMb5KpFAJsh/QhYcgV7/8SJLUVCis5QKj+1ORaY/+C+IwOPWz0UFtzvYaNm3z9bmV8o4wyHCziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDpxvBujlGue2HJkcCjljzExp3jR5I81CiprRb7cV5Q=;
 b=dUTJn68iNMGMm16DgVCC0YpkQ1SKeQhkWLUbUxVdb5XMWS6UgQYYJpXm46+GdkDdKNM41ds0nxwVeyzl1vp8tlitRXF3+Vd4MnDfxuWtPTlCxYsqXyOuXlICS/V+bSt6rMv8wZGxBiphwZrR/th1P7Q6zbTp3vp/b+n05BXtn58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by HE1PR10MB1627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 06:31:51 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:31:51 +0000
Message-ID: <42f2ba58-acd9-a214-83f2-037f669d8d59@prevas.dk>
Date:   Wed, 22 Jun 2022 08:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::22) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71edf7a5-d22e-4381-6617-08da5418e44f
X-MS-TrafficTypeDiagnostic: HE1PR10MB1627:EE_
X-Microsoft-Antispam-PRVS: <HE1PR10MB16273E62D3E7168227BAA82B93B29@HE1PR10MB1627.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGLEqMfxEuTYF7BM9PxbRFPKB/RkasgZoKPV2PEoQCbj0av7CaRoUICw0AMtQ5eUwWceGFGATxbGzmRnzjOApZtgeS+OBx/+pFOaQHHbQ44IQEX2RJm+JPyMkK9mMWZJZ2nJcVQY9OjERpwr9JTU7Pt3phr0zu2R4yEPXGvIcwaiwmfErJYV5zkrwC8GRPdYSNujYtI6w5sZYOc0pLJGWYWHNb9aIJ+bstvK6rb44KI6vZuAaYDgwg2LTBhBo/i7D4yPkQVMIf4sw+sHmNBgxUv1ktJrzQ/zFoM+IytrG3D0fWBsS6+6yeypugcHGNcpiyH86YnvMGTG0qQkQDD4Ew4vJslRTdTfo90XTDNrzgoFJ5kdUkmGaJRlPyrz82TpmfQ6AmWABpXTs2klzwwWLwEASYQcfNgJYYPWBpcr1Zdk7hn9a5CRAd8fS1ymNfHGkjkpRb3UtIgYlfr9KHQoaxCx7485XlWEgJRSh1bU0A4h9x2lj/sysohAf08oj7neFekxzQN5mVTEge5LseKFNjA4VuOuoZbPqAypC/iwR4jjYXkwHAhwCYjys4Ix6vEflKmD3hg/s0ie+0B8Uagconqqw4M1AX0ZpVIspLHAZNFcwewwFUHlCwQ0Ybp1g3rP35Oj5ai/rOowO6JZVDnBkAHrsvlRDhSDJggKKaFF5kJbH5qY7r0YWSGNJQvockVMVV2Sm/9yUDzQ4Q6OMhmHluXB7jpT3o4VSPThAqXKkaPl/SIKvv05iXe/10OJHzyZT3J/Glqp7ayN4oe7WO6UYAUffEKnKESucZZMQv613vDXLMlvGBZFN7JpC8/03P7R0IIzMKFOCbGyOwFK/g/jHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(39850400004)(366004)(136003)(396003)(376002)(6506007)(4326008)(31686004)(8676002)(478600001)(41300700001)(6666004)(26005)(6486002)(38350700002)(66556008)(6512007)(66476007)(38100700002)(66946007)(5660300002)(2906002)(4744005)(44832011)(7416002)(36756003)(52116002)(186003)(86362001)(316002)(31696002)(2616005)(8936002)(8976002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtlZ1FuSHc4bG1sN1RGMzV6Z1Fmdmw4bnVhVmd5M1hwTDFsUEJ2SFlEWWoy?=
 =?utf-8?B?ZXZpY2loMUQybWFyWDNlVG9sdTJKZDltMW9pblZNR3pib1c3eUJFU2p2QjF6?=
 =?utf-8?B?c0Qvd3V3dDZJN2cvR3c5UTA1QzlnTnVrdWF0UjRLSGZacitRRldmenZaU3Bm?=
 =?utf-8?B?dDh5VFlLR0RNM2xrSGdwa2syUkxhU0F6WkZwYlNFcUZTV2hFQTEvYVEyZHZR?=
 =?utf-8?B?ZFBuVnREQStoWElTVXlSSytNNmRhM3F1eVJ0RzVDWmpUM0tzRndkTXhxQTJI?=
 =?utf-8?B?YjhYSDB0a2NVT0VMM3g5QURLRWo4b0ZpeWpWL0ZLK2d5ajZldTlSc3ZHblBL?=
 =?utf-8?B?eDZvNjRTUU5ucENkNWdkelQ2NXV0SGo0ajlzOENuNGxNM0dlNWF4OTlOMlI3?=
 =?utf-8?B?eThGcEpqdm9QdFVUS0pTZW1ocmdRQzFsd09mcE1iYmo0MitqRU5QSHp6bVpi?=
 =?utf-8?B?Q0F6SHpuK2taVlhFMjl0ZmNTcjVMdUhhR1ppWUZ2OXlSTTZrb3h3dStjc0hR?=
 =?utf-8?B?TDkzNW5EUmZCN01ibHZVR1hIcllCSy9VMzkxOGl5SEZuV2Y2V3BVdDZrcFRq?=
 =?utf-8?B?NWRKV205eGJGU3ltN2Yxc1dBZ3orUkd0N3FVTEFqT2VVRVV0TlExNUdkakl5?=
 =?utf-8?B?KzVPYkc3NGprSEpvOXNDckZlWEp1eG02NkZhVjdmc0pRUElSUFhHbk9Pekc0?=
 =?utf-8?B?SDNZeDc0TFdRbk5haFpicHFSNEg5SWV5cFQvdW9ySktNeVpmVVNIUXZRWmVv?=
 =?utf-8?B?V0swd1NxMlY5TUNVV1ZSaEJxYkh5cC9MWEg5SUlMN2Y0bEdLdlBuSkJiVFNp?=
 =?utf-8?B?cFd4WUZaZXlIcEM2S2JTNTNkbGprS0dhK3BKcG5XYUNnSk9EVy9vdFkxekJV?=
 =?utf-8?B?cVJBaHdxT0Fzb3hNc2h0cmZCUXV0d1d3MFBNV09mM1ZhdTEvZ1d1WVF0UG14?=
 =?utf-8?B?c0Y1T0plOWdBNDdhdzNWeisxcWQ0eGJhM1lPdzhYVTBsTGlDcUZsbmdlajB4?=
 =?utf-8?B?L3VZWEZDbjJmN20rQ21wcG9zT0xWeUduUGgrUnltM2JaeUhVQU5zeFZMWEow?=
 =?utf-8?B?bVZnN0NkN0hkREZGRUpKbGtPc0VmcXhOUGFUalNKaGZYMXkrcmtwNUNLdmUr?=
 =?utf-8?B?OFlXZTUvdWg2UjZXdkl0ZjN3QStpQ2JaS2I4bXNNRmhVc0lTOHBXR2Z1aEhT?=
 =?utf-8?B?US92S3E2YXd4Rmg5ekVSUnQ5RTVkdHpQb2FQdWV0T1FOazkxSnVXUTQvSnIy?=
 =?utf-8?B?eTNid1V2Wm5MeDNKNjlESUxOU3pIMFlVMU00YitWYzhpejlsN081YTdodWow?=
 =?utf-8?B?cWxtTXZBczBiVnBGdDdsNmhIanV6K1hzY2VsUFNlQTlaQWFlSHFPQUxvRVdv?=
 =?utf-8?B?WFl0eDc5WXQxOHVJN0dpbjgzODErMkpwM3pCeStoQWkwNW41d01KQlN6R2tX?=
 =?utf-8?B?SFhCTUJ6WCsxRldrRlZSQUs0aE5ZM1dIWUhNdHpiSmtTcHVGUk9aWEYrbERN?=
 =?utf-8?B?ZmRrcTlIWFhXWHhGbXE1cEtpSUwwNC9FMGR4eTdyYjQzdk1PN2JtYnVQWHY3?=
 =?utf-8?B?ZDkrRDZ2RmgvdW04VGQ5eDEzeE5uQllNTUswM1ZSNEZIaTdlVVMvdWViZ1lU?=
 =?utf-8?B?M0NhNHF4V2duNjF6Vkh2blJrR0c3VzhUNE1PVmNxd1g3S2JncDRoR0RyZTYz?=
 =?utf-8?B?QTVHTzd4NThLZ3BQZ3E5L0JENVhheW9acEhLRzBtYnNNRUN0M1hZWXBwVVFv?=
 =?utf-8?B?R0RhTytKMXNxODVnSTBSWlI4aTJpeVV4d1hsMHVZN29ibFpqY2poTVJiUm5S?=
 =?utf-8?B?SEtjUjNjUEpNWXo5Vi9Ub3V2YjAyelRPbm5DWUxpRW13c0ZEQ3dRUW9yaUIr?=
 =?utf-8?B?U2dhSEMyQ05YRzFZeDlHckdkTlFYRERZcHhCcHIzR1gySStPZmVxdnZnZ0I4?=
 =?utf-8?B?NFlibTU0S2JxdVMrNytLZ3d0clBBRjJVSjZ6M0ZqRWZmSmlsVDROZkhMZTdV?=
 =?utf-8?B?RXBPM3JwT2pSWWNjOEJ6b0Jnc0xlVlVOYWpKVkU4VWR1UHRDS25hRHRFWVBD?=
 =?utf-8?B?RlpiU2xXck1YRGo0RUwwMmtPbkp4NWhnV3NIM0ZJWkM1UVY2c3FNMDB3a1ZM?=
 =?utf-8?B?bTRkLzdrQ055dEE4cUxrbWZMbmZvT0lnUjh0U0dScVZRV1FMMXc2UktwRkp0?=
 =?utf-8?B?NkJlR1dSb3RpNVY0bTZyYWFoUGtxd3JzQnI5dDkyZ0grQVFXZHM0ZU0yN2Vs?=
 =?utf-8?B?QVZ5ekJxem8rdzZIWE8ydHFWZ2MwUENoa1FoamZaYVZkamt4djAxL2JsZmhi?=
 =?utf-8?B?aTVXVVEwQTNQQWdGZzRkQmZkMzM5d09saGpLZXM2Nlo4bzFwVjk2cDNQUnV5?=
 =?utf-8?Q?4ivTDXg8MKXMAeUU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 71edf7a5-d22e-4381-6617-08da5418e44f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:31:51.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj7z9vLgI6SsYh+sa+2lZTPKrJ8f2W3+d4GU/OD87PPFZDsHisqzNDPNIJYj1KsD224A/w2cGbx0UIEIeeYiJs1LPZrDDirTwvLh+HJqxQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 08.13, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
> reserved bit will be ignored and reading will still return 0. Although
> function not broken with reserved bits set, we should not set reserved
> bits.

Thank you, these have really been bugging my while trying to bring up an
imx8mp-based board and adding the right pinmux settings - not knowing
whether there was some undocumented effect from including one of those
bits has led me astray more than once.

One question: E.g. in patch 11, you change the setting from 0x49 to
0x40, which is of course exactly what the patch description says. But
when bit 8 (PE) is not set, is there any effect from either setting of
bit 6 (PUE)? Not that I suggest changing to 0x00, but I'm just curious.

For the series:

Reviewed-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
