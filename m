Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9193A572F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiGMHsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiGMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:48:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63417E5DF9;
        Wed, 13 Jul 2022 00:48:05 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.47.106.71])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B42E204DE8E;
        Wed, 13 Jul 2022 00:48:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B42E204DE8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657698485;
        bh=KZ3W7Lm0ppPu0mxu7WcxzkIS3QqQzFKigKl1JQiFt2Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P6+Zhlbq0DMsnVL+ep7Gw05EZe/vUerKqkJmmAvdzE0pSRyQXm6vhKjOFnTdc84dI
         Wr5o/o68+rQ16YtPQgftXDkZ3oY7JvtHA9SjKygZ+43CrDgiRDmcJS/qnvQ8OjqHRv
         Hs3mxf8ksl5o7PzzC4HWh10dRPhLpoAdGUpHVLUs=
Message-ID: <e5c47d13-bbb9-e607-47cb-6bf4cf6bebd9@linux.microsoft.com>
Date:   Wed, 13 Jul 2022 00:48:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 3/5] ARM: dts: aspeed: Add HACE device controller node
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        BMC-SW@aspeedtech.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-4-neal_liu@aspeedtech.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <20220705020936.1751771-4-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2022 7:09 PM, Neal Liu wrote:
> Add hace node to device tree for AST2500/AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 8 ++++++++
>   arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index c89092c3905b..04f98d1dbb97 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -262,6 +262,14 @@ rng: hwrng@1e6e2078 {
>   				quality = <100>;
>   			};
>   
> +			hace: crypto@1e6e3000 {
> +				compatible = "aspeed,ast2500-hace";
> +				reg = <0x1e6e3000 0x100>;
> +				interrupts = <4>;
> +				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
> +				resets = <&syscon ASPEED_RESET_HACE>;
> +			};
> +
>   			gfx: display@1e6e6000 {
>   				compatible = "aspeed,ast2500-gfx", "syscon";
>   				reg = <0x1e6e6000 0x1000>;
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 6660564855ff..095cf8d03616 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -323,6 +323,14 @@ apb {
>   			#size-cells = <1>;
>   			ranges;
>   
> +			hace: crypto@1e6d0000 {
> +				compatible = "aspeed,ast2600-hace";
> +				reg = <0x1e6d0000 0x200>;
> +				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
> +				resets = <&syscon ASPEED_RESET_HACE>;
> +			};
> +


Thank you for addressing ast2500, for this patch -

Reviewed-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
