Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1697558295F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiG0PNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiG0PNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:13:39 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4025D2FFEE;
        Wed, 27 Jul 2022 08:13:39 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id 125so13766836iou.6;
        Wed, 27 Jul 2022 08:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljprftnMg4GohtjzDyzVYKO0P1DGlNuwtq9vwy5essI=;
        b=CJosuv2ATaGzNrrIjutb6XrTos0bqsX6diCmFavlnOAUTJuLKzer0gvy8rL3Bnv7ro
         WY+AA1TRRsRM0sSGpvsFBVry/E30Xa7cRGGtA292pqdAsweFEEsBXwiWJ3JBzoiOWTo3
         Dx0PokqqyTv4I4ihhcQnc82fZEqSN6ArZA+BUIpvwTC3XGqquAJk+TYyISBTOIv5gasb
         U3IKyCZd4yWHHlZsMqWHEW1YHq1AFpM9G28kwFf7h/VjR8naVMIlBoEDpQkXWSlMDo7p
         C/Ncw3kFojH4xZlHFmwn/RKGIxZVzl9SzLfKTH20iGf4QyyOh0pY5+0cEBNkdgPPO2h1
         NrpQ==
X-Gm-Message-State: AJIora8rvTxaYRz37qksqZrUUzQxgc2/jR+bU2CjB2ynekXJNJD87w3a
        MrP2gomZoW29eL78pdrZGg==
X-Google-Smtp-Source: AGRyM1uoMW1AUFT45NWyxyQDxKKEFxSdJ+kYSch+/vP4GJl6ZFseEZ7qwEnfiqDoyTaNwhqoLTC9qA==
X-Received: by 2002:a05:6602:2c8f:b0:67c:308a:ce26 with SMTP id i15-20020a0566022c8f00b0067c308ace26mr7641753iow.94.1658934818345;
        Wed, 27 Jul 2022 08:13:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o22-20020a0566022e1600b0067bd7f5f964sm8557429iow.7.2022.07.27.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:13:37 -0700 (PDT)
Received: (nullmailer pid 2680133 invoked by uid 1000);
        Wed, 27 Jul 2022 15:13:34 -0000
Date:   Wed, 27 Jul 2022 09:13:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: qcom,pm8916-wdt: convert to
 dtschema
Message-ID: <20220727151334.GA2680005-robh@kernel.org>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
 <20220726120215.101868-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120215.101868-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 14:02:15 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm PM8916 watchdog timer controller bindings to DT
> schema and include them in parent device schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/reset/qcom,pon.yaml        |  4 ++
>  .../bindings/watchdog/qcom,pm8916-wdt.txt     | 28 ----------
>  .../bindings/watchdog/qcom,pm8916-wdt.yaml    | 51 +++++++++++++++++++
>  3 files changed, 55 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
> 

Applied, thanks!
