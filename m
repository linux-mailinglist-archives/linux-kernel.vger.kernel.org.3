Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C13520E61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiEJHfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiEJHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:06:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26E89CDE;
        Tue, 10 May 2022 00:02:19 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7s1M-1njOCR3gdG-004yY2; Tue, 10 May 2022 09:02:18 +0200
Received: by mail-yb1-f171.google.com with SMTP id y76so29055581ybe.1;
        Tue, 10 May 2022 00:02:17 -0700 (PDT)
X-Gm-Message-State: AOAM533ETVQqOGd98mKKn5I3jsOydLd8pfc9K4zQhooUGt9dJm4p1/8b
        3UeFHFMLwIhMPqCtbms+ZAofTta2br3qPE7El+M=
X-Google-Smtp-Source: ABdhPJzCoErVlOlWP+3agvpOC/u6kgO4/gR8EykNKzu19PrW0u0Z98t99jOPlEpsD8ttySzd6YiVB2UWW4A083+k8U4=
X-Received: by 2002:a25:cbc9:0:b0:645:879a:cdd3 with SMTP id
 b192-20020a25cbc9000000b00645879acdd3mr15923423ybg.550.1652166136461; Tue, 10
 May 2022 00:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220510032558.10304-1-ychuang3@nuvoton.com> <20220510032558.10304-4-ychuang3@nuvoton.com>
In-Reply-To: <20220510032558.10304-4-ychuang3@nuvoton.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 09:01:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1tbvE+PTB-qy2y7o3_i3VP0zkgMueDy3zBd64BsGKssw@mail.gmail.com>
Message-ID: <CAK8P3a1tbvE+PTB-qy2y7o3_i3VP0zkgMueDy3zBd64BsGKssw@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] arm64: dts: nuvoton: Add initial support for MA35D1
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ychuang570808@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        cfli0@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:41uXJV8ZDI63xzuVbY8paB13ziPpltqOnktwNglwfUmNJw9cwCd
 5P5mu20L/Nj1xc8WlYqCwvAtU+g/vFs7tbrlxZxKacQTrJIa434jFkbAQTSRxmbOa8wx3qA
 PTGOpcRLTwidHUrxL/WFup/F9NkJjUsJ1A79nwzzRNgynnIp3dB3zvvkyjGmL+sk0Jbe66W
 JorYpPblV4AbPGXK6o7YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EywyeRWjnAM=:tgppNxSMe33OniewTBHltP
 sdTFdQQeI4ME11si5cRlTj8pqdF21LRzNVODnHZJTYonX/jKI4dt3kV1l5pGSfPgDcg4Yi5pm
 F4yngPZPg55zwDBCOAyFgcqTtidatGFt98rNZMfUOiy7U5IxFcmrbl4dfTf3R9pGyBHmuTjco
 ZF2p9tmplFKS37hwWL2zChcEExR9UkXrSJY8IkGoOozZHL2CUjNp9QLBBSqcFdDEKdnLGVKO0
 pmu2ZCvbbM2IYYX+UwoRM0Kad/77LkRDNWJCpFtZO7/SeahAwg7K5JyhuJ0xi9VQMiusB9n6C
 fNjCog6hWmmqmtLph55AGx0aBcPJxZzLMmotvyLmedU15Eo7b+VT/o87qEjVFWqc+IzX4/Y+S
 Ul5uVdzNhaiLsrjRheSC5cvJYmuNzOrGqGLSyV3g8zA1lo9SItndZnex4CSmr4BI+FjCZmKJl
 wSdIF2o83cmogKKZxdihAJCGGEmqNGLc5SMoME7T10fg+6emYUSAB7sXWMLErSCbol5A8P0d/
 M/PVqAnlTrWHwpZFe8bEvEw01YJPaberRT4nHnLnS7xwwT8Rff+jBn+Tn01NbtleAdK54+pS1
 qwJw6sBbbpZQoGa5DqvzFR4l7iQHSwVZlsyfj1rCTwgPsS7aSIwZ1PC93Us17D/mxS0+sDvrt
 ufOzQNe30mZ7+zv2f506yzooqzxSB30NuK+Kp8DhYHrLH6QL17L1H9+ZgMBpeiEtl+nC0DLvy
 xOvkVHyJoRHuxBgal47FNPOVMogUx4oBdVw7yNw1YAORqXVHnKfddA+9jq/cU6Ikoly7uexoA
 0bn3ObIxyt1W4I2uDU3dsn2H+9hQmzXk/Bmj/8AApXSfu+1/Uk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>
> Add the initial device tree files for Nuvoton MA35D1 Soc.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
> +
> +/ {
> +       model = "Nuvoton MA35D1-EVB";
> +       compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1";
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };

Something seems to be missing here: you set the console to the serial0
alias, but that is not defined anywhere, and the ma35d1.dtsi file does not
appear to define any UART at all. Are you still missing the driver for this?

Please add a more detailed description in the changelog text above that
explains what kind of SoC this is (maybe a link to the product web page,
if there is one), and a status of how complete the support is: which drivers
are already merged, and which ones are still being worked on?

        Arnd
