Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59EB54567D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiFIVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiFIVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:30:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFFC275CA;
        Thu,  9 Jun 2022 14:30:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e4so11655756ljl.1;
        Thu, 09 Jun 2022 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+X+hSIuCzgb8u3X3IIj+QVdVBieGi/ipj8I6jv9SVfY=;
        b=B4bFqZL2CFXTVG65Kz0IqAXblvU1uNDsCXYYpuzfx1D5eO5g0YyV8oxSP+CTkFeAxg
         +o3zKeoEXNFtcDF06q8xKFOo8z8Lg8U5p05ABDhuqlI0FVi4WnRp/QGvGbTGtGj462US
         Xx5ipxShzEpkP6bB+Zr+KkHL7krh9oQ9GAwDK9XRCfiSbicM38pWplW01BzJul0ucuLo
         jchhM/mrewHi25ZTBaa0EXHdpo8zRGfMYTfycwA2E5gUkqPuIghN3XQs9ZSJObms6G7C
         LYss1PaXLrm3eWaWLazjfTpHrCiCslpQ2HlMvMIw9KZiWQTAXeEBWgAbO+J2h30XLlAb
         Ks1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+X+hSIuCzgb8u3X3IIj+QVdVBieGi/ipj8I6jv9SVfY=;
        b=6lAok4+/xxsnYto54fYYuD4sh/11lIv/xGmrZTej2U42LbvJ5vE4Tc3M5+ACVYGKt0
         5RZ6wmlbRaQzo7Njh2D/eeA0LdgOsQeOJIBrwT36iMXVGRuhj0lA7amW+mi4FLry/Zpj
         jWk95t7SjwWUo1yXXBi7mQsk4NNK+ICYLfFn3BmNFDTvMo70Kuk6Vz6xNSziLX3JOKFR
         W0V8MW/sGzX3OM5ktcNB5XF0kVTt+7qXBDGVo/U3yOHcpNk/UScwwX30gtW27MvmjWT9
         XRNansaHfxulTHqUMkotxKCrp6UXA9V0wwStrcHGZoo73w2ndrTPPOfqO4y7AQiTlX0p
         BgVA==
X-Gm-Message-State: AOAM532Cp5T1PF7A0O56F/SaIcFG0Hlb/IM4qX63TMaJHMSliYRyjEFZ
        Zse7u7T/mouP+PH2omqdgTDck2BGxCIVFLktHmY=
X-Google-Smtp-Source: ABdhPJx3Z43TlI2Ag+K2FOcYIRBYxKYFJQGfTFWGDMiLNnCYfvvQ3Bzq0zYKxXQcHgs3RO+qXVgPYOxFY8+5yf5sEGs=
X-Received: by 2002:a2e:81ca:0:b0:255:78c0:cb21 with SMTP id
 s10-20020a2e81ca000000b0025578c0cb21mr20226995ljg.240.1654810252988; Thu, 09
 Jun 2022 14:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-11-tmaimon77@gmail.com>
 <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org>
In-Reply-To: <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 00:30:42 +0300
Message-ID: <CAP6Zq1iCJO3AzHnG7RSQ1pyVwayxs+X3iVM4U=6j2k0EgR7psg@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
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

Thanks for your comments

On Wed, 8 Jun 2022 at 13:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Add nuvoton,sysgcr syscon property to the reset
> > node to handle the general control registers.
>
> Wrong wrapping.
it will be very helpful if you could point me what wrong wrapped in
the commit message, is it the explanation or the header? or something
else?
>
> Best regards,
> Krzysztof

Best regards,

Tomer
