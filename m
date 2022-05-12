Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419A524628
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbiELGux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiELGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:50:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971F616C;
        Wed, 11 May 2022 23:50:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l11so3752014pgt.13;
        Wed, 11 May 2022 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=GDtSUd3+3FvleNdNo5qvdUv+pBK1487kb+LMeT3yIhY=;
        b=KbywR13DJWjHj472g6YqxoWvg9OPjC7yUaFR8Rg0JByb/bayBgdzIS6sPw8VWE+QcL
         LIlLFeU5EY8eC5diblq3T8F2uPC/p7q9EWKhxcLFKbnNaXs8XL+md48V/m7owwT5BS0f
         7RuxkO9SXftg8vdS2q/hwJg1DRdhrdDI+U17IkP2Du3Ep6e4SMu0tJRhGVNhbCAG47q3
         pjXVsmq5HAZ9uwUgv4apWTqmpqWJHU+KzqzHGXwoxO1ifCOiwjfrWl6m0/r2Y9muT88L
         ch5j96GMkoeKYn/Vuq7nek/5S59ypEbJS8mtkZ+w4q2b+yoo8iyrAoHDIB7eatYTbW5l
         ZSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=GDtSUd3+3FvleNdNo5qvdUv+pBK1487kb+LMeT3yIhY=;
        b=ptaoybsL7KN138T9uQnxNV8I78v4VAN0ooQHcgz4Z7mKkXywNH6EU2gR9ha5bhZt5C
         J7Smpsgogy1gRLboPlxGPu0zsUAPVYNWpMAfaQDyJu8QFV21CrJ0z7hA48MZMldoAHc4
         CXsLbDcef11KhzqMLB6aRE57jnLOQc8UFIyB02o1vyDC5K9+vYYJDSwVCP+GDd/tC3As
         lG3SqHtdfJb4KA4C59wuiEX/gYKbcL+ye2qCkw8yK3EmL+Hnbe/lC1Dlthnqi2W/MhmB
         k0sKTuKYlGQb3n8c+632FwU+ObgZiDerkyCAey5nHmrbLfzJWD4S7grfGnCOZX4/gn5i
         IldA==
X-Gm-Message-State: AOAM5300W5oXUZZUrBocSFyxbXAcd4oQ/3J41iLeiLtshhjG22bABhi2
        vtovPqIQzsyMY9YamzWb5yjQRYWIOb+iLx5x
X-Google-Smtp-Source: ABdhPJzu19fpYpJIOHAIYMITyORGelofBcFut2MSOZr+PA8dmZ0lPdXPBcLbIYCoLh3ZexgThIiT2Q==
X-Received: by 2002:a63:6547:0:b0:3c2:13dc:aff with SMTP id z68-20020a636547000000b003c213dc0affmr24367797pgb.14.1652338246688;
        Wed, 11 May 2022 23:50:46 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b00512c63bfaf0sm2001478pfa.62.2022.05.11.23.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 23:50:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 12:20:40 +0530
Message-Id: <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to
 YAML
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
In-Reply-To: <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 10:45 PM IST, Krzysztof Kozlowski wrote:
> On 11/05/2022 18:15, Sireesh Kodali wrote:
> > Convert the dt-bindings from txt to YAML. This is in preparation for
> > including the relevant bindings for the MSM8953 platform's wcnss pil.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
> Please use existing bindings or example-schema as a starting point. Half
> of my review could be skipped if you just followed what we already have
> in the tree.
>
> Some of these qcom specific properties already exist but you decided to
> write them differently... please don't, rather reuse the code.
>

Thank you for your review, I will make the chnages as appropriate in v2.
> (...)
>
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description:
> > +  This document defines the binding for a component that loads and boo=
ts
> > +  firmware on the Qualcomm WCNSS core.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,pronto-v2-pil
> > +          - enum:
> > +              - qcom,pronto
>
> This does not look correct. The fallback compatible should not change.
> What is more, it was not documented in original binding, so this should
> be done in separate patch.
>

This was not a change to the fallback compatible. msm8916.dtsi's wcnss
node has "qcom,pronto" as the compatible string, which is why this was
added. It is however not documented in the txt file. Is it sufficient to
add a note in the commit message, or should it be split into a separate
commit?

