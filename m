Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC3584B93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiG2GR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiG2GRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:17:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49822BEC;
        Thu, 28 Jul 2022 23:17:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f7so4038983pjp.0;
        Thu, 28 Jul 2022 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EW499GBzYHaTH/WArZ0WtZvIkRlpsncxTw1RlPqz+v8=;
        b=bBJrwZNNbNwZOSdpiHnZjxTBlhq5e5F5z/aB01/7Rhm7XVlQWB/jv1YB3Yg3stPpPN
         SmPojYXgxob/8myvBqE/AYKB3hUIDzGgtgzp4td+2Rutu5SZSMSBz+TEPl7HNs7Bb9MW
         W7TCxTINNO2IXJYHAUFDEo60ceS/hW+jhm95xlptfVEjnS/+i/uxEzpBJqVXlteEWYKP
         MLSVJZ2NRzFuZR5K2IulKBp8EOOR/C3KOurSc/13nA+jBRKeS6G6Ni3gVaAmjbINYeTP
         Y/exdADOpBiQOL0wbDkY7ixd3HtrsRWGX3QW7Rcr/xwq05d0Ejbdfk37De6Lis+ytz3+
         Mzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EW499GBzYHaTH/WArZ0WtZvIkRlpsncxTw1RlPqz+v8=;
        b=cPmxhGU7MgqV4EBa4XWT5LuS360COaAYZ6cDzOzjw8SmwjaJ1rTeBi3L+mFbxZE6vS
         DZZBOxxfbSv13xQrsElyP7O1Ee8NmkOjgT+KiyavRF84YVFLxHPqwX0oNdyCBIG7wcQP
         4HXBZy/2TPS+Uk1Ml+ct/Snyc/3TJ9F8rJQifEr6WKMhhGqucrFEkMt36QSE4PzbQPn0
         y9iYeBZtcA4w+D7ztS40tlnNGpTEbDTctwEXrisw9PDPucuw10AUC2P6TFhs+JzvOX47
         nd2s87rEcXApCbW+oQd16cUPfixPX7jNKY6LS7gQHVbb5Ul/+HuTO5IeEu67SDSfXrHd
         ggJQ==
X-Gm-Message-State: ACgBeo17wSnN1z33QLUnK4eooIxonOjnmRpB2YaxDgyDCEzcj0SBt3Qc
        9lTKE01qpSBls2DN+3OTgBcrpewOZyFK1U10NVc=
X-Google-Smtp-Source: AA6agR5CfpBYT1/n0Fz3b0mpL30Y1BQpcR5ZJ1q53vOkI+o8r7h1QJKT9bGnP/JXhqgwA8TQcF5sWeEJfeZ5+jaoGc0=
X-Received: by 2002:a17:902:f646:b0:168:e2da:8931 with SMTP id
 m6-20020a170902f64600b00168e2da8931mr2450692plg.84.1659075444381; Thu, 28 Jul
 2022 23:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
 <CAHp75Vf85_uzA9fRxTizbPJxODcXFpM4wuU6DxP2j9UA47B_2g@mail.gmail.com>
In-Reply-To: <CAHp75Vf85_uzA9fRxTizbPJxODcXFpM4wuU6DxP2j9UA47B_2g@mail.gmail.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Fri, 29 Jul 2022 14:17:13 +0800
Message-ID: <CA+hk2fYcw0szJ7bBvfEjtyUE_Z61_A1vFWmPSdhe-gmd5jbC6g@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=8825=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: Alice Chen <alice_chen@richtek.com>
> >
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> > LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> >
> > The Flash LED in MT6370 has 2 channels and support torch/strobe mode.
> > Add the support of MT6370 FLASH LED.
> >
> > Signed-off-by: Alice Chen <alice_chen@richtek.com>
>
> This SoB chain is wrong. Prioritize and read Submitting Patches!
>
Hi Andy,

After reading the Submitted Patches,
ChiaEn Wu wasn't involved in the development but he submitted the patch,
So, ChiaEn Wu <chiaen_wu@richtek.com> should be the last SoB, right?
I will revise SoB to

Signed-off-by: SzuNi Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

If there is anything else I need to fix, please let me know. Thank you.


Best Regards,
Szuni Chen
