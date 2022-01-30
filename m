Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822574A3578
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354524AbiA3JuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:50:06 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:51574
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346817AbiA3JuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:50:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2iMqp4fhkYyqKZxMgsCRNA+bLrIr4+4+UX2Bj5zVW3hXUq5G00Io/uC4emqYubpk7WiWQEOdBH2hEgH3bsiHR5EN4TWaoVua+bfbT+GZP6HH/V+BdsdT21rRIslRoSlobq1MlabFpbFtSAOSPm63pDiw7ki4ePa/0V+3ckWvQ9ARQSs+Jr18/un2qf4A4u78+COMglArbVAmPH8d8fm8ckOcCnbpm4oMKbWa0FHZNb+ihJ9bI+LqAOldNJquNtdbA2Zm4fpmJpQgNJqdXkHC0wflDoTPjPsinzdx0Roand7lhpZZla+qM9MWPl6kH7d1/EPzi0e6/8nxj+ROTrhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XIYa4zkcd6a6/78+EPlpTrTWEidaxP2YsOI3kfOPKA=;
 b=FQBKzWhtmqjppkEvj1G2iqwGp28K4ejU674ONi08+ti4mFZux9Ra00dMY3y7Vv40nal06t0qs/Yhp7PCTp+7H4qhaV9CZ7puEtsxHG+0excWZnJ+6bG8kMihrjWN8cLClegH1m6Ecyb/P7PmNXBfxwFvy+FFvnvUOHMogPBLhJyxi85ngtRY9zfKDWStVw9y8UPe+PW20ErrngmAjHLMnjOL0N5RM8qC9FEeB9NOW+cI5APwPhL304kt80IdAoleVbt7266wS04LDW+QbewYrJ1XwFrmuStO/A0NozLWxtkX7J+2p3H9cLrYA5KDt37BFsJCIS7cFAbpVCfQzPfw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XIYa4zkcd6a6/78+EPlpTrTWEidaxP2YsOI3kfOPKA=;
 b=CEbyTs5CUoOMQMHQRg1Sl/3xYS0TkkeZ9plXPH6h7KuuaASs+TeAgkIOK32aBuUsCtPtsh2yX/fpqalsoWG7AYIqOGbLCWFZq4XnOGU9nQzmPtsmNmCBwSRduM2Txl8e38ksj3jhl5hwn35fJyq8b5ado2L5df0OOqBidzZqhp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by VI1PR08MB4543.eurprd08.prod.outlook.com (2603:10a6:803:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sun, 30 Jan
 2022 09:49:58 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::e14f:197:5001:4c56%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 09:49:58 +0000
Message-ID: <0fe601eb-2993-79a5-bb45-6eafc7f9d0ba@wolfvision.net>
Date:   Sun, 30 Jan 2022 10:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: rk356x: Add pdm node
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
References: <20220130053803.43660-1-samuel@sholland.org>
 <20220130053803.43660-2-samuel@sholland.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220130053803.43660-2-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0086.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::19) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205a647d-3795-4c82-7ac6-08d9e3d5e002
