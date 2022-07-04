Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A655650F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGDJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiGDJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:32:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8BFE0C7;
        Mon,  4 Jul 2022 02:31:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so13070622pjl.5;
        Mon, 04 Jul 2022 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xIA0tkEJFCPwLmR+R6eKHNKrvI9a6bVM4TsihGfrld0=;
        b=f8MhiLRjvn4JhQhz9F64yCgS5B6jrH8tJwT1awj7AGv9RShuJdBVz84vc1kQVsx0Lv
         eNwaezjyn3nuI01xLjtA8+y0NZAqsqTswX489ZxWe/DK4qA3KOAt8JChBJylkfu6iBcj
         ORlmB+OW6RB+2+Vau8HlQetnTopYsjVTFjp0f9KRNoR/+YI371o5iIsodX7EUGlhLxKP
         kIepqqS2tlY+l7PfLRiLbmuc06ZAkcN8W3clHbhEfFPx2LGi5BU/JurrZIflfzIJK1dI
         KLvXaDm+sy2U5Xe0lntfK9VA1zVFQuJyC2Hbzq2cctn7nouM2bwK0yqcoPWSdeZyN5vE
         +/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xIA0tkEJFCPwLmR+R6eKHNKrvI9a6bVM4TsihGfrld0=;
        b=POMPhCymPAxgLj2H6m7adApMVcTrUWLx1gC5wWoSYnMk8y7f37BYaMomk10afoT4mg
         VvWRteExDmC6YL2pHc9YTYlaPZSrBAL8Ku456f5j2U16C6v1q8vs8h9SlOcF7eVCo9VQ
         otonsIoxN6lV0Is0xQpYoRAgzcMFjlmZAEdkzcnLW9sTtjAqoRWvP+VTSDUSsFjt6H5w
         khuhWdTW2ScsDwWGtolr2cIEP9YeCMPxo2aUSYmcZ1G3x1QlwP64PPRVowc+XgCXg6UN
         x1CYrcPKhqcPx5VaAsFPeL6fc3BQZb/7/nS0yUyEEilfHfkywXsIF8r8zIsqo2GQvS9l
         d61Q==
X-Gm-Message-State: AJIora+ywkXY3rglOW+A0MWGoerBEpEer7QEG6ser+wAjZxjmjxxKPfg
        fz3MvTmVktNpFh+dIjt/DF/1kEYY97iCmWGriEw=
X-Google-Smtp-Source: AGRyM1snqrRpQbd96zgAVBmjrPX1x2o3afFwTRTiOLpzM13U4eENpimphE3z0PHrUTRqdjm3Nu9HaCkQlEPGsPeCLlE=
X-Received: by 2002:a17:903:110c:b0:168:fa61:1440 with SMTP id
 n12-20020a170903110c00b00168fa611440mr34740455plh.149.1656927100855; Mon, 04
 Jul 2022 02:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-9-peterwu.pub@gmail.com>
 <YsKXcnys2Wa8Zz0p@kroah.com>
In-Reply-To: <YsKXcnys2Wa8Zz0p@kroah.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Mon, 4 Jul 2022 17:31:29 +0800
Message-ID: <CA+hk2fYA3phYAoh+BFr0ddy9MR8Ro1WCoqBpa1UK2StwMtLyfQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] usb: typec: tcpci_mt6370: Add Mediatek MT6370
 tcpci driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, chiaen_wu@richtek.com,
        alice_chen@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
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

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jul 04, 2022 at 01:38:56PM +0800, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add chip level mt6370 tcpci driver.
>
> What does this mean?  Please provide more information about the hardware
> being supported here so we know how to review this.

Dear Greg,

MediaTek MT6370 is a highly-integrated smart power management IC,
which includes a single cell Li-Ion/Li-Polymer switching battery charger,
a USB Type-C & Power Delivery (PD) controller, dual flash LED current sourc=
es,
a RGB LED driver, a backlight WLED driver, a display bias driver and a
general LDO for portable devices.

This driver is used for the Type-C & Power Delivery controller in
MediaTek MT6370 IC.

If we change the commit message to

"Add MediaTek MT6370 tcpci driver.
MediaTek MT6370 is a multi-functional IC that includes USB Type-C.
It works with Type-C Port Controller Manager to provide USB PD and USB
Type-C functionalities."

does this meet your requirements?
Or =E2=80=9CAdd tcpci driver for Mediatek MT6370 IC=E2=80=9D is enough?

Sincerely,
Alice Chen
