Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E564CACD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbiCBSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244393AbiCBSD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:03:29 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496339FE3;
        Wed,  2 Mar 2022 10:02:45 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso2778812oop.13;
        Wed, 02 Mar 2022 10:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgE6mXj5k3v9QZZO5v/Knmz+OxYujVNrLAAks+xKJQ4=;
        b=NhVnxH/QsUCbCCAm2DV+xb1HnYy1YGEG1a1qkvB0vleZgiEQmaha1Pfx7+vPS3ldR8
         DSPcE017VYt36BGavcBpro/e+DAGXamHuIS4nJq/EglC1wDu7tENsB8L2FTpB54L1Tmf
         ZoGgX7vKYCQa+TaWiYxCatTBpQsdX+LfbK/3Wmnz7jdJYDHshzaU1MuqW3npw/rOhyGK
         DcSxlHlcmkfHfCP7dqoNvT372hyBEtUzS1EeEjRJ5Ak53TUmcwPGGMqnbAiipWLzdelb
         MlN96e8C6zZa8IMzaXHRXXcObXdlasbcyqjjmH+QkqSkVst6cIw3k53j0QJ0n6mNTafv
         LSPQ==
X-Gm-Message-State: AOAM533SWiGWVmvr1awGpdwpWq2KYcg/eRdXgxkXzOsMXazpkE4Hoi1/
        Ii8HWDrUL5uMqC8fCwaz8w==
X-Google-Smtp-Source: ABdhPJyA0Rt6qcpNxU14kgn7YYDpWhkXrSU6jmXb3jSq8JPxYyTQ880stHIx2uKruejT3XtNaFV2jA==
X-Received: by 2002:a05:6871:79b:b0:d3:4039:7e7c with SMTP id o27-20020a056871079b00b000d340397e7cmr814561oap.121.1646244164495;
        Wed, 02 Mar 2022 10:02:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t82-20020a4a3e55000000b0031847b47aaasm8196143oot.26.2022.03.02.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:02:43 -0800 (PST)
Received: (nullmailer pid 3971499 invoked by uid 1000);
        Wed, 02 Mar 2022 18:02:42 -0000
Date:   Wed, 2 Mar 2022 12:02:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: msm: Add optional resets
Message-ID: <Yh+xQg7ycLMHLMcS@robh.at.kernel.org>
References: <20220302012931.4107196-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302012931.4107196-1-bjorn.andersson@linaro.org>
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

On Tue, Mar 01, 2022 at 05:29:30PM -0800, Bjorn Andersson wrote:
> Add an optional reference to the MDSS_CORE reset, which when specified
> can be used by the implementation to reset the hardware blocks.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New approach/patch
> 
>  .../devicetree/bindings/display/msm/dpu-qcm2290.yaml          | 4 ++++
>  Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml | 4 ++++
>  Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml | 4 ++++
>  Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml | 4 ++++
>  4 files changed, 16 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

