Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5D4B4F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbiBNLxh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:53:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiBNLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:53:35 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED8C35;
        Mon, 14 Feb 2022 03:53:28 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:52:58 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dts: x1000: Fix missing TCU clock in tcu device
 node
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ACMA7R.XSUTVF0NI87S3@crapouillou.net>
In-Reply-To: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
References: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam., févr. 12 2022 at 15:09:27 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> This should've been present all along, but was omitted due to
> a mistake in the TCU driver.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> v1 -> v2: 
> https://lore.kernel.org/linux-mips/20220209230145.18943-1-aidanmacdonald.0x0@gmail.com/
> 
>  * Split DTS changes to separate patch.
> 
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi 
> b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..c69df8eb158e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -111,8 +111,9 @@ tcu: timer@10002000 {
> 
>  		clocks = <&cgu X1000_CLK_RTCLK>,
>  			 <&cgu X1000_CLK_EXCLK>,
> -			 <&cgu X1000_CLK_PCLK>;
> -		clock-names = "rtc", "ext", "pclk";
> +			 <&cgu X1000_CLK_PCLK>,
> +			 <&cgu X1000_CLK_TCU>;
> +		clock-names = "rtc", "ext", "pclk", "tcu";
> 
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
> --
> 2.34.1
> 


