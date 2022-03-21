Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F44E21A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbiCUICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiCUICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:02:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC12E0BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:01:20 -0700 (PDT)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0X0U-1oJtik1HZU-00wVqJ; Mon, 21 Mar 2022 09:01:18 +0100
Received: by mail-wr1-f54.google.com with SMTP id q8so8128981wrc.0;
        Mon, 21 Mar 2022 01:01:18 -0700 (PDT)
X-Gm-Message-State: AOAM530QyJNXpQwGNlPMqeItywJxqMsl/zbjvWWzDpdlrZkXCr8RJaxz
        quxuO6/2myPpZKT/w0nv6SS5TdiP5FOIXzaaers=
X-Google-Smtp-Source: ABdhPJyn1rYxVcE3vSEk7fX9M0V9XhL9fPzronNopTs/qFftIqrfqDJrF+1Q25gMK0KMvVps+51S6HSesNjON/ttkuc=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr17006225wrq.192.1647849677912; Mon, 21
 Mar 2022 01:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220310233307.99220-1-jmkrzyszt@gmail.com> <YixWZ+IiN2l9jmzg@atomide.com>
In-Reply-To: <YixWZ+IiN2l9jmzg@atomide.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:01:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3nLV2FXRQVocELNTiLqJY-CZXy9Ko6CSunFnhou_493Q@mail.gmail.com>
Message-ID: <CAK8P3a3nLV2FXRQVocELNTiLqJY-CZXy9Ko6CSunFnhou_493Q@mail.gmail.com>
Subject: Re: [RFC RFT PATCH 0/4] ARM: OMAP1: clock: Convert to CCF
To:     Tony Lindgren <tony@atomide.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vgAUigR5OPNj49ogn46JzH0xL1qFerLhCnQe2Rw4G41COIuYwD2
 gDQhNMFMotYD1t0mm2MBqsdJWdav5iLbb5T0IpEp2gVK2WGlmTxXsfJ7ELVnTmM7NPGp78h
 ejDsVzbVo7ItJ26utXeSWw6cgLBwubNJdmpeMif5wlsKHWpInaHGs7TdHV5BGlq174FP8v/
 E1fG47z+WffR58W8Wpasw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hWY/liMjJbA=:sw307NMD8+bKC+dgNxHTNY
 oEsPdAkk+Mn3lR0bEAlhdmgYnxL2VqLfo16/c7hIjPHT4RzrsmKs9D52JLnwfdHm8CdDOAqf/
 qLHvTWRcmXeAlGUqvln+34Cvw0HGkbuzDqZkiqwXpNUwaW1U3e9/6gx19hA8HH712Sn/pD2R2
 tU9nAOxTRxjtStvkhglGXss5OyEVDdEVFMzFt0RRCBOy7Rd1j1SBz+VcuGGducXmsMJsGlHrg
 xWKIQtZurfNbkEMRS6EveTqBQ2CpDjVcrjTqBs3cuFl4ZkCrOlYPzzQK2kegZzf+ESSLhYniv
 LQwZaEzA5fOISssO7uOZmsvykANK81l8YPvqsjy3fM/6GME2CmTVtXODwSgWpe5GzgaWDl8pE
 vIjis5CRVlNU4MoO8LRdnqlFpU7AoDF/7XJdBzcWydK7TDTIpUeKG7pbBdeWKUeaud6tHenkT
 UEP3YOup8cypEEr7ZP+I2rh3PLTaZ45/4C5bvALtZrG+eykyt7h7tHWju9uXn8aIYWy7VpgdD
 fYMb/mM/METvfWashHDiSKtxXnRFk1x+XUZ2nnFI9swWdtQ5pkxhUNB0fDtZdlrOAyzhyLRjN
 0cEkO14UwrlI3LkVi1hkAVboiSy7jViR7lthrHPIjJjq7k1L8V4bUGvkUm7GnsgaRxsg5sLUV
 56ph+z4NmtWjd4s2hF+JRQnUnU+oiLJZOdKmteBA/AjvZEKlTgHpEL3pOinUqWmArVT22c6Vd
 MdX36IrmKlulEtZ5zpxQjJX9dXTaf0fqmwgc6EFznbFCfdZ/svr/uI7d1lJhL/Hm4c1CFPd9d
 MzuT1qCfCP8JU9174Bf8XuEVDQsWYRnsM+uKRNqwA50qkgAMmM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 9:14 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [220310 23:32]:
> > The main motivation behind this series is planned resurection of OMAP1
> > camera driver.  Since OMAP1 clock internals have never been visible to
> > drivers, that driver used to use v4l2-clk to expose a pixel clock for a
> > sensor.  The v4l2-clk code has been recently depreciated and removed from
> > the media subtree, hence the need for an alternative solution.
>
> Nice :) This will also help Arnd with building multi-v5 kernels.

Thanks for looping me in, I missed the thread originally but now
got the replies.

As OMAP1 is the last user of HAVE_LEGACY_CLK on Arm, converting
it would be particularly nice, and it allows me to dig out my omap1
multiplatform patches, which does get us closer to endgame.

The only other ARM9 platforms that are not multiplatform yet are
ep93xx (which can probably be done now as well after its
clk conversion) and s3c24xx (which is scheduled for removal next
year).

When those are out of the way, we only have StrongARM (rpc,
sa1100, footbridge) and XScale (pxa, ixp, iop) remaining.

      Arnd
