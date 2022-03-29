Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8D4EB3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiC2TIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiC2THz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:07:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BC122225
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:06:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a8so36918542ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R4sUD/h50Bf43vOXljayxbaTzrnkE01kcRyo4ru/wmE=;
        b=dCHc12WonPl6079dcHq+ZOly+/rYb0WPhWVaW6uIMntiA3fSfeCfEgE1dLYF7YlsIw
         fFJDXnoMDTFZoWfnZ+6Db1MZBFQuJEORc/aKf+HuWVMFxMnP1JAXXhg9bR18DccS9e9K
         P16oZnRCBSMXFsP6jmDv33TIG8sogxezhfe3hiNFk1F4c7vcCV4P9yysaYkDPXyG45lD
         XYVFXnugodx50wXw6cndXonIZ7rKmo0gZ1iI0FxsbePnKo6dvvHObMtUlmDxrIIOhnj8
         MHBFszLv4oOpT6ssux6c7vd+TPiSdJu+0Tdbf/b2rMLG5R8HJlFtWMPOeY2k/ffKm8Ze
         Txpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4sUD/h50Bf43vOXljayxbaTzrnkE01kcRyo4ru/wmE=;
        b=XEqpfkBByoXFMFY0qXZ/yV9QTnFIHZDpyQbldv9Vu+ITBwLd85z24eUxjwR6oYnt8M
         PBBf5+Zi+L1zF8QYnl25+A2Z5kIMUg9Xq4DN8Z8DfbzBYxZhobC5DrgK7NU9A9X5/xED
         u8HwVCM5IKiAEd5gkF13cWjEb7hLpremF17VjOj7DRfnQOD9HnLKQnB0NsbqAr2aQ9KD
         ZSWRCCKOdqOm3JWKH47Oqt3y7TJExMJOZM5155e+0wXEIyPO3uVsqphlcBHeDRlLRA7+
         EqR5OVHeUP66HpjHwTnsuiuBguuTNqmridk1bA0xxO7AB2ttEciBVczMWiZ+RaV1PUtk
         unFA==
X-Gm-Message-State: AOAM532HGe5dQWMAwJpJI//6pcpAI9HawqOLFkEHcUQh6yMvyKxJWiP9
        t4PNfSf5WT4G12N+ChbsmKFXAw==
X-Google-Smtp-Source: ABdhPJx2shVhEMiPQQnvRhN82e0FGdSWbageEUczWptVA506xGOCxhu6bQZW3y6SqBnigtrgpKjrxQ==
X-Received: by 2002:a17:906:704f:b0:6e0:2ce5:131e with SMTP id r15-20020a170906704f00b006e02ce5131emr34569646ejj.246.1648580769541;
        Tue, 29 Mar 2022 12:06:09 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm7492373ejb.145.2022.03.29.12.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 12:06:08 -0700 (PDT)
Message-ID: <e019c6cb-9840-5e4c-9c36-10e2ec99bba9@linaro.org>
Date:   Tue, 29 Mar 2022 21:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,
 rk3368-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329180550.31043-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329180550.31043-1-jbx6244@gmail.com>
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

On 29/03/2022 20:05, Johan Jonker wrote:
> Convert rockchip,rk3368-cru.txt to YAML.
> 
> Changes against original bindings:
>  - Add clocks and clock-names because the device has to have
>    at least one input clock.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3368-cru.txt    | 61 ---------------
>  .../bindings/clock/rockchip,rk3368-cru.yaml   | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
