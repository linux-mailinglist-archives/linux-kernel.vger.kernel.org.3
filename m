Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612C501864
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiDNQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347039AbiDNQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:51 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AF1066E7;
        Thu, 14 Apr 2022 08:51:02 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id g17-20020a9d6191000000b005e8d8583c36so3656510otk.8;
        Thu, 14 Apr 2022 08:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MPg8OKyiyQeA31rFhxzDutjNV/rxmutM88qSYThi0Q=;
        b=cmeKPHSuGAvlUiLjhKr5VhXht4RbIR+mFbCgdQV4ZUa+w39FC0+WJdQox1qUaKn387
         yNxY6Vu/ozTd96F2DSF4J4csQHybgP0Re4p3ioIMQ2CLFe44acUZQ1aR8HLCVSlYoRIw
         WMidwBSu35ptWlMUD0EEEuZ20ayjOMeIyZK3RP5kfiBMhTET7NNW4zs74Ws5GZgX53xY
         aR/p0eTGWYSSVaM7l1MhRrkFtYVQvOCX1XnTavfr5PGIF/M558LQDMo6PzoY+016fDDs
         ryDzxtlP0wlu2fmEA+oLw5995ndC2oKWuNk7gS9bcuOHb+sgXeArNSPL5oPcxtHCTVA0
         4MlQ==
X-Gm-Message-State: AOAM531Hw0C02FENDJlCv7PcprjluYpvzg5gtW5RVpg0vMxjaI1W+6Mk
        KZGw4hFObKNGNq5NvErATg==
X-Google-Smtp-Source: ABdhPJxaEQz1K8lTJldqv9W54iJUO61jQZMSCTCf5cNn3IbLcn1CiQu0r0tV09L5oyhV2z9QqA/3cA==
X-Received: by 2002:a9d:71c8:0:b0:602:3f40:f9ec with SMTP id z8-20020a9d71c8000000b006023f40f9ecmr381662otj.224.1649951461743;
        Thu, 14 Apr 2022 08:51:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a19-20020a0568301dd300b0060131a30a1dsm133704otj.67.2022.04.14.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:51:01 -0700 (PDT)
Received: (nullmailer pid 2120315 invoked by uid 1000);
        Thu, 14 Apr 2022 15:51:00 -0000
Date:   Thu, 14 Apr 2022 10:51:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: document
 supplies per variant
Message-ID: <YlhC5B+ZaNn9wUuB@robh.at.kernel.org>
References: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
 <20220412073123.27229-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412073123.27229-2-krzysztof.kozlowski@linaro.org>
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

On Tue, Apr 12, 2022 at 09:31:22AM +0200, Krzysztof Kozlowski wrote:
> The RPMH regulator binding covers several devices with different
> regulator supplies, so it uses patterns matching broad range of these
> supplies.  This works fine but is not specific and might miss actual
> mistakes when a wrong supply property is used for given variant.
> 
> Describe the supplies depending on the compatible, using a defs-allOf
> method.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/qcom,rpmh-regulator.yaml        | 290 +++++++++++++++++-
>  1 file changed, 276 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> index 842ccef691b8..773536fe37c7 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> @@ -95,35 +95,297 @@ properties:
>    vdd-rgb-supply:
>      description: Input supply phandle of rgb.
>  
> -  vin-lvs-1-2-supply:
> -    description: Input supply phandle of one or more regulators.
> -
> -  vdd-bob-supply:
> -    description: BOB regulator parent supply phandle.
> -
>    bob:
>      type: object
>      $ref: "regulator.yaml#"
>      description: BOB regulator node.
>  
>  patternProperties:
> -  "^vdd-s([0-9]+)-supply$":
> -    description: Input supply phandle(s) of one or more regulators.
> -
> -  "^vdd-(l[0-9]+[-]){1,5}supply$":
> -    description: Input supply phandle(s) of one or more regulators.
> -
>    "^(smps|ldo|lvs)[0-9]+$":
>      type: object
>      $ref: "regulator.yaml#"
>      description: smps/ldo regulator nodes(s).
>  
> -additionalProperties: false
> -
>  required:
>    - compatible
>    - qcom,pmic-id
>  
> +allOf:
> +  - $ref: "#/$defs/pm6150"
> +  - $ref: "#/$defs/pm6150l"
> +  - $ref: "#/$defs/pm7325"
> +  - $ref: "#/$defs/pm8005"
> +  - $ref: "#/$defs/pm8009"
> +  - $ref: "#/$defs/pm8150"
> +  - $ref: "#/$defs/pm8150l"
> +  - $ref: "#/$defs/pm8350"
> +  - $ref: "#/$defs/pm8350c"
> +  - $ref: "#/$defs/pm8450"
> +  - $ref: "#/$defs/pm8998"
> +  - $ref: "#/$defs/pmg1110"
> +  - $ref: "#/$defs/pmi8998"
> +  - $ref: "#/$defs/pmr735a"
> +  - $ref: "#/$defs/pmx55"
> +  - $ref: "#/$defs/pmx65"
> +
> +unevaluatedProperties: false
> +
> +$defs:

I'm not following on why you need $defs here rather than putting the 
if/then schemas under the 'allOf'. $defs should primarily only be used 
where it saves duplicating a schema 2 or more times. That could be the 
case here if there's a case that's a subset of another case.


