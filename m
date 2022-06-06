Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C953E9E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiFFMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiFFMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:00:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C1E289706;
        Mon,  6 Jun 2022 05:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbX3Iln1kVFv14PyTGPSDAlA1Npt5DPjVV48nh9H/q0fznF9tdxzv7rxUx9kYE/RunsOm99HhyXihDOMQNz/F7vaJ/kjk76WfKTXusG0PaR8UFYqsJMuN1ksai5hpe8GsEMAWp3LjjMQyHAiJc4bsNFVzgU0XIqANIPlk0Wg0XTTLfuQqKNN2HjgZXwiLXXQx2BouMybjaU4gdPek0itYxTmKbnzSjjZIPOPlaUSwTJOsC2ic9MUTtwveeyF94+F6NFKBQ3CZoIfY0fptg//uSma5ZLbE8EKxSZf+eObuVhNVwBpzfhxIFw39R55rPN8M+D5YUrGJteLlbaQSoSB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I96350oxisszH3c3wUce1Q61Z4XaDUfhIQ5p4hJ8tUg=;
 b=IGIHcvZjCF8yCiyLivbgJhi2qCDmaFHCTEk5CPY23+II/S56/ciwuteSx5mAqIHXR6dpImj8zYaIk3jHIsnkTDDVKXNmYqvgxp150oKOoY4L34ioAODA6cqLFrQAQfc8PC4cFtPnqNVrH3lZM97y5ZBMsj7LvKUTGCWi77eDSGM6smvBYA7ATvXyhEz36JUTVPFoChgp3rC0J2RvvfISKTctP/XaoK5DAKQmH6NbrkdASPIzagsOxgtISg0ao2ayK1S3R0u2UoHP0ayZKo1qpWZcwCrAWhcYikwM0VhXv6W1VVVqWaKWD9WUB75thlDX+4jh8H4oDtUkcS5LzECJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I96350oxisszH3c3wUce1Q61Z4XaDUfhIQ5p4hJ8tUg=;
 b=NXs+svTFguywpgl8tQc70hYYgrpsRajFmuJoLzCA9bneBUl9P0DkmqpyC3ywFDCNSFtMBAbgr9wqPBsK62NEVVzx1gNXuT54pOS7K73vQqtizImznETFAX+2BleY49p+dXOhp0LIRrUo2jZTIp+AgF0Y4mOfQFkoi1cY2+Akguk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR08MB3503.eurprd08.prod.outlook.com
 (2603:10a6:803:7a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 12:00:40 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2%3]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:00:40 +0000
Message-ID: <4731d47f-ef02-d512-c599-274f8208f845@wolfvision.net>
Date:   Mon, 6 Jun 2022 14:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-s add more peripherals
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Akash Gajjar <akash@openedev.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220606082629.79682-1-sjoerd@collabora.com>
 <20220606082629.79682-3-sjoerd@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220606082629.79682-3-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0190.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::17) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efa897b-835c-4655-7585-08da47b42d39
