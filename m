Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DC5A802B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiHaO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHaO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A0632B91
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E85FB61BAD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28459C433D6;
        Wed, 31 Aug 2022 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661956062;
        bh=+1mkF0vDf807PJ0H5aPT1o4EZsGPNKP9hJQmi638xpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kctWLX660iXiGG2x075AXkNa3B0ywLam+2Mbsa+cXeAtLykW5AmmC4C9/TDTmwTyR
         Wq/2RO0F9TsZVxZdgnZ5Yw/TimSTqwoVbudTpHdW5XjxSK+AsOzFu6K9JEhZFKZKfG
         sQpTG47iJMgOlAXSIEkKjUhN+sBJG8ocd6ssZe9I1N5q8TWtNxEbWbFOwXlOdPXsPu
         HMDSig9akOBsmoUYA6s7nsK44kI38FppL80ULNweYSS4/VqiUPDjMP88jT/MmKq5xq
         Lx4HnBfz9LNkKV5ycKwjCaRfwBd0ArQwL4+XBTbAaY0rcw/N2ALSx+dKksKcwS5jrA
         egMXCiqRKkL5Q==
Received: by pali.im (Postfix)
        id 65048855; Wed, 31 Aug 2022 16:27:39 +0200 (CEST)
Date:   Wed, 31 Aug 2022 16:27:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: armada-38x: Add gpio-ranges for pin muxing
Message-ID: <20220831142739.nmvi6hzhlimiyqjj@pali>
References: <20220727131619.3056-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727131619.3056-1-pali@kernel.org>
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

On Wednesday 27 July 2022 15:16:19 Pali Rohár wrote:
> GPIOs are configured by pinmux driver, so add corresponding references.
> 
> Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index a176898944f7..1590143c52c8 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -298,6 +298,7 @@
>  				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
> +				gpio-ranges = <&pinctrl 0 0 32>;
>  				#gpio-cells = <2>;
>  				#pwm-cells = <2>;
>  				interrupt-controller;
> @@ -316,6 +317,7 @@
>  				reg-names = "gpio", "pwm";
>  				ngpios = <28>;
>  				gpio-controller;
> +				gpio-ranges = <&pinctrl 0 32 28>;
>  				#gpio-cells = <2>;
>  				#pwm-cells = <2>;
>  				interrupt-controller;
> -- 
> 2.20.1
> 
