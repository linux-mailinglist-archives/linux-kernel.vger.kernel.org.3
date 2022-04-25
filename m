Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BC50DF78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiDYL7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDYL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:59:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B6C2E;
        Mon, 25 Apr 2022 04:55:54 -0700 (PDT)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6bHC-1nwg3r1hcc-01822M; Mon, 25 Apr 2022 13:55:53 +0200
Received: by mail-wr1-f52.google.com with SMTP id w4so20423599wrg.12;
        Mon, 25 Apr 2022 04:55:53 -0700 (PDT)
X-Gm-Message-State: AOAM531ApSC2VSFZrxMs/0HkxfyveZ0V63JDnUI//tVuapV+4jJno3yD
        bBpZWd8ppKru3/DwWHbPqv8GtTTR+cqBr2zpNEc=
X-Google-Smtp-Source: ABdhPJy6G1KFbKHEzOAredhlniFlHgR99fdfjjNVGzWiR1NENqqdvyAlm9QrDNMIfUNAfKR7gKHmCTAe8oiy/GkxXHY=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr13310843wrs.317.1650887753050; Mon, 25
 Apr 2022 04:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org> <YlVAy95eF/9b1nmu@orome> <c5fad2c0-598d-a90c-5272-398ce48399fe@nvidia.com>
In-Reply-To: <c5fad2c0-598d-a90c-5272-398ce48399fe@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 13:55:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1fyibqtkNMXDA6JXFWc2856B40C6oD8hBaieR8jTD-Ng@mail.gmail.com>
Message-ID: <CAK8P3a1fyibqtkNMXDA6JXFWc2856B40C6oD8hBaieR8jTD-Ng@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: tegra: Fix boolean properties with values
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        SoC Team <soc@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TJThzSquOMPhjy725+dgA9ErMyiOQCUXXxl9RgLyzQjdDishMWN
 P8o71btqoX6QO9FSNR/iVp/Rb1TfaX4Sdiri8chrFtf8bQCBHZ1vrbVboKHOB2Py+F/cNhy
 CU/22OAgrG6UALd921r0domb2peA3zkHSO4axZ8YGchJenCJD4pHMonLMMcQj7PqTKl81Ie
 n/HOMvdkVkGI0QqjWW+6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tR5UHx9sUtI=:OLmXCofZgbaTPosvGTFV4q
 5/WsyUg6ZLU3YwheZChd/Vf5JY0BQQoVTFS6KfgZvu4c1pT9S4pa9G/vcze2EizLfCrVDqDDv
 8ljBRvnkMk3NDec/zm8pb9XRyugbmij1wEq4fMwNHP0N6oq9yUGC33J/5yjm4snN81gPSrNey
 M0fm0vdUxWCONA/rIqBdmfiZm7mxbleRmphKXYGLP06lRAs4c0ASYjuzhE0rB/wsptTMQ4BhK
 lCmFmC5wuqs4GuWJ6vFdirTo3iazexRdw5ufJRh8vb46oHbGZFFLgEaTdaUTeped1/LxIj4y2
 tiEgM3AK21k3c2vz6KxPvVNDoRsXpZ09G9k6G0ELLIhNNZVf5M2a82eJS09Xaq7nKcoW2W3QS
 donbKm5929wyYUFRZRc5sZpLIc8u00GPxSRzcMPlU7ARDWQrZWCgl+kyXI0Dbc9eQUxkDFsnS
 drnCmZMsu0NwpqaBZmDpWhFoTuj2eCXujCHbK/MibbVhYGHRFiCAf4RwxXZWA7MuBLUUoNvSK
 MTxGqh20DJHqzyrns5LCpETLDF2t6YRfJOmIsQjoMOKbEE3BGwtEBr4qi3TwBhFxubrtYBp/i
 saJfQVvPMk+AeX12eimOV0edW3d0UYWDuaAmvecb+8xPCy8SJFUy3KoAOvtipoR+IMOsIlypD
 7iWIMPOlpDvLIl7NtWy67T73iqhv/c9esY2RvSUXhOKIbDEjjC4i/tQPYgz36+2s7pP4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 1:20 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> On 12/04/2022 10:05, Thierry Reding wrote:
> > On Wed, Apr 06, 2022 at 02:17:30PM -0500, Rob Herring wrote:
> >> Boolean properties in DT are present or not present and don't take a value.
> >> A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
> >> matter.
> >>
> >> It may have been intended that 0 values are false, but there is no change
> >> in behavior with this patch.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Can someone apply this for 5.18.
> >>
> >>   arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi            | 8 ++++----
> >>   .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts    | 8 ++++----
> >>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi            | 6 +++---
> >>   arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi            | 6 +++---
> >>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi            | 6 +++---
> >>   arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi            | 8 ++++----
> >>   arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts        | 8 ++++----
> >>   arch/arm64/boot/dts/nvidia/tegra210-smaug.dts             | 4 ++--
> >>   8 files changed, 27 insertions(+), 27 deletions(-)
> >
> > This causes multiple regressions on Tegra boards. The reason for this is
> > that these properties are not in fact boolean, despite what the DT
> > bindings say. If you look at the code that handles these, you'll notice
> > that they are single-cell properties, typically with <0> and <1> values.
> > What may have led to the conclusion that these are boolean is that there
> > is also a special case where these can be left out, but the meaning of
> > that is not the "false" (<0>) value. Instead, leaving these out means
> > that the values should be left at whatever is currently in the register.
> >
> > See pinconf_generic_parse_dt_config() and parse_dt_cfg() specifically in
> > drivers/pinctrl/pinconf-generic.c.
> >
> > Arnd, can you please revert this so that these boards can be unbroken?
>
>
> Arnd, any feedback on this? A lot of Tegra boards are still not booting
> with v5.18-rc4.

I have reverted this commit now, sorry for missing the earlier report.
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=arm/fixes

> > Adding Bjorn for MSM, the Nuvoton and STM32 folks.

I'll wait for the others to reply, but I do agree that these are likely broken
as well. Could one of you propose a patch to make the binding
describe what the kernel code actually expects here?

       Arnd
