Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADD58CF10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiHHUZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiHHUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:25:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE91A802;
        Mon,  8 Aug 2022 13:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADD3DB8106E;
        Mon,  8 Aug 2022 20:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45A8C433D6;
        Mon,  8 Aug 2022 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659990299;
        bh=RabQK1oIMT30l8/qu0BBkcfTpYLr6VzJLWZ9Ko+UWGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYDJoWsIOWLOsi9ZeyJm7FJfm5ojabeNJwkEGI/TiRQtXX774iZDDP/ND9L2ADgQ/
         F/r1J6PwZ4nShypeN4Dx1wvYHgi5sw/DqAULgqRVgF8rpYy3qBfnU6QkZrLr+nRv3x
         pD6l7lYq/4G60k9QxT9n53uaeYA4mxtCZXseDZaIMN4hW+O6kevhUi51D5fE7RPBKJ
         V43mcd5XbcQ+EA2l/gJKtYj19s8eC513HSBZ10/2Yo/GXvftwnlDRDdqdlNUG4QQWU
         E3vFUnmC0Rhv4En2ZhOUCO9tzHQWA6iYeTFcOjAlP5gNq6hDc3Agdg+tFg8tsEFjHC
         3UwwaHi1GqKnw==
Received: by pali.im (Postfix)
        id 8968CF13; Mon,  8 Aug 2022 22:24:56 +0200 (CEST)
Date:   Mon, 8 Aug 2022 22:24:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220808202456.lpwvhq22edb56ptf@pali>
References: <20220713125644.3117-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713125644.3117-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Wednesday 13 July 2022 14:56:44 Pali Rohár wrote:
> All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> family and do not have Armada 3710 processor. So none of them should have
> compatible string for Armada 3710 processor.
> 
> Fix compatible string for all these boards by removing wrong processor
> string "marvell,armada3710" and adding family string "marvell,armada3700"
> as the last one. (Note that this is same way how are defined Armada 3710
> DTS files).
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                  | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts   | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts         | 2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          | 2 +-
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi                    | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index bd4e61d5448e..0cfb38492021 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -18,7 +18,7 @@
>  
>  / {
>  	model = "Marvell Armada 3720 Development Board DB-88F3720-DDR3";
> -	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> +	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> index 5c4d8f379704..6715a19c1483 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> @@ -18,7 +18,7 @@
>  / {
>  	model = "Globalscale Marvell ESPRESSOBin Board (eMMC)";
>  	compatible = "globalscale,espressobin-emmc", "globalscale,espressobin",
> -		     "marvell,armada3720", "marvell,armada3710";
> +		     "marvell,armada3720", "marvell,armada3700";
>  };
>  
>  &sdhci0 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 070725b81be5..447760b69850 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -13,7 +13,7 @@
>  / {
>  	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
>  	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>  
>  	aliases {
>  		/* ethernet1 is WAN port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 75401eab4d42..2a8aa3901a9f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -19,7 +19,7 @@
>  	model = "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
>  	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
>  		     "globalscale,espressobin", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>  
>  	aliases {
>  		/* ethernet1 is wan port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 48a7f50fb427..b03af87611a9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -18,7 +18,7 @@
>  / {
>  	model = "Globalscale Marvell ESPRESSOBin Board V7";
>  	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
> -		     "marvell,armada3720", "marvell,armada3710";
> +		     "marvell,armada3720", "marvell,armada3700";
>  
>  	aliases {
>  		/* ethernet1 is wan port */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 1542d836c090..c5a834b33b77 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -16,5 +16,5 @@
>  
>  / {
>  	model = "Globalscale Marvell ESPRESSOBin Board";
> -	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
> +	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3700";
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index caf9c8529fca..5840ed129309 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -14,7 +14,7 @@
>  / {
>  	model = "CZ.NIC Turris Mox Board";
>  	compatible = "cznic,turris-mox", "marvell,armada3720",
> -		     "marvell,armada3710";
> +		     "marvell,armada3700";
>  
>  	aliases {
>  		spi0 = &spi0;
> diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> index 5ce55bdbb995..02ae1e153288 100644
> --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Marvell Armada 3720 SoC";
> -	compatible = "marvell,armada3720", "marvell,armada3710";
> +	compatible = "marvell,armada3720", "marvell,armada3700";
>  
>  	cpus {
>  		cpu1: cpu@1 {
> -- 
> 2.20.1
> 
