Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291F85657D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiGDNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63611655D;
        Mon,  4 Jul 2022 06:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D295961594;
        Mon,  4 Jul 2022 13:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085AAC341CB;
        Mon,  4 Jul 2022 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656942668;
        bh=KvKeOxcHnEj4x6o/YxW2xXiwJTOrRcOqrpTbLSJnsnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wz6FlkeDtwnaVwEIaprnDp7s9qkYvSJSJyt4eeUq8wXV1DjeGOF5l41B1wwIyV/V1
         CK+6rNOInqhxM3DbXlCCyvgszai80R0X+IcfzTWrNjT2k74wO2OCZhaoCI8OTBk40A
         44CZY03Ha0b4SlHnqYSxqoioZs12vagHUC6M82iJUnISi2Q3DNOnXhjfI6qQBKacqs
         XX6asUZRfhJg6UBf9jIqq0A5teW0FrSUL8KtxxK2qtMNzKZgHnfMk6CbTUwkHizWav
         hi5qGBb71JeIk992Nwi8KKL8IUZgUXDCOBkBP5qWmxNHTUPEMdJMuvkuYrtCfv6tV9
         v0Wk+JRCLcUTw==
Message-ID: <36d8fbe2-b64d-4997-5836-b2c32e4d987f@kernel.org>
Date:   Mon, 4 Jul 2022 16:50:51 +0300
MIME-Version: 1.0
Subject: Re: [PATCH V3 10/10] arm64: dts: imx8mp: add NoC node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
 <20220703091132.1412063-11-peng.fan@oss.nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220703091132.1412063-11-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peng,

On 3.07.22 12:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
> Currently dynamic frequency scaling of the i.MX8MP NoC has not been
> supported, only NoC initial settings are configured by interconnect
> driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index eb2d516278eb..13a2ee77d3c6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/interconnect/fsl,imx8mp.h>

It's also possible to drop this line for now and add it in the next patches when we add the 
interconnect consumers. This will allow merging this DT patch independently. But it's up to Shawn.

>   #include <dt-bindings/power/imx8mp-power.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
> @@ -1019,6 +1020,27 @@ eqos: ethernet@30bf0000 {
>   			};
>   		};
>   
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";

I got the impression that we are dropping the syscon, or not?

> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MP_CLK_NOC>;
> +			#interconnect-cells = <1>;
> +
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-200M {
> +					opp-hz = /bits/ 64 <200000000>;
> +				};
> +
> +				opp-1000M {
> +					opp-hz = /bits/ 64 <1000000000>;
> +				};
> +			};
> +		};
> +
>   		aips4: bus@32c00000 {
>   			compatible = "fsl,aips-bus", "simple-bus";
>   			reg = <0x32c00000 0x400000>;
Patches 1-9 look good and I am planning to merge them.

Thanks,
Georgi
