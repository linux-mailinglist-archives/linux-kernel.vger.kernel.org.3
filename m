Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3624F5B0BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIGSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIGSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:01:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39BBFAA2;
        Wed,  7 Sep 2022 11:01:07 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1278a61bd57so19435288fac.7;
        Wed, 07 Sep 2022 11:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CcKlit7HWPI71ZUe/GljJgB5zkSi4EijYD98Jqq648E=;
        b=NO52m8senwiSrdJf2qOHJZzfAdBXaz7BvGmLZuEhXNne5yQyFmKNmMi68Y4BvBOYv3
         UWQJRq/heeV5JSUW5GutUSZXMDUcgH5eK8DxZ0lLyarIbfdTfEm9dHDGy5f2YOwBs0Hu
         Gz3tI8tjicBrPjEqdaTptbwNrOCm8uhm072I7ayXXxJwLMTZvkeLmyEbPnRXUGc1cBdY
         3f4nHLkmdIbOgmzB7g1AnBpnJPPB5H6NFajp9qNJ7U/euC6k0h90T7LZZvX6mKQ20sy6
         MjCVLrgkxivgJiDkpRjYYnEWd6EeOz+5tpUoD44fpGZoFUuqv4+HUEy6VhceQd12pMW/
         C/AQ==
X-Gm-Message-State: ACgBeo1Cs763rCR2fGpQauIRmuFTYV3r7xvVM+R5soXzxMiGaefxa6qE
        UWf6A5DOjfaiQJz6rt6q4A==
X-Google-Smtp-Source: AA6agR4biI7Jy8t1a+y/JH8nraXYykytOrk/m+fs/VxKBmcF6nuftmhGQC4Flf3XySFMmoHn+de8wA==
X-Received: by 2002:a05:6808:199f:b0:343:3592:4dea with SMTP id bj31-20020a056808199f00b0034335924deamr1940962oib.163.1662573664559;
        Wed, 07 Sep 2022 11:01:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s25-20020a056870631900b00127fbb7afffsm949675oao.5.2022.09.07.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:01:04 -0700 (PDT)
Received: (nullmailer pid 3803412 invoked by uid 1000);
        Wed, 07 Sep 2022 18:01:03 -0000
Date:   Wed, 7 Sep 2022 13:01:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 10/14] dt-bindings: soc: qcom: apr: correct service
 children
Message-ID: <20220907180103.GA3803351-robh@kernel.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
 <20220907101556.37394-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907101556.37394-11-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022 12:15:52 +0200, Krzysztof Kozlowski wrote:
> The APR bindings were not describing properly children nodes for DAIs.
> None of the DTSes use unit addresses for the children, so correct the
> nodes and reference their schema: clock-controller, dais and routing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct also sound/qcom,q6apm-dai.yaml (Rob)
> ---
>  .../bindings/soc/qcom/qcom,apr.yaml           | 68 ++++++++++++++++---
>  .../bindings/sound/qcom,q6apm-dai.yaml        | 10 +--
>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 16 ++---
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 16 ++---
>  4 files changed, 66 insertions(+), 44 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
