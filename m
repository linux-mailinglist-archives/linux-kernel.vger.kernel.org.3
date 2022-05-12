Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42783524901
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiELJck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352093AbiELJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:32:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B662133;
        Thu, 12 May 2022 02:32:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a191so4105835pge.2;
        Thu, 12 May 2022 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=flXivKEC2IcpiBFhfrddh1E6vjH9V3TZjevgVn91yi4=;
        b=AN3U3kcHTlxbl51/sP1uJBCTPhiI6nHZw6wqz3ur7ecIYBifrP+OPAj8sktJaG0sbI
         Z2Sn6izC8Um7AKLiUuB71AepwcU/kCOstIN5H8FlT13Bryk7oqT+lcrL3NICkAxo2rlH
         d4gS8tshEKdqHFwVxbYXvol1qD7yxjnxhknP/FMUxMvZvlahjGvMvXHgEn6NpjcSMH2i
         Clq7qnqAXgS+t5qtMQk6fhPr8cAgQKtY5AxvVkrXB5P6hqqteZI/P26qnClW2BhMd+Cr
         cdw84aTRBKLszNAvxJN4Kq97/3prjkwG4vp2hvrOuk/kCe9KdN+9+5yWQP8Hd4iXmFw/
         8Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=flXivKEC2IcpiBFhfrddh1E6vjH9V3TZjevgVn91yi4=;
        b=F3Jl1AwG/VuZIRQrU6UvPjGi26O0cFm/zvJ73ZTF4aeQLEJCQPuVjWktm/SuTb7gKv
         htDyr/bDWswESvBqfemze9hiM6kzQ+PWwIoKqX7WOH1kcZyBaguycAXmC3M/nyxVg6iQ
         Ezb87+aPx8abm4SjKf47Oxu3/uUhR7td+WtFH87fgpfWQdCVxP87ROf+8TJ+c5bIixuD
         P78YNRy8VroIRy57aA70NV9vZNnTF0NcR/VhyHYZq6CLd9gM3Ah2ph0C1T7ZCLKggZ03
         zyucuOJhZlNdf/Hs7/j3OMK32fdcHGyeohWMdMx27ykOIo5s1irtIPGCsVzrqGjnHI3I
         lXeA==
X-Gm-Message-State: AOAM530YFcgZbeywUM/IASpwky3CsRTiAY4MJD+CBhKwzLQ9l35J6lol
        iioHmREe2fH3bveHkhjykpW4oXLU6KyN0K9X
X-Google-Smtp-Source: ABdhPJw/9YkqxrxQzGxTkTCCtpdkg05Mdc6nHzu4qoWSWe2lNP16o8faNIalqgzW/s/O+sqweam6Zg==
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id p2-20020a056a000a0200b004fdf9dd5494mr29453508pfh.68.1652347944324;
        Thu, 12 May 2022 02:32:24 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902a9c100b0015e8d4eb1ebsm3386164plr.53.2022.05.12.02.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:32:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 15:02:17 +0530
Message-Id: <CJXOGJIR1ONQ.2ZT3JQGVWWHFB@skynet-linux>
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
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
 <a62822a4-a771-dfa9-f46d-586fdccedf66@linaro.org>
In-Reply-To: <a62822a4-a771-dfa9-f46d-586fdccedf66@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 12, 2022 at 1:44 PM IST, Krzysztof Kozlowski wrote:
> On 12/05/2022 08:50, Sireesh Kodali wrote:
> > On Wed May 11, 2022 at 10:45 PM IST, Krzysztof Kozlowski wrote:
> >> On 11/05/2022 18:15, Sireesh Kodali wrote:
> >>> Convert the dt-bindings from txt to YAML. This is in preparation for
> >>> including the relevant bindings for the MSM8953 platform's wcnss pil.
> >>>
> >>> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >> Please use existing bindings or example-schema as a starting point. Ha=
lf
> >> of my review could be skipped if you just followed what we already hav=
e
> >> in the tree.
> >>
> >> Some of these qcom specific properties already exist but you decided t=
o
> >> write them differently... please don't, rather reuse the code.
> >>
> >=20
> > Thank you for your review, I will make the chnages as appropriate in v2=
.
> >> (...)
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> >>> +
> >>> +description:
> >>> +  This document defines the binding for a component that loads and b=
oots
> >>> +  firmware on the Qualcomm WCNSS core.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - enum:
> >>> +              - qcom,pronto-v2-pil
> >>> +          - enum:
> >>> +              - qcom,pronto
> >>
> >> This does not look correct. The fallback compatible should not change.
> >> What is more, it was not documented in original binding, so this shoul=
d
> >> be done in separate patch.
> >>
> >=20
> > This was not a change to the fallback compatible.=20
>
> You made it an enum, so you expect it to use different fallback for
> different cases.
>
> > msm8916.dtsi's wcnss
> > node has "qcom,pronto" as the compatible string, which is why this was
> > added. It is however not documented in the txt file. Is it sufficient t=
o
> > add a note in the commit message, or should it be split into a separate
> > commit?
>
> Please split it, assuming that fallback is correct. Maybe the fallback
> is wrong?