X-MS-TrafficTypeDiagnostic: VI1PR08MB4543:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB4543E4BF2DA5B010DE4FD6A1F2249@VI1PR08MB4543.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w/hfnxfbF/M710Pl9fni/+neFDcka539zfAlerqxiyNEmWzhmDVE32yIDUm3V/5dEAORSLTYhDFbiz+D907YN1F+WYPJHHs+u3QAX18Asm59j15sKxbM05BMxxbuBRwCXaFdtYvXTz/LP9JPtjka4k2BwQEdrJen5Xp3anFO6oIIxqMuttXPvPzVBRNMf04CBiD940N09RVC3CA04tGP/ZneCZAuY1SV5LZaXG5DdG/+BDuCoFnolPylEhRMJuqK9uglqgfkfr5e6ES9xxIefY6CHYGO+iIns/Ew01/xZ2AZeH5s8sGOT+fZ7AFjw1MU3IAD6mexwi8IQP75wZBBkF6qAoGnZgllNy0LaEVHNxOlnicNisuTFnXSiRK8TmJNHT9znBH8E2FVFHmqlWYOkd8XookBKMkJEom+scalcZ3vHkUCQl3spmm9SWmo8u0x4Kh1sC1ZiLLUmVk/iLsyzKWU1u95pv5s/Cm3pOP15xHh8MBM1RfwK4Uds3aHxrr8/uBkrXQd2L0lQaAnfX3oN/FwfZdxM+mzeBOsAjxdDI6fgXh8LwOI6ILWf5ntV8388McrpgJUdhtmD0TLbfJaEQOaoTIwKOU8LLLbXMI0g0FKo686GKB9bO0dPMNutfrA9rJkwbguXE+EhgL25Jx4uF7z94eSQTsS1i2smSibD9PWnaum7tQjn+6ghw69aymHX4r4EH/7MmjM/P8zfwoujV7aKjv5EshxU45tLa7838=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8936002)(66556008)(66476007)(86362001)(4326008)(8676002)(66946007)(38100700002)(53546011)(52116002)(7416002)(6512007)(5660300002)(6506007)(508600001)(6666004)(6486002)(54906003)(316002)(83380400001)(2616005)(2906002)(44832011)(186003)(110136005)(36756003)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk85bXlpSUhuR0hiY1gyWjlWc1kydmprSk84b29xbU1hWEZmeHhFTzltSHFM?=
 =?utf-8?B?eTBJcVF3eHZLak9OdmV5S0tsRlp2VE5CTUlyN3U3TllHaEU4Rm0rTy9ESE9N?=
 =?utf-8?B?WlROUEtlNDVlb0EyU1RCS3ZienVONDh6L1lWc2xSaUdaRSs1Yjl1SGRZa0Yw?=
 =?utf-8?B?YjRqZnprOTZKaWk1Q2xwQUJNbCs0Tlh3bDhqMTh3TlRVWCt1dlNGMkR4ODUw?=
 =?utf-8?B?ODVlK0hyMWV6dG1kNnBEREdqaGV2amtGeEthZExWak53Z1dJSnZqMk9iSHpw?=
 =?utf-8?B?VnpiYTA5OG1tV1plVDloWEhUMGpyYlNoeXBBeWJKY0hhVmZhZ21CQ05veEJu?=
 =?utf-8?B?dXRJNVlQd3FvWU96cldSelYrZUN5eFVGejBRcmhYS0tsY24zVE02TjRIekFU?=
 =?utf-8?B?bnpiMlA1Tk1laHZvL3JxSkVrU1R1UlFwbndyc0lTRGpiMnRMZFB3OC9TWXhW?=
 =?utf-8?B?TGF5Qy9VMlF5aWhYV0wwQksyWEdYamdTN1BpdVJ2Yi8wTmVqL3BNbDAvTkZr?=
 =?utf-8?B?VU1mTWhZeUdQdit5eW1DdXdPNnJuSFdnMHFqUkJ5NHVpOWVmZ0VNZGNseFk3?=
 =?utf-8?B?YVpIbjRlRCtIWVk1dFBLUlFvN1ZFbmpMM0svaVNjWW9yeFRKdjlKempLY1lV?=
 =?utf-8?B?UkFpQ2gvWVFuK2d6aGxkRVVndkYwSnV5RENBdkIzR25sUlVjelQ2Sk5YcHBt?=
 =?utf-8?B?RU5qUGdSMmlKSWkwajNGNWZOdmh1cXhPbmpqWUxYVXQzdWYxT1lKdDh2UUl2?=
 =?utf-8?B?M1d4eHgwZ1Y5WS9vU1Jod2dxYmNXZEJGMjI4dTVFZXEySHNvRFk1Qko2dlVv?=
 =?utf-8?B?M01PZXIrYXY5RFlDeUdIMGh6ZXJGQ0JCSk9hOXp1YVk2Vnh6c2dXb3ZIcXpG?=
 =?utf-8?B?L2pjZGl6aE8rSGp3ZlBpN2tkTTI0dlo0cytxVkxMMS9RZ1RWaWhmZ0hMNHFD?=
 =?utf-8?B?K1hCNFJzOWZtOHVFUzB4clZqcDI2cDNPQzFIa1VvQUpUbnFKb3BTYkx6UFBa?=
 =?utf-8?B?SEh2aXZWWEdHRjVhTmNhbkFFOExPK21CeHRyMDlDZDhhb3RpWXlaRVRGZktw?=
 =?utf-8?B?b2VvcnpMdENLOFloNTBuaE5mL2xHeHMzQ3VzVTgvUVRKWkNQMmFzL08vV3dZ?=
 =?utf-8?B?dEVzdVcwY0VEYnJFUVJXU2pzaW9aUUdFOW1EajRiWXl6S01YY25UVG55bWhJ?=
 =?utf-8?B?QmNSOExzY0pWTlNjRHVrL3crS1Rnc2Rzd2hmRFp3WG52UUcwNUM5WjgyRmpo?=
 =?utf-8?B?cTJnUjVJcGRVNVdvS1l5WndlRWNuQjRmcElCaVlFd2lXU3JRRXdBV3ZTdGZ4?=
 =?utf-8?B?bEJCNnpCSTdLK1lMd2UxUjhadWlXbmMxcithalp2d1RPbVN3OHZXekc4VG1J?=
 =?utf-8?B?WldRMC9xY0loWEVSRHZ6aXZwL1N2NGYwS3dWbnp3Qnl0L0pxeGF6aFdnNEVh?=
 =?utf-8?B?SDJTVFllNW51VEkzVGk0ZVhhcWQ3c202NkdCbDUzSFQrekwwSko0L1lNdXFj?=
 =?utf-8?B?QzRDUkIxMUFKS25pUmZxLzBxa29XOTBlKzdNZHhLenRYWTR6ZEZlaG5McUll?=
 =?utf-8?B?QWR4cUV3VXN5TDhlQ1JtYmQvMmY3REF6cFY5QkRvOThXZFlxRW5Id09ZZ1ov?=
 =?utf-8?B?ZTZvV1lLbHVPV09CMnZCa204V1BVb25UQ3QzSFF6bWxnMlFreFV2OHFMQTg2?=
 =?utf-8?B?V1BLU3JRaXVYTE54N0gzRHYzTnVCOUJEOFpqaS9QWGUweFExalY4NEJVSHB3?=
 =?utf-8?B?UzJRbzlSYWJIZEJ1NWJnbENuSktuM295aDZvQmFUOU5JQXJqWmNUaTdpVFFP?=
 =?utf-8?B?Z3VWamFyS2RyZG51cVFKVmN5YkFSSU83cnZ0UURnR291MmtRTkdISjZlcUd4?=
 =?utf-8?B?VGExZnByTkxmSloxaU43N24zellwdmxMRm1DWkV5amREVlB4QmE1ZEZ3d05R?=
 =?utf-8?B?ZjlGTTdoRU1jdXVPT1g3cVJtOHoyY2ZWcUlRaVZYa1J0KzR5aWZKZjhqalov?=
 =?utf-8?B?a244RFVuTXUxczJiVGtwbERhRmR0TnUvUEZxUE12SkhHQTZSYllEWVMxaDV6?=
 =?utf-8?B?aXp0SlhGbEJUM1gwVnUyWHRHK01Od0tJNWRXUWFINU5FMmdoQ0pEOUg2a1Q5?=
 =?utf-8?B?cEQ4Z0Q0bmRsR2MydE0vTDMzL0JXUlZWd0JWSXhtb2xmYnhwbGk0UytpbG8x?=
 =?utf-8?B?QkVSOVN0TDl1VHU0alFGZDkzbm5NTFN5SEovU2JUOXpIbHZSbkM1aFBKUjJG?=
 =?utf-8?B?K0NldE1jZkQ0eG9vTlc4NFJsTStvQTI5ZitPbDloNjVOSlQwUW12TkFoWm1i?=
 =?utf-8?B?b2NYRlNxejNlTmdzdmJsd2g5M2MreFhlV0xjcEdtcnN2eEZCZ2RUdz09?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 205a647d-3795-4c82-7ac6-08d9e3d5e002
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 09:49:57.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiyzCM6efAYHYlSL36wGnwUHOOlToaE6FsDtI4jxUNhExYrdJ+vjf7oU/0sZK8eTBCYLCOEL/84Bf+me6RrHwBCKQ+5ECdyhrSI16BDejOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4543
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Samuel,

