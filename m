Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6252C0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiERQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiERQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:39:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39316F93F;
        Wed, 18 May 2022 09:39:26 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N63JO-1npMbU28vQ-016PHS; Wed, 18 May 2022 18:39:24 +0200
Received: by mail-yb1-f175.google.com with SMTP id v71so4646073ybi.4;
        Wed, 18 May 2022 09:39:24 -0700 (PDT)
X-Gm-Message-State: AOAM532l8m8lEszDoj70Q9bmmqfVAJcoCtndPIiTWhKzJVVK4wAiysQj
        LqvGooPp3FLdd8CL4XL5Tw25IChUez5HjYRD8bc=
X-Google-Smtp-Source: ABdhPJzgO+qZWLWCVNG0zigCWvcyaAMnm3eGdOmvWgnrUQyVgjytOzSGXEWpAN07OlHuwbLMC0znLO5cjVzishwdUG8=
X-Received: by 2002:a25:cfd7:0:b0:64d:9526:1ed4 with SMTP id
 f206-20020a25cfd7000000b0064d95261ed4mr487184ybg.106.1652891963222; Wed, 18
 May 2022 09:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com> <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
 <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
In-Reply-To: <56e8c32d-6771-7179-005f-26ca58555659@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 17:39:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
Message-ID: <CAK8P3a1YhkEZ8gcbXHEa5Bwx-4VVRJO8SUHf8=RNWRsc2Yo-+A@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To:     Oleksandr <olekstysh@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jason Wang <jasowang@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l6Zmm0Lt2Cs3Lj3V/oRAG1XoFxKRLpZyyELmAAmBae16I65msdd
 5JM6bkwu7sJPAOaiw//CuKljLbLeZcxBAaKafhVBllY8NkFvtnW312uXnwxG1PpeLelGKJe
 qMT6rxYcCLtfBuOzoyCyJGtUnj3lnf2371xiIqY969MkIQzN0PTHgOe65AdXgsRe8p2wPUZ
 Ci1OTFOHAUzcBUD0PNqIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6JupdEVbEI=:IVS+G9GEQ5TsiitUcqK9BO
 jzKYAZxO0bn70RdppsRPMUII0MihQqTtSkOAPfNbM9AQQap4U25NhvYinbRizJuqEXvEtP+gs
 O1iqiZ9m2GrrLMDYQrYBxYaUUaqrdxR9hmy6NxiAcvaKezWxmQwgrqQzJxsn+S2iCpeBBQseZ
 j3W8mN0IiiQ3YTY6gQBAhzLM0h/UyjuHJwBixIhjd/ur6fQ8hrZSiNU+jMcUfFQjT5yo1FcZu
 iFcj9L6FnlPAIE/XQ1t3wgDwNXmts8ZZ1jWheZ0mXGl1e1eCxMjn0JOetjO5KR9hDZX8l2Jig
 M/KDdEZakfN9yjk9a6f/nNKT2orkGPoYLy/8zlVJCSMMqJ5f9ri1M1GkiNb7IvFjAIZK5MLdS
 KSK5zCvAjwSkRg04WBRwYRyUIUc6vUJAGbnprDlOF6K6SHUiMoYPiE5VMHsB+uPfc9f6tSMyF
 Ql9dh1/fvuG4eOHt5V8OXugiwgpuXthOW4W5DlRrydmY9kXFt3p43WdoiL3Mo/QSfx6TPy/5q
 PVeQ1Lr995aIILAGl+mTbHbprEMoK1ukNI4rW6E+SRGpF+/Gli22rJiGtn83yV3GRR+oJ9aD8
 P6IsGMrtmCrOKs0aXm6phDpv+qwcX1vBSCZnGCH/XdMUUXSMpXVxdbrjt4RPnnQOP9KMJdQRb
 hNwKjMOrMoYk9fXPqg9mu0Z9cawdyi8w7V6iVWcK0khHf/qNQPwbovPxG17h0Ao+SUfRFs1JN
 MMaVUJOGfXc0fRfN6WWDrOFc0uGrMr7phYr0JQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 5:06 PM Oleksandr <olekstysh@gmail.com> wrote:
> On 18.05.22 17:32, Arnd Bergmann wrote:
> > On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>
> >   This would mean having a device
> > node for the grant-table mechanism that can be referred to using the 'iommus'
> > phandle property, with the domid as an additional argument.
>
> I assume, you are speaking about something like the following?
>
>
> xen_dummy_iommu {
>     compatible = "xen,dummy-iommu";
>     #iommu-cells = <1>;
> };
>
> virtio@3000 {
>     compatible = "virtio,mmio";
>     reg = <0x3000 0x100>;
>     interrupts = <41>;
>
>     /* The device is located in Xen domain with ID 1 */
>     iommus = <&xen_dummy_iommu 1>;
> };

Right, that's that's the idea, except I would not call it a 'dummy'.
From the perspective of the DT, this behaves just like an IOMMU,
even if the exact mechanism is different from most hardware IOMMU
implementations.

> > It does not quite fit the model that Linux currently uses for iommus,
> > as that has an allocator for dma_addr_t space
>
> yes (# 3/7 adds grant-table based allocator)
>
>
> > , but it would think it's
> > conceptually close enough that it makes sense for the binding.
>
> Interesting idea. I am wondering, do we need an extra actions for this
> to work in Linux guest (dummy IOMMU driver, etc)?

It depends on how closely the guest implementation can be made to
resemble a normal iommu. If you do allocate dma_addr_t addresses,
it may actually be close enough that you can just turn the grant-table
code into a normal iommu driver and change nothing else.

        Arnd
