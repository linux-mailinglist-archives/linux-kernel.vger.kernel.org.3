Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37152EB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiETLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiETLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:42:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6FEC3CC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:42:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so15084711ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=wS/ZZ/XGdYJivGUIc7glIv8A/QnED+cfdPx1Mf0OR3o=;
        b=GB72r8xYURZ6bzQkm22Tu7tonI4ZKXJGQRhTtyxiRTudpMondZELrlYY1Xhwk/RTh7
         5Zeda7d68kYmu4UCNIN7fS1lTpbwBNmqbf4icxZKokgVZAw3IURsvL0hYvjRsQQt94SW
         8g3F5Vr/0cKVHhCmBXZcWzC0wiq7c3V0JSaC3VnVhKiPnqLTbIVVrxOldU6Csho//iAb
         i+1fml2hr9pQ0FUoqm5dGGC4coiMNgTvLt6e50kn9jusRG5SCBeCbTcL00riYCnnhFaf
         YFkN3NQQ4g90z5x59jFrDWx4eRldBx1pjejiDJWfm3XVu8iRY29x1FFUUaukXe6wZQ0h
         /hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=wS/ZZ/XGdYJivGUIc7glIv8A/QnED+cfdPx1Mf0OR3o=;
        b=4OFRE0tQbpalPXfa0uvuG5Zo+3kkEXfM5899UfXKCLQHWVqqVXj2WayIk04EzwecGs
         SkHv0Qjb8pWDSOWot8XYL2iESoWJs/0YdOIEm0MZitYuEwKYO6SYM05MBgHET7EcZKZr
         bi1+9SsuozQxE6mUxSToILJ3tq19W2RRN/eW9ow+djqJLFJKWJeamPjByARwHDnR+xke
         fSSYFSL1LCYKfZL5ih0u1JeYrUpU2eGwbA8EPfye0oYEfNS2ykqRGIpKks+CfjAOv8N1
         d0JwQYtGA/tvjtH3XboCK7l1N91yq+a/Tsvaz5kvI05Vpfi2zMEl7hUrCMnYpx7s/Xkw
         HVMA==
X-Gm-Message-State: AOAM532EOf35azHxL6umGlfE1EtnS13x2B+Mx/o5pFog4Kk07uuukg0i
        N3SM2kH+wq7mSwUZl2zsS7TngQ==
X-Google-Smtp-Source: ABdhPJy7fnm73XK7inxXakUomDMt4LomtggIToBNbNojpFIo5Eg5Y2uqDhzYDPx7fPeRzTTy50Yt/g==
X-Received: by 2002:a17:906:7b82:b0:6f3:ee8d:b959 with SMTP id s2-20020a1709067b8200b006f3ee8db959mr8591524ejo.458.1653046929316;
        Fri, 20 May 2022 04:42:09 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id w6-20020a170907270600b006f3ef214dedsm3036390ejk.83.2022.05.20.04.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 04:42:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 May 2022 13:42:08 +0200
Message-Id: <CK4K8B8KQICX.LX0G6HW66RNU@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Georgi Djakov" <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Odelu Kukatla" <okukatla@codeaurora.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: interconnect: qcom: Reuse new
 rpmh-common bindings
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-4-luca.weiss@fairphone.com>
 <d1072c55-9e1c-83df-0184-7405448bbade@linaro.org>
In-Reply-To: <d1072c55-9e1c-83df-0184-7405448bbade@linaro.org>
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

On Fri May 20, 2022 at 12:33 PM CEST, Krzysztof Kozlowski wrote:
> On 20/05/2022 09:03, Luca Weiss wrote:
> > Stop defining the properties twice and use the ones provided in the new
> > qcom,rpmh-common.yaml.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes since v1:
> > * New patch
> >=20
> >  .../bindings/interconnect/qcom,rpmh.yaml      | 22 +++++--------------
> >  1 file changed, 5 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.y=
aml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > index fae3363fed02..e822dc099339 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > @@ -18,6 +18,9 @@ description: |
> >     least one RPMh device child node pertaining to their RSC and each p=
rovider
> >     can map to multiple RPMh resources.
> > =20
> > +allOf:
> > +  - $ref: qcom,rpmh-common.yaml#
> > +
> >  properties:
> >    reg:
> >      maxItems: 1
> > @@ -131,28 +134,13 @@ properties:
> >        - qcom,sm8450-pcie-anoc
> >        - qcom,sm8450-system-noc
> > =20
> > -  '#interconnect-cells':
> > -    enum: [ 1, 2 ]
> > -
> > -  qcom,bcm-voters:
> > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > -    items:
> > -      maxItems: 1
> > -    description: |
> > -      List of phandles to qcom,bcm-voter nodes that are required by
> > -      this interconnect to send RPMh commands.
> > -
> > -  qcom,bcm-voter-names:
> > -    description: |
> > -      Names for each of the qcom,bcm-voters specified.
> > +  '#interconnect-cells': true
> > =20
>
> So this explains why your previous patch had such values... The order is
> messed up - first you move common parts to common file, then you add
> SM6350 support.

Right, that makes much more sense. Will split out qcom,rpmh-common first
and use in rpmh.yaml and then afterwards introduce sm6350.

Regards
Luca

>
>
> Best regards,
> Krzysztof

