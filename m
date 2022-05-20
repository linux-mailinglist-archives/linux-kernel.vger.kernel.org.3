Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62F52EB83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348973AbiETMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiETMEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:04:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92114E2C7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:04:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n10so15213319ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=bnp8Ujwr8MQyroDL1ax6TC+7SRvJNg55sxpIGZD26uk=;
        b=quqvSHxC6rGCpfvIoQTQlfgyzOfCAOVSoJ0/SHj0YgmVnY3uE4NeOILG9RUerUh9x1
         up9AjQNAGGP5YuiCGLuloWLqv4JcA7lPCfTPKXP5mMIHS4ABzOx8NRQDoOgXJ9N3C4KS
         ExoJBIhCY2/ucanpGN3W7T+/vOxR/hYa9ZMa4PKqmD5s0Q9cROgfePxkCfOlMwpyIRbf
         Rx2YzJRITibYjjHh1EF81SRQ05GN1R4/6h+g8DFqKwAOQXIUbbrqvLHRd1tG6CGuBkmT
         BAi6z4wC2J3yIGto12mcGu4uQsK9SuXwiObX5TIaQ98GBBCFk1mfnoyKcUbaVxku51Kl
         4SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=bnp8Ujwr8MQyroDL1ax6TC+7SRvJNg55sxpIGZD26uk=;
        b=t1dlcZdynojGgUUKsyDP7HaZGIb9URmi0HhlxXGkA6CHbBxOO4dDEhdxeDPTqgdXDR
         RjfORP2/W4LI7CaYkZR/m9DkMj5ELDeLMeicCs3SxIT0bUHCMEM/7jyz/D62Qi1xpP6O
         MELm8YPvLbYCIr+olipm2dR3PJeEP/dTQYZEfs5uTHrucsxCZYfNOJmCytz6chGtX5Sz
         T0kbBDU5c+GpeuGZokv1kCl1dtEdUhofsXQ4Clqhl09DrtLaS5SL0abcIwSEj2ZpAdYY
         IizGJAogCD8BDZjP9kjPqDGDZG61cM8oKfFcbihBNed8gQf7rd+i6jeBhfo2FdWAKUEl
         bM6g==
X-Gm-Message-State: AOAM533MbfD+qDmg6fIdXaRhXOsYuGmA8y0Q/3eqWfuPEvr3EUBCmZpL
        ZHJq8m5Mwk1h8NtElWEr5IEDug==
X-Google-Smtp-Source: ABdhPJxz6xN6SrDKQFNsARBd2ZX6IwHX3udFQjhKbdEnaeG29Octc2v/NTMAWOIO2IC97iIEFmAA7g==
X-Received: by 2002:a17:907:1c20:b0:6f4:639e:9400 with SMTP id nc32-20020a1709071c2000b006f4639e9400mr8479969ejc.485.1653048269844;
        Fri, 20 May 2022 05:04:29 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id d13-20020a05640208cd00b0042617ba639esm4214058edz.40.2022.05.20.05.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:04:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 May 2022 14:04:28 +0200
Message-Id: <CK4KPEWM9165.2LR9ZUG2GGK6Q@otso>
Subject: Re: [PATCH v2 2/5] dt-bindings: interconnect: Add Qualcomm SM6350
 NoC support
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Georgi Djakov" <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Odelu Kukatla" <okukatla@codeaurora.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-3-luca.weiss@fairphone.com>
 <7b451dfb-8353-4a4e-1834-a01feaa267d2@linaro.org>
In-Reply-To: <7b451dfb-8353-4a4e-1834-a01feaa267d2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review!

On Fri May 20, 2022 at 12:31 PM CEST, Krzysztof Kozlowski wrote:
> On 20/05/2022 09:03, Luca Weiss wrote:
> > Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.
> >=20
> > As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
> > binding documentation, as was done for qcm2290.
> >=20
> > Because the main qcom,rpmh.yaml file is getting too complicated for our
> > use cases, create a new qcom,rpmh-common.yaml and a separate
> > qcom,sm6350-rpmh.yaml that defines our new bindings.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes since v1:
> > * Split sm6350 into separate yaml with new rpmh-common.yaml
> >=20
> >  .../interconnect/qcom,rpmh-common.yaml        |  41 +++++
> >  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
> >  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
> >  3 files changed, 271 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom=
,rpmh-common.yaml
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom=
,sm6350-rpmh.yaml
> >  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-c=
ommon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-commo=
n.yaml
> > new file mode 100644
> > index 000000000000..6121eea3e87d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.y=
aml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm RPMh Network-On-Chip Interconnect
> > +
> > +maintainers:
> > +  - Georgi Djakov <georgi.djakov@linaro.org>
> > +  - Odelu Kukatla <okukatla@codeaurora.org>
>
> Is this valid email address?

