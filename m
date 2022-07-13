Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14E573168
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiGMIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGMIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:44:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70097.outbound.protection.outlook.com [40.107.7.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4D804B2;
        Wed, 13 Jul 2022 01:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd7+KKlfPx6xI9lIAvN69HZHu050HT6avpQwB22YYGBdQ7X9Ot3u+Gy3tS5K4x/4prxLstRxeAx1kZ8n5qC0nd8kMvbfHamMKPbECY1c6HbQA3c23zd9urb2FY1AHojeeR9T26VLhUaDzqTRzMSkG+1LfZjVyvNV74FP/KX6JHDvNczmOQhN7NLZjkk1FfuSJ/vWxhaB4SFE5UvsTMWfyWUGLunbnDlqLQbuzdtVd0R3WuhsuPAv6r69CNmIfTYhIvPyWP9edA0fPrlTMHGpFAII1mUGzpVwuVMAsjghTVLNsRWwnIT66NSUz64Y3q632To0AXwm0ii/Eo+ILJGAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xJlFBmvFp85Cpm45df+lDUQCQGACGv5q0qnlYDwTug=;
 b=F9UbcGksiFWN1HqGrxmLKjnK/BBYDcEO5WGQp4ypN9aZNTa2Wux6zBcfMPgutELZJs/Ryh3DOrIV84QRgN7P1cchQnmJAYpH8oK0l0E7/oJxPRihj1gnVzYVCtlOCorKJVxutyMnb3iA57FBgEtSYEduPT8o629HRInFoLYqk49BMjEzLWwscRB7lSHOIPq/wEjAzwY94uplVZVCJ5xAAndw2ZiM8Eh7X9js2RBhf0hW1SDvTdc6MztTGhi+tRIXPAwbJ+B3SbSxTpItvPpxT2lAdP3tGZhw3xHVaDD4d2i70XBM/BVKgBgyrBEa26FPzJIszOGoLbxCQBfEa3t+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xJlFBmvFp85Cpm45df+lDUQCQGACGv5q0qnlYDwTug=;
 b=HCu2nGlDzXk+5g3y9anCaAx4BK3Yv8P2AKrtems/zS1TTyqCitXPnolxbRxOBJDc88X74z+9gWlht1EnEr3hSzuzvQTY3dhnwj7T/IGnX6CkFyOg3KGCrHy4xhLYxJ66a2LB/FC3mDFQnND5lUKggpxhE8Ux8iN8+WK6Ru+xvMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM5PR10MB1539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 08:44:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 08:44:37 +0000
Message-ID: <5cd2bd6b-30e9-582f-5e28-74b49429103c@kontron.de>
Date:   Wed, 13 Jul 2022 10:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/6] arm64: dts: Add support for Kontron SL/BL i.MX8MM
 OSM-S
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-6-frieder@fris.de>
 <20220713083603.wjb3znctugrerep5@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220713083603.wjb3znctugrerep5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a60d677c-45a7-490e-2a38-08da64abeb04
