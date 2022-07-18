Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37F25780B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGRL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGRL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:28:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906CBBC8;
        Mon, 18 Jul 2022 04:28:48 -0700 (PDT)
Received: from mail-oa1-f44.google.com ([209.85.160.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAwTn-1oOAQJ1woj-00BMGZ; Mon, 18 Jul 2022 13:28:46 +0200
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-10cf9f5b500so21665761fac.2;
        Mon, 18 Jul 2022 04:28:45 -0700 (PDT)
X-Gm-Message-State: AJIora+1kOmEFp0hCdR7rq47pEbVX6oqifTqPII4Ojrdwr75YRgOKKnK
        yL8lVkfEiAjdFUCctd6KiAA6k4iA5Hn4z9j8Sfc=
X-Google-Smtp-Source: AGRyM1u3T7s1p1tMCI3Ux3IMuwbe7i4DiTt+21krVOs89HFUCcgbDFyHfQD+kzZHPRaiPmpi1WSRcKQJW4jBIRjM+80=
X-Received: by 2002:a05:6870:6114:b0:10c:6bf:542f with SMTP id
 s20-20020a056870611400b0010c06bf542fmr16739255oae.188.1658143714477; Mon, 18
 Jul 2022 04:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220706165406.117349-1-tmaimon77@gmail.com> <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
 <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com>
In-Reply-To: <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 13:28:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Dh+wTyPYhvv5c-wsqMK24ZgqPWHw2C7xuFh9vL53XfA@mail.gmail.com>
Message-ID: <CAK8P3a3Dh+wTyPYhvv5c-wsqMK24ZgqPWHw2C7xuFh9vL53XfA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>, Tomer Maimon <tmaimon77@gmail.com>,
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
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
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
X-Provags-ID: V03:K1:ITCj9jon9+Jp0REjUl6uAP1CUdHTMKxA/CgVnRkDtI74FZ0km2X
 7Gd6SqGUe3J3iNADoY0hW0P2zk8G5cON3x2kTLPrK+kjeZRyY2F7o6apIR+JVIMklq7zvrC
 yc7s6Ua6xQFiiey9ePv5hI0NzGX3ZlsJn+J9s2lAmuKrjS77OtEV9dHSuyTK6FqElD/oggZ
 aImj7Ji6UYxdllBIhZjPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/VcfA3LNdA=:QY0sx+6BapAmnf5H7fYpQE
 bCaqxilwfUEUat/UsAoBozWpZ9ThUeEy2z/JWBWlMRRtsfKZOrhFXuQEn1JdBLud39kxqjiRo
 hdMpvEhr7cDBUEctRiYN2htOB8gX+ePNmPFFo7cue1G6f6cxeStV1JdHKtCLpdJR0yXspSU+w
 Bqa/t/1/7ut5WcSxT0Fk5JOJRO27H/abQfQy0R3mtkwD1mhPoM369NKcSTQLaxvFChldzcM2S
 ZrswhYIf5BGiqQH6LOmsq9XcPH6a2uqnlqhuwMRG4FwKekavEkg2qrJCnfdlLdGBi7swGshfB
 4AgQt9BVqxNH+trKV/sfnI+/jZ5yTivr/Mbj6NgQ8M9rV9tNmjicsBCL7hxtH+EI3tQUv7Clo
 J99XQSi0blLnM1frs4N5Hrp0EYcJULJV4+JHFNn95zOng7dY6YEhD9Q35Yi6TBNAokRPeHjq2
 /9vE+p87m5+N8mUlhXt7YvTNw9rfvyEaaKaUZfP7ZkexP+aDRD4HxHCFkpYF9BcBpVCBqN/oS
 tlT8jzYMaq+L1SDnj1ySHJVZ5zT+0p24ZfpZgk2lGBKceSIgJBLNp4x23tCuXtk8z1KShy9Zs
 6JbwmEyFPau/EGZS4jfXC8sAkjAyuhctSzWefL1W2qc2DsD4CQ0v2JSju7NbHpRbQTkBRU2Jh
 0t2RY1ui82O+fgh//MInL7xVfpHccrJJZz85ooWuuxAD3q89DmqKiFqF3LWAIhhdLYSkNivJV
 KD6PwoNwdlzL/d77gYXDPgspEmj5DeDVUkbe6/unzVSmyIiaG/bybfbf2B8Ic4PSPe67OoO4p
 9y6ZEp3J9eFXkSJWzjkFlJDEPkk8ua7ipO0M27ER79paJ3aYilEj1XXjWbtzsn4Gnh1kgcmFQ
 r2Quf8dE3mUyFpA9Xt1g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 3:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 8, 2022 at 8:50 AM Joel Stanley <joel@jms.id.au> wrote:
> > Are you happy with a cross tree new soc branch for this series? If so
> > I can put them in a branch and get some build coverage before sending
> > them out.
> >
> > (I notice the clock and reset changes are waiting on acks still)
>
> Yes, I think we should merge the parts that are reviewed already, but I'd
> leave out the clk (4/16) and reset (9/16) patches in this case.
>
> Krzysztof has reviewed the binding changes, so I don't mind having
> the DT nodes added in the soc tree even if the two drivers are still
> missing.
>
> I would do the same thing for the sunplus SP7021 platform that
> Qin Jian has been posting, as this is also waiting for a final Ack
> on the clk driver.
>
> I would put both of the new platforms into a single branch in the
> SoC tree, separate from the usual dt/drivers/soc/defconfig
> branches. I was already planning to pick npcm8xx up myself,
> but if you can do a pull request, that would be even better.

I see there is now a v9 of the series, let me know if I should
apply some or all of those, or if I should wait for a pull request
from you.

I've just merged the Sunplus sp7021 support leaving out the
clock driver in order to make progress on that one, and
we can do the same thing here if there is still ongoing discussion
about some of the drivers. It would be nice to not wait too long
though, as we are already past -rc7.

      Arnd
