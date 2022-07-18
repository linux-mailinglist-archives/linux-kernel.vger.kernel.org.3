Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1757842D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiGRNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiGRNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:46:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815BB27FEC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:46:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e28so19383584lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1Ca4WmtOXZ89SSKgkCTyyeuFvpbtZ/WHhtifhXbvcEo=;
        b=rb1wVT0dKmKGL97pEjcvYwz/fhSAmZNDc0P4/hdcXz+Fufj0XsGMDTNfdqNosxjrb/
         57AUxgA+P0U6Qi3HPr/LuS+AR4VkKsWCyA3nOiO25zhwMGvWP6UHSZgZ3Kkgy48b1+/a
         iLXztohSBaWRIPlwjdgq9YjDCDE6RuSc76qJYd2/OZxeK80wgSdqVtbWZvtpnPfku/XF
         7X6oOZAigrmYDSv/I5NK2Dj56r7N2aytqo2F4ObTzgLgtL1eADFzIkKVIhNiv040iT0A
         /tB/gsbgZM3btLohUMcR3B+lDMnBgC/VKIacpgbR1w/m3CI3LZr+AYCfbZntDqIXGPqf
         /NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Ca4WmtOXZ89SSKgkCTyyeuFvpbtZ/WHhtifhXbvcEo=;
        b=RBAmoAPcdf66l/jDi9AD1Pph6uU6N7pP8gQbDKp7gPuDJHsUn/8nQJKbudq+5of1+E
         5K6fZAykf969EdZG/1XH+gVLKPkbBkUVzYisavfs7iVqquci/RAToZcF9teVMJFTa2KA
         FuHh05Wc/a48yePT75LKOseIvBKLvhlTWWHNAq+UalGfIPfs4NYoJbGYu+/XeF0nTF5p
         PaAIjiCJ9uTL1ATvdoyhyAAjFQaxhxiDG+fFeH/3qE1BYBXhQ7AQU8TaiEXPjaz/IDv4
         yYt7x2DhsjkDi1f2nle6nlM7XGn15F8W2rPOKOYTz+Fv2v3NSXAwkbkcgKR3wXZ0zIE+
         kAHw==
X-Gm-Message-State: AJIora/i7xKYfxFvw+QI35wxn3piwCVGTkqCZwWY3KPYXZ0DIL6KYmeV
        xSF0ZAqfso5VIml/4nXSp2AOIw==
X-Google-Smtp-Source: AGRyM1uONSabiSDCR4AmrDqvp810Jrfu+iudY40VuKCfH8AAfC6slMQ6f4KBsjQXUXAjBHW7qOTadg==
X-Received: by 2002:a05:6512:12c9:b0:489:fa6e:d371 with SMTP id p9-20020a05651212c900b00489fa6ed371mr15583105lfg.37.1658151988393;
        Mon, 18 Jul 2022 06:46:28 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id q9-20020a2e84c9000000b0025d4f025ab9sm2112445ljh.70.2022.07.18.06.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:46:27 -0700 (PDT)
Message-ID: <6b9ff2dd-fa49-0e3e-f832-5af903749aa3@linaro.org>
Date:   Mon, 18 Jul 2022 15:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Document samsung,matissewifi
 device
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
 <20220717213432.134486-3-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220717213432.134486-3-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2022 23:34, Matti Lehtimäki wrote:
> Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) tablet
> which is based on Snapdragon 400 (apq8026) SoC.
> 
> Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..5a24dfd66823 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -104,6 +104,7 @@ properties:
>            - enum:
>                - asus,sparrow
>                - lg,lenok
> +              - samsung,matissewifi

samsung,matisse-wifi


Best regards,
Krzysztof
