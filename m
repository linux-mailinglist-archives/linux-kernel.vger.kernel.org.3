Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AD52A098
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiEQLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiEQLkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:40:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7223E5D5;
        Tue, 17 May 2022 04:40:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n8so14283281qke.11;
        Tue, 17 May 2022 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uM51Zcymw4uk08szgMKZErz3xEoJBdUgSYcbBXV2GbY=;
        b=pZfuPhwLGJ9jCe30O2q0IX3kvPhgLsZPkwgxHup2DQgixUYZvP/SsfbaP6LP3TjhBL
         zYJtoxEXYWyeu5XmIGFr/pKFj1W+rHpuTgnxYtcATWMwS+tJGt9Bwocu720EqBGMdieQ
         HaJoyP7jdb6+W4tF8xMarVherM3a1rkQmcW4o7zvlUTxp9B1kRXM+0tagy9QmYF08yZi
         208byjI2U8jlP/6Zy0V5+h4VWn1NngxtzKHm/7ELURGMo6m8x0anyJFgBS0iZauS16az
         ssLUgJwNUeXOFTyAdZ+VREOYIOJ4uVn42/eYRO+71TWGHyo9oRoYksLFzsDhBK6q9A+K
         ITnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uM51Zcymw4uk08szgMKZErz3xEoJBdUgSYcbBXV2GbY=;
        b=npWEEUoo2baqI4e6xXi2cUey4McAj0BoAqawmT7Lbts+EVF7kWAqzI3/eqF8xNttmD
         AtBtmAxvK+Ch7frZVgAA98LZpqiWUnDjamlVahyeWEQCjjMJ+yRQXcbgofdmEYEEeIsa
         KnhEBUVVBFzy+JpB/o3WlHxmONVf3ZzgU+buo4xbkdQuY9y1mMDkhseqwb1QbPaWPMga
         AiaWfvjF3Q9sy3lhCW0wMJMpny9oBUMgzJLGN+QyeIuTJ1kYGJfo6pPh7OyoULIQnv/u
         fLUacTT9FOGf+TQiXiEg41jESMrpZsVqCmqlsE9nVny80xGBPB2fO3o0o8P9Q4tyF3JW
         zHMw==
X-Gm-Message-State: AOAM530ZNLta/T+D0RIwD+v3fBXjwBhQ6nYNZUsaDMXk5k/zMv9GIOuE
        b443VzAQIJRqKd6xpojGmMB5At1lPQVQze/3l0Q=
X-Google-Smtp-Source: ABdhPJxNJYcB7qT1GnstL4Yc2ivjya6G/7KHE8kNzleGLFZI+uU9E//UH1YL+g9xhZ8AFHnCNyxrMddb7xpApyvWDMc=
X-Received: by 2002:a05:620a:1a01:b0:69c:fda:7404 with SMTP id
 bk1-20020a05620a1a0100b0069c0fda7404mr15931147qkb.522.1652787638429; Tue, 17
 May 2022 04:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220515203118.474684-1-robimarko@gmail.com> <fa11d71b-d53e-1eb3-22db-e7237c523cd4@linaro.org>
In-Reply-To: <fa11d71b-d53e-1eb3-22db-e7237c523cd4@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 17 May 2022 13:40:27 +0200
Message-ID: <CAOX2RU6AtVY5HSqK6LJk24yK2LPMN8YP4ZFgfHa2geEgwQcAgg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: regulator: qcom,spmi-regulator: Convert
 to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 at 09:26, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 22:31, Robert Marko wrote:
> > Convert the bindings of Qualcomm SPMI regulators to DT schema.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > I am aware that syscon alone is not really acceptable, its converted
> > directly from the old text bindings.
> >
> > There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
> > '#address-cells', '#size-cells', some even defining reg property for
> > regulators.
> >
> > Any advice on how to solve these issues is appreciated.
> > ---
> >  .../regulator/qcom,spmi-regulator.yaml        | 176 ++++++++++++++++++
>
> You miss here the actual conversion... where is the removal of old file?

Hi,

Oh yeah, sorry for forgetting this.
Will fixup in v2.

>
> >  1 file changed, 176 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> > new file mode 100644
> > index 000000000000..f7da310f1845
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> > @@ -0,0 +1,176 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SPMI Regulators
> > +
> > +maintainers:
> > +  - Robert Marko <robert.marko@sartura.hr>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,pm660-regulators
> > +      - qcom,pm660l-regulators
> > +      - qcom,pm8004-regulators
> > +      - qcom,pm8005-regulators
> > +      - qcom,pm8226-regulators
> > +      - qcom,pm8841-regulators
> > +      - qcom,pm8916-regulators
> > +      - qcom,pm8941-regulators
> > +      - qcom,pm8950-regulators
> > +      - qcom,pm8994-regulators
> > +      - qcom,pmi8994-regulators
> > +      - qcom,pms405-regulators
> > +
> > +  qcom,saw-reg:
> > +    description: Reference to syscon node defining the SAW registers
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pm8941-regulators
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          items:
> > +            - description: Over-current protection interrupt for 5V S1
> > +            - description: Over-current protection interrupt for 5V S2
> > +        interrupt-names:
> > +          items:
> > +            - const: ocp-5vs1
> > +            - const: ocp-5vs2
> > +
> > +patternProperties:
>
> This goes just after "properties:"

Will fixup in v2.

Regards,
Robert
>
> > +  ".*-supply$":
> > +    description: Input supply phandle(s) for this node
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +
>
> Best regards,
> Krzysztof
