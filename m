Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B184F51560E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381042AbiD2Utn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380913AbiD2Uti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:49:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49084EFA;
        Fri, 29 Apr 2022 13:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63AF2B837B8;
        Fri, 29 Apr 2022 20:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27465C385A7;
        Fri, 29 Apr 2022 20:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651265177;
        bh=jsYCu34zYnPSZjXO3cgZgGRLcHie+luSSGL0NBVj6U4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OhO1aPIJflzlkvH6l9NkZnvTQzJN3xMRD3Ywi9dCUkaV/kAI+dCXRhzRIPPq0LJpz
         wf28K1qPxxmcDjx2bxndbwp8pVwz2WgaZfoUVBtxuVALnXaF5PtVVE4pESISezRiba
         KSUiijuh+HPypTZnkMzFr1j7EST6O+tTlWMXT6dkmBruRivHrmjntUP1zDgKB4uWgb
         rcJ44LffqCdtYSfnnvPxMtdKyHY9Xmk+xiT3oggCgyWMBOlETdsPG05vg1mj4vhlOt
         6DtBTaTiaFj4zVJajRF8qRi0lungzXyrw2JLatoVGPwi267UhYD8S7Wm3uHMHG5C59
         WzsFopcJEwW3w==
Received: by mail-pl1-f172.google.com with SMTP id n18so8126741plg.5;
        Fri, 29 Apr 2022 13:46:17 -0700 (PDT)
X-Gm-Message-State: AOAM531ZWgSZaIP0K0mvz4klF1iLowWCJJp50kTCu8uIJWE99Ke6e5nQ
        WWHhsUM6OfIZLBimfNeLJ4oGHYi/ih8AdQ8YzA==
X-Google-Smtp-Source: ABdhPJxDh/IIqErx1P3QaSmPVmtIcm9I8AiMy3H87xSJ1x1O7WSi1P0R8L8uDtqi7k+/5pFd9rNyA4GgTJdDIZzQBzw=
X-Received: by 2002:a17:90b:4a85:b0:1dc:64:1980 with SMTP id
 lp5-20020a17090b4a8500b001dc00641980mr5758549pjb.211.1651265176710; Fri, 29
 Apr 2022 13:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-2-sebastianene@google.com> <YmbonypWxzZJbjQ1@robh.at.kernel.org>
 <Ymqksfth+sj5JOWo@google.com>
In-Reply-To: <Ymqksfth+sj5JOWo@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Apr 2022 15:46:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKwR9Dq_zUhG7-KLJpHF=H2yLQBA8x09yfgSRscv2bhhg@mail.gmail.com>
Message-ID: <CAL_JsqKwR9Dq_zUhG7-KLJpHF=H2yLQBA8x09yfgSRscv2bhhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
To:     Sebastian Ene <sebastianene@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 9:29 AM Sebastian Ene <sebastianene@google.com> wrote:
>
> On Mon, Apr 25, 2022 at 01:29:51PM -0500, Rob Herring wrote:
> > On Mon, Apr 25, 2022 at 01:42:05PM +0000, Sebastian Ene wrote:
> > > The stall detection mechanism allows to configure the expiration
> > > duration and the internal counter clock frequency measured in Hz.
> > > Add these properties in the schema.
> > >
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  .../devicetree/bindings/misc/vm-wdt.yaml      | 44 +++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/vm-wdt.yaml b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > > new file mode 100644
> > > index 000000000000..cb7665a0c5af
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/vm-wdt.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/misc/vm-wdt.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: VM watchdog
> > > +
> > > +description: |
> > > +  This binding describes a CPU stall detector mechanism for virtual cpus.
> > > +
> > > +maintainers:
> > > +  - Sebastian Ene <sebastianene@google.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qemu,vm-watchdog
> > > +  clock:
>
> Hi,
>
> >
> > 'clocks' is already a defined property and 'clock' is too close. It's
> > also ambiguous what it is. 'clock-frequency' instead perhaps.
> >
>
> Yes, I think 'clock-frequency' is a better name. I will update it.

You are defining the register interface, so why not define a register
containing the frequency? Again, make your interface discoverable.

> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The watchdog internal clock measure in Hz used to decrement the
> > > +      watchdog counter register on each tick.
> > > +      Defaults to 10 if unset.
> > > +  timeout-sec:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The watchdog expiration timeout measured in seconds.
> > > +      Defaults to 8 if unset.
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    watchdog {
> > > +      compatible = "qemu,vm-watchdog";
> > > +      clock = <10>;
> > > +      timeout-sec = <8>;
> >
> > How does one access this 'hardware'?
> >
>
> This is a MMIO device.

Then how do you discover its address? You need 'reg'.

> > Why does this need to be in DT?
> >
> > We have DT because h/w designers are incapable of making h/w
> > discoverable. Why repeat that problem with s/w interfaces?
> >
>
> We need to have this one in the DT because in a secure VM we only load
> trusted DT components.

How does using DT make something trusted vs. any other mechanism the
hypervisor controls?

I would like to know from the virtualization folks (Xen/KVM) how they
would implement this feature? Certainly this could be reused, but then
we need an ACPI binding too for non-DT systems.

Why not use virtio?

Rob