On 1/30/22 06:38, Samuel Holland wrote:
> rk356x contains a PDM microphone controller which is compatible with the
> existing rockchip,pdm binding. Add its node.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index a68033a23975..f2f3cdeab0aa 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -651,6 +651,27 @@ &i2s1m0_sdo0   &i2s1m0_sdo1
>  		status = "disabled";
>  	};
>  
> +	pdm: pdm@fe440000 {
> +		compatible = "rockchip,rk3568-pdm";
> +		reg = <0x0 0xfe440000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru MCLK_PDM>, <&cru HCLK_PDM>;
> +		clock-names = "pdm_clk", "pdm_hclk";
> +		dmas = <&dmac1 9>;
> +		dma-names = "rx";
> +		resets = <&cru SRST_M_PDM>;
> +		reset-names = "pdm-m";
> +		pinctrl-0 = <&pdmm0_clk
> +			     &pdmm0_clk1
> +			     &pdmm0_sdi0
> +			     &pdmm0_sdi1
> +			     &pdmm0_sdi2
> +			     &pdmm0_sdi3>;
> +		pinctrl-names = "default";

I think the pinctrl properties should go before the reset properties.

Apart from that this patch looks good to me.

Best regards,
Michael

> +		#sound-dai-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	dmac0: dmac@fe530000 {
>  		compatible = "arm,pl330", "arm,primecell";
>  		reg = <0x0 0xfe530000 0x0 0x4000>;
