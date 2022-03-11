Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F44D6246
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiCKNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348862AbiCKNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:22:16 -0500
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DF1C3D11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647004842; bh=J7/vKcyix+nji45hqGrcjszxF1kSDnocg442Y//BGKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tOhHJisO0eoVBxXAyJJVaphOYMMSeBqvEeikezoAsTuQxuXP/DrQ/jRcRmrk3F1v5
         S0PPiGSE7VOj6V778ZCTCqxgsFWcb6Dfp14kJOZsRDKIYe/8SP5vnlUXNPc6QY3Fip
         cCSpCjcyhDXrCINmTirV/w3AyWfvAe1U2kSm13yo2S3m2XlTc2A0fSCK76NffTgmyR
         F1n1tMZnOzuY5SHDKuFymCG9lCh06Z+NmDuY/NjoSiwW2KTZDQhU8fo7MoNfMwba33
         zx76vIdgTDlmZ+c/BYTDigElSyh3SZud/P5+zbnxDMZpkzwjOnHfw4W+XWzZgPDTwc
         WeM/PBJLVyPmA==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 138F439E948;
        Fri, 11 Mar 2022 13:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647004842; bh=J7/vKcyix+nji45hqGrcjszxF1kSDnocg442Y//BGKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tOhHJisO0eoVBxXAyJJVaphOYMMSeBqvEeikezoAsTuQxuXP/DrQ/jRcRmrk3F1v5
         S0PPiGSE7VOj6V778ZCTCqxgsFWcb6Dfp14kJOZsRDKIYe/8SP5vnlUXNPc6QY3Fip
         cCSpCjcyhDXrCINmTirV/w3AyWfvAe1U2kSm13yo2S3m2XlTc2A0fSCK76NffTgmyR
         F1n1tMZnOzuY5SHDKuFymCG9lCh06Z+NmDuY/NjoSiwW2KTZDQhU8fo7MoNfMwba33
         zx76vIdgTDlmZ+c/BYTDigElSyh3SZud/P5+zbnxDMZpkzwjOnHfw4W+XWzZgPDTwc
         WeM/PBJLVyPmA==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id AA1DF39E937;
        Fri, 11 Mar 2022 13:20:41 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
Date:   Fri, 11 Mar 2022 15:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220311_132042_108857_54C47694 
X-CRM114-Status: GOOD (  20.88  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 11:38 AM, Kuldeep Singh wrote:
> PL022 binding require two clocks to be defined but lpc platform doesn't
> comply with bindings and define only one clock i.e apb_pclk.
> 
> Update spi clocks and clocks-names property by adding appropriate clock
> reference to make it compliant with bindings.
> 
> CC: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v2:
> - New patch with similar changeset
> - Send to soc ML
> 
>   arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index c87066d6c995..30958e02d5e2 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>   				compatible = "arm,pl022", "arm,primecell";
>   				reg = <0x20084000 0x1000>;
>   				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk LPC32XX_CLK_SSP0>;
> -				clock-names = "apb_pclk";
> +				clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
> +				clock-names = "sspclk", "apb_pclk";

In fact I'm uncertain if it is the right change, could it happen that the commit
cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
schema pattern?

Apparently just one clock is wanted on all observed platforms and cases, this
is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :

	pl022->clk = devm_clk_get(&adev->dev, NULL);

So, I would vote to fix the device tree bindings schema.

>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				status = "disabled";
> @@ -202,8 +202,8 @@ ssp1: spi@2008c000 {
>   				compatible = "arm,pl022", "arm,primecell";
>   				reg = <0x2008c000 0x1000>;
>   				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk LPC32XX_CLK_SSP1>;
> -				clock-names = "apb_pclk";
> +				clocks = <&clk LPC32XX_CLK_SSP1>, <&clk LPC32XX_CLK_SSP1>;
> +				clock-names = "sspclk", "apb_pclk";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				status = "disabled";
> 

--
Best wishes,
Vladimir
