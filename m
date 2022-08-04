Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B66589D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiHDOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiHDOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:01:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20E1C128;
        Thu,  4 Aug 2022 07:01:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a9so18139695lfm.12;
        Thu, 04 Aug 2022 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JaMe6j4fYY9HfpaAc4kq+NXQn/JQWze+bei2ZzmND0I=;
        b=QSKMyIcYM/epVOjE3xPWm4g7Fax7lyHTwJQV6QgjlHcsv/cO9qjGpwNheGqSJgDhfx
         emrqTQFK2mDSQ4NpoATQJCLyuB2zWwcio2s5WMthC2HEW4OqjfATYWffLDBA8Z5QtKkZ
         EdrQwKuI1Rigsooo83kdn/f1PCIPbrD2BeU9N0Ide6iYB/yq/yopo5SIbE4Bzvo2NpxE
         8pavzD0D8zzoVWA1GgymHDDf+Lv4icd/sdUYt/dTojG8d5rqwxgNhQtDboOQP+0F3yy1
         vW6yfJMOZl/AXpGWD0W9//zTRIQ+q+NfA0h4Ybvt7EaW+eLXglfH6Vb3cto0ZC1/rGyw
         T/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JaMe6j4fYY9HfpaAc4kq+NXQn/JQWze+bei2ZzmND0I=;
        b=U4EhkMyn/NpqG3NKFpACQtE5Usb5SPIK/ICMSr4meFQxUuAA/p9R8Lgsf+vTF0Pbok
         q3F2P4uZbep8NP14lCW2EOx/Jc/PafM4bPdIcuNde1+Ub8UgAhm4pNvQJnYWcKJiQQ1J
         8EzTSwgrq7GAHxe1PBnyc/EcAXZjoQ+4Opb7EmH3mumf067gSl0ylCFrT+kVNBdWhAsX
         hCqKaskt7hu8xOfbEex38hgBXWWf+UJWIjhQwIx8/EhcmxoFsS3YcQvZrf8g0IjOub2J
         J2O9r/sJpjpe1yxWe01cn59Cp9NC7WKQfqUJn54TsiwOjjDMkLluxuxADciaT9nKNaMa
         U00g==
X-Gm-Message-State: ACgBeo0O6nFMuwWooNnrPrAq7SvBrHzoJKQIOKPIsLz5Ad/6UK2uLJw+
        FsCsPa8KKauXlmYUxX66+52QdlzHCJgHFlJhMVw=
X-Google-Smtp-Source: AA6agR65paGn+KC3Fe8XeawVhkTkP00otnvSfxoWcwCf52HbrAmRlzdXLDzIJw4f2/h6gbNdmVYU9iaaEEjx63FHNO4=
X-Received: by 2002:a05:6512:692:b0:48a:f5fb:188c with SMTP id
 t18-20020a056512069200b0048af5fb188cmr816276lfe.111.1659621702117; Thu, 04
 Aug 2022 07:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com>
 <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
 <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
 <20220723030226.8E43CC341C6@smtp.kernel.org> <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com>
 <20220729225603.12528C433D6@smtp.kernel.org>
In-Reply-To: <20220729225603.12528C433D6@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 4 Aug 2022 17:01:30 +0300
Message-ID: <CAP6Zq1hOxG+2X-qTbvPkrVHQ5zf04GO21m1n328Jiqgzns2CMA@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2022 at 01:56, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-07-24 02:06:54)
> > On Sat, 23 Jul 2022 at 06:02, Stephen Boyd <sboyd@kernel.org> wrote:
> > > Furthermore, in DT, reg properties aren't supposed to overlap. When that
> > > happens it usually indicates the DT is being written to describe driver
> > > structure instead of the IP blocks that are delivered by the hardware
> > > engineer. In this case it sounds like a combined clk and reset IP block
> > > because they piled all the SoC glue stuff into a register range. Are
> > > there more features in this IO range?
> >
> > No, this range only combined the reset and clock together, but it
> > combined in a way that we cannot split it to two or even three
> > different registers...
>
> Because it is jumbled in some range?
Yes.
>
> >
> > I do see a way to combine the clock and the reset driver, the NPCM
> > reset driver is serving other NPCM BMC's.
> > Should we use regmap to handle the clock registers instead of ioremap?
>
> Sure? Using regmap or not looks like a parallel discussion. How does it
> help use platform APIs?
I mean to use regmap API instead of platform API for handing the clock
and reset registers.
the regmap API gives only one user access to R/W (lock).
I will be happy to get more suggestions, on how should we solve this situation.

Thanks,

Tomer
