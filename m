Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18AD47B034
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhLTP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:28:18 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhLTP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:27:55 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAwTn-1nAa2a2u9h-00BMmM for <linux-kernel@vger.kernel.org>; Mon, 20 Dec
 2021 16:27:53 +0100
Received: by mail-wm1-f54.google.com with SMTP id z206so7142471wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:27:53 -0800 (PST)
X-Gm-Message-State: AOAM530YO34nC7cURVZRrBReL/uLoFhSw+8ypz3e4rCEOeqfGm/u+Ccg
        DYTz25m6cadzpoa8amInBxkHOwg93fd6eQ6O7Lo=
X-Google-Smtp-Source: ABdhPJwcwOobEoLcg19twwbzlytK2IfVNFN+eE1j0Rgj8askqzd9F9mG9seAa7XGnAqbDUH0VwfAeXPvWcdVn44rEcg=
X-Received: by 2002:a7b:c448:: with SMTP id l8mr21138198wmi.173.1640014073329;
 Mon, 20 Dec 2021 07:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20211217172806.10023-1-vigneshr@ti.com>
In-Reply-To: <20211217172806.10023-1-vigneshr@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Dec 2021 16:27:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com>
Message-ID: <CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: TI K3 SoC configs changes for v5.17
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC <soc@kernel.org>,
        arm-soc <arm@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jU3n0Qg5uPiveqqkzl4QxVutK4wTpi1QBbWaj+FB5qnl3RMWxCj
 cranYfWNNuTZigWnoBSpw4Cd9L8gwRyHDwS+pYp2lAfDeFNRBarercMxXmnKjcrZrOTRO+j
 /3f/0dJZ8TrdSVIcR5BNWpkJRGYhitfhjw4ITjXz4ChA4QPD82q2+rtLreJmMzmCjrHiIFe
 VzHL2Vithsa5T0Qv8/4Ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bxhrHGAeV8c=:xjVH/RSrYnb4hOLE/rZtMc
 a3dml2AGw2oLJaqDvCNjazVJ8JU4fsVpfniVTwxjtfsiFVnUo7tDeRhxlWGmRmM3uUHFMXPmr
 r4oyuDLfdwJ8hK6Fi0ymv6uhSQck780tGzqAWELI2Jlu8II2AZjkHZMh4ACexRPO8kS6/H7bf
 JXKDjvlLswnIfPyVpfIJ6k8dXbOj74Aio8hGYw8XaScfTmcYf8Goz8QV7d171FwGx9gz2nH6G
 1Xv4rspsLdh+WETGz5aBoFCYXh8KlZnQBg2vMz4c/F2z+tFL+AY0pjJgDx4BEi9VcpPf9ZLEU
 CxgsJrJCoBjcqvAI8xoZY8/9H1+ehkdL8duxx+TCcnqjWENcDYlS7UXYuj+Qm2aV5Vzf6PP+u
 /cZBOYbmssAgioKRzJOytlXJ25JsHHBfuo1WqO+DJgbL+7koext91m3qS9xZTH8cWYp/sGZwg
 GoRaF+u/AVW/w0fVKvSrscYtqn4feHASLn/mYTvuRyArGGP5biShM6lJmzXbpczb4V/vv0pvE
 8sAMkBDlxC6LNZjLADYsfO6uz8edc+OxcGbQw30no42MRsUNcVezeQKWFeHOvYovN3TPGCkCy
 tLETej6meXwsGOhJCa6Af/i+a4AtR8gLu7hJ/B51j97+U5smVOs2Q7xoCJ1IxFIVuXlPIwc8m
 vNRx5Sr+OW35GCRFZHRdxSjOejsb46RQeMn92kWMGsdHYO9+CYayGareH5hzDMTtc1y8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 6:28 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v5.17
>
> for you to fetch changes up to 8d73aedca28cbed8030067b0d9423a0694139b9c:
>
>   arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC (2021-12-14 16:22:25 +0530)
>
> ----------------------------------------------------------------
> ARM64 defconfig changes for TI K3 platforms for v5.17 merge window:
>
> - Increase No. of 8250 UARTs supported in System to 16 for J721s2

This looks a little excessive, I'm holding off on this pull request
for now, as I'm
not sure exactly what the downsides are.

I see that your dtsi file has

+       aliases {
+               serial0 = &wkup_uart0;
+               serial1 = &mcu_uart0;
+               serial2 = &main_uart0;
+               serial3 = &main_uart1;
+               serial4 = &main_uart2;
+               serial5 = &main_uart3;
+               serial6 = &main_uart4;
+               serial7 = &main_uart5;
+               serial8 = &main_uart6;
+               serial9 = &main_uart7;
+               serial10 = &main_uart8;
+               serial11 = &main_uart9;
+               mmc0 = &main_sdhci0;
+               mmc1 = &main_sdhci1;
+               can0 = &main_mcan16;
+               can1 = &mcu_mcan0;
+               can2 = &mcu_mcan1;
+               can3 = &main_mcan3;
+               can4 = &main_mcan5;
+       };

which I think is the underlying problem here. The aliases are really meant to
be board specific, and I would assume that none of the boards actually
uses all the
uart and can bus devices, usually this isn't even possible due to pinctrl
constraints, so please follow up by moving these to the .dts files listing only
the actually used devices instead of working around it in the defconfig.

> - Enable USB, PCIe and SERDES drivers on TI K3 SoC

I see the PCIe driver is built-in here. Is that necessary for booting?
If not, please
make it a loadable module.

       Arnd
