Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42E857144C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiGLITt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiGLITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:19:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244AA1247;
        Tue, 12 Jul 2022 01:19:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d12so12655126lfq.12;
        Tue, 12 Jul 2022 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsZS54G0TF7yfO7aK95cWjaqDjAEFLG+zKLdqz5qOj8=;
        b=CPUwdWfRzwbAZFcSL/+Xjt3FqB3hWjH8AYkd4hQjSi3iRLxbnAuxssCAMlVoJeLxXF
         R2rqxjUOMH8oK5mvIgpsFFIckigyPFYdhRmKN7ikguePeF+GqelHrrPuUbGmPlFb0eXK
         Jbxm0I0xcjyCVr9O+cnxT+f9RUKy26jP2K/hnfCFAGh7YLrXQM7JHXwIFVmm0rdpX41B
         OlrLqKNm4H+2V3Mp10n1LO7FN0iVDPDaiXWaQ4FT9F1yjW1K7QvX47SxNMQsihnUY54i
         JeFp01ka7yVdBkFXLbj2Hnfs08y62O63V5PKVJMcdl804+g3nbRXAhwiNxXMmrXiaC1n
         c3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsZS54G0TF7yfO7aK95cWjaqDjAEFLG+zKLdqz5qOj8=;
        b=6BweLTMqSrl2alCcnesB+4MAplom2QL9FvO8PNzdAbnAd9JH+T9Uy1LXG2kP9GvMoO
         0mqD8efQNZBGZq9ruzJtEPP3U0fMz2zU/rZHBF1ntfVHjPQYY5FzJxjY6Xxltw8gMeyz
         MRatt5Si83Hsr/AbcJJADZ4ReWnmvqbwjtspmd70o+hixsI6WwaT5Rj5MApABL1oJiRY
         jTtSmdjo17223tTsihGgTxz0RkhPPQ4N9c+x8CKY2soAMYPaoMZw9sjmgRYeLYhY8dsQ
         aaojQDtNYXc7jrZ3XyHX8taq1Lv5Ps1lrGvdVnJp9bvzBEkhYZdNozdXjRjuby+M5/db
         Nw0w==
X-Gm-Message-State: AJIora9QKBRVzSXVAoUSMJDe/FMVt97VCFh0HNS44gvXHhxXpV3gB4Vp
        Tg5a7klnvACKz8e5PcjgecYL42E+BNU/hjydj+M=
X-Google-Smtp-Source: AGRyM1uwm5voGsujOseVCxcKpWGEQUFJOWHea1M5BQx/JSJlJYHEAMBsAxCGRsQCxXgwON5GZlvbfB6CpmpGIIyW154=
X-Received: by 2002:a05:6512:3103:b0:489:cdd7:b360 with SMTP id
 n3-20020a056512310300b00489cdd7b360mr10578125lfb.111.1657613979260; Tue, 12
 Jul 2022 01:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-2-tmaimon77@gmail.com>
 <154dd9ef-cb8c-d8d7-ae62-a73bac160089@linaro.org>
In-Reply-To: <154dd9ef-cb8c-d8d7-ae62-a73bac160089@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 11:19:27 +0300
Message-ID: <CAP6Zq1gMNeU9Ah5vWmhFyd_=XWhAAOsX2sQ8v1KLF2W+DSH=QQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: npcm: Add npcm845
 compatible string
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 12 Jul 2022 at 11:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 15:43, Tomer Maimon wrote:
> > Add a compatible string for Nuvoton BMC NPCM845 ADC.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml     | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> > index 001cf263b7d5..c9e9c5bf5e5b 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
> > @@ -14,7 +14,10 @@ description:
> >
> >  properties:
> >    compatible:
> > -    const: nuvoton,npcm750-adc
> > +    oneOf:
> > +      - items:
>
> This does not make sense. oneOf with one item. You also create now list
> breaking all existing users/ABI.
>
> You probably wanted an enum here.
indeed, thanks for your comment.
>
> > +          - const: nuvoton,npcm750-adc
> > +          - const: nuvoton,npcm845-adc
> >
> >    reg:
> >      maxItems: 1
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
