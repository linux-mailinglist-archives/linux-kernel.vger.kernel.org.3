Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220F4545569
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiFIUOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiFIUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:14:44 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118846C85;
        Thu,  9 Jun 2022 13:14:43 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id y17so19538879ilj.11;
        Thu, 09 Jun 2022 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=naj/yO1cWIPZHGNJu5XeGk620rDStQ2LIowqVDXTSRI=;
        b=rKuP5QmCOKWBV8aM1arTT5UTKvF+lQQYpNP7qosg6yQkeFNOiVW7MfrDKbVPw7sBcG
         +0v63pWRl1yjlTFwbJKGoFnkx8U1A+jmWjRSwi31tGJCIENEoephaqKTClqMnCxb1KLs
         WB+tkTi6ffhZVqhHpC2dwK/TI//n6qOSFQhiNeDNR/a2u/T1KXdC2m/x3dpg0AKyUfTR
         gGWqr7tVS1Y2bu3SaajtenI+7F0yYtQkDSyq2kFbjxua2wdznC+xHTmUT6Sjo1nJHVI0
         oYSnNlrncldiRR+orqxDhtgX6lpemCclkUVY4hHwk1agRyzuASUz94JnOlMow86VEDC4
         pecA==
X-Gm-Message-State: AOAM531s1R5aT95CD0CnmsnmeDxTeUwSMeiu7hjKCVk9IOUvw4tkgNXX
        A+ak2L5uZEZNQe0zIshhBRZeE48jPw==
X-Google-Smtp-Source: ABdhPJzyIK4O/Pgp9CPyEjSzzScxFEpun+hlkMs/+bvpuXIaHYFsiTrN2QdUJdfQfofRcBMjZscHTg==
X-Received: by 2002:a05:6e02:b4e:b0:2d3:dd2a:5d58 with SMTP id f14-20020a056e020b4e00b002d3dd2a5d58mr22851076ilu.26.1654805682931;
        Thu, 09 Jun 2022 13:14:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a1-20020a056e0208a100b002d53ade2fffsm5763938ilt.85.2022.06.09.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:14:42 -0700 (PDT)
Received: (nullmailer pid 28924 invoked by uid 1000);
        Thu, 09 Jun 2022 20:14:40 -0000
Date:   Thu, 9 Jun 2022 14:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,tcsr: Convert to dtschema
Message-ID: <20220609201440.GA28822-robh@kernel.org>
References: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 07 Jun 2022 15:34:42 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Top Control and Status Register to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,tcsr.txt     | 24 ---------
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
