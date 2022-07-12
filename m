Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC25715AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGLJ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiGLJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:28:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29DF9FC5;
        Tue, 12 Jul 2022 02:28:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so9195007ljh.2;
        Tue, 12 Jul 2022 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xJct7vEjBCMJh3rBGYc/iOhbOODN5YQYTl76Ke6v2U4=;
        b=Q24pyPIt/VqdeOyR13jVe1yU+/b/hY7BmZs1Fc+F1bVOdL3EWVKCKWLtmEACMwaS/5
         ZPsIizXk4WxxPgvbodojzIk++MjiNreYmXfdOWxwj07cd2gdd+uM5NhUYRuvOc5RzT2M
         dx1oQUkvzDZ0wnwciL2jacrjMj5IgCryk6he+JmacFSPSnYlOHHZd80cGd37f9zdDEdl
         lMxoLcU87emsF9NnRs7x7hGbOGnY8Ev73+v0RC9d2wQbAYfCGlV54O9g4anOWrhRY7uT
         6mdK/GDDshEne7UTrqJL+hnTQu5gQRiDvwhokCh8LCl8nct3SDsCNXE3eo90/AjQE37C
         UQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJct7vEjBCMJh3rBGYc/iOhbOODN5YQYTl76Ke6v2U4=;
        b=xTXalcsy4SzrlUU2FpOpSly4KE9ON0IHu3GDqyLcs+UV0b94dADHx8C4xYFG4/tY6X
         Q+zle/qx+rQYSmq8kMs7p2lqRlZ1dQeSCM+m8SJE9nogUZgusLX/QCtaWR+ujPVbJ2Wg
         05nomfyWgJEvfBuCW6jeSluv3Yp2Nygns12WNExh4yoEg3eQCQD4UbrSQrWHXb41FO/N
         4+OznBRqAeliBU03gUP8e+4NHyXx0hNAge0B7YLmDFmesQ3eY08cw4DDtKTqbGESA8B7
         bilJtown3YfeT2gsGp1vMuplR9xf20BKMsw87xyGRO/BUYJ2p3hZiTFmfyhjVtz6Ffak
         pU4g==
X-Gm-Message-State: AJIora8V/zdaDJNMETNmSg8WDSP/xz78nRYT2kwkoEhcrtOePBtUWm9V
        kJgHM2eYHKljncB1D+ID0uXigGuQ0HYsPFaj5dA=
X-Google-Smtp-Source: AGRyM1vc3Gcp6847kG1cXb1tgtAB09PmgaOrFEl5S+FEGvbWXaf9an+I+Uw/6X8+vimY2qGyJFP02L80uZLRP5c1u8s=
X-Received: by 2002:a2e:a288:0:b0:25a:76f9:dc6d with SMTP id
 k8-20020a2ea288000000b0025a76f9dc6dmr12901296lja.152.1657618118747; Tue, 12
 Jul 2022 02:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220712030509.23904-1-mimi05633@gmail.com> <20220712030509.23904-3-mimi05633@gmail.com>
 <b9268cfe-2428-65c9-979b-522e4a43f955@linaro.org>
In-Reply-To: <b9268cfe-2428-65c9-979b-522e4a43f955@linaro.org>
From:   Minying Lin <mimi05633@gmail.com>
Date:   Tue, 12 Jul 2022 17:28:27 +0800
Message-ID: <CAL3Znpyx9Srhkje0HW_0FJPrWmTmmMVPonFH_oQ8hFhZWFrL4A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>, a.zummo@towertech.it,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, ctcchien@nuvoton.com,
        Medad Young <medadyoung@gmail.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, KFTING <KFTING@nuvoton.com>, JJLIU0@nuvoton.com,
        CS20 MYLin1 <mylin1@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Dear Krzysztof,

Thank you for your comment.
I will fill blank line.

Thanks.
Best Regards,
Mia

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B47=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:44=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 12/07/2022 05:05, Mia Lin wrote:
> > Add nuvoton real time clock RTC3018Y in I2C node
> >
> > Signed-off-by: Mia Lin <mimi05633@gmail.com>
> > ---
> >  arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/=
dts/nuvoton-npcm750-evb.dts
> > index 3dad32834e5e..589aadb67688 100644
> > --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> > +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> > @@ -202,6 +202,10 @@
> >               reg =3D <0x48>;
> >               status =3D "okay";
> >       };
>
> Missing blank line.
>
> > +     rtc0: rtc@6f {
> > +             compatible =3D "nuvoton,nct3018y";
> > +             reg =3D <0x6f>;
> > +     };
> >  };
> >
> >  /* lm75 on EB */
>
>
> Best regards,
> Krzysztof
