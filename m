Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A701580FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiGZJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiGZJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:31:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DB248CE;
        Tue, 26 Jul 2022 02:31:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a23so19435944lfm.10;
        Tue, 26 Jul 2022 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IL3Z4+bwdRS3yxOZTNpNZKdqvlk3APcJ7jcbsYJVSmk=;
        b=l6SHg/J5A0OUd8PSnS43zbEUAINghMLi0ClY87M7YZJOU1SRfY0cZpGXsr1ju7YAAk
         /DR22tO/5n9CPiQeYtI+j6BnoywwsnfcU5ICBFO2BJd/7QvwoKtUpsMqZ62BXuTSRnaK
         iX9My8uqm5wq3kROf9GWBFLp59n+0zotuzXO8qjqLLnd3VHsivnceSKRbNhfPUSGKCcG
         ywxKtTMFpsQz6+gSRsJRwZtdWALuA1QLRYtz+hiQqv69/mtTFr7ToR5loJxRq6vxaE8f
         bS0YfTZaK+bdlHfd8rXL5I1J2G4v63GuRjrWQr5tzwFWcMpnA1j8lBgOVVlHoPqqWshS
         gjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL3Z4+bwdRS3yxOZTNpNZKdqvlk3APcJ7jcbsYJVSmk=;
        b=RnKMT7Tn5cm4kSNrJLjaTyTHJTQbxBpfEBYzJFbeloJV/VAYxw15ZbMuDu/8jWCOa7
         gpuSDYFuekolXyogPjkJJgKDSHxfSoFTDtkVrT5mJAqe36lNf1l5zykbXGqo1/I2SJw4
         lCXlIMZYe2+T52i9IF0naXQ7nIAamfCvQUaAEJJ1mGdUIFUVHW7wDPFgTdrpOi1dN3F9
         6ZyXrBEgeYafIPVN3dK0WsxERvN3QVH93yTkFTXcpb68Q3vgweYpBRPzmsT7h+DeJkPX
         CRebImJaPYYaEU8IjxXCeN1uMNy1h3bDDjXvF0jzXwQ3nF6SgDeGYHv/Zb2FkcuOGBE0
         unNw==
X-Gm-Message-State: AJIora+LqffXqVrPFqnRuJdswGgkH/hk54sXXR8f9pWb5UhOrlWbGwF+
        6Jqqz8XZvdREM7MazPIFvF3ZFA7hYWypZ0Y+y0w=
X-Google-Smtp-Source: AGRyM1uL6DT83C459zUSdYi1GQWszpd4iNJjtzhdOjGifSm4yOssdUqu+X+HBkYa0gNl/VFvJe/TlxbmoZl5MFHL4M0=
X-Received: by 2002:a05:6512:693:b0:48a:7c23:1896 with SMTP id
 t19-20020a056512069300b0048a7c231896mr6390732lfe.111.1658827869026; Tue, 26
 Jul 2022 02:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722114136.251415-1-tmaimon77@gmail.com> <20220722114136.251415-2-tmaimon77@gmail.com>
 <20220725225650.GA2898332-robh@kernel.org>
In-Reply-To: <20220725225650.GA2898332-robh@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 26 Jul 2022 12:30:57 +0300
Message-ID: <CAP6Zq1j0pKHsX20t4ep9-6B_5pTe5MzkU__245F6tW7wFJESiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your comments.

On Tue, 26 Jul 2022 at 01:56, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 02:41:35PM +0300, Tomer Maimon wrote:
> > Add a compatible string for Nuvoton BMC NPCM845 PSPI.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> > index b98203ca656d..a4e72e52af59 100644
> > --- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> > @@ -3,7 +3,8 @@ Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
> >  Nuvoton NPCM7xx SOC support two PSPI channels.
> >
> >  Required properties:
> > - - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
> > + - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
>
> Who/What is Polog? Board/BMC vendor? If so, that should not be in SoC
> bindings.
>
> > +                             "nuvoton,npcm845-pspi" for Arbel NPCM8XX.
>
> Same for Arbel.
Poleg and Arbel are the name of the BMC SoC, will be removed next version.
>
> To answer your question on fallback, just put:
>
>     "nuvoton,npcm845-pspi", "nuvoton,npcm750-pspi" for NPCM8XX BMC
In the document?
because I don't remember doing so in other documents that I use fallback.
I need to do it in ymal files as well?
>
>
> >   - #address-cells : should be 1. see spi-bus.txt
> >   - #size-cells : should be 0. see spi-bus.txt
> >   - specifies physical base address and size of the register.
> > --
> > 2.33.0
> >
> >

Best regards,

Tomer
