Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E615455CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiFIUkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiFIUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:40:20 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8FFC81B;
        Thu,  9 Jun 2022 13:40:19 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id y12so23374204ior.7;
        Thu, 09 Jun 2022 13:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3inXp28+t1Fu79HVtNOuLwQSwI2FZtsXZm82BbEUbM=;
        b=CUhKsn6lNkObvScQjMFQneQkGcqY4Y3wD7Hi8MED7Xov07JLLk/I3R/b37DDokI0GZ
         w2RborYaxpHsu38zDh9kjUemBmqVMmcNpPQdDgD3+RFya6o8IPjaX8YaM5+F1EpuiXTg
         XdieUpO2/iODAkq/ryodDKVJApbVm5VPNwgNuv7m/RPkgM4kVPfCzmQS5oQh4svdhxXV
         GHdzVO10043GeTvWFqruWuLKsI8vojCitER4SpJ9Etb+UWCrYH2ygVuUiM6+LGzMIucf
         +ZhF22c+4ANMFq0oReZnCFG79N59dHLw1xtrt5ZO+RyOKhviVM/PWUCE9LSB0Yd0KU75
         IpXA==
X-Gm-Message-State: AOAM532sAPzn4xSQxtt/xcAg08vY6xR79RmpM1yN9/mlXvbsPDMKRDf+
        Jvs+Ijz6MUKUqpgGogaZ4kb0DfMdxw==
X-Google-Smtp-Source: ABdhPJzNkq8AnEwrys013uFfNBIMTljy33vvXsnbh8wZjluRcL2tShGePfR6E5wOFRvNqDHM4dr0Cg==
X-Received: by 2002:a02:3506:0:b0:328:9a29:678 with SMTP id k6-20020a023506000000b003289a290678mr21985379jaa.33.1654807218797;
        Thu, 09 Jun 2022 13:40:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b13-20020a02914d000000b00332122c106dsm121225jag.152.2022.06.09.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:40:18 -0700 (PDT)
Received: (nullmailer pid 63550 invoked by uid 1000);
        Thu, 09 Jun 2022 20:40:16 -0000
Date:   Thu, 9 Jun 2022 14:40:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] dt-bindings: sram: qcom,ocmem: cleanup example
 coding style
Message-ID: <20220609204016.GA59013-robh@kernel.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
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

On Tue, Jun 07, 2022 at 07:18:35PM +0200, Krzysztof Kozlowski wrote:
> Fix the indentation in the OCMEM example and use generic node name -
> sram - to reflect the type of the device.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sram/qcom,ocmem.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.
