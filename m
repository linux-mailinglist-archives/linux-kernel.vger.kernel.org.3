Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7D52BA19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiERMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbiERMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:34:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBD195BC7;
        Wed, 18 May 2022 05:30:02 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5FxN-1nhQlJ2bp7-011BPq; Wed, 18 May 2022 14:24:48 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef5380669cso22085547b3.9;
        Wed, 18 May 2022 05:24:48 -0700 (PDT)
X-Gm-Message-State: AOAM5338/s/qHA3UKNQFolakTnjREpT0yWd1L53JIUD9VgvzOjXDe+CQ
        VF2bavNxYvWWJJ6wFDNC8LEeVmvFWmFc7ViQPaY=
X-Google-Smtp-Source: ABdhPJxZRkGXRvX53ymOSUVaooG3HpMXOKVV13GaKLQVQtT/IdcwmlHH1YBCPp9l/07/fkfwXAFHJLin8SwdOcL4H+U=
X-Received: by 2002:a81:456:0:b0:2fe:dee5:fbbc with SMTP id
 83-20020a810456000000b002fedee5fbbcmr20659765ywe.249.1652876687402; Wed, 18
 May 2022 05:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-3-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-3-gerg@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 13:24:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2DNKEj2T9fr_tch=WGWvVT0rG5Pbi8J04dAAxtwEZj7w@mail.gmail.com>
Message-ID: <CAK8P3a2DNKEj2T9fr_tch=WGWvVT0rG5Pbi8J04dAAxtwEZj7w@mail.gmail.com>
Subject: Re: [PATCH 2/3] m68k: removed unused "mach_get_ss"
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mkFA0VxBtWgHqqY2a8Z1cBSEYRjG9fUF5O9c/Y3vHbkiETmf2/+
 JTbY5ziAptpkM6nHfC4uXHwKGN9cKKDX3rUTLjscXyW818j704TsgxyNKGZnr2rU4hOuXG2
 knxebAYyuvoNqpjsa0KqjU3btasyUwxJ1DWo+pb9bCHf8U2G9Mn7CsCEh5SGQicrJI8sFWO
 xoYRtaXTE/vJ21L1+qxsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:elFAfiDWLBs=:9whmihggJ4h6kYZB2znNdn
 ZUyxM9J2Uy3PkOw7ozqRJ3zY6mPjAX38FSFQWkqjeBZbbDtNOOPzfvisgOaJ5j1dF1k5Jl5mq
 nSbMisOe4I7g9T9wj5YUPPfXSYfSYVcLcgFob9yHDXD7jutYgDaYmAkTJy+X2auJprhtRSS7T
 uhJMXIpL3jb246P3ySYsViVIuh8xHLC0k5i8IJwEMVRu2rv5I4fAc2+1iIDCqwsxd4HoQJgF/
 ZODOBSWhXp8FdDXckpkViAxnYvkzcH6duHtr7f9Uj+RZmMcyJGr0h2uJt6UIltfp1tYgKrtNv
 44vJN76rGtv4HIu5TuD6LuwInDJKYdmxB6Ude5IxSuCOcOWjVKb6BY+9ND4BPFPDcg2v5Wath
 e+KCYj+D62yQ56O1hCFAGIGL4bM3CNkuLyvvi/L7ijOZvrk2zOXv0re4n3yQAFxdGbniFtsnT
 /Og0N+hFwl2yoT7QEAdHhUJvy5wQJlfmV6A70qTpop/OEeWgaCwQFKFTGENL7AnAKtdBWgJhf
 F9IykRFLl/y1xISgXIX+udSXMoDqf+XIeZP5DejQVi6HgFaZd/7sdTGRBXmKfyLtyjtYmTz9b
 Ya4IsrsRVAo2fTsCNeilJbzu2hMZC9NRF3CROjfrRJ2LMmkShIbSPuB4uYn+4LgpOXGa83JGj
 wZOIYeTq6HcyHkzP3hcPMnt6TXzpyfCqyZ3Av2HWH9pRwpvQtMSqSGVZb/PzWjJyDZDb3tfD2
 0xDh+ygETdvGQkON+VBytRtNFzla3HXMhQvkFU51HiTuM66oTsbJRbfhvnP314keTafJ12e1v
 f1AQWCMcrv3otEX7B5007rDmIAHPhq1GGpFj6k8R0lZOYH73nxj4gpEr/IjAxgTGmE/hNIxLB
 xooDDk0st5ahNM+TCKGQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 7:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> The m68k machine helper function "mach_get_ss" function pointer is
> set for some machines, but ultimately never used anywhere. Remove it.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Good catch!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
