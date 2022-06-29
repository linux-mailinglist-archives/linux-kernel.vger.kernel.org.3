Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E355FD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiF2KkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiF2KkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:40:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F03DDC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:40:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z41so3018223ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KL+L6harPh+JuFJAJRzJRE0zJdkLBe7duDknnurvqcA=;
        b=pMA3XQX716O5iGIEUmBKEFlchqA/QeyKwJN9kbF2vMVk/TUqGUyiTuey4JkHO7CCYm
         5SOT6qYlf8l9U05i8K+ev6aQHq0vieOxnPwDggGqTslCl+fX6QwrQetyrENkoaOJhYW8
         o5khg408Ap9+/M+Jlx35ge3gNotzz8hyo81ibeEYKKbZjQZ3llNvKGVpSn9cbuwaKScV
         Kwni8wphX5kvQFDd9P4Hpjg6O9FUjLsHsmpTJEFvpU4k2axnEoRYqhPtIO4BpmEn5Sb3
         qC5D62FNI26+mGaT+oQJ3OutYBtKubcoFj8wFU6nra2fhBFLuAIQTclF0GBF2F2pQlUt
         r4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KL+L6harPh+JuFJAJRzJRE0zJdkLBe7duDknnurvqcA=;
        b=hfyzPJFla7egUcNHeUiNE9sF1xZIe854+L2zikd6nE1/aEZ61mHsVuxc8l3kcrg2CS
         KuaZ7fmxYsPWnaJOd59u0LFqBZI9zpDYTvWTxB2VsjkauafPpBg7qGfda8BEwG7DNk6k
         YEwH9ETFfILP0ms/BrDEFC9sykle5taTaQFAXrX0Ki8q1XGhYRizWNJMUrQK0D2QOA3b
         HuAMO2Fbn9yUdUJa8cgP9rUANJ0LGUvY6gMqdU1Waxcj7FiNzM/U2kmtwONl/v8WVCyi
         ygo+FZj6hp0ewMwHMCK3YTAFrlS0TQL6kyWTB+4KY+EEcCzKRlMSswGnxizNDtwfwFsl
         T6Lw==
X-Gm-Message-State: AJIora9/J19zOsEMBvrjJ5diveu5Knul0BNqFC0OpE2hmVquaP4yGs1B
        nZtiBWh0VhBnfW4wo5NvAbbe3Q==
X-Google-Smtp-Source: AGRyM1t9O48I2+5YgJKV5tmvh4uRD2cuz487ZZQ1UlwQE8O4ndR1/8YnbtI21nLf5m9qLbXRFG2l8A==
X-Received: by 2002:a05:6402:3591:b0:436:c109:1fa7 with SMTP id y17-20020a056402359100b00436c1091fa7mr3288828edc.208.1656499207253;
        Wed, 29 Jun 2022 03:40:07 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm7550132ejb.208.2022.06.29.03.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:40:06 -0700 (PDT)
Message-ID: <d419bee2-80de-0c5c-599b-44a70b86efeb@linaro.org>
Date:   Wed, 29 Jun 2022 12:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,am65x-dss: Add am625 dss
 compatible
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220627151200.4693-1-a-bhatia1@ti.com>
 <20220627151200.4693-2-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627151200.4693-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 17:11, Aradhya Bhatia wrote:
> Add ti,am625-dss compatible string.
> The DSS IP on TI's AM625 SoC is an update from the DSS on TI's AM65X
> SoC. The former has an additional OLDI TX to enable a 2K resolution on
> OLDI displays or enable 2 duplicated displays with a smaller resolution.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
