Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7E4D4ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiCJOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbiCJOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:20:52 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9116A10D6;
        Thu, 10 Mar 2022 06:19:51 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so6859142ooh.8;
        Thu, 10 Mar 2022 06:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3W/Ki5qpGDEFWKMk7J7E8+Sx1qx4QiEdndntXWsLJJo=;
        b=Ip0WAWLy+dn1sMctdsuJo5pDUkIl9qdZgYX38nAjIUWhur9Y1uGlNtmBSUlY9dbUGM
         yb10n122GLmhFpCXq+hWNPe0TCtX8TNcmhkyD2F5lzBWTwtoaLWdSpH76nsnMY2paHvF
         pHbPmpHhlT2QiqEbO4+eX2/5/N27A/hAZyj/C35dRxvxw2rP9Bq2PV3i3lP42WVN72uc
         YJlYaBi3U8bgBvI0KeTNwh479d+bUOgz08EJarCfwLd3Wutn3L4hbVlFcTKQT0c9QQ74
         rK7sREFgO8BeRrEzgt+hJ50VdX1VK7z/OpptoYBX9SI9bJ+9iooikTrb8hRMt+AS7w/h
         TT9Q==
X-Gm-Message-State: AOAM531xlm+JxmJc0dPjggMGm0X/hMYtlMzpEwF2qHfYn1kLj2P+rKRe
        7nRkd/+11zJfOqp3QlEc5eIQngxFJg==
X-Google-Smtp-Source: ABdhPJzLQb+1MVtYdE1o45AtniXUkVnyGAHMsHASWKW9w52BpjEdb/3jkpPrqvjFst6yafyQZQu4tw==
X-Received: by 2002:a05:6870:796:b0:da:3d6a:101d with SMTP id en22-20020a056870079600b000da3d6a101dmr2781905oab.20.1646921990718;
        Thu, 10 Mar 2022 06:19:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 68-20020a9d0a4a000000b005ad3287033csm2451415otg.44.2022.03.10.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:19:50 -0800 (PST)
Received: (nullmailer pid 1611493 invoked by uid 1000);
        Thu, 10 Mar 2022 14:19:49 -0000
Date:   Thu, 10 Mar 2022 08:19:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Convert QEMU fw-cfg to DT schema
Message-ID: <YioJBWPxuE+T9g9g@robh.at.kernel.org>
References: <20220310013552.549590-1-robh@kernel.org>
 <9651bc36-3da0-4e2b-1d29-bb4b3ce1389d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9651bc36-3da0-4e2b-1d29-bb4b3ce1389d@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:05:04AM +0100, Laszlo Ersek wrote:
> On 03/10/22 02:35, Rob Herring wrote:
> > Convert the QEMU fw-cfg binding to DT schema format. As this binding is
> > also used on Risc-V now, drop any architecture references and move to a
> > common location. The fw-cfg interface has also gained some DMA support
> > which is coherent, so add the missing 'dma-coherent'.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/fw-cfg.txt        | 38 -------------
> >  .../bindings/firmware/qemu,fw-cfg-mmio.yaml   | 54 +++++++++++++++++++
> >  2 files changed, 54 insertions(+), 38 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
> >  create mode 100644 Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fw-cfg.txt b/Documentation/devicetree/bindings/arm/fw-cfg.txt
> > deleted file mode 100644
> > index fd54e1db2156..000000000000
> > --- a/Documentation/devicetree/bindings/arm/fw-cfg.txt
> > +++ /dev/null
> > @@ -1,38 +0,0 @@
> > -* QEMU Firmware Configuration bindings for ARM
> > -
> > -QEMU's arm-softmmu and aarch64-softmmu emulation / virtualization targets
> > -provide the following Firmware Configuration interface on the "virt" machine
> > -type:
> > -
> > -- A write-only, 16-bit wide selector (or control) register,
> > -- a read-write, 64-bit wide data register.
> > -
> > -QEMU exposes the control and data register to ARM guests as memory mapped
> > -registers; their location is communicated to the guest's UEFI firmware in the
> > -DTB that QEMU places at the bottom of the guest's DRAM.
> > -
> > -The authoritative guest-side hardware interface documentation to the fw_cfg
> > -device can be found in "docs/specs/fw_cfg.txt" in the QEMU source tree.
> > -
> > -
> > -Required properties:
> > -
> > -- compatible: "qemu,fw-cfg-mmio".
> > -
> > -- reg: the MMIO region used by the device.
> > -  * Bytes 0x0 to 0x7 cover the data register.
> > -  * Bytes 0x8 to 0x9 cover the selector register.
> > -  * Further registers may be appended to the region in case of future interface
> > -    revisions / feature bits.
> > -
> > -Example:
> > -
> > -/ {
> > -	#size-cells = <0x2>;
> > -	#address-cells = <0x2>;
> > -
> > -	fw-cfg@9020000 {
> > -		compatible = "qemu,fw-cfg-mmio";
> > -		reg = <0x0 0x9020000 0x0 0xa>;
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> > new file mode 100644
> > index 000000000000..3aac9448e7f1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/qemu,fw-cfg-mmio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: QEMU Firmware Configuration bindings
> > +
> > +maintainers:
> > +  - Laszlo Ersek <lersek@redhat.com>
> 
> Ugh :) I guess this is based on my authorship of historical commit
> 53275a61bc7a ("devicetree: document ARM bindings for QEMU's Firmware
> Config interface", 2015-01-13), and prehaps my R-b on commit
> 92aed5d6ba90 ("devicetree: update documentation for fw_cfg ARM
> bindings", 2016-02-09).
> 
> However -- I totally can't maintain this file. (I mean I've probably not
> done anything related to it in the past seven years, so I guess it's
> time to admit that fact!)
> 
> Rob, would you please consider taking it over?

Yeah, no problem.

> With my name+email replaced with yours:
> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thank you!
> Laszlo
