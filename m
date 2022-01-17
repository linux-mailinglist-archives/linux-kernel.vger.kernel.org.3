Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1B490A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiAQOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiAQOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:37:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57550C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:37:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g81-20020a1c9d54000000b0034cd1acd9b5so2112000wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vQvlRkBG8jyAFRkdJw5QqA+mnvGAb10rlLjyuN04xs=;
        b=QjEdn1V494YIOgy22qdp6vDH5BZPbC+l+4DyMdnaxhOsSomlH3tJ3xiazui+zjN3Zi
         yfy8cV03n9ak5nStGvMoXx4ezcKXinKQUvu2ibsFQbmAEZvtUEJSL26lWX+1bBACIFzj
         Kw7kaqcJ32ykROt5YjJ+EQQ0u1jT8rnn2Shgbnw7/N30GpIWtYDOgbjV86asy9fBM0Al
         m4ujK2sK+a1huYIOlrurQJyS+zEF1el0VI4xrkqmCFNkCQ5IKROkvdfOiksT2rarMBKp
         QyA9qCMCZDLcaTaMIPu4hK1BpRWOonYu5NYf1eB58VXO0lQ6Yz7YCCCcijaMH3bSvF8x
         7iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4vQvlRkBG8jyAFRkdJw5QqA+mnvGAb10rlLjyuN04xs=;
        b=CPke9th5oiojdfhpGLxICx7yFTC+GkZhiuav//lFSVKybf7XrHRD2DGD9TkRnXGwcq
         NWp+44gvERai4wULSNfvSy+4r9MIiRBkNRWvR/TvFeeCLQ9+uInd7pBzy1Nb9YeN6O3a
         sveDo38U9RvgcYZJFAf3ejGYpptZ4dNZwsrpf5SMyfRiEAmQ9FsRn8WBgrSg+DIHf1cS
         l4cZDmz8nn+MNhHYxutxRtykd1q23Z33q+jeIJQ1SkpHmYfKsIXgjGSItOQPn0xLrWcc
         FqXJkdlr5kaCCAcUDKaJnVMEnYZtGkMycH7v0JyTcss0pj/4nLJyj5NZd+ERYdpnSjG3
         S2Lg==
X-Gm-Message-State: AOAM533fgqkdIlmyCAQZ1hu1QcP/qk5BCiMMkAjZWb26qybtQ70hqulQ
        vOCTcGdYgu1SY6yREYEoGxzzGKZ3kH33jA==
X-Google-Smtp-Source: ABdhPJwqlv7WG3XoYbvtpmNzZ7lMwU5e5dYWkiNHREnVczkvwGQlzQCCr5goFgi16xexqDTyavAgjg==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr19119203wrp.90.1642430277417;
        Mon, 17 Jan 2022 06:37:57 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:c004:9fe1:fbda:2d0c? ([2001:861:44c0:66c0:c004:9fe1:fbda:2d0c])
        by smtp.gmail.com with ESMTPSA id j9sm14444458wms.0.2022.01.17.06.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:37:56 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to P212
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220113044546.16856-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <aa02e3f7-3f77-4b9c-74a0-987045de0352@baylibre.com>
Date:   Mon, 17 Jan 2022 15:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113044546.16856-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/01/2022 05:45, Christian Hewitt wrote:
> Add initial audio support limited to HDMI i2s.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> The P212 dts is widely used with Android box devices that follow the
> reference design. The real P212 development board probably has many
> more audio capabilities, but as a minimum we can enable HDMI output
> and help box users too.
> 
>  .../boot/dts/amlogic/meson-gxl-s905x-p212.dts | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> index 2602940c2077..a39830379c74 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include "meson-gxl-s905x-p212.dtsi"
> +#include <dt-bindings/sound/meson-aiu.h>
>  
>  / {
>  	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
> @@ -32,6 +33,45 @@
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "S905X-P212";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&aiu {
> +	status = "okay";
>  };
>  
>  &cec_AO {
> 

The P212 ref board has an analog audio output with a DIO2133CT14 amplifier unmuted by default with the active high GPIOH_5 to mute.

It's very probable all the STB boxes uses the same scheme, so it'll be safe to add the analog audio output here exactly like libretech-cc.

Neil
