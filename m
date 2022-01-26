Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7649D365
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiAZU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiAZU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:26:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE3C06161C;
        Wed, 26 Jan 2022 12:26:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F03B81FC8;
        Wed, 26 Jan 2022 20:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51515C340E3;
        Wed, 26 Jan 2022 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643228791;
        bh=eXAJVhNHEmGmh8jkpV3UnQcM8JFFnL5CWntepi5Zm3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IyZbas3twmprqjTtZGQZWrNYuuPWpE56mxYQGX4hqJMVtMoSYC4hsjAj071NO+9V1
         P15poW5KoGL/D2BP36KTVlaanwx25+d/imdRo+LnZpAFNukBBRVibDEtwZ2mQs+RQg
         4XNNfw91Tb2/NJJAY2LFY7hzBLIfnsgbYiqJqco3E8jnD9fePWsfeb5Em7i3PvbiGF
         PeSswM07/xG1URkhLeTZusSEQjMzQV9Ae9M/ILd4jeCZAQiAteepawGkuiefw706r+
         wrEY0RwHuC0V5tFnOBl88TTbzRtJN4jRrPxhpHDD3Z3oine+VGAAdnzVTUtVdJMORB
         6HLqXvX6gy5yw==
Message-ID: <2cb2bbd9-1ff7-2a5e-a425-29a502080290@kernel.org>
Date:   Wed, 26 Jan 2022 14:26:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND, third time][PATCH] arm64: dts: intel:
 socfpga_agilex_socdk: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20220126174157.288111-1-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220126174157.288111-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 11:41, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Align the LED node names with dtschema to silence dtbs_check warnings
> like:
> 
>      leds: 'hps0', 'hps1', 'hps2' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> ---
> 
> This patch waits for a year. Dinh, you previously acked it but can you
> apply it?
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> index ea37ba7ccff9..26cd3c121757 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> @@ -21,17 +21,17 @@ chosen {
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		hps0 {
> +		led0 {
>   			label = "hps_led0";
>   			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		hps1 {
> +		led1 {
>   			label = "hps_led1";
>   			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		hps2 {
> +		led2 {
>   			label = "hps_led2";
>   			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
>   		};


Apologies for missing this the first 2 times.

Applied, thanks!

Dinh
