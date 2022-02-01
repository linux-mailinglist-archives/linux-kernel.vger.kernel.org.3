Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DFE4A58E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiBAJAO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Feb 2022 04:00:14 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBAJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:00:13 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1u2b-1mD4OT0fPt-012EHw; Tue, 01 Feb 2022 10:00:12 +0100
Received: by mail-oi1-f171.google.com with SMTP id r27so9795019oiw.4;
        Tue, 01 Feb 2022 01:00:11 -0800 (PST)
X-Gm-Message-State: AOAM531afx/pf8aVLUrOet4V65+C+KLZcDCQjILz5LTBeowldr+MmLW5
        6CDjmlfltBIdsyvjBXJuMPZGc4LFChDK1z2Oiig=
X-Google-Smtp-Source: ABdhPJygwdTfon0x9DJPFhnTfex7k/EUaoKkqy5L3rZOJOm/m+wWWs8/4gr7zInf5+PzxIzYSEjApE7e8LkPzvovZ1Y=
X-Received: by 2002:a05:6808:1a26:: with SMTP id bk38mr537794oib.291.1643706010707;
 Tue, 01 Feb 2022 01:00:10 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220125194609.32314-1-nick.hawkins@hpe.com>
 <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
 <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com> <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
 <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com>
In-Reply-To: <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Feb 2022 09:59:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3AUdQ94yu5An0-MhOuY2bOsr=zFWhtqVHk6E_+hBUCZQ@mail.gmail.com>
Message-ID: <CAK8P3a3AUdQ94yu5An0-MhOuY2bOsr=zFWhtqVHk6E_+hBUCZQ@mail.gmail.com>
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:25kZqhuAYtnLmP1bfYSuPzRdeyPptmlRgbeWuTpyhSp+3BslXI7
 3kK7Pk61V8aIyQyXOKdfjjGiML+pizAWs8EWUqPp9COcMfBJ78jHeYnZ74bIqyyyyHxRg5m
 paOjAzfrv17tr9fz7JpKDuW6xG8LkvDfyYaiZI0g2b4o1IrLFs4iicoywOZ2E3a8i0deBrQ
 q0uZttHDqKgF0xvw4T8MA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyeu6G5QG5E=:6eFvbbesaTDFSU31NiS+Ya
 KBhpZgUW/vLr1CMta+jHdrH80cspfe7cWBAuzBCfSJGyZqSdPEdPBysRX7YAvcOBlN1ljX4dq
 xzTXj5s/6Dh2j54uVPMUK0QelmRyZmkwgooNk4Grq28MCX9vLJpRSjFkYfw4AZskxzMTquuf+
 sVI1b8pqcwzF3ECNBup/HewPqbglJWRd2cNIBC8rJbZFwm/NK6vcHq90JfbabWioFNnkcUknG
 Vo/c4SXTmvMR1xl+6jtqOOW/84xb7SwvFCFF6lICa4cyuXdWV5VcVE0bVFk6anIXqa+GcaCpv
 I741oWyNVZ2/tkGH3+hjvGv5sJSn6BwA7Ti8Q9eI0V9lzDSNrDILoGh90Jq0bJIChsXnwkCLq
 aKRZrpL0iJpkACp/pqfr4CWNzAsjCLJV67pphDYgp6m/GWdvl3wy3eRI6Tow5VPqx7d8YBJw3
 5jEJRBgwHpFTC60yvYAHjw7W96ZSusblTjmZE9HWfNv4j3xxze7QtgE8qU6goqiLfBFH2Qbav
 yWDZi2Zo8a69l1X8IBjSyYmk2CohEI0iov8fM3Me+FqciqA7j5V8AO3k4BWa/IWNvA29Y57h5
 0Mkrs0UsAuCxJt0TEP61Ji7Jl6FKZH2eRFpXkfYgGNZliMRSdnfKF3IERBmLwUlv9aucdZ7SI
 HvcYalIrBrm4ksSGCKVg1WEeZ1g2tcWuy1CalMoPCWiyceiVLgQzE/DfLLWmkM/RZGk8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:52 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
>
> - GXP is the name of the SoC. It has multiple implementations, which are currently compatibles. I don't think for the moment that we need to distinguished them. We might have a GXP v2 coming up but not before a certain amount of time which is far enough.
> - This SoC is used to implement BMC features of HPE servers (all ProLiant, many Apollo, and Superdome machines)

Is there any more specific name of the chip that can be used to identify the
exact generation after a new one comes out? The normal way we handle
compatible strings for devices is to start with a specific model number of
the chip that integrates it, and then have later chips refer to the device by
its new name, with the old one as a fallback. This makes drivers work out of
the box when the device is unchanged, but gives you a way to distinguish them
if a difference gets noticed after both revisions are already used.

As with some of points that Krzysztof and others made previously, the goal
here is to avoid binding incompatibilities in the future: anything that works
in an upstream kernel should keep working in later versions, ideally
allowing any combination of old and new dtb blobs in the bootloader
with old or new kernel versions.

> It does support many features including:
> - ARMv7 architecture, and it is based on a Cortex A9 core
> - Use an AXI bus to which
>         - a memory controller is attached, as well as multiple SPI interfaces to connect boot flash, and ROM flash, a 10/100/1000 Mac engine which supports SGMII (2 ports) and RMII
>         - Multiple I2C engines to drive connectivity with a host infrastructure
>         - A video engine which support VGA and DP, as well as an hardware video encder
>         - Multiple PCIe ports
>                 - A PECI interface, and LPC eSPI
>         - Multiple UART for debug purpose, and Virtual UART for host connectivity
>         - A GPIO engine

Thanks for the description. This seems quite normal then, similar to the
aspeed and npcm BMC platforms that we support already. You can
probably drop some of the people on the Cc list, but I would suggest you add
the openbmc list and Joel Stanley (Cc'd now) in your next submissions, Joel
would be the best person to review the parts that are BMC specific.

> vejmarie
>
> ﻿On 1/26/22, 12:41 AM, "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com> wrote:
>...

Please follow the normal quoting style when replying to mailing list messages:
reply below the part you are quoting, and trim the parts of the original message
you are not quoting.

       Arnd
