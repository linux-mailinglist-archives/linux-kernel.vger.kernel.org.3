Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B21510689
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353671AbiDZSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353668AbiDZSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:18:21 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD62E0BF;
        Tue, 26 Apr 2022 11:15:09 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e9027efe6aso12926775fac.10;
        Tue, 26 Apr 2022 11:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuszhkzwVSvuIjdf0zLmtdsA7PD3kNJt5NhF6kgFDew=;
        b=GpJKeBOb6jpAgC32358nadL2iRyQ3GRqQQB3pDjyafnDgyB9dB0s84g5FXC2YH/XBm
         s/OpOQc1i8KiZQBLMXXER6XI8zYu0JSscLSh74YMk1yNJ1zl+ch4UPyYSuIq7aJWjNO6
         hNme2Gs180GgoM31YTgH4d2euaT5u5pl3tuvOx5jscgI/aLnwDsAOq0dq6Cc0+N3VUbp
         +CmfXOoj2+OKwpZ8V1RDuVYn/8mJc02yKdG/LZu1SMkpajj48Xvhbxkw0s5dIpDD5oAD
         kAwF4P1mOZWoXWHruRvtj77Z0WjvXBW9adDKxp0uOd4KVHu7ZwtoJOV3pq2GQo4ratcT
         QJ2g==
X-Gm-Message-State: AOAM531N3MTqu6EmMjdgBiJivLZKW5y5P/ciJnLgftZLI4q3c5AIOVj0
        mlYN0WasLaU31QW7tQG48w==
X-Google-Smtp-Source: ABdhPJzxRzSuI14j7y1LkGIg6AiDNSYupXj9Vua8a/EnRksjvbi5hGsenSTH5vuHGxtGykm3KZEhsQ==
X-Received: by 2002:a05:6870:c14f:b0:e9:144a:8b46 with SMTP id g15-20020a056870c14f00b000e9144a8b46mr7099500oad.69.1650996908435;
        Tue, 26 Apr 2022 11:15:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b20-20020a4a3414000000b00339e0afec88sm5907649ooa.31.2022.04.26.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:15:08 -0700 (PDT)
Received: (nullmailer pid 2289122 invoked by uid 1000);
        Tue, 26 Apr 2022 18:15:07 -0000
Date:   Tue, 26 Apr 2022 13:15:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: stm32: correct blank lines
Message-ID: <Ymg2q/nO0vWbJwMA@robh.at.kernel.org>
References: <20220425140436.332467-1-krzysztof.kozlowski@linaro.org>
 <20220425140436.332467-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425140436.332467-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:04:36 +0200, Krzysztof Kozlowski wrote:
> Correct blank lines to precesily separate entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
