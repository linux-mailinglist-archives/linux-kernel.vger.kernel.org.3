Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD45155B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380805AbiD2Uhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348455AbiD2Uhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:37:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B77D890E;
        Fri, 29 Apr 2022 13:34:11 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MsI0I-1o0XhT3RYw-00tgcR; Fri, 29 Apr 2022 22:34:10 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f7bb893309so96691527b3.12;
        Fri, 29 Apr 2022 13:34:09 -0700 (PDT)
X-Gm-Message-State: AOAM532rxromeFZx8orO5hOHchjbE54LKfDWxMdlUd5Swbw//PE9+j/3
        UsW6EFR2dL8rmIca8urwxofEZXpk773qXu3qJMs=
X-Google-Smtp-Source: ABdhPJxmchRzlwbhUzJrTXSW5O46V9uTUf564hU5vkqZRRFSlvWrH3L90d9vRfJr0xR1Zvdx0EHMPavAkqrxafxfaRE=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr1115356ywf.347.1651264448577; Fri, 29
 Apr 2022 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev> <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com> <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
 <20220428142412.GA19708@lst.de> <be7e0eb1-c423-455f-bd89-050d52996340@www.fastmail.com>
In-Reply-To: <be7e0eb1-c423-455f-bd89-050d52996340@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Apr 2022 22:33:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1CO8_Pa=Hk3hcdNfT_eD3PQK2aWDFB9bwk6TCNbGmtEg@mail.gmail.com>
Message-ID: <CAK8P3a1CO8_Pa=Hk3hcdNfT_eD3PQK2aWDFB9bwk6TCNbGmtEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     "hch@lst.de" <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r1FSgC0+iHYSfxL+8Z+moknQ0nCGDDpQkwCtuY53NIDtW2hw1bd
 849ECg/PwrI6rBtWZcCbZ7kXa6HlPekmQAMMcdSktsetvLR0C7FUi5ETNGlVEiedzg2/j08
 HKcUfkD6f/KAm+1oYZ0tCJXH9s4wxVzbsFAzb6FCOci8KigQzuwf5WyffOMsYaxIUDztAX2
 gQVaOVJAhJJhbX5uttjsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:htzl+qKV3XQ=:14TACTnPszlg1AVU/JL99l
 E9rL+A6iQRVIjEFsYXqtMTfvvwMgeVYao9jScukS4yrLbmXsiulwjxSrloFO9w/6ydTR00zU0
 kBbfsp+c5TZJxjlv+aDJrwMoZw0l9qmZAlhbup2x+x5BmSjNFx5CrNs0dxi2qnCu6m7Ty5onr
 4i8BR7jH8xh/T21lWLbshrBKayybO0zn/hxtonpq4LZ/auKk63phg7ben5EYIf/i8Wn5cuL88
 pQzrRlUxhIsltrVcNSHI9b74ydpEkiVUtoWy24CtmRH9r2FgYPc7sd32VK7gfamp+Q+F3nX89
 TPDf/QR29cXsL1lypvFtAlsW9AQx8ciMeT0VRgndtVefhEKimmIIbW8MuGlpQ4b+bLiBBSITi
 XfB4YMvy0xPAxbbjMAOrWu3gFXzNXeaWtcv9y8ks1shRLUhvWIAVblxfGByB+o71oAmo8tPEH
 QKDY4xuXs5aJoGmZPFzsicte3gOdHpfJwJeMW1QzIFZG3AFQrORdk5bSBxVebju+ww5T3x+MD
 JmCyRvhSwA/ZEcEC8bPQMLZ7t9s6ugz589f/XaF1jZkLdPyG6t+IS4V+5NutnZ+4buw722tCU
 U2YUVDr0IHso9YWQzn0DktU2/DJqO078hte/xcetQYzalVt7VtFWStZ6s4Fbx5HkJd1NUATHh
 BV12vkwLdC9HSBJRtUxeBENWlFIE8UPAk6keCCTXz22iM469/hpgWn5MtdOEtbJ5F/Sc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 6:37 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Thu, Apr 28, 2022, at 16:24, hch@lst.de wrote:
> > On Wed, Apr 27, 2022 at 07:39:49PM +0200, Arnd Bergmann wrote:
> >> The usual trick is to have a branch with the shared patches and have
> >> that pulled into every other tree that needs these, but make sure you never
> >> rebase. In this case, you could have something like
> >>
> >> a) rtkit driver in a shared branch (private only)
> >> b) thunderbolt driver based on branch a), merged through
> >>      thunderbolt/usb/pci tree (I don't know who is responsible here)
> >> c) sart driver based on branch a), merged through soc tree
> >> d) nvme driver based on branch c), merged through nvme tree
> >>
> >> since the commit hashes are all identical, each patch only shows up in
> >> the git tree once, but you get a somewhat funny history.
> >
> > Given that the nvme driver is just addition of new code I'm perfectly
> > fine with sending it through whatever tree is most convenient.
>
> So If I understand all this correctly either
>         1) I send a pull request with rtkit+sart to Arnd/soc@ followed by
>            a pull request with the same commits + the nvme driver to
>            Christoph/nvme to make sure the commit hashes in both trees
>            are the same.
> or
>         2) I send a pull request with rtkit+sart+nvme to soc@ and we
>            take the entire driver through there with Christoph's ack
>            if Arnd is fine with carrying it as well.
>
> In either case SMC (or thunderbolt if I finish in time) can also be based
> on the same rtkit commit and could go into 5.19 as well.
> I don't have any preference here (not that my opinion matters much
> for this decision anyway :-))

Correct, those are both ok.

        Arnd