> > +      - items:
>
> No need for items, it's just one item.
>
> > +          - enum:
> > +              - qcom,riva-pil
> > +              - qcom,pronto-v1-pil
> > +              - qcom,pronto-v2-pil
> > +
> > +  reg:
> > +    description: must specify the base address and size of the CCU, DX=
E and PMU
> > +      register blocks
>
> New line after "decription:", drop "must specify" and start with capital
> letter.
>
> You need maxItems: 3
>

Will fix in v2
>
> > +
> > +  reg-names:
> > +    items:
> > +      - const: ccu
> > +      - const: dxe
> > +      - const: pmu
> > +
> > +  interrupts-extended:
> > +    description:
> > +      Interrupt lines
>
> Skip description, it's obvious.
>
> It should be only "interrupts", not extended.
>
> > +    minItems: 2
> > +    maxItems: 5
> > +
> > +  interrupt-names:
> > +    minItems: 2
> > +    maxItems: 5
>
> Names should be clearly defined. They were BTW defined in original
> bindings, so you should not remove them. This makes me wonder what else
> did you remove from original bindings...
>
> Please document all deviations from pure conversion in the commit msg.
> It's a second "hidden" difference.
>

Sorry, this was meant to be a pure txt->YAML conversion. The missing
interrupt names was accidental, and will be fixed in v2.
> > +
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Relative firmware image path for the WCNSS core. Defa=
ults to
> > +      "wcnss.mdt".
>
>
> Blank line after "description:". This applies to other places as well.
>
> Remove "Defailts to ..." and just add "default" schema.
>

Will be fixed in v2
> > +
> > +  vddpx-supply:
> > +    description: Reference to the PX regulator to be held on behalf of=
 the
> > +      booting of the WCNSS core
> > +
> > +  vddmx-supply:
> > +    description: Reference to the MX regulator to be held on behalf of=
 the
> > +      booting of the WCNSS core.
> > +
> > +  vddcx-supply:
> > +    description: Reference to the CX regulator to be held on behalf of=
 the
> > +      booting of the WCNSS core.
>
> s/Reference to the//
>
> > +
> > +  power-domains:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: References to the power domains that need to be held =
on
> > +      behalf of the booting WCNSS core
>
> 1. Ditto.
> 2. No need for ref
> 3. maxItems
>
> > +
> > +  power-domain-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
>
> No need for ref, skip description.
>
> > +    description: Names of the power domains
> > +    items:
> > +      - const: cx
> > +      - const: mx
> > +
> > +  qcom,smem-states:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: States used by the AP to signal the WCNSS core that i=
t should
> > +      shutdown
> > +    items:
> > +      - description: Stop the modem
> > +
> > +  qcom,smem-state-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
>
> No need for ref. Really, it does not appear in any of existing bindings
> for smem-state-names, so how did you get it?
>

The smem nodes were copied from /remoteproc/qcom,sdm845-adsp-pil.yaml

> > +    description: The names of the state bits used for SMP2P output
> > +    items:
> > +      - const: stop
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +    description: Reference to the reserved-memory for the WCNSS core
> > +
> > +  smd-edge:
> > +    type: object
> > +    description:
> > +      Qualcomm Shared Memory subnode which represents communication ed=
ge,
> > +      channels and devices related to the ADSP.
>
> You should reference /schemas/soc/qcom/qcom,smd.yaml

Will be done in v2
>
> > +
> > +  iris:
>
> Generic node name... what is "iris"?
>
Iris is the RF module, I'll make the description better

> > +    type: object
> > +    description:
> > +      The iris subnode of the WCNSS PIL is used to describe the attach=
ed rf module
>
> s/rf/RF/
>
> > +      and its resource dependencies.
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - qcom,wcn3620
> > +          - qcom,wcn3660
> > +          - qcom,wcn3660b
> > +          - qcom,wcn3680
> > +
> > +      clocks:
> > +        description: XO clock
> > +
> > +      clock-names:
> > +        items:
> > +          - const: xo
> > +
> > +    required:
> > +      - compatible
>
> clocks and clock-names were required.
> Missing supplies, which were btw as well required.
>
This was unintentional, it will be fixed in v2.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts-extended
> > +  - interrupt-names
> > +  - vddpx-supply
> > +  - memory-region
> > +  - smd-edge
> > +  - iris
> > +
> > +additionalProperties: false
> > +
> > +if:
>
> Within allOf, please.
>

Will be fixed in v2
>
>
> Best regards,
> Krzysztof

Thanks again for the review,
Sireesh
