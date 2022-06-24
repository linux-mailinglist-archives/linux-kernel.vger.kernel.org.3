Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C15595D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiFXIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiFXIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:51:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE4792B3;
        Fri, 24 Jun 2022 01:51:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id n15so3596209qvh.12;
        Fri, 24 Jun 2022 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOkJMguCySKiYgS3jaAKrTeCcltfp+Ak4u2IsO3Ufzc=;
        b=OS9y9gyqqlzBUxmT5C5qu5Bzoov0SFyiZghT1n2aZ6NXxe47VHQ2fxNtwNcSSNMSZc
         TLujETxvVIzU7ZaBySBQKfS2B3GmzGsJpW+Z/sx4QadJF5AwweatiW25cA3VyBl1kw4f
         zNMjb8JP1KkoOOfGDi+DB+JbPmAsmUF0R5Cg4eJMCW8YAAbZeXrYNGyTbemUqRJaAAFR
         B4D5wo0c2JB38NP4yV7DgMhzIXzGj3A0YM3utDucRIkmA41mENTxYzywcYEfuIi3CwKS
         uFKzXfk35U42oPGU4YEOm7oi/UkPjeMRqkd7aaof02RHFSuDe0GGxkrSWBYWdvd+9VaU
         83Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOkJMguCySKiYgS3jaAKrTeCcltfp+Ak4u2IsO3Ufzc=;
        b=tS3v0/k+bOIyt2aTinm1L4dITVjEQHa2mHXV8s11+T2EenNTNsiyLfJJwm9/U6HrtL
         UTH6ZRoZ/GQPTddG1QEVz18TcZOVOQLjQfUU78GxpboLB8dsgfOnGNScwQABtJPXTft4
         RDb4vq/f30JR4Cn2ut1vi1txC3/etekoiFFnv+Njj1QxNSh+V0uKjVAgOU9KvuGcL/uT
         NW+TrfKhilMJOiREUqnUL4Lahud8UdTG1ZY2sSYddqp1FaEGK++F2Tzk/Ju5U2AggR2g
         etdqbDGvUI7BJp6Qi1h6U25GZT+ACLHlM+1H+ywm3jrRTgY2W3YThaaFkgsl8KvvyCKL
         nTIg==
X-Gm-Message-State: AJIora+HzIpDg+UCgqdD3hInz8ffIGPyr2R3y85VxN4FSdZeGS+QeBia
        qt4k3BvbeDyAuYHPjeUBCTHRIca4H4zLgEcAhSY=
X-Google-Smtp-Source: AGRyM1uiyXBd99GGaJBVR8C85XZmoBzCNHgrHQ/Wwsu4HOvyYcJpTRur+mwswijaZ+WAJ/rBF4BpXrIwIkgbPjNMzeg=
X-Received: by 2002:a05:6214:2129:b0:470:396d:19c4 with SMTP id
 r9-20020a056214212900b00470396d19c4mr24485321qvc.34.1656060667403; Fri, 24
 Jun 2022 01:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220623182542.1116677-1-robimarko@gmail.com> <20220624010103.GA23758@quicinc.com>
