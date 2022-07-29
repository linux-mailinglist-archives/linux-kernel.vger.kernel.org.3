Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205A584EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiG2KfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiG2Ke4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:34:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7677545;
        Fri, 29 Jul 2022 03:34:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c12so5304982ede.3;
        Fri, 29 Jul 2022 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Zk6yHET57f/wYXBe4yiexZ1AAMItVqOz1Jv1kut5E8E=;
        b=IsM5N0dJ2jSYwlQl9rbwt+OLNPEKaCRVIniuh9/fK2UA5cEWqol8qEt2eY1KAFImh0
         xgKtFlDvRwmal8EgGb4Op+XBno/E/HH8Bxy8BPnkUU2nIxz44g1exMkT0mBgnzczAkOM
         jEEdvopg/k2e5S3/4OLDkdml7fNMgGZXJmK2pxORFJYNKUIs9dcrZpTPKP/PyTRRiDnU
         4AbNyblEPeQVwrctPIK+zUGSC8WmuyEHQXK0TllYSTMZqHtKbYQ+rO3pNAksc0uoqvC9
         H7uLLtXO9go/uW0Ye5nZLjgde4OuJHwsb257PiiTAEQZboCcDlee7NJuUdg+WQoQdZGF
         8sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Zk6yHET57f/wYXBe4yiexZ1AAMItVqOz1Jv1kut5E8E=;
        b=QV3GjVqcXmZkzYvOvw6OgT3i4XSD7Gfdy313J3JcSvuqH0c+EYx/ZOsdwC2ux5OW58
         2tN1M7mF5DZYbELP0pwzMG/Pa2RuKLZAzhW+OlyYRvr0Rg2aaoqsbkxzOdw1QPztnc8l
         KPkkL0D0qpWL9goqpbA5LaGeBEoPvCvTWTjz/7lRZQdBd+Zvx4F7A/cgHoH54/uiranJ
         cE3PY7JtbB5HhpOtnKluTtn18C5Bj72TI1j1OCB2pJkrXa42kmZPURPQeTiQko+AQjHB
         Gg/9S5LyLbL89/gOPWwJMmY5HnLamveXxTLeQG9poE5pDU23LBUXRUHxl2adb7g0BtVK
         wH1Q==
X-Gm-Message-State: AJIora90pI00yBVTJwuF7e7ebXlM+Me5FQxFoyqIf0VRtl9Qi19H3SCa
        vpYjgYQdjSa8C1sVboZqseomTPcUf/IqlribDhE=
X-Google-Smtp-Source: AGRyM1thJcc6VzDaeaE+EySViKuCRpu348iS7jC1QI3PpaFzkcmRpNMn9JsAnkR2MfsFuw188nD7QnVuUJohoFdGXiU=
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id
 p29-20020a056402501d00b00437e000a898mr2923947eda.265.1659090892398; Fri, 29
 Jul 2022 03:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
 <CAHp75Vf85_uzA9fRxTizbPJxODcXFpM4wuU6DxP2j9UA47B_2g@mail.gmail.com> <CA+hk2fYcw0szJ7bBvfEjtyUE_Z61_A1vFWmPSdhe-gmd5jbC6g@mail.gmail.com>
In-Reply-To: <CA+hk2fYcw0szJ7bBvfEjtyUE_Z61_A1vFWmPSdhe-gmd5jbC6g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 12:34:14 +0200
Message-ID: <CAHp75VctFBkPYumu-4+iGNATt=zE7HJ3n0kRSdDduJZ=h6FDEQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
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
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 8:17 AM szuni chen <szunichen@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=8825=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:51=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrot=
e:
> > >
> > > From: Alice Chen <alice_chen@richtek.com>

...

> > > Signed-off-by: Alice Chen <alice_chen@richtek.com>
> >
> > This SoB chain is wrong. Prioritize and read Submitting Patches!
>
> After reading the Submitted Patches,
> ChiaEn Wu wasn't involved in the development but he submitted the patch,
> So, ChiaEn Wu <chiaen_wu@richtek.com> should be the last SoB, right?

Right. Submitter's SoB is the last SoB in the chain.

> I will revise SoB to
>
> Signed-off-by: SzuNi Chen <alice_chen@richtek.com>

Not sure I understand the SzuNi <--> Alice transformation...

> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>
> If there is anything else I need to fix, please let me know. Thank you.

--=20
With Best Regards,
Andy Shevchenko
