Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483053BAD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiFBOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFBOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:34:08 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BE28184D;
        Thu,  2 Jun 2022 07:34:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f2e0a41009so6955504fac.6;
        Thu, 02 Jun 2022 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVu2oQVild1vEKEAE+Rn0XDQ1xRpMhSCJgQ4U59zTYk=;
        b=ZZ3QM+vL4tRVvjtlv0SZc+pTGL+UO7vgBBhxJ5Pc5MVP0dCee5zUbb+99mOWbKb2Cd
         9kylzmd5AkFpM0JpzMtUCNEEx044GTQGJ/hZjhndtdHYEV4Z8302ShnfnQtdULaD2fOL
         DoJzMAMmCynsBf2PPX02bbPHlZRnfbS6mn2/C2dc7q7eYNn0/CuvWTBLXWnWRGgE5xEY
         JPVvwZKsHsPSoF6yH0yGis4IqlB8CcYaawpyj7ukIIoJ+0KSBMAJVFqH07dD349AbYLs
         Ltx4u/bDO3Rficd4Q+iq4RBVs39TEFIGsH2EyiVn+x6G3cTz2J5P8f+v+5van0mqb4+y
         VXpA==
X-Gm-Message-State: AOAM5321/4pYFhhdhWxCG9C8dHmxIKN0VVTC1VnzkNv71e84E6SCCRjc
        f18q/fAFkMkmLzZO3e1flpCBMPQh4Q==
X-Google-Smtp-Source: ABdhPJzHsqGg59s873sO3ghowbtFbU/KemkqSRcAXPRkYLZuOwweeGLbUVPRfijI5vRbV2R7AvRBJg==
X-Received: by 2002:a05:6870:339a:b0:f2:d065:be1f with SMTP id w26-20020a056870339a00b000f2d065be1fmr2927823oae.69.1654180446565;
        Thu, 02 Jun 2022 07:34:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a05687044c700b000f34dacf350sm2051519oai.6.2022.06.02.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:34:06 -0700 (PDT)
Received: (nullmailer pid 2263860 invoked by uid 1000);
        Thu, 02 Jun 2022 14:34:05 -0000
Date:   Thu, 2 Jun 2022 09:34:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        bhupesh.sharma@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Subject: Re: [PATCH V5] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
Message-ID: <20220602143405.GA2261501-robh@kernel.org>
References: <1654170291-29910-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654170291-29910-1-git-send-email-quic_c_sbhanu@quicinc.com>
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

On Thu, Jun 02, 2022 at 05:14:51PM +0530, Shaik Sajida Bhanu wrote:
> Add gcc hardware reset supported strings for qcom-sdhci controller
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since V4:
> 	- Updated Dt bindings changes YAML format as suggested by
> 	  Ulf Hansson.
> 
> Changes since V3:
> 	- Removed reset-names from DT bindings as suggested by
> 	  Stephen Boyd.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index e423633..5548c35 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -121,6 +121,9 @@ properties:
>      description: A phandle to sdhci power domain node
>      maxItems: 1
>  
> +  resets:
> +    description: Phandle and reset specifier for the device's reset.

Don't need generic descriptions for common properties. What you do need 
is how many entries and what each entry is if more than one.

Rob
