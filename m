Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA154310B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiFHNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbiFHNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:08:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0C25D82C;
        Wed,  8 Jun 2022 06:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdnhUvIuukzohfTgxtbWpXwlR3MZjsN1TOXbqMyetdwJWuPXXRECbeGMYRGeRWgOgorUb4AdIUJI1DbIV88jvDGsya+Bh+QRFBECdSb62gOUvaebcF9BfTyZzYY0X2UeKZ+NKxreoEQUMOQ/JGA9+VNiS5zdfj2+Njp2Z/n0b5kT6LPccMbinwODQ8Hg2sBxeyx+dae5uEzkqjjXuMXHBl0m20hTUMfFBElNSU4GfHDR19/RRjBEynKd35kCEbrT843UmOzQNdyU31jzSfFqnA3itEpQ2Wd67iF248+EOEKmBzLh2SJ7ybhq4pqQ9yMrX1UWOWt3qJqTrzpusU8KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFhnqP082Ay0394vc5XMq/xJxQ6OACLoSFSjBmjD4M0=;
 b=LttWEcamzuYud1jB2s2qIvSJXv7xl84RXguyw7WscZ25n4MgpKZRPblrROsZeNEPLPWlWETKZQHKdlODUtu7hSyWh/pyYPCAbYzaurNPXI6q41l/GDrnFNM10fgwz2ff9qgRz1pty98GzOWwVyO4ssCYjMGp0kwJLeuS3s8dVRK6IbN+RycqIZHgo5pdNcca8o9E6q+8Ckf5EHm/z6qmlMmzcHTg70eucKWm1MDi2subWn+zzKu9uuuUNBJtd0f9pRJINbU+HBwHy1vucFw2WsyZ3bCNwlE1CW5gBaNGMZw+9AO5ItyTONlHAD+RcVUtXMzTKH6+qbFu52rXdvnt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFhnqP082Ay0394vc5XMq/xJxQ6OACLoSFSjBmjD4M0=;
 b=I5V3kNq22SfrrlI2bSruhKrnfCjPGFmVfHuEfjvvr13r+kdpXMDFA+iSlCi/bhyoT9SVSChu0u0MfkkaGc8vUA4uIQSpzNoXEtYPxtlRQpjYjOhWokEXBhFMOFG26HSW0l2g/mm9zysvaVkZ8zn+Q/otXKYIlFLjjk/+7ENiM7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VE1PR08MB4704.eurprd08.prod.outlook.com
 (2603:10a6:802:b0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 13:08:44 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2%3]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 13:08:44 +0000
Message-ID: <5e0b908b-52c8-494e-a804-393c8aad097a@wolfvision.net>
Date:   Wed, 8 Jun 2022 15:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-s add more peripherals
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Sjoerd Simons <sjoerd@collabora.com>
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220606082629.79682-1-sjoerd@collabora.com>
 <4731d47f-ef02-d512-c599-274f8208f845@wolfvision.net>
 <3576f2af98a0d9e7128568777d85af3bfbab801d.camel@collabora.com>
 <2759751.88bMQJbFj6@diego>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <2759751.88bMQJbFj6@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 124cdc9b-ffa4-4dc0-00b9-08da49500422
