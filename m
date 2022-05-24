Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233F53209A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiEXCER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiEXCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:04:14 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF98198C;
        Mon, 23 May 2022 19:04:13 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5e433d66dso20664084fac.5;
        Mon, 23 May 2022 19:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLpFwwL4jxokl8yTJf2sFGQcsIPj9l2jwc979me7pqg=;
        b=HCqYHKU8y50d4UGS7V1PBhjKNSIPsQ3xcQIwI2MohjAHzzXVxUed98Lq9hRC7bE10w
         7d9AKx85roFc5mvAadflzPEY08+HdDoy6q1fRsglNy3V9pG09vfiUCwWWzsCxOMHgNTl
         EoAkRTtQaQxcvzyDzcjpbmryOEmllbMMMhpy43gQ7b3DmsehrdAKjk/B78ChdBGbt+I+
         mVY3hUJ0MdDzgz6nBZWqAFwXtBygP7x0tumXgbuMcYGVellogaDhIR8Xd+CymCAN2fJv
         2diepZqrQo+nlJy8zRme8o2x12g8rJsOfvidxSgBTN7SdY9NDbvBC6wE+FjEKi/IlBkS
         /06g==
X-Gm-Message-State: AOAM531De8YOYYRKR30B1xlEAYUcDJKkmrstFAlsoYph3OaDHWOk48Fa
        5g6lb5snhXjeAmQ4KpM7LL6XjHuXpg==
X-Google-Smtp-Source: ABdhPJzkF4WvkQc0te+BAhyw5JStp+ht1qlShDlUbPCymsX1I3qzyya+73nuYpyX6XzGmyc3X9ZAIg==
X-Received: by 2002:a05:6870:b006:b0:f2:1cc9:d75 with SMTP id y6-20020a056870b00600b000f21cc90d75mr1184153oae.157.1653357852832;
        Mon, 23 May 2022 19:04:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l17-20020a9d7351000000b0060b02eda329sm3100336otk.14.2022.05.23.19.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:04:12 -0700 (PDT)
Received: (nullmailer pid 2602902 invoked by uid 1000);
        Tue, 24 May 2022 02:04:11 -0000
Date:   Mon, 23 May 2022 21:04:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 07/12] dt-bindings: arm: qcom: add missing SDM845 board
 compatibles
Message-ID: <20220524020411.GA2602849-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-7-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:45 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
