Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75758AC24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiHEOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:10:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7B2DCD;
        Fri,  5 Aug 2022 07:10:10 -0700 (PDT)
Received: from mail-ed1-f48.google.com ([209.85.208.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEV7U-1oDuZ90Hf8-00G42h; Fri, 05 Aug 2022 16:10:09 +0200
Received: by mail-ed1-f48.google.com with SMTP id b16so3548908edd.4;
        Fri, 05 Aug 2022 07:10:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo2dSVIivKhcx4KQcXObqYE4Nx8RlkV7dPJLgx13fGzonAmKrqHo
        OGAOo2xV4atX4p00mCxLWHkWGZT8bX82WN2fNV4=
X-Google-Smtp-Source: AA6agR5MgCQ7W85cRkQaUheEvCb+TFX/hsp6VXNQop8SnX1T6GAWSxE7KW8sxZxnJnZqaTvbnIpiw9jBHdeVB28dn8Q=
X-Received: by 2002:a05:6402:520e:b0:43d:df14:fbed with SMTP id
 s14-20020a056402520e00b0043ddf14fbedmr6882796edd.16.1659708608714; Fri, 05
 Aug 2022 07:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
 <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty>
 <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com> <1826852ea3a.10a917cc826728.6077661125986568031@linux.beauty>
In-Reply-To: <1826852ea3a.10a917cc826728.6077661125986568031@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Aug 2022 16:09:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2hyhzjYqeL1LY7WziDjXQJasg3jFe83eErzKgbfP-a3w@mail.gmail.com>
Message-ID: <CAK8P3a2hyhzjYqeL1LY7WziDjXQJasg3jFe83eErzKgbfP-a3w@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O5wHPtUzcovKFvcYfkOjBWal1dMfG7bvsw6kM80MG6+iSNp7txg
 2FWsQTt9ciiljV6Yq5/7ZY9rfbf9HyaxIUy4Rar5Vp3fMvLziPqUtfxTtW5A46MbTS8Iw/s
 QAjtKwNgHzCpusbSgDdkjpbo8cpv1YoJ3qnTava90VlhzOfUvPExZB5s3Atyv9+Bbgmbgbv
 q/p+ppttYZLBtPiLwlx0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dHDGKKnKDaA=:kQOIcC5Ei802S23mnxuMro
 n/Z+GfqsIq5BJoRjeZS9Toro0mviJu4JWy3tgsfKljbB8cs9E6EZCm1n1NkNGABvCKhr7xlFT
 Da2pJ4osJyvPAQpiULS7Z92UhN7MccFQxbaQEKMto/JpMuOYhP5RxD1EjpXOt36keWVNkyqj0
 Rc9D12QfoOJgLk/xGnXh40x1wcaMauLadFslIaVxKV1HGnIwfKLBiSteUpHm86ptOrhXzp2NZ
 098sti8NJpSdtkLghxGRgjUQf6teIq4wu+mU9CETAEJBLOYnpa2UjEmRPAd2YaM4M/8a71SV2
 XXkGh4FGC+TMwDvxVtoyYN4fVLbTT6B3LYpXznZJCe+JodAAN8O28plI76NE2+as+sES2ytlz
 x5Pcy8wm4IktZkL3se4PxmFsTYfMlzLPm0HF6iYW2JwXqDZu/yejt5QV8Gc450YmXLXk6/eMr
 bXjOPxZNw6zVr2VoJ8DNAiPTmMDJeA0T656iWgFJA72ch9oVrDkXcG33ugyoVkZk66bd3yLb9
 jtC0vtXPKzhykjvyIaQZkAPm5xF/SCHLuFLV5bZeuM2DH180Swb4muGwU/v3NCeEpdluQh3Fz
 zEAMA2ee1tdB4CQsrJD/oc881L6jhDP+6w2yiL0xjhCtlS+CbFf5xAqyR6NyqQl9ME63ddScG
 qsvG1PX1V5wFTHyHQLI3uhtT7v5vEnUK3dLe2gsXXsmUbO3z9xVzJ6NR5YU4jNgMA0rnzsLVZ
 IzxP2Omx5rlp9cVD2REoTelrVAeNhek3fQK7W4rae8P5huEtw0K60buioNnFTIkOS/MgPy1jf
 kHe7F5azYtFW0ifNdcwy9tZSqOAb2DC+T+2UtA5ApfTwO22mIkuo4JFDkKtGEL/csBdfSBzPz
 31P8feaxm1WAiAg+WNRw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 12:07 PM Li Chen <me@linux.beauty> wrote:

> Apart from our cases, I heard there are some other cases where cma_alloc
>  failed even non-cma system memory has enough memory because pages in
> CMA memory are pinned and cannot move out of CMA. There are some fixes like
> 1. move these memory out of CMA before pinned
> 2. only allow non-long-time pinned memory allocation from CMA.
>
> But these two solutions are not merged into the mainline yet.

Right, I think this has come up before, not sure why it wasn't implemented.
My feeling is that 2. cannot work because you don't know if memory will be
pinned in the future at the time of allocation, but 1. should be doable.

A possible alternative here would be to avoid the pinning. In most workloads
it should not be possible to pin a large number of pages, but I assume there
is a good reason to do so here.

        Arnd
