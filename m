Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73B648BFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351612AbiALIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349434AbiALIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:30:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349DC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:30:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1046969wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ+w22PTxUPaJcKWhY/UceXma5p+nqWWd0Bsmebx8pQ=;
        b=IeeX2Is5svan06jOKIvq/96afdKfJzhzUKgHhQ0u3wtF46c8hjl3h1OBkqD4qXrQm0
         /KbWT6JaUOGhdO0C+JbtgZonOP1rb8bp1Jt6GiSUz0jpJ23IbDPBZ9CTtyY/rzrMBR+B
         aCOFCWREcEAk27MX53Tnv0n4CVIEuvSpIzMigVMQglVkTxGoC0xN138aXE6J8fSBJjqI
         pKpcMP/FQhH1tlN82stvigaOWpKwkwzF6BUYLwqlgv7HCTrGv6zRllLN/MC/WWt+X0gl
         xjw44EEjrXtd4Dl9g3SLB2LSTF8BfR3cOcFnzbTHLq3yoJE++xNvbhq15kZrZi2iMBI2
         umOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vJ+w22PTxUPaJcKWhY/UceXma5p+nqWWd0Bsmebx8pQ=;
        b=QjE9S5TlqEv8ZMEuPm4q5YqZGWTJ7PLXS5JR8qtDDjuQmc/OuO0ouSLCDR9nstTVUw
         QInTR+zj+t8fDYxkG40I1VIXYXxDXJGZTaAvXTtMvzVGbe4BwDl1GVV15dUTE8pea0QK
         lZ868RlLBNnnWcFa5rMikUWLXTuhXwBeIWJNz8tfW1vChBpCS5qHEet4F4gPAN0qCbkK
         oNBOFv0R2jd9RatTCDPSn52wkZioJS9mSZZMWgQLWPJvUlwIXdj0FzPzPsg1lGFJZBrP
         jMJh7/0Ibp6MNhIvmIibTrsXsVY7ifdqxGtXIEnixZW/1NrQSWGa/Yvl5dlhLM7p0b/Z
         CBvQ==
X-Gm-Message-State: AOAM531aei4FbV/RWdGG2InYkDw7IXXlha9ofRYJJ+UlNlmSyXiqyZTy
        WtdgszX2CDk3K0XD9Jr7cf6W+sE51P3d2A==
X-Google-Smtp-Source: ABdhPJxLOO/vJS+ah4oOFATT6onrl/OkLjwtx4tPEXlqChpCptI4FLbhrbta4n/T6Sb+KXZ8/ItwFQ==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr5616827wmq.152.1641976255095;
        Wed, 12 Jan 2022 00:30:55 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id q206sm3981739wme.8.2022.01.12.00.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:30:54 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: meson-g12-common: add more pwm_f options
To:     Gary Bisson <gary.bisson@boundarydevices.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220103154616.308376-3-gary.bisson@boundarydevices.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <a4282cb9-3ebd-0c95-7a47-522eb1bbb770@baylibre.com>
Date:   Wed, 12 Jan 2022 09:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103154616.308376-3-gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 16:46, Gary Bisson wrote:
> Add missing PWM_F pin muxing for GPIOA_11 and GPIOZ_12.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../arm64/boot/dts/amlogic/meson-g12-common.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 00c6f53290d4..af1357c48bee 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -894,6 +894,22 @@ mux {
>  						};
>  					};
>  
> +					pwm_f_z_pins: pwm-f-z {
> +						mux {
> +							groups = "pwm_f_z";
> +							function = "pwm_f";
> +							bias-disable;
> +						};
> +					};
> +
> +					pwm_f_a_pins: pwm-f-a {
> +						mux {
> +							groups = "pwm_f_a";
> +							function = "pwm_f";
> +							bias-disable;
> +						};
> +					};
> +
>  					pwm_f_x_pins: pwm-f-x {
>  						mux {
>  							groups = "pwm_f_x";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
