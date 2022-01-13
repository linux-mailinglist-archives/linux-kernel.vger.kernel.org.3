Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880AE48D5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiAMKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiAMKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:39:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A9C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:39:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t20so1788718wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6v29IF5ynl4LtatwkL+aWAs6JBK13MEYBvlVFMZquU=;
        b=5E/rRDm8VAePAEyXX2CiCjdULP1GlaSRlCL6rP1OFm9NtTcT/ZfHPSri7GAsFYooGM
         e2qNDpxVfENa2JMngQsDUOjXgZ3o5XLR0qX0fgev0eMWSDe0Suu4v5WNdQE4UDR0mXXa
         kkKHuxoejXna0MEXcK4iXXEpfcEqg9UG7JdiILDdWWIZ8ceKfXzhOmHLN3imRfvKC8VD
         SnACzgmeN3L1Z+W4gevDeBd0yj4MAmFBfDu+qM/w3B5Xjs1hskbyi+RkG7h/JE69UMIU
         9TUgJD73bM3CaCNrP1KwcjKvQwl39rjNWnQVm8osulfvAcS4cazQgb75PcZOrpgSAKoj
         B+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D6v29IF5ynl4LtatwkL+aWAs6JBK13MEYBvlVFMZquU=;
        b=HDjWnB99u/zAFucpDId+HPov6BjjI9Nqb5doa3YS2TT0peqAOEBRMREWWnWqlceqIb
         68yT2KBThS7nIg8dTSh9y49mg4zbOgIsYlZToTYTuiG4+jWKS8DntirXy9KixNMoTQYp
         OUGoMoMsPp8og/j2F6qvQw/r55IkRaAGtEo71+Wf5znuQPIz5c6F/DeLiyctGR8scB1B
         KQYda0n7g8oc33QY9CoWTLLAy1TZuvdHa2KiJdBFBoHWki8XFhrgdP/oumGI7YdLEqHb
         6/rVCs32u6VeDtLZbnY0C8EXytJoOl/q9WMlWh8pKNRFcjy+CFipNpDxjxyfsFWlNWHu
         YTsQ==
X-Gm-Message-State: AOAM533sVPOL8/7d87R3gYbKnE7AkvD9NN69cQrd0D7r3vP4eUbPB1Nh
        qvvTAwGSA/pSz8u9dlwvQ/fsA6JoMMoFqQ==
X-Google-Smtp-Source: ABdhPJz6q0lW1Um0SBfgQk6QTnCEXbTZmY8UEIgCUZe0rFIhVUDt/FUZhC1I/awTcNLmGS51ZbyFQw==
X-Received: by 2002:a05:6000:1d91:: with SMTP id bk17mr3370944wrb.684.1642070388799;
        Thu, 13 Jan 2022 02:39:48 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bece:ab45:7469:4195? ([2001:861:44c0:66c0:bece:ab45:7469:4195])
        by smtp.gmail.com with ESMTPSA id y4sm2667120wrd.50.2022.01.13.02.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 02:39:48 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: amlogic: meson-s4-aq222: fix waring for
 leading 0s
To:     Anders Roxell <anders.roxell@linaro.org>, robh+dt@kernel.org,
        khilman@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220113102746.598763-1-anders.roxell@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <e0a8be1b-025f-a599-0298-3521066860b0@baylibre.com>
Date:   Thu, 13 Jan 2022 11:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113102746.598763-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 13/01/2022 11:27, Anders Roxell wrote:
> When building allmodconfig the following waring shows up:
> 
> arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts:21.18-24.4: Warning (unit_address_format): /memory@00000000: unit name should not have leading 0s
> 
> Fixing the waring by dropping all the '0' except one.
> 
> Fixes: 1c1475389af0 ("arm64: dts: add support for S4 based Amlogic AQ222")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index a942d7e06d6e..8ffbcb2b1ac5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -18,7 +18,7 @@ aliases {
>  		serial0 = &uart_B;
>  	};
>  
> -	memory@00000000 {
> +	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x40000000>;
>  	};
> 


Thanks, I also noticed and fixed in the commit directly, it should be fixed on next -next

Neil
