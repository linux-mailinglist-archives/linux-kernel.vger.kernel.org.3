Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17505265FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380657AbiEMPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiEMPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:24:01 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205F10E8;
        Fri, 13 May 2022 08:24:00 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id y63so10493715oia.7;
        Fri, 13 May 2022 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1J6Zu4Y3tOCa7n+k1s3WdHdTjmsh4OIORv9TDHyhOcA=;
        b=ZcNTRQT2JuijcTjsx5rT9wDW4pdmHcBSbzjNHXKRWjXhoFXxdczFmG0bbpu6nmY5NK
         +4ZdiLZwma6DCDQBe3ChBy92NObcMmRnJ2Y9m22R83AsQdbAD4xbqubC1quWjWUtEwqU
         kv5c7PcMvf1gTm9dj9fm3BVChXPoLrvK9vTA4Q7Fd21RZ+ONUpumkp4LjmOptST8Io+k
         6ZmlVmY+KxrqZ7EpXFdv0rLB7TnZFlkcYu6cIVEXXJpHxodKa1Dyv1WuF5FCu9u2RDIw
         cxESxYIwBIEX7yp2atMKcOKhu80zXt5zz72004DUNqxdap3d/Ghou2bWB+hjoJFcvSG0
         4AYQ==
X-Gm-Message-State: AOAM533lD1E0t3RtpEnuttHe+KZ40W+B+aH0S0DZ44S+dPljHfPMgY5s
        H05UjigSqyM1NyFr/NVNLw==
X-Google-Smtp-Source: ABdhPJzk7/dBLs+2vZIqFSUcjyOfATh31/401J+2A7wbSC1AORySmWax4qvXEnqYgRlz796HZj7exg==
X-Received: by 2002:aca:4154:0:b0:322:7a9c:7daa with SMTP id o81-20020aca4154000000b003227a9c7daamr7908697oia.52.1652455439736;
        Fri, 13 May 2022 08:23:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870a60200b000e99b1909d4sm1064987oam.25.2022.05.13.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:23:59 -0700 (PDT)
Received: (nullmailer pid 363506 invoked by uid 1000);
        Fri, 13 May 2022 15:23:58 -0000
Date:   Fri, 13 May 2022 10:23:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to
 rk356x
Message-ID: <20220513152358.GA334264-robh@kernel.org>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
 <14624530.8YKtBhKLIE@archbook>
 <CAAEAJfBczhKTmRQfteacN4rYmJPRSuWZBs1LUuVnMKJ_z0EUwQ@mail.gmail.com>
 <2024120.v6J0oxdlOP@archbook>
 <CAAEAJfDMG9ykJQHUf6oB5gjV_J0M+eycCqiUvDv2WjpC3g8dKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEAJfDMG9ykJQHUf6oB5gjV_J0M+eycCqiUvDv2WjpC3g8dKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:07:51AM -0300, Ezequiel Garcia wrote:
