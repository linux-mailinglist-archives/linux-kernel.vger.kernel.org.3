Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84D55CE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345267AbiF1LxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiF1LxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:53:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C130F79;
        Tue, 28 Jun 2022 04:53:11 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ef5380669cso114055487b3.9;
        Tue, 28 Jun 2022 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XNYX9WokN0679cD0D/hGygcBjjhtjrHu3X0w/VyXDQg=;
        b=p+9m14+6QsTCZ3pdtSfJn+WEHQmDbBfmFgyzcxQlQAFSE6IZY+I2k0I60ILS1T6sE6
         5tfPY5UZgBU3FRb4NSW//C4Rx1Ok8ZtMgaPCeNnseoVwEVJEBVFNSrjEMdO0/aE06dMF
         bO4JyL56j2waskXr5NRKktwhHstWwfoOWUIKXEVeyeHLnlyJ69uPTTPHfcyFtQdII3ir
         DcrqRmp4yuJtYhQikKQO4K74tylJuh4wPkW3XPaMf8NJTGy1r4c5kq60uETiZZASMznb
         ZWFQkb1edLWF2vaOXd4DP8s5wnw2b9QM2i0kdqnmPmBiANAXfuc6nrwo6+J80NhmvMlD
         X06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XNYX9WokN0679cD0D/hGygcBjjhtjrHu3X0w/VyXDQg=;
        b=gMCi5KiuOCUMC69Re5b0/9L++ghu2RXNDuEI5AwSOua/EJIY3+TPmS8Geaghgr2X+5
         2tnT0p302GOuGVVkMHcPnvsmGS2Oc5+5V63/h5rVD/3dPlY5gi43bmlER5lskl+SPxP0
         ZpObq//ZGJ+K795oHNO1YimTRkK9Q48v1pN7FJbw8Gc3RxjIC4HoSTiXzur0EHYYZNz1
         QcDKyFGzG3BLAS//yZWdqK9jeJ903xsuFm11t7srKE0MWnmKidMKWyi1EgpUWzp3KGKM
         44rGhD6SUFF+uX3XfqfqBj6tXQtgDneJl3t5uiC3RKhi5qCuXfG/ax7o+5QSRF1buL4S
         7yaA==
X-Gm-Message-State: AJIora9B+i+3eFd33AR/+SmeQRIniyyJPgSc+Ykf0r4TtY/hRkwT0ISv
        8vyjcfuX2IhMGwHEJS5RcGnD8hhUTQbRGXTf0+E=
X-Google-Smtp-Source: AGRyM1t1yvSVmh1UzQdiLz0fOsWVO4xcBW2SRjndRAGwREFZZ1pQOPCCdyP/RInbExx8gXe7S6V6QoaMvGta8vqrn/0=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr20865815ywj.195.1656417190958; Tue, 28
 Jun 2022 04:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-8-peterwu.pub@gmail.com>
 <CAHp75Vd95sEQz8y4ZcviUKaC9ic27yitR+VCwkfb38MTTe0mkg@mail.gmail.com> <CABtFH5K_vB5Rmo+2zAJ8PuMeMvC9x-yhDL93ByOLD+gc2maQYg@mail.gmail.com>
In-Reply-To: <CABtFH5K_vB5Rmo+2zAJ8PuMeMvC9x-yhDL93ByOLD+gc2maQYg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:52:34 +0200
Message-ID: <CAHp75Vc0t+3p2TGs9kZ-6JP8y-+cmSF++9uCfbWAgFhapteh-A@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] mfd: mt6370: Add Mediatek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:19 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A82:01=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Thu, Jun 23, 2022 at 1:59 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:

...

> > >  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)  +=3D intel_soc_pmic_bxtwc.o
> > >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)     +=3D intel_soc_pmic_chtwc.o
> > >  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)  +=3D intel_soc_pmic_chtdc_ti.=
o
> > >  obj-$(CONFIG_MFD_MT6360)       +=3D mt6360-core.o
> > > +obj-$(CONFIG_MFD_MT6370)       +=3D mt6370.o
> > >  mt6397-objs                    :=3D mt6397-core.o mt6397-irq.o mt635=
8-irq.o
> > >  obj-$(CONFIG_MFD_MT6397)       +=3D mt6397.o
> > >  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)     +=3D intel_soc_pmic_mrfld.o
> >
> > This whole bunch of drivers is in the wrong place in Makefile.
> >
> > https://lore.kernel.org/all/20220616182524.7956-2-andriy.shevchenko@lin=
ux.intel.com/
>
> hmm... So shall we need to cherry-pick your this patch first,
> then modify the Makefile before the next submission??

I don't know what Lee's preferences are, but at least I have these
options in mind:
1) wait until Lee applies my series;
2) take that single patch to your tree as a precursor.

In the second case you will need to send the series with that patch as well=
.

...

> > > +#define MT6370_REG_MAXADDR     0x1FF
> >
> > Wondering if (BIT(10) - 1) gives a better hint on how hardware limits
> > this (so it will be clear it's 10-bit address).
>
> well... This "0x1FF" is just a virtual mapping value to map the max
> address of the PMU bank(0x1XX).
> So, I feel its means is different from using (BIT(10) - 1) here.

Perhaps a comment then?

...

> > > +       if (ret < 0)
> > > +               return ret;
> > > +       else if (ret !=3D val_size)
> >
> > Redundant 'else'.
>
> I'm not quite sure what you mean, so I made the following changes first.
> ------------------------------------
>        if (ret < 0)
>               return ret;
>        if (ret !=3D val_size)
>               return -EIO;
> ------------------------------------
> I don't know if it meets your expectations??

Yes.

> > > +               return -EIO;

--=20
With Best Regards,
Andy Shevchenko
