Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DEC51F5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiEIHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiEIH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:29:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BA21ADAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:25:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d6so15173305ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ffn9G0lVjAVw7VY7Gf2gVJa9bJPx61VNfBkBP4QKUhg=;
        b=k5iU4+wpkI+gckTEyQH4UBbPHXsLPXH18PiLYdBl7uzRbx2ZqyT2op2yR7RabsO5sl
         cq/bJYUju0o/GmAfREaayXamQwFhL8YqhzC8DWuq+eeOORl9FqAOQrIUl0wSMy6QuNuc
         iCvDsShVxcJiy1+NWH8xT+RMYngLYWvMHgMf4T6He/YIjjmMr+GXNdUTS8MV2X/EASlh
         nI/w+Dku3ZrXh/CItkCZ/o8/8JNmYxJub6JtAvkEDKQto1EtwhpHVglffKEsfoUaLAOJ
         cfhzmwTtP7fGOFtHVo/RKo036vEwgSqEEAWJjKEu4dvGD7VA/OpiP7QaLMUXH9j60IjC
         QZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ffn9G0lVjAVw7VY7Gf2gVJa9bJPx61VNfBkBP4QKUhg=;
        b=ZqC06+1ulFLAPdHVeYK1ngWu+h1TD+u8yIlwkqIwwD2VZX93wxZ+0IiI+gFlpmJBul
         3O1reAWeOxY6EqCe6EyYIq+2rJWu9fm6boykp8zDUfHZJL4r0+LVTigF8qyfkQIVSNy5
         HWlTveJ0XnJw4+aFW0IT6SdyZeaUmoMfzpN+Ac7EitSXhpxHi6xkuZxTjH12jC3AjD1C
         A1gvX04skbS6w3xl4O3PhbMPQ7QYnZdcpXHVaIkIUj3UnPEcW4800CH0T60EJkYaykqN
         ho9rKV7io8DpM1XaMupwoxxdBVrRf/Pi4+qIc1BhBTmHtGM3SOSRWJ862u6yWyZSBrjC
         SlTw==
X-Gm-Message-State: AOAM532X/QKcDJJYjSsnV120fV7ziDCE+LglI7f6VF6HMGOZ2oE9VjcY
        B0eEk57W3gH2WzQNHyzlmNW6bQ==
X-Google-Smtp-Source: ABdhPJyLrNXAR9V95KOmH7TaGfKkewtlQeguVyMLABaxdfoHqhHBGdvEKNPUSXI80M5LoO9ChLiQxg==
X-Received: by 2002:a05:6402:50d2:b0:427:f49e:71a0 with SMTP id h18-20020a05640250d200b00427f49e71a0mr16020611edb.211.1652081125192;
        Mon, 09 May 2022 00:25:25 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709064cca00b006f3ef214dd7sm4788853ejt.61.2022.05.09.00.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:25:24 -0700 (PDT)
Message-ID: <422bf3bc-7787-97dd-6ab4-7570e5ce2ed8@linaro.org>
Date:   Mon, 9 May 2022 09:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU
 compatible
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
 <20220508202544.501981-2-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220508202544.501981-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2022 22:25, Nicolas Frattaroli wrote:
> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> encoding. This patch adds a compatible for it, and also allows
> the bindings to only come with a vepu interrupt.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index bacb60a34989..4045f107ca4e 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -22,6 +22,7 @@ properties:
>            - rockchip,rk3288-vpu
>            - rockchip,rk3328-vpu
>            - rockchip,rk3399-vpu
> +          - rockchip,rk3568-vepu
>            - rockchip,px30-vpu
>        - items:
>            - const: rockchip,rk3188-vpu
> @@ -40,6 +41,7 @@ properties:
>    interrupt-names:
>      oneOf:
>        - const: vdpu
> +      - const: vepu

This should be enum (for both lines above) and you should add
allOf:if:then with a constraints which variant can have which interrupts.


Best regards,
Krzysztof