> Hi Nicolas,
> 
> On Fri, May 13, 2022 at 3:23 AM Nicolas Frattaroli
> <frattaroli.nicolas@gmail.com> wrote:
> >
> > On Donnerstag, 12. Mai 2022 23:33:03 CEST Ezequiel Garcia wrote:
> > > On Thu, May 12, 2022 at 5:00 PM Nicolas Frattaroli
> > > <frattaroli.nicolas@gmail.com> wrote:
> > > >
> > > > On Donnerstag, 12. Mai 2022 16:16:52 CEST Ezequiel Garcia wrote:
> > > > > On Tue, May 10, 2022 at 12:28 PM Nicolas Frattaroli
> > > > > <frattaroli.nicolas@gmail.com> wrote:
> > > > > >
> > > > > > Hi Ezequiel,
> > > > > >
> > > > > > On Montag, 9. Mai 2022 16:17:03 CEST Ezequiel Garcia wrote:
> > > > > > > Hi Nicolas,
> > > > > > >
> > > > > > > On Sun, May 8, 2022 at 5:26 PM Nicolas Frattaroli
> > > > > > > <frattaroli.nicolas@gmail.com> wrote:
> > > > > > > >
> > > > > > > > The RK3566 and RK3568 come with a dedicated Hantro instance solely for
> > > > > > > > encoding. This patch adds a node for this to the device tree, along with
> > > > > > > > a node for its MMU.
> > > > > > > >
> > > > > > > > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > > > > > > ---
> > > > > > > >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
> > > > > > > >  1 file changed, 21 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > > index 7cdef800cb3c..2e3c9e1887e3 100644
> > > > > > > > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > > > > > @@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
> > > > > > > >                 status = "disabled";
> > > > > > > >         };
> > > > > > > >
> > > > > > > > +       vepu: video-codec@fdee0000 {
> > > > > > > > +               compatible = "rockchip,rk3568-vepu";
> > > > > > > > +               reg = <0x0 0xfdee0000 0x0 0x800>;
> > > > > > > > +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > +               interrupt-names = "vepu";
> > > > > > >
> > > > > > > It this block "encoder only" and if so, maybe we should remove the
> > > > > > > "interrupt-names" [1]?

Please raise binding design questions on binding patches. I don't 
regularly review dts files.

> > > > > > >
> > > > > > > The driver is able to handle it. See:
> > > > > > >
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/hantro/hantro_drv.c#L962
> > > > > > >
> > > > > > > You might have to adjust the dt-bindings for this.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/
> > > > > >
> > > > > > What the Linux driver can handle should not matter to the device tree;
> > > > > > device trees are independent of drivers and kernels.
> > > > > >
> > > > >
> > > > > I guess my message wasn't clear, no need to lecture me on Device
> > > > > Trees, although I appreciate
> > > > > your friendly reminder of what a Device Tree is.

The independence is not universally known, understood, nor liked, so not 
unreasonable to point out. Your tone here is not any better.


> > > > > Having said that, the binding is designed to support both decoders and encoders
> > > > > for instance:
> > > > >
> > > > >         vpu: video-codec@ff9a0000 {
> > > > >                 compatible = "rockchip,rk3288-vpu";
> > > > >                 reg = <0x0 0xff9a0000 0x0 0x800>;
> > > > >                 interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                              <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > > > >                 interrupt-names = "vepu", "vdpu";
> > > > >                 clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> > > > >                 clock-names = "aclk", "hclk";
> > > > >                 iommus = <&vpu_mmu>;
> > > > >                 power-domains = <&power RK3288_PD_VIDEO>;
> > > > >         };
> > > > >
> > > > > Hence the question is why do you splitted the encoder to its own node?
> > > >
> > > > It has its own IOMMU and is in a different power domain than the decoder.
> > > > I think I have mentioned this multiple times before, including in the
> > > > cover letter.
> > > >
> > > > Assuming you do not believe me, feel free to check the TRM, of which I
> > > > am sure you also have a copy: page 475 of Part 1 shows the VPU being in
> > > > PD_VPU while the JPEG encoder is in PD_RGA. Pages 478 and 479 of Part 2,
> > > > Section 10.5, shows that the JPEG encoder (VEPU121)'s base is not the
> > > > same as the Hantro decoder (VDPU121)'s base, and their IOMMUs which are
> > > > based relative to their base offset are therefore also not at the same
> > > > address. If you think the TRM must be wrong then, consider the fact that
> > > > I have actually run this patch set, presumably being the only person to
> > > > do so, and found that it works, so no, the addresses and power domains
> > > > are correct.
> > > >
> > > > I do not see any way in which it would make sense to put this into the
> > > > same node as the decoder. It would not even be possible to do this in
> > > > your bindings, as they specify a maxItems for power-domains and iommus
> > > > of 1. Even if I modified them the driver wouldn't know which PD and
> > > > IOMMU belongs to decoder and encoder.
> > > >
> > > > I think if we put this encoder in the same node as the decoder, we
> > > > might as well take this to its natural conclusion and put the entire
> > > > device tree into a single very large node. It's not the same hardware,
> > > > it cannot be modelled as being the same hardware, just because the
> > > > bindings lets people model some separate hardware as the same hardware
> > > > doesn't mean this applies to this hardware.
> > > >
> > > > Long story short, why did I split the encoder to its own node? The
> > > > answer is that I didn't. I simply refused to combine it into a node
> > > > that it has nothing to do with.
> > > >
> > >
> > > As I've mentioned:
> > >
> > > """
> > > the current binding models the idea of decoder and encoder
> > > being the same device. This has never been really really accurate,
> > > as the encoder and decoders have always been more or less independent.
> > >
> > > The reason for having them on a single device are mostly historical,
> > > some old devices shared some resource. I don't think this is the case anymore,
> > > but the binding was still modeled to support that.
> > > """
> > >
> > > The PX30 and RK3399 VPUs are probably pretty independent as well,
> > > and in retrospective, we should have done separated Device Tree nodes.
> > > For historical reasons, we didn't, and we introduced those weird "enc_offset"
> > > and "dec_offset" fields:
> > >
> > > const struct hantro_variant px30_vpu_variant = {
> > >         .enc_offset = 0x0,
> > >         .enc_fmts = rockchip_vpu_enc_fmts,
> > >         .num_enc_fmts = ARRAY_SIZE(rockchip_vpu_enc_fmts),
> > >         .dec_offset = 0x400,
> > >         .dec_fmts = rk3399_vpu_dec_fmts,
> > >
> >
> > As I've mentioned: that doesn't work for this hardware. It's not just the
> > memory addresses. You literally quoted the part where I explain this, and
> > then decided to completely ignore it.
> 
> I didn't ignore anything. I was just trying to explain you,
> how the decoder and the encoder could have been separated for almost
> all the other Rockchip devices, just like you are doing here.
> 
> > I will not explain it again, you
> > have the explanation once more right in this e-mail. Read it.
> >
> > Not to mention that you've also ignored that I disagree with rob's
> > assessment about interrupt-names.
> >
> 
> I didn't ignore it, I just didn't reply to it. You think this is about
> changing a dt-binding, but you are actually introducing a new dt-binding
> since you are adding a new compatible string.
> 
> You are doing so by extending an existing dt-binding.
> 
> I am explaining you the _existing_ dt-binding models the (incorrect) idea
> of a combined decoder and encoder. Since your device is encoder-only
> and has a single interrupt line, you should omit the interrupt-names,
> because it doesn't not add anything.

While in general I agree on single entries don't need -names, given just 
'vdpu' is already allowed I would go with symmetry here and allow it for 
the encoder.

If you wanted to mark 'vdpu' alone as deprecated, then that would be 
fine too. No need for an if/then schema to disallow interrupt-names 
either. Eventually, I plan to (optionally) remove deprecated schemas 
from validation and that would have the effect of requiring 
interrupt-names to have 2 entries here.

Rob
