Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2758BB68
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiHGOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiHGOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:54:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977DA443;
        Sun,  7 Aug 2022 07:54:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c17so9462332lfb.3;
        Sun, 07 Aug 2022 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X+zhTBewnBwAZ0gofQrf7ORuRinYGAAL513LlgG86O8=;
        b=m4x10IEX8aE70An0kEaihnvqapU6S/pdtbtry7gpY0hEFprtgBrPgcbHk0+2UHV/x7
         Ws8hZhz5ZeWzBebeGYSCWaDHmG1Mgex/6i0ehkhoSZ6HTTDn0AWicby4j+iYH9JIZwef
         mmWRhL8teZMM3UuA7xFR7dhpidw5HCIGxAtgPij8/32dZfAeSjBV/RgAfMN/59Avbddk
         JVKbhTxNL9WhOYSR1wVVSGQVXJ2Yq0/Mj/yLKeEagIZ2WD5rFO9gj1froDBzHpAAVcds
         wysfNx1YmPr/+yHrYjKhACLJ21PjMGki9YUCRws5cHkAAZ1J+0CsFXWIJJNkOsM34N2N
         m5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X+zhTBewnBwAZ0gofQrf7ORuRinYGAAL513LlgG86O8=;
        b=pL1MeFVk1+A5GzN1j8yu9fQcSJX3Iqut/M+LaYomv7SEqM6ynIlBZDp3OOYDHh/7h2
         phT72ShLtKsut4QinquZVo83ZJPq5nQ0nHeHBPb52SjxwmhE3B4wMXCWoS+gdvn5MF3+
         Apsa6nSpaQmm73gavFsd6uFtWb6a7wkm7RFydUeixv2ppwZaoYQSPOvq2Xh3xdVilukv
         PzmYdaDDO0UPeVsf6SxJQy/6JYgz7BSJk0wNGx1IrWS3ZUWHBucDykSskkVXtsLaBMYR
         m/s9jVGX2/cX238Z4Z7fHntj8HtvVvxx7SqerVnT7b+2PbJMgY343V0GTNcXGJrRiV2V
         CYKg==
X-Gm-Message-State: ACgBeo0c2DBMS4v72ZVMPDhTFqUHqhKkmFOUsUBvkaox5ZmsLLqVsp2a
        plLLwLUSqxOGeArdSX7Ch/gqjRHs9nmw/YVRUws=
X-Google-Smtp-Source: AA6agR7We5PalU4zjjHMXJd5bxSNXx2tDuED1Tt+AS9hZRH2ejZC0M3Y/ZY1QTHV0ss3gWSpNMHH7YPOJAY/thAuQRo=
X-Received: by 2002:ac2:5f77:0:b0:48b:3886:5d55 with SMTP id
 c23-20020ac25f77000000b0048b38865d55mr4487858lfc.668.1659884080506; Sun, 07
 Aug 2022 07:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220804181800.235368-1-tmaimon77@gmail.com> <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com> <20220807121138.GL3834@minyard.net>
In-Reply-To: <20220807121138.GL3834@minyard.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 7 Aug 2022 17:54:28 +0300
Message-ID: <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
To:     minyard@acm.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
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

On Sun, 7 Aug 2022 at 15:11, Corey Minyard <minyard@acm.org> wrote:
>
> On Sun, Aug 07, 2022 at 11:03:56AM +0300, Tomer Maimon wrote:
> > Hi Corey,
> >
> > Thanks for your comment.
> >
> > On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
> > >
> > > On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
> > > > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > > > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> > > >
> > > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > index cbc10a68ddef..4fda76e63396 100644
> > > > --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
> > > >  Required properties:
> > > >  - compatible : should be one of
> > > >      "nuvoton,npcm750-kcs-bmc"
> > > > -    "nuvoton,npcm845-kcs-bmc"
> > > > +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
> > >
> > > This is just wrong.  The compatible is supposed to identify the device,
> > > not the board the device is on.  I think compatible here should be
> > > "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
> > > used on a board named npcm845.
> > The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
> > BMC SoC device family.
>
> Ok, but same principle applies.
>
> If the device is exactly the same, then you would only use one of the
> "npcm7xx-kcs-bmc" and put that in both device trees.  You can use
> "nuvoton,npcm750-kcs-bmc", it's really not that important.  Or even
> "nuvoton,npcm-kcs-bmc"
If we use "nuvoton, npcm-kcs-bmc" we should take care of backward dts
compatibility, and I am not sure we like to change NPCM KCS driver.
>
> If the device has a minor difference that can be expressed in a
> parameter, then create a parameter for it.
>
> If the device has enough differences that a parameter or two doesn't
> cover it, then you put either nuvoton,npcm750-kcs-bmc or
> nuvoton,npcm750-kcs-bmc in the device tree.  Not both.  Then you need
> two entries in the of_device_id array and you use the data field or
> something to express the difference.
>
> Since there appears to be no difference, just put
> "nuvoton,npcm750-kcs-bmc" in the npcm845 and I will drop the patch
> adding all this.  Then a patch can be added saying it applies to both
> the 7xx and 8xx series of BMC SOCs.  If you want to change the name,
> then a patch will be needed for that, but then you will need multiple
> entries in your device tree, but you would not document it as such, as
> there would only be one that applies for this kernel.

It little bit confusing to use nuvoton,npcm750-kcs-bmc that are
related to NPCM7XX for NPCM8XX KCS.
We can use the generic name "nuvoton, npcm-kcs-bmc" as you suggested
above but we should take care of backward dts compatibility, and I am
not sure we like to change NPCM KCS driver.

We had a disscation with Arnd, Arnd asked us to use a fallback as we
did here if NPCM8XX device module is similar to NPCM7XX module:
https://lore.kernel.org/lkml/20220522155046.260146-5-tmaimon77@gmail.com/

I think we should use a fallback to describe the NPCM8XX KCS in the
dt-binding document.
>
> I'm pretty sure the only reason to have muliple compatible entries in a
> device tree is to cover multiple kernels where the name changed.
>
> -corey
>
> > >
> > > -corey
> > >
> > > >  - interrupts : interrupt generated by the controller
> > > >  - kcs_chan : The KCS channel number in the controller
> > > >
> > > > --
> > > > 2.33.0
> > > >
> >
> > Best regards,
> >
> > Tomer

Best regards,

Tomer
