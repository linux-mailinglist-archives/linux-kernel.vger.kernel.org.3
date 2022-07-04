Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65856579A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGDNoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jul 2022 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiGDNn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:43:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB52ADB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:43:54 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MfHIZ-1nfM8I0Ah9-00grI3 for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022
 15:43:53 +0200
Received: by mail-yb1-f176.google.com with SMTP id 76so1370234ybd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:43:52 -0700 (PDT)
X-Gm-Message-State: AJIora8pPkO2gSZXCtyXJsOlIIiwOPRoyqG+gpyLxi/h8roAVyzx3Tjp
        kkIB+IskU//9yIxJIyCioTJxaL2Afx62O7Hhfm0=
X-Google-Smtp-Source: AGRyM1sl7ZhrdyDlr2pScNIVgZG3D4DXePFqgUbPtO3R2pdcjKLgl0+jlEAndq8SOJ1A5ZwWwducTiOPZWJ7gVrp92s=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr31378860ybl.394.1656942231974; Mon, 04
 Jul 2022 06:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
 <20220704131358.fy3z7tjcmk2m6pfh@pali> <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
 <20220704132904.irvs4xefu4esgw6c@pali>
In-Reply-To: <20220704132904.irvs4xefu4esgw6c@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Jul 2022 15:43:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30ecxG-A0_YDSBJAaGjcXXVwSnc7z4k-nreO+0UfJJ3w@mail.gmail.com>
Message-ID: <CAK8P3a30ecxG-A0_YDSBJAaGjcXXVwSnc7z4k-nreO+0UfJJ3w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:sba96hj5QkOtmm45W32nw/kGITFYG8pdyVhpbB6iQKRoU4CXTFq
 HpGN6GTpy8EDBR3dxm9LkQQQOfgI76QagrqM0NMWvFXrmgSW/PTiDqVnptVZyOpEg+JhcDz
 hOhWsxaHBgLfNj8PnzP6F6sk2Fq1lDqt91NWWTpMq1oIzySh39B1h4vt9GRnkRsD36+Eg3z
 rznyelSGX5azWHLjfCqoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPW5Zaei2E0=:sQPukXNVC6EhSCfQMP7p6z
 KyQUGAktX06i0av87XbyRJ6I6Ib2M13ACmasYx4PPxj29ylCe1yIgioheAsi7ZN/2Vnk50Usq
 36sb2OtVPWWpLiv5/6FBEKM4eq6+AWDleFA3APMDop44Vw68FyCQL5mH3o6/u/L0/fEZn5Noq
 Eg2oSEWi7X8mWl350GANcsMflPV4W0H3z6gxaRprq6VGkZcNcfWLppjPlSuoahvOWrFalN7EL
 VsaH5skCpZy4MoDjv0v52zgw+FpmwOYnRxCu6ESMMfpD0ongrcywlaxb3hnDELmjSuBUrH9Dk
 Y9cbwuY8up7KLJAGjBL+6RG343iMbFfYIrbxsIMRAAKu6ZEn4PhNeGC885lfA8gDnqfmu+eAy
 NJkPZzzhBTMR7ToIvmqREOMVGWp2lQRaYSAnpRKE5oQT66k6VfU+t0kwYgfFTfiGY3BlbKbbq
 P9RhFdjvx2w4wOTTuSTFdicljwXRmORP5M68nxdlPcmVjEy9/ngCvoNsqj/EKjl4g6N6kTKHL
 ADQBI9Nd/6SqwHclzvAyJToRiLqU49K9Ivg95Lk/q6tlhIftpDBAZ2FxZHGW1owHKoidbmNDY
 6j6UbEzbW6qvEtMpnFDa7YeaWjwikMWgWlqub0MgIOaGbTSMtKuGq/lSLx5cYrTdIGK6/fbYQ
 AJYPpE1kmORNuf7/vSgQ2+rC3aF0AfLUN0cb9vNSyssxQEx+ZYy6lY32GpGhDPMGhXXUuNzjO
 icQdop3f+wOZYWz5m7+UEcoil0IXOQr+u1WqipmXyN+Gtf1lbxteCIzKcIngzJmZCWDjEzqkl
 nwk1llYOI80MUO5Wm9iOUzF70X/vLruVdi3/tbT2zhGPCwFoAOuPycXb0Ns/uUVTwuC+V2+F4
 pZbdW4I7w6rkN70/SxlA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 3:29 PM Pali Rohár <pali@kernel.org> wrote:
>
> And still what to do with 4bf4f42a2feb ("powerpc/kbuild: Set default
> generic machine type for 32-bit compile")? I'm somehow lost there...

As far as I can tell, that is not needed, as long as every configuration
sets a specific -mcpu= option, the only reason it was required is that
there were some configs that relied on the compiler default, which
ended up being -mcpu=power8 or similar.

       Arnd
