Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212353BA64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiFBOAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiFBOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:00:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD5271781;
        Thu,  2 Jun 2022 07:00:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so10254962ejc.0;
        Thu, 02 Jun 2022 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AYxq+mMduPBX5NXqRBF2+5IJjnwegK5vDcEeTyInUPU=;
        b=auP1KW3KeSmMw7VIZ62/gbLMAnB923JIROgeNcNM60iNfs70SRXGH9Oh+PqNAIdl95
         sF3KgLrJAdhJvNL5E/yTCatacqFZTuJwNSgnwpd8r3nWCcjRXQOJQGh/LEv8L8WGwDHn
         GRMckxbpngc/1zSMfnGGQOEbWW1vqQbIAf/Fr7XQHihGGmhAIL+CXKz/Sx20mLoDFvK2
         Mrq/lvN37tLRQTJChv3fW11X7HfKADxJn3lW1n7mcgkdAUHAPKZhMEZRqOIIvJS+CQJo
         E9+wli3/tU0/Qxnp7IRGppAp11D6KG1QpREaRpW+RGISetT3kVGuRq7qeRk42Hciw7Be
         LYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AYxq+mMduPBX5NXqRBF2+5IJjnwegK5vDcEeTyInUPU=;
        b=ND6vo9TSDcon/FmEUjE+075JxG/6ovzx/dplStXFQ+KTdj+yLHnr9f2bum1FkOT6QG
         oTnhJbLJ654aRR8//t3d6Nuj9JOSjq+bQRbHyEkbgc3rcRkJcBvFbOJryiRxeWlqP6eC
         9MV/dDkEe0ziWC+CMLSgisNfLOa4r45JVnOJi9NEwoZwVb+g2PFtwwj3OBG6jayL1TiL
         I9QzTvn+RiGuc91kDYdwic2yoRFit0rkF/Apwp7X+eILLFxqvLTOOXekzIlbIqaZB3Wb
         cnHYUnCa/OtF7wGfhSvt6N43PinmmuswWRcF404NnjEimncKk8OVkVm8nSUp9qu/hLjM
         f6Kw==
X-Gm-Message-State: AOAM532TKGBJY+Ss51GOm90GYOOs8uwe5JUvEN5lnjmuMC0lKo/F1SlR
        Z4UofG7MOSLrh/iTM0EEoTIop/aumYUXFE6Gi/I=
X-Google-Smtp-Source: ABdhPJxtpuBCKEOrj7yi3ocCsJZ0ETA3Lw0fV9RaebX5CwbyumoNpdxxmykaJXm5oH5aPRnpODJs/24H5iu7FWYfbjE=
X-Received: by 2002:a17:907:8a27:b0:707:cc50:e790 with SMTP id
 sc39-20020a1709078a2700b00707cc50e790mr4462180ejc.77.1654178424506; Thu, 02
 Jun 2022 07:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-8-peterwu.pub@gmail.com>
 <CAHp75VdUQqihr=AX-wEUD05jY1ReL63hMCL+eaqmjkN8CsS_Vg@mail.gmail.com>
 <CA+hk2fasiriGHepNjsnPCqTMJOgAEbVHACmWrDRZY7cHPcOQqA@mail.gmail.com> <CAHp75Vf=ATRfaaaGFuuPHuQj6wTjnRPBw4W5WYfgYuUP-A-L=g@mail.gmail.com>
In-Reply-To: <CAHp75Vf=ATRfaaaGFuuPHuQj6wTjnRPBw4W5WYfgYuUP-A-L=g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 15:59:48 +0200
Message-ID: <CAHp75VdDLnisODLCpTEHdGcxCFATdJHfJWf+=GdGtYV2U_o9+g@mail.gmail.com>
Subject: Re: [PATCH 07/14] leds: flashlight: mt6370: Add Mediatek MT6370
 flashlight support
To:     szuni chen <szunichen@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
        Helge Deller <deller@gmx.de>, cy_huang@richtek.com,
        alice_chen@richtek.com, chiaen_wu@richtek.com,
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
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
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

On Thu, Jun 2, 2022 at 3:57 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jun 2, 2022 at 2:07 PM szuni chen <szunichen@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Tue, May 31, 2022 at 1:32 PM ChiaEn Wu <peterwu.pub@gmail.com> wro=
te:
...

> > > > +       const char * const states[] =3D { "off", "keep", "on" };
> > > > +       const char *str;
> > > > +       int ret;
> > > > +
> > > > +       if (!fwnode_property_read_string(init_data->fwnode,
> > > > +                                        "default-state", &str)) {
> > > > +               ret =3D match_string(states, ARRAY_SIZE(states), st=
r);
> > > > +               if (ret < 0)
> > > > +                       ret =3D STATE_OFF;
> > > > +
> > > > +               led->default_state =3D ret;
> > > > +       }
> > >
> > > fwnode_property_match_string()?
> > Sorry, but I think the use of this function is different from my target=
.
> > I want to read the string of the "default-state" property and figure
> > out if the string is in the states array.
> > But the fwnode_property_match_string aimed to figure out if the state
> > in the property array.
> > One is a property array and another one is a state array.
>
> Ah, indeed. Nevertheless you may reduce the code base by doing like
> the following (I wonder what your code do if there is no default-state
> property):
>
>   led->default_state =3D STATE_OFF; // it's by default off since
> kzalloc(), so I don't see why we need this line at all.
>
>   fwnode_property_read_string(init_data->fwnode, "default-state", &str);
>   ret =3D match_string(states, ARRAY_SIZE(states), str);
>   if (ret >=3D 0)
>     led->default_state =3D ret;

Missed change

  const char *str =3D states[STATE_OFF];

--=20
With Best Regards,
Andy Shevchenko
