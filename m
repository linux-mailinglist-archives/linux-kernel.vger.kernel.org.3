Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05806571A63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGLMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiGLMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:47:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C1B23D7;
        Tue, 12 Jul 2022 05:47:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g4so13717327ybg.9;
        Tue, 12 Jul 2022 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuKIucR4KkuGyNu77o8BMuklCnlGTYu08xOm0VTgdvk=;
        b=GqU/u0UlCR6S91EqqKnO0JOpU9rLiT7tbPk0Wkx/SrM4UWJYrcl1e0tR//MWxWfhlO
         c5Hz6NuofNkEIyx9vVL6U73Y2jdAV/me94++R4ZedtiPQor6j5LpefQEzpvSIHdLRfv9
         yI8A9FKt5KfSokgAHN9ERtG963U/REg9j8H0IQxa00Kp4m2p4hBr0Q4TEEcTr+me6Hla
         0zFQCD4vTCrO1FQGXUPOOkvnYDC64UVjPC7Vy+Cv0z05O7C6gX20yNfm0pResEKK7VjK
         GpcsvaoBOZN80/En12Gy8gjmMifGwOnS1yYuKPZkOCaq0242959il3sgRns+h8Z8k3tY
         aaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuKIucR4KkuGyNu77o8BMuklCnlGTYu08xOm0VTgdvk=;
        b=DZJaeLyqQVDWCg7AP5rNl1hrMNSkSgQC+3VoNjXQjQiGIra17zBw19J9pVb8h4/ECL
         YXn+llTV6aqVjqirACg3SgfA54xqmHexTo7eOBH9goiTf2AQ6vZ74LMAoAet+wLfNz4H
         AOuuQrm0J9iVRbGR4WmLQDOAfjfvZROOJWf2PJ6dcPBkajQu7AuRx484IDipTx09wtE/
         jrkr6mvbl+xbWy2D2N7yVg7t99o2FDZhWEjSC9uAR1xxrpO6Bkw90RV014LpZFBrIpT5
         Q7m268nTV15LiYxMz2gb+P6v8kxjPRSlruWMp5b55d7KHSTnNHBth5uDI1cJJXnxcF4I
         WDuA==
X-Gm-Message-State: AJIora/dLVsMZOQScPRJr8Z6N/9XRzpyFdaJFGqYBIDHIbhKJhD/X8dE
        SDkr/Llr65HOhdXJJN8W0VtSsaWe+wv0iFZW1uQ=
X-Google-Smtp-Source: AGRyM1sKejbUO1HoZjE4lSyDoKO9Miu7goYifaotbPEm1foAGgKjrYVSe34gWUcQ2nkEyr2fAzNJ96SJe5dnVWQnEBE=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr22814673ybg.460.1657630058486; Tue, 12
 Jul 2022 05:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <CAHp75VdaT8WjoHYgmUY+mKVaUivLGGeaRJAkwfRjHspPAmw_XQ@mail.gmail.com> <CAP6Zq1iQL2R67dbdQiXW_JUWrGne9xp-9yQ97vQOb4RveQE7Yw@mail.gmail.com>
In-Reply-To: <CAP6Zq1iQL2R67dbdQiXW_JUWrGne9xp-9yQ97vQOb4RveQE7Yw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 14:47:01 +0200
Message-ID: <CAHp75VfYbFYcp6eKQsSJ9-0Wz-9=UaM8ERWyOkcXfWvinZHB7w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 1:33 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Sun, 10 Jul 2022 at 22:36, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jul 10, 2022 at 12:44 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

Please, remove unneeded context when replying!

...

> > > +       if (pincfg[pin].flag & SLEWLPC) {
> > > +               switch (arg) {
> > > +               case 0:
> > > +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> > > +                                          SRCNT_ESPI, 0);
> > > +                       return 0;
> > > +               case 1:
> > > +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> > > +                                          SRCNT_ESPI, SRCNT_ESPI);
> > > +                       return 0;
> > > +               default:
> > > +                       return -EINVAL;
> > > +               }
> > > +       }
> > > +
> > > +       return -EINVAL;
> >
> > Why not to use usual pattern, i.e.
> >
> >   if (error_condition)
> >     return -EINVAL;
> What do you mean? like if (arg>1) return -EINVAL? It just seems more readable.

  if (!(pincfg[pin].flag & SLEWLPC))
    return -EINVAL;

  switch(...) {
    ...
  }

> > here and everywhere in the similar cases?
> can you point me to which more cases you mean?

Any you find that follows this pattern. Actually the rule of thumb is
to address all places in the code even if reviewer has given a comment
against one occurrence of something.

...

> > > +               val = ioread32(bank->base + NPCM8XX_GP_N_ODSC)
> > > +               & pinmask;
> >
> > What was happened to indentation? Check entire file for indentation to be okay.
> Sorry, I didn't understand, could you explain the comment again?

Indentation is a code formatting technique that allows the text to be
more readable. In particular when lines are split they should
logically follow what code does and point to the code relation. Here
you have '&' on the next line with indentation starting at the 'val's
column. This is not readable and confusing. In this case formatting on
one line fixes all issues. Possible alternative is to clearly show how
the 'val' is being modified:

   val = ioread32(...);
   val &= mask;

But see above about the amount of LoCs.

...

> > > +                       } else if ((nanosecs > 3496) && (nanosecs <= 4136)) {
> > > +                               iowrite32(0x60, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > > +                       } else if ((nanosecs > 4136) && (nanosecs <= 5025)) {
> > > +                               iowrite32(0x70, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> >
> > With switch-case with ranges it will be much more visible what's going
> > on. Also think about it, maybe you can use some formula instead? Or
> > table (array of integers) approach where index will show the lowest
> > range value.
> There it can be described in a formula. Will be done with switch-case

I'm not sure I follow. If you can use a formula, use it!

...

> > > +               if (ret) {
> > > +                       dev_err(dev, "bgpio_init() failed\n");
> > > +                       return ret;
> > > +               }
> >
> > Use
> >
> >   return dev_err_probe(...)
> Why it is better to use dev_err_probe?

(beside deferred probe, which may be not the case here)
- standardized format
- less LoCs

> I am not sure that the error will be EPROBE_DEFER, all the failure
> cases the driver returned the
> error in the code.

...and it's fine to use dev_err_probe() as stated in its documentation.

> > In ->probe() and satellite functions.

-- 
With Best Regards,
Andy Shevchenko
