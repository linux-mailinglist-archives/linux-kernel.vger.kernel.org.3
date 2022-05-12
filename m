Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68891525035
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbiELOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354452AbiELOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:35:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9225D130;
        Thu, 12 May 2022 07:35:20 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJn8J-1nV91L1dyj-00K7ib; Thu, 12 May 2022 16:35:18 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2f16645872fso58979727b3.4;
        Thu, 12 May 2022 07:35:17 -0700 (PDT)
X-Gm-Message-State: AOAM531uf/IF/eWxzCferfvFQ6nIMHB2lfFsJRRwsc+S2dpF7nYzmX0X
        XxBk2ONLjbID075LmHgnLUw4L2odBO2eNk5CZp8=
X-Google-Smtp-Source: ABdhPJzfbhwoFr1q9juMntgIfHM+m3U1nWpSEbsdjudirAmgYnzjhj8eMLGYhy6XgarB5vhSiUly3q7lBnc1N2pSqgQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr331249ywk.209.1652366117032; Thu, 12
 May 2022 07:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220510032558.10304-1-ychuang3@nuvoton.com> <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
 <8be62b40-077a-7634-7d34-7776909a2abe@linaro.org>
In-Reply-To: <8be62b40-077a-7634-7d34-7776909a2abe@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 May 2022 16:35:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3=YD7WV+Www8pf+JTv14DwcnSjD+f=YFCNMxXYT9FAZA@mail.gmail.com>
Message-ID: <CAK8P3a3=YD7WV+Www8pf+JTv14DwcnSjD+f=YFCNMxXYT9FAZA@mail.gmail.com>
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jacky Huang <ychuang3@nuvoton.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ychuang570808@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        cfli0@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f35I4VQN5HrjLu+f35ruvI1eR5T9g+bS8hIxq67YP8hU7et8GXq
 6/ga5BEAuNysl5lffjUoLFn5i77YASqLm+x0rtNCuyggX++caLY3Lbm2HsCugCp3hMCY4pQ
 GzzJ+3KwbzZaF4Mjb5Rzfx5AtpBzCIZUdIBhT+5xL2soYf++YgqAUeGSxv91EoCtsvutHh6
 Nm+mInPbNTW1RvP4obUXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fkt0tv7tA1I=:UI38Qzf7Hgmuu3pdwo8Sza
 FIDnSMv87Ew1LeBfkAnGiv96fAvynAjx7G455b/zjgpTOBoAzfHzoWrPpTWD35lL5mjfyVQ2V
 3mtXsArw+VU4KZQkllqM+NjGPy06D1Nxc4pcD3EgvrnQVV9G3/1VtFHcjcZRraf1/X1txz+RJ
 2cFvvs/zLtqNfHx/z2lmHriraxorAeZipIjhu7s52OgNer4igR3/RZZsUn4N5MKYghbYXbsgN
 ffCcCy/YR4TOVPT8SRSju9xHnuzSIUxW7P0yfgyfPGo5b2G9PQDC/A5wZ4teKOy0wjXKhbBJm
 t9zMJJbEz7heT7jMAFuc6p5moRal+sYfFDsvxNIPrjYEA/zLd0mdNoKdhWlE6hPZNkw8B+9wI
 HIw4cO3rundVs9CHfm3Aq3uSGxT1KvIF6sfEP99SrKjsHf71WIcC3Eka4nhoXi+2S80GbCKPH
 lvgNvShwFowIcNXg6Qug4Z2bWYVmp0Q67Bg9h1v+JsiGrNt0S+II/l1kUtq3BYP8RplgjJhfj
 6rYZVFfKh+7v561mukU2a6Y7gAoD1xDSeDrrDZYiuz6yE/F5zZZQn345YpIAUP03nxjcA6NJR
 R5BXdcFbeQbQzx+UbeolBUk7+IpjUSZsOGXncmK3sSaenEgUmbLvO/4qkYGp9Fxg7UuRtCOcI
 u+iMksTTQH++kmbPHfTQKLBEfIc2Tsfn423KoptDxCWPna+ibMYT/5BN+g91V/dR+Hq1NlsMY
 aF1wrvqsm4xICty0OOHSaRE9MrsaSJYeASF8OA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 4:11 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/05/2022 09:07, Arnd Bergmann wrote:
> > On Tue, May 10, 2022 at 5:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
> >>
> >> This patch series adds initial support for Nuvoton MA35D1 SoC,
> >> include initial dts and clock controller binding.
> >>
> >
> > This looks fine in principle, but we are getting close to the merge window and
> > should finalize this quickly to make it into v5.19. I see that you don't have a
> > console device, as commented in the .dts patch. Normally I prefer merging
> > platforms only when there is at least rudimentary support for booting into
> > an initramfs with a serial console, but this is a flexible rule.
>
> I disagree. It does not look fine - does not pass `make dtbs_check` even
> with Nuvoton bindings...

Ok, thanks for taking a look. It was already late for 5.19 and missing the uart
driver, so it was clear it had not seen actual runtime testing. Let's try
aiming for 5.20 then.

        Arnd