Will put Georgi and Bjorn as maintainers, as per your other email.

>
> > +
> > +description: |
> > +   RPMh interconnect providers support system bandwidth requirements t=
hrough
> > +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The pr=
ovider is
> > +   able to communicate with the BCM through the Resource State Coordin=
ator (RSC)
> > +   associated with each execution environment. Provider nodes must poi=
nt to at
> > +   least one RPMh device child node pertaining to their RSC and each p=
rovider
> > +   can map to multiple RPMh resources.
> > +
> > +properties:
> > +  '#interconnect-cells':
> > +    enum: [ 1, 2 ]
>
> Why this is an enum?

As a start, just adding that the definitions are copied from
qcom,rpmh.yaml so it's not my invention :) Of course that doesn't mean
that it should be improved where possible!

Either value is supported by the driver (and used upstream). But perhaps
it can use a description to define what the 'parameters' mean.

The second (optional) parameters "is to support different bandwidth
configurations that are toggled by RPMh, depending on the power state of
the CPU."[0]

A commit message for sc7180 calls it the "tag information" and "The
consumers can specify the path tag as an additional argument to the
endpoints."[1]

Not sure how to properly describe the first property, I guess the
interconnect endpoint? Maybe Georgi can help here.


[0] https://lore.kernel.org/linux-arm-msm/b079a211-d387-7958-bbe2-c41cac00d=
269@kernel.org/
[1] https://git.kernel.org/torvalds/c/e23b122

>
> > +
> > +  qcom,bcm-voters:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
>
> Please implement my previous comments.

Sorry, I looked over the comment in v1.

As far as I can tell in current code only 1 item is used.

If the second parameter of_bcm_voter_get would be used as non-NULL then
qcom,bcm-voter-names gets looked up and the N-th value in qcom,bcm-voters
used. But currently qcom,bcm-voter-names is not actively used so only
one gets used.

Do you have a recommendation what to put here? A synthetic limit like
32 just to have a number there?

>
> > +      maxItems: 1
> > +    description: |
>
> No need for |

ack

>
> > +      List of phandles to qcom,bcm-voter nodes that are required by
> > +      this interconnect to send RPMh commands.
> > +
> > +  qcom,bcm-voter-names:
>
> What names do you expect here?

Currently unused in mainline but newer downstream kernels[2] use "hlos"
as first parameter, and e.g. "disp" as second one that goes to a
qcom,bcm-voter that's a child of disp_rsc. Not sure exactly what that
does.

[2] https://github.com/atomsand/android_kernel_qcom_devicetree/blob/a6d5081=
0116e8314d64eb63b8862c207b974e0c7/qcom/waipio.dtsi#L1701-L1793

>
> > +    description: |
>
> Ditto.

ack

>
> > +      Names for each of the qcom,bcm-voters specified.
> > +
> > +required:
> > +  - '#interconnect-cells'
> > +  - qcom,bcm-voters
> > +
> > +additionalProperties: true
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6350=
-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpm=
h.yaml
> > new file mode 100644
> > index 000000000000..89fe17c31b8f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.y=
aml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interconnect/qcom,sm6350-rpmh.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SM6350 RPMh Network-On-Chip Interconnect
> > +
> > +maintainers:
> > +  - Luca Weiss <luca.weiss@fairphone.com>
> > +
> > +description: |
> > +  Qualcomm RPMh-based interconnect provider on SM6350.
> > +
> > +allOf:
> > +  - $ref: qcom,rpmh-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sm6350-aggre1-noc
> > +      - qcom,sm6350-aggre2-noc
> > +      - qcom,sm6350-config-noc
> > +      - qcom,sm6350-dc-noc
> > +      - qcom,sm6350-gem-noc
> > +      - qcom,sm6350-mmss-noc
> > +      - qcom,sm6350-npu-noc
> > +      - qcom,sm6350-system-noc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#interconnect-cells': true
>
> Since you defined it as enum in rpmh-common, you really expect here
> different values?

Doesn't ": true" here just mean we want the value from the allOf: -
$ref?
But we could in theory make interconnect-cells only accept <2> for
sm6350.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +patternProperties:
>
> This goes after "properties".

So above required & unevaluatedProperties? Will update.

Regards
Luca

>
> > +  '^interconnect-[a-z0-9\-]+$':
> > +    type: object
> > +    description:
> > +      The interconnect providers do not have a separate QoS register s=
pace,
> > +      but share parent's space.
> > +    $ref: qcom,rpmh-common.yaml#
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - qcom,sm6350-clk-virt
> > +          - qcom,sm6350-compute-noc
> > +
> > +      '#interconnect-cells': true
>
> Same problem.
>
> > +
> > +    required:
> > +      - compatible
> > +
> > +    unevaluatedProperties: false
> > +
>
>
> Best regards,
> Krzysztof

