Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893B8511DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbiD0Rnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbiD0Rn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:43:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBABB908;
        Wed, 27 Apr 2022 10:40:08 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Md6dH-1oJNFF442N-00aF1u; Wed, 27 Apr 2022 19:40:07 +0200
Received: by mail-yb1-f173.google.com with SMTP id y76so4741080ybe.1;
        Wed, 27 Apr 2022 10:40:06 -0700 (PDT)
X-Gm-Message-State: AOAM5317ynu+vRQDP0skLbYfqrjDzhse8pBTLTU4kfc84sBdAPS3pEvw
        sUEBFla4uYCcCuDzONwFo5v6NMlndi3E+61b81w=
X-Google-Smtp-Source: ABdhPJzGG7dXTjLV/N930H2jECBxmcHfIENpJEZwy84Jm+PgNFN5BfeM0y2kC82NWH0UZJvpag8dzGlkFmBl+oiknr0=
X-Received: by 2002:a25:c50a:0:b0:647:b840:df2c with SMTP id
 v10-20020a25c50a000000b00647b840df2cmr20714873ybe.106.1651081205687; Wed, 27
 Apr 2022 10:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev> <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
In-Reply-To: <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 19:39:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
Message-ID: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F3hUzU1ZhjUCXqfGZZdr+hD2H1JhQqrVrIF9/SaNUA4k1FiLxJY
 aEtvEeOs68mbxIF0blAK60Ho4QPgvxVrxQQRKiI71DO3L6gEjNBzo0FWgcxGKFjuk/qjnvq
 lFEAjdYH1b9omEmPzXThYNfcsJpPueQ/cPLL02v+24+aSxpcA18j1JTGkiltTLVaid7VVJV
 gfNDbH9+TV8+nbIGq/jrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gRDZWsT3GOk=:8Z2kP0iAVqpXpZ2JgslY8e
 DXASlYGm9UadzjnVRjFUx2BMOUnFH29DPQicezvDGtXKwxQR2GgmnP4tNYbXcUf4esE2/mFko
 ohb36tfXsWcYqY3TjfHgeX7i/jZbymUdhAjpybWshby1nl1+2qy+tR2cNFuaRSrq1uu0XBcA1
 DiIXbkU/xrtuZvy5gdh3/lIkhNSlvkxbINkCKkqemiIwYDsn5vU/+hs66aGIrR0O4WmMvFlu3
 pkK43Dg/EyM0DZZY/eMnvqwLJyZyv0P7vUBL1oKu+6SbyIE9K1c+dI3g8QUgqDNj/M00CfHPv
 cIGMEMaDkowjuOFVOPpsPpsDmhrtX4HnyxNvEEd49Ya5CI82bVv9is7wv6CyoKkm8BgAto+Pj
 drSbK+jftyR4c8AoRIHH10EJkhWmhs1h6X5vIDXNIYR0p8cqQttSAbe0vHPObqyisS3y4VWRC
 HQur/ofP94X0aKaaLYj/jxXXZzAy0peEnLbFd7I7m8VgfpPsuTcdDMPk2cBdiYBr86ZaIZafT
 wUfEyNFE/zYrxtmPvSJw9rf8agB7EAD5r3teWrw9Zk4SM8oBlQIdRLk1Vk9SDK44GbtjL1i7e
 +g6dPQSuKbMXmMuTDJU6WdmliGe9BwL0sySqNFQeUJN2i/r/ivqJHIpOPEH0cgAq16v8xBHx9
 FRfrLegsXdNIup4DXNcVg58y/8X/oDfrEt53T4nxJx6m+xsXwGg41MyOKq5FU7Kg1DqW9j+xB
 JjXvMECNYxdehJOT/Oam+embJubksmwTfwGy/atVNR343Lt7UOaR0jl7JCGhCVLFoBAOcd/A3
 0f+L/5wguPfepyqb7bEfSANWgAvn3oeEgaY5CRBOi2dC3ZBslk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 5:33 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Apr 26, 2022, at 23:15, Arnd Bergmann wrote:
> > On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Makes sense!
> I don't think I'll be ready to submit USB3/USB4/Thunderbolt (which also needs
> RTKit) during this cycle but I think there's a decent chance marcan will submit
> SMC which also depends on RTKit and will go through a different subsystem.
> What's the best way to handle the RTKit commits in that case?
> It would be great if we could get both into 5.19.

The usual trick is to have a branch with the shared patches and have
that pulled into every other tree that needs these, but make sure you never
rebase. In this case, you could have something like

a) rtkit driver in a shared branch (private only)
b) thunderbolt driver based on branch a), merged through
     thunderbolt/usb/pci tree (I don't know who is responsible here)
c) sart driver based on branch a), merged through soc tree
d) nvme driver based on branch c), merged through nvme tree

since the commit hashes are all identical, each patch only shows up in
the git tree once, but you get a somewhat funny history.

        Arnd
