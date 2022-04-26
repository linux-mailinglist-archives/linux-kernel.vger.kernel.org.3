Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B75510BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbiDZWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiDZWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:23:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B681DA78;
        Tue, 26 Apr 2022 15:20:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIKs0-1ng81J3aBI-00EPJk; Wed, 27 Apr 2022 00:20:22 +0200
Received: by mail-yb1-f180.google.com with SMTP id y2so199659ybi.7;
        Tue, 26 Apr 2022 15:20:21 -0700 (PDT)
X-Gm-Message-State: AOAM530dksNh2Wr7t3Qi2voZaXX87UE2D6ey4u8pwQGyAikY8TJPvJPO
        XNn3rbx3kkmtA4RsP8jQkuJozSBaT/CpLXrfj18=
X-Google-Smtp-Source: ABdhPJzbAvI1S2GyRLREWapjSXfR+JqwT+LmqG09UCM4q8/CHei88Q5j9UOL+o3W1tRf1uMqf75Cr4X40ZB+iuMcOqE=
X-Received: by 2002:a81:1dd1:0:b0:2ea:c38b:65a8 with SMTP id
 d200-20020a811dd1000000b002eac38b65a8mr23947273ywd.135.1651007764178; Tue, 26
 Apr 2022 14:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 23:15:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
Message-ID: <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CixkS2E+mlKw5pzPwhyDCC/8HxFvnr3fmZhK4GHAcYfDZLts8XD
 iRk6lX964SAVPkFxrZ/mvnfFOZqTYsJwrrxsz68R7hh8hD3EgkHIAXjDnn1U5jXuBZzFe1n
 6dK/Yg2qoYt6uy7WOgeTbIVUWY5F256u/Bbw7jmgkf17u9vvr8YzZw8Ra89GQrhgiZYfGZX
 5z7fbK4CeEyXTNuv0Eufw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SbbhEI0rkWg=:eUZEiUHFZiKJDS2DW1SQee
 Af1x9PLsKdCkbbKeD8NVLB7QpGG5RG/133tp4hDAyQynhS0kKk98FMyhTRxYOsqQDS37bwCd1
 wt+cJNB94WAdhWbE+mMkJAqDFYOVzdk6R+9ZP8jVQPMmCrcrk2TJ+Hw8e4wliHsy9CpP9l/8O
 PQG6wHCWSUlVj67hpUt88pzfch3N1ntrRw7KgFMf5xMdLgAoYHaE8Cbta2oNNuBSCrc5HXUeZ
 gCL0Ml0HAoUT+w8xIqyBSXqVPbo07nxmXTriWu/7ekYKS9M5cDk26fQUK2tXKy3GG1cgFG6ZD
 SHo95Gu6sJE2e0c82cnYlZg/VV6reXmOVNY88HgLH4hxtBCmbLRUTxuvnIv9rvVuxPvum4XnZ
 puQp+e+pMb6hQ1F/zBcQQgcfLEcpHeG2xpS1jCcJ99dbPeYEB6oJcr4Gv4MtMfK2RlslMYU2+
 fPJyQ4als5hYkfKBryHMSPB8wEia19dqs5Aebx3hIED9mH2nUR89/hS2JsYS3Ezf1CbNOW1tT
 dDnsB6P95KGpAr06AMk1yZrGYbPbY8yfMq1rTXQvD79ZjcNi4SSNDKtVDAVLy0+R50sd1JFhb
 sQ+Y7gx68+soP32QPvvOTbrk+MqzpHBjJIFW2lI5/f8PtYNgeF9IcJT7xOXqZ8v5/wwD6dd24
 /B1njLN+7qFQ6tyWEJ0BEt+yrHnh1pXcecmRORlXktMG74OKmsZqP89e6a31T8nzBckOx2iEx
 quSjsSrO85b1J6MwAhudajmp5FQEr0auEeJK4VehP44ViQClo7PCoiZdaDxvrDMemURC6TOds
 5uCmLIA27bF2UM/rTyoYphqapqcR/PnwsnzU3oAV207r/TQblk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Hi,
>
> This series includes everything[*] required to get NVMe up and running on
> Apple's M1, M1 Pro and M1 Max SoCs.
>
> v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/
> v2: https://lore.kernel.org/linux-nvme/20220415142055.30873-1-sven@svenpeter.dev/T/
>
> Thanks everyone for the reviews of v2 again! There are just some minor
> changes since v2 listed in the individual commits again.

Nice! I had not looked at v2 in much detail, but I'm perfectly happy
with this version,

I found a few things that could be improved if you do a respin, but
nothing important.

> [*] The only missing part in this series are the device tree updates
>     but since these will go through arm-soc anyway I haven't included
>     them here but will instead submit them once this series is in a shape
>     where it can be merged.

Just as a clarification: the drivers/soc/ portion should normally go through the
soc tree as well, but I'm happy for those to get merged along with the
nvme driver
if that helps get it all mainlined more quickly.

       Arnd
