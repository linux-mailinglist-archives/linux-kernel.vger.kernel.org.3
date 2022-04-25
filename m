Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4D50EB99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiDYWYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiDYVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:48:16 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53E23BEF;
        Mon, 25 Apr 2022 14:45:10 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id z8so18661916oix.3;
        Mon, 25 Apr 2022 14:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZMstEGR59a6WeLJcSDZzBTL969MVFol/7kqyWovv4c=;
        b=obXWrnqaFu91kMdRfKfdulQkxPwilw0ID+21Ett64qWaxPNy2uxP56wO5XJYositR4
         JYKRdFty/787G2glyiFp7CU3t5wNUcGCiuiM8sEgOty3FvrKKaGmppIQTRMmjSJVUkfl
         r/3YRJnB7JsuJz1axlyrYmzwhNLWW3Qqpc4UJu+1WXwdw1xstSP5exDmt9o783RMywPa
         cux8yPkniuL3yrj10Gw8dl1br+4z+rWQh93G32YsX7XROWQ8k8Y28PnaqdCBlZgPKwKw
         O/QSvb6YB+6OCESeRpjGLzQKUE2gbHy2H4ieQCD7iFYgpH2yZos3w9YOjuA3850z8QAy
         fcDQ==
X-Gm-Message-State: AOAM530UFRAaIHYtUyu6K+J4lfs68JMO/6ZzCPODjR3QrlpPiS3iVkmC
        Z3Wt2+GDSOIWX3GoVeYQUg==
X-Google-Smtp-Source: ABdhPJy/rpBx/iJkVWRVcZNGd8eAyl3X6OyANl4MITXioNcKwEoeJ12MJdt0640bsxJiI2ms7mVrhw==
X-Received: by 2002:a05:6808:2388:b0:325:e69:4ec5 with SMTP id bp8-20020a056808238800b003250e694ec5mr5220386oib.10.1650923110270;
        Mon, 25 Apr 2022 14:45:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x64-20020acae043000000b003222bb3dfb0sm4208670oig.36.2022.04.25.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:45:09 -0700 (PDT)
Received: (nullmailer pid 344104 invoked by uid 1000);
        Mon, 25 Apr 2022 21:45:09 -0000
Date:   Mon, 25 Apr 2022 16:45:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     dmitry.torokhov@gmail.com, corbet@lwn.net, sre@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@quicinc.com>,
        David Collins <quic_collinsd@quicinc.com>
Subject: Re: [PATCH v6] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Message-ID: <YmcWZLp2X8UYOVas@robh.at.kernel.org>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191239.6271-2-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:12:38PM -0700, Anjelique Melendez wrote:
> From: David Collins <collinsd@quicinc.com>
> 
> Update the description of "reg" property to add the PON_PBS base
> address along with PON_HLOS base address.  Also add "reg-names"
> property description.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/power/reset/qcom,pon.yaml | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 353f155d..65ec8197 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -26,7 +26,24 @@ properties:
>        - qcom,pm8998-pon
>  
>    reg:
> -    maxItems: 1
> +    description: |
> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
> +      peripherals.  In that case, the PON_PBS address needs to be specified to
> +      facilitate software debouncing on some PMICs.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    description: |
> +      For PON GEN1 and GEN2, it should be "pon".  For PON GEN3 it should include
> +      "pon_hlos" and optionally "pon_pbs".
> +    minItems: 1
> +    items:
> +      - const: pon_hlos
> +      - const: pon_pbs
> +      - const: pon

Did you test that 'reg-names = "pon";' works? It doesn't. The schema 
says 'pon' is the 3rd entry in reg-names.

As 'reg-names' is new I thin this should be:

items:
  - const: hlos
  - const: pbs

And if there's 1 entry, then 'reg-names' should not be there.

Rob
