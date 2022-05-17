Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E152A0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbiEQMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiEQL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:59:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95B43AC9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:59:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so34151739ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=We6UnTkt5DfPq+wuwoB7alfZF2Hv9K3HgKR2Inooa2M=;
        b=mJUxow8TJYLd1QWdt4w54y14ncU32yxMoU6rAuy9WcO3jRkd7oe7jKuPrsY2rNm5sv
         1BKYohHd6rUaSdXm5PduVz5YYYj/WNzO1gyqgmznJEr4jwUuuz3xIIfspVy5iZUe5YhQ
         q1l32lRbVlLMCItWsIhV1mU6rnPvfK9fwRKkgflcgf0VpqLAtfHpwQNu1WE3VVurFdsA
         iBr7rfZ/WlcszsTo/UvoSvzdkTYmse0qFb60Qb/YjL/eEzexO99zZrjtWGhYLDrKF3fj
         La5T7bT9WybG4SiMlalfi1G9RI7UsOsibH+sFHt0JGH6m7rWrDkSKzp3bJrnWouYmXzX
         QPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=We6UnTkt5DfPq+wuwoB7alfZF2Hv9K3HgKR2Inooa2M=;
        b=iObmiw3hV+ecMmkNZFa9SWvh9e5LX3CCE5ND09IznXK2hkZJW4okJt5f/rh3b3q/yi
         enb4X0I7cpei6kKR06GNhvIF/vWEFKCbHjkQ2IfzrNdBwhuNHApx3rkDToY6SRN+aCFV
         wEHYv1j1MP7X2J3rDWECPRps7//ym+tsYXNTCD9l/yDCJy8ig6B3du5lyzRWqSYpvq9W
         POvewIPXX4kXMk0gxlQnWrFyPd+CqmebemtdvmHzfUEERbt4IwAvyx31Hw3w0o0HB4v5
         6W1oHZsh1t0RFHXaH/petLnRoUfNLggO0WME+x5gYkdCetSRWarA88SPQNFAIH23Hd+B
         lgPg==
X-Gm-Message-State: AOAM5303Tf+ZrntBysLQa6aKpVRrkVpXDyxuvGmCxiUwcpmeK09LM1gS
        EnfxaiBhHa/Idoy7a+T53zge8w==
X-Google-Smtp-Source: ABdhPJyvwVUAbJ0QXLt9/CxdM+HPOyaIV1T5I4ZB9Qx0sEtfYLUok+mJqrxKP1RTakPh02MMo1ynRQ==
X-Received: by 2002:a17:907:1c9c:b0:6f4:2918:5672 with SMTP id nb28-20020a1709071c9c00b006f429185672mr19312685ejc.439.1652788777021;
        Tue, 17 May 2022 04:59:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id eg16-20020a056402289000b0042abb914d6asm2074448edb.69.2022.05.17.04.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 04:59:36 -0700 (PDT)
Message-ID: <96973d1d-c52c-d190-6989-3f7996dae70b@linaro.org>
Date:   Tue, 17 May 2022 13:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: Add USB2.0 device controller
 node
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-3-neal_liu@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517082558.3534161-3-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 10:25, Neal Liu wrote:
> Add USB2.0 device controller(udc) node to device tree
> for AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 3d5ce9da42c3..5517313eb2b5 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -298,6 +298,16 @@ vhub: usb-vhub@1e6a0000 {
>  			status = "disabled";
>  		};
>  
> +		udc: udc@1e6a2000 {

The same as DTS in bindings - generic node name, please.


Best regards,
Krzysztof
