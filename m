Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885D52BC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiEROAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiEROAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:00:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7541B184A;
        Wed, 18 May 2022 07:00:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h3so1660442qtn.4;
        Wed, 18 May 2022 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzOS+GlQNt2K4QiqlD0wmcPgVEFauW0EWl1uwO2WAzo=;
        b=izpDwXjEmWbNrmbdx7spk/mq3rK/P72H5Acyamh8wltb1mz19T5rG6WQK2032v8IRE
         a75fotZLaUVHeBngtTEUUZa9J0fTi+MUrnonWxqyb3qaQXQyrxX5gV93fB569YS2rvSz
         CIHVoxEiRSbUdtEOlW8IGtZe7cfml4AhRlJO7gB5SIb9MKk0ZDh2MH78/K+EHQRtaVBD
         dWM65/VE++xHH3BCeJ3ob2sXN2vciITB4AnTnP26aZQaX27IP9vcAI4+18ve44RXeuBU
         tcM8qDQc3oO183uhaavsAoMDBqCMwWY6JygIAlmqTT+X8wANX/W7LsQcO7LLPUPdlesH
         tPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzOS+GlQNt2K4QiqlD0wmcPgVEFauW0EWl1uwO2WAzo=;
        b=Vb30fwb5IgEnOsmvMTTMe4CfUzEBjt/lmqTTR2bkRW+kJ8qFLegaHXCt3emNJfsz88
         2qwo/rncw2WmirVDrlPvMNdHF4NyMdGZ0mX4s2lffWSR/nA9/QxPcAeXbhYP9EJgmTI/
         d6yJGRkzI4v5QHM5nXaFWVvS8aRLG0Osh42kwUq+2nxrxnAV5EO1RGwo3APbT5r82jDd
         8EASXA5Y+7xBCJTP106ThQzJjzgUgcsgdaQPAE3Ac7DbIO2+96vVLxZSF85/pF5i7njL
         j/vDpn1LWAgHM+iSbqQI5vVG+tmQX0bEvIyVHTh094oZi0etF2XF4wgj/RdB0la+spsK
         3kag==
X-Gm-Message-State: AOAM531Fj6AVrrQ6wAl/HGehV3LTO3JjMsUK//d4dF+JWdESmomWUGl7
        seC7lomcgbcFmuWFfjLnsLm5+UuxIKV8sdDk/GTYKiNLbtg=
X-Google-Smtp-Source: ABdhPJyvdr7g5GFNdj+2jig0J6P9vWfdywsKI8871NPXUvkpwLUHgmozsZ5LLrXAoArPgj1OISaIUzfKxV6VunJRLo4=
X-Received: by 2002:a05:622a:606:b0:2f3:da55:bd1b with SMTP id
 z6-20020a05622a060600b002f3da55bd1bmr24606901qta.546.1652882411268; Wed, 18
 May 2022 07:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220517205341.536587-1-robimarko@gmail.com> <2905b9ae-df66-eb12-60fd-306ea2d3d626@linaro.org>
 <CAOX2RU4dH-iUMY8yebEEgdJRqm37AHBMH135YkNsnDJMPZCbPg@mail.gmail.com> <bc13e57f-9701-80c9-8c7a-e491fbcfd181@linaro.org>
In-Reply-To: <bc13e57f-9701-80c9-8c7a-e491fbcfd181@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 18 May 2022 16:00:00 +0200
Message-ID: <CAOX2RU6sW5x-Ufbgz5pxWRnOMj=jrTXqHuba5USKgBnfc+KeJA@mail.gmail.com>
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

On Wed, 18 May 2022 at 15:34, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/05/2022 15:25, Robert Marko wrote:
> >> I think we misunderstood each other. Old bindings indeed did not require
> >> the interrupts, although if present they should be always defined.
> >> Therefore here you should specify number of items and their names.
> >
> > Yeah, I think we are misunderstanding each other.
> >
> > Old text-based bindings specified the interrupts, but no naming or
> > number was enforced,
> > so I looked into the driver to see what is going on.
> > Only pm8941 has interrupts defined in the driver and DTS, so I added
> > those based on compatible
> > matching, the same as with supplies.
> > My logic was that it was only valid for interrupts to be described if
> > PM8941 was used as describing
> > interrupts for other regulator models will do nothing.
>
> Indeed, you're right, thanks for explanation. Your patch in such case is
> correct way of conversion but allows any number of interrupts with any
> names, so it's to relaxed. Maybe then better go to previous version,
> where these interrupts were defined only for one variant. For other
> variants they would fail on as unevaluated?

Yeah, that was my intention with not having interrupts as the generic property.
I will remove them as generic property and only allow them per
compatible, cause I tested
adding interrupts to a PMIC DTS that does not allow them and make
dtbs_check will
warn about those being unevaluated.

Regards,
Robert
>
> Best regards,
> Krzysztof
