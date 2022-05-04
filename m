Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB53B51A429
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352565AbiEDPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbiEDPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:40:44 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396561659C;
        Wed,  4 May 2022 08:37:07 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so1157959otl.0;
        Wed, 04 May 2022 08:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+491uatbBNklSf07jZRBjGyT71SmXQky++32pxlRJE=;
        b=VkHC6cbWYvI8BT0dTRdv5td4/bPuSH1yuEXRlNqufGbaTglRLua087tf/DW/mvT0rB
         4uqCz4tUpLAovcOWSp/k5FY1jlxEMw+iBPo7ij+sz3cCVhPnb+H4g5svNRTT7ENHmWBf
         6JTFFiYby9ceaoV8trQv8JLge1ULL19ncV6Q3RNlOur303nXvFaOhMbGZtDBJVzFuB1P
         2chHastE1EN/LQ4C073vuP3+3PfKuRoiQ0oJB60O+IheZ+TIeGbqvOdP7hlUeXl8f0M1
         Ms7v+IcHAionkbzOF0zJAJ9o2bhwlPPMuVqorKLk3Yf8x182xlCqxV1PaEp4Ygj+EqF8
         Saqg==
X-Gm-Message-State: AOAM531Geh1S1JW5+x/Flb13B86d3jJZqKuRLCrNi4XlxI+wAv/KY0QE
        DBY9e615lZwoJP07vSrGeHqmL3M21g==
X-Google-Smtp-Source: ABdhPJwOA2TQTPagMyY/d/b2379s4djD8KoNRcc2UmGBn4bQGTVBpdokxfhoi0xudJn30hCjsg4d8A==
X-Received: by 2002:a05:6830:1e18:b0:605:f631:1bed with SMTP id s24-20020a0568301e1800b00605f6311bedmr7512441otr.137.1651678626482;
        Wed, 04 May 2022 08:37:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x108-20020a9d37f5000000b006060322123csm5109675otb.12.2022.05.04.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:37:06 -0700 (PDT)
Received: (nullmailer pid 1755199 invoked by uid 1000);
        Wed, 04 May 2022 15:37:02 -0000
Date:   Wed, 4 May 2022 10:37:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: qcom,spi-geni-qcom: allow three
 interconnects
Message-ID: <YnKdnv69vueSURiU@robh.at.kernel.org>
References: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
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

On Wed, May 04, 2022 at 02:51:19PM +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come with three
> interconnects.  This fixes dtbs_check warnings like:
> 
>   sm8450-qrd.dtb: geniqup@8c0000: spi@880000:interconnect-names: ['qup-core', 'qup-config'] is too short

I'm confused. A length of 2 was already allowed before this change.

> 
> Fixes: 5bdcae1fe1c5 ("spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Fix for a commit in MSM/Bjorn's tree.
> ---
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> index e2c7b934c50d..47e1b3ee8b1b 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -45,12 +45,15 @@ properties:
>        - const: rx
>  
>    interconnects:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    interconnect-names:
> +    minItems: 2
>      items:
>        - const: qup-core
>        - const: qup-config
> +      - const: qup-memory
>  
>    interrupts:
>      maxItems: 1
> -- 
> 2.32.0
> 
> 