X-MS-TrafficTypeDiagnostic: VE1PR08MB4704:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB4704B29970B5C44DE998DE12F2A49@VE1PR08MB4704.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRKTlSaz47Pg5UuwTjxcIF00rZaOoo6gqamJFjhD/6XD6TyiBSKRCKjE0wcRUViLuHBiZ34O8aZ97C/rgK95HLSaANHgCdHwLhZ0BXn/ClayTCGyT2N2IwFRrCDynqvgosPBrqmwaUnQEDFI6vwl8N12ADEcVbCA3uIW9vVZtDGGm82fz/ZCSvjpEQueXl+ie3tYbFIv8ayvBud9Io9mEGLsQ6XfzCDmRb86p1VT/o+LmULI7hwp7Xh05u55KCKeAi4P+g1FCWDzQzKMmJwDL0lars6DJngO4ndvJOS3/1T4M4d9zX2SzCZNV1NnnwuwUHJPz4G/7WalD72Uuj0CDiXSnH+F/EyaWftBMuz9PudG2OxOxblJJPBh48uTGpXR/PZWqC/FYRihtRf/5t65MoRZw8ip7tjrh3eejFB1s8kWb6nMl2JVxt3W2uJWYYThCqzWOEdE9rTpg6TeFUjYhrBrW/CwYUP4YLFyizLeMoc0enSnJtF2K93fAJdaC2wl1O3a6y/6MZQvW1WmPsro4lzbhwjPYIjWsd3XOF3HOEcFp18RRQViWh8TEmKHR/uvkXWgGi61jW9qQumC303MVAfs4w5gLCjlPEPIcK/ijnsuKo75MrPKpipRh3ms3w6e9BJfM45Kc03cHvQuSvv3BzvseMJ61HFfQNHjPoLNVg9OgddYCU6a2qrgJqn1YJaCykz/oKaOcMFTMp1OW3XuU8RrTBZpHUJ/icH0x+jRcxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(39840400004)(366004)(346002)(396003)(66476007)(6666004)(6506007)(316002)(8936002)(66556008)(36756003)(2616005)(66946007)(38100700002)(6512007)(31696002)(86362001)(5660300002)(31686004)(8676002)(4326008)(52116002)(7416002)(110136005)(53546011)(186003)(44832011)(54906003)(508600001)(83380400001)(41300700001)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFMdnFLS3JNb2ZNMXA5WkxtQlNZcnZhTmt3Ymxua3lMNzhjd05DYk9WUGJN?=
 =?utf-8?B?V2Yzc2ppOVF1UUo5N28zMi9PTmt0M3lFWFFEUDBmaXRsR3Z3cC9ucW5ad0FC?=
 =?utf-8?B?aFg1ZEpzeE5uVm0xMVNQWGxSbEQ0VVNqY1dxYkJhOW5CeVNYRzcycUpqYmhn?=
 =?utf-8?B?UWxGaEN1SGp3VlBVOGtrUWZ4RE9qc0JGYXA4QnVLVmtDMURSSThPcjBzOUJG?=
 =?utf-8?B?bFpCaDJJUlovdXZQY281eDNXMTlKT1ZGYkRHWVFxeHhtQkxlYkR5bXhZTU9V?=
 =?utf-8?B?UGRrNVU4alJ4cUVCMWFXQW5LbThGaitOUDhORFVydDR3azEyeXBrSVZ5MHFY?=
 =?utf-8?B?MXlYN0lCMUNMM0FtNlRqZ3FXcGN5TDI4SFRKbVNVeFNaeGxEL3dlT2d1REEy?=
 =?utf-8?B?VXBMQ010ZmNka1J6RGg4b3RQeGN5bi8vQXdBTlRRQy83T1J2RS9XbjRaODVk?=
 =?utf-8?B?QWNyQ3pIVFZacndyZWdjUEphV1VTRHhMNkJ6SzkwMVcvWHd3SG9FNEQ2ZFdi?=
 =?utf-8?B?YmNSaklodWJ6SmtWZHM3MDk1aUptN25LaVRPZVV3Z3hxY2E5OUhXeVo3OVJz?=
 =?utf-8?B?Tyt1ajNlcmxZYTRoZFZ5SVlnOVQ0aDQrS1dMV0NPbUtreHpieGdDbkVTLzVW?=
 =?utf-8?B?c2hnZkJJalpKU3NpN1pIajFmY1pBNEszRUtBTDRtRDlhYnZFZGZ4RUhKcU1X?=
 =?utf-8?B?blZiaEY4NmtZOEowUGZ3WDFTQUhXbUVHTTR0bFJuRWN3QTVMbDVOK1pXekQ2?=
 =?utf-8?B?WXl1RFZORjdIYVQrY0NzM0N3YUlxMllLdVB0U2pxaXVxdlI0VlROOTk2MU9p?=
 =?utf-8?B?NUNkR1hSUW84bHRwMi91ZXRiWlp0QlI4Q05zWWV3cndldy8vM2Q1TU1uWHdY?=
 =?utf-8?B?STlka1EwaFNwZkVrVjhYeGhZQmxxK1lWQ05Sc3pqKzJldVg4N0FMb0E2cksz?=
 =?utf-8?B?MkEzUkFHdDdheUlDQXFBcWZLaTI0RnBTNUJyRnNXYjd5TVVDWTIvTHNFcFd2?=
 =?utf-8?B?TFhlWFhDbUxSZHVPWEkvM3lKZDRwVUs4QU45aFpRTm5IS0Y5VTlUMTk1SmZK?=
 =?utf-8?B?NlhPVGxubFl3MFNzUXNlRk9IUldPUXNtN1BPdHpnNERYdk15VDgxdjJzU1hB?=
 =?utf-8?B?TmU5QmIrM2xBbmhNdXpjZDBmSDNYdU9oblM0QVRjSVBkdjZKaGZkTnlDZ1da?=
 =?utf-8?B?d1VKaks5S0JHMUd0M0hLTkE1aDUwTnJBTnZnZnJZaWxwa3IwbEJqZDkwSnB0?=
 =?utf-8?B?ZXRoaW1ONnFPUzg4UW1EZ0JPZDVxMHVVekNNYmNWQjlSVUZuOGZubk5CZ0hU?=
 =?utf-8?B?T2EzQTcvVVE0dWcwKzc5eU9lUFBnUnhDRUdSMVJEMFp1djZQY3NHbk0vNFZy?=
 =?utf-8?B?RnArbURLRUpWSml3MjRqTm03MTNEaHY1ME9oQ1QzMU5CVXhhVEVxUDZZd0tn?=
 =?utf-8?B?NnJkaDFCcjJLM1hTeWNjQkF2amJaY29IMlJQazJxVDBnRno2bVBwM01US2Nq?=
 =?utf-8?B?Wi9WQVZWQnIvc29XOEJJQVlxQTkyRTNsWHFxaUE5RjNCemtGMUw4dDI0NVpr?=
 =?utf-8?B?OWJ3aW11UEVjb2E4VDhxM2lzSWZkeHpxS0UwY25FdXVKcXJxcWYrR0V1OENN?=
 =?utf-8?B?cVNOS24vcHFUNHo3U2dOS0Nyem15VGt0TjFlVVoxa2NTN3oyMXZrSVlqMUgv?=
 =?utf-8?B?U0F1MnM3VG9oV1A4elpwN1Qycy9pQWpiUTRUTk50SE1tNnluMTFIcnk0cDA2?=
 =?utf-8?B?K0dkbmpha0VOck9UcnphTlpRSFkyOUxwNUp2ZFdUdzRoRUNUUVZIRzF6Snlh?=
 =?utf-8?B?Z05HV3U1N0JvMGIrQk1SZVNnbFN3Q1NETWhGWE9uVFJYRDRqUUh2SlRCbW1U?=
 =?utf-8?B?ZG9nREt2a29ZQ29lbnB1dFRiZEN2WFdKNjVUQjd3RzYwbS9oNE9oRmxpVGsw?=
 =?utf-8?B?UFo5UHVBOUszTE5QNlByNjRJcGxZRGYvWTh5eFpJbnBURjhablRteGx5OWo5?=
 =?utf-8?B?cGppbGp0Z3ZPaE5NR0c0Tk9heFNQdXFtQlV5WGR2TG9QVnJML0VsMkZJbG8z?=
 =?utf-8?B?TlZFcXhrSGZ1N2lHR3ZiS3YzYkFuek0wb0NZcnBMYjVMVE9aTzRrTmdyd1ZJ?=
 =?utf-8?B?c2x4MExkMVBPYUxhaGlEY1ZzYksrbzRGUmEwSVY1SElDRmRVcFBGOTdPSFVI?=
 =?utf-8?B?ZFJrczc1N1Byem9sMmthczhhckRyT1JWUXBnUWtqTjlxdy9memQ5WW5Na0pX?=
 =?utf-8?B?SGg5blNOYTZ6MDNzOGRHakF6SGlDOGNqcWNyUjN4R1E0dHBNVzRxSWlma3Ux?=
 =?utf-8?B?Q1dSR2UxSW4wVzFoMXlJblNpRHIwOVZTMTkzVzlnenc2VDFDcUpYMDYyQUl2?=
 =?utf-8?Q?X7ZT27ramplq4tFvIYyKhGGmZr8Gq7I2HSQUZe6qP1FkB?=
