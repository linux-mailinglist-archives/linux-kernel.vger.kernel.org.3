Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1837B53208C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiEXCBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiEXCBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:01:38 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D368922285;
        Mon, 23 May 2022 19:01:32 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id r12-20020a056830448c00b0060aec7b7a54so7610409otv.5;
        Mon, 23 May 2022 19:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Mup20IopJTPRvYzjtHMLvLcw0RYXFS52otXL309fRo=;
        b=cYI7QWy6FhCmm1VzMbI0M4dcmYqEdxcfL5mE6Y2lLqeN/wPf6IDLRmnzyF93nIfljd
         VhwHWzEFRjyaH5VirjEDZumsmydhbv62TYXCB5dbQYRjiyuCjKZdh8ne1fxJsIpXudsw
         RLBEX9bI1OOY6gK7iN/bDVeD1RH4nIERx1vFz5WPuM9RjUbAAxmjGpf37BT3BYV4WYNM
         W5H8f8P7ljI2eCY0jeVSQbYDvi7HWZfSglf/hz00cGl6tnvbeNIdcZmS9YW517RWi/cb
         x/qLWsbyNJJV5jbUu3AjNgoyFMNgvJBSx8Mh7gpT2IVlJ1BQF2WCGJ8e2bfB++F9kCZL
         5I2Q==
X-Gm-Message-State: AOAM530jX+ZvzSm9ifPoJxm7BhmjDN5/X1w/i5wlL5OEIKS7RyAP6o6W
        puU3rqy7gmkx6MG+ac9F8LCJVZtQNw==
X-Google-Smtp-Source: ABdhPJwjoS8k4lq+ol/GKRB3gQD/b4SVCxslRMi/2Wa3S0HfpLb0c+tmNBqZuas8Hh0xX84CPkCYLA==
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id b24-20020a9d6b98000000b0060b0c54e22bmr3728888otq.357.1653357691623;
        Mon, 23 May 2022 19:01:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f4-20020a9d2c04000000b0060a426ee09asm4576604otb.19.2022.05.23.19.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:01:31 -0700 (PDT)
Received: (nullmailer pid 2598293 invoked by uid 1000);
        Tue, 24 May 2022 02:01:30 -0000
Date:   Mon, 23 May 2022 21:01:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: arm: qcom: add missing QCS404 board
 compatibles
Message-ID: <20220524020130.GA2598243-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-4-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:42 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
