Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C9578C34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiGRU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGRU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:56:32 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD32D1C9;
        Mon, 18 Jul 2022 13:56:32 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h16so6694282ila.2;
        Mon, 18 Jul 2022 13:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+SGKaM5PYTsp4dhMAWOhMPFfu9JfJuU7ytqSJNiIms=;
        b=5TPnRoEzSr838C4NPVwGBRquPX8VJZW0P7Fy3FrLhuYEGan4DZTOiBGtOWcts8n+bN
         d/CRR35YV5+5SzxIXzrTg8CfvO5VOXuKbci2jDTrbPV9CHM1qtXAmVz99Cym488wTvOw
         cOPaqoc3h6RzIhD4fe7LPM4wZvuM+9AOPMe5opF/UclyqhOCop2+H2U+ISCDI+9/zB9x
         +lDVWgVqCVBAeosQAebfVpmcQ7Kq38CC8bERkS3wdcrL0+/wo+mDgjZvLF39T69caUj0
         YKiEpnOS4przGuOwuNiJ4vXEJTIynpr5lMWg/i70Cos5zyRyZWxl9OIbjsW4AL3/dxh8
         HO3A==
X-Gm-Message-State: AJIora8akNrTXShGObzknVBaQpz3bOKrpLgl5RcoaC9d1ergyNwpB5nw
        ledptN1MXPG7FsHCu826uA==
X-Google-Smtp-Source: AGRyM1uPgmdQ612VJUv7DoaDaQzxx0K/+K4/OCALhKicgiTopdQ9Q9lnfZD+zIBNMNlHcAaLbS8awA==
X-Received: by 2002:a92:7f12:0:b0:2d9:1e05:6310 with SMTP id a18-20020a927f12000000b002d91e056310mr14135053ild.317.1658177791313;
        Mon, 18 Jul 2022 13:56:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c10-20020a02a60a000000b0033ebf04f624sm5970875jam.152.2022.07.18.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:56:30 -0700 (PDT)
Received: (nullmailer pid 3538882 invoked by uid 1000);
        Mon, 18 Jul 2022 20:56:27 -0000
Date:   Mon, 18 Jul 2022 14:56:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        corbet@lwn.net, sre@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Message-ID: <20220718205627.GA3535152-robh@kernel.org>
References: <20220713193350.29796-1-quic_amelende@quicinc.com>
 <20220713193350.29796-2-quic_amelende@quicinc.com>
 <c129c748-4306-da64-fc18-2d224b2fc97c@linaro.org>
 <ffb31b6f-8ed3-e890-976d-64a48478d404@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb31b6f-8ed3-e890-976d-64a48478d404@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:57:09PM -0700, Anjelique Melendez wrote:
> 
> 
> On 7/14/2022 4:48 AM, Krzysztof Kozlowski wrote:
> > On 13/07/2022 21:33, Anjelique Melendez wrote:
> >> From: David Collins <quic_collinsd@quicinc.com>
> >>
> >> Update the description of "reg" property to add the PON_PBS base
> >> address along with PON_HLOS base address.  Also add "reg-names"
> >> property description.
> >>
> >> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> >> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> >> ---
> >>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 73 ++++++++++++++++++++++++++++--
> >>  1 file changed, 69 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> >> index 353f155d..562fe308 100644
> >> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> >> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> >> @@ -15,18 +15,26 @@ description: |
> >>  
> >>    This DT node has pwrkey and resin as sub nodes.
> >>  
> >> -allOf:
> >> -  - $ref: reboot-mode.yaml#
> >> -
> >>  properties:
> >>    compatible:
> >>      enum:
> >>        - qcom,pm8916-pon
> >>        - qcom,pms405-pon
> >>        - qcom,pm8998-pon
> >> +      - qcom,pmk8350-pon
> >>  
> >>    reg:
> >> -    maxItems: 1
> >> +    description: |
> >> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
> >> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
> >> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
> >> +      peripherals.  In that case, the PON_PBS address needs to be specified to
> >> +      facilitate software debouncing on some PMIC.
> > 
> > You miss here min and maxItems
> ACK
> > 
> >> +
> >> +  reg-names:
> >> +    description: |
> >> +      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
> >> +      "hlos" and optionally "pbs".
> > 
> > Skip description. You miss here min and maxItems.
> > 
> > See
> > https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57
> > for examples.
> ACK
> > 
> > 
> >>  
> >>    pwrkey:
> >>      type: object
> >> @@ -42,6 +50,63 @@ required:
> >>  
> >>  unevaluatedProperties: false
> >>  
> >> +allOf:
> >> +  - $ref: reboot-mode.yaml#
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: qcom,pm8916-pon
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          maxItems: 1
> >> +        reg-names:
> >> +          items:
> >> +            - const: pon
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: qcom,pms405-pon
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          maxItems: 1
> >> +        reg-names:
> >> +          items:
> >> +            - const: pon
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: qcom,pm8998-pon
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          maxItems: 1
> >> +        reg-names:
> >> +          items:
> >> +            - const: pon
> > 
> > No clue why you made three if statements. This is one if for all three
> > variants.
> > 
> Sorry about that was not sure how to combine the if statements originally.
> Found that you could do:
> 
> - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - qcom,pm8916-pon
>               - qcom,pms405-pon
>               - qcom,pm8998-pon
>     then:
>      ...
> 
> I was wondering if for the "qcom,pmk8350-pon" compatible would you rather
> have the if statement the way it is or have it follow the same pattern as
> above i.e.
> 
> contains:
>   const: qcom,pmk8350-pon
> 
> vs
> 
> contains:
>   enum:
>     - qcom,pmk8350-pon

The former. If only 1 possibility, use 'const'.

Rob
