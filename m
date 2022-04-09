Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4D4FA978
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiDIQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiDIQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:27:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741536692
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:25:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc2so2313719ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/i5bq1sUVPZ8voo09f+RmZlGXIR3LOWZJkP8vxfCkxs=;
        b=iaRy2XeK3H+BL8S9B//6ecqylfMzpD67Z/6z7Px+5S8xwp99ZQj+I0iUV8Qp2cHoX/
         hn6b3sszVAot6c0WwbJsjnonJafv5VuJdOXIByL5GlOjfdcUk2YSRVw7pwLPyCP3DKeJ
         QDTt3L/DviaQUOex7ayqIgeSMsKga1sLwxs2AxQ69/BLPZ5fi6tK4owZieCOtY9fK+PF
         crU19/rgPa772FI+aPzd1nMtYNEcpEfUMN/AREKFbyPexpHZ0xhJuw7y9V23mIGamvkG
         bcbq/bOgssl8If7jxqGpb2FGmaQCLyz4G37IyZJ//9VqlPAALkLjvqUA4+jYOjTNwn20
         GxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/i5bq1sUVPZ8voo09f+RmZlGXIR3LOWZJkP8vxfCkxs=;
        b=bGwji+Dpgsas7hKYEgLSMLs+ghBmclk1KqyRYzZHu/+BrZyczt+hhHfs29WTLdz0Da
         7D1U1eq/xw6RSUyOSp3BUw7w/vBQeroTMIOpYb2JRGZnVMOZ3qqQ2tfj9pQiEO6IUslp
         70ST7KPRzmCCpvTLaxa+FkJWG1uVGaUvVwjKs2f6oWRmUXoa6jSSLNdUcH71Ci8emLQt
         pKPzu+Gg3WXDRINwxc/r8heiNk/OL3LZgteyP7SlVLLAFPAxKvL+98qieT7NUsjMJzw2
         hNGSstwBjhcjKtN6HeJac23wgQifmvyLXDXH9HBsoQw0NuDkwzKA6jPTSqyDGb2WI6xj
         Hg/w==
X-Gm-Message-State: AOAM531WgDi088V3P3YxognceZu0YoGBh+sGhuCkPw4h6zcDAt/2opH7
        wcZqg2hXfgtOXUMoaMQPpXIAkRWUjoAbvpHg
X-Google-Smtp-Source: ABdhPJwhD1sGm0VjzGzH83FGU3qxCXO1Djq6Bsftw/zRBN6NcwxjyHtdhSbxTa6JQ2P/xdODB18Mgw==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr23085476ejc.64.1649521525607;
        Sat, 09 Apr 2022 09:25:25 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm9807666ejb.187.2022.04.09.09.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 09:25:25 -0700 (PDT)
Message-ID: <c4536b89-4843-c669-e499-f82fa3fec7f8@linaro.org>
Date:   Sat, 9 Apr 2022 18:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle bindings
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220409045145.2434096-1-dfustini@baylibre.com>
 <20220409045145.2434096-2-dfustini@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220409045145.2434096-2-dfustini@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 06:51, Drew Fustini wrote:
> Document the Wakeup M3 IPC properties that can be used to toggle the VTT
> regulator during low power mode transitions.
>

(...)

> @@ -51,6 +61,15 @@ properties:
>        mbox_wkupm3 child node.
>      maxItems: 1
>  
> +  ti,needs-vtt-toggle:
> +    type: boolean
> +    description: boards requires VTT toggling during suspend/resume
> +
> +  ti,vtt-gpio-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: pin on the GPIO0 module used for VTT toggle
> +    maxItems: 1

No need for maxItems, it's a single uint32. You could add "maximum" if
you know the constraints for the value.

Do you actually need two properties (bool + pin)? A case of
"ti,vtt-gpio-pin" without the "ti,needs-vtt-toggle" is valid?

The other way looks wrong, so you need to add a dependency (see
example-schema).


Best regards,
Krzysztof
