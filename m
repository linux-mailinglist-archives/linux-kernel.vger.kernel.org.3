Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9672D4CD6D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiCDOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiCDOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:54:39 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF30187E39;
        Fri,  4 Mar 2022 06:53:51 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A78341BF204;
        Fri,  4 Mar 2022 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646405630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TySVdy94IbkIuYNoa5NXDfUiMMMbAJCyvZocHTXJLaQ=;
        b=JUTYSelu7xdSqVX75hDUcp8cIxwmHcv9hcdi+qKwFwZwwF9ZcswDHPNDri4vFA/nmhbPxn
        zYUm/OokbkkmGlSzX0W1BDM0vYILIyMkFFjSeQXT1qZ52phCZCv1pZe061AFK/NTr8laQu
        Alt77bfdW0/V4bA3W+kn0EGb83xDde01AF1r0x/V/6S8GTHlZvClDu4uxBsZCy8qag2B2a
        +EajNCUcmd839e48K8ycbiqefS8XC+MRjz1MOCF8FCfpZGFXyA+QYe3zYEXtDeRBoRWA6p
        xqOBY40MWUksV8Gke9Ji3wMwFPhCEBssJIIVzQiIvZV399HO96khPZSrXBeekQ==
Date:   Fri, 4 Mar 2022 15:53:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ARM: dts: at91: Add the required
 `atmel,rtt-rtc-time-reg` property
Message-ID: <YiIn/NJyqeYlhV/z@piout.net>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
 <20220304142746.121947-2-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304142746.121947-2-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 16:27:42+0200, Sergiu Moga wrote:
> Add the required `atmel,rtt-rtc-time-reg` property to the `rtt` nodes
> of the board files that were missing it.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
>  arch/arm/boot/dts/at91sam9263ek.dts | 8 ++++++++
>  arch/arm/boot/dts/at91sam9rlek.dts  | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index beed819609e8..3c1f40b4a13e 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -178,6 +178,10 @@ dbgu: serial@fffff200 {
>  				status = "okay";
>  			};
>  
> +			rtc@fffffd20 {
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +			};
> +
>  			watchdog@fffffd40 {
>  				status = "okay";
>  			};
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 71f60576761a..1208bb580d14 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -102,6 +102,14 @@ mtd_dataflash@0 {
>  				};
>  			};
>  
> +			rtc@fffffd20 {
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +			};
> +
> +			rtc@fffffd50 {
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x4>;
> +			};

Do we really need two RTCs with the exact same features on that board?
Is there a check failure hen the property is not there and the node is
disabled?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
