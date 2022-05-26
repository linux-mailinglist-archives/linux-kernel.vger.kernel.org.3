Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE795348C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiEZCQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEZCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:16:22 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93318E19;
        Wed, 25 May 2022 19:16:21 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f2bb84f9edso687702fac.10;
        Wed, 25 May 2022 19:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJ6HA5Js/33HFt31MWtDtihI1teRmVKt0MrTEpltRUo=;
        b=Op5fCfDgXB90Bfu1mbA++mTXwAbYiQhL6N794RsTVZs5xORPOomZcDvBDUWtQz6Jqg
         DhKIdrgqGJiOEAr/xwJRTwq0+de+nAZTULEvl5ZbOh4CjaaJv8aTYPTLt94qR7cIi6Dw
         FMeGatRSVQGeUw2qXxdmy8VaRTj9JLqsXDf9gqVTjLgznqh5LuJEhS3IOyTAtbAy6giG
         TdYhR1E/qlBN7VsIJHnpC7WNnUfLWsBitZFOp00lfVAeSFvK4IvIAlTUvnvmq+K4kBTO
         H6UFwHh2xkfaIgGRr9/8nsvUte9kNmy3wIJmYGzC4NCkCXviZh6O06Nn9fFX0hs68Km6
         YDow==
X-Gm-Message-State: AOAM533/fkjcCcZnhS5sFj7IFS1jo9ZjvkEwSnzU5bJaFhJk9kqxlRup
        XCUH5DTWt31YtEPqCgAwmw==
X-Google-Smtp-Source: ABdhPJyZv1XbJw8w3qP0ppxDcvSVOyM9Gmzxo3p7TDgF9oUnAaUieXplVNeCD4uSoZdAiczL3BKBvw==
X-Received: by 2002:a05:6870:e0d1:b0:f1:ad9a:8c98 with SMTP id a17-20020a056870e0d100b000f1ad9a8c98mr59659oab.168.1653531380772;
        Wed, 25 May 2022 19:16:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s31-20020a056830439f00b0060613c844adsm151479otv.10.2022.05.25.19.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:16:20 -0700 (PDT)
Received: (nullmailer pid 2927073 invoked by uid 1000);
        Thu, 26 May 2022 02:16:19 -0000
Date:   Wed, 25 May 2022 21:16:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: arm: qcom: add missing SM8250 board
 compatibles
Message-ID: <20220526021619.GA2927001-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-8-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 May 2022 14:32:51 +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
