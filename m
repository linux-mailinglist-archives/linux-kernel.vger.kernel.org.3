Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9D4EEA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiDAJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiDAJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:37:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86C62BDF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:35:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn33so3136465ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4FSuKnccX1iFN0uwomkiOn5u1Xbdrve2qg2JRoojKE=;
        b=VogYOcScEozGo2HMiWfqxuG6WYR1q4RB22WpLk5JKZJ7C7863bdDZMoez1zh52xN3E
         tQRCs5L9iLeEb3iV/aDNvioJiF6J1FXPf/1x+Jyf0ZnUG8mzmEooJR7j+y5YldogbuP+
         5ezZ26ojecVxEvsIhBKIacbEiCW3aRA9iQwLnC0eJIRp9QpLT3gCIlLWTVPWekSneKDD
         gETW8elTB+iNq/ztsFTbH9BsNjgxNo1YX7KDi+JnJHg6QgCVPbLGDuQJi9sf2ve2FCoA
         TVnlbcWW+EXB4ILmmm8EcrghRQ2R5G/sodiSOxtoOtAHy5iED1RwUgHk4B4qiR9ViDYB
         1gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4FSuKnccX1iFN0uwomkiOn5u1Xbdrve2qg2JRoojKE=;
        b=5haFoPkk3sPdQ9SuROzvoMKJGIvOY3cbIyg0DOLwMypWMdBV0onA/IZBorJgqcrnLW
         0xFBvKpbPhi8O72TfcAzbUD0InWySA1vb29ttMCNjYFCv4Bm1/PPiopPM2lAjVntFaLn
         1SCaXLwG/A6FLKrXxjUqF8B0zQzfN1KPZv4uoirLviiircLXj5CAMEGe5McxCj+b3tWF
         J+4hL4l7a+8Y/Qy8DRh//qjUTWXc1bbDnKOfvI++gTJIWvjRrRTHDNKE34kaBjCCkyQW
         Q75sjcXsOdUr7DtPWT6lsICL9cTj3LozpCj3Py/IKNQ5gV+IzvKLJMI2L16A5cvta0Kc
         TBGA==
X-Gm-Message-State: AOAM532ccsTXMbLhitWBFOm8V5S6J7/F5n9IrQUUIBHhie3MC3j5XtNO
        aq/B0YdOqjgrn0iSBKWEea5QWjpJDfjhJeb/2lSh8w==
X-Google-Smtp-Source: ABdhPJz6psO/sjbUT/j1r3XjHcZRBUCIC5sFVlTg1I2riC4zd4S5suzIVESlXB2FKEJIV3qX81Z8ZtW69b0xCIMwSA8=
X-Received: by 2002:a2e:8189:0:b0:249:7d3a:ceb0 with SMTP id
 e9-20020a2e8189000000b002497d3aceb0mr12136101ljg.367.1648805715996; Fri, 01
 Apr 2022 02:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220329032913.8750-1-axe.yang@mediatek.com> <20220329032913.8750-2-axe.yang@mediatek.com>
 <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
In-Reply-To: <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Apr 2022 11:34:39 +0200
Message-ID: <CAPDyKFo_PYc9ofWuXeaE86oK6FqOAnHsH-ZSG58MfNq8nEOVOw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 at 11:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
> >
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> >
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml         | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 297ada03e3de..3872a6ce2867 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -69,12 +69,22 @@ properties:
> >        - const: ahb_cg
> >
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source irq.
>
> If I understand correctly, the extended interrupt (a GPIO irq) may not
> necessarily share the same interrupt parent as the primary device
> interrupt.
>
> Perhaps it's then better to extend this with "interrupts-extended"
> instead. See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.

One more thing, looks like using the "interrupt-names" property would
be good to use too. To easier distinguish the different irqs.

[...]

Kind regards
Uffe