The code doesn't recognize "qcom,pronto", so perhaps the best solution
is to just remove that compatible from msm8916.dtsi?
>
> >=20
> >>> +      - items:
> >>
> >> No need for items, it's just one item.
> >>
> >>> +          - enum:
> >>> +              - qcom,riva-pil
> >>> +              - qcom,pronto-v1-pil
> >>> +              - qcom,pronto-v2-pil
> >>> +
> >>> +  reg:
> >>> +    description: must specify the base address and size of the CCU, =
DXE and PMU
> >>> +      register blocks
> >>
> >> New line after "decription:", drop "must specify" and start with capit=
al
> >> letter.
> >>
> >> You need maxItems: 3
> >>
> >=20
> > Will fix in v2
> >>
> >>> +
> >>> +  reg-names:
> >>> +    items:
> >>> +      - const: ccu
> >>> +      - const: dxe
> >>> +      - const: pmu
> >>> +
> >>> +  interrupts-extended:
> >>> +    description:
> >>> +      Interrupt lines
> >>
> >> Skip description, it's obvious.
> >>
> >> It should be only "interrupts", not extended.
> >>
> >>> +    minItems: 2
> >>> +    maxItems: 5
> >>> +
> >>> +  interrupt-names:
> >>> +    minItems: 2
> >>> +    maxItems: 5
> >>
> >> Names should be clearly defined. They were BTW defined in original
> >> bindings, so you should not remove them. This makes me wonder what els=
e
> >> did you remove from original bindings...
> >>
> >> Please document all deviations from pure conversion in the commit msg.
> >> It's a second "hidden" difference.
> >>
> >=20
> > Sorry, this was meant to be a pure txt->YAML conversion. The missing
> > interrupt names was accidental, and will be fixed in v2.
> >>> +
> >>> +  firmware-name:
> >>> +    $ref: /schemas/types.yaml#/definitions/string
> >>> +    description: Relative firmware image path for the WCNSS core. De=
faults to
> >>> +      "wcnss.mdt".
> >>
> >>
> >> Blank line after "description:". This applies to other places as well.
> >>
> >> Remove "Defailts to ..." and just add "default" schema.
> >>
> >=20
> > Will be fixed in v2
> >>> +
> >>> +  vddpx-supply:
> >>> +    description: Reference to the PX regulator to be held on behalf =
of the
> >>> +      booting of the WCNSS core
> >>> +
> >>> +  vddmx-supply:
> >>> +    description: Reference to the MX regulator to be held on behalf =
of the
> >>> +      booting of the WCNSS core.
> >>> +
> >>> +  vddcx-supply:
> >>> +    description: Reference to the CX regulator to be held on behalf =
of the
> >>> +      booting of the WCNSS core.
> >>
> >> s/Reference to the//
> >>
> >>> +
> >>> +  power-domains:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +    description: References to the power domains that need to be hel=
d on
> >>> +      behalf of the booting WCNSS core
> >>
> >> 1. Ditto.
> >> 2. No need for ref
> >> 3. maxItems
> >>
> >>> +
> >>> +  power-domain-names:
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>
> >> No need for ref, skip description.
> >>
> >>> +    description: Names of the power domains
> >>> +    items:
> >>> +      - const: cx
> >>> +      - const: mx
> >>> +
> >>> +  qcom,smem-states:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +    description: States used by the AP to signal the WCNSS core that=
 it should
> >>> +      shutdown
> >>> +    items:
> >>> +      - description: Stop the modem
> >>> +
> >>> +  qcom,smem-state-names:
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>
> >> No need for ref. Really, it does not appear in any of existing binding=
s
> >> for smem-state-names, so how did you get it?
> >>
> >=20
> > The smem nodes were copied from /remoteproc/qcom,sdm845-adsp-pil.yaml
>
> Hm, indeed, you're right. There are few files having here ref. I'll fix
> these.
>
> >=20
> >>> +    description: The names of the state bits used for SMP2P output
> >>> +    items:
> >>> +      - const: stop
> >>> +
> >>> +  memory-region:
> >>> +    maxItems: 1
> >>> +    description: Reference to the reserved-memory for the WCNSS core
> >>> +
> >>> +  smd-edge:
> >>> +    type: object
> >>> +    description:
> >>> +      Qualcomm Shared Memory subnode which represents communication =
edge,
> >>> +      channels and devices related to the ADSP.
> >>
> >> You should reference /schemas/soc/qcom/qcom,smd.yaml
> >=20
> > Will be done in v2
> >>
> >>> +
> >>> +  iris:
> >>
> >> Generic node name... what is "iris"?
> >>
> > Iris is the RF module, I'll make the description better
>
> RF like wifi? Then the property name should be "wifi".

RF like wifi and bluetooth. However there are wifi and bt subnodes in
the smd-edge subnode. Iris is just the antenna hardware if I understand
correctly. Also this is just a documentation of the existing nodes that
are present in msm8916.dtsi, but for whatever reason their documentation
was missing in the txt file. Without adding this node in the YAML
dtb_check fails.

>
>
> Best regards,
> Krzysztof

