Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DC4AB046
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiBFPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiBFPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:35:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44210C06173B;
        Sun,  6 Feb 2022 07:35:51 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u6so22282317lfm.10;
        Sun, 06 Feb 2022 07:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lXH9W2UPYnqV3aAat/o8IqUOFsVADH6rgPsLKGvLDNw=;
        b=YpuqMo0/ZVHVPkxA/ddPz72Wo0vzlX3wUJiTWGevARBQDfOpYTwBwWe0gcU2+NKaYk
         RxDUrPyXt1iYPgt3Eu8buAKGyQ1Wj38K1cV/OB/yDcKLI1v3otJVoZvjz3jw4g6jZPb6
         3nvS137TwRxStoNb4FDHglQLHGF6IGuxnZR+A+Ol8umrLfB3/Zsmbft0ZPQ8a/tJpWyp
         /oo3L50nEPHSjT1HLTYK1vHq5dt5b3plSDD7kBy9YWcjCuc1Z77qRU3BQlErt2aQPlae
         7OMaeKtzqmdlaT5BclZMrf6vvAcBPe466QvyYaV/u/AZyzkUDktosCUNMqf/VrZxLRou
         pWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lXH9W2UPYnqV3aAat/o8IqUOFsVADH6rgPsLKGvLDNw=;
        b=NNLouzNRRzvlA2uu8yM/bK/7t0MC1A140wh08Fkbwq6kJ14rJNGT+xTe0qhUhTWVJn
         1H5RnuZ+9khRHtLJoNcQCCFxby7+4aPpY7p7XnpxgL89J+jQfEaO7+sB3+X3eNUD6DIa
         ybGUB51+cYtQXb0CDveJFmJfZm+aY4YFv9kVW9SdcwXUr9qzv/oSAZvQclI1wwbnywlh
         771LDv+OEHZRfLDG/pUL+r/VELjwa/rw0AVV/6DjfNrz04RipXy8MZheFamPvx1eXqBA
         Uba+aaJd1B09tAzFRvhUPTmCgERCosOdnGcnGP4EBh2kw8kpEQqZ/UamH8vEn9Wyk9cG
         mTUw==
X-Gm-Message-State: AOAM532+jdMuwqpCXbioQQhs9xzY5Zk06qqgwGJH++8IoIgqlrVcAiDc
        9+slgtx9ioyEvNtJUSN204Q=
X-Google-Smtp-Source: ABdhPJxc2cNeHKXgw3XaDtDkn1pg8+BRyC2PfbVRpVXxUhMCENtGewUFb0Z4gBJ8D8RSVl6ao9IvTw==
X-Received: by 2002:a05:6512:3f13:: with SMTP id y19mr5658866lfa.25.1644161749697;
        Sun, 06 Feb 2022 07:35:49 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id t10sm1129565lfe.215.2022.02.06.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:35:49 -0800 (PST)
Message-ID: <255e0ce7-f9dd-8fa7-db5b-0dac69310ed6@gmail.com>
Date:   Sun, 6 Feb 2022 18:35:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/8] ARM: dts: exynos: remove deprecated unit address
 for LPDDR3 timings on Odroid
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
 <20220206135918.211990-1-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220206135918.211990-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2022 16:59, Krzysztof Kozlowski пишет:
> Passing maximum frequency of LPDDR3 memory timings as unit address was
> deprecated in favor of 'max-freq' property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 2f65dcf6ba73..35818c4cd852 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -333,8 +333,6 @@ samsung_K3QF2F20DB: lpddr3 {
>  		compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
>  		density		= <16384>;
>  		io-width	= <32>;
> -		#address-cells	= <1>;
> -		#size-cells	= <0>;
>  
>  		tRFC-min-tck		= <17>;
>  		tRRD-min-tck		= <2>;
> @@ -358,10 +356,9 @@ samsung_K3QF2F20DB: lpddr3 {
>  		tCKESR-min-tck		= <2>;
>  		tMRD-min-tck		= <5>;
>  
> -		timings_samsung_K3QF2F20DB_800mhz: timings@800000000 {
> +		timings_samsung_K3QF2F20DB_800mhz: timings {
>  			compatible	= "jedec,lpddr3-timings";
> -			/* workaround: 'reg' shows max-freq */
> -			reg		= <800000000>;
> +			max-freq	= <800000000>;
>  			min-freq	= <100000000>;
>  			tRFC		= <65000>;
>  			tRRD		= <6000>;

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

