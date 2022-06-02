Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AF53BA46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiFBN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:58:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD0793B2;
        Thu,  2 Jun 2022 06:57:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so10158719ejk.5;
        Thu, 02 Jun 2022 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lCjXd1DtLAOiKDUVepuP3tVKlqmoM9phz1lypZW4eiM=;
        b=eKXUR7kiBU80Kt1ivUsBYC1Vp5ABsZgOFlwcUTfYnL3EYaoBLLC4llE6qNCbLYkoPK
         yV/E9DUt2ifgfA2Nbk6ykWpgQhfm9txSuz+Z9LmYA2e0QtK14BpQdaIg86EMFNfuUWkx
         hMXNoGeRpp7Hw5ALo7uCiIN/Vg+bFN+64MnxIrSs4784P1udBgejLUQnnHasBXCy/VJv
         Hraq92Husrz3Xf7aLdubPKJuxySVXpGPA0CZZLKoHOr29+EvAoDaQOSqIfuA/pA2wdFl
         oxnZHqbsTfLFBaxgW2BGhnhwkC0uMC12x04YUFSe3zvFWWisWKPD/j9A/tTeJZTOCSWO
         kQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lCjXd1DtLAOiKDUVepuP3tVKlqmoM9phz1lypZW4eiM=;
        b=NWuso4ZzJ2XIOREiQvXrUw/xeTo07Z3fHySVFA9TDeKu07xHWPceLUwXEDFYALRl0S
         uaeG7QzPp1TeVgLicOtPL8nwiXYTN3cgFBJrLk69g/Mx7HPVHkUb7rNoEPXj1qvDL4nv
         oJaMJPPL/vAxZkKZv3B4ffi8V0TmuCV2SdURfhKLPZ/qGDXIes5HimrFntNNtz13e5zM
         rkFSzx1v5Og1dZIrjRBTGpLPyUiVgR4nbuJehcnrg/yNqwr2SL18Vmvxwhr4yPzsD0u8
         Y6QD6XDuj+bMSIQSRzwDVROxrZl4VAPwwt/izuS1JBcd5cAxpsi+DVO7mGdbD+ccmghI
         yLwg==
X-Gm-Message-State: AOAM5316Gy/jrnPFisdF0TmIb9D8QZ3WQg76+w3E9C+Cel0YmpXYq7K+
        tOdhpMRUbSgymgoHxR4FF/WmYF9ZwQ9AeQW+Rb0=
X-Google-Smtp-Source: ABdhPJw17vPxP2UwrASUkgWE75bkBumiXi0yzz2upgIbMhdhBA7mECqviI1+XnRf2zU0lOm4Q01q8wM9WsX0p02cGPY=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr4545345ejc.636.1654178277156; Thu, 02
 Jun 2022 06:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-8-peterwu.pub@gmail.com>
 <CAHp75VdUQqihr=AX-wEUD05jY1ReL63hMCL+eaqmjkN8CsS_Vg@mail.gmail.com> <CA+hk2fasiriGHepNjsnPCqTMJOgAEbVHACmWrDRZY7cHPcOQqA@mail.gmail.com>
In-Reply-To: <CA+hk2fasiriGHepNjsnPCqTMJOgAEbVHACmWrDRZY7cHPcOQqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 15:57:19 +0200
Message-ID: <CAHp75Vf=ATRfaaaGFuuPHuQj6wTjnRPBw4W5WYfgYuUP-A-L=g@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 2:07 PM szuni chen <szunichen@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Tue, May 31, 2022 at 1:32 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:

...

> > > +       const char * const states[] =3D { "off", "keep", "on" };
> > > +       const char *str;
> > > +       int ret;
> > > +
> > > +       if (!fwnode_property_read_string(init_data->fwnode,
> > > +                                        "default-state", &str)) {
> > > +               ret =3D match_string(states, ARRAY_SIZE(states), str)=
;
> > > +               if (ret < 0)
> > > +                       ret =3D STATE_OFF;
> > > +
> > > +               led->default_state =3D ret;
> > > +       }
> >
> > fwnode_property_match_string()?
> Sorry, but I think the use of this function is different from my target.
> I want to read the string of the "default-state" property and figure
> out if the string is in the states array.
> But the fwnode_property_match_string aimed to figure out if the state
> in the property array.
> One is a property array and another one is a state array.

Ah, indeed. Nevertheless you may reduce the code base by doing like
the following (I wonder what your code do if there is no default-state
property):

  led->default_state =3D STATE_OFF; // it's by default off since
kzalloc(), so I don't see why we need this line at all.

  fwnode_property_read_string(init_data->fwnode, "default-state", &str);
  ret =3D match_string(states, ARRAY_SIZE(states), str);
  if (ret >=3D 0)
    led->default_state =3D ret;


--=20
With Best Regards,
Andy Shevchenko
