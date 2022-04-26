Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849A5107CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbiDZTCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiDZTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:02:42 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701D198C74;
        Tue, 26 Apr 2022 11:59:33 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id v12-20020a9d7d0c000000b006054b51c3d4so13685273otn.8;
        Tue, 26 Apr 2022 11:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBAsRSlI5kfF827D6uZ20E48AKeiISaoDfHd2SYry2c=;
        b=34hw1vCs/6W+9fV15tQq9cheJt1dZN/NVzxYjXwiFpyLiWCI1OcOaAaJQ/2zJxlM9O
         8roSLKAeqOJ3hu4JE1+pkEhKdHOJb88QKfqJk3+km281VhtvVVnt+smCWe+T+E83vfLB
         Q4y6QSRwQfyPjrX3jDbxNflgOVmq3Lvb0Hv9S/fFxSFFi+0/uukonOt4M8VIja+e8caU
         7l08aIOXjTSjiFBPVFhxdy0FGgeApIDVjCY6RY4p82IS/bJ+E8X+/OOnwYHwrsGwt7zh
         fHuplPGEhIATWXjWt8s3szyundZVS36nu37xscDw7mmKP/SOgAxQfqKPpjcNTSdF98jC
         QE/A==
X-Gm-Message-State: AOAM5310CRqwW4jJ1sH7uN8Nbm1Z+MJYocovK3pUy7mKfFgM0ocQuhX3
        WKKGZ6Xr/duIKKqdxLSkhQ==
X-Google-Smtp-Source: ABdhPJwTxcgP/rmXRz69W2nYrZhXJ4foSfebPmXAvMZ8QYnHXAV1DWgVRH8w6+rLGzU7kQWD+4exPQ==
X-Received: by 2002:a05:6830:10d:b0:605:7db9:85f6 with SMTP id i13-20020a056830010d00b006057db985f6mr9017248otp.145.1650999573228;
        Tue, 26 Apr 2022 11:59:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n18-20020a056870349200b000e686d13898sm1116146oah.50.2022.04.26.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:59:32 -0700 (PDT)
Received: (nullmailer pid 2358549 invoked by uid 1000);
        Tue, 26 Apr 2022 18:59:31 -0000
Date:   Tue, 26 Apr 2022 13:59:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Message-ID: <YmhBE/JDV66qQIBv@robh.at.kernel.org>
References: <20220416154013.1357444-1-leo.yan@linaro.org>
 <20220416154013.1357444-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416154013.1357444-2-leo.yan@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 11:40:09PM +0800, Leo Yan wrote:
> To support path tag in icc-rpm driver, the "#interconnect-cells"
> property is updated as enumerate values: 1 or 2.  Setting to 1 means
> it is compatible with old DT binding that interconnect path doesn't
> contain tag, if set to 2 for "#interconnect-cells" property, then the
> second specifier in the interconnect path indicates the voting is for
> which buckets.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> index 89853b482513..7464a50804db 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> @@ -118,7 +118,7 @@ allOf:
>                    - qcom,msm8939-snoc-mm
>  
>                '#interconnect-cells':
> -                const: 1
> +                enum: [ 1, 2 ]

Describe what each cell value is here.

>  
>                clock-names:
>                  items:
> -- 
> 2.25.1
> 
> 
