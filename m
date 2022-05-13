Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B35262A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380574AbiEMNIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbiEMNIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:08:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E4369C1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:08:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d6so9925174ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JktyQozRr2Cz4cFwzIQ+UMGCdPh43AUYY4NAypHDM8=;
        b=OlZEX0vwTmT/AVPyyiSYeEOgYbGnJ5u5RGlJ6GCRSMsjYKh438OlW2YHs6KXaG/TnK
         jxCYA43qQGHdbN+rZn3Mn4hSirivnlHQmlAXGFrU5yCAZp22dxQ4oZCt/2EWLYWkdq4x
         ByrAYG6gLnXHm7/UMvHvAmn7jyIfraHOQvsbMdvYwiJSt8f7StttRhNrArLYBjxHIukc
         28zxck6d0qDXQrcQcVQRwEh4wVgO6FVmMbKyZfAN7QriMS+sK1ox2J0mL8J/z3n1JuGP
         WbCvY+LBBnSnYRFgrdYJnusAswfaB244GYYonL7BhNo5DzZcuix/lpZ2JQr6qvXMFGWc
         qH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JktyQozRr2Cz4cFwzIQ+UMGCdPh43AUYY4NAypHDM8=;
        b=gRgYHZFnGJfRvwdx4gRU0uE2O/LVHTYwl2Qwph3UMKZpyF48zbO2jxZ0Ll5yI5RbF1
         qdmC9LhVVViDlpN39T6aptSqqyWWY5fPMyEti23mTyHuaSzUphEBhT0onOI90H1lohVy
         iHZKusmE2QBL+rYtM/gJg6FMs0m97b3+h3c2EvQ9YV/++GLZYWoOYzm1lhzr+UKYYiak
         ExbMvxVFHl6MuK9F7ng80KCvz/2nNtHiQMoCITMrwf0JfQJy/6lnbM7OCQ6D+CVjQB8W
         KVuChFXN/GlDroYD3rOXE0Z+GpEdy7G1SojFgj5M5I3GTLGsD8ryKTxnKfGAHwPENze5
         0Xcw==
X-Gm-Message-State: AOAM530u9by1zuBaE3fkUqmEmrY43DKPoDbmyw4D30DNLhsODend93Yx
        /cLEUIg93xNurxIJ8yROa87OYnGTSeYRAfAzdFV4RZRVUe0=
X-Google-Smtp-Source: ABdhPJyfxwGtIJZMHH2WpAkNEyRxYWQL3F2ojW2wNv6Zi8EZx7txNXsxSsoin0OhW1qhA99x2EvKq2+tokJC30JUB6Q=
X-Received: by 2002:a05:6402:2c4:b0:425:ac5c:4376 with SMTP id
 b4-20020a05640202c400b00425ac5c4376mr40621823edx.10.1652447283775; Fri, 13
 May 2022 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
 <14624530.8YKtBhKLIE@archbook> <CAAEAJfBczhKTmRQfteacN4rYmJPRSuWZBs1LUuVnMKJ_z0EUwQ@mail.gmail.com>
 <2024120.v6J0oxdlOP@archbook>
