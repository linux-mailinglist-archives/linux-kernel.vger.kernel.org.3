Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF56856B54F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiGHJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiGHJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:22:07 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7DC2BB14
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:22:06 -0700 (PDT)
Received: from outbound-ss-761.bluehost.com (outbound-ss-761.bluehost.com [74.220.211.250])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 9670B8047982
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:21:55 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway8.mail.pro1.eigbox.com (Postfix) with ESMTP id A867C100471DA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:21:32 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id 9kB2oPuOexkuL9kB2o3mhE; Fri, 08 Jul 2022 09:21:32 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=euAacqlX c=1 sm=1 tr=0 ts=62c7f71c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=RgO8CyIxsXoA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=DfNHnWVPAAAA:8
 a=HaFmDPmJAAAA:8 a=xPYjEa9yCoeP-FtDBPQA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=rjTVMONInIDnV1a_A2c_:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h2R9iU1WVzxmJmBpd2nGVGlMqHQ7caamQY0bCp67pZ8=; b=aisUtkUvDRX0w+Aip0NO/UZKcg
        EpIHkPqU5SuuZH0HCnYjhEX1d0swCd32RNTZn9Ogy+uZWMYlvonO7QYNS6h8wTUtUz0vX2yTxdi9r
        XhGTGKenwmuqFMXsqdDwegSczZ331znx24PnfImUenYaZrDvM5dbBCuDxjgA4Qo7VOY2CQU8WJT+S
        5zxx4dy1wzLKecbwKtmkMUHIv5/+oW9RqRan9ZpeYwJWaq8+Y2bo0HFX5HoRjrG6YzM+w57r0mMdp
        jvmG+4ckqprLkuca3dvQYcE7z9q/fsHf2rfs4lLZKlUJtVRSDOzNUksrCfdcYHdWs7rML0qeTvw01
        W1aSv8pg==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:35088 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1o9kB0-0003BW-FT;
        Fri, 08 Jul 2022 03:21:30 -0600
Subject: Re: [PATCH v1 4/4] riscv: dts: sifive unmatched: Add PWM controlled
 LEDs
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
 <20220705210143.315151-5-emil.renner.berthing@canonical.com>
In-Reply-To: <20220705210143.315151-5-emil.renner.berthing@canonical.com>
From:   Ron Economos <re@w6rz.net>
Message-ID: <57d1ee28-933a-ce84-2715-7d7390920b6e@w6rz.net>
Date:   Fri, 8 Jul 2022 02:21:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1o9kB0-0003BW-FT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:35088
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 2:01 PM, Emil Renner Berthing wrote:
> This adds the two PWM controlled LEDs to the HiFive Unmatched device
> tree. D12 is just a regular green diode, but D2 is an RGB diode with 3
> PWM inputs controlling the three different colours.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>   .../boot/dts/sifive/hifive-unmatched-a00.dts  | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index c4ed9efdff03..beaefe74755a 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -4,6 +4,8 @@
>   #include "fu740-c000.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
>   
>   /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
>   #define RTCCLK_FREQ		1000000
> @@ -44,6 +46,46 @@ gpio-poweroff {
>   		compatible = "gpio-poweroff";
>   		gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
>   	};
> +
> +	led-controller-1 {
> +		compatible = "pwm-leds";
> +
> +		led-d12 {
> +			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> +			active-low;
> +			color = <LED_COLOR_ID_GREEN>;
> +			max-brightness = <255>;
> +			label = "d12";
> +		};
> +	};
> +
> +	led-controller-2 {
> +		compatible = "pwm-leds-multicolor";
> +
> +		multi-led {
> +			color = <LED_COLOR_ID_RGB>;
> +			max-brightness = <255>;
> +			label = "d2";
> +
> +			led-red {
> +				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> +				active-low;
> +				color = <LED_COLOR_ID_RED>;
> +			};
> +
> +			led-green {
> +				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> +				active-low;
> +				color = <LED_COLOR_ID_GREEN>;
> +			};
> +
> +			led-blue {
> +				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> +				active-low;
> +				color = <LED_COLOR_ID_BLUE>;
> +			};
> +		};
> +	};
>   };
>   
>   &uart0 {

Tested on HiFive Unmatched with both udev and systemd. Works good.

Tested-by: Ron Economos <re@w6rz.net>