X-MS-Exchange-AntiSpam-MessageData-1: FQq9TQJ1EAOWpLb9vquZiCNyWtbBBBOx5L8b+iAt5WLAzF7rX8/kb9b1
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 124cdc9b-ffa4-4dc0-00b9-08da49500422
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:08:44.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdLJPcDfTsPgxsc9YC7QTNHCCmwJLxOkBr9s2vDOqLHCeV/gnt/NfgB1+0d+1GqOFD5CFktKLXQpIoh7NXJPJzGix/DrGXXEkLVztqiMKPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4704
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 6/8/22 14:19, Heiko Stübner wrote:
> Am Mittwoch, 8. Juni 2022, 14:07:33 CEST schrieb Sjoerd Simons:
>> Hey Michael,
>>
>> On Mon, 2022-06-06 at 14:00 +0200, Michael Riesch wrote:
>>>
>>>> +       aliases {
>>>> +               ethernet0 = &gmac;
>>>> +               mmc0 = &emmc;
>>>> +               mmc1 = &sdmmc;
>>>
>>> Sure? emmc is at address ff49000 which is larger than sdmmc's address
>>> ff480000. I believe the aliases should be sorted w.r.t. addresses.
>>
>> Do you have a reference about this sorting requirement?

No, not really. I did have the impression that such a convention existed...

> I do believe we used that mmcx -> *mmc-device sorted by address
> when the aliases still were in the main soc dtsi. Simply because one
> couldn't really know what was available on a specific board
> (no emmc for example).

... and this seems to be the case indeed...

> I guess now on a per-board level we could actually do that more relaxed
> and let that be the decision of the board submitter ;-) .

... but apparently the convention is not that crucial anymore :-) Just
wanted to point it out.

>> Also do you mean that mmc0 should be &sdmmc *or* that the aliases
>> should have mmc1 listed first.

FTR, I would have suggested

mmc0 = &sdmmc;
mmc1 = &emmc;

according to said convention, but then I would also take a look on
whatever any other rk3308 boards do and aim to be in sync...

>> For reference the reason is that mmc0 is emmc is because it seems more
>> logical to have the builtin devices come first (e.g. as mmcblk0) 

... unless there is a good reason not to. You be the judge of that ;-)

Best regards,
Michael

>> [...]