In-Reply-To: <2024120.v6J0oxdlOP@archbook>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 13 May 2022 10:07:51 -0300
Message-ID: <CAAEAJfDMG9ykJQHUf6oB5gjV_J0M+eycCqiUvDv2WjpC3g8dKQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Fri, May 13, 2022 at 3:23 AM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> On Donnerstag, 12. Mai 2022 23:33:03 CEST Ezequiel Garcia wrote:
> > On Thu, May 12, 2022 at 5:00 PM Nicolas Frattaroli
> > <frattaroli.nicolas@gmail.com> wrote:
> > >
> > > On Donnerstag, 12. Mai 2022 16:16:52 CEST Ezequiel Garcia wrote:
> > > > On Tue, May 10, 2022 at 12:28 PM Nicolas Frattaroli
> > > > <frattaroli.nicolas@gmail.com> wrote:
> > > > >
> > > > > Hi Ezequiel,
> > > > >
> > > > > On Montag, 9. Mai 2022 16:17:03 CEST Ezequiel Garcia wrote:
> > > > > > Hi Nicolas,
> > > > > >
> > > > > > On Sun, May 8, 2022 at 5:26 PM Nicolas Frattaroli
> > > > > > <frattaroli.nicolas@gmail.com> wrote:
> > > > > > >
> > > > > > > The RK3566 and RK3568 come with a dedicated Hantro instance solely for
> > > > > > > encoding. This patch adds a node for this to the device tree, along with
> > > > > > > a node for its MMU.
> > > > > > >
> > > > > > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
> > > > > > >  1 file changed, 21 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > index 7cdef800cb3c..2e3c9e1887e3 100644
> > > > > > > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > @@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
> > > > > > >                 status = "disabled";
> > > > > > >         };
> > > > > > >
> > > > > > > +       vepu: video-codec@fdee0000 {
> > > > > > > +               compatible = "rockchip,rk3568-vepu";
> > > > > > > +               reg = <0x0 0xfdee0000 0x0 0x800>;
> > > > > > > +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > +               interrupt-names = "vepu";
> > > > > >
> > > > > > It this block "encoder only" and if so, maybe we should remove the
> > > > > > "interrupt-names" [1]?
> > > > > >
> > > > > > The driver is able to handle it. See:
> > > > > >
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/hantro/hantro_drv.c#L962
> > > > > >
> > > > > > You might have to adjust the dt-bindings for this.
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/
> > > > >
> > > > > What the Linux driver can handle should not matter to the device tree;
> > > > > device trees are independent of drivers and kernels.
> > > > >
> > > >
> > > > I guess my message wasn't clear, no need to lecture me on Device
> > > > Trees, although I appreciate
> > > > your friendly reminder of what a Device Tree is.
> > > >
> > > > Having said that, the binding is designed to support both decoders and encoders
> > > > for instance:
> > > >
> > > >         vpu: video-codec@ff9a0000 {
> > > >                 compatible = "rockchip,rk3288-vpu";
> > > >                 reg = <0x0 0xff9a0000 0x0 0x800>;
> > > >                 interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > >                              <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > > >                 interrupt-names = "vepu", "vdpu";
> > > >                 clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> > > >                 clock-names = "aclk", "hclk";
> > > >                 iommus = <&vpu_mmu>;
> > > >                 power-domains = <&power RK3288_PD_VIDEO>;
> > > >         };
> > > >
> > > > Hence the question is why do you splitted the encoder to its own node?
> > >
> > > It has its own IOMMU and is in a different power domain than the decoder.
> > > I think I have mentioned this multiple times before, including in the
> > > cover letter.
> > >
> > > Assuming you do not believe me, feel free to check the TRM, of which I
> > > am sure you also have a copy: page 475 of Part 1 shows the VPU being in
> > > PD_VPU while the JPEG encoder is in PD_RGA. Pages 478 and 479 of Part 2,
> > > Section 10.5, shows that the JPEG encoder (VEPU121)'s base is not the
> > > same as the Hantro decoder (VDPU121)'s base, and their IOMMUs which are
> > > based relative to their base offset are therefore also not at the same
> > > address. If you think the TRM must be wrong then, consider the fact that
> > > I have actually run this patch set, presumably being the only person to
> > > do so, and found that it works, so no, the addresses and power domains
> > > are correct.
> > >
> > > I do not see any way in which it would make sense to put this into the
> > > same node as the decoder. It would not even be possible to do this in
> > > your bindings, as they specify a maxItems for power-domains and iommus
> > > of 1. Even if I modified them the driver wouldn't know which PD and
> > > IOMMU belongs to decoder and encoder.
> > >
> > > I think if we put this encoder in the same node as the decoder, we
> > > might as well take this to its natural conclusion and put the entire
> > > device tree into a single very large node. It's not the same hardware,
> > > it cannot be modelled as being the same hardware, just because the
> > > bindings lets people model some separate hardware as the same hardware
> > > doesn't mean this applies to this hardware.
> > >
> > > Long story short, why did I split the encoder to its own node? The
> > > answer is that I didn't. I simply refused to combine it into a node
> > > that it has nothing to do with.
> > >
> >
> > As I've mentioned:
> >
> > """
> > the current binding models the idea of decoder and encoder
> > being the same device. This has never been really really accurate,
> > as the encoder and decoders have always been more or less independent.
> >
> > The reason for having them on a single device are mostly historical,
> > some old devices shared some resource. I don't think this is the case anymore,
> > but the binding was still modeled to support that.
> > """
> >
> > The PX30 and RK3399 VPUs are probably pretty independent as well,
> > and in retrospective, we should have done separated Device Tree nodes.
> > For historical reasons, we didn't, and we introduced those weird "enc_offset"
> > and "dec_offset" fields:
> >
> > const struct hantro_variant px30_vpu_variant = {
> >         .enc_offset = 0x0,
> >         .enc_fmts = rockchip_vpu_enc_fmts,
> >         .num_enc_fmts = ARRAY_SIZE(rockchip_vpu_enc_fmts),
> >         .dec_offset = 0x400,
> >         .dec_fmts = rk3399_vpu_dec_fmts,
> >
>
> As I've mentioned: that doesn't work for this hardware. It's not just the
> memory addresses. You literally quoted the part where I explain this, and
> then decided to completely ignore it.

I didn't ignore anything. I was just trying to explain you,
how the decoder and the encoder could have been separated for almost
all the other Rockchip devices, just like you are doing here.

> I will not explain it again, you
> have the explanation once more right in this e-mail. Read it.
>
> Not to mention that you've also ignored that I disagree with rob's
> assessment about interrupt-names.
>

I didn't ignore it, I just didn't reply to it. You think this is about
changing a dt-binding, but you are actually introducing a new dt-binding
since you are adding a new compatible string.

You are doing so by extending an existing dt-binding.

I am explaining you the _existing_ dt-binding models the (incorrect) idea
of a combined decoder and encoder. Since your device is encoder-only
and has a single interrupt line, you should omit the interrupt-names,
because it doesn't not add anything.

(About your dislike for the "default" string in /proc,  that is a
driver thing, which can be changed. It is not related to the
dt-binding).

> I'm actually done arguing with you, this is going in circles. v4 will not
> address any of your concerns, because it's either literally impossible or
> because I disagree with your concern and you did not actually address my
> disagreement.
>

Let's just wait for a Device Tree maintainer then. If you get a +1
from a DT maintainer for your dt-binding change, then I'll review and
consider how the rest of the patches look like.

However, it is very important that you moderate your communication,
you have been very pedantic and rude since your first reply.

Hope you can do that!
Thanks,
Ezequiel


> >
> > > > If we have good reasons to have separated Device Tree nodes,
> > > > then having interrupt-names = "vepu" for its only interrupt line
> > > > doesn't make sense.
> > >
> > > How does it not make sense? The bindings allow for a vdpu only
> > > interrupt-names, which in my understanding makes the same amount
> > > of sense.
> > >
> >
> > That applies for the binding for the previous existing compatible strings.
> >
> > You are adding a new compatible string, so just change the binding
> > so it no longer requires "interrupt-names", for its single interrupt line.
> >
> > Quoting devicetree maintainer [1]:
> >
> > """
> >  *-names are used to distinguish multiple entries
> > and don't add anything if only a single entry.
> > """
> >
> > [1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/
> >
> > Thanks!
> > Ezequiel
> >
> > > Regards,
> > > Nicolas Frattaroli
> > >
> > > >
> > > > > What does matter though is to be consistent in the bindings.
> > > > > interrupt-names is a required property even if there's only a vdpu
> > > > > interrupt. I modelled my vepu-only binding after this case.
> > > > >
> > > >
> > > > The current binding models the idea of decoder and encoder
> > > > being the same device. This has never been really really accurate,
> > > > as the encoder and decoders have always been more or less independent.
> > > >
> > > > The reason for having them on a single device are mostly historical,
> > > > some old devices shared some resource. I don't think this is the case anymore,
> > > > but the binding was still modeled to support that.
> > > >
> > > > Hopefully this makes sense!
> > > > Thanks,
> > > > Ezequiel
> > > >
> > > >
> > > > > If robh thinks there is no value to having the interrupt show up
> > > > > as anything other than "default" in /proc/interrupts, then I respectfully
> > > > > disagree with that opinion and point out that this should have been brought
> > > > > up when the vdpu-only case in the bindings was made to require
> > > > > interrupt-names also.
> > > > >
> > > > > Changing the binding now that there theoretically could be drivers out
> > > > > in the wild (though I doubt it) that do require interrupt-names, because
> > > > > the binding told them that this is okay to do, seems unwise to me.
> > > > >
> > > > > Regards,
> > > > > Nicolas Frattaroli
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Ezequiel
> > > > > >
> > > > > > > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > > > > > > +               clock-names = "aclk", "hclk";
> > > > > > > +               iommus = <&vepu_mmu>;
> > > > > > > +               power-domains = <&power RK3568_PD_RGA>;
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       vepu_mmu: iommu@fdee0800 {
> > > > > > > +               compatible = "rockchip,rk3568-iommu";
> > > > > > > +               reg = <0x0 0xfdee0800 0x0 0x40>;
> > > > > > > +               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > > > > > > +               clock-names = "aclk", "iface";
> > > > > > > +               power-domains = <&power RK3568_PD_RGA>;
> > > > > > > +               #iommu-cells = <0>;
> > > > > > > +       };
> > > > > > > +
> > > > > > >         sdmmc2: mmc@fe000000 {
> > > > > > >                 compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
> > > > > > >                 reg = <0x0 0xfe000000 0x0 0x4000>;
> > > > > > > --
> > > > > > > 2.36.0
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > Linux-rockchip mailing list
> > > > > > > Linux-rockchip@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > >
> > >
> > >
> > >
> >
>
>
>
>
