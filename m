Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226A25312BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiEWOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiEWOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:32:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470052E9D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:32:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f9so29311742ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=mlEN37RGVVHIHvr+/hBakjwM1KtuFOZ5STJWC6VPCe4=;
        b=Rcj4RHh43jilygk/Vks3FrXhRojthZEyi5e2TNhpmMYxd9vZI96vQ9WaZOyTTw7Am8
         FpK6yZOa40KBLEsOTHiassJOaUUZVs2jXPuV2dIKLl46bdK6lwUOmR+f/8pBfm0FRS2+
         cS3bssbbTMu/a/92yFs9/Ou3qcRZoCM4wwu5uJxOZGQr7TM40i9HEB/tPD4WMx/DPYTA
         +NPXoSYnVdLSPjy4fM8ZRZfsCXoIvuDJ/GflHI7aDqnd2mC8nh6SHaY9XuhX3CmLGil3
         W59GLADwbzpdcsyiqZ/MGGQX0R7/nzkCtn7NwXaRe97p54CU2epvXC50b9mzLvUEH/CJ
         HS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=mlEN37RGVVHIHvr+/hBakjwM1KtuFOZ5STJWC6VPCe4=;
        b=S1jUJhGB3Rrpf9lVAidYQXWp5i1/y/5lP3C6fUQZOvzQv4Ql/vG8DVfW479FWRtanS
         +L0jJX8dKM1lvR12i5Txpo5BBKLG7itncFJN2M7wEwCEobw7mSzlbw3/yML61cyBrCn3
         r5VzuYif+SrqTJrMPmG6lF5OnJLVEUI8qLu9zdC+i5i2drdS/BYxeh0iYpT5dQygggoq
         /rXzYY1gqNBTicKID21wbKeD8LW+m7gT0Sgz6viPF7Xpcrq1WhyA71jZkKB54GIf4+e6
         tls+IZLJOgyw4twuCpSyAmQfc1HPBkS1WkJDvBHL+kSmE4pKasj5FoxEdv5JWS2xxLdx
         2uxg==
X-Gm-Message-State: AOAM5334ISDNaN0j34c1LxqZKXHVsNfQUwcwwlbnYcUAJvX2tM8/5bXW
        XAvHnaFadQ4PQxEplJrj4skW8NpteBEr/g==
X-Google-Smtp-Source: ABdhPJyusWKZbqf11Faic6AnpiRE4C9fByFH9k2mbyP2EBgTg9fTPLO26mlUksfmbTdWrZopA5QUqg==
X-Received: by 2002:a17:907:1612:b0:6fe:d943:312f with SMTP id hb18-20020a170907161200b006fed943312fmr5489472ejc.263.1653316355711;
        Mon, 23 May 2022 07:32:35 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709060a8700b006fec3b2e4f3sm2334343ejf.205.2022.05.23.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:32:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 May 2022 16:32:34 +0200
Message-Id: <CK77QG2WNJ7B.EIXG4S6SVQ2D@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Georgi Djakov" <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Odelu Kukatla" <okukatla@codeaurora.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: interconnect: Add Qualcomm SM6350
 NoC support
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-3-luca.weiss@fairphone.com>
 <7b451dfb-8353-4a4e-1834-a01feaa267d2@linaro.org>
 <CK4KPEWM9165.2LR9ZUG2GGK6Q@otso>
 <b9487ffe-7ed5-077c-3c2c-886746457365@linaro.org>
In-Reply-To: <b9487ffe-7ed5-077c-3c2c-886746457365@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri May 20, 2022 at 4:24 PM CEST, Krzysztof Kozlowski wrote:
> On 20/05/2022 14:04, Luca Weiss wrote:
> > Hi Krzysztof,
> >=20
> > Thanks for the review!
> >=20
> > On Fri May 20, 2022 at 12:31 PM CEST, Krzysztof Kozlowski wrote:
> >> On 20/05/2022 09:03, Luca Weiss wrote:
> >>> Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices=
.
> >>>
> >>> As SM6350 has two pairs of NoCs sharing the same reg, allow this in t=
he
> >>> binding documentation, as was done for qcm2290.
> >>>
> >>> Because the main qcom,rpmh.yaml file is getting too complicated for o=
ur
> >>> use cases, create a new qcom,rpmh-common.yaml and a separate
> >>> qcom,sm6350-rpmh.yaml that defines our new bindings.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>> Changes since v1:
> >>> * Split sm6350 into separate yaml with new rpmh-common.yaml
> >>>
> >>>  .../interconnect/qcom,rpmh-common.yaml        |  41 +++++
> >>>  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
> >>>  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++=
++
> >>>  3 files changed, 271 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qc=
om,rpmh-common.yaml
> >>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qc=
om,sm6350-rpmh.yaml
> >>>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh=
-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-com=
mon.yaml
> >>> new file mode 100644
> >>> index 000000000000..6121eea3e87d
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common=
.yaml
> >>> @@ -0,0 +1,41 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yam=
l#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Qualcomm RPMh Network-On-Chip Interconnect
> >>> +
> >>> +maintainers:
> >>> +  - Georgi Djakov <georgi.djakov@linaro.org>
> >>> +  - Odelu Kukatla <okukatla@codeaurora.org>
> >>
> >> Is this valid email address?
> >=20
> > Will put Georgi and Bjorn as maintainers, as per your other email.
> >=20
> >>
> >>> +
> >>> +description: |
> >>> +   RPMh interconnect providers support system bandwidth requirements=
 through
