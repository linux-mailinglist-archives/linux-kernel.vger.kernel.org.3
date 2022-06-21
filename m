Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB95553AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354136AbiFUTuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiFUTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:50:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44154FD3E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:50:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n197so10973066qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0FNs76I6PYHUD8nUMxoTlXk1ab7LOTanpWTBmJrGzw=;
        b=BKcki+BIePrM6E9kcB3xomBKzV5tKnUzmvpzechBUVFWCMYuykMDQ3l1VN9T5BMDdz
         EcJ3HEb8qj19pDHPJ/c3q9aXP2HLHMF+/VGIqilJWzH4gBk9eNJX1Ln2WsTs1xB30xq/
         b6Pkp4x4MuWckNjrQuwgjrs4lIjovn6/rq+ibcHkjzC2Pc5e3xfCLKKCpwdoZcusft5v
         E/D94vXx9HdXMus92JhKz1oWySsGhrK6sDRhD8WI2qXN8ObRN2WX6nzQypBlMnWit58l
         r4iU2SAsLTXExSSa+ZOY6UJlTupunrkgY0o7iVkpuA+gEfo6hbdjnupl3SoXGsrFAhqP
         16PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0FNs76I6PYHUD8nUMxoTlXk1ab7LOTanpWTBmJrGzw=;
        b=w2X4iw6DJJrAx9c1O0mi4tc+YT9rOcF2ObMHcIzVXON4BX6x0iHUtRjswxyrpfgOrs
         n/jhQk3OVQnwdq/qQOostenqFVgnxQrEDW58ZzKvihN7Qn7mlTU/sYEIOQShHNqYC3cN
         P752ddC4xQYpH6G0T4fv5LtqUQoBV3WSJT9+pjoSmvE8XjvQcK6F4YfVmhEoVBnqRmn1
         2rSDPE5iLj0QAhFf+mXh8yx/YBNuAqVOyC+c9AqaS77ulWboeFhZEXyDVNScNlnl/zAv
         qRrUZx4Rpl6Ai9AJl8Bfa7Z9/efOShkkyN8qliiMheexj1qRva854H45RI6TTCJdcZ8b
         9zZg==
X-Gm-Message-State: AJIora/SJ2PoKupl/6ry6Uy9zu0IS9AfDMTC8LZwqKLENMJVtDZHEYWj
        shVXKzb4gL/3cvUa0ld5bjdFGvXEWzwJkcXBMSiPLA==
X-Google-Smtp-Source: AGRyM1tiOseFNhWcEc6fHGXP4+6oN+ZEaXPVTblnXaxheIcmNpRD9KsU3vJ0aW/ikv9lIC85gHWeHCYu7Oiv6c4CwmA=
X-Received: by 2002:a05:620a:31a0:b0:6a7:549f:a788 with SMTP id
 bi32-20020a05620a31a000b006a7549fa788mr21370863qkb.203.1655841008291; Tue, 21
 Jun 2022 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220621185649.37391-1-krzysztof.kozlowski@linaro.org>
 <20220621185649.37391-2-krzysztof.kozlowski@linaro.org> <609d1f0f-daca-4fde-3315-5d8e171ca5c4@linaro.org>
 <7ef854a5-0e56-c71e-447a-f52cdcf51ef0@linaro.org>
In-Reply-To: <7ef854a5-0e56-c71e-447a-f52cdcf51ef0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 22:49:57 +0300
Message-ID: <CAA8EJpp3HqsPOcz1t9W=cjExuddjEV2MaA10L5mMgcUrmqUmAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 22:32, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/06/2022 21:26, Dmitry Baryshkov wrote:
> > On 21/06/2022 21:56, Krzysztof Kozlowski wrote:
> >> The top level qcom,msm-id and qcom,board-id properties are utilized by
> >> bootloaders on Qualcomm MSM platforms to determine which device tree
> >> should be used and passed to the kernel.
> >>
> >> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> >> compatible format") from 2015 was a consensus during discussion about
> >> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> >> problems with that consensus:
> >> 1. It was reached 7 years ago but it turned out its implementation did
> >>     not reach all possible products.
> >>
> >> 2. Initially additional tool (dtbTool) was needed for parsing these
> >>     fields to create a QCDT image consisting of multiple DTBs, later the
> >>     bootloaders were improved and they use these qcom,msm-id and
> >>     qcom,board-id properties directly.
> >
> > I might be mistaken here. I think it was expected that dtbTool would use
> > board compat strings to generate qcom,msm-id and qcom,board-id
> > properties. It's not that the bootloaders were improved.
>
> Don't ask me, I am new to this.
>
> https://lore.kernel.org/all/02ab0276-b078-fe66-8596-fcec4378722b@somainline.org/




