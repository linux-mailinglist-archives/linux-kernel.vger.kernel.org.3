Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8252752BCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiERNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiERNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:25:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5301BA8ED;
        Wed, 18 May 2022 06:25:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i68so190535qke.11;
        Wed, 18 May 2022 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdtG+Oh5rA118xynE6nPINrtJ9nv4r0UKABUGrkGLPI=;
        b=nYS26kpkZXfBGMHF6KyW6cqwtWJ5gMbM+VtS1jLuEi2BdO/CHkPcjYbF3jgwZxYBAv
         gIc8xm57N1sl9u5IjwbWuOxrFLRhC1nRq8RajcADa5fRtQrsw9SgrOsFSSO9Dhdeyrk7
         pqE81P3TQikJGEnMPQ6CToW6oqF0wF482qrbch63Wx77e9wUmwoeFk4QUi7/zB/eOOQM
         es0P6wMax1HuuBBcSM3II9r+McXiIkSVrxXa4OXYJOdstd02xFOGKdITbSAasss3ncdF
         TuWALsNkrZWBFTdKO+ZQembLF2KWCOF020H6fRTiKS0F6JuYIk/MQDCiz3zna8TdqZG+
         uIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdtG+Oh5rA118xynE6nPINrtJ9nv4r0UKABUGrkGLPI=;
        b=lzwLWPH9lPFpD6zJOuhd+TwiKwyOhCG59LAhHSlWyu82s8sFllTTAFpEiy7I5wjUEp
         h0ixn1Q4fKyYVCipWXDobnCytck0DS6LmoNn6CEIKCNPXpjLUDaN5xY3U4AaHYGU0Kif
         m/mdLe8UZAazOwTl5pdf6p7UrYSvYN0u7DD4AqD9XRvewbhuWSvYH13Ou3hJ2FjbSYCW
         RM8F78FuWxku+H9D+pEUO4Mm9FI0JBsqZtRp5UiGjLNB2Ntnt7fZku38YriH/HLuO/sR
         DYlNr/61e7v23fx+dc+5jMwBqeITTJfiz9SNJNGPDLp7WW9iyFQCMV7M/OUfoyRFc3Uy
         yEHw==
X-Gm-Message-State: AOAM530tQ4WEPNOhYwiGWf1okjPn3QJwPrvbIQTMQu2h1F1pLtQ7kyQm
        E9PuYl2jiV5C1PBZoh2IrKdOkU7X2xb9HlygPwU=
X-Google-Smtp-Source: ABdhPJyhLZWSZhcq2uRhpyaWCutF+RT3RE2uwuCUEUvW0wPBozfJ4+bEpziZ+uU99WBw3k645UCQ9oHw0WnVx48q77I=
X-Received: by 2002:a05:620a:e18:b0:67d:7fcb:6244 with SMTP id
 y24-20020a05620a0e1800b0067d7fcb6244mr19961682qkm.42.1652880319465; Wed, 18
 May 2022 06:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220517205341.536587-1-robimarko@gmail.com> <2905b9ae-df66-eb12-60fd-306ea2d3d626@linaro.org>
In-Reply-To: <2905b9ae-df66-eb12-60fd-306ea2d3d626@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 18 May 2022 15:25:08 +0200
Message-ID: <CAOX2RU4dH-iUMY8yebEEgdJRqm37AHBMH135YkNsnDJMPZCbPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
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

On Wed, 18 May 2022 at 14:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2022 22:53, Robert Marko wrote:
> > Convert the bindings of Qualcomm SPMI regulators to DT schema.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
>
> > +$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SPMI Regulators
> > +
> > +maintainers:
> > +  - Robert Marko <robimarko@gmail.com>
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
> > +  interrupts: true
> > +
> > +  interrupt-names: true
>
> I think we misunderstood each other. Old bindings indeed did not require
> the interrupts, although if present they should be always defined.
> Therefore here you should specify number of items and their names.

Yeah, I think we are misunderstanding each other.

Old text-based bindings specified the interrupts, but no naming or
number was enforced,
so I looked into the driver to see what is going on.
Only pm8941 has interrupts defined in the driver and DTS, so I added
those based on compatible
matching, the same as with supplies.
My logic was that it was only valid for interrupts to be described if
PM8941 was used as describing
interrupts for other regulator models will do nothing.

Regards,
Robert
>
> Rest looks ok
>
>
> Best regards,
> Krzysztof
