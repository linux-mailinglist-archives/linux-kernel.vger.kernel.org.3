Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6756805A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiGFHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiGFHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:43:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DE2314B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:43:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu42so4622336lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=sCqxJgiHwg2gn7pT7SVBdgDBrSqiAbmxYrREjlIruR8=;
        b=aNGpPmQd0+6iv/iwx3y7ULO+qF40M3E+ueIpvliy68l/U47nhXkpNbJ6+ZPruGhjTQ
         SyE07lVmJ03sooTwtf1/DbJpY+FGo2t4dTsMX746HF/6n+gfEV/GLhDI/QfSrhgDjROJ
         ZA7apXzDLxSfVR/bNfqoMIvQcREiah/UxUSVShVc5QnlGxzvNW+vi2Rl9BkPqcJemfd1
         zySgBkwahWg4rdwMy0XtE2d0stoxbnJCE16KMvMCuVDRdOnD3NA0qvmOJWAlfPRnekb7
         3YSpDxYOdMyqIyjdz4O1OLfFLI1IQEJV2251lggJ+fVcq7XvnCOF6LpfnXW1X+o4P81b
         Xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sCqxJgiHwg2gn7pT7SVBdgDBrSqiAbmxYrREjlIruR8=;
        b=y90f9pFvkPI1P2ex7rEUhSBOiFNM0jv2uiVMQSUDRSuNsMeJ8nb5s6PfLisU+pe5TY
         cAIPm3FoEnk2n1h8uVM4HJ1eGKmiM+aeZcLHW4XN8t0EY/RLNRchgpuphIj9lLzCEYGY
         ivO1c5LNJQ4Ge3JPRrJU/tDRWKpGZXJim1G9hmx09oE+yY/Fuy/mijbXhIdJhkNaNSij
         BkmUlbrI0uN9yb3fiNna+2WcbVAsGJn8HuXarJ8MCZL/4gsTy8yURhft5LH2XL7BNKXE
         0FS7PPo0dLkePiNVeplhhb1n8LiN+kUfb8ywL96rG4prdiM6FxilwVKdeDKVXChq1OdN
         oxCA==
X-Gm-Message-State: AJIora8z3fyQN+dgeeUI9wCmKjTRTwEl33RPJ4a8+wHchY79N0vZVoKL
        UyJ2St9XPU1qht6iFHjTg913LQ==
X-Google-Smtp-Source: AGRyM1sqUFemROALwykBJdUtm50OkihXymMBaGRnFzA2ualCr1IFmLnVFvgfIx4qLAvo8icCfwzRxA==
X-Received: by 2002:a05:6512:3048:b0:47f:c0e3:9ae8 with SMTP id b8-20020a056512304800b0047fc0e39ae8mr25777182lfb.640.1657093385239;
        Wed, 06 Jul 2022 00:43:05 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512214400b0048109845ab8sm2733806lfr.50.2022.07.06.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:43:04 -0700 (PDT)
Message-ID: <fc6a3282-2186-c458-9c85-b0bd2e0fc624@linaro.org>
Date:   Wed, 6 Jul 2022 09:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: fix wrong clock documentation for
 qcom,rpmcc
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705202837.667-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 22:28, Christian Marangi wrote:
> qcom,rpmcc describe 2 different kind of device.
> Currently we have definition for rpm-smd based device but we lack
> Documentation for simple rpm based device.
> 
> Add the missing clk for ipq806x, apq8060, msm8660 and apq8064 and
> provide and additional example.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,rpmcc.yaml | 77 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 9d296b89a8d0..028eb0277495 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -48,16 +48,65 @@ properties:
>    '#clock-cells':
>      const: 1
>  
> -  clocks:
> -    maxItems: 1
> +  clocks: true
>  
> -  clock-names:
> -    const: xo
> +  clock-names: true

That's not correct way to describe these. Check other files, we've
already talked about this. You need min and maxItems here.

>  
>  required:
>    - compatible
>    - '#clock-cells'
>  
> +if:

allOf

> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,rpmcc-apq8060
> +          - qcom,rpmcc-ipq806x
> +          - qcom,rpmcc-msm8660
> +
> +then:
> +  properties:
> +    clocks:
> +      description: pxo clock
> +
> +    clock-names:
> +      const: pxo
> +
> +  required:
> +    - clocks
> +    - clock-names
> +
> +else:
> +  if:

No nested ifs.

> +    properties:
> +      compatible:
> +        contains:
> +          const: qcom,rpmcc-apq8064
> +  then:
> +    properties:
> +      clocks:
> +        items:
> +          - description: pxo clock
> +          - description: cxo clock
> +
> +      clock-names:
> +        items:
> +          - const: pxo
> +          - const: cxo
> +
> +    required:
> +      - clocks
> +      - clock-names
> +
> +  else:
> +    properties:
> +      clocks:
> +        description: xo clock
> +
> +      clock-names:
> +        const: xo
> +
>  additionalProperties: false
>  
>  examples:
> @@ -73,3 +122,23 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    rpm {
> +        clock-controller {
> +            compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> +            #clock-cells = <1>;
> +            clocks = <&pxo_board>;
> +            clock-names = "pxo";
> +        };
> +    };
> +
> +  - |
> +    rpm {
> +        clock-controller {
> +            compatible = "qcom,rpmcc-apq8064", "qcom,rpmcc";
> +            #clock-cells = <1>;
> +            clocks = <&pxo_board>, <&cxo_board>;
> +            clock-names = "pxo", "cxo";
> +        };

These are the same. Provide examples only for blocks which are
significantly different.


Best regards,
Krzysztof