> >>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The =
provider is
> >>> +   able to communicate with the BCM through the Resource State Coord=
inator (RSC)
> >>> +   associated with each execution environment. Provider nodes must p=
oint to at
> >>> +   least one RPMh device child node pertaining to their RSC and each=
 provider
> >>> +   can map to multiple RPMh resources.
> >>> +
> >>> +properties:
> >>> +  '#interconnect-cells':
> >>> +    enum: [ 1, 2 ]
> >>
> >> Why this is an enum?
> >=20
> > As a start, just adding that the definitions are copied from
> > qcom,rpmh.yaml so it's not my invention :) Of course that doesn't mean
> > that it should be improved where possible!
> >=20
> > Either value is supported by the driver (and used upstream). But perhap=
s
> > it can use a description to define what the 'parameters' mean.
> >=20
> > The second (optional) parameters "is to support different bandwidth
> > configurations that are toggled by RPMh, depending on the power state o=
f
> > the CPU."[0]
> >=20
> > A commit message for sc7180 calls it the "tag information" and "The
> > consumers can specify the path tag as an additional argument to the
> > endpoints."[1]
> >=20
> > Not sure how to properly describe the first property, I guess the
> > interconnect endpoint? Maybe Georgi can help here.
> >=20
> >=20
> > [0] https://lore.kernel.org/linux-arm-msm/b079a211-d387-7958-bbe2-c41ca=
c00d269@kernel.org/
> > [1] https://git.kernel.org/torvalds/c/e23b122
>
> Hm, indeed driver supports variable values. It's fine then.
>
> >=20
> >>
> >>> +
> >>> +  qcom,bcm-voters:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +    items:
> >>
> >> Please implement my previous comments.
> >=20
> > Sorry, I looked over the comment in v1.
> >=20
> > As far as I can tell in current code only 1 item is used.
> >=20
> > If the second parameter of_bcm_voter_get would be used as non-NULL then
> > qcom,bcm-voter-names gets looked up and the N-th value in qcom,bcm-vote=
rs
> > used. But currently qcom,bcm-voter-names is not actively used so only
> > one gets used.
> >=20
> > Do you have a recommendation what to put here? A synthetic limit like
> > 32 just to have a number there?
>
> Let's go with maxItems:1, for both fields.

Do you mean adjusting the example using:

  qcom,bcm-voter-names =3D "apps", "disp";
  qcom,bcm-voters =3D <&apps_bcm_voter>, <&disp_bcm_voter>;

in qcom,rpmh.yaml then? Otherwise validation fails with maxItems: 1

>
> >=20
> >>
> >>> +      maxItems: 1
> >>> +    description: |
> >>
> >> No need for |
> >=20
> > ack
> >=20
> >>
> >>> +      List of phandles to qcom,bcm-voter nodes that are required by
> >>> +      this interconnect to send RPMh commands.
> >>> +
> >>> +  qcom,bcm-voter-names:
> >>
> >> What names do you expect here?
> >=20
> > Currently unused in mainline but newer downstream kernels[2] use "hlos"
> > as first parameter, and e.g. "disp" as second one that goes to a
> > qcom,bcm-voter that's a child of disp_rsc. Not sure exactly what that
> > does.
> >=20
> > [2] https://github.com/atomsand/android_kernel_qcom_devicetree/blob/a6d=
50810116e8314d64eb63b8862c207b974e0c7/qcom/waipio.dtsi#L1701-L1793
>
> The bindings example uses apps and disp, so here would be only "apps".

Here also the above, allow only "apps" for now in the binding and remove
"disp" from example?

Regards
Luca

>
> >>> +
> >>> +  '#interconnect-cells': true
> >>
> >> Since you defined it as enum in rpmh-common, you really expect here
> >> different values?
> >=20
> > Doesn't ": true" here just mean we want the value from the allOf: -
> > $ref?
> > But we could in theory make interconnect-cells only accept <2> for
> > sm6350.
>
> Yes, and the $ref defines it as [1, 2], so initially I thought this
> should be narrowed. However it seems 1 or 2 are still valid for all of
> Qcom interconnects, so your "true" is correct.
>
>
> Best regards,
> Krzysztof

