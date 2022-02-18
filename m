Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23A4BBDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiBRQnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 11:43:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiBRQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:43:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672523191E;
        Fri, 18 Feb 2022 08:43:23 -0800 (PST)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEVBa-1nVb073iJ8-00G0Xa; Fri, 18 Feb 2022 17:43:21 +0100
Received: by mail-wr1-f46.google.com with SMTP id i14so15505233wrc.10;
        Fri, 18 Feb 2022 08:43:21 -0800 (PST)
X-Gm-Message-State: AOAM533KCBp9cfGSfaeNhC/xkomehwEVEK/RVeRToK64sowAqKKKJ5sd
        EyPuZH0FFbIuBMi0gDipcKGEW3HWGysJe2FpqV8=
X-Google-Smtp-Source: ABdhPJya7KJW40w+8EvG22/ogqA/L/ueVMwSm8J6b9LRMVcNTbNBBrGtb6cVelJPl3THb0bYSKxwpfk4ST+4TsvPcE8=
X-Received: by 2002:adf:c406:0:b0:1e4:a5ae:34a3 with SMTP id
 v6-20020adfc406000000b001e4a5ae34a3mr6918358wrf.407.1645202601511; Fri, 18
 Feb 2022 08:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20220113170755.11856-1-pali@kernel.org>
In-Reply-To: <20220113170755.11856-1-pali@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Feb 2022 17:43:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
Message-ID: <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Increase PCIe IO size
 from 64 KiB to 1 MiB
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:4M5UZfLM60QlGjKrHZAErX2tEmSvIBbWz5fsxkzKo1WtRaOEwll
 4x/PeYB4D5BNUoJBVIjgYznYIf43JeH2M1T1P12hmC+9akv3Ei8oSDHQ1X/tBJJ4Oorzip8
 coJInlkwrg8mrXxYz1TMofoX0bIdg2fwqPO5SoVUq/intsgmzBC4jR8Umf7J0BeC7Df8hEv
 AdFAD/XNQUEhwmzSavAxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:clAO1iAF50Q=:ghn77pxIagHZbjCyBKMTHe
 wSfXnErKGCGokZrbipsHRxA9IDwHlW1VM+EIXokHnD84W+kJQpfacF37W5Uptbqq4XQprKgQY
 Q0J6d2uUa6pYZD0XAdARTLp0vKLqBl63uiXRtCY1ztMAK7/vmBKibb0l21VxADUQM/YFXli/S
 ZGLlVSyh8HJnPj7GJom9p8Xrda1whD6ruekewloeAUCXFJleDOVK2xoEgfOjFKSJACsPFZEJx
 JwGr3gOU0oR5CuZKgF07Z5Od2naYLfYWF4TXHqFq4dFNmoV2bVm04fLz/W7v9IZNFZc6EphpQ
 KjwyLlp4YW01m+BdNUpt9UtLjTydNGTJkthswDO5hJqKlsHq2MJu6Sc8XNuNCz04ioN9onNHn
 5SHWVKu4KdMjElLEEp+94KovNio1+JVz/EqXJiK/2usoc84wQYEucDASkUYDgln7M7SMj9Caq
 zGfdSFBtXF1w22TmyDBV9zRjt1bSaEk/4F7BACGv1ITeGv4yfiDgv+D5oktF6OCLrPyN7qcdX
 /86NNVOjk+dYIL2hZ36XRTQVOuMNfcQy7CvQUQexm+yj/IpPFUXCIrHLcvulvPMusgs3aeuY/
 AA4RQyI2Oa1svvsRoajLY576O7eZYH0wX/k7hQegUSx4jJ0eLf2Z9Yy9kXwv+AOC2K+qpgu9J
 arzReH47kKjT/09xwsoNDq0lVJQf9vhl+ofQnVv7zf44epu/fZXjhZ8TiNSsbI/bVvhKGqOyJ
 USaQxr90OlgAFUfoXfsHMd42bHz/GnnEXbiERsnx8WCO2RumOQqdn5pCrEkWQxJgm158NRXNU
 H8V5GZHHlDsIMy6yhFmBsLLUWAnfOkAbZw+3JjFWEHOpC7XkJY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:07 PM Pali Rohár <pali@kernel.org> wrote:
>
> Commit 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM
> space") increased size of PCIe MEM to 127 MiB, which is the maximal
> possible size for allocated 128 MiB PCIe window. PCIe IO size in that
> commit was unchanged.
>
> Armada 3720 PCIe controller supports 32-bit IO space mapping so it is
> possible to assign more than 64 KiB if address space for IO.
>
> Currently controller has assigned 127 MiB + 64 KiB memory and therefore
> there is 960 KiB of unused memory. So assign it to IO space by increasing
> IO window from 64 KiB to 1 MiB.
>
> DTS file armada-3720-turris-mox.dts already uses whole 128 MiB space, so
> only update comment about 32-bit IO space mapping.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")

I just saw this is the fixes pull request, and it seems very odd. Does this
fix an actual bug? Note that Linux normally doesn't map more than 64KB
of I/O space per PCI domain, so it should not make a difference to us.

Also, note that having a high bus address for the I/O space (0xefff0000,
as as the CPU physical address here) means that a lot of the older
devices that actually require I/O space won't work, because they need a
low bus address in the first few KB.

Is this mapping a requirement from a broken bootloader, or can you change
the mapping of the I/O port window in the physical space to the usual
bus address 0?

        Arnd
