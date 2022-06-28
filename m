Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA99F55E202
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbiF1LzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343940AbiF1LzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:55:10 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A5231226;
        Tue, 28 Jun 2022 04:55:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v38so11079207ybi.3;
        Tue, 28 Jun 2022 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WRlzJEXIDSC/xppUDMk3dCziyjCMe9bw9g7ZjtMlNWc=;
        b=CmaAQlqVxTtwAwTMBcNHdcD5nQ8/1n9uY6sAAnGoXMm/bskTVcJe0doxfjfSuV4DDM
         ycJrmTEU7M9ompmrsazJrcgK8CBOlHlKxkeOt5AKb7PaHVBJ5BdmBtpKhaL/omLeJwKd
         z8KIWABeC7iqGcV8umJupiQ+jv33fn1pYiubviGcSU1JMg/YFdU/oLBYxHNEyLAXNJ7q
         CXrLCTZFp+lpvSdjP1qxtjhI+7PnKczCA1dk/JaN/g81TGDN+1OIJ68dTwZdWHARiZdv
         fb/ZpWPoCUVwTZnMjHEKZ783H7+4wqhvDfhyEwNsJoST3WRImOzRQCQJwalBEqCZd6jE
         Fw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WRlzJEXIDSC/xppUDMk3dCziyjCMe9bw9g7ZjtMlNWc=;
        b=uy4wvz79Tm84dcJWhFXmGVMWG3aMy/lWXWqDMeCC7azirRmST898+upZORTrLTSfoG
         uag13K8xH/jN4yQa7YDWvlTJ4TPElORScRuAnJvMSiBNov6Fp3WUy3njpanDLEwbzls6
         DGbNmAbuGwbGeluCSXOfTM5Hq83HVw6FonDaNLLYBBhvEMzcs4SsRRLao4npyHvyZk/i
         QuZFG2R63OXd7xk/xCVPhiBBnhJ1yR5mNncBD+cdZWNxkMclTf4qp0PVKnoqVromDjyg
         xwyDcO601KwQ10sbjKZC2J9gX5qZhAR0SGQQfWWsRybgLUrRkURy541XlikEWm2PYQLI
         w5vQ==
X-Gm-Message-State: AJIora81eq/M4RNup2j+OfmluLaj+TnwTsJAFSZC2m0R5RvHjPkOea53
        aykXBdW9dWRM0nTr3r8pN4sne0thZ++JLFYb8e8=
X-Google-Smtp-Source: AGRyM1uykJWizq1yWSU8bYm0BHbWS+35APefPp+3MlNtqzzo6MB05yQElDVVW/E20r0RIxop4VWi/8sWSqknbKaV00s=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr20612051ybg.296.1656417309029; Tue, 28
 Jun 2022 04:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-10-peterwu.pub@gmail.com>
 <CAHp75VdgxR9aFQmi_MPrX=t7RMnKDiLAwWMvxbpW9OoQMJkKyw@mail.gmail.com> <CABtFH5+YLpYdWNsy1DwkKf19L6THo5NYvQ8e3rpo9wkTS9HxwQ@mail.gmail.com>
In-Reply-To: <CABtFH5+YLpYdWNsy1DwkKf19L6THo5NYvQ8e3rpo9wkTS9HxwQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:54:31 +0200
Message-ID: <CAHp75Vccc3xx29DQUMdwEfPz4k3Zwn=T5g24KAzEw4Y8KOp62A@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] regulator: mt6370: Add mt6370 DisplayBias and
 VibLDO support
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

On Fri, Jun 24, 2022 at 12:33 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=
=9C=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A82:19=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Thu, Jun 23, 2022 at 2:00 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:

...

> We got a notification from Mark telling us that this patch has been
> applied to git.
> ( https://lore.kernel.org/linux-arm-kernel/165599931844.321775.8085559092=
337130067.b4-ty@kernel.org/
> )
> So, should we need to make any other changes in the next submission?

You may do the followup(s) to address all or some of the comments
depending on the case (e.g. good to clean up code with dev_err_probe()
use).

--=20
With Best Regards,
Andy Shevchenko
