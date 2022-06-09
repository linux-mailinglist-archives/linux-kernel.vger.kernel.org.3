Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426B545675
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiFIV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFIVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:25:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7853A81CB;
        Thu,  9 Jun 2022 14:25:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a15so39918743lfb.9;
        Thu, 09 Jun 2022 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4IZraFzH/fc6lguBHVeQeCPbmXku16+PH5/TRbu+AM=;
        b=RC47ywgyo1TUXdMXpXkEo4vFFCEao/sI6jAzruyxLD19u09a1EJrPhapVX7rMJwvIE
         2JjmWbt4OmEY9BGEswVtb4AtdCjU/GOyyGmbIgsP0xukLXu1XCTTRg0sALm9n+FNeS3b
         7+APoxeJULphUZLfr+xFbY0dKHtBP9mxcC1J+zU5E4wg7r2fKsPUlsWV+H+L9+LVU9or
         2xw80B10e61BnvjuDcUd/dszHkVGA5hPFDdZqE6e6S+Lr1wWBVaJ/UI0XtZ/IRnSWr5y
         +Oa9AxXvGW1lNdtjpbLn0PDWGkXm6Skfk+zIv1QLrJQ+01lHSmbHQFEFnm07pOzF+MA/
         bN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4IZraFzH/fc6lguBHVeQeCPbmXku16+PH5/TRbu+AM=;
        b=sGsvpQNCCDwbgDxFsuhEFQF61zsifGUBADB4MAdIMzWBH8u3crLaaJeCM/7MZK32qx
         oIXQQtZNIGUMcbrUdcIaE6vtbzTL5nyMHubrg/57JVmMIYaoSwFfkqEz/khJ8b+bmSXk
         JZknxW6Gc3SQghvVqnTpSAr4JZ4iLmLeSdssXQIXtev8wVrOdyn0oo+dzBsBU0ALL4e9
         4Lu7lXo2yBN0SUeLkSAIWckRyOn+Epuy4pzaBfUVPq6Cwr9poWcKGQVj1KTTGLHTpc+C
         +8S/NgNLyRsLDpJJhj/Rkf8BdSg5k8AlYv2R9Wje8FY0seN7+GUnA3MXBG27ZYycuxvV
         uV5g==
X-Gm-Message-State: AOAM532Vf5A4vE22pVkP1f4m6X5LlvdPKtpqYa2Vtvf0Vcd5GnaTtvdA
        OlMuy+x47D7lq25o5GxzpEfvJvmGKcFMeYI2Od4=
X-Google-Smtp-Source: ABdhPJz/ixQLlEnHwe0V/CFg8tjeFJsLlPv2eEsEGo7/F1gfd5wKnSDLJbBEv4KPXW6BnQHVl0H4l0HwB2DOY+rNRTg=
X-Received: by 2002:a05:6512:1052:b0:479:1f92:13b4 with SMTP id
 c18-20020a056512105200b004791f9213b4mr18761878lfb.200.1654809951471; Thu, 09
 Jun 2022 14:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-9-tmaimon77@gmail.com>
 <b06eb0bd-08b8-87b8-fdd7-4cad07d1fa89@linaro.org>
In-Reply-To: <b06eb0bd-08b8-87b8-fdd7-4cad07d1fa89@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 00:25:40 +0300
Message-ID: <CAP6Zq1iD-Sc5jv0GF-jiXFqB7aWs_jiuy8mTrVm4hmvP+LecRA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] dt-bindings: reset: modify to general NPCM name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Krzysztof,

Will revert the change in V3

On Wed, 8 Jun 2022 at 13:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Modify nuvoton,npcm750-reset specific name to
> > general NPCM file name, nuvoton,npcm-reset.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../{nuvoton,npcm750-reset.yaml => nuvoton,npcm-reset.yaml}     | 2 +-
>
>
> No. Name from the first compatible should be used.
>
> Best regards,
> Krzysztof

Thanks,

Tomer
