Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6357849DBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiA0Hfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiA0Hff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:35:35 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BDC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:35:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a28so3586345lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFlPNohioylVZ6TzuDEF1YOceKLEX6bvfPEUnxwBSPg=;
        b=XFXzHL+kIWa4NRQpGa6wnShMiw3hMRKNdslDa69Y5VYsiAda4Q+QgRSLTgcbuSGw4G
         gAVH55GiAna7rm2tROsn6FnVPvuKF+3XdMAJToQwfid1OfbuefnYGCCWkw4bsDJN2H3k
         +GOAlBrR1PYeGFQ9dEgDTCuFU2ltP8CNM1ldIB+UAx2HTyiBX1m8FTns7P/3xmo2hlmz
         QW8uZ4Ct/Xo5UBimw9CZLN8Q7kOHYxXGHemjQAgUPoYxzNcW3ckQMzUX2wMuY/jzWHrs
         CXM4MnBAUEqRbQVKS0/N+S5OHEm6fjvQM59ZeuLL/RfzperAIe0v4ur5lVRDVX7p9AWN
         zo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFlPNohioylVZ6TzuDEF1YOceKLEX6bvfPEUnxwBSPg=;
        b=mKwJB8+BR4fEQRXewSTnVg/o2K/6GgqyRVQAPflHINagHT3ikp6dyzJnLcYvvUgYsd
         Davt+xzF1ltcusJhncQT9LuLBkqsnUS7S7o9NfxrcBNaptTx8szKJJ2uUUZT8RySAHyN
         q4lqCzbQjLynOLZWzoEgkNnKa9KuDMfM3K7xSULImlrgrOgtROFf9oWStZLEbqg1fzUt
         jMsr1QvCrzksKDmN4mYD+R2YdoVscNr5UDKAJmsnLhOd2Pt3kGetmCkm3XDFawa6S2UV
         Z0NV+rytKJWr/cBKsihvjy7lPh8TAA6XDvSoaK17OGg/UWr/AN+ZUXKGEPPm09daXCeX
         591Q==
X-Gm-Message-State: AOAM533339hq92qDkXtv5qC8+u4tWxfIKIXql9FmTNgpGYwFPU7WRucU
        JhD5rznr4oYtGzcbRXegu1GTzRbxpJGM39yGduuhGQ==
X-Google-Smtp-Source: ABdhPJwOaezJNsHNZ784GwMKibaqQucQTzXckcoN/zwUBW6a5VrWDpMAG4Y5Sntkn5L2pTPY81CTneDwFvH3vmstqZg=
X-Received: by 2002:a05:6512:3052:: with SMTP id b18mr2082206lfb.5.1643268933354;
 Wed, 26 Jan 2022 23:35:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642383007.git.zong.li@sifive.com> <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
 <YfJD11wlgkzuE+Sp@matsya>
In-Reply-To: <YfJD11wlgkzuE+Sp@matsya>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 27 Jan 2022 15:35:21 +0800
Message-ID: <CANXhq0qX_TZTRyZGGBSs0_zUa87ktSSv-CubHF8pFxuhv7rocA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] riscv: dts: Add dma-channels property in dma node
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:03 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 17-01-22, 09:35, Zong Li wrote:
> > Add dma-channels property, then we can determine how many channels there
> > by device tree.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 +
> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > index c9f6d205d2ba..3c48f2d7a4a4 100644
> > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > @@ -188,6 +188,7 @@ dma@3000000 {
>
> Unrelated but the node name should be dma-controller@...
>

Thanks for the correction, I guess we could give another patch for
changing the node name.

> >                       reg = <0x0 0x3000000 0x0 0x8000>;
> >                       interrupt-parent = <&plic>;
> >                       interrupts = <23 24 25 26 27 28 29 30>;
> > +                     dma-channels = <4>;
> >                       #dma-cells = <1>;
> >               };
> >
> > diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> > index 0655b5c4201d..2bdfe7f06e4b 100644
> > --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> > +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> > @@ -171,6 +171,7 @@ dma: dma@3000000 {
> >                       reg = <0x0 0x3000000 0x0 0x8000>;
> >                       interrupt-parent = <&plic0>;
> >                       interrupts = <23 24 25 26 27 28 29 30>;
> > +                     dma-channels = <4>;
> >                       #dma-cells = <1>;
> >               };
> >               uart1: serial@10011000 {
> > --
> > 2.31.1
>
> --
> ~Vinod
