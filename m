Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9842F51AECA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbiEDUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352117AbiEDUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:14:34 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31B4B43E;
        Wed,  4 May 2022 13:10:56 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e656032735so2352728fac.0;
        Wed, 04 May 2022 13:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQcC/PTw0CZ4nW87/fDZEd1OCFRfJKtF1G1vA6JNl30=;
        b=RQr0fRDs8oSnLTEIaCWk2+95WrviwBo+P9Df4GgeqUTK8UacayQ87PqZpMwwzDjytp
         XG7pMKb9uJyJwKe4gF/OeMztw90nJ9Sg9wSimSRLENKRBfDBI/7aje/SMUYL0BHav/yU
         +riYSxE3HGTqRbxloUIkbOw3Dv0NHOyrlanVqkM56gU9N+ZG0GsSoIviWoIW58HEQ5zD
         41YBg2lJcABsvJEpK3VIaymMUsPtLDYvc1z9cgsjIzTValc9YlPPBsymnr0xRvznbKHY
         W16IGlSDgvZML99V/N3T+F6PhK0AGZAEs9ceHRI1xfT66v9/8uwHD+QGUdbIxgcQP9eC
         U7Cw==
X-Gm-Message-State: AOAM5301P/nQSsP00Sq/K+Ts7eTcXHyoXX4+3Mn8mYzD8YZCo0OFeHgl
        Q9iUz/+bZxXqC0rYbmXkn+/GWaJyxw==
X-Google-Smtp-Source: ABdhPJxm9dCY1QAzxTuM18EpGcmPS9stG0iSdDg3APF55LC0FY7ml3TuO/YsSKuI0ItXvUhRfVyG8Q==
X-Received: by 2002:a05:6870:2419:b0:ed:efba:5e11 with SMTP id n25-20020a056870241900b000edefba5e11mr641328oap.136.1651695045621;
        Wed, 04 May 2022 13:10:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z24-20020a9d7a58000000b006062d346083sm2907056otm.22.2022.05.04.13.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:10:45 -0700 (PDT)
Received: (nullmailer pid 2143715 invoked by uid 1000);
        Wed, 04 May 2022 20:10:44 -0000
Date:   Wed, 4 May 2022 15:10:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: thermal: tsens: Add ipq8074
 compatible
Message-ID: <YnLdxF+P7hWwjgZS@robh.at.kernel.org>
References: <20220503200813.4020698-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503200813.4020698-1-robimarko@gmail.com>
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

On Tue, May 03, 2022 at 10:08:09PM +0200, Robert Marko wrote:
> Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
> only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.
> 
> We also have to make sure that correct interrupts are set according to
> compatibles, so populate interrupt information per compatibles.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v4:
> * Add the forgotten Reviewed-by tag from Krzysztof
> 
> Changes in v3:
> * Remove implied min/maxItem properties as pointed by Rob
> 
> Changes in v2:
> * No need for a list in compatible check
> * Specify minItems and maxItems for interrupt and interrupt-names
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 76 ++++++++++++++++---
>  1 file changed, 65 insertions(+), 11 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