X-MS-TrafficTypeDiagnostic: VI1PR08MB3503:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB35033FD94BCB607F35900AA6F2A29@VI1PR08MB3503.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMcbqtXpHKFcLAFXYotEo8sPkzrKQVMrHsDGKhobYTB4iKelt4ZAVcBTBuwm4teub+hEbO7akn0tg1rWcR/FuT/TBArSsN+sswKDOjZ9TJwnGyVzVHlhEklx3qpx881cT8iizRYI/fvGw2wNXCjPMcStx8//0lXO0a2GcnWxjx8+MUtiBP9W0M4L9blFATHJ3s2JqH5OavMkzV3zRHX1maZzeXy83Vu359ruDPzT49JrNNeIqjBmrdrb0Mup3yRy0o5w18L4SqNAdjT5bQlXYK6v4IL0SeeFc//uIqSMievqrP0F3V+/i6NYfRixZPX/6wiL/W/zvRO6ejDSZWG7OdDzojz6tMLc8KarELDh6HpWUURALZmXgiJn2w3tuijlUOT4pusbiSlnQap3pfGT6QQWiW7uSWHnlpLSQBVJKLh0NWQXumqRWj/fhk/72y6lLMqnr60n0LrtaMfYDAc8t7BQfg4nynSvdcjgNyN/2AEOCc7boO9Hmsb6XONm1ssGbDZY2Hc/iTE6AdCe/qUeB0D6rsczuzUt18E6YE3yn0zZPQK0XTXqsN+oK5NmDTK1QpUFwhH7mt8x809zWZsiTEbbLz5udUpp2hFckF6TDVL5oS5OuMyxs/fs0UA68to/iVjtxShvTpJYeavzCsJB+aKAtNKDkXN+p/3es9uWXo4oY6usyHP9D+AmH4kIFi1IYlpZNCwK5glzJZC9uY5KO1SIuRhKgcEHWVTsEl8LRa1LvYNgPo0eei71CFBeq7yj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(54906003)(316002)(4326008)(66556008)(66476007)(66946007)(8676002)(186003)(31696002)(86362001)(41300700001)(2616005)(7416002)(53546011)(6506007)(6512007)(508600001)(6486002)(44832011)(38100700002)(5660300002)(83380400001)(8936002)(31686004)(2906002)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xobVhxaDlmMWUxanVRcm1VV1FSL2RzcURnWTR3RGNqL05DUklOOGxhak8y?=
 =?utf-8?B?ZGtGL3FPbjIvRnhPcGJXbWVBQTI4am1adjc1dzVPVUVramNBcDBIbTFRaE54?=
 =?utf-8?B?VUljOFcxOUlhbDBuZU1qckxGU20yNWgyNTNqZE1Mb09RVXJOemt3eHFlY3BR?=
 =?utf-8?B?MEpjUURPTGFhQnNQU1Y4RjlPT2tMNU5lekpwL0poQUVsVUhuZ3lIVGxjL3F3?=
 =?utf-8?B?UEtRa3o4VFJpcEVWY3lWTU1QR2prNlczUDMrMU9zczBqODE4VU80ZjNPdFp0?=
 =?utf-8?B?ak1GT3hFQWhPNmQzbnlDUHlKKzVCdElIVEhnSDAzSUkza090c2FVUExpYThw?=
 =?utf-8?B?UnVvQmNiYmRyWUhvbUFUL1ZGcnlrazdTY0RRaHJWUCtudmZUeUFnSjlCczVp?=
 =?utf-8?B?R3NrRU1ZL2VERXI3aUZZL1B3aG5PdXEzdmFzcFhMOEhCdXpGMGtvVnFRb1h2?=
 =?utf-8?B?VTFlbUZKT21sM0ljaTY5RisxVVpyUTV0bWIrQUYvWTVkRnNBZjA1YUpmZ0dP?=
 =?utf-8?B?V2lIRGF0ak9iejRqL0xKVEJWYWQ0UWZSYkV2SmcyZXR1R1JtTlJRYUJZNWNC?=
 =?utf-8?B?d1MzNXdMcXEyc2xkcnlpY2YxZVh4WUhOQ3Z5dFlLc2NyOFBVdmp0WlFEdVlF?=
 =?utf-8?B?dkxvTUh2ait0amFabXlEM0RZSURCQXk0NFNNWXBnWTFQM0luQzFnSklFQnJR?=
 =?utf-8?B?VzRmSHVwQUppeUNnc0xGTmVuZmpseFB2RHhVb2JRcTJYTW1ycTdlQ3lJQ1JZ?=
 =?utf-8?B?RWlpeSsxYzEyOTF3TUtNTFBJV1BnL0ZQaHNFTnB3UFBJSUhsRGxpeDBwa1E2?=
 =?utf-8?B?UEVFemc2eEFRT1c4SXFYc09QZnBEYnB1TVBTNWZSN21LVngxbXZxN2ZmVEpn?=
 =?utf-8?B?YUUxS1B0blpCLytPckhUUW03WWhLanZzM1V6ZjZscEdtcnVlTUpQK3Awenhi?=
 =?utf-8?B?U0o0Q2RsRjRZbWI0VDBhNzJBdXVZZUliTHpodEtYQmg2V0VtbDFmUEFKQ1M1?=
 =?utf-8?B?ZS9oUE9Td3R3TG5xWWdYRSs4eHBVTlpsZXQrR1c5cmFCbFN6cC81UkZleExq?=
 =?utf-8?B?SHFlYlJKRXFxSFdWNUN2MmF2V1Y0SGh1d0xSWGtleDVnNm51Y25oUHNCRVNK?=
 =?utf-8?B?RDA0UEkxeDlTekFlaFNOSktVVjdwaUhCZ2RKaWVxTmNkTzl0MnVQRUorUnl3?=
 =?utf-8?B?MTlNKzduRTJLa3A4WTlIL0lZRW5XWU80dmFKdG1pcitlMXRDMVpjOWJraE1R?=
 =?utf-8?B?VG5vd0NjemdKdXlsZGo3bVo4M0xEUS9UVGorVjJGU2lINFQzZGdrQm9Yc1Jt?=
 =?utf-8?B?RHNDK2xOekE1eEh5ZnMrcStxRlMvNy9uZUF6YzA0RmE3MXdzRkswaFdRNU1w?=
 =?utf-8?B?V0JYSEFMczVlZUxpVjBGQ3ptNUJsdlEvUVp6RHRMUFpiNmRZeHIwV21NN0hD?=
 =?utf-8?B?VDFBVGZZY3dBZm43VGJJYi9SalZmN01RZ1ZUaFJNTWpwMmxQUnlkY0FDa0tT?=
 =?utf-8?B?ei9mMjI3S0pGYUF1MWFPYnJ4ZExDMG8yWFo2MVVMVERWWUNQL2J0VUhGVk5Y?=
 =?utf-8?B?K3ROWEVxakluY055K2ZBOUovTGs0akZrbS85L0p6T1ljZ3BtTXkxMUNWTkZE?=
 =?utf-8?B?SU5Od1RtdnQ1U0s0RlN1L0N2MjkrY0tudm9zbGcveFZWODN2ampiWjZDK0c0?=
 =?utf-8?B?WXkxd1hDYjNoMkkvNmNXanNzQkUrc01lcjRKYklCemQ4bFZ2MXRZdll2cnNr?=
 =?utf-8?B?Rk11c1VVTUxPWm1rV0I5OWhIUVh3ZFpqQVR0bExlRDN6SjdQSjArMGcrNk1z?=
 =?utf-8?B?RDgzZkVPSU9tOHNUWi9IRlJrUEFacDVQQjNIVW5Gb1g4V3hmZ3Y5QVFIWlQ0?=
 =?utf-8?B?UzU0RTl3Z0VoRzNNK2hqekh6dlh5Sm9ST293anBKVzhGS3NnQm5zeGtwem9w?=
 =?utf-8?B?R2tpTmM4eS9NbUJ1elJ5VkxRSnlSTEpra3p4RERoZG05U0F4eXA2dkJGNStN?=
 =?utf-8?B?K2YyTTBWWUd5alZiNGtlRmthNU9qOEp2LzVJWU5pUTBnd280b2ZTTzV5bTVy?=
 =?utf-8?B?N1ROd3R5MWt6RUI2YlR2U2ExcGtNWGpkamkxOUR1ZUovSUs1RGpTeENxd0M1?=
 =?utf-8?B?M1VMSlNrMVRRYWlRTFI5amhUQ2lQMVh4UytlUFZYQUNOQ1BTVUF0NVBDMVpY?=
 =?utf-8?B?UTFmWmpnNUp4TEk3Z2gvbVhtdXN1QTBFOWh1N3VWL2c1b1hqUVRKSFZxYVI4?=
 =?utf-8?B?UEsvaXg2dkcrYTJSWnpGbGR2K2F3Q0xuSjF6eCtKV2h0RlA2Y0tvUExIY3JR?=
 =?utf-8?B?c0dRa09DWkRkOUc2SFJ2ZkthZ3V2bzhtejEvUThJZWMvRDlTUWJLMitCU2g0?=
 =?utf-8?Q?Euq7jwu7VtpAMK0CY93CdEkLaDAXEspjMi+moS1lq0hTO?=