X-MS-TrafficTypeDiagnostic: AM5PR10MB1539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MX5modsuPqQjnpAKnlPgCpb7sx5QWsIsFr16HDe4E8MjO/D5DsyyuVLmJxNUuHkxp8WHk/ptLB+pQSgXTs4bwYSv+seyU36Yx4Lf1tnBnEtCHHSK0zk9WnQVZ7H4vei7A3mjZjV7gFaRjXhCeEBn5PZCRAlnUP4TA0zbtPIRbMBXy+cLBwvGXP/gtTU4xe9cEXA9ZA9chyhI1iS9AhLcSyKmkXWMpUivS3/CF+AJG37fodspFdGlX9hYh3hfeRQDRWHLIFl5yv/EPrkH78JjcQ4r6fpOGm8kafDaI5/32hj7sB3BY5I6H7iDH/JKPLyP86GCccnIi+JPt0wv/zuqn90Q5otG3lVoewzr+xJrwOMiLSGQYCfzDRyphFsnqq+sMqvEAYLsA67Yq2YqSmhzmTSLo7Y4gZqz/YdYsVuiPpC9ED9UOv8n9IGxeDsz8Pui7kQn7QdbaS4GehMSktW7jHrMEagWRkF0z2omVc+j0aAL9UJ/lVB11/Xf6fmQIf9g2qi+XPyk4E7AD5/lUIn/68xGdXDyrBmoodAytzZDexN6zcmEnq4wbrA9f1wkAHeecSFaA2e5+Bn/5c7GbTh5Na6iOMDr5FRME1qDuUp5QG0CRHhWTGDyfXnU9b+xuTJRzwHWdjAlQ44ftP3Xh4scSTPLgigDn/IPqT9cW56E3kBnRpWtLwORRgiPmcpWjMHvyx4gVwF6JNvuE0SenxyCu/i4ctLKartPxScnHRX3v8EAuvwgsbfT0FJ9k+EnNY9j886JKhnAmEnFIsejrN/zukck5tC24Fb+WcRo/G4hUK5b5vO4PYwPukhKH6WAhFH9oylqqNDiRuCLQeVfORO+z0Xm/Bl5gmZSPoc5jzMB274=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(110136005)(44832011)(6506007)(31686004)(8936002)(4744005)(36756003)(4326008)(38100700002)(6666004)(41300700001)(54906003)(2906002)(6512007)(66946007)(66476007)(66556008)(5660300002)(7416002)(6486002)(2616005)(8676002)(186003)(478600001)(31696002)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01HdGxpd0V1Y1lzcCtCdk5jZHVMNDdyS0xYSGxBUTZ2YTVISHA1MHlPQ1FM?=
 =?utf-8?B?WWVObEhpNVNGRWZtODdyWHEwdkx3RTYxMXdzYytrbTNhTUNsWlhEK2JsSmVk?=
 =?utf-8?B?Z25rV2dGdXJ5N3RscEoyS2ErTUtEMHJJT0VHdnU4cFRHcDJoUDNuVmszajF0?=
 =?utf-8?B?QWpIZElkUnREdTc2bDEyUlZ6cnBQSG11eW1LRlBydnROaDBDMWpIZm1Sam5p?=
 =?utf-8?B?SFIyeU01dXpVNjBnRXhFN2F0VEdGT1pZZVd2OS85alVVY24reXBRQzZ1L0JY?=
 =?utf-8?B?TWZqSlZ1QzJkdEdxRFArT3FvUHRuU1ptNUlmd3p4dll2aTZZVnpoNTl4QW50?=
 =?utf-8?B?aUdoSDhNT1EvbWVzMnViZFlidTc1SUhlbHRQV0pUUnVjMWZsU0NpYllGUlgy?=
 =?utf-8?B?dStOcXlSL015K2JNODRlcWJhZGdWSnpQWkwydkV2R25LS1lUQUdia2g0Sy9D?=
 =?utf-8?B?RlJ4OXBNVlpYQXpWdWpFNXJDMitYNFgrYk1mYThudlpTUm83YytWTi9oek1z?=
 =?utf-8?B?Z1ZRYUFVSHhrVjlVaU9FQWwwM2NBczVXZWtSYXA5dGlPbS9QKzkyaXRGK1I2?=
 =?utf-8?B?NGNOK2UrYXhvTmtmdlplY0FtcFhxN1N0M0tsbGNaSWJNMFBJU1pZcktYV1gw?=
 =?utf-8?B?TGRJZlh4T2p0WUg2SlVDOUdZYWRtQ3pKdSs2YVhVaGVadi9SZkNBSkVYSzZr?=
 =?utf-8?B?bWdUSjdjdFdRWUZRRUNNanY5VVZIYk9RK21OMSt4Qm1Hb0E3RUF6Y0xiNjhh?=
 =?utf-8?B?aWFPQ2xCdjRQUUhxc1EyMi9jS3k2MG5rTHo1KzZKTWlZWHRnUzlUM0lkTExQ?=
 =?utf-8?B?YTI0S0tvSldndVlLMGFWRkI2OGc1NzFaalYyT3hERGEvUU12bFhIU0Z2R0Ro?=
 =?utf-8?B?bHV5UVBnd05yRGc5bDJpd3dFS0xHRlllZ2hYUmFFK3NIaEZlOU9rM1VsYWQ4?=
 =?utf-8?B?bExxVkdMV09ramFBb1c0L3JWQ0hXWituUXhvZEZURDFUeENFaGx0WUJLbWE0?=
 =?utf-8?B?MytmM1hxWVM0VXhXQ3NEZCtjaWpCR1p5MGN6eHN2NVVIc0MrR0F1YlBuYVRD?=
 =?utf-8?B?V2pNL1pEQktXZ2dMZlVLTDBGc1M5TTVTTXhmbG5aai9NVzQ2c2FqR3NHRGtk?=
 =?utf-8?B?TGdlT3NxYmJoV1ZuR01NSGpVNDBaWnBZNlJyK2M2N1IzbVJ6dmk5eVFvZ29G?=
 =?utf-8?B?ZXNpQlFoOUtQQkNjT2FrZExYWDkrdytYMHN5MklpVkNQcmlUK0FPam1EZm9x?=
 =?utf-8?B?Vml0dWJTbW5yYlZTdlVNWjREdGRKeFBLS21SSFVhRW11RlZiSjhILzVYZkdE?=
 =?utf-8?B?Uk1iWGlwVDNlSWZKNWdjdHVvZW5BUkdXNjNFUHNLMnpIMVhpSlMrc0dGYnB1?=
 =?utf-8?B?WlY0clAvQ3R1aEZMMmpmNkdpSWN2NTVpUUZmTk5ienhFL1N4RWM5eG13YzNL?=
 =?utf-8?B?Vk55MG5tSm94Mm91ZkduVmtNRSttdFhvdWhDTG95eXZCRGlUYXArRGpMQk1m?=
 =?utf-8?B?YUcrZGQ0VWMyR0x0UVF1TFgzZVJYdkd6cTgzTzBIMVFtT2NYY1ZYOWwxZGxp?=
 =?utf-8?B?dVhsTEtUVzI0Z3RoSi9EdGo0UnRZUmJzNFlaT09tdnBpM1AxL1J6Mml2RjM3?=
 =?utf-8?B?U1lCSUhaMWJUK05qbitxMmloOUY5YUFVaWFpSm9Oaml2cW5xRmRyMFlsUjMy?=
 =?utf-8?B?d0FNbDh6MlBrcWFiOXZiVHZHVldndzJ3b0NGbTJRaUlMSjNoNGtwbS8zUUMy?=
 =?utf-8?B?NnM2a3hTVmNUSG5OVGtrdGc4OXhhQmlZQzQ1dk02aDh3dWFEYW9UWGpJbWd1?=
 =?utf-8?B?S3RYOXkxQW5HSWY5OHVnQjBBLzFzNkJOUVk0VkRSejNVMUdFU1FGNHg4eGph?=
 =?utf-8?B?WGRKOFBTU3F6STRJQkVZWU5TcGVITytJSk5TbWY0UW1lc3J3cXJEMFh5eW9a?=
 =?utf-8?B?U3Z3ZStKMWVKYjN1RUMxeHFmMmRoWUZRLzZoSk5jRWRUTG0vNWdDNGZFNVJp?=
 =?utf-8?B?RERma0hndzlrRlpXSVc5VDU5WUR3NjY2ZWwyWGc2WFFiSlkzamJKei9GWC9K?=
 =?utf-8?B?azRjUXZhdnM2U0hPK2x3S0VHVXBmY05CcFNCYXVpSm1QRERPM0srTUE1OENH?=
 =?utf-8?B?WUR3QTZDSkxsY3BMSHRaTWdlOUdKeXB5T1hiclgvWGZZeGNWTTZKeFdjWGxo?=
 =?utf-8?Q?icTY/1iD1QF6cFHKI4Qw9a5adjbuY56Qdz+OW/GO7yk1?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a60d677c-45a7-490e-2a38-08da64abeb04
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 08:44:37.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XceUXo/DbQ+9hARXMyyXxILCiYI1B7BIM066uvHgXpcCVvVgY6k9zqBvPCbvBkN6Q6fTHyIn1XdtT4OHP9LTC8Jg365lt/awIz0VThK95Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1539
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Am 13.07.22 um 10:36 schrieb Marco Felsch:
> Hi Frieder,
> 
> On 22-07-13, Frieder Schrempf wrote:
> 
> 
>> +	aliases {
>> +		ethernet1 = &usbnet;
>> +	};
> 
> Out of curiosity, why do you prefer usbnet instead of the fec?

We don't. In imx8mm.dtsi there is:

ethernet0 = &fec1;

We only assign the alias for the second ethernet, which is the USB adapter.

Best regards
Frieder
