Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2245A802F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiHaO2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHaO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F013D0C;
        Wed, 31 Aug 2022 07:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AA261B74;
        Wed, 31 Aug 2022 14:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4D0C433C1;
        Wed, 31 Aug 2022 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661956091;
        bh=1QA5Gwy5yM74XPHFPpRTyh0noC8OOgttdPqN/fIeYDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNL1O9CENaxh2v8eefT7iJYEyjWCcuShXRxpfxS0qWn2PtGGK8mtGuwxSVRvBFtTl
         E+IOUipjsmOzWL7lFlw+Gc+d8XlsU9Rn6gUE1p9URYzAQi3TwVYYTUIIE1FriRkjM1
         z9yQtyg/nh7zBqE+IOgKmL9JSV6QnEyatA2KL1B5iPSdbuwsU+B8sJgMwc0ML/ZPjX
         fXIUyJU5pBzH5Ebb6OP0Jdu2CedtgHHntigVNnUDvMK1ISlsmEdfOOhMBkb1InjtfG
         ygL+cipmfwOy2shhkhBTTvKnzPgbZnFMt/AJxjejy1dL6Wgo2E1e3LVxqB6ziNuzj9
         GPyEgGe5CemLg==
Received: by pali.im (Postfix)
        id 1B45A855; Wed, 31 Aug 2022 16:28:09 +0200 (CEST)
Date:   Wed, 31 Aug 2022 16:28:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <20220831142809.lcmnv3l4rnulo522@pali>
References: <20220819131152.6513-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819131152.6513-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
> At i2c address 0x2a is MCU command interface which provides access to GPIOs
> connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Same change was already sent to U-Boot project together with driver. As
> Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
> this change also in Linux. There is a plan to write also Linux driver for
> Turris Omnia MCU, like there is already in U-Boot.
> 
> https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index f4878df39753..f655e9229d68 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -184,7 +184,13 @@
>  			#size-cells = <0>;
>  			reg = <0>;
>  
> -			/* STM32F0 command interface at address 0x2a */
> +			/* MCU command i2c API */
> +			mcu: mcu@2a {
> +				compatible = "cznic,turris-omnia-mcu";
> +				reg = <0x2a>;
> +				gpio-controller;
> +				#gpio-cells = <3>;
> +			};
>  
>  			led-controller@2b {
>  				compatible = "cznic,turris-omnia-leds";
> -- 
> 2.20.1
> 
