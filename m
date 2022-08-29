Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793365A5524
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiH2T6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiH2T5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:57:39 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81C79EE1;
        Mon, 29 Aug 2022 12:57:20 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id p48-20020a4a95f3000000b0044b0f5a8d17so1641441ooi.0;
        Mon, 29 Aug 2022 12:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=C/b5BQ8B0knkatmMJR40aqQPPoLSGpLK/2JLZ5QFmUw=;
        b=eImUuhqyp62LEmLIDVYlwYU5plpjVHdKiZuHjGd8n8EOt4ci5TynReN22/5G1MbB+Q
         L52Y8K0v/G+7iIa6iPlCvAISH25Wesyqa5hEIV8PJLNjgG6lN2M8mFJqf5q8XCzd8Cmp
         +EShlH48OXiddZcZJcg4XZO5svahRSVXb0F7jRBpa5mpwf65I/Id9d/+boeGQTrNHCHC
         VYXsvL89tv9uKdtlsmJnBuCnZ+hOmWyDOF1MGEed73FuAG6fCLCP/DNvuImtPVRsIn+e
         8MsCv89KzrgvvjfZuJtV5CQdMHH/rDTdCQt6r/vjhIIzHFL/JeCWs5MF9gmMM7sM4FGQ
         fn9g==
X-Gm-Message-State: ACgBeo2o9acuXt07wVrmBHj81rJWuafMHH+jqppi2pgOonuqaGg6lZaM
        bNqWCd3TcrB3Q+zlMEyH+g==
X-Google-Smtp-Source: AA6agR5LaMvdXmR3cU1fCf8sxgz3wyxGFdB0vw/qJCQe8L6S3Fun9SKbUE0WeGvM57B8obexSFpOQA==
X-Received: by 2002:a4a:2243:0:b0:44a:e5cf:81e5 with SMTP id z3-20020a4a2243000000b0044ae5cf81e5mr6203415ooe.44.1661803040220;
        Mon, 29 Aug 2022 12:57:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d23-20020a056830139700b00639443424f8sm6183476otq.8.2022.08.29.12.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:57:19 -0700 (PDT)
Received: (nullmailer pid 2314952 invoked by uid 1000);
        Mon, 29 Aug 2022 19:57:18 -0000
Date:   Mon, 29 Aug 2022 14:57:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kiran Gunda <kgunda@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH RESEND - dt 2/2] dt-bindings: leds: qcom-wled: fix number
 of addresses
Message-ID: <20220829195718.GA2314862-robh@kernel.org>
References: <20220825125410.232377-1-krzysztof.kozlowski@linaro.org>
 <20220825125410.232377-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825125410.232377-3-krzysztof.kozlowski@linaro.org>
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

On Thu, 25 Aug 2022 15:54:10 +0300, Krzysztof Kozlowski wrote:
> On PM660L, PMI8994 and PMI8998, the WLED has two address spaces.  This
> also fixes dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: leds@d800: reg: [[55296], [55552]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/backlight/qcom-wled.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Applied, thanks!
