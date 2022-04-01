Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5554EF84E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbiDAQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbiDAQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:46:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8317538E;
        Fri,  1 Apr 2022 09:30:44 -0700 (PDT)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBV2f-1njMa5405P-00Cxum; Fri, 01 Apr 2022 18:30:42 +0200
Received: by mail-wr1-f48.google.com with SMTP id a1so4983431wrh.10;
        Fri, 01 Apr 2022 09:30:42 -0700 (PDT)
X-Gm-Message-State: AOAM530/9HCvGSlUlFqYsP/Q6kheaWgJR1MaN73BcwFIzrmh8Ju7Trkj
        2sRXtxRCppih6RA8YqHgfl2SYVs7TLrnAvMALkQ=
X-Google-Smtp-Source: ABdhPJwyW/9yDumqLlMXuT9IiGs4++GAwrVsH9ehz5Nj8vorMda1+nQReZXN9clMCgy38axwXXENGm/jEqa+upBHgYo=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr7945225wru.317.1648830642616; Fri, 01
 Apr 2022 09:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com> <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Apr 2022 18:30:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
Message-ID: <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:84PbHfFG5R9zbToAhkEPIpwjYnxkYlxV/K9XYUjBvXOtkiu+8FQ
 QXjcJOduBQgVN5KragQSgNoCXzJqn+s8Bi9Pp8D1mRrMbhKjyjg591UBXDMgaCbnAmDunKc
 F6jGbc0k0zK4Ixoqj76JeLfvtNwbjbBUkIhuIRWrA0K14fqdeVibUXQu6LhFWN8A6sHOMuh
 cTrEG3AETbYz2RZbN1tEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q9uoNhZXOGg=:1IsjX1XJhmT1vpiN/5tmJH
 kC54m8v8t3IlTw4yixztjjgyXmEEc9PLyCIbyXcwYQ8T9Pxt9QL7Xc3ALL2mB2t4LW3neROLY
 kcj5tivv+GW3w+Ru1yC6cGIr/u0zdeXOMJaVo0ibc8NB9O1dRt3x/IKFxk42U8rwMApqksBNj
 QlNNxxuRHkBwz6/X9Nx2xEw3+kkgLKAYqmpzbNpG1g+g2hVHDc+W/R51oeFIYL+nmdlnL57nl
 tMMTty/rpgl3N0QJTdZhr2+dxzIcrzdh9exEud5rTPMi2AiX0hPUXsxu5T1GU1lXBpagFO7CS
 yZi3YsktojyQ3fRyKriYJ3WDa4jpfN2AC1WR5PE7w3Tc9fSgbctIet6AKU5BLaK4UBnT1Aaus
 d9OVEL3jj0j1tszhUIzJKN2YZlrioS5pyxfhgLBnGU1SXCl3EXNHmRjKzhlpXW0A6zs3D+QNv
 UXyYhXqPTAOXhmlz0FvCKVoj3suxvWL2Deund07ubxIQmsGjDdq0qSR7WOaFDdGcc0NET0WPm
 2rQlMHAm3nHB4NzdTIIk++XaZAZO36wGS/RvDwBUPbrR512fGcHr865VF3OSRh9yANPoXy6OC
 HW93bQ9egkv5w/oeyF8sElTAmfN+gbpOGXDQiAv5I5tDoOWlDFJw/xtnPIPQ9BuA+uc/U+XDP
 rcw+TxD7+29bnsbsuc9kqYsBKEwG/3blSiK/zO+yjchDEw0azZ6dTVF5fM/v3H8sZwGk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:05 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> > I don't think you can do this, if you are using the syscon regmap, you go through the regmap indirection rather than accessing the mmio register by virtual address, and this may result in some extra code in your driver, and a little runtime overhead.
>
> > If you prefer to avoid that, you can go back to having the timer node as the parent, but without being a syscon. In this case, the watchdog would be handled in one of these ways:
>
> > a) a child device gets created from the clocksource driver and bound to the
>     watchdog driver, which then uses a private interface between the clocksource
>     and the watchdog to access the registers
>
> > b) the clocksource driver itself registers as a watchdog driver, without
>     having a separate driver module
>
> > One thing to consider is whether the register range here contains any registers that may be used in another driver, e.g. a second timer, a PWM, or a clk controller. If not, you are fairly free to pick any of these approaches.
>
> I will try to use the b) approach everything in that range is timer or watchdog related. There is a second timer however there are no plans on using that. Should the combined code still live inside the driver/timer directory or should it be moved to mfd?

I would put it into drivers/clocksource/, I don't think drivers/mtd
would be any better,
but there is a chance that the clocksource maintainers don't want to
have the watchdog
code in their tree.

        Arnd
