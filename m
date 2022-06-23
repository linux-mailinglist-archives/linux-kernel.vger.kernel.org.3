Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72E557D92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiFWOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFWOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:10:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737142489;
        Thu, 23 Jun 2022 07:10:45 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdeX1-1nVaxG2n7R-00ZdrX; Thu, 23 Jun 2022 16:10:44 +0200
Received: by mail-yb1-f178.google.com with SMTP id 15so563770ybc.2;
        Thu, 23 Jun 2022 07:10:43 -0700 (PDT)
X-Gm-Message-State: AJIora8XmMVdOKlVWYkg79a3UTF1bbFPsdtAxQDfmmHObHI/gi1+nO7v
        KZKaKM8So0wxCCUThBfbVM8QS5zLF+S51tbYWfo=
X-Google-Smtp-Source: AGRyM1vu2ZSkm/Pt+nGXc9raGKFWpG1R93fwwvTgqs7o3h5sgHq5bTE/W+B1nhlaeEKf3D0HrCeaA49AGPTGXH8OIc4=
X-Received: by 2002:a81:b93:0:b0:317:791f:3c0 with SMTP id 141-20020a810b93000000b00317791f03c0mr10368978ywl.42.1655993431168;
 Thu, 23 Jun 2022 07:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220622132302.267010-1-tmaimon77@gmail.com> <20220622132302.267010-3-tmaimon77@gmail.com>
In-Reply-To: <20220622132302.267010-3-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 16:10:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Q-NyfDYPurvK9FFbNn08bGvuxXpGSry5=kRsfu2BZbA@mail.gmail.com>
Message-ID: <CAK8P3a3Q-NyfDYPurvK9FFbNn08bGvuxXpGSry5=kRsfu2BZbA@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] clocksource: timer-npcm7xx: Add NPCM845 timer support
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
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:y0GPzKr6X2XmJyLU3cWjFZMaH/zxwAK48Jv57Sgl952+TB+5N+j
 ESrSdNlZ8YFnMhkk4Or5Zp3SPBzc+frjDTDNJ5Q7AldkJS9Y3XznXGmxVai3V7Fi5GbLPQ9
 HRdaLTCS5y1IVo1fispDq+lqk21agZBqzxF7CgFl6JfJE354J8YFIN9LuuGLyBzWl1euw6I
 id5zOhZJ55Sa1OndBvUMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BgDnWiH/xJo=:nr3qgtQFvi35DjnOhogLVX
 AefwCcJHkKobfF6n2DDo4RmhwOYEDMx8v1MHW66C2HPgOg3u80e51TyLopXZ37TBKZkOwJmUe
 Y9EF2OLucFZNM7a+l6/BzpzH2D27ySosjAQ6tWCbLExqt0GJz5w1m6GkSHEDdRLd/m0eNRx6A
 iwnoFXxSX+vg4WhQ3HdKKOCZKET9LvLIAInB4y21IYKNermO7pZ8cYCj/ZF2WJyq5gczG6/YG
 NW84gOaJfKigg32Wn6tdVGO8tNRQQeWM1Zg+pH3d62bhf/643ZBcZQuS2QlJT347dLEPivX64
 +WNXNzcR9xQtpgx0IsIKLscI7cfj3qdEHjT1rhD6mkg28psGgNdOIK1cBOElHNhK/SKQB4P2t
 w2kEHORTnys3F2PZkAmoaRdH+NTa8a9Tkz9OgcMkov1HFbpGcNzydKMAFxNfazyefdMmZCyaM
 riKtfcKunuFabmYHFcfWey3RaPQMzn477wT7yp/vl3kWGAjWaDbvDa5Rv3D/SSSHcfUAPYtEN
 LnEk0d2hlclH+pQ3FNmKtE7+e+RdAR9qOcMy6amxkhXSYoAPu/nRx/aJ7Jz1nvTI1CbVOWFCM
 tD5jwBlWps7MzGbi3n0uCQ38Y/m9BbCQDxLqvTIRu6y2EH7ywj42nicdD1rSIkZlUyqSGHE31
 FjfNkxMI1X7Dn4aVCKPCTVpTG3ESgZDf4MvThyEGcaNKGNQZQTn+l05AUxnlyqlRMoN+1IqVW
 /4H5/nDrwdgr1alhqDP8PpbvCfVGnEGy4KIZHBUUAhEgNDKNHK4jhiu4+L1iCIRQ0ooBRfDQG
 ei3gJ45rCyayyQcPdm2UJrzBkl3ou3hlSqBR1ne9uZ3SV7EV6yQNj5QWQjMuEE9H+C6rtLonN
 GvFKrX5maGYhiWL5F0cbfl9jhTkN0rAN7wscjfkdo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 3:22 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton BMC NPCM845 timer support, The NPCM845 uses the same timer
> controller as the NPCM750.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

I think I've commented on this before: if the timer is the same, you should not
need any changes to the timer driver, just mark the device node as compatible
with the older model (as well as its own string) in its "compatible"
property and
drop this patch.

        Arnd
