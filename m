Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32274F1EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiDDWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381751AbiDDWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:01:06 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5B48E58;
        Mon,  4 Apr 2022 14:42:20 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 12so11433450oix.12;
        Mon, 04 Apr 2022 14:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uc3yH/jG3sBllzxTBICCkefelRQR1XgnPj3KbXvbVCQ=;
        b=7rWW5ZQnTnCtCjPYmwiy8lvKFYcRW7epgyJ6rzfQdAknMwSZxcVFiL28/balsSCuGh
         ye2PyaMppGzhfKRBLyh0C2hhI+aHq3IM0VShaxk90WJSLADlDL/Z4yXDmo/JS6q/fLJa
         J77ZwXCi/hJPa3CMNp/eCtu6Z2CWYdLvBuESXhQs9/kLf03RjT7EDD7d/IamMSNHiN31
         sCLf5LiqP8nGxXiT/5dsl99wXf6YelpKoD61EOgg/CWxvFdrX9XujdOZbEjDxbqiC1ou
         rvDueI/PzwMVM2ZUhBx9d5zkSC/YmA77JnsIhp/4HZyDWI6jzUwYLDyPFe7ep1BJqzsT
         fjUw==
X-Gm-Message-State: AOAM532fhwOnRxJCqDCBGqRBn/JvoaIeDzmKNHLJS+3ZNSxLP09rcw2v
        FNleivYkrs4YRR9X6c/MIWwWl8xTlQ==
X-Google-Smtp-Source: ABdhPJxHw7bHJudtfLTQCO8oKlv8FHP+ZChE+ETXaBzSBI9Iphp6FXy94+GdG1dh6KtJdDrJQdpgVQ==
X-Received: by 2002:a05:6808:179a:b0:2ef:8a55:b947 with SMTP id bg26-20020a056808179a00b002ef8a55b947mr141706oib.95.1649108539523;
        Mon, 04 Apr 2022 14:42:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e9-20020a056820060900b003216277bfdasm4461315oow.19.2022.04.04.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:42:18 -0700 (PDT)
Received: (nullmailer pid 2038274 invoked by uid 1000);
        Mon, 04 Apr 2022 21:42:18 -0000
Date:   Mon, 4 Apr 2022 16:42:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [RFT PATCH 1/2] regulator: dt-bindings: richtek,rt4801: use
 existing ena_gpiod feature
Message-ID: <YktmOhXnZ0Amxcov@robh.at.kernel.org>
References: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
 <20220401154237.1061331-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401154237.1061331-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Apr 2022 17:42:36 +0200, Krzysztof Kozlowski wrote:
> The binding and driver duplicated regulator core feature of controlling
> regulators with GPIOs (of_parse_cb + ena_gpiod) and created its own
> enable-gpios property with multiple GPIOs.
> 
> This is a less preferred way, because enable-gpios should enable only one
> element, not multiple. It also duplicates existing solution.
> 
> Deprecate the original 'enable-gpios' and add per-regulator property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/richtek,rt4801-regulator.yaml        | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
