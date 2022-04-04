Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7094F1EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380864AbiDDVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379833AbiDDSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:14:39 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09C3EA8F;
        Mon,  4 Apr 2022 11:12:43 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id k10so10957430oia.0;
        Mon, 04 Apr 2022 11:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XS6wd7KBJkWjJUIjJgiow3emNKY1rL+GG1As3obGiU=;
        b=gkWFV+6DejGHSNi9kc7Ghv5YFK3/z0xF0wF/r0+jvntMTzyzS9MrLO9X1OStIQ3ULk
         Kwl4shaHWslF4g45h1iEvQvqPzrmroh2+bfIXoXIF7pCLug8dK30+RiExbTjINq6zwBq
         C6nUv3wOJd/vPiRuAi1BL94rmf6qVYUvuPwQCHNy6a8MWRSUy81hUwlu/O3H3PyM4e3i
         AMoOqSUuDonxBfacmphtkDdH1YRkzIworzpxfrl2VwDwsgahfF4wizU2FysXMeA8d7Jz
         /6TR4yH6HB/Z0D55psasyRCkjUOjIGk0LeDV/+dN1buLkJmlpWwfT5VP8q5TPE6aEiRE
         Oe7w==
X-Gm-Message-State: AOAM530cpPPPehsIFugmEgbz36jVv4Eys7kwlYvBBRZoONT6ojJMRf9f
        dtP8broRh/UKaGAQM/vQkA==
X-Google-Smtp-Source: ABdhPJwd/bAV5beScgDIr/RlKmA9hCr/TJhNTGDzZzAUz4bpVpq2T2M+qtBiWdusjWeAdtrIZ2Mh5g==
X-Received: by 2002:a05:6808:4d2:b0:2ee:f75b:41d9 with SMTP id a18-20020a05680804d200b002eef75b41d9mr208098oie.20.1649095962562;
        Mon, 04 Apr 2022 11:12:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a4addc4000000b00324bd261e5fsm4088420oov.11.2022.04.04.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:12:41 -0700 (PDT)
Received: (nullmailer pid 1649882 invoked by uid 1000);
        Mon, 04 Apr 2022 18:12:40 -0000
Date:   Mon, 4 Apr 2022 13:12:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <Yks1GJRkM4PjE/W1@robh.at.kernel.org>
References: <20220329113718.254642-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329113718.254642-1-krzysztof.kozlowski@linaro.org>
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

On Tue, Mar 29, 2022 at 01:37:17PM +0200, Krzysztof Kozlowski wrote:
> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> address rejected: User unknown in virtual alias table), so switch
> maintainers to Andy and Bjorn (as Qualcomm platform maintainers).
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml  | 4 ++--
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> index 1ca081b1664e..1bc12b6a7e01 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> @@ -7,8 +7,8 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: GENI Serial Engine QUP Wrapper Controller
>  
>  maintainers:
> -  - Mukesh Savaliya <msavaliy@codeaurora.org>
> -  - Akash Asthana <akashast@codeaurora.org>
> +  - Andy Gross <agross@kernel.org>

Andy is no longer active AFAIK, so I don't think I'd add him.

> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>  
>  description: |
>   Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> index 055524fe8327..e009cb3e6dc9 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> @@ -8,8 +8,8 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: Qualcomm Quad Serial Peripheral Interface (QSPI)
>  
>  maintainers:
> -  - Mukesh Savaliya <msavaliy@codeaurora.org>
> -  - Akash Asthana <akashast@codeaurora.org>
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>  
>  description: The QSPI controller allows SPI protocol communication in single,
>    dual, or quad wire transmission modes for read/write access to slaves such
> -- 
> 2.32.0
> 
> 
