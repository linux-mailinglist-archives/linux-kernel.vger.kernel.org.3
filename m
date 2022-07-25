Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA635580469
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiGYTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiGYTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:18:07 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A87201A5;
        Mon, 25 Jul 2022 12:18:06 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id u76so14670515oie.3;
        Mon, 25 Jul 2022 12:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDk0FZEuxU2uuaKZtdC5XS6n+uPoonjOhnRdKY75YXc=;
        b=AxKpuKFglQT+GtynuW4j3Ut0s/bHp1IAE6vnKvmWvqppWUmSvzI3y+i6P00qELNhi+
         YumA1qvtMMzy5cJtO3mb0wLGqXeqgF9L9fAa1kXghC4gfIsi29l5rTqoE6WKyCZOl1CJ
         9Cp4VLQ4bcGmX3NyVJdchUGMmt9HqCNslgEa6s+6mA4V4ZMepB/HsTuSotbaZvxmqwwv
         UOZ5UBJhNVvHuEMnsMTrm5FRf7cY/vHuHgwoYbbq+uViILRu873svU7yAg+np7RsvWlZ
         rZnThOxU6At3CyIH6Q2milPmcujF4jUYjgE8NuMGUZ6RnWgGghXrSOlihtZtMhoCKHpl
         k5RA==
X-Gm-Message-State: AJIora9LIJo/O5/wa4aF3uIBzToWaULhGWCQQqE2lhiW2SsGi/LqfWG9
        fBTvaIrh6eREAD6ibdij+A==
X-Google-Smtp-Source: AGRyM1vIbmiCL5PXhgCKFFG4lHm+L/R990EXKfWOyJ3ZPOpHqcumTytalUbbgKa4ZdE1oJZFoyVrHg==
X-Received: by 2002:aca:ab13:0:b0:33a:9e31:7038 with SMTP id u19-20020acaab13000000b0033a9e317038mr12745070oie.223.1658776685641;
        Mon, 25 Jul 2022 12:18:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u189-20020acaabc6000000b003263cf0f282sm5161153oie.26.2022.07.25.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:18:05 -0700 (PDT)
Received: (nullmailer pid 2536263 invoked by uid 1000);
        Mon, 25 Jul 2022 19:18:03 -0000
Date:   Mon, 25 Jul 2022 13:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: soc: qcom: smd-rpm: extend example
Message-ID: <20220725191803.GA2536201-robh@kernel.org>
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
 <20220723082358.39544-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723082358.39544-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 10:23:58 +0200, Krzysztof Kozlowski wrote:
> Replace existing limited example with proper code for Qualcomm Resource
> Power Manager (RPM) over SMD based on MSM8916.  This also fixes the
> example's indentation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       | 33 +++++++++++++++----
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