>
> >
> >>
> >> 3. Extracting relevant information from the board compatible requires
> >>     this additional tool (dtbTool), which makes the build process more
> >>     complicated and not easily reproducible (DTBs are modified after the
> >>     kernel build).
> >>
> >> 4. Some versions of Qualcomm bootloaders expect these properties even
> >>     when booting with a single DTB.  The community is stuck with these
> >>     bootloaders thus they require properties in the DTBs.
> >>
> >> Since several upstreamed Qualcomm SoC-based boards require these
> >> properties to properly boot and the properties are reportedly used by
> >> bootloaders, document them.
> >>
> >> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> >> Co-developed-by: Kumar Gala <galak@codeaurora.org>
> >> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   .../devicetree/bindings/arm/qcom.yaml         | 123 ++++++++++++++++++
> >>   include/dt-bindings/arm/qcom,ids.h            |  30 +++++
> >>   2 files changed, 153 insertions(+)
> >>   create mode 100644 include/dt-bindings/arm/qcom,ids.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index 6c38c1387afd..05b98cde4653 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -403,6 +403,129 @@ properties:
> >>                 - qcom,sm8450-qrd
> >>             - const: qcom,sm8450
> >>
> >> +  # Board compatibles go above
> >> +
> >> +  qcom,msm-id:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >> +    minItems: 1
> >> +    maxItems: 8
> >> +    items:
> >> +      items:
> >> +        - description: |
> >> +            MSM chipset ID - an exact match value consisting of three bitfields::
> >
> > two bitfields
>
> Right, thanks.
>
> >
> >> +             - bits 0-15  - The unique MSM chipset ID
> >> +             - bits 16-31 - Reserved; should be 0
> >> +        - description: |
> >> +            Hardware revision ID - a chipset specific 32-bit ID representing
> >> +            the version of the chipset.  It is best a match value - the
> >> +            bootloader will look for the closest possible match.
> >> +    deprecated: true
> >> +    description:
> >> +      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
> >> +      can optionally be an array of these to indicate multiple hardware that
> >> +      use the same device tree.  It is expected that the bootloader will use
> >> +      this information at boot-up to decide which device tree to use when given
> >> +      multiple device trees, some of which may not be compatible with the
> >> +      actual hardware.  It is the bootloader's responsibility to pass the
> >> +      correct device tree to the kernel.
> >> +      The property is deprecated - it is not expected on newer boards
> >> +      (starting with SM8350).
> >
> > Could you please elaborate this?
>
> Second paragraph:
> https://lore.kernel.org/all/20220522195138.35943-1-konrad.dybcio@somainline.org/

I think this is something peculiar to Sony. Public lahaina (sm8350)
dts files contain both these properties:

https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-hdk.dts
https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-v2.1.dtsi

>
> Plus consensus with Rob:
> https://lore.kernel.org/all/CAL_JsqKL-mtAQ8Q9H4vLGM8izVVzDPbUAVWSdS8AmGjN6X6kcA@mail.gmail.com/

I'm not sure here. But sm8350 and sm8450 dtsi files use these
properties. I've linked lahaina files above.
The waiptio dtsi (sm8450) are present at the same URL.

>
> > If the AOSP team were to add e.g.
> > SM8350-HDK to their single RB3+RB5 images, they would still need the
> > qcom,board-id/qcom,msm-id properties to let the bootloader choose proper
> > DTB.
>
> If you have any email addresses in mind, please Cc them to invite in
> discussions. Otherwise I am afraid it won't be allowed. The feedback I
> got before was that SM8350 and newer do not require this property. Feel
> free to propose other way to solve comments (see "consensus with Rob"
> above).

Amit is in CC list. In the past he used these properties to allow
single-image booting of RB3 and RB5.
In fact I might prefer adding more of these properties to the dts
files, where it makes sense, to allow adding more dt files to the
images we create.
I'd really like to be able to boot a single image on all my boards
(rb3, rb5, db410c, db820, ifc6560, etc).

