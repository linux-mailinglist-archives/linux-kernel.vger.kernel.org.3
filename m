Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212E949DFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiA0Kqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiA0Kqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C457BC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s18so3933784wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=INQLM7jSRCzBoxfXW9jTTbSbm/ueqhtFo7lfbZC+OTA=;
        b=ubIxn1E+uNN1vDY8MebsAnQ7GuteGrFXwuGBUEKfvEdrfcixd8B/PL3c6z249JegoI
         UB+w1mUpFo7WRUInG4yAS/VwFV6a02sedrhPEFAhzYmlRMaRbmFYlHRqLksIa9PC7HNU
         hPoZrEllCxxNU4IdjpwWXJUM0TxbEwDARYj5b+g/SKG0IJRgrnbvGyJP8thtdHaEHjAw
         PMd7tq7fp7skgzU7VW3YLI0toF343PGWT33l/q8qGNRrghmUBOSZnQCac/vvAaIhPWu1
         hN4w138udbtDxqSo0bW8vhRWASaC8l5dbhwWAyEHr01HKVx8tiwWy8pC+W62A0IvyO5B
         zA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=INQLM7jSRCzBoxfXW9jTTbSbm/ueqhtFo7lfbZC+OTA=;
        b=UsE/wV0tdUOY/YCv/eNMyBdc4sH7Hhm2XWDoEmBZuCcOrvddxcFqNTp9VA8aHyGdxu
         bZ0prs4W1BEPbNbU7VZkIoePS+EMnpfbTf+6vEQcfhxv7cDEwcxFernmq7SZnVILGPpw
         Ipn07rn76MHs5J8r4qhcjrm4Oz03B6rXdYN1aLXUb8EorKOQabtGk6PW79+ZIm27BMdd
         J51OytFa9c1aybA/ShSDboGiuzASmKVXENxM+Einu/dVciRDuxjE6QaYBNVDaTxkTTOb
         D3lsWheHcNL/kl3n7GaZyoZsNAVzf8BMgtMGhX1JWyYxJ9Nz//twXhi/6MHQZLQBiVMK
         Ur3g==
X-Gm-Message-State: AOAM531y1oX+ygr8nMVgXvEZUms4wNTxcexZo0lvD1+SAX1GChE3MKwv
        ZMjY02i81O2UQgDnVGpvRh1vR4dlmt35oA==
X-Google-Smtp-Source: ABdhPJyrYLuJIOBp3qeu8mqqbHMX/5mzQXLLyDocyJjjEBiYOnwetPI8LA9wboNZZFmrinmGUK2+mw==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr2473052wrr.97.1643280394960;
        Thu, 27 Jan 2022 02:46:34 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id h4sm2162389wre.0.2022.01.27.02.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:46:34 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12: drop BL32 region from
 SEI510/SEI610
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-4-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <cea820b0-5ca6-4a34-3d57-92e593785001@baylibre.com>
Date:   Thu, 27 Jan 2022 11:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126044954.19069-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 05:49, Christian Hewitt wrote:
> The BL32/TEE reserved-memory region is now inherited from the common
> family dtsi (meson-g12-common) so we can drop it from board files.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 8 --------
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts  | 8 --------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index d8838dde0f0f..4fb31c2ba31c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -157,14 +157,6 @@
>  		regulator-always-on;
>  	};
>  
> -	reserved-memory {
> -		/* TEE Reserved Memory */
> -		bl32_reserved: bl32@5000000 {
> -			reg = <0x0 0x05300000 0x0 0x2000000>;
> -			no-map;
> -		};
> -	};
> -
>  	sdio_pwrseq: sdio-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> index 427475846fc7..a5d79f2f7c19 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> @@ -203,14 +203,6 @@
>  		regulator-always-on;
>  	};
>  
> -	reserved-memory {
> -		/* TEE Reserved Memory */
> -		bl32_reserved: bl32@5000000 {
> -			reg = <0x0 0x05300000 0x0 0x2000000>;
> -			no-map;
> -		};
> -	};
> -
>  	sdio_pwrseq: sdio-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
