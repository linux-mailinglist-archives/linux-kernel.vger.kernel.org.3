Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596A5348B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiEZCPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEZCPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:15:46 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED48BD1E;
        Wed, 25 May 2022 19:15:45 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso157048oto.10;
        Wed, 25 May 2022 19:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtFQTWwNfAo7narXbWbRfl4GInX5fQ4oenWpCwWjM+E=;
        b=Y5r1omiHJq88JwOvCvUqekpr5l2P5RSCrH0KUvRMy+pp42naja81U676keX905fr1K
         t5rlZqB6kUP/6RkdRbbao2Rgy+nUjVNmM2LeSMvt2zXGo7m+SeIO/w++ygDAhfwzXOR5
         jXouEPKpO8YdDatM5+etTjDuJCzoyqyZZOgzxG/YodoGsIc8G2UgSwL0lgdq/gxAsU3J
         E398ZPawKl+WoHfHRsFcxq99qtmZ9zM2kcFfiuPDtdELS7pzoc/p6CiJ1q8EQUKdBphG
         aTw/W9BDSqfTqLnYfjMl3IhQQfhVJ7dRUoUhOcRj3IdbV8tcCBcrJxlSrpThERNIMcLc
         1iSg==
X-Gm-Message-State: AOAM533ZdMuGhcXsESRa23nx1GvseO90IPvWBV/wDfZW/N0OIft+bvMW
        xrPTLHBOushRbZQHNhM0Sg==
X-Google-Smtp-Source: ABdhPJzZqw8JY/GHFxztTsv552hoEDuXY7V9IVanVp7vLgsTqVzo2CuXcWsVMFOjS4DaWnYRkwzlow==
X-Received: by 2002:a9d:6255:0:b0:60b:29b6:7a91 with SMTP id i21-20020a9d6255000000b0060b29b67a91mr3644302otk.158.1653531345244;
        Wed, 25 May 2022 19:15:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b3-20020a056820134300b0035eb4e5a6ccsm150408oow.34.2022.05.25.19.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:15:44 -0700 (PDT)
Received: (nullmailer pid 2925928 invoked by uid 1000);
        Thu, 26 May 2022 02:15:43 -0000
Date:   Wed, 25 May 2022 21:15:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 5/9] dt-bindings: arm: qcom: add missing MSM8916 board
 compatibles
Message-ID: <20220526021543.GA2925896-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:32:48 +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
