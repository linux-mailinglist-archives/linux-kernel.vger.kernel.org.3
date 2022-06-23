Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D98557F93
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiFWQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FD2FE70;
        Thu, 23 Jun 2022 09:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1540461F16;
        Thu, 23 Jun 2022 16:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A17C3411B;
        Thu, 23 Jun 2022 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656001017;
        bh=9hzaq+Mj5SOymDnqMHxkRzyT7FLLGSDp3XZppwjM7vc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=bcMuQmysro0TsXmL8ruICaNvqn2Xbf6ulty7DnbtRaX96SM8S0cYRcRL6PKGNILvx
         nRiViwV1gXvzfuTZxAnhZmiX0iOgsYHCd9rbukkTgurzFeRoJLAf1sy3nbMU9uWNGg
         yBa6wLJTpNv+wAHBqlfHaIAyYw84Ir9HsVs2hcghDyvitzX5mrB0YmVThQA94eTpOd
         DOuKuUNOLBi1oCZpPGc8j92NlJwKQaVkhUxLp8jOJqRoerqAcywRWH8EW0zZUUivNL
         2TY7oVgqahNIkR2Nu3IMarrMArpuV58EhAujInXavZ+/raIWIh5tVPN2KuhmqczObc
         bAevbG7QbCDwg==
Message-ID: <1f1ac1ad-0eed-0871-93a9-56f710eeba98@kernel.org>
Date:   Thu, 23 Jun 2022 11:16:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: altera: socfpga_stratix10: move clocks out of
 soc node
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220623024221.2766255-1-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220623024221.2766255-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 21:42, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> The clocks are not part of the SoC but provided on the board
> (external oscillators). Moving them out of soc node.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   .../boot/dts/altera/socfpga_stratix10.dtsi    | 56 +++++++++----------
>   1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index aa2bba75265f..5c7d926d18f7 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -97,6 +97,34 @@ intc: interrupt-controller@fffc1000 {
>   		      <0x0 0xfffc6000 0x0 0x2000>;
>   	};
>   
> +	clocks {
> +		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		cb_intosc_ls_clk: cb-intosc-ls-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		f2s_free_clk: f2s-free-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		osc1: osc1 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		qspi_clk: qspi-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
>   	soc {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -119,34 +147,6 @@ clkmgr: clock-controller@ffd10000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		clocks {
> -			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			cb_intosc_ls_clk: cb-intosc-ls-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			f2s_free_clk: f2s-free-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			osc1: osc1 {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			qspi_clk: qspi-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <200000000>;
> -			};
> -		};
> -
>   		gmac0: ethernet@ff800000 {
>   			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
>   			reg = <0xff800000 0x2000>;

NAK! This patch breaks the Stratix10 boot. Also these clocks are part of 
the SoC!

Dinh
