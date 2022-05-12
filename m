Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9957524FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353684AbiELORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbiELORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:17:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2BF6898D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:17:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so6443358ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzCgdXpm2Ct9CFRrH5hNJszZr1JzGPf47dDWtbsHyHw=;
        b=QExi6kj3+AqSVwyWHb591m6aK8pW5ZQSdaluuY4HU98gcz2whH1Hp5ADRaUUQC/xcu
         1gXwQnbpZSYKzKRjReLpd+2CEaty+1RHRxm9m4jVV2BsBQY9YzH3Fewy2WPIz4bfR2ts
         TYot+x5fJLmwQQHwODDTNBI0CMsNy/V5Vj0g2TqyCtRA4EJMjExpbcp2tLKby7GZqNOQ
         u1bQr3+RKMi4Mo1UcsDRUUZdCFvHUsdoZrgzWJ3k3enxpcjxWUPu66gK7+4NcKQC7MR/
         Z/WqOKLS6SMkZv9ckfqFmc/M+QutGh53mLnxcQUAQSXwqj+6N99KC0sVQNB2TbOfPPnT
         /rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzCgdXpm2Ct9CFRrH5hNJszZr1JzGPf47dDWtbsHyHw=;
        b=om7xU649vAZSykU214GDfrY6Vk30dpELjkrDO7TpmlwEa9Nl2mLCL2+5VpkNhGgCz5
         AlQwohDjcbfB5df5D9IJwQQ7/1NSvOK0W/u6nYQWG4JokC82D2QmnZvGfvVA2+7WZ0YQ
         L4V28ZAtU1YW1TPevtC7pvQPHKPNETxqahL/gD0INDZnTJGZ37l+ejyBBebLGa15p6/8
         83W2OHt/0rlFeNhZvmhSCZZE/FllwslLvCWihYSMQIYnbHFuKP0gP4XZBhXdKZEQ2FKK
         jMwQaYmnaQmd7w6CiMkziw6J2uG48Cw8alIXwDxQA52CVnl8C78Nmh8rBFfp6sUFtlku
         qRQw==
X-Gm-Message-State: AOAM533BDYKq7pPDYw07zfBB3NkcqgbmnHwHXnKioZzEeqLsmz7L2PpH
        GcINpvrjsC+Mvr6nQCfQZ+LUasc+6Fw3nhIn8l00Ng==
X-Google-Smtp-Source: ABdhPJwHK7nJi6/IKRzYKSBUhsfpinq40HQ+OtZPIviahMIQY6dt0nt6hC7w8bdcTI7sf5Z7crNkmy335MhAZ2Dkk6g=
X-Received: by 2002:a05:6402:2c4:b0:425:ac5c:4376 with SMTP id
 b4-20020a05640202c400b00425ac5c4376mr35666828edx.10.1652365023498; Thu, 12
 May 2022 07:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
 <20220508202544.501981-4-frattaroli.nicolas@gmail.com> <CAAEAJfC5aoFmk7hKZ-CSv1=RhzO8YU38Abz8PhD26MvV+X0r-Q@mail.gmail.com>
 <1959188.DQhRDO7MrQ@archbook>
In-Reply-To: <1959188.DQhRDO7MrQ@archbook>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 12 May 2022 11:16:52 -0300
Message-ID: <CAAEAJfAnbJoTLyYoKucy8GFJTJyBVFO=Fcne1EbUVOGa+yC3iA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:28 PM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> Hi Ezequiel,
>
> On Montag, 9. Mai 2022 16:17:03 CEST Ezequiel Garcia wrote:
> > Hi Nicolas,
> >
> > On Sun, May 8, 2022 at 5:26 PM Nicolas Frattaroli
> > <frattaroli.nicolas@gmail.com> wrote:
> > >
> > > The RK3566 and RK3568 come with a dedicated Hantro instance solely for
> > > encoding. This patch adds a node for this to the device tree, along with
> > > a node for its MMU.
> > >
> > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > index 7cdef800cb3c..2e3c9e1887e3 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > @@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
> > >                 status = "disabled";
> > >         };
> > >
> > > +       vepu: video-codec@fdee0000 {
> > > +               compatible = "rockchip,rk3568-vepu";
> > > +               reg = <0x0 0xfdee0000 0x0 0x800>;
> > > +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > > +               interrupt-names = "vepu";
> >
> > It this block "encoder only" and if so, maybe we should remove the
> > "interrupt-names" [1]?
> >
> > The driver is able to handle it. See:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/hantro/hantro_drv.c#L962
> >
> > You might have to adjust the dt-bindings for this.
> >
> > [1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/
>
> What the Linux driver can handle should not matter to the device tree;
> device trees are independent of drivers and kernels.
>

I guess my message wasn't clear, no need to lecture me on Device
Trees, although I appreciate
your friendly reminder of what a Device Tree is.

Having said that, the binding is designed to support both decoders and encoders
for instance:

        vpu: video-codec@ff9a0000 {
                compatible = "rockchip,rk3288-vpu";
                reg = <0x0 0xff9a0000 0x0 0x800>;
                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "vepu", "vdpu";
                clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
                clock-names = "aclk", "hclk";
                iommus = <&vpu_mmu>;
                power-domains = <&power RK3288_PD_VIDEO>;
        };

Hence the question is why do you splitted the encoder to its own node?

If we have good reasons to have separated Device Tree nodes,
then having interrupt-names = "vepu" for its only interrupt line
doesn't make sense.

> What does matter though is to be consistent in the bindings.
> interrupt-names is a required property even if there's only a vdpu
> interrupt. I modelled my vepu-only binding after this case.
>

The current binding models the idea of decoder and encoder
being the same device. This has never been really really accurate,
as the encoder and decoders have always been more or less independent.

The reason for having them on a single device are mostly historical,
some old devices shared some resource. I don't think this is the case anymore,
but the binding was still modeled to support that.

Hopefully this makes sense!
Thanks,
Ezequiel


> If robh thinks there is no value to having the interrupt show up
> as anything other than "default" in /proc/interrupts, then I respectfully
> disagree with that opinion and point out that this should have been brought
> up when the vdpu-only case in the bindings was made to require
> interrupt-names also.
>
> Changing the binding now that there theoretically could be drivers out
> in the wild (though I doubt it) that do require interrupt-names, because
> the binding told them that this is okay to do, seems unwise to me.
>
> Regards,
> Nicolas Frattaroli
>
> >
> > Thanks,
> > Ezequiel
> >
> > > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > > +               clock-names = "aclk", "hclk";
> > > +               iommus = <&vepu_mmu>;
> > > +               power-domains = <&power RK3568_PD_RGA>;
> > > +       };
> > > +
> > > +       vepu_mmu: iommu@fdee0800 {
> > > +               compatible = "rockchip,rk3568-iommu";
> > > +               reg = <0x0 0xfdee0800 0x0 0x40>;
> > > +               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> > > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > > +               clock-names = "aclk", "iface";
> > > +               power-domains = <&power RK3568_PD_RGA>;
> > > +               #iommu-cells = <0>;
> > > +       };
> > > +
> > >         sdmmc2: mmc@fe000000 {
> > >                 compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
> > >                 reg = <0x0 0xfe000000 0x0 0x4000>;
> > > --
> > > 2.36.0
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
>
>
>
>
