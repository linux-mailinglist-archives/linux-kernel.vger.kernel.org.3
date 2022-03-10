Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850264D464B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiCJLwZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 06:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiCJLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:52:20 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B1145E09
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:51:19 -0800 (PST)
Received: from mail-oo1-f44.google.com ([209.85.161.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJFpj-1nhtKo3jJL-00Kfxr for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022
 12:51:18 +0100
Received: by mail-oo1-f44.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso6412571ooi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:51:17 -0800 (PST)
X-Gm-Message-State: AOAM5311bbalYi8EQTfg3pHnM69O/Zu1RTk8AQ/nhMqAn3HoUxb2wCq5
        CxdFZy7OLiPl1fMcMuq0xbT7dIDmg0i+EOimwWM=
X-Google-Smtp-Source: ABdhPJzhQ6HDCnGf4ELAi1hiAjTwlUZ4Udhx9o9AnZcGtXufmdvbLQuFqx7ujzZsPngG/QrJx7H4reMnDSkEVDlBDXE=
X-Received: by 2002:a05:6870:73c7:b0:d9:be64:a11f with SMTP id
 a7-20020a05687073c700b000d9be64a11fmr8161169oan.3.1646913076640; Thu, 10 Mar
 2022 03:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20220218212526.16021-1-pali@kernel.org> <20220310103923.24847-1-pali@kernel.org>
In-Reply-To: <20220310103923.24847-1-pali@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 12:51:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1jz1gJe-Xd08bWBByqpoPrVNDmfi5uK+t8XZTCBRCGxQ@mail.gmail.com>
Message-ID: <CAK8P3a1jz1gJe-Xd08bWBByqpoPrVNDmfi5uK+t8XZTCBRCGxQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: marvell: armada-37xx: Remap IO space to
 bus address 0x0
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:u5M8QtIjcYrszJPfR4DWsaqaH+mQQgqa45ekm6s37nCIj1q/ltV
 FzT4M9mYoZIE/9+CZTluuNbI6b5gfSucIZTtcmPsAU9ebt6gz6ZT10PSz4NFtBfhrf1TIGJ
 DY4IbgiO2p0jSoJN6hhSrf+lZcpNe2RsKiHxXb76r8cDRCvrqrDiMJVv8zlqNW1WwGOsH75
 GszVctJ4x0OJMdAYKPtUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TvTndfbROmM=:SKc6Cu1V7jHolkPddGAlOG
 lrI7mXDRK9WQYbbWVMd2AYHjAJy+oBVTMCGwPsWFIABKr31jUjq/o4vLT7Kd7K12fz1Elhsh/
 GHfKl810LWOtVvcAzouJNru9zafOyLBh9qaQgYE6QKS9PQVz8vUXJ1sif5WuVRY37Ye7fVY9a
 vZsuuZfv3ery53ixXEww2YVH8BpJDJdlKfrU74PS5c/bjWH3kvQ2YhBh6fxqGQcRf1gkBXPYM
 nkgtbt0SJzFSzp6oApZ2Xja4QglmZYLEJjf0Y+fuYCYcAwS1ZAxh06VVb9vXX40v2YgD+imyK
 FDtg6lR37JdX7VR6Gnny5mXBQtd6NhBm7kkA5E8dv21pbokMURrYjpM/XWbW1DrsQA2sCEUNz
 QOcZJI3a6TnJ/ma2GXmvB5N7TuKfB8THhkGITYBZfZo8N1exnWkWwvJNwoiQ0YgRHoE6BaFeK
 147F1ydAuKGfYcxYD5bMkCoGWYFsQSiJn5KEv1ZpyFbL3Yy7c1ZB3PruzRCzOX+7h1MM1t5ix
 BvdDQKH0ticwRC6UVTQSnpyRGCobYf0EnhS4Jjo+Lwrq4H3jenIw6KOqJkAoLYDg3YW6kW73H
 NHdIydUKw6dtMW001OCSjqFHJ8KZTRQz2NBjO0PS8vcJB+7Q9bKtBQHF+OjZoO6uFZtEJuOW0
 mtkld1CVZ/fO+Gdffx/IVvXW83l03A5yFa6oy3tGEbVWLi4059q2iMmn6j9cn3ucVL3w=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:39 AM Pali Rohár <pali@kernel.org> wrote:
>
> Legacy and old PCI I/O based cards do not support 32-bit I/O addressing.
>
> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> 'ranges' DT property") kernel can set different PCIe address on CPU and
> different on the bus for the one A37xx address mapping without any firmware
> support in case the bus address does not conflict with other A37xx mapping.
>
> So remap I/O space to the bus address 0x0 to enable support for old legacy
> I/O port based cards which have hardcoded I/O ports in low address space.
>
> Note that DDR on A37xx is mapped to bus address 0x0. And mapping of I/O
> space can be set to address 0x0 too because MEM space and I/O space are
> separate and so do not conflict.
>
> Remapping IO space on Turris Mox to different address is not possible to
> due bootloader bug.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support for Armada 3700")
> Cc: stable@vger.kernel.org # 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from 'ranges' DT property")
> Cc: stable@vger.kernel.org # 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
