Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E401547D83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiFMBt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiFMBtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:49:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B234706E;
        Sun, 12 Jun 2022 18:49:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d18so4690641ljc.4;
        Sun, 12 Jun 2022 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/PYSWXKibe5x9jtHsZxLHvWagS6xrlBtfVUeqbgDuWE=;
        b=GDhjNW6CbulMug7jA0ipc7EGhoWRP/DNYVh/vaAjlMnbVMC5qhObLJInM+Gjla34Ok
         sQwTcFqxg4LtzW+FVN4tIem2cAEpknLLnqJIzLOsjOvKa8ClFTTSvXf1ARCw4IwbouNh
         QBpx2UA8ZDR8cdDQC82U2r9nRU5vHXy0xxXM8gkT6MyqPPMA/Y9AM1ky0HegAe1RZHcz
         MI6hWLOKY96FrsRXRFq7oWFyfZoEHLkXjjM4sSEheGsM5DIW9TLB9QjOLnhSdSiTtFAg
         BQ8H0SVNegD4Wg8WBJIhbtH9AaJC0j7pYlQ7LbpWcryR+8zbWGpNyAEW1SvEGdAVoS0m
         fXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/PYSWXKibe5x9jtHsZxLHvWagS6xrlBtfVUeqbgDuWE=;
        b=f+4uypnPAC+bDLzc163LsjAdBhvyt+3K2BljLBk63QhHHUKCSA1oUvkltrzK5GI2zd
         W+Zw4GVOreTEbEuXPIWq5RBsGPNful9Hxnbv9fkTVraV0ArdSUD6sqoB67QAmjwFWvDE
         wisNufbcYXAGpUudhULgsQwrMfLb5eBUDvC1ouMQiZXbWAboO++z/d9ChEvrosXlxtUZ
         jFTGm+jIaM5fH7HN5emFYeiNo0hRYOjpYmSj496Kz7z1uy+amo59oAvPfsKoq4RfFwZm
         rdYVTchNmbgdrAWwvzBSHh/qEopxQnILMTIxNPBGcHIYYTIEQ38tW9FqG1DaPAzGa8Kf
         dSTQ==
X-Gm-Message-State: AOAM530n3zkzGX8eeG+Rei1Ym59KfX/cJ7qJLbBztTJaE725ZmvPg0Jo
        EZ+Ysd5f3s/0w3/YkI/QvbuzoVj7Bun6P2SwQDo=
X-Google-Smtp-Source: ABdhPJzzln+Z7qw1U2oLvG0AVilcaZA03DyMpD6mMn9tsOSoyikE6TzEbC0tINtnJfIMOKBK/Ej4ijYmw6xWD9tsoO8=
X-Received: by 2002:a2e:8404:0:b0:250:cde7:e9e3 with SMTP id
 z4-20020a2e8404000000b00250cde7e9e3mr68692306ljg.289.1655084982967; Sun, 12
 Jun 2022 18:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com> <Yp+gS6r5Kpi33Ags@sirena.org.uk>
 <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
 <YqB19O/HYvEAxdiM@sirena.org.uk> <CADiBU390XRXZ2yx5CT2NxhN3aROHXcxs7w2d-xhB6+EYn+uTfA@mail.gmail.com>
 <YqMlDVMlukNAns5S@sirena.org.uk>
In-Reply-To: <YqMlDVMlukNAns5S@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 13 Jun 2022 09:49:31 +0800
Message-ID: <CADiBU383BxOttuoLdF2GjXHasoPMc634wsMr3zLC=v74OBGUmw@mail.gmail.com>
Subject: Re: [PATCH 3/4] regulator: rt5120: Add PMIC regulator support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jun 09, 2022 at 02:35:07PM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Wed, Jun 08, 2022 at 11:15:56AM +0800, ChiYuan Huang wrote:
>
> > > > My excuse. let me explain it.
> > > > buck1 voltage range from 600mV to 1393.75mV.
> > > > buck2~4/ldo/exten is the fixed regulator.
> > > > buck3 and buck4 is fixed by the IC efuse default.
> > > > buck2 and ldo is fixed by the external resistor chosen.
> > > > exten is designed to connected to the external power.
>
> > > > That's why I cannot directly declared it as the static regulator_de=
sc.
>
> > > So buck 2-4 need some dynamic handling then but the rest can be stati=
c -
> > > that would be a lot clearer.  You could also have a template for the
> > > ones with some dynamic values and just override the few fields that n=
eed
> > > it.
>
> > Not just buck2/3, buck2/3/4/ldo/exten all need the dynamic handling.
>
> Why do the others need it?
>
Sometimes, for this kind of general purpose PMIC, it need to provide
the flexibility.
Cause buck2 and ldo can already be fixed by the external resistor,
buck3 and buck4 seems to be fixed by IC default.
So there may be the same part number and use the postfix to be
different like as 5120'A'/5120'B', etc...
And use it to define the voltage for the different IC default for
buck3 and buck4, and exten behavior.
That's due to the different application use the different power on
sequence and default voltages.l

> > > > > Drivers should never override constraints passed in by machine dr=
ivers,
> > > > > if there's validation needed let the core do it.  The same probab=
ly
> > > > > applies to providing a voltage range for a fixed regulator though=
 that's
> > > > > not modifying everything so not such a problem.
>
> > > > Please check the above explanation about each power rails.
>
> > > I'm not sure what you're referencing here?
>
> > Sorry. Let me explain it.
>
> > You mean 'of_parse_cb' must not override constraint.
> > But if the regulator is fixed and dynamic, after
> > 'of_get_regulation_constraint', apply_uV will be true.
> > The is referring to 'fixed.c'
>
> fixed.c is a special case due to legacy issues and being generic, for
> normal fixed voltage regulators in a device where we know what they're
> fixed to they can just have their voltage hard coded in the driver.  If
> there's issues with the machine providing invalid or nonsensical
> constraints the driver should just let the core deal with them.
>
> > > > > This is all open coding stuff that's in the core - just provde an
> > > > > of_parse_cb() operation and let the core take care of calling it.
>
> > > > Ditto
>
> > > Or here.
>
> > If I put 'of_parce_cb' to make core handling it, the input parameter
> > 'init_data' is declared as const.
> > I cannot override the 'apply_uV'.
> > Right?
>
> Yes, that's by design.
I have traced the code for 'of_get_regulator_init_data' and
'set_machine_constraints' in regulator register.
If I cannot overwrite apply_uV variable, it will cause the
regulator_register return -EINVAL.
Is the below flow that you suggested?
1. of_parse_cb to check min_uV and max_uV, and fill in the fixed_uV in
regulator_desc
2. provide the duummy set/get voltage  to make set_machine_constraints
not return '-EINVAL'.
