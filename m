Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C5518B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiECRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiECRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:44:19 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF512AFF;
        Tue,  3 May 2022 10:40:46 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e656032735so17943098fac.0;
        Tue, 03 May 2022 10:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=siZbujmt7vQ4sJ6au98I9XS8Yd5ti5LrSFfgPvyl/Ks=;
        b=twyXSGciQ7SVvWIiSYJbj9styw3utP/G4GjbrWLKPCL/WVB33tsCeiUuwzCVs6NHWN
         IXXeTqeCzaAUixfqPhy54q8m71D13DLXnEvXlaw7YXgQE/NqM9Naf+VXIjaLokJvmK50
         A36peKSS8AS2M3hH+KdPKgsMeOcm/qGqFc1plv7QoW6lypKTdIlc7svxL36ja26xj6RM
         u5dpMsP7wh+V+mAxSGW3pDGzKwkFa2rk5JUx81q9/sZhbAyVGUK4Ee8Cl4ZW+8ug7Znr
         4x2/uPrZ7fPLxyShycNeqt/vio/UB+sKntNA3sC1492QqPYcAMyaJW8OIX+ufEfdCgRA
         bn1g==
X-Gm-Message-State: AOAM533y1/HUA1roYVE2WZzqU+1pAtQMPcwQVp3Eo3xnL3mrASZC6k3I
        R35uB31kR/+K1W/bnTRjMCQcnw394g==
X-Google-Smtp-Source: ABdhPJzpflgXomVrdFYXYUdqw9hHS6rHrJtqr24Xyl8vzUSWNJXHoFjlcuTfg2aWHr0L51sMSGCOzA==
X-Received: by 2002:a05:6870:340e:b0:ec:c40f:e630 with SMTP id g14-20020a056870340e00b000ecc40fe630mr2124593oah.144.1651599645934;
        Tue, 03 May 2022 10:40:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870878700b000e686d1386csm7158390oam.6.2022.05.03.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:40:45 -0700 (PDT)
Received: (nullmailer pid 3932684 invoked by uid 1000);
        Tue, 03 May 2022 17:40:44 -0000
Date:   Tue, 3 May 2022 12:40:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: msm: Add sc8180x and sc8280xp LLCC
 compatibles
Message-ID: <YnFpHPmIn7lufCbn@robh.at.kernel.org>
References: <20220502215406.612967-1-bjorn.andersson@linaro.org>
 <20220502215406.612967-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502215406.612967-2-bjorn.andersson@linaro.org>
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

On Mon, 02 May 2022 14:54:05 -0700, Bjorn Andersson wrote:
> Add compatibles for the SC8180X and SC8280XP platforms to the existing
> LLCC binding.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Picked up Krzysztof's ack
> 
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
