Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C745288C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiEPPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245341AbiEPPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:25:25 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2103C705;
        Mon, 16 May 2022 08:25:24 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so10271810otk.1;
        Mon, 16 May 2022 08:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OpVnMo42G5s86PrfDD1Zlh8XPSNlbAHUDJJNgTC/Y9E=;
        b=Yx3qtJPGKgzOENUnk58tn+v08w+XIRZb6rS6ChkB4a6+KY2K10y6ozK4YkdW7S2KYQ
         SXwt4ENGsQjUtgjJoFcGn/L7zNrnhbf9sp8SO62mmiohw/7GCN422+0LCNGcRvCz5rVV
         LP5zQIs2VbwiHRgMxxouKKJ/jLGSSlk7MN+8lKaMqV2MfvBToyMTkAGichBA2uPpH2h7
         2WrJQu/ODMEiyB69r0vnDOLmH4BHJFfUCpN+1AUHZWLTlj9sNrcrQOYNVzSJnRVwuPAt
         4a6ObECvz+rQTyQYR3ZoRE3Lgbms5bLz/vgp11jiJbb6n62yhY9WMj4b4PkNDY4Vft3i
         4Ytg==
X-Gm-Message-State: AOAM533MP9cdyw4OzxZQDiHUpbvkLlI7S6HPI6G1MrEir5BGy9HPK8Cz
        0aaZLfY8pf6NZyDwFVgl5w==
X-Google-Smtp-Source: ABdhPJzQb6U+yxx1+Yyv+RdOBdfG4c9OWyZUaP/P8dWPXkSvXkWGRT72AonAuE9aQlT52lkdYFq4qg==
X-Received: by 2002:a9d:24a8:0:b0:606:b2b8:cfb6 with SMTP id z37-20020a9d24a8000000b00606b2b8cfb6mr6157234ota.237.1652714723474;
        Mon, 16 May 2022 08:25:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i20-20020a4a8d94000000b0035eb4e5a6c5sm4246865ook.27.2022.05.16.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:25:22 -0700 (PDT)
Received: (nullmailer pid 2675482 invoked by uid 1000);
        Mon, 16 May 2022 15:25:21 -0000
Date:   Mon, 16 May 2022 10:25:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH 08/12] dt-bindings: remoteproc: qcom,smd-edge: define
 re-usable schema for smd-edge
Message-ID: <20220516152521.GA2672819-robh@kernel.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
 <20220512100006.99695-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512100006.99695-9-krzysztof.kozlowski@linaro.org>
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

On Thu, May 12, 2022 at 12:00:02PM +0200, Krzysztof Kozlowski wrote:
> 'smd-edge' property appears in multiple bindings, so split it into one
> place which can be re-used.  This reduces code duplication and strict
> schema matching for smd-edge nodes (instead of just "type:object").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  2 +-
>  .../bindings/remoteproc/qcom,smd-edge.yaml    | 88 +++++++++++++++++++
>  .../bindings/soc/qcom/qcom,smd.yaml           | 53 +----------
>  3 files changed, 91 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index 4dfbfece1ec7..3072af5f9d79 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -148,7 +148,7 @@ properties:
>        three offsets within syscon for q6, modem and nc halt registers.
>  
>    smd-edge:
> -    type: object
> +    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
>      description:
>        Qualcomm Shared Memory subnode which represents communication edge,
>        channels and devices related to the ADSP.
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> new file mode 100644
> index 000000000000..fde2c450e8b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,smd-edge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SMD Edge communication channel nodes
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  Qualcomm SMD subnode represents a remote subsystem or a remote processor of
> +  some sort - or in SMD language an "edge". The name of the edges are not
> +  important.
> +
> +
> +  See also Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
> +
> +properties:
> +  $nodename:
> +    const: "smd-edge"
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string

Don't need a type here. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
