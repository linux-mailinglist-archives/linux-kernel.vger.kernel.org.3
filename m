Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F85348C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbiEZCQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEZCQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:16:13 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833405FDB;
        Wed, 25 May 2022 19:16:11 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-f2cd424b9cso705785fac.7;
        Wed, 25 May 2022 19:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wuJ7BjwKNlM5fOKNMp7vuV72gq8O6lLmKM4p8NQjz20=;
        b=QgTx8J3Bvi6CkpZwnGuzaGgTrgG+87NTQ+FFfBWvJF0tT+U2AAKJFruU+jPmex/xki
         FwgsUaLQh+qYITMppHotQ1Zndk5TXbTRuQxTy7XDwYKpc9Y+WMgShryG3fq7qtMoNL4Y
         tO0HrKKS630xbF5ie3i4BNXSlclp4NzRxIoENU9NRT8lg/3PJhDEgWVTJ7l0Shds8l7Z
         lbbyurlBea/pS7n04cR4/kuXlwNDDkc76Lu75l3D5jq4KnVE0md1khXL+gUX1RkpyRmc
         gVcrfL2yChfsTdxQkHYox7Q6Z5nS+2DTBjM5Cmu+PS+vdFDsdxPV6ihZGaHeHtao25Cd
         ug4w==
X-Gm-Message-State: AOAM533I6D2CWfAqNbb/qr7SnuFzJjHWyGMZYsgltH/S2vRu7wOb7Q6p
        2XA3XL4Sfrhzhc6ME/kK9Q==
X-Google-Smtp-Source: ABdhPJwjlGbNYFP1K1/AMy26ehj1wvMD82YgB3JdGPM1K2bPF0Ovroj6xvh+FzwHN2LIcP3hxHS5lg==
X-Received: by 2002:a05:6870:a2d0:b0:d9:ae66:b8e2 with SMTP id w16-20020a056870a2d000b000d9ae66b8e2mr50602oak.7.1653531371165;
        Wed, 25 May 2022 19:16:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r10-20020a05683001ca00b006060322126dsm129503ota.61.2022.05.25.19.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:16:10 -0700 (PDT)
Received: (nullmailer pid 2926734 invoked by uid 1000);
        Thu, 26 May 2022 02:16:09 -0000
Date:   Wed, 25 May 2022 21:16:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 7/9] dt-bindings: arm: qcom: add missing SM8150 board
 compatibles
Message-ID: <20220526021609.GA2926701-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-7-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 May 2022 14:32:50 +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
