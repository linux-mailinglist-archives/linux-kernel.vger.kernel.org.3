Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E785608E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiF2SRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiF2SRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:17:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D93A705
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:17:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so23305797edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E1jlEoaTPiNrxpMd8CbmD+GquuR2xwFVd9hdNuD3pQg=;
        b=IMgvJNI2Shu2YS7FRrkuNOoKotUuk+Gd5objaOVBsEnVVBB82azq2pGZzKy08ce5Lx
         0dOVNDIzkmGnqX/yNuK3G8TvwkXyoasGPPmGvgdX+1+77T71yGeQ5OqLqj2Qzh9xewZS
         t04/PxMPqgs98zQfD/f6firmFl2/Jpa/GQVaeERfF/5tUwQlxw2oyQpvMlQvnDlDL+wd
         PFBmY73Ho1OEgMtY9IYc+dGr2MFHeS+wR/rSD3BcziClhyjTE8SQRfu1XtYOHGIOD8e6
         C4QnGx/WivSfHEB2ayQrwSP/fX9Gqi6iU0TE8FBzTtsrBsPxJEXggml4VvpwKNn0+RCZ
         9Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E1jlEoaTPiNrxpMd8CbmD+GquuR2xwFVd9hdNuD3pQg=;
        b=7YQjQrAumhkMyHgzGUWct9u0FQ2brR+C1Zh5ctfemq8YqDayTb2VXYXzymyhsh8+tu
         IZx3x2YgmM1gfcPXcVJhW/BII1ULDVmcFjfO9+pBcjEB5XMJyxwR+9TgwvgnJNsU/ToU
         DfIvNMJ1AXlz43/h7vIB00JRXwC44PrO77wFgFMa+YQOw46g9Zr7KBbFoSa6P1Wj+ZT5
         tcXn3H+awqJ67xxQ/zXhVCRb9hkvWdp1sbUJsHXmiRJGwKmieqXSn68wPq96IWJjfHsb
         Z5EUQz1GlqOsaRZzeCI2X1E7sYRTTPGEC1ObEDtrUOFOgKz1HO1E/8OS5y3nBi+P2B/p
         8IZw==
X-Gm-Message-State: AJIora8V9LgkUkZoswXJRmm7LUz6+2ujWaPzKchjP/Zz6el9YywDPwFL
        fW8AQK2Q1dLvw+ZVXbWVZNE/1A==
X-Google-Smtp-Source: AGRyM1tqWVzV1AZV22fnO/A7rGjKFDP+PsQHU5xoa8tsJ3MnfAUQCYmOGVMe/tTQ+u93YZGrhNA4IQ==
X-Received: by 2002:a05:6402:520b:b0:435:c2a4:f822 with SMTP id s11-20020a056402520b00b00435c2a4f822mr6209482edd.198.1656526625454;
        Wed, 29 Jun 2022 11:17:05 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n4-20020aa7c784000000b00437e08d319csm555612eds.61.2022.06.29.11.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:17:05 -0700 (PDT)
Message-ID: <506c9d41-6808-64b8-f57e-380d4520cc0d@linaro.org>
Date:   Wed, 29 Jun 2022 20:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 04/15] dt-bindings: gpio: Add AXP192 GPIO bindings
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 16:30, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> new file mode 100644
> index 000000000000..ceb94aa2bc97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +

If there is going to be next version, please drop the quotes for these
two. In every patch.

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