> +  pm6150:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm6150-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l2-l3-supply: true
> +        vdd-l4-l7-l8-supply: true
> +        vdd-l5-l16-l17-l18-l19-supply: true
> +        vdd-l10-l14-l15-supply: true
> +        vdd-l11-l12-l13-supply: true
> +      patternProperties:
> +        "^vdd-l[169]-supply$": true
> +        "^vdd-s[1-5]-supply$": true
> +
> +  pm6150l:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm6150l-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-bob-supply:
> +          description: BOB regulator parent supply phandle.
> +        vdd-l1-l8-supply: true
> +        vdd-l2-l3-supply: true
> +        vdd-l4-l5-l6-supply: true
> +        vdd-l7-l11-supply: true
> +        vdd-l9-l10-supply: true
> +      patternProperties:
> +        "^vdd-s[1-8]-supply$": true
> +
> +  pm7325:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm7325-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l4-l12-l15-supply: true
> +        vdd-l2-l7-supply: true
> +        vdd-l6-l9-l10-supply: true
> +        vdd-l11-l17-l18-l19-supply: true
> +        vdd-l13-supply: true
> +        vdd-l14-l16-supply: true
> +      patternProperties:
> +        "^vdd-l[358]-supply$": true
> +        "^vdd-s[1-8]-supply$": true
> +
> +  pm8005:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8005-rpmh-regulators
> +    then:
> +      patternProperties:
> +        "^vdd-s[1-4]-supply$": true
> +
> +  pm8009:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8009-rpmh-regulators
> +            - qcom,pm8009-1-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l5-l6-supply: true
> +      patternProperties:
> +        "^vdd-l[1-47]-supply$": true
> +        "^vdd-s[1-2]-supply$": true
> +
> +  pm8150:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8150-rpmh-regulators
> +            - qcom,pmm8155au-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l8-l11-supply: true
> +        vdd-l2-l10-supply: true
> +        vdd-l3-l4-l5-l18-supply: true
> +        vdd-l6-l9-supply: true
> +        vdd-l7-l12-l14-l15-supply: true
> +        vdd-l13-l16-l17-supply: true
> +      patternProperties:
> +        "^vdd-s([1-9]|10)-supply$": true
> +
> +  pm8150l:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8150l-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-bob-supply:
> +          description: BOB regulator parent supply phandle.
> +        vdd-l1-l8-supply: true
> +        vdd-l2-l3-supply: true
> +        vdd-l4-l5-l6-supply: true
> +        vdd-l7-l11-supply: true
> +        vdd-l9-l10-supply: true
> +      patternProperties:
> +        "^vdd-s[1-8]-supply$": true
> +
> +  pm8350:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8350-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l4-supply: true
> +        vdd-l2-l7-supply: true
> +        vdd-l3-l5-supply: true
> +        vdd-l6-l9-l10-supply: true
> +        vdd-l8-supply: true
> +      patternProperties:
> +        "^vdd-s([1-9]|1[0-2])-supply$": true
> +
> +  pm8350c:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8350c-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-bob-supply:
> +          description: BOB regulator parent supply phandle.
> +        vdd-l1-l12-supply: true
> +        vdd-l2-l8-supply: true
> +        vdd-l3-l4-l5-l7-l13-supply: true
> +        vdd-l6-l9-l11-supply: true
> +        vdd-l10-supply: true
> +      patternProperties:
> +        "^vdd-s([1-9]|10)-supply$": true
> +
> +  pm8450:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8450-rpmh-regulators
> +    then:
> +      patternProperties:
> +        "^vdd-l[1-4]-supply$": true
> +        "^vdd-s[1-6]-supply$": true
> +
> +  pm8998:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pm8998-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l27-supply: true
> +        vdd-l2-l8-l17-supply: true
> +        vdd-l3-l11-supply: true
> +        vdd-l4-l5-supply: true
> +        vdd-l6-supply: true
> +        vdd-l7-l12-l14-l15-supply: true
> +        vdd-l9-supply: true
> +        vdd-l10-l23-l25-supply: true
> +        vdd-l13-l19-l21-supply: true
> +        vdd-l16-l28-supply: true
> +        vdd-l18-l22-supply: true
> +        vdd-l20-l24-supply: true
> +        vdd-l26-supply: true
> +        vin-lvs-1-2-supply: true
> +      patternProperties:
> +        "^vdd-s([1-9]|1[0-3])-supply$": true
> +
> +  pmg1110:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pmg1110-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-s1-supply: true
> +
> +  pmi8998:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pmi8998-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-bob-supply:
> +          description: BOB regulator parent supply phandle.
> +
> +  pmr735a:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pmr735a-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l2-supply: true
> +        vdd-l3-supply: true
> +        vdd-l4-supply: true
> +        vdd-l5-l6-supply: true
> +      patternProperties:
> +        "^vdd-s[1-3]-supply$": true
> +
> +  pmx55:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pmx55-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l1-l2-supply: true
> +        vdd-l3-l9-supply: true
> +        vdd-l4-l12-supply: true
> +        vdd-l5-l6-supply: true
> +        vdd-l7-l8-supply: true
> +        vdd-l10-l11-l13-supply: true
> +      patternProperties:
> +        "^vdd-l1[4-6]-supply$": true
> +        "^vdd-s[1-7]-supply$": true
> +
> +  pmx65:
> +    if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,pmx65-rpmh-regulators
> +    then:
> +      properties:
> +        vdd-l2-l18-supply: true
> +        vdd-l5-l6-l16-supply: true
> +        vdd-l8-l9-supply: true
> +        vdd-l11-l13-supply: true
> +      patternProperties:
> +        "^vdd-l[1347]-supply$": true
> +        "^vdd-l1[0245789]-supply$": true
> +        "^vdd-l2[01]-supply$": true
> +        "^vdd-s[1-8]-supply$": true
> +
>  examples:
>    - |
>      #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -- 
> 2.32.0
> 
> 