X-MS-Exchange-AntiSpam-MessageData-1: H+wfHHzRdobWH4hzg3yIt5f3huFytxjRArOuAD6sln9v1FYhdZ5hbK3W
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efa897b-835c-4655-7585-08da47b42d39
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:00:40.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxQITGkk8zltpXHzo9honUop0LqQvN3ChSQf8CwfuHnVq+BGrtgFAiWks6qdyqw5dJApIvy9/f6ubq/7qCwlp9luA3kVYY/fUamVzkpwv7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3503
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/6/22 10:26, Sjoerd Simons wrote:
> This enables the following peripherals:
> * Onboard ethernet support
> * Bluetooth
> * USB 2 port
> * OTG port via type-c connector
> * Hardware watchog
> 
> Also add aliases for the mmc devices and the ethernet interface
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
>  .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> index 9095efe25ccd..46ba48b843c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> @@ -11,6 +11,12 @@ / {
>  	model = "Radxa ROCK Pi S";
>  	compatible = "radxa,rockpis", "rockchip,rk3308";
>  
> +	aliases {
> +		ethernet0 = &gmac;
> +		mmc0 = &emmc;
> +		mmc1 = &sdmmc;

Sure? emmc is at address ff49000 which is larger than sdmmc's address
ff480000. I believe the aliases should be sorted w.r.t. addresses.

Best regards,
Michael

> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:1500000n8";
>  	};
> @@ -132,6 +138,15 @@ &emmc {
>  	status = "okay";
>  };
>  
> +&gmac {
> +	clock_in_out = "output";
> +	phy-supply = <&vcc_io>;
> +	snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 50000>;
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	status = "okay";
>  };
> @@ -195,10 +210,47 @@ &sdmmc {
>  	status = "okay";
>  };
>  
> +&u2phy {
> +	status = "okay";
> +
> +	u2phy_host: host-port {
> +		phy-supply = <&vcc5v0_otg>;
> +		status = "okay";
> +	};
> +
> +	u2phy_otg: otg-port {
> +		phy-supply = <&vcc5v0_otg>;
> +		status = "okay";
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
>  
>  &uart4 {
>  	status = "okay";
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723bs-bt";
> +		device-wake-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&usb_host_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host_ohci {
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&wdt {
> +	status = "okay";
>  };