In-Reply-To: <20220624010103.GA23758@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 24 Jun 2022 10:50:56 +0200
Message-ID: <CAOX2RU7yKuV4i_9YRs9fx2DTTvAndWFFw3cYtQ3qFk9m1zZJVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, 24 Jun 2022 at 03:01, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
>
> On Thu, Jun 23, 2022 at 08:25:42PM +0200, Robert Marko wrote:
> > Convert bindings for Qualcomm SCM to dtschema.
> >
> > SoC compatibles that were used, but not documented were added.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  .../devicetree/bindings/firmware/qcom,scm.txt |  57 --------
> >  .../bindings/firmware/qcom,scm.yaml           | 124 ++++++++++++++++++
> >  2 files changed, 124 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
> >  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> > deleted file mode 100644
> > index 0f4e5ab26477..000000000000
> > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -QCOM Secure Channel Manager (SCM)
> > -
> > -Qualcomm processors include an interface to communicate to the secure firmware.
> > -This interface allows for clients to request different types of actions.  These
> > -can include CPU power up/down, HDCP requests, loading of firmware, and other
> > -assorted actions.
> > -
> > -Required properties:
> > -- compatible: must contain one of the following:
> > - * "qcom,scm-apq8064"
> > - * "qcom,scm-apq8084"
> > - * "qcom,scm-ipq4019"
> > - * "qcom,scm-ipq806x"
> > - * "qcom,scm-ipq8074"
> > - * "qcom,scm-mdm9607"
> > - * "qcom,scm-msm8226"
> > - * "qcom,scm-msm8660"
> > - * "qcom,scm-msm8916"
> > - * "qcom,scm-msm8953"
> > - * "qcom,scm-msm8960"
> > - * "qcom,scm-msm8974"
> > - * "qcom,scm-msm8976"
> > - * "qcom,scm-msm8994"
> > - * "qcom,scm-msm8996"
> > - * "qcom,scm-msm8998"
> > - * "qcom,scm-sc7180"
> > - * "qcom,scm-sc7280"
> > - * "qcom,scm-sdm845"
> > - * "qcom,scm-sdx55"
> > - * "qcom,scm-sm6350"
> > - * "qcom,scm-sm8150"
> > - * "qcom,scm-sm8250"
> > - * "qcom,scm-sm8350"
> > - * "qcom,scm-sm8450"
> > - and:
> > - * "qcom,scm"
> > -- clocks: Specifies clocks needed by the SCM interface, if any:
> > - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
> > -   "qcom,scm-msm8960"
> > - * core, iface and bus clocks required for "qcom,scm-apq8084",
> > -   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
> > -- clock-names: Must contain "core" for the core clock, "iface" for the interface
> > -  clock and "bus" for the bus clock per the requirements of the compatible.
> > -- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> > -                download mode control register (optional)
> > -
> > -Example for MSM8916:
> > -
> > -     firmware {
> > -             scm {
> > -                     compatible = "qcom,msm8916", "qcom,scm";
> > -                     clocks = <&gcc GCC_CRYPTO_CLK> ,
> > -                              <&gcc GCC_CRYPTO_AXI_CLK>,
> > -                              <&gcc GCC_CRYPTO_AHB_CLK>;
> > -                     clock-names = "core", "bus", "iface";
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > new file mode 100644
> > index 000000000000..7dd7beb39846
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > @@ -0,0 +1,124 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/qcom,scm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QCOM Secure Channel Manager (SCM) bindings
> > +
> > +maintainers:
> > +  - Robert Marko <robimarko@gmail.com>
>
> I'd like to volunteer my name as well, if that's okay:
>
> Guru Das Srinagesh <quic_gurus@quicinc.com>

Hi,
Sure, will add you to v2.

>
> > +
> > +description: |
> ...
> > +
> > +  '#reset-cells':
> > +    const: 1
>
> This isn't part of the original file - could you please explain why this is
> being added?

Yes, its not part of the original file, however I noticed that a lot of SCM
nodes were adding #reset-cells, and upon looking at the SCM code its
clear that it is being registered as a reset controller so #reset-cells are
appropriate.

However, since its not really being used via phandles #reset-cells did
not really matter, hence why I did not add them to be required,
this is something that DT guys can probably clarify.

Regards,
Robert
>
> > +
> > +  qcom,dload-mode:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Phandle to the TCSR hardware block and offset of the download mode control register
> > +
> > +required:
> > +  - compatible
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,scm-apq8064
> > +              - qcom,scm-msm8660
> > +              - qcom,scm-msm8960
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SCM core clock
> > +        clock-names:
> > +          items:
> > +            - const: core
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,scm-apq8084
> > +              - qcom,scm-mdm9607
> > +              - qcom,scm-msm8916
> > +              - qcom,scm-msm8953
> > +              - qcom,scm-msm8974
> > +              - qcom,scm-msm8976
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SCM core clock
> > +            - description: SCM bus clock
> > +            - description: SCM interface clock
> > +        clock-names:
> > +          items:
> > +            - const: core
> > +            - const: bus
> > +            - const: iface
>
> Thanks, I had this YAML conversion patch done locally, but couldn't figure out
> how to represent the above logic in YAML. Thank you for this patch.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> > +    firmware {
> > +      scm {
> > +        compatible = "qcom,scm-msm8916", "qcom,scm";
> > +
> > +        clocks = <&gcc GCC_CRYPTO_CLK>,
> > +                 <&gcc GCC_CRYPTO_AXI_CLK>,
> > +                 <&gcc GCC_CRYPTO_AHB_CLK>;
> > +        clock-names = "core", "bus", "iface";
> > +        qcom,dload-mode = <&tcsr 0x6100>;
> > +      };
> > +    };
> > --
> > 2.36.1
> >
