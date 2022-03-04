Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A14CD903
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiCDQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbiCDQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:23:29 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40081.outbound.protection.outlook.com [40.107.4.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFA13D62;
        Fri,  4 Mar 2022 08:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGQC7kQo1zW9M8Ne1o7/4lUediLa8UGv9n9yxqbvGoqla4dASkGvzgrQwg/vsQbZtEfKK6ntDCsCXxWD+pqOBQZ1gBEAWhcVoG9ut+ue3uzwPaU+iLA4D0wnwDELPSmdqami3zFw0qJUhsvAV6JwIj+yEBfkdQ4YpCiLjgPzI9MhMx9XquMLY5FzzoPcgeouZMwGpUl//6cIEmvj/vRCfCP9/HnmPq0a4H5mUfQ1y73fXmVnQaXiVj0cAH+ol/90blOKV1WFaD8EhvHG6rt9NasnVXfcVK1hMnFHH8V2ET9SUynrUU3zB8ERPdt6fuO7ixVUz8Ti/tqqweIgeuvulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8PGr/WVBvb7mExb0aKyjvFzoxUEcjfE8jlPI5qzDZ4=;
 b=G5b5fo8uj24vbmyWK8WmFglVU1GjVWgsNrdz5Hy3WPTf4RJrtCGDGajyWtX85mO0giq29DXz+NXmX8eY64K1KePj2ItXdWJGS9wfwCF6yMoVZu6IngdDfqhRo3oX35LBY27hrDMN9FCH3ZnCntW0G5hWSLH6rNrgWjFVnxYT1eOVOv1SUdciu0SNLRFAWdIUgw+HrAy+qqzk+6lpMWwdJ7hX7Zc0VIwUAX+M4rajZro1XfRqg8eAXsFqKxTQS5TA3tWfJsWwjK1brjBKFQ6KwoEpnoS8jwP+XkX8PrpK1e4AdGWTDoTkUKNZXUhvXJDU+8EVwe6qMCFiBV7CNJZwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8PGr/WVBvb7mExb0aKyjvFzoxUEcjfE8jlPI5qzDZ4=;
 b=h0TF6cVlqvdGz+97sfwyIeEyic8Ci9ba5Az8WvZxXyureVqF4RaoGVlb+jzgh5wRixQCgWI+wFxeavF9n9LY9UdzX81S5UFnQ8/L5OlnkCkJxyZUTJUJld/624Q4oDNT14pHcGBHb3QlyFVQTmC8xqUb7b7xWxHuWh8l5D7UnoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM5PR0801MB2084.eurprd08.prod.outlook.com (2603:10a6:203:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 16:22:37 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.028; Fri, 4 Mar 2022
 16:22:37 +0000
Message-ID: <4a20924b-7040-bf18-4fa4-2bda8d1bf974@wolfvision.net>
Date:   Fri, 4 Mar 2022 17:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add basic dts for the radxa
 rock3 model a
Content-Language: en-US
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
References: <20220304161130.34977-1-michael.riesch@wolfvision.net>
 <20220304161130.34977-3-michael.riesch@wolfvision.net>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220304161130.34977-3-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bb2ed9-2932-4cb2-406c-08d9fdfb325d
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2084:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2084022A624FA8E70E655AB9F2059@AM5PR0801MB2084.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akIWF7sULMPyPapHD9CaRbM0NSL/1/OtWJ8WR2M4Yo8ZPWgOgnhIid9hDvyCy0+pHiRRssZ3fWDDcMRsNezBTCOc8i2e40cWP9tCxATz/BYH1khDxWMryHFyvVHYKpbZSAD2G6CmtKIHR2Q4jkp/IKnhAX/iFKzaX2IjGa3M9CpnZuDDzRBpu0HOUq6CJ/El9BxsJS9UFjiZQSGOLiMTXR8azcpSIxPEsHmWCNJCnLQ+IW5DAreX1+EUUmJ1fdwVTQYVo8/7i/tEyBhqXgkb6DgO6FOwRaGNHuqkimN6sv0UscA9NjKC/1Lfr75F6NcwcwqTsB/os8Hu31RNv/b2bibN6QAG7iwA4DeolBiMGXNyB2NMVxybmzyCNx1+9EkVII1bO2crIyfnzEru9PJwo/OaOJrVbA+DNgrFI9xRtxirsqTZNbzd5ygFVIcOXm2XQsAgdMbj/yJC3mLC/w/23mWVcHlD0koLmuQu47P07Ig0zDUK2NbRSkzhQ85RImDL5TRrltkcSppJXlvQP7nVA8RcwacGYN9IspJU1QojTgsNxoVOd6PEzk9VEvBA3RsEzF8FZlclM72PcFM/2K7cDmGfICVWDSCVwl8xzRExRGnt+DT3sTW26HGN4zGFgQHM7xTdIXJZiuzg/Rhi3VVP9mFA4nIyBexT6S4gwMkpO+4tePLIZ9+ouoL1RMhs4DFlOUk3TIYeN6Z0HzXctQaZCa1iiFvxc/pa3l5nUVjFwWyQgNzGBCNhEvWbky4eAg4XwMwRGZvRV/Bc8lgRUhjsNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(376002)(396003)(136003)(366004)(346002)(4326008)(508600001)(6486002)(66556008)(66476007)(54906003)(31696002)(86362001)(316002)(186003)(8676002)(66946007)(83380400001)(6506007)(53546011)(52116002)(38100700002)(2616005)(6512007)(5660300002)(30864003)(2906002)(7416002)(8936002)(36756003)(31686004)(44832011)(129723003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWh0c2dxM1FySmsxM1pJYW4zejZRYmQ0bEhReHVOdHN4QzJ0aENyUUsrNE1z?=
 =?utf-8?B?T0dYYkNva2dSMkwvVW95bVIwODBVZjBjRU9vM05Lb0JKaERRNVgxaE5BK013?=
 =?utf-8?B?QXVOZHVROGdrdm5TUGRSQSszYU1zNVUvSENSZGFDRjV3L1hvemtJRS9hU3o3?=
 =?utf-8?B?SGVzREgwanVPVnBOci9IajA5Nk5UektzS3U3a1ptSVNncFVYTHB3dC96b2dz?=
 =?utf-8?B?UVd1WmI0TllOVnBKV3F0TjlaVjFJNXZDT0dDcUN0cEtlYk1LYWFTUTFuc3RD?=
 =?utf-8?B?Kyt0R003eWk0SFIvVTd1SXJmdjZBSWdFWlhnY1ZMZFNzNVlvdFh3dTJmSEJ1?=
 =?utf-8?B?Q2EveXFCa1hlMXVmQ2IrY1hHRkRMMDd4bkJMVUExZjVibndYR3VhRUpkb29k?=
 =?utf-8?B?ZmtLSThRUFhyUjBlV2VxN1VUcjQwUEJMcU8rd3VhQnNmQ0JlMnhHaklYc01X?=
 =?utf-8?B?dWladDJTL01Zem5Va3F5bXdZQk5xYmQvaG5KL2o3OS92UExRMzNBSFhIOUhw?=
 =?utf-8?B?KzRSQjMrVkR1NGtKYkY5NHVPbWc2TVpUaHFrRFRJc1BPN1VCQmUyU2dDNVM1?=
 =?utf-8?B?eFV3WVByaERtaHR0WlFtRkcrL21PbXBGRHJnZlQ1UUh1RVB0Wm5LUzNaZlZN?=
 =?utf-8?B?c2xreEdveUtDalE2emR0Q1lkNzFXeHdJend3NzFGMG5hL1grTUVqejVGRUtX?=
 =?utf-8?B?UmtoSzBQUzM4VjlGUm5jcWRmek9YVDh1azh4ODYyTnhNYklIbU1kSUVJVU9x?=
 =?utf-8?B?NldmRllNM00zUjYvamRVS0FvRThRbjlFSExiOHhBcHVDSWI5NG5zZm52UUc2?=
 =?utf-8?B?QWpCRHhOS2hzdkZ5TEFNbXZrZ05rMzRPWk5TZWpqTnUwYWtMWDJ5dU5mTmY3?=
 =?utf-8?B?czhyRWdIK3JTOUlEam1uaDRFVjVLN1Vud3hJZWFUeTZrbUIrOVFoYklJMndJ?=
 =?utf-8?B?eXBOZDVkK3NuNm5aNFZBQnBXNWV2T1JVRXJncDd4THZsUnczVGd2MlUxTXJi?=
 =?utf-8?B?U0lubWNzL2dLQWdvQ3oxbmZPaUhEZE5MOTg1NVBERjNTVXhaS2FhRnFJMktI?=
 =?utf-8?B?bEtXVzBPV2NtNlFyS1BZb0tPazNqcTB3aGJ6ZlNyMnBBQlJXUmlCMVRUbU10?=
 =?utf-8?B?SlJCbEVKcWVEaHBkZFFMYTNjcWtNc2w2WDN6OFFvTm5aWWVmN1ZYb2dmUWx0?=
 =?utf-8?B?UldlKzdmY1F1NEZDUlQ5a2JzT3k2N0xaOE4yOWJ1VGxPL3ZRL01kWjJBN0Yz?=
 =?utf-8?B?WklJRjRoZEJRa1NpY2FEa0tFckVhYnRGTjBYbzIweXp2aEZHNG9kZVFIR0pt?=
 =?utf-8?B?bnpRSDBxL1lMK1RPQndnYmljZUd2bm5mNTJ3M1JCOHE2RS9HeGFUNmMwek1Z?=
 =?utf-8?B?akxOL0haSHdtbjFVMkxNVlNybzUrYU1NeDFXS2dNTDdvS1I0WHNmTm1wc2lL?=
 =?utf-8?B?V2ZZelY1RUR3MWpldUNCNU9nUXM0c2h6TnNNeU83ZXVhcWkyUlJad0Z4dVEx?=
 =?utf-8?B?VzdPQUppMEJOL21iZUVBSEZWMU5RV203M3VwVGhpNVlWbzR4aUp2TGU3QU8r?=
 =?utf-8?B?T2tVZ2lhVTFtUDFpbWtObFpJMlBBSC82Um5yZHZjSWg4c2M0TWh6bDBLK1Ax?=
 =?utf-8?B?b3dkU2NmUlZOUHErRVpnWG93RGhFaXZMb1NRNXFSM3dIL2NqNS92MjYvZVoy?=
 =?utf-8?B?MHZzSDJIcElQY0d4L3U2NUFtUy84Tkk5eitQZ2g3bkNKL0ZTUmJQVlNmb2J1?=
 =?utf-8?B?MnBKbHRTK2JIb1R1NXAvbWZCZndhcGZHK1dBR3Z5RUJLcG1aeHJxMG9pTGhl?=
 =?utf-8?B?T0FheSsxZTQzNTBLSERTWm9oVWJSUUN3d01iT1VpY3FFNmg2VG0vaHVCeEIv?=
 =?utf-8?B?OFZTbjNXeVlxTHVacC9sR2lXajBaWTRIWTBJcE5jelQ4bi9mM2lJRUUvUGZx?=
 =?utf-8?B?Vm5LNmJsS3VFWFA5TkNUbkFWTzVCK0lwSzhYbmdFWGZrYTVacHFaazhBYUlq?=
 =?utf-8?B?bkFiNEtEZjhMZitUSEVqOXFDMHRnN1IyaCt1anI1NHlMZUVmMklZOUZuY0g1?=
 =?utf-8?B?dnd3ME5nb0NuL1RhSnpmU1dqTjEzZ2YxUWNaMlhFVytuNm9tRU5pOGZXcjhC?=
 =?utf-8?B?UTdhS1FZUzVDOUZHVmtLcUY5Z0JCZGFLWUE4aDEvazNYL0dpSXZ4T3RIelBU?=
 =?utf-8?B?c1IzZ1JiWVQ5OWZQdkhST2xWWVpxbVVXMTg0Qm45bnVSZFhCWk9VZFJyQ0Vu?=
 =?utf-8?B?SWFEeVhBQ1FTUkpFTDFZMDR1WHBrN1ZzMnMwUzFTQ0I1c2F1Yi9ZQjN0UWJN?=
 =?utf-8?B?UXA1TmlrU2NpRjhYU1Y3NWdWb3grOWw2Ly9FNlJwbWNwd2Q2dG5hZz09?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bb2ed9-2932-4cb2-406c-08d9fdfb325d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:22:37.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IPDWSHcCYAdd9Iyh19zioF5KkeXtpBX4av/wYwVLh2NCWjN9u6GGvG6S/lubK14DQoFuGFdZ33zLoKfsEmAFQLrVJxdksE8oWhFugUfPjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 3/4/22 17:11, Michael Riesch wrote:
> Add basic device tree for the Radxa ROCK3 Model A board (with
> the Rockchip RK3568 SoC) including Ethernet, USB2 and headphone
> connector.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 501 ++++++++++++++++++
>  1 file changed, 501 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

I forgot to add the dtb to arch/arm64/boot/dts/rockchip/Makefile :-/
Sorry for that, will be fixed in v2!

Best regards,
Michael

> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> new file mode 100644
> index 000000000000..18d2d8e5e693
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -0,0 +1,501 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK3 Model A";
> +	compatible = "radxa,rock3a", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_user: led-0 {
> +			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_BLUE>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_user_en>;
> +		};
> +	};
> +
> +	rk809-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Analog RK809";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&rk809>;
> +		};
> +	};
> +
> +	vcc12v_dcin: vcc12v-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_usb: vcc5v0-usb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_usb_host: vcc5v0-usb-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_host_en>;
> +		regulator-name = "vcc5v0_usb_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus>;
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		#clock-cells = <1>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
> +		rockchip,system-power-controller;
> +		#sound-dai-cells = <0>;
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu";
> +				regulator-always-on;
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name = "vdd_npu";
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name = "vdda0v9_image";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name = "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name = "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name = "vcca1v8_image";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-name = "vcc3v3_sd";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		codec {
> +			mic-in-differential;
> +		};
> +	};
> +};
> +
> +&i2s1_8ch {
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&eth_phy_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	ethernet {
> +		eth_phy_rst: eth_phy_rst {
> +			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		led_user_en: led_user_en {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =
> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_host {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
