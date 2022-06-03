Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDD53C628
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiFCH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiFCH2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:28:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3757B7FF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:28:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q1so14282931ejz.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UiKl1D3+pwktIaSMQTL9mSrntfBBrXE+DPKJRbP2o/w=;
        b=eR2EYbPDHjP6hNmdz50L11x3q7f+g7MQAMXhMpE6Eey3RqH/unJQ3qn7+yHVpX85JK
         hd9MxhzOxr8seMtBL683FgVVOch7loQWA8DWp7TElq322zNZgpdkp4O4eF2ad/wBGQ3g
         Vs65DtimXziQkPpX9tANbwC0u8Oly+0+uqlnNvGxb0jUu/Q4TOzgAM50WqpaLPQ8FuQg
         iM/ck+Mqgh5Fm6RCDvRWwfvJABGdiNbzWop3hjqHmzaRXJG8F8oBk8hkMy5WHaD7VA17
         9jRLRBboHGxNw6f1M/3emOx8o0Spo8GOwZgEkXG83q4U1pb93HfVSJGSdsArmCZr7Nto
         NruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UiKl1D3+pwktIaSMQTL9mSrntfBBrXE+DPKJRbP2o/w=;
        b=YN37flok00MmVyrrHAqWevzy3bWYjtxxdcPt7Am54Ra1kP14LUGmU4FXRJjnWjInI9
         6hGmu8Zd0B4jOfVvmIzNPMey3ksUSzzBApQzHoln9A5v8DawK5qnMNuGoarW9+/KM014
         swFgznaiw6U+JglGtkS2hTrBvMbM7YbGaUl+67S0lBhHPxWb2DIk1hWA4/QZ1htIUP6s
         hCJ4do7yVj32o7VRiMkxuUf0ZcQiBVKbaJx7DkYv7lo//mx1xQx4StIvzFAxEn6hO0JV
         yg5F71MfT4M3nVwIOf9WLAAUnMchBVHNV76GEHUJgu2HDaiD0fDlc0PLJmeajmQmSW5j
         DUnw==
X-Gm-Message-State: AOAM532O9kRDQpBQ6jQDKOhd2B89X2YKLd7iAudCjeEFqfvbbWi6PodJ
        sooqVW52j1KPh/lo6PG4L5d/6Q==
X-Google-Smtp-Source: ABdhPJytXhjJYZraGHGdapMjrFiVu/AhMBQE0aDS7xbtPzsUJ3Zx+bqjJ3RvvCMQGMwViBu7evHOoA==
X-Received: by 2002:a17:906:85cb:b0:70b:ffb4:b0e with SMTP id i11-20020a17090685cb00b0070bffb40b0emr4538677ejy.533.1654241308308;
        Fri, 03 Jun 2022 00:28:28 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ck11-20020a0564021c0b00b0042de3d661d2sm3531068edb.1.2022.06.03.00.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 00:28:27 -0700 (PDT)
Message-ID: <7374666a-212f-76fb-4626-386e46f74cd8@linaro.org>
Date:   Fri, 3 Jun 2022 09:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] dt-bindings: altera: Add Chameleon v3 board
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com
References: <20220603065816.87952-1-pan@semihalf.com>
 <20220603065816.87952-6-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603065816.87952-6-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 08:58, Paweł Anikiel wrote:
> Add Mercury+ AA1 boards category, together with the Chameleon v3 board.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 5e2017c0a051..4a08c082dbdb 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -29,6 +29,14 @@ properties:
>            - const: altr,socfpga-arria10
>            - const: altr,socfpga
>  
> +      - description: Mercury+ AA1 boards

This looks good but you also need to remove enclustra,mercury-aa1 from
previous entry because after your changes to DTSI, it should not be a
standalone (final) compatible.

> +        items:
> +          - enum:
> +              - google,chameleon-v3
> +          - const: enclustra,mercury-aa1
> +          - const: altr,socfpga-arria10
> +          - const: altr,socfpga
> +
>        - description: Cyclone 5 boards
>          items:
>            - enum:


Best regards,
Krzysztof
