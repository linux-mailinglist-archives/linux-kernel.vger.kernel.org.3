Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB951F93D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiEIKDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiEIJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:53:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81C229232;
        Mon,  9 May 2022 02:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHj3mI+S5XPwTE/GlAlCyr/gd2rnkNmyr27mSKSeTKbg42eLans9zF5RaKN8hW6Q6xiRzu4OSLR/hzRkSABDHpLVOAR8z9hX72KZPxMeCJUs1y+lb13Rlk1RnNtNbueDtyDbnUUCoFNl/XyFsxJZQza9W/GPMtLwBLAjODXLbdpP+k9TOoRb+o35jwF9LO7eysLymcFSKD0fB7DKavl/8kyokwivOd5WFMGT7OYeGpZf9X0iKFicd2kMmXl+eZprwWYlA6twEjJnIuOfvM2JHSYFBRg3qinRczxO1+MC1FD1A19HxNzPFePpX9hTSJ0jQ9NxXYF8cMBuxpyppHNljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ip0mRyuhTr9hIOFtbzqhroARC+gojYgKNMJf1XeMrWE=;
 b=KO6bQGvv9SNEC60jNd3LisRdqu+dJIpK1Jda01a0QYQx4zuYU4mi7SqKOndrKOWDM9Av4ZEzPF8CONThBIb1mU3N4b+Dv1OBlyjaBxOOCw9bChfnN4JUltVlEB8vDv1My3jTOInNuVUaiISYUl+YHJJVd9bYLMLkId2ZyN2GhQfcKtb8okYG3NnrK9/97iIM9iBhu5Fid3A/uqns6NGguU7kebDyMJ8jloztJyC4SuME72dF3nfI7+YLLYqPCKrd2W9TZQYXmVTkeqAlwxXXCe1PltRsOim/OhW4rZgIHRp4LpurDzcrqwL/vkop+YkKO9dryCrI0hyy4wRVYDGMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip0mRyuhTr9hIOFtbzqhroARC+gojYgKNMJf1XeMrWE=;
 b=itZGvdN51IZ3p5QTgHx6C/X7g8LXawFpmGyKfRA6n8nS7vU3R7SPapLFYtxCRmMzgnIu+NU7cXKZAEXfNE12rihBCrwkTOIV1mCo9KKdYkFc9R9JllljHQWbhIHjcRBAo3cq5BhO+/h1uo53r4x9/sJSAgfOW14ZsCunb/NwML8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DBBPR08MB4348.eurprd08.prod.outlook.com (2603:10a6:10:cc::10)
 by VI1PR08MB3423.eurprd08.prod.outlook.com (2603:10a6:803:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 09:49:11 +0000
Received: from DBBPR08MB4348.eurprd08.prod.outlook.com
 ([fe80::fdf6:eff9:d68:ea9]) by DBBPR08MB4348.eurprd08.prod.outlook.com
 ([fe80::fdf6:eff9:d68:ea9%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 09:49:10 +0000
Message-ID: <aecc866c-685b-8def-a197-d1246070aa54@wolfvision.net>
Date:   Mon, 9 May 2022 11:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable otg/drd operation of
 usb_host0_xhci in rk3568
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
References: <20220502064551.202613-1-michael.riesch@wolfvision.net>
 <CAMdYzYrChKVwuGj=VEc=T4Gez-Bs647GxaeMsdbgvU_6p3FeEg@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <CAMdYzYrChKVwuGj=VEc=T4Gez-Bs647GxaeMsdbgvU_6p3FeEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::19) To DBBPR08MB4348.eurprd08.prod.outlook.com
 (2603:10a6:10:cc::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3285f8-b303-44a4-9c61-08da31a12aa9
X-MS-TrafficTypeDiagnostic: VI1PR08MB3423:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB342370401AEF73DA75CF4D8BF2C69@VI1PR08MB3423.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTUsexml5xqsrtcUotKy9Sk2i8+A3vdsn5Xrm8Q9fvP0OkE6f0evYY63P8uCbu9W/yU/Vied4KI2l6qAGj236+idMWfbWi5chWCwwzxUhAv8Il1E9ZXeyHdyTgMx5qkuOu+nJ1tAWxT4oinSAhXjLToGJBr8K72E/8a+YjEGuXoyZPpdYMltUEDdaN+t8QUKcJYv7zFpy1ix4Hor8aCg8kVVyHO0fYuvsq8qvKywChrUxypjks0fgxFllWf+umj3O51ZI/tYmyVEqz141XRgKSBIritC2E35y1c9p/s0ZMsRodI/dBJfprJRzWSp++U1sSav6PEe37fkQ3zdm5IZA1eOs1SYagt6JLZ4AumLyNnQDnWR5WJ/RX0e+7KtxtX+Wlf3RsbGTYtGBdQCiWbsQ8MPZcUWUBqX7rvphZU44rT2AyGkWt1guCH+EON+yWw6LzLxTCI9QyDCy1WDWSmki/JNWXhktCqSI8m44pFSeSLO4Bq3ExtBz0y84IJqbK5Ii7/oILAD3bX/QxbYntJj2v1MZtNwgiSMY9uMougJwhZMgIK+qN1jpTlFTbE9ZUdt0QLvp8r5GEgRZ7HMCtcJTWMvH5bcXR/ChSw6I+InQHfCxfc2sCZ+pkAjjsk5vWjNDqnFive7EGHBY4datwC+47C0XG4T4W7/E0KXpKBQ060P3j8TDKTSaNdMD3gTBagjIxinzAmpui14kb8Hufrtq4y2sWGRwm+B/fwTcB3Ga08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4348.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(4326008)(6506007)(316002)(186003)(53546011)(2906002)(7416002)(6512007)(66556008)(66476007)(6916009)(8676002)(66946007)(54906003)(31686004)(508600001)(6486002)(52116002)(2616005)(83380400001)(5660300002)(31696002)(8936002)(86362001)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2lhRnM5UFdRZnVxZVhvRGs4TWF4NTB0ZkdOU2o0RFl1cUpieDNhaDNHbVRw?=
 =?utf-8?B?YWZZaUtGbUQ1c2NWRklwb0NKeExHd2kvK0hCdytJS29hbk9udWdkVEFnL3RQ?=
 =?utf-8?B?aUhJbHNYQWZzbVE5SHNPVEZCd1YrVDdQT203MUprY1NScWd6TllUU2hVcS9l?=
 =?utf-8?B?TzlWQXBXRnM2MExHei9nTElsbVVjS2JjMkpSV1IxbFN6WExuU0RTekd0aUNU?=
 =?utf-8?B?SmF4ZTBVWDB5TjRuRTJOWmhXdWZ0WlNPUTBaem9pRklNd0E2V0N5cU43b3Fs?=
 =?utf-8?B?UEdEVGQ4OTFsaGVyQkVPS0QxcU9TTEkyODBWWUpOYVdvaU1OK3dBUTFWanI0?=
 =?utf-8?B?dGtkeDlsdEdtT25xK0NLbVFUYU1FZzZ1SjhYY2JZWFRHcVZwYXhHbDliQTBK?=
 =?utf-8?B?dkd3YTIxSXA3ZWFYZ1lQWkhwZjIzdkdpa2hkOTdPUTRGTC9wWHlFb0VVZmY4?=
 =?utf-8?B?ZHJhZVp4QXpUM1FBcFJCbWJkMmpHeG1lWFk5M3FqaUxpbVRwdisxQnB5SUtX?=
 =?utf-8?B?azJ6RXh0MkNvYlhTWSt1TlpUSTNjbVBESHdnejhQMnVtMnB5QlQ1eHpoZmo0?=
 =?utf-8?B?UFFaNk1xL2FFZkRmNUN2MFFTSXBHcjhCU0F5ek11TmVicFVBWTJPVWZiU1JB?=
 =?utf-8?B?bVBIY1Q4NEtGb092YTNpVXJnVktQT3creFJ2bE51VjJMYjBLZmQ2TDVudkFP?=
 =?utf-8?B?SkZxSUlmeW51RkZqYm9SeXViMUtyYWcydzFabTJVS09NLzEwUlRVZlNwNkhq?=
 =?utf-8?B?cEJCVmNUMWtzSWk2akU2QWwxQlF3c3czTGZHcDM0ZTVDbHIrbHJFOHY0WGJq?=
 =?utf-8?B?c1FJQW9HMzFXNllyOFNSSElXQnB3WFMzVW5xME8vMHg2dXljUnRySUV0V2xP?=
 =?utf-8?B?OUFxYVFVRThQNGxXU0h2L0tiZGZFdWN2ZXQzYjE5NVJnTldKZTdLVUoxK1hR?=
 =?utf-8?B?U3hBWEZ2ZlVqeG1hVk9pOTlIQnNwYzBWZm1CTnpuU0l0SVJzRTYzMEFpdkRs?=
 =?utf-8?B?bHprV0pCdkN2cHk1Z3diNURjb3V2RGtjZHRTZTZ3ejU2YVh5eVI2L3pnMysv?=
 =?utf-8?B?UmFhOVJkQWQwaGp6WFVqMUtRZ09hZFlXbXY5dHFJUG1Ta09RczRlcDlGaUNl?=
 =?utf-8?B?QlBwOHpVSW5hS1R6NjBiNnhxYlNXV0dGdXo0OTdScENjbmE0ZnBBSEFGK0hx?=
 =?utf-8?B?VjVXY1M0Y3lxZFVwRFBCUEsxL0xqbUpKbEdrdEgrdHB0d1ZMTU5wTkVMeHMx?=
 =?utf-8?B?Qmp2Y3B2K1JaRkhZdWxVMFpGa3VIeVRtOXBTd3lxeUZxb2c4WlR2YkRqejFp?=
 =?utf-8?B?MTB5KytEUjZrb1g4VEtJZjhDdWRRSGxQbEh0Y0FSTXNOOCtZQ3M3SWpaeU9E?=
 =?utf-8?B?UFpYb1RCTjdiUk5LZnV6am1iSXQ0YzJuK0owK0pQVkYwWnZlL2RRWDZMMGt0?=
 =?utf-8?B?OU5sTFdLeEdPYTZEbEZnWXRiQjVKVXhlNWswTjhHZW9TNkFETkJpbmUxVFl3?=
 =?utf-8?B?VUZrRXk2Z1cxOGkxbzRWcW5vZnpzTFlyQVFneGM3UGFRaVhlbnpTWlExZG5n?=
 =?utf-8?B?RElYc3JTTlZuZUJTMkNaN0dSSk5jSVNVcHBBMWdkRXgwZTZTZnF6QjdXR2x3?=
 =?utf-8?B?T05xY1Y2eFlrRmdqa2FyQWdiZXAvekVyQWdZcFBlbTVMdFJ1V0xPWnRmNmky?=
 =?utf-8?B?VUVjQVQ3M09aTEk0bHgxTkVKaVlxVmx0d3ZONGVWaVdPeFVEU1VUb3FIVjB3?=
 =?utf-8?B?c0I4RVNrZUVSR01aVk5yQk8zV1lwbEYvSWdERDVrcy9zNzhUV3N1YWdEUEtE?=
 =?utf-8?B?VU4zWXNkTGRITkNxcTFicEFVWXI2QkJ3alhGaTRMMkVWbVZMcnRkR3dnWStm?=
 =?utf-8?B?R2MrOFMrMTVLVXZMMm1vOWFnY1RhNytIeDJUNjhwVG5uajlXd2lJYThkUCt0?=
 =?utf-8?B?NDhJaGdZbEhqV3JpZGplU1IzRVBySGoxaTFtNHl0NmJhMjJWWVpRRlpTZ3F5?=
 =?utf-8?B?ZnMrN1F0Q1pTYUhqanAvSUZ6dHJYNjFQaXA2QlNqV1k1RC85NmR4L04rVm1h?=
 =?utf-8?B?alM2V2I3QUxYL2I5OUhRK2FYRFJkcXNzQ3JsTlJtYktnTzA2cU9sN1Z3UEJQ?=
 =?utf-8?B?RUR1MWlKRnNaUzZiT0ZxTkFBTzVQWHRFNS9MNkZuNk1hZzllVGZ2SWU3emI5?=
 =?utf-8?B?NTdLSGpxcit5OFFpelZaZTJPSTVPcmVmMmQvWHhQSjZRRGxTVHdsZWFBNnpK?=
 =?utf-8?B?QlZQVDhGbFE3MVZjYUJadWNORG5uUnBWeitDc0hLSGJEL1EzYU1NbHBUbG5m?=
 =?utf-8?B?RllONFplemxsWHRRL0dvZitZbUNLU01tU1hjZitUMkt1M21PdkFOaHlOS2U4?=
 =?utf-8?Q?MA+1vgO0ay2g0bxRGPRTdLo9TtZh+ZL4lxMnjgjEdGszb?=
X-MS-Exchange-AntiSpam-MessageData-1: i7jmXHfOwptdShIRVb09G/+icEZlmHAazizBQ4fbXyqFbQx6MQqjnZdf
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3285f8-b303-44a4-9c61-08da31a12aa9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4348.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:49:10.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq3ggTC7gaTvTv8U4N4/VEFxt33Tyk3qq4K8USbv8AAl8v8J6f1z8RhUIsyEEOgDxpDXPEqeWTN2Hv2k6WSsFg57bRmVV00DTuZMEcXzOhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3423
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 5/2/22 11:54, Peter Geis wrote:
> On Mon, May 2, 2022 at 2:46 AM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> This USB 3.0 controller of the Rockchip RK3568 is capable of OTG/DRD
>> operation. Enable it in the device tree.
> 
> I think I missed a conversation here, the xhci0 controller is the otg
> port for both rk3566 and rk3568. The only difference is on rk3566 it
> is a usb2 only controller, where on rk3568 it is also a usb3
> controller. It was set to host only because my original phy patches
> didn't support otg mode. Since then Samuel's series fixed that.
> 
> Your original patch was correct.

I have already replied to v1, but at this point I would like to
 - thank you for pointing this out
 - and send a friendly reminder to Heiko: please apply v1 of this
   patch :-)

Thanks and best regards,
Michael

> 
> Always,
> Peter
> 
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>> v2:
>>  - As pointed out by Nicolas, this is RK3568 specific. Moved change to
>>    rk3568.dtsi.
>>
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 5eafddf62edc..bbfe8f3d68b7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -134,6 +134,7 @@ power-domain@RK3568_PD_PIPE {
>>  };
>>
>>  &usb_host0_xhci {
>> +       dr_mode = "otg";
>>         phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
>>         phy-names = "usb2-phy", "usb3-phy";
>>  };
>> --
>> 2.30.2
