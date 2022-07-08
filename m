Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E056BB19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiGHNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGHNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:45:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28996237D7;
        Fri,  8 Jul 2022 06:45:49 -0700 (PDT)
Received: from mail-oo1-f42.google.com ([209.85.161.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5xDJ-1oCpNP0p1H-007Sud; Fri, 08 Jul 2022 15:45:48 +0200
Received: by mail-oo1-f42.google.com with SMTP id n11-20020a4ad12b000000b00425b01c3326so4030431oor.8;
        Fri, 08 Jul 2022 06:45:47 -0700 (PDT)
X-Gm-Message-State: AJIora/NkYcFzv3biE/No2vIDOOovKULoW3sHuFORcS70u6rD/tcQxwD
        WHvv0luOX90EwN8N1eFlEGwsMCDJ4RxlvhapwXE=
X-Google-Smtp-Source: AGRyM1vy4rbxR1Ytn0Zk8NhNJ9KORyOPGe3ZQtW5xW3Of3raZdxBwA3+N0Uu+YK+RloM8boTybyN5UBcBgQVHJwdeE0=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr3516820ybr.106.1657287935403; Fri, 08
 Jul 2022 06:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220706165406.117349-1-tmaimon77@gmail.com> <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
In-Reply-To: <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Jul 2022 15:45:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com>
Message-ID: <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Joel Stanley <joel@jms.id.au>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Qin Jian <qinjian@cqplus1.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:p60fzRZH6lXRcjLjsToh4E1dS5TOvz9nhqrmXYCRlR7go2qMZu4
 Al1+phUcp+UEblx0TNia+VpZ4BLL7cAU4JntVEikn1/mZJU/GX7vB8fMZJ7iYaOHyLuMz/x
 v/4jUzEmJYh3evJyJWk9Nb3HgrSlCvNPxcdcM53ZGG5VL8b9T/dGJmue9B5B+swz3KBnBsO
 O6lbHITMeKW9cQvi7Cr9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WmPl8rkq1kE=:fiJt4rwFRraSb7IQg6gC+r
 PUrDoHeJD6QSQo2lMYkl31KUSL18tnsEUT+YDsrrsO2g9pDzekoZz4QZMOlGIzs8ZJeyBPdBY
 2Ix5249rUjt9CMvN5pSIgea1jcOQz+xoJNGXjPyNEFbfVeo+GpTvD6LbTF94M6OB2zHV07tYs
 XoXK9wU+gogG1nQuu6aveipUAZTWShwJmU/wWbB1W4ea672X4LM1VghzccWc5xZ3A7SbpWAqH
 89ck8OaNmH8ENc3ciAV8DVwd3/q9zXwSr1f747kLq4fY1SuTlLyqA9omhuNqLDFsBYcpeggOa
 RXHv4U0Ks79Vz2sopK41/3bd2+9HjVolj40aCWfKx3na1bmT9an7BX4DtbDIt29+n4t+DVMLW
 jv5XCpEqH3Y0wN5FQNR8MVutmkjXj5w0SWXpJvOCoBFl8Fu4O7SSu8mV0gCC0rdH7cTt3Vf5n
 AlTYSAbD0GzmMll2foy9vwfIT3h/c6ypTV1jiZgCrmF0N32K49sQ6uPDTQ7Xx4JUwHlXvS7EM
 e7l1iMD6l4Vnt52QvG9ZzNn9x/E8hsq9SVR93PrbE+iOhaZXKe2asQ+IDgATgh6lPFCopq9IW
 z9I7yt2P3GfqPSO3k/IqnwFNnbZKXSGgZMi7s7W36YruHe3PYxZuHCjSdAiuEp14uDnb/eSfp
 PolNTm7i+Bw29cRvlSwyeXbHPcQ1vVReVjjsJuuQskxRRXWPHDBIm8I1rUAMFEwfKIR1CH3c4
 UhuEnPD88k1BbDVVHhKw4UQBHb0h3ujAdRi82WPFZQNHTpAboi4fpA587Zhlxr7/A0epC77mN
 dBB7/FPuoSRda3v6xLht9mR2WepSSZcCL2r0ZYIryn3z01owlQu2skj8+BpcZOL6U9mA2+cjA
 fmcQPV9DfAzIDexPD0mA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 8:50 AM Joel Stanley <joel@jms.id.au> wrote:
>
> Hi Arnd,
>
> On Wed, 6 Jul 2022 at 16:54, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > This patchset  adds initial support for the Nuvoton
> > Arbel NPCM8XX Board Management controller (BMC) SoC family.
>
> Are you happy with a cross tree new soc branch for this series? If so
> I can put them in a branch and get some build coverage before sending
> them out.
>
> (I notice the clock and reset changes are waiting on acks still)
>

Hi Joel,

Yes, I think we should merge the parts that are reviewed already, but I'd
leave out the clk (4/16) and reset (9/16) patches in this case.

Krzysztof has reviewed the binding changes, so I don't mind having
the DT nodes added in the soc tree even if the two drivers are still
missing.

I would do the same thing for the sunplus SP7021 platform that
Qin Jian has been posting, as this is also waiting for a final Ack
on the clk driver.

I would put both of the new platforms into a single branch in the
SoC tree, separate from the usual dt/drivers/soc/defconfig
branches. I was already planning to pick npcm8xx up myself,
but if you can do a pull request, that would be even better.

       Arnd
