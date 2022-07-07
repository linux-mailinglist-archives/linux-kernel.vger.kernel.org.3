Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BF569DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiGGInu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGGInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A9313F21;
        Thu,  7 Jul 2022 01:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE26C6215A;
        Thu,  7 Jul 2022 08:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD721C3411E;
        Thu,  7 Jul 2022 08:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657183426;
        bh=JShi5H1i2nsGD1KHHmbsIvrn79bCrEpp/5XJP6iaUXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YSTB1EGxRgdlzlNAjp+SyTj8N3cJgEpPHrDJU0l5e5HuVnkuWEufm2H/QEABJV9OH
         oS6GlVSK5CVPKMqhq/3epAB2L1wsnpMLxtEFtjvk4ZFPE9RKlafzKimxiH3AD3JlMN
         iqxHJw7HdFaEIUOas5yrvOZiE2b0eboT5eU8na1P3/0zGQgSmIlorY13++4jX1feCW
         l2pKIEJGvRAOb73ksx1C6+ibZ7jjcKTeDaXclhqfXq1LomuH9wtYSV2fhpNHRqTXHD
         1S0S6Dv5CV9DX43luXNo+3i+SN+mmOkxUpNwxNvf0wfQ4XOFRqUFf49vE16zwhAu/Z
         Y3SfBv9UwmErQ==
Message-ID: <049f9386-fafb-a359-7bc6-6b346b00b0a6@kernel.org>
Date:   Thu, 7 Jul 2022 11:43:38 +0300
MIME-Version: 1.0
Subject: Re: [PATCH V4] arm64: dts: imx8mp: add NoC node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
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

On 7.07.22 2:47, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
> Currently dynamic frequency scaling of the i.MX8MP NoC has not been
> supported, only NoC initial settings are configured by interconnect
> driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks good to me.

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> 
> V4:
>   Georgi has merged the V3 driver and bindings patches. So only resend
>   this patch. Per Georgi's comments:
>    - Drop syscon from compatbile
>    - Drop the header inclusion
> 
>   Seems I not see this patch in patchwork or mailist, maybe sent failed.
>   So gave a resend of V4.
> 
>   V3:
>    https://lore.kernel.org/linux-arm-kernel/20220703091132.1412063-1-peng.fan@oss.nxp.com/
> 
>   I not list the full change log, since this is only a minor patch
> 
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index eb2d516278eb..42ed8ee08548 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1019,6 +1019,27 @@ eqos: ethernet@30bf0000 {
>   			};
>   		};
>   
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc";
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

