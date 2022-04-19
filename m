Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52550768B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbiDSReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiDSReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:34:21 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1C381B4;
        Tue, 19 Apr 2022 10:31:38 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-de3eda6b5dso18296279fac.0;
        Tue, 19 Apr 2022 10:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsh1+N3AHFl1INtReH0W0OLxuEQj6Zw6DbwHLNwXacE=;
        b=zIGF5NXkktJYBrV8alm5bE97t02hw14nhHqbhTojGUFT0ltIxC1DmUi5XsvgF78o8p
         hOi9UF03hEbiWguwzOPVWkW35JaHzs0ukqlc51Q/LvfVu8P1/2xezSxnpJoDFVc7EUHG
         9xvsS03XL8cT7J5qVslxtbDeqO0TDVWt0l09VwRSKYfrTTNQs60T1tXnTENfEuDF67W1
         doMnHDqRekLZ3KayXjtomuvKhThTbiKr3mIO7XPpw6KdZgkwTyIUnLyBYoDSaOSU1Fe8
         B2F1DHguyH1Ncrs8Tc2+4zXpeTOMx7ZDKJOA+GS6x9EJ2JLp8monLP3B9bHLTZydJ2h2
         J7sQ==
X-Gm-Message-State: AOAM531ctP27o2S9BUUkHxwFYfJenDXlhrStvAxVB8tA4iJqKhtJgaqW
        MdRA1fin/9PVLBz370excQ==
X-Google-Smtp-Source: ABdhPJwZ4amMBF78Uj2HwtGidHVXq6uMihB5xsWXnDCbEN1qgpu+cOZ/oO2Kjw0LPTDblGdXyLBBYA==
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id s37-20020a056870eaa500b000da0b3f2b45mr9151148oap.228.1650389498029;
        Tue, 19 Apr 2022 10:31:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a056870e29400b000da4a0089c9sm5298243oad.27.2022.04.19.10.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:31:37 -0700 (PDT)
Received: (nullmailer pid 3011512 invoked by uid 1000);
        Tue, 19 Apr 2022 17:31:36 -0000
Date:   Tue, 19 Apr 2022 12:31:36 -0500
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
Message-ID: <Yl7x+LG9vdL3mcpC@robh.at.kernel.org>
References: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
 <20220412073123.27229-2-krzysztof.kozlowski@linaro.org>
 <YlhC5B+ZaNn9wUuB@robh.at.kernel.org>
 <39b68e91-93cc-ad74-d064-a29ff01d60a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b68e91-93cc-ad74-d064-a29ff01d60a6@linaro.org>
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

On Tue, Apr 19, 2022 at 08:44:48AM +0200, Krzysztof Kozlowski wrote:
> On 14/04/2022 17:51, Rob Herring wrote:
> > On Tue, Apr 12, 2022 at 09:31:22AM +0200, Krzysztof Kozlowski wrote:
> >> The RPMH regulator binding covers several devices with different
> >> regulator supplies, so it uses patterns matching broad range of these
> >> supplies.  This works fine but is not specific and might miss actual
> >> mistakes when a wrong supply property is used for given variant.
> >>
> >> Describe the supplies depending on the compatible, using a defs-allOf
> >> method.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../regulator/qcom,rpmh-regulator.yaml        | 290 +++++++++++++++++-
> >>  1 file changed, 276 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> >> index 842ccef691b8..773536fe37c7 100644
> >> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> >> @@ -95,35 +95,297 @@ properties:
> >>    vdd-rgb-supply:
> >>      description: Input supply phandle of rgb.
> >>  
> >> -  vin-lvs-1-2-supply:
> >> -    description: Input supply phandle of one or more regulators.
> >> -
> >> -  vdd-bob-supply:
> >> -    description: BOB regulator parent supply phandle.
> >> -
> >>    bob:
> >>      type: object
> >>      $ref: "regulator.yaml#"
> >>      description: BOB regulator node.
> >>  
> >>  patternProperties:
> >> -  "^vdd-s([0-9]+)-supply$":
> >> -    description: Input supply phandle(s) of one or more regulators.
> >> -
> >> -  "^vdd-(l[0-9]+[-]){1,5}supply$":
> >> -    description: Input supply phandle(s) of one or more regulators.
> >> -
> >>    "^(smps|ldo|lvs)[0-9]+$":
> >>      type: object
> >>      $ref: "regulator.yaml#"
> >>      description: smps/ldo regulator nodes(s).
> >>  
> >> -additionalProperties: false
> >> -
> >>  required:
> >>    - compatible
> >>    - qcom,pmic-id
> >>  
> >> +allOf:
> >> +  - $ref: "#/$defs/pm6150"
> >> +  - $ref: "#/$defs/pm6150l"
> >> +  - $ref: "#/$defs/pm7325"
> >> +  - $ref: "#/$defs/pm8005"
> >> +  - $ref: "#/$defs/pm8009"
> >> +  - $ref: "#/$defs/pm8150"
> >> +  - $ref: "#/$defs/pm8150l"
> >> +  - $ref: "#/$defs/pm8350"
> >> +  - $ref: "#/$defs/pm8350c"
> >> +  - $ref: "#/$defs/pm8450"
> >> +  - $ref: "#/$defs/pm8998"
> >> +  - $ref: "#/$defs/pmg1110"
> >> +  - $ref: "#/$defs/pmi8998"
> >> +  - $ref: "#/$defs/pmr735a"
> >> +  - $ref: "#/$defs/pmx55"
> >> +  - $ref: "#/$defs/pmx65"
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +$defs:
> > 
> > I'm not following on why you need $defs here rather than putting the 
> > if/then schemas under the 'allOf'. $defs should primarily only be used 
> > where it saves duplicating a schema 2 or more times. That could be the 
> > case here if there's a case that's a subset of another case.
> 
> The allOf+defs is a workaround for schema behavior. The entire approach
> if defining properties in "if:then:" works only with
> unevaluatedProperties, not with additionalProperties. However
> unevaluatedProperties require to reference other schema, which I do not
> do here. I don't have other schema.
> 
> allOf+def has references tricking schema to accept unevaluatedProperties.

I'm going to relax the meta-schema instead.

Rob
