Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FC53E8BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbiFFMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiFFMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:54:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579B252AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:54:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id me5so28254185ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zSWtlPJP36ORYOSSEGdXjiEBg41sfQK7fjIGlhhOsv4=;
        b=ohH7X4O4gfbSAOd4Lxe/JDB2Yg4fnSaAo6bBsnNdlicr8huPh8WTvgc6hdHfL50WvH
         wVUGSLm9xAb8s1RzQqdeyLh+0R8rCX+bNlGSEUVryCEgqwZxvpUkN/sHsZot64pVzUSr
         +G5szJr7atoS0Z52yWU8ikh1n3KcKJvkaBbUG62CyI7NI8lOUjjI5FB6Wr9ck6d9Mv2R
         9s3VfJN0N73dACy7RVZ807jdv67u4GczFiLGHXmxnXDn2FRXV46DsP8Z0obZWNahrKEw
         AYP3p/d5bqKtGEANvK0DKqc8YRlwEfFqpXFqDeDDMy9YQ64CjPtfyp4myp967aj/IxBm
         j3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zSWtlPJP36ORYOSSEGdXjiEBg41sfQK7fjIGlhhOsv4=;
        b=JWhvHcjXWqgA58eHH6dP3q9dL8YagCuOuiFERn5BEsNnI8r5FcYSxGGypnQDXo3Noq
         XoWwUBQYAl+Lw5K7Z4fVxNYykdwNrW4ci5B0Lsn1l4CgHsuPMTtoqyxMtOl5M62kG4zO
         aArMdk4ewSW5X6i8cPnWPjuS6ECfFshcT5ycXJDQHwDOrjIlleRRibga0Vsa27LKh1ew
         M5eA2+UkPcz2xPZkgECVaWs1YVvu5yLLLWpauUVN2s/uQP9NpKFKmIgkybTsYEgyqTxi
         8mkHODW9cFZdzC3txTgoAfG9SDP8sHB2vhPFKgLuFZM68u2cFRx3mnZQ0yZTSF0JlM5R
         kjhw==
X-Gm-Message-State: AOAM531CJk1TtC5mZp9tSlDxd8BW51Zqt20Nuv3CFon06y2AY/Kpq0eD
        DolhWIGvf6sPsdVbWHQgGFuZVw==
X-Google-Smtp-Source: ABdhPJyPPzcXaQmBcA/vX+SWRT3t+CpQ+4vwiWmzsqQBRttf3RbMfRiW4DKpHFbPTsiZVUQvVzaL4Q==
X-Received: by 2002:a17:907:2cc4:b0:6fe:2100:de21 with SMTP id hg4-20020a1709072cc400b006fe2100de21mr21217971ejc.462.1654520062876;
        Mon, 06 Jun 2022 05:54:22 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090791c400b007109b15c109sm3119325ejz.66.2022.06.06.05.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 05:54:22 -0700 (PDT)
Message-ID: <fc350cfd-e9c1-e29e-392b-ede4fe7fb265@linaro.org>
Date:   Mon, 6 Jun 2022 14:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 RESEND] ARM: dts: nuvoton: wpcm450: Add missing aliases
 for serial0/serial1
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220606123529.1738542-1-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220606123529.1738542-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 14:35, Jonathan Neuschäfer wrote:
> Without these, /chosen/stdout-path = "serial0:115200n8", as done in
> nuvoton-wpcm450-supermicro-x9sci-ln4f.dts, does not work.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - mention WPCM450 in the summary
> ---
>  arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> index 93595850a4c3c..57943bf5aa4a9 100644
> --- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> @@ -17,6 +17,8 @@ aliases {
>  		gpio5 = &gpio5;
>  		gpio6 = &gpio6;
>  		gpio7 = &gpio7;
> +		serial0 = &serial0;
> +		serial1 = &serial1;

Serial aliases might be wired differently per board, so this should go
to board DTS instead.


Best regards,
Krzysztof
