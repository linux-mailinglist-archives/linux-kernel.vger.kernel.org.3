Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F182543108
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiFHNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFHNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:08:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC3525BFA4;
        Wed,  8 Jun 2022 06:08:48 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXGSU-1oG2q01o7C-00YfIY; Wed, 08 Jun 2022 15:08:46 +0200
Received: by mail-yb1-f180.google.com with SMTP id w2so36420406ybi.7;
        Wed, 08 Jun 2022 06:08:45 -0700 (PDT)
X-Gm-Message-State: AOAM533ZETNMkz5kNb8uj6zF3dcDVXFL3w0SnsqoL3TDjybL+jWOeF73
        yX0rqwjJzK+rsy8o8/S3rrWnBo4D2FJMad+zVcs=
X-Google-Smtp-Source: ABdhPJyPAr6agm+ybv42a6+IQG9YtkbGrrN61pdQKlRReOgHwkoxQctAgFm4ahpz9ijG+yWaGNlDD7K9UznYhi7Yq18=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr34051688ybx.472.1654689712767; Wed, 08
 Jun 2022 05:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-6-tmaimon77@gmail.com>
In-Reply-To: <20220608095623.22327-6-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 14:01:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CNxijmy0AO6NEfg=hxQZn5WxgQij4JgkTjDTfZZSScA@mail.gmail.com>
Message-ID: <CAK8P3a2CNxijmy0AO6NEfg=hxQZn5WxgQij4JgkTjDTfZZSScA@mail.gmail.com>
Subject: Re: [PATCH v2 05/20] watchdog: npcm_wdt: Add NPCM845 watchdog support
To:     Tomer Maimon <tmaimon77@gmail.com>
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
        gregkh <gregkh@linuxfoundation.org>,
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
        robert.hancock@calian.com,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:huBQqQStfZDdfCBwbAntxePlQBHuJuWlkIZEOXlTP+7cMnlLO25
 QAMIlVpdSccZ+G82I6yJyjCmLa3Gor2QBmUiUbyGtKXR39UkX9fPoGaOd6/vDT8lnHbdvf4
 mSzK14ChIv50ilSFpQnhD7AswcFgckpo9rc2LK/sNviu9hIysCmaTop7LsDHvPNP/sJcg9P
 cdkVF8Dgnx7FPfPsrjZnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6qJE0q2QEA=:+coisMcRzU0apWjkEGabQB
 OXvLYzXe3ZFAsN4DYqYQ57hM7KO1LdLWX/fU46tcnZK28u844j3gs3dDH5QpHgV8UMfAYZbvE
 dlLzDMlp1y3i3k6Jg+UozDM2BfTm5uh2nZP/fiYY+5NeygDL8d6FMVKsmC6bep0FiamkDb4It
 lfvgx04Ol/eSVlnzLJH2INyccaCFugYJ2MBlgoBjQuqncmgtFccVfzQJAM51UJOVgjlEKF7nV
 NYy4Eva43/bkI3tZ8d6wA+tTyMVg4k15vGQiUTTLdc/OfjNIycoylysgio3xi3KQsHd3BXd06
 IAJZ8DqfHrOf727g7jyfIlVffJiq4glNRokD2Xa9gktgrcVkVEz25Uu8u0vqzRkJ4lN2C8QjF
 xzFmHQ+GAr+hPaC6B5SiwMKL6ryrACKuZ79slKebmc9oPU6pGYvqUOtqAg3epHB830q0ZTfMT
 S2GfXnq1e5uueX0NHHH347ulpsnyprWUbz7iFpNf1ZiBJtzuBOVsvvrkwBvAF/oPAUM/enIAQ
 EbLR545Y0F2f3uUA/ya/bHbdHxz9yY6fnvbSaU22H9BJYAyAbRZF0f77LNb0odlzyG0fJ8hCI
 eFFdwNLx7uRyhcrdhewGTthUYDcSucBB/5vr0zc2IqRP6N+MQ8J7SCOmQs0A6/v8gZILHy//x
 e/AGcsKdxjqKlElhU8P7KgkKh+1K3MU/e/4nn6irGFwAvWNzlL0b4QkcU+horeTvP1I1y8orB
 sxUNiJ/rX+6i9Siwjx6o3DMeWDZ7KkbJpp95KQ3euz1MxuqpbqZrZTomz+wHhH7zkpQottSau
 4Wu+Ulb2EgeHc75UyLlzGMVkwbs14x/J8OzRioWbhD0+aIp7IGeoAxlmQJAlCiBu5nzl58/1d
 Lq6egdyK1iDCGFoVrTm5ZV6DKjGEJRHfM2QeYYpeY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton BMC NPCM845 watchdog support.
> The NPCM845 uses the same watchdog as the NPCM750.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

This one should no longer be needed if the timers are compatible with the
old ones and correctly described in the DT.

      Arnd
