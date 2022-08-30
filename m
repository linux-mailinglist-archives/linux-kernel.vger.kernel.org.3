Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD695A6850
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH3QYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3QYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:24:51 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9D5592;
        Tue, 30 Aug 2022 09:24:49 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11dca1c9c01so17967417fac.2;
        Tue, 30 Aug 2022 09:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=j9hKnhcG2H74szOTuO/QuH+GdjQxo+KorbP/zhVl3Ac=;
        b=0upfzlkea8qmRIRuCeg5G8s086EAeHeSbGgcm9SOKASa6ZxN/OME5aqqXCrCch2DGc
         yl2Urc45L5qm6O9t9OOAWmZ9Du3TBqrG9cBEpZyt1/oxGL+kKGqAoD04VnXwneaXFufE
         tza1SEpFYdzHwBHAXK8fXxxtb2IH9MVuEMF+ivcsg5JlmtHXkPlPcXJbLdsvcZ1eM1Re
         vVgBxbBGLgEJ+vED+CKQo/03WuqWa2yGHEc9AKnOgLznHXObvD28lOkKI+PlXN6P3tFZ
         jIg7Pt4Un/vDt+1meyTKZu+rAezktPml18kFcLZ581z4J6hW7kQulX7QYFu0HQV/sq6c
         dYkg==
X-Gm-Message-State: ACgBeo1COtzpUMfu2f+rkgQx8IMWjLaKnVEDYR8XUH8/O01sNXDv15HK
        GKhvDoGgilMtm1lm7TNN1L13Qn7hOw==
X-Google-Smtp-Source: AA6agR6jxGYMQy0LBcuYfgLJD84RQXshKmUJMu+IU7Y4UmXonuRzzkmsC9mh0JvtJd93YHj+REIgmw==
X-Received: by 2002:a05:6808:1647:b0:33a:f484:2ae2 with SMTP id az7-20020a056808164700b0033af4842ae2mr9490649oib.60.1661876689162;
        Tue, 30 Aug 2022 09:24:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g17-20020a544f91000000b0033a11fcb23bsm6448452oiy.27.2022.08.30.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:24:48 -0700 (PDT)
Received: (nullmailer pid 1506950 invoked by uid 1000);
        Tue, 30 Aug 2022 16:24:47 -0000
Date:   Tue, 30 Aug 2022 11:24:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: add missing compatibles
Message-ID: <20220830162447.GA1506864-robh@kernel.org>
References: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 28 Aug 2022 09:51:23 +0300, Krzysztof Kozlowski wrote:
> Conversion from TXT to DT schema lost several compatibles.
> 
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
