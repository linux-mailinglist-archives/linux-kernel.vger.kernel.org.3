Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733AD51FB70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiEILmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiEILmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:42:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2116.outbound.protection.outlook.com [40.107.21.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A356820CDA9;
        Mon,  9 May 2022 04:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlXWlvlEkBi+9tkDhDB0ILvq4dfRKRcD9zsmHjP4tvV+Vzo44wVTkPHK6GHxgfcNUKcVe2JII4ZCYRD41Mfb75T9wvT2RGrOB3c/OBOKNyyOSSkJcsgTLSAAi+a90azCjTvVkQVSPHUxGFbfriZmSYif9+InMSoEkcPiwTi4aDZZ0b3GTCSNioL9OXIzD084LJ979LKaFZgWL4IAsJnqleqMCi+IqAG93dyAoWSqIJ4reb8sbjhkcBJAxYVbxQ4H5at9T6YJJK9NXcRSk2sexV4FjDwPqKzAV0Z0v2h2V2Fh6oeTzYsZP/DkI43WBFNHzY13KrRAwFmjPQ1hL9GdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Q0VKmDeqa+7sFmo9KArZJV8z/bbuwhMQspU1NTDHo=;
 b=kBKlyAuBv1JLjli88uWqA9UF3v9UssA8Qf+CmlPZPf6+/RAM87Xv/nM2m3N2zaGElNBAGrqk5LcDyrHOTdfdbe2VCwkkzJ8QoldqSSR9y5nEHIqm6AFReDQ7LMBZDrS8eonGObk7hkeaRaUpKgF9TWchuItrVjcr0fUWTct87qN9hrC7icgdeaMJhF8jephv6ejQe9s1dyhLVPj94S9P7t3waalswrfXy5As12LhPrR/im4+vBd5hB5wVW5FxMPGAXLCqFh8CQoH17wQ5hgkmzqk8Fetw5e+9X812xOvRRYAxMOkyjwsWAL6PDKg/AByzBvFR2aZjtLV9FvUSfmTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Q0VKmDeqa+7sFmo9KArZJV8z/bbuwhMQspU1NTDHo=;
 b=HiHXzJ6KxxCxfASd+trDBwZ8bY3/rmcfd9qPgFiEhjzoMRbwVbYifuqVxGGS2+b0pxHczbozEsgQmOLoqS7RnjXCrA2Rz3D9SDbhaXvryPjIRfywBhwI9VLNgkitVxG+/+Nb/oiWXJnhQ+KNGSvpuFSepFL21xqTDKEoNknLS48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR0201MB2317.eurprd02.prod.outlook.com (2603:10a6:800:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 11:38:02 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.028; Mon, 9 May 2022
 11:38:01 +0000
Message-ID: <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
Date:   Mon, 9 May 2022 13:37:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0048.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::17) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcffb87-8496-4240-21ba-08da31b05f9e
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2317:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2317333BD75A26BBB40D0EBBBCC69@VI1PR0201MB2317.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrAZJl7WVrI+MG+PgbyKA+RYeYdOtHxub+HXfpR89LUPwrtR4bmjGmxn73r/bgfd6RaDWq0v2lcVgLo4c9g1zyFCLb6UsxfgVv5Dr15JrsFYtKgfIW6zQnymM0YcgdTBrBd090Cur7bOEKBWUWD8+lDAa1Ate+ADNFH9OxSjb/VRTg8DI0UxxajiBFSK4tg1k2y1ksOTblzm8HaSVhXTZCzS+JlpXXtwLBbtzBLfdGVYMqz0Hg6QbxGsdUkcpu8ELOE8jaweu7mJZV3h5sPrhXiALqy6HXdN2Onxezvnil6grXdMhYjiPnSM8lSgu2aiVNaAWm1jJlSVCFex7gLpKxt7B2tguAR2184qKqt3XmN5hU+Wg5gcQlJRMmHj4KLLkUZcDfK8fLhYzM2ACopJ6tuZKZhRABfHXjiFxvCBD1T6MzrEm//OA3S0Jq18pVMxj7wxuU95OsvajTzRyfvfUED5OFtGx3OIrDyAKPk5wctZvipsRm6qwpllv2bUO9Jp9AR14T0H8lFem3NS8/qs2XScu4TudWrknhiUw1B3H2lbUhj7XG7vwHG7ZNTAXz8boyw0C7UQK5Zeut9v6wNaIxD5kvxuN12vTdHqX5niNm03/qu7Ka3p4EZ20+9Z5DZkldAHKi0CGFNV032JT+ipFLjyki4iSiMCVERfpB81yCkRFRC9rqEahjs3f8U3V2AOCGgp1XiySgERi2AAT6OrDmTr6t7SUikbCOfdB+hsh9cD/oDQJ6p0GqLsfvJGf8ni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(39830400003)(346002)(366004)(396003)(86362001)(186003)(26005)(31696002)(6512007)(31686004)(38100700002)(7416002)(5660300002)(2616005)(30864003)(8936002)(83380400001)(66476007)(4326008)(2906002)(8676002)(66556008)(66946007)(6506007)(508600001)(36756003)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Y2MTFycGhOam9jKzBBRkFPNDRSOWRxdkhWMGRqUS8zT1VRYmxOU3RWOWhx?=
 =?utf-8?B?U1FqWC9FZEt0MEsvUzVuc2Q2Slowb1JaT3phWDlDeGJoNStTcEtleG1hT2Zn?=
 =?utf-8?B?ak5ndkpXTGdMK0phL3ArZ25ncVNjWDNGa1RNVmVqRnl6ZW1aT1E0MDR0dmxo?=
 =?utf-8?B?WHpYT0lIb2FhZGpZN3VtcWc0WG9FbXNnVVQwb24yZzJwODBsYTNVem8vbHZu?=
 =?utf-8?B?U0VUQ3RpMjM1RkJiMkYxL256L2tiMSthSWpJZ1QvYUZZUjN2V2FRZ2Z1c01v?=
 =?utf-8?B?QzhtdDdYNFZaNlY3VW41QnhuTXJYQnliS3hXY1ErdjQrRUlsSG45U2xwYyt1?=
 =?utf-8?B?TTBXbkk2Vi9Wa2ZnT0d6UU1vWE1DRXRzZUtSdVE5YUppT0NJeGZjc0xkSEZn?=
 =?utf-8?B?cUpyemF3WmdnMHhwZ24rVU56WEdzcmtBNFAzakNpRE9XTlJiWjVwVmY4LzN6?=
 =?utf-8?B?c0ZGZzlUeUNBSnlTM1hXUktweTlrekkyN3RiZS9yODJsQ3NlSHpkS2VsVU5l?=
 =?utf-8?B?OWhxOXJrY1R2VHhKejJoNnhXejQxL2c5SUpqMTJsNlU5UkkzREcvTitkbjdo?=
 =?utf-8?B?SytjSEZBYTRJWFJxVmxTbFRxOVNGOHAvL01BQUgzc3pXZW5JNzl2MjR4QlVT?=
 =?utf-8?B?bmRxSHVpOHlNRnZIUC9QNk9RRlZscm1QZjRZcjE0aUE3a0t1NThST2wvUE5p?=
 =?utf-8?B?eU1YczRKRkk4dE5mSUxYQXRMTTZOUmdIM3QwYjRnYkxHdWtXOVh2L0FGRVcw?=
 =?utf-8?B?eUdwaTN1Q29hZWlKdUFSdDdtNlRJd3EzWGpJdEE3a0FwNk4ybS9XaCtVWGF6?=
 =?utf-8?B?UDlQU1BCa1d5ZE1PVTRoeTBLeW4zMXM1SGR6WG9XK2gzT2FLMnRDZFlwU2Jy?=
 =?utf-8?B?djM3K1BPTXlLaHIvM0FuMmVhV0JzMHdFdzN5cTVIaFFvZi9xVWcrYlJiWlNN?=
 =?utf-8?B?QXBJSjFrVWxBWEpHNmJjaXJGY3c1b1pWbEhBQWVhL0p3T1h3RlJoTjl6djQ4?=
 =?utf-8?B?cGdobHQyYmlRSE5SSzh1eS95TWREY0xyYnBDL1pLWE5QUGZnOXB2QVBqZnZG?=
 =?utf-8?B?QndlUjM3TlIyRHhUY2dhMjNpY2NuSE93dTZpNDA3VVhyOXFpVm12SnJ1NlNU?=
 =?utf-8?B?aHZGaC83YXlMb1JFV0FSeXc1ZUlBUkdnUW9XMjlFSFNBM0dPMlBZVXBuQVJh?=
 =?utf-8?B?L1FKRElrREhzdTdnSnd3QkoxYTIxQjBNUjZ3YWZQZ1c3UlprNE9aMTBzWGJ3?=
 =?utf-8?B?U2IycWNKR3NaTkpielExSzhmekV4TDhDMDZqS2FaZkZYNFUweDk1dzkwQ3Rh?=
 =?utf-8?B?V3VIMHI1Wmk2WnpBU3ZpcmZRNEFxM0MyQ0NCbnRwTEpLb2N6akRURGk4Uloz?=
 =?utf-8?B?VVE2R3hYclJWYzJ2dWZTQ3lkaGdJU0s4M1hjSjB0RWpyVWtQcDRyclhvQTBC?=
 =?utf-8?B?N3RZZGh1d2EvbWhwNDlYY1FtOGthVXdwNHR4SjlDcERzQzcxbVlLK050Y2d1?=
 =?utf-8?B?TkRSaURreVhoSkwzQWVTN1hrTndmNHoxS1kwOVdUdzNUa1hxZHdjZ0ZWZWxQ?=
 =?utf-8?B?b0NRZk9ZeTJvTVNRalpaZTh5RXdxaSt6WUx1Y3g0T3pDTDVnSjhHSUhub1l4?=
 =?utf-8?B?a2hOZnErRUhnQlpkNmEyTlJnMTVpY29UUmNKKzFvTTA5b3RXUzNhREZFVnJl?=
 =?utf-8?B?dVd1VTNWZnZEVCtKNjIvcFJTVDNFeDFPYUpsQ3FMMVNET2NxbkkrREtyV2t0?=
 =?utf-8?B?eldWa2U1SVRYVk5WUHBzQ2s4VlBCbW1MenBkRzdGWkhzRzR0Q0hZRW1JaTFm?=
 =?utf-8?B?QW9kY1pBZVRwUzdhY201ZytTK281dG1iU3ZTUE9zRngrbkF5bWk0aEJWV3N1?=
 =?utf-8?B?MWZCajd6Uk1ra3ZlZWJsVnc1ZGZ2citQdjhsWVFkZHphQnZaRUErbG5ObXJJ?=
 =?utf-8?B?UlFxNG1xMGxhU2wzeTllSkE5T0pZeW9Zai9GRUFpNnBvYTBWd05UV2ZCdkVB?=
 =?utf-8?B?OXRlK1YvZGUvU1dhOHJjQzBrbStwMmZ1QUVsa2RxdEVSTGxTclg2NmRWYmI4?=
 =?utf-8?B?WUc1cjZCV3BSckhySFNXaXVOWmYyUlgwK2paZkQ0ckg0RHlNM0VhZDVIZHV3?=
 =?utf-8?B?ZlB6NUt3L0FLOWw5MjZ2MnZaS2k2ZGxycXhkSVI2aXlza1pOelJwejlKemw4?=
 =?utf-8?B?VDhOSktGSkxobkxvOVNZQVhPV3FiZHVJOE92TWE3REZhaUdKdnZVSDU0a29I?=
 =?utf-8?B?cS9GcmRnTElWUzhBOVl3Vms3K2U4VTRVRWJKL05CM2h1RU93ZDlWYzQxSmZC?=
 =?utf-8?B?RW9FazJDcDU3RHpFbzA5RmdybFpKTlI3M1NVbDhjazVlOExuOS82dz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcffb87-8496-4240-21ba-08da31b05f9e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:38:01.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/f97eqvXf46Gac2z6mUOucgpHnACLP7xW3Y86O6E1nKbHGHYKMiDXgWwv8uzRgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2317
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-05-09 at 10:49, Kavyasree Kotagiri wrote:
> LAN966 SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
> For each chip select of each flexcom there is a configuration
> register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
> configuration register is 21 because there are 21 shared pins
> on each of which the chip select can be mapped. Each bit of the
> register represents a different FLEXCOM_SHARED pin.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig  |   2 +
>  drivers/mfd/atmel-flexcom.c |  55 +++++++++++++++-
>  drivers/mux/Kconfig         |  12 ++++
>  drivers/mux/Makefile        |   2 +
>  drivers/mux/lan966-flx.c    | 121 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mux/lan966-flx.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 279810381256..26fb0f4e1b79 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -74,6 +74,8 @@ config SOC_LAN966
>  	select DW_APB_TIMER_OF
>  	select ARM_GIC
>  	select MEMORY
> +	select MULTIPLEXER
> +	select MUX_LAN966
>  	help
>  	  This enables support for ARMv7 based Microchip LAN966 SoC family.
>  
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 559eb4d352b6..7cfd0fc3f4f0 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <linux/mux/consumer.h>
>  
>  /* I/O register offsets */
>  #define FLEX_MR		0x0	/* Mode Register */
> @@ -28,6 +29,10 @@
>  #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
>  				 FLEX_MR_OPMODE_MASK)
>  
> +struct atmel_flex_caps {
> +	bool has_flx_mux;
> +};
> +
>  struct atmel_flexcom {
>  	void __iomem *base;
>  	u32 opmode;
> @@ -37,6 +42,7 @@ struct atmel_flexcom {
>  static int atmel_flexcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct atmel_flex_caps *caps;
>  	struct resource *res;
>  	struct atmel_flexcom *ddata;
>  	int err;
> @@ -76,13 +82,60 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
>  	 */
>  	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
>  
> +	caps = of_device_get_match_data(&pdev->dev);
> +	if (!caps) {
> +		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Flexcom Mux */
> +	if (caps->has_flx_mux && of_property_read_bool(np, "mux-controls")) {
> +		struct mux_control *flx_mux;
> +		struct of_phandle_args args;
> +		int i, count;
> +
> +		flx_mux = devm_mux_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(flx_mux))
> +			return PTR_ERR(flx_mux);
> +
> +		count = of_property_count_strings(np, "mux-control-names");
> +		for (i = 0; i < count; i++) {
> +			err = of_parse_phandle_with_fixed_args(np, "mux-controls", 1, i, &args);
> +			if (err)
> +				break;
> +
> +			err = mux_control_select(flx_mux, args.args[0]);
> +			if (!err) {
> +				mux_control_deselect(flx_mux);

This is suspect. When you deselect the mux you rely on the mux to be
configured with "as-is" as the idle state. But you do not document that.
This is also fragile in that you silently rely on noone else selecting
the mux to some unwanted state behind your back (mux controls are not
exclusive the way e.g. gpio pins or pwms are). The protocol is that
others may get a ref to the mux control and select it as long as noone
else has selected it.

The only sane thing to do is to keep the mux selected for the whole
duration when you rely on it to be in your desired state.

> +			} else {
> +				dev_err(&pdev->dev, "Failed to select FLEXCOM mux\n");
> +				return err;
> +			}
> +		}
> +	}
> +
>  	clk_disable_unprepare(ddata->clk);
>  
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>  
> +static const struct atmel_flex_caps atmel_flexcom_caps = {};
> +
> +static const struct atmel_flex_caps lan966x_flexcom_caps = {
> +	.has_flx_mux = true,
> +};
> +
>  static const struct of_device_id atmel_flexcom_of_match[] = {
> -	{ .compatible = "atmel,sama5d2-flexcom" },
> +	{
> +		.compatible = "atmel,sama5d2-flexcom",
> +		.data = &atmel_flexcom_caps,
> +	},
> +
> +	{
> +		.compatible = "microchip,lan966-flexcom",
> +		.data = &lan966x_flexcom_caps,
> +	},
> +
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index e5c571fd232c..ea09f474bc2f 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -45,6 +45,18 @@ config MUX_GPIO
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-gpio.
>  
> +config MUX_LAN966
> +	tristate "LAN966 Flexcom multiplexer"
> +	depends on OF || COMPILE_TEST
> +	help
> +	Lan966 Flexcom Multiplexer controller.
> +
> +	The driver supports mapping 2 chip-selects of each of the lan966
> +	flexcoms to 21 flexcom shared pins.
> +
> +	To compile the driver as a module, choose M here: the module will
> +	be called mux-lan966.
> +
>  config MUX_MMIO
>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>  	depends on OF || COMPILE_TEST
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index 6e9fa47daf56..53a9840d96fa 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -7,10 +7,12 @@ mux-core-objs			:= core.o
>  mux-adg792a-objs		:= adg792a.o
>  mux-adgs1408-objs		:= adgs1408.o
>  mux-gpio-objs			:= gpio.o
> +mux-lan966-objs			:= lan966-flx.o
>  mux-mmio-objs			:= mmio.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
>  obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
> +obj-$(CONFIG_MUX_LAN966)	+= mux-lan966.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
> diff --git a/drivers/mux/lan966-flx.c b/drivers/mux/lan966-flx.c
> new file mode 100644
> index 000000000000..2c7dab616a6a
> --- /dev/null
> +++ b/drivers/mux/lan966-flx.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LAN966 Flexcom MUX driver
> + *
> + * Copyright (c) 2022 Microchip Inc.
> + *
> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Looks like it is based on mmio.c?

> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/mux/driver.h>
> +#include <linux/io.h>
> +
> +#define FLEX_SHRD_MASK		0x1FFFFF
> +#define LAN966_MAX_CS		21
> +
> +static void __iomem *flx_shared_base;

I would much prefer to store the combined address (base+offset)
in the mux private data instead of only storing the offset and
then unnecessarily rely on some piece of global state (that
will be clobbered by other instances).

> +struct mux_lan966x {

Why is the file named lan966, but then everything inside lan966x?

> +	u32 offset;
> +	u32 ss_pin;
> +};
> +
> +static int mux_lan966x_set(struct mux_control *mux, int state)
> +{
> +	struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
> +	u32 val;
> +
> +	val = ~(1 << mux_lan966x[state].ss_pin) & FLEX_SHRD_MASK;
> +	writel(val, flx_shared_base + mux_lan966x[state].offset);

This reads memory you have not allocated, if you select a state
other than zero.

> +
> +	return 0;
> +}
> +
> +static const struct mux_control_ops mux_lan966x_ops = {
> +	.set = mux_lan966x_set,
> +};
> +
> +static const struct of_device_id mux_lan966x_dt_ids[] = {
> +	{ .compatible = "microchip,lan966-flx-mux", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mux_lan966x_dt_ids);
> +
> +static int mux_lan966x_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct mux_lan966x *mux_lan966x;
> +	struct mux_chip *mux_chip;
> +	int ret, num_fields, i;
> +
> +	ret = of_property_count_u32_elems(np, "mux-offset-pin");
> +	if (ret == 0 || ret % 2)
> +		ret = -EINVAL;
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "mux-offset-pin property missing or invalid");
> +	num_fields = ret / 2;
> +
> +	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(*mux_lan966x));

I might be thoroughly mistaken and confused by the code, but it seems
very strange that a subsequenct select is not undoing what a previous
select once did. Each state seems to write to its own register offset,
and there is nothing that restores the first register offset with you
switch states.

Care to explain how muxing works and what you are expected to do to
manipulate the mux? Is there some link to public documentation? I did
a quick search for lan966 but came up with nothing relevant.

> +	if (IS_ERR(mux_chip))
> +		return dev_err_probe(dev, PTR_ERR(mux_chip),
> +				     "failed to allocate mux_chips\n");
> +
> +	mux_lan966x = mux_chip_priv(mux_chip);
> +
> +	flx_shared_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(flx_shared_base))
> +		return dev_err_probe(dev, PTR_ERR(flx_shared_base),
> +				     "failed to get flexcom shared base address\n");
> +
> +	for (i = 0; i < num_fields; i++) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +		u32 offset, shared_pin;
> +
> +		ret = of_property_read_u32_index(np, "mux-offset-pin",
> +						 2 * i, &offset);
> +		if (ret == 0)
> +			ret = of_property_read_u32_index(np, "mux-offset-pin",
> +							 2 * i + 1,
> +							 &shared_pin);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read mux-offset-pin property: %d", i);
> +
> +		if (shared_pin >= LAN966_MAX_CS)
> +			return -EINVAL;
> +
> +		mux_lan966x[i].offset = offset;
> +		mux_lan966x[i].ss_pin = shared_pin;

This clobbers memory you have not allocated, if num_fields >= 1.

Cheers,
Peter

> +
> +		mux->states = LAN966_MAX_CS;
> +	}
> +
> +	mux_chip->ops = &mux_lan966x_ops;
> +
> +	ret = devm_mux_chip_register(dev, mux_chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mux_lan966x_driver = {
> +	.driver = {
> +		.name = "lan966-mux",
> +		.of_match_table	= of_match_ptr(mux_lan966x_dt_ids),
> +	},
> +	.probe = mux_lan966x_probe,
> +};
> +
> +module_platform_driver(mux_lan966x_driver);
> +
> +MODULE_DESCRIPTION("LAN966 Flexcom multiplexer driver");
> +MODULE_AUTHOR("Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>");
> +MODULE_LICENSE("GPL v2");
> +
