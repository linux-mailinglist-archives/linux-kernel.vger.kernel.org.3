Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B653307C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiEXSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiEXSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:33:29 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77C6B092;
        Tue, 24 May 2022 11:33:28 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id i66so22384038oia.11;
        Tue, 24 May 2022 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osmoK8nEM3jq9+H1tyN0glH3K5aIE7ekbxWxddh47XE=;
        b=rL1Am3Pw/hJ8BYqTKvaQUkcOCozkor4bylTQd0IJKXVJ1lOvaFSrL7lAGy0ZB2VO3f
         cR+nsXwGBwdsoEDVcjKvmX4PWa/o/YYO6ifld0t1j/0f4Xl/7xPHsLywvLvvAYykvMRx
         +DG/8uoOdHDed4d2F3CC5EBcAU8Gbayn5zkyouiCiNzWPSiJxetNvUtkTx8pxOAZA3s2
         F5oW8sq4UU8HYocsS6qCiZWHyAwGESczkwc+n3+EEW6meQiWwKbMlaHw8Ux/8udN/X8P
         Utntd3IbVrLEX5F1J1e9e+IVG7phf/0iA27hk/Rc5AgNdfx6utzKVHpmLW+cgifXa6pl
         iY5A==
X-Gm-Message-State: AOAM533JwHjKDBZD3OM6n0nAfTbyTeooLC2Rycj123Q/Yel2YPOyG2Q/
        zd1R/B1GqMDYf/Aq0CBPI+vttKAn7g==
X-Google-Smtp-Source: ABdhPJxL0Vk4USoU0vwIPGUIcL0CROOXT1M1fUxzIdlczQcE6baLMQ9+LjLey3T5QatKO3HWk+ML0w==
X-Received: by 2002:aca:378a:0:b0:324:f822:675c with SMTP id e132-20020aca378a000000b00324f822675cmr2908164oia.88.1653417207477;
        Tue, 24 May 2022 11:33:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056870440600b000e686d13871sm5191238oah.11.2022.05.24.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:33:26 -0700 (PDT)
Received: (nullmailer pid 4134638 invoked by uid 1000);
        Tue, 24 May 2022 18:33:25 -0000
Date:   Tue, 24 May 2022 13:33:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom,smd: do not use pattern for
 simple rpm-requests string
Message-ID: <20220524183325.GA4134573-robh@kernel.org>
References: <20220524070408.39505-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524070408.39505-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 24 May 2022 09:04:08 +0200, Krzysztof Kozlowski wrote:
> patternProperties should not be used for properties with a simple string
> as name:
> 
>   Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml: patternProperties:^(.*-edge|rpm)$:patternProperties:
>     '^rpm-requests$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#]+\\$$'}
> 
> Fixes: 375eed5f51a8 ("dt-bindings: soc: qcom,smd: convert to dtschema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