>
> >
> >> +
> >> +  qcom,board-id:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >> +    minItems: 1
> >> +    maxItems: 8
> >> +    items:
> >> +      oneOf:
> >> +        - maxItems: 2
> >> +          items:
> >> +            - description: |
> >> +                Board ID consisting of three bitfields::
> >> +                  - bits 31-24 - Unused
> >> +                  - bits 23-16 - Platform Version Major
> >> +                  - bits 15-8  - Platform Version Minor
> >> +                  - bits 7-0   - Platform Type
> >> +                Platform Type field is an exact match value.  The
> >> +                Platform Major/Minor field is a best match.  The bootloader will
> >> +                look for the closest possible match.
> >> +            - description: |
> >> +                Subtype ID unique to a Platform Type/Chipset ID.  For a given
> >> +                Platform Type, there will typically only be a single board and the
> >> +                subtype_id will be 0.  However in some cases board variants may
> >> +                need to be distinguished by different subtype_id values.
> >> +        # OnePlus uses a variant of board-id with four elements:
> >> +        - minItems: 4
> >> +          items:
> >> +            - const: 8
> >> +            - const: 0
> >> +            - description: OnePlus board ID
> >> +            - description: OnePlus subtype ID
> >> +    deprecated: true
> >> +    description:
> >> +      The board type and revision information.  It can optionally be an array
> >> +      of these to indicate multiple boards that use the same device tree.  It
> >> +      is expected that the bootloader will use this information at boot-up to
> >> +      decide which device tree to use when given multiple device trees, some of
> >> +      which may not be compatible with the actual hardware.  It is the
> >> +      bootloader's responsibility to pass the correct device tree to the
> >> +      kernel
> >> +      The property is deprecated - it is not expected on newer boards
> >> +      (starting with SM8350).
> >> +
> >> +allOf:
> >> +  # Explicit allow-list for older SoCs. The legacy properties are not allowed
> >> +  # on newer SoCs.
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - qcom,apq8026
> >> +              - qcom,apq8094
> >> +              - qcom,apq8096
> >> +              - qcom,msm8992
> >> +              - qcom,msm8994
> >> +              - qcom,msm8996
> >> +              - qcom,msm8998
> >> +              - qcom,sdm630
> >> +              - qcom,sdm632
> >> +              - qcom,sdm845
> >> +              - qcom,sdx55
> >> +              - qcom,sdx65
> >> +              - qcom,sm6125
> >> +              - qcom,sm6350
> >> +              - qcom,sm7225
> >> +              - qcom,sm8150
> >> +              - qcom,sm8250
> >> +    then:
> >> +      properties:
> >> +        qcom,board-id: true
> >> +        qcom,msm-id: true
> >> +    else:
> >> +      properties:
> >> +        qcom,board-id: false
> >> +        qcom,msm-id: false
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - oneplus,cheeseburger
> >> +              - oneplus,dumpling
> >> +              - oneplus,enchilada
> >> +              - oneplus,fajita
> >> +    then:
> >> +      properties:
> >> +        qcom,board-id:
> >> +          items:
> >> +            minItems: 4
> >> +    else:
> >> +      properties:
> >> +        qcom,board-id:
> >> +          items:
> >> +            maxItems: 2
> >> +
> >>   additionalProperties: true
> >>
> >>   ...
> >> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> >> new file mode 100644
> >> index 000000000000..eaf86c18650f
> >> --- /dev/null
> >> +++ b/include/dt-bindings/arm/qcom,ids.h
> >> @@ -0,0 +1,30 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2022 Linaro Ltd
> >> + * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
> >> + */
> >> +#ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
> >> +#define _DT_BINDINGS_ARM_QCOM_IDS_H
> >> +
> >> +/* qcom,msm-id */
> >> +#define QCOM_ID_APQ8026                             199
> >> +#define QCOM_ID_MSM8916                             206
> >> +#define QCOM_ID_MSM8994                             207
> >> +#define QCOM_ID_MSM8996_3_0                 246
> >
> > 2_0 too.
> > And then (according to 3.18):
> > 8996-pro 305
> > 8996-pro-auto 315
> > 8996-auto 310
>
> Sure, I can add these.

Nah, it was just to complete the picture.

I'd just suggest dropping the _3_0 part of the define. Let's add more
ids if one needs them.

>
> >
> >> +#define QCOM_ID_APQ8016                             247
> >> +#define QCOM_ID_MSM8216                             248
> >> +#define QCOM_ID_MSM8116                             249
> >> +#define QCOM_ID_MSM8616                             250
> >> +#define QCOM_ID_MSM8998                             292
> >> +#define QCOM_ID_SDM845                              321
> >
> > sdm845-v2.1-rb3.dts:  qcom,msm-id = <341 0x20001>;
> > But this might be a typo
>
> Yeah, that's an interesting one. I did not fill the list to all possible
> options, rather to some subset of more reasonable sources.

Checked the msm-4.9. sdm845 is 321, sda845 is 341. sdm845-v2.1-rb3 is
341 because it uses the SDA845 SoC.

> >> +
> >> +/* qcom,board-id */
> >> +#define QCOM_BOARD_ID(a, major, minor) \
> >> +    (((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
> >> +
> >> +#define QCOM_BOARD_ID_MTP                   8
> >> +#define QCOM_BOARD_ID_DRAGONBOARD           10
> >> +#define QCOM_BOARD_ID_SBC                   24
> >> +
> >> +#endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */
> >
> >
>
>
> Best regards,
> Krzysztof



-- 
With best wishes
Dmitry
