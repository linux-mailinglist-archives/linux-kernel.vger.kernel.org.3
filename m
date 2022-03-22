Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B744E4642
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiCVSud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCVSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:50:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E85AEE5;
        Tue, 22 Mar 2022 11:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 895B1B81D12;
        Tue, 22 Mar 2022 18:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAEDC340F2;
        Tue, 22 Mar 2022 18:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647974941;
        bh=GezTty0jPoyFJLxyLQyA1KLxy9CHoc9y6yF+W6ZDHqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW+Tezg6MJ9CTsRF6nd9zHrO+NTai3t2i/r0wNX+SmIk4nwkXW3F6qYcbpKGfUtf2
         dPqN26kOslkDv4aMn04gojtLkrs9JRyTgm5Plb08K62SA9p2C2fD1EWmtifhpiecQr
         jQYHBUrvv5U9tsooAE7+FZLlZPFq4JBY+LbON2jJaS+9nZMM7x/gILPa7IPRZv4HiI
         1u5sE6zMSzdbQaK9Dwq7RHd0WS5dbuhmEB7Z0cSEVIZzjEox89xm81M4kZ7YpqvUK2
         Mhf23Ai+eTH+ecbhQVTNeDVQmjFbnxfOwm28NDFkxNavND8WbjebUXh6jSruGY5TvF
         bkww2lHfjGDQw==
Received: by pali.im (Postfix)
        id C113E843; Tue, 22 Mar 2022 19:48:58 +0100 (CET)
Date:   Tue, 22 Mar 2022 19:48:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH v2 2/2] arm64: dts: uDPU: correct temperature sensors
Message-ID: <20220322184858.irr5p75tdu4mths3@pali>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
 <20220322105857.1107016-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322105857.1107016-2-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2022 11:58:57 Robert Marko wrote:
> uDPU has a pair of NCT375 temperature sensors, which are TMP75C compatible
> as far as the driver is concerned.
> 
> The current LM75 compatible worked as all of the LM75 compatible sensors
> are backwards compatible with the original part, but it meant that lower
> resolution and incorrect sample rate was being used.
> 
> The "lm75" compatible has been deprecated anyway and is meant as fallback
> in order to keep older DTS-es working.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> Changes in v2:
> * None
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> index ac64949bb53e..1f534c0c65f7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -153,15 +153,15 @@ &i2c1 {
>  	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  
> -	lm75@48 {
> +	nct375@48 {
>  		status = "okay";
> -		compatible = "lm75";
> +		compatible = "ti,tmp75c";
>  		reg = <0x48>;
>  	};
>  
> -	lm75@49 {
> +	nct375@49 {
>  		status = "okay";
> -		compatible = "lm75";
> +		compatible = "ti,tmp75c";
>  		reg = <0x49>;
>  	};
>  };
> -- 
> 2.35.1
> 
