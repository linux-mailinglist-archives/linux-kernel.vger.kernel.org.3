Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C64F066D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbiDBV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDBV2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:28:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8883252A8;
        Sat,  2 Apr 2022 14:26:46 -0700 (PDT)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MbAYo-1o7c323umW-00bY9M; Sat, 02 Apr 2022 23:26:44 +0200
Received: by mail-wm1-f44.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso3413631wmn.1;
        Sat, 02 Apr 2022 14:26:44 -0700 (PDT)
X-Gm-Message-State: AOAM5322Clzfnf/qwSNK/kgsENGPMT97WynnqBMnVAe1Wso/xJZokitl
        60brgr31KhgccU3BFtc1bt3r0VQiBzLt3Id0ccU=
X-Google-Smtp-Source: ABdhPJylADU8u1Uad2avcKqoy4J12Y7Ldo8r2ly4hCBr2blS2EVb+EGXxI00qvmV4NpEdPUxq7mTzkMgGKL7bOTsU7M=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr13758469wmq.174.1648934804584; Sat, 02
 Apr 2022 14:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev>
 <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com> <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
In-Reply-To: <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 2 Apr 2022 23:26:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3d5XmtXxGwVHFSyNraOJdTaFCG1s+LNev=39eLXxGFHg@mail.gmail.com>
Message-ID: <CAK8P3a3d5XmtXxGwVHFSyNraOJdTaFCG1s+LNev=39eLXxGFHg@mail.gmail.com>
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QVlumoECcVTiHC5u2S6Rwvxgn5vdkFihYQYtznc++DhQvJ0F2RK
 ZxtOtoSPeY5khKzM3uVVpREH9ML7BSTfAkH/Kj5Numjl7p5Glx7Phv10C+9LYZkQDTXQ5Bh
 WWGgTGgHnVD6jrRIi+ysVHNwFuLGJyUIFOasFbT8BF0CXjq1kucH06rq8MRM6ih2Q7EpAD0
 qGlZDBI9aTNflsiDx3vAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pFhRKGiCbjo=:1N0YG1QrJF/QXWd9niqOW7
 0Gtz5sVAx85pNw/WcR406dvkC1b2nta17SmsrgEDR/S9uIJYCBXF3SAPDVPBq0mTULFglJA2b
 mVrhPKo7KM7MKvIpd1C3Fy9lmlP6qUwRAQXgXkYahkhSn0W0EXk4DnmCn6C509wTe4A/x9AK9
 eh5GQxhekhq91CsLoiOMWsBYdVSlMaYDD4WgD7f9iVjKibAR+AGcCpvnpaILbU69BRVpMjpln
 +rGEDkBhJAX46bn+Ux6ujeThhOcC8S0J/iSfFGO7R3phB6gKbXaosUJJoFEZlcDV3+pHmLK1N
 otnGRRP0Cju3bBp5RpGwHC8GbVGJcRbbcLobejJVdL+boBCBV6qyAjVpY8SdHOexFD7hXpH5B
 YsvI+TuJdzfyjJUtfBXsV61+jtS37U+T0HV8PC6z8VwTGkXn2jAdFZIp0SusPsODFuDYpP2E4
 Y1FZS87VbbvRyF4RAcKP3Y32D405L/JiN01gSmLWmOW2liFw8DIgXwW1m4E2iHuI9c65Mypa0
 N+vXLekHd5OW87k9Gpe3MqjLTRbQfW49vg5wm+ErDYk26HD4yaKPjMwz+dWdzKxVNDJtbpblW
 SBcQSdGgfnatGe/T4Az0SbO448nmqPMHMNMi6svahoNAqxGt5mCajxp3e1+UIJMkZSGhnkzW6
 zmsMdnYmRcylLg7ETIRSipMkmcmcGQiu9qZ84XJBUiGL+HXXckZq+lXmZcYieNFzYtDA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 3:34 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 22, 2022, at 14:38, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:

> >> +bad_sgl:
> >> +       WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
> >> +            "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
> >> +            iod->nents);
> >
> > I think you mean WARN_ONCE() here?
>
> This is taken from pci.c which used to use WARN_ONCE but was replaced in
> d08774738446e77734777adcf5d1045237b4475a with this construction here.
> The commit message mentions
>
>     The WARN_ONCE macro returns true if the condition is true, not if the
>     warn was raised, so we're printing the scatter list every time it's
>     invalid. This is excessive and makes debugging harder, so this patch
>     prints it just once.
>

Ok, makes sense. If we get more of these in the kernel, we may want to
add a helper that makes this more obvious, but it appears that for now
these two are the only ones.

It could also be expressed by moving the WARN_ONCE() into the
condition above the 'goto', but I don't see a reason to change the other
driver and it's better to keep the two consistent.

> Agreed, I've actually tried replacing all non-relaxed ones with the normal
> accessors (even those inside the hot path) and didn't see any performance
> difference.
> I can use the normal ones here and I'll consider using the non-relaxed ones
> in the hot path together with a comment why they are safe in those places.

Sounds good. If you find any instances in the hot path that have a
corresponding version in the pci.c file, it would be good to keep these
two in sync, hopefully making the non-apple case faster as well.

        Arnd
