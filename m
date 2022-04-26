Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A81510AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355180AbiDZU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354172AbiDZU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:59:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804623BDC;
        Tue, 26 Apr 2022 13:55:56 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mn2Jj-1oBwtR32BD-00k8AD; Tue, 26 Apr 2022 22:55:54 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7b815ac06so119883017b3.3;
        Tue, 26 Apr 2022 13:55:54 -0700 (PDT)
X-Gm-Message-State: AOAM531c/I0RGyxqBLDaVfLZu6TJuKPc6VRH54LNIQzlN53DL9cn5vsO
        0wocP/GzquO5zE+7873Oz5+kXPlZMU5EgqR4TSc=
X-Google-Smtp-Source: ABdhPJykVbC51GHiNxSRF22iubyVclEPEIn++KiZqruq+/JC2nxl37pjEPmurLqJ7gUHZrZwTtprNFSeiezKdA6Gjr4=
X-Received: by 2002:a0d:d804:0:b0:2f4:e47d:1c2c with SMTP id
 a4-20020a0dd804000000b002f4e47d1c2cmr23664046ywe.320.1651006553470; Tue, 26
 Apr 2022 13:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev> <20220426201539.12829-5-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-5-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 22:55:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39t-yyhtVKiEvD9_FvLiVxySnJRXaOv4E4q77t6mDesw@mail.gmail.com>
Message-ID: <CAK8P3a39t-yyhtVKiEvD9_FvLiVxySnJRXaOv4E4q77t6mDesw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] soc: apple: Add SART driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aCEZ6RBb3tpXSd8jlPQICSalKhz/lcJThhMJ9qtj94Ow0K3Qwv/
 pusAWlNyx3fi4froZHrjvIJL7JdWmeXgU+TAOnk4QNw4+tS1+jquXFQJJmY5mWc1eAEk2lz
 fNPGBZp7Kxbtc1iv2PYOjbQM+OJXdlzDWm9Lr1foO9Yt+3eNWz2gdJjc90sL80MIelVe2m5
 iwa95pM6GQ4ek+hx0ethg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A2bn5Um674o=:tIiRX89DHd3lVxumZ100zH
 eRHmP3e1wCYkbq8MRref0+xJysSUJxebo3I+ufrjeK0AeCcYCCf3K7I5Brc/7n9qKnCWTN2df
 ahq2FzPtHLRao8HXnPyOPY03EBvyph/NZG0xfFOrKgYq7VZZjJ8l8uuS7P6vr/IwTuv/Fnt07
 P/DCxz7n+/gQmRKPdOH7eLGyC7Gn2uF18S/8l6Z8TAHanC6MjREjDM3ERj+ZpYXLagJuUpUKz
 PCcjUuzaOjgPFVnYG7/vS0zq6H/iSUuna+zLmf6DndhTl9xywWebH2du+eLayAA0xB3OjYjv4
 /nVHH/PbygHzO9IQVZ1aPeQZJPOzuaZtbTcGus/TX82Fi5dPKRRhjASAn2fbqb3Sle+zzyjMS
 cdWiN3JLmZIU8zi3cLipCmmN/ey4D2BRThMFITT1ChCbjIXP1UujmkkscV06MgJ6II94zr9ti
 kk9ZwPzzu6Bu1HitHUaZo1i0dvTlNnY41BM9j80YwR5tW0/9S2XeX+4Rc4DycKYjcD77XcMG1
 F4hFksUdJoBa5Md+cjT62GDsTmFqMp0iJR8fAD3TRO6e8US5P6ycgfldI58wEPQgD0fwbul6O
 Lj+XKXk9aynDJO5oBDxv1s+IjTQjbqtXfw7T0bbdt7ZzAwYxw40q0p8juRdb/4Tu5HwV2rSGl
 czqW9IWEIhhT4H1wKaO5dFbULPfqp9WKH2JTjOBLO3WaR2KhZpv6j/4ItUFCX60ZFgiI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> SART for some DMA transactions. This adds a simple driver used to
> configure the memory regions from which DMA transactions are allowed.
>
> Unlike a real IOMMU, SART does not support any pagetables and can't be
> implemented inside the IOMMU subsystem using iommu_ops.
>
> It also can't be implemented using dma_map_ops since not all DMA
> transactions of the NVMe controller are filtered by SART.
> Instead, most buffers have to be registered using the integrated NVMe
> IOMMU and we can't have two separate dma_map_ops implementations for a
> single device.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One more detail I noticed:

> +#if IS_ENABLED(CONFIG_APPLE_SART)
> +
> +struct apple_sart;
> +
> +/*
> + * Get a reference to the SART attached to dev.
> + *
> + * Looks for the phandle reference in apple,sart and returns a pointer
> + * to the corresponding apple_sart struct to be used with
> + * apple_sart_add_allowed_region and apple_sart_remove_allowed_region.
> + */
> +struct apple_sart *devm_apple_sart_get(struct device *dev);
> +

In general, I don't like to hide declarations in a header behind an #if. Unless
there is a good reason for doing this, just make the declaration unconditional,
which avoids recompiling when the symbol changes.

The only other effect is that you get a link-time error instead of a
compile-time
error if you messed up the Kconfig dependencies, but as long as the dependencies
are correct it will be fine either way.

      Arnd
