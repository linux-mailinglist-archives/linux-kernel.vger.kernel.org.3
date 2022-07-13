Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406E57310F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiGMI1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiGMI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:26:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70118.outbound.protection.outlook.com [40.107.7.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8EB494;
        Wed, 13 Jul 2022 01:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFfz2+R/ARhaoJrl6KKzdnfWKNnqcIr1sH2ENMUpSmAhUoSQXgkFJgkJhm5h24JsDLluEhohVhOUZZdn1ijmZeBqYnfcbzcx/6ns6WICIbntuuJi8a43MLRkwqg7BScK7KylblZmnEYRQUV/11bz8fhrSyTuRaZ7F8gTtu1YuGWB/VtklkBMHaPzELytiPvgc4lyig45qM8TLHKxXIfQvPrAh5dkVEpQPFxoUPYmxdqt9B2Ttbex9AhAGw6IzwLI4U+j5RCzBQlLnfAqqcR7gQc1hr4b58I9PiOrBkKCAivujYypL9eOp4KLrTXSuXSv+bEOUEiaRU/YTW3/n7cPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4RD7zSYz3HeDJus/5IKblEBtYKaNvbZUTkcqny7fLY=;
 b=V9kshwXpf+ka84yzFayfdqbZjzfGiSA3e6lgp5Qk42VZ8w8MtCddk1zri5JIpxFlk+MlwMwJrl+47JKU/OVBoSsvgxypaVfACIAiLEv43Vxx6DpXABuqJ2cPhY0Uimc3Yeu9LkTqDtbUnlQvofu8exdRq8icBfTdgauW2KbAnykyF5K2m0sVlmSN0W8SuXtikJMHNuFSutNV34c4lbqDmHfQ1iQWocRVQIAAtVNwswospk+W5Y9ewLraiPNWKnX+gHroq9H7CCaGRGkEJ/qaWzL6PoRz06xYWMuB9c7tVm1F+2q6n+AYgY/73sM+JL0J64hHjj2ia4BtcWWSFU5NXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4RD7zSYz3HeDJus/5IKblEBtYKaNvbZUTkcqny7fLY=;
 b=hk5lLjQt6G7Xn+g1ZPe2LclbJh5EUOtc7MvPXLfAqK1SkiLgzOWxPtLiVo7qi8k2wUjHbfWY1feK22GErwwD46ZQaAIvvpQC4G4AHHlyQtU/735FP1YCkyYLfxGo1G8jYiNv0rmQhywNRnm3e7S+IJN6qgoQoiteLuuXIQkOa9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by HE1PR10MB1547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 08:25:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 08:25:35 +0000
Message-ID: <4f121712-25ce-45e1-1faf-abcf55e952d8@kontron.de>
Date:   Wed, 13 Jul 2022 10:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] arm64: dts: imx8mm-kontron: Use upper case PMIC
 regulator names
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-5-frieder@fris.de>
 <CAEyMn7a7S6UZOTsubM3pY95diY0oR0WNvhQpTUSmedjG59Qn9g@mail.gmail.com>
 <02a9b4ca-baf8-9f06-12be-57853893fb50@kontron.de>
