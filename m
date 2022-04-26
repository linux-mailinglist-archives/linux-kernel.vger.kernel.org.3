Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16F510AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355242AbiDZVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbiDZVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:05:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0649F02;
        Tue, 26 Apr 2022 14:01:59 -0700 (PDT)
Received: from mail-yw1-f169.google.com ([209.85.128.169]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA7Om-1nZ2Cd3Jb0-00Bb4f; Tue, 26 Apr 2022 23:01:58 +0200
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ebf4b91212so196251937b3.8;
        Tue, 26 Apr 2022 14:01:57 -0700 (PDT)
X-Gm-Message-State: AOAM531Jmeb+wXxwTPybB2cgpXPepoLVRfxSs+7joNgFzGXF4h3ycNPo
        rLFlIWRRGqZwYgeg2+XHIlkkYlRn3WsiKYh65F4=
X-Google-Smtp-Source: ABdhPJy/86FV4KH1867Lm15JAmIgDQfnAK7NPGjdzs+ZuMReM3UPpqkZq2mfK0iy60GKZRpX6sFCtSy2EluixJ9sXoM=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr24255532ywf.347.1651006916466; Tue, 26
 Apr 2022 14:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev> <20220426201539.12829-6-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-6-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 23:01:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
Message-ID: <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] soc: apple: Add RTKit IPC library
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
X-Provags-ID: V03:K1:VFuEeW327at2nyzcIChUDGMSvIHITn2NnxbxqxgCaeMKNpJmsUO
 jnlVBDQfKm+tf2Ujlx7tT9KVIRJtRKNIBOtuWIfvGLYMWMqEVNgj2AxpcHEJ3D67QeD/4xl
 qmpcl3CipxYTvMYnrgkQsQDWR84sBfxIgYOUohin4Tx4JnqYj6h5K0IMoaP6LusNIbymNcR
 KHoQ7UweTkKgRBrFCspOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8nUuzV/p2Ts=:OutXrVNzlQMqqtGLdguG+f
 LHoaPt60bV0y4R8hbYReEFkiUPmFufZR6swS1GxW4JoRr652ky/QDPUMiY+wQ56nulzEWM4Ov
 +lKb59Ne0CtN8jt/JT5qg/lNkGSRXtykbvVG8RbJ5/o2jvYz++2qoz7FUbtaBpHbci9Ce6+51
 8CooEFkvmXS6TFrDmeNYee/WDBS1BuTs1k3Dna6hiGftRk7DUbWd2J4IUE0ITOTNCXNmzNHKB
 iPHWZoi2AlbAtZjLGcJYxjC9bl2tztiytrICUWMGAJG7TgdRjGGPyxNPfu9tWV73W9YaDk4AS
 sdbZ0n3N3QxCbtywPlRwMm4g5k49IzbcTYN7wKlCA2GU/u5lc2pGTpEtYgYzVfuYeVKobOo4q
 H7GS1JThs4QyI4njyXxmFAcZugEe+XENpkYK/hf+lHqd2LOW3OB7K6a0kT8a9RUTZc7RijHMa
 O5LZm3GLlYNzS37hrU0s0v3ivK2OtQnW2nwsfEZ4V83kpEtvTjzSpCX+iY0grxX1b7Qqms46f
 wJymGFPEr2RUxeWFU/+8soKHnpu9OTqIoLXAm8xIbkie3gfkFwgjVoFnhTpHXe8Nw+aOLO/j1
 7aq4LwbLzK0dfoXTy8Zb+XvC1ADcz7dEMD9+NlywHHWPf7ZE2kUr9z1k2Y4eo1PKLb/1fhshE
 TfxziD8aba45hn00hWBvSiEhKlDLMNLKIOXcbobSMJqMC61G4R/rE0PeN08SRqKU1P3/UUpa9
 sNbL+TiCrqyIkJOqBjTQQABGtk+mnTjcNu2oGQjW9Sbe5GMRilmzuIjd3t3OfDImUuszMyUn/
 rYFtais8nMINdn/3SOv0/9ngrObOF0oj2DBj0iQH5U7HjO9yPU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
>
> This cannot be implement inside the mailbox subsystem since on top
> of communication over channels we also need support for starting,
> hibernating and resetting these co-processors. We also need to
> handle shared memory allocations differently depending on the
> co-processor and don't want to split that across multiple drivers.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +bool apple_rtkit_is_running(struct apple_rtkit *rtk)
> +{
> +       if (rtk->crashed)
> +               return false;
> +       if ((rtk->iop_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
> +               return false;
> +       if ((rtk->ap_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
> +               return false;
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(apple_rtkit_is_running);
> +
> +bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
> +{
> +       return rtk->crashed;
> +}
> +EXPORT_SYMBOL_GPL(apple_rtkit_is_crashed);

I noticed that you use EXPORT_SYMBOL_GPL() here, but a more permissive
EXPORT_SYMBOL() in the SART driver. Is that intentional? I would have
assumed that both are similarly private to the apple SoCs and would be the
_GPL type, but this is something you get to pick as the author.


> +
> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)
> +

Same comment about the #if as for the SART driver: I'd prefer it without the
conditional compilation.

       Arnd
