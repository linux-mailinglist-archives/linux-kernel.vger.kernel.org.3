Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19F5261EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380285AbiEMMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380264AbiEMMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C466FB0;
        Fri, 13 May 2022 05:33:25 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id i66so9905324oia.11;
        Fri, 13 May 2022 05:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OpfAUEQTkPwhvM/zr3ZGgNzzj7N1HTqD0nu98IltT+0=;
        b=Kc+CV+yng3bZELY3qrBklJt7FhXbPIlXOTlemvuGKNF3v2sYu3vlbkJAD9+cta8blt
         FWIGkvd93vgGbjzjStelyVvhb5AUFAIJHT5Ov+B2kCrUjDEg93Y7V/ZOyOvnw13HTURL
         g+OSt57axrJYgieP51/NefPoPcfCKsp7pnFU1wnCD2q43qJ4h1WI2iSavAyTj9T+CJTO
         0WJYsyNFNap01GsGHgFQUInvjW/3aaQpgFccfAyXNs5w6zW8ZwgyQlBv4f/rHEcGuxBb
         cTXb7nvoOd10v+TJaHf9N9aSwHPZBoYrfUHtkq755PD9j5gS7ssEBT54PQ7bP2KflwAS
         JGaA==
X-Gm-Message-State: AOAM530nZHpfUEn3o6VSGjVvK8Q7YXvu9U1sumzxUtdz56S7469wBEvq
        BxbgcbJfkZWQs4Z5ddWXZA==
X-Google-Smtp-Source: ABdhPJyk2WjJ8yZT/KInI0FPITOZxMlS0onLUUNtxPFWmgDFaotQBnCJsXFAv8AsaGq3vmWLkJAX4w==
X-Received: by 2002:a05:6808:2121:b0:326:7593:45b6 with SMTP id r33-20020a056808212100b00326759345b6mr7568460oiw.181.1652445203763;
        Fri, 13 May 2022 05:33:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6212000000b0060603221260sm905703otj.48.2022.05.13.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:23 -0700 (PDT)
Received: (nullmailer pid 85850 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sireesh Kodali <sireeshkodali1@gmail.com>
In-Reply-To: <20220512100006.99695-7-krzysztof.kozlowski@linaro.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org> <20220512100006.99695-7-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 06/12] dt-bindings: remoteproc: qcom,adsp: use GIC_SPI defines in example
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.107710.85849.nullmailer@robh.at.kernel.org>
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

On Thu, 12 May 2022 12:00:00 +0200, Krzysztof Kozlowski wrote:
> Use GIC_SPI defines instead of raw value in the DTS example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


remoteproc@b00000: qcom,halt-regs:0: [28, 102404] is too short
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