In-Reply-To: <02a9b4ca-baf8-9f06-12be-57853893fb50@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a0ab3af-f3e5-4891-799f-08da64a94278
X-MS-TrafficTypeDiagnostic: HE1PR10MB1547:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL0SZKU54c8ixHKcUQDrGmFUmMmQUjNN5pbVpJ4bIi54SoQwS31TBoPL4V1syZ+9w5+NNri3SrXr6o5WMPPFI7q1K2YbiYpOFIMgv6Aq2I3MOLxL83B15W3JUxdGg4H60hoZzO/+5OeN6BdZJofmqj4/lc4B4l5si9ALuo82kNLYmqm2WU9n8r6t47eOFjCxH4LIiTCEG07ugTDRSXLCTFc+PQxqjNXkeJ764axauwlsrW55FvmKmGy91rsm6kNbQvgYWpee3kGWEqG1LEHu6WB5Ph5fI2CQ3U8j6rAmtV65ZGdQblhQEcFS+KmxIGfId+St6Ok87dlFUf3gLTBPeu+d/bfobrfsHtIUO5P1sFDKa00Gl/KMHXf1VxgosbRh1AdMc+0zCp8iYf74mSCeTXwIdxmxjgJwhJiEEZbGW+t4W9TUwwOjE5FYtNItWZN72kLNV6aTIRa3ZVFhdQRyfEF7nB+U3DYMY408DbG5UBNtCbKojZYwVGrglztDhniaRWt8Nub5fAagemGv0/3xhvzwzoY6nK7fPtE8H+sPftM0TjhIrEfsHl3GrHvrob8gi79xKpp5Kagl553aZ3BiIZ6BYdaOfcUNrNGZKlgzw82u7z+nyXMvg1eLwUNhHvkEFBpoa7IiuiJCEGzXhyDjKk9nd4X9jK0v5UEjXBNzg4Ekme37+NQx2fRXjKzYYY8yTchVdn8SK0bcEbsTrJaogO6CNiLSr64gu7yyS5ZQ72wgIqdiRPTZugKzxEy+trH9BGUwGg8jJ4ELChzqU9C/MqM7bESiOHiNrTfnzWdZk7jtWsNyUVL1+21F20/kWIG10t3ql+Dy4ZeLerYib5CHSoXWtW6ZF/UOdM0wfCKabosTodcQk8z/taZ8ylA4/sF6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(31696002)(83380400001)(6512007)(2616005)(86362001)(2906002)(6506007)(8936002)(66476007)(31686004)(66556008)(4326008)(54906003)(38100700002)(41300700001)(44832011)(316002)(66946007)(5660300002)(36756003)(478600001)(8676002)(7416002)(6486002)(110136005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZ4WU1mNHN5M1Z5R2NVSnJORnM5MjlZWUVqb2xheVM4Kzh5U1BnM1lWSHY4?=
 =?utf-8?B?S1cyQnI3VHlYK0ZVVTd3VUJ4NjJFMk9XcmZuUXFGbld0M29uMWlycUhoV21G?=
 =?utf-8?B?Wi9xK0RMT1MxQ0hiL1JxQzJUTDEzOFNRRWoyNHJFZ1pYWXl3Qzd3Q3N4SWQ0?=
 =?utf-8?B?WTM4MUF4dFZYWFBQa0tmVXV5ZkxkZnMvZ3ZQMTFxSm96UnJOcGhSL0dsa3ZF?=
 =?utf-8?B?UTVpSGJEK1VlVlVRSExDcHhPNWRjSUM2NVFxTVFDUkhMaUt6N1VQVi9zVnFO?=
 =?utf-8?B?ZFNaQWlIcUkvVnpLWUNRMnI2WTJrN01HZitPamdibDVwZktjWG9ubGc4VjBy?=
 =?utf-8?B?Z0JEdzlrbTdCcXQrbGtpa1ZEclRaTG94cEJOcUNkRk1KVndNc2pRZWlqYlpZ?=
 =?utf-8?B?dWVUYzdSQUo3cWVEckpFaGNUckZZY0ZWV1ZOdCtCWWtjRWNpNzJaMi9RS2Vm?=
 =?utf-8?B?Q2NFTnpkdFpUYTNEdEVKYmMvZW1VNkdNM3EzVDJwMVFaNmdFLzVmYnlzOWZF?=
 =?utf-8?B?bUpFaEtITk12QjN0dld4ZFRMeHpxUzZaZ0JTVjVIWkYwV2gwNHY5aWxZSHhq?=
 =?utf-8?B?VWM1VHZMK0lVbHRDTmJkLzBtcFNOWFNzWU15YjFtS3o3WDBpYk14SFNoNkFt?=
 =?utf-8?B?VW1WbDRrbHBUclZhVmhuMlVLdG9oVktLWmpDbnl0WHppSi8xT3Y1UjB3WHNX?=
 =?utf-8?B?VlZkdE4rMnBxRWVNUzR5dUovRnkxTlNTWDRvcVhNdWtTeFMzS2pITkpSTS9R?=
 =?utf-8?B?MmJhcUQ5Z1lFbnU2Y0o0R1QxZGczOEpkdkZDQnM0cUk1NFRQZCs0dmVjZldv?=
 =?utf-8?B?R3JtQkNtMGpBWDJNWGhDdy92ZDQ5N1BwSk1iUjExeUV3MnljS1BmTk5tays1?=
 =?utf-8?B?TDRWOUpFOXYzVFZVM1dUOVVyQ2NScHE3T0pkU3llUUhMMVU5M3FVUWF6NnZp?=
 =?utf-8?B?cHI3QUpSc1Jsb1Z4ZDhDa3B0ejNVaFBVNTB5WlJBUjhySkNSTThLTWZVWFdz?=
 =?utf-8?B?YWpsZnlyOGxjTTVCY3FLUDdtTUdMRlg0OUVJVEJkRzArZzJtdzg2N0JFeVJq?=
 =?utf-8?B?bjV6LzNNREY2VFdSM2NTSEpMM21QeVY0eGVsbnBqdGFBQmhyS0hXOG1ZYjl2?=
 =?utf-8?B?Z2VRQW95NmdHZFBtRTZsV2JTRVNOYkFYdTc2MU5hUzZ2Y2dNUExLOExQKzVG?=
 =?utf-8?B?VDl0WTB0UWZvcld3d01iWDE1THh6MzVhTnF6aTZIVHRMc3FuQnl2ZUo5Vm9O?=
 =?utf-8?B?bU1CUTFaV3YxR0RzNkY0bk4wQ3hqNEtHKy9Bbk1qQ2Z1cVhtdW1DVS9VNTZD?=
 =?utf-8?B?YklsdjBMOE5iWTlBeFpEZjgxaWNUdE9ZcmVsTUhUUGRRMVZ5bFo5clV2S3V0?=
 =?utf-8?B?Nk1yam9wSm01ZmpLZEFLVFVSWGYrY0piM0FqdWZSWnFIZ1VET1VWUy9JQ2hW?=
 =?utf-8?B?bTNiMU1GSTFVemJ0TWR5cEJLRHQzYzVJYTV6a2ZNNUlmS0NsSTd6STU3aFA3?=
 =?utf-8?B?K0V0bGdiZW56RE1COXZkQ08wLzBBMXVZWlh4cDhveUFLMXRRTHBHVFkvZ2xm?=
 =?utf-8?B?eTNTd0tiTjRsa05JUzZTaWtSSUpkV3dQM0E4eE1lTUZnYVEzblE5N2hZOUVh?=
 =?utf-8?B?WitkWGtDcE9WZDhiK3k5QTJYVXhqR0k2alRJU2JtcTJLak1iM2ZRelZYWXZP?=
 =?utf-8?B?OUE0UXI2ZnROejFtZFZ2MmdyUExreVdjc2VoTngvWmlWY2xTK3lyTXRnNDU3?=
 =?utf-8?B?bmJGTjQ2dEx6ZzM0ZmZ1ZE9meE9oSTc2a3ZLSlZzaGhyMDJTKzkvZlZzRTEw?=
 =?utf-8?B?SlYzRS9PeEFKNEM1YkxsTy96MjNtMEQvcld0RVZhT3htYWxaa1FWL0wyb3c4?=
 =?utf-8?B?b243bHhWR0JlQlBLTm02ZU00MjdCenVLejE5S3E1bzliQ0c1VUg0c05QL1lM?=
 =?utf-8?B?MmVvRWZrRExuZVNxWXR5OUt2Rlk5a3ZobFVKZzR1bWVuMVRqR28xa0RzcE1w?=
 =?utf-8?B?Z0pQdHpxSS9Lam9YMlU5azFjVFpPWVF5UEJJdzVGUXZmVkdHMzJuc0V2Q0FO?=
 =?utf-8?B?eXdscUtXRlc2QzhpTUZUcFZmek1sMmRzZlVJck1obEVtLzc1YlVMemRwWEdU?=
 =?utf-8?B?eU5uUXAvYnBQWHB3K256aHJKOGk1Y3Z6TmlIMHBaQjNldFpTeHZkRzhYWER5?=
 =?utf-8?Q?2XrzWIj4iA23YMATIZikUMykSimGB6WcFl/ouD4QosZj?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0ab3af-f3e5-4891-799f-08da64a94278
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 08:25:35.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QmWAl9qArYmJ/8+z0E6l18iXHnX+SmvS0WGt8uQbHN0QZXAJP0/5XbOiQTx7iJgUUYeKFMHImjQnOUEPcYGVf03gRsQ39cTNVOjOBLlX1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1547
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.07.22 um 10:15 schrieb Frieder Schrempf:
> Am 13.07.22 um 09:52 schrieb Heiko Thiery:
>> Hi Frieder,
>>
>> Am Mi., 13. Juli 2022 um 09:41 Uhr schrieb Frieder Schrempf <frieder@fris.de>:
>>>
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> Use upper case PMIC regulator names to comply with the bindings.
>>>
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> ---
>>>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 22 +++++++++----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>> index 2d0661cce89b..2e3d51bbf92e 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>> @@ -85,7 +85,7 @@ pca9450: pmic@25 {
>>>
>>>                 regulators {
>>>                         reg_vdd_soc: BUCK1 {
>>> -                               regulator-name = "buck1";
>>> +                               regulator-name = "BUCK1";
>>
>> Wouldn't it be better to use the real signal or voltage rail names
>> used in the schematics?
> 
> Sounds like a good idea, thanks! I will try to include in the next
> version of this patchset.

On the other hand, the bindings stipulate that the regulator-names
should be "^BUCK[1-6]$" and "^LDO[1-5]$". But I admit these names are
not really useful and maybe the bindings should be changed to allow
arbitrary names?
