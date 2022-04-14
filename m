Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B925018B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiDNQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiDNQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:34:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C53AC072
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:00:12 -0700 (PDT)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxV4T-1nqOjy09yj-00xpND for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022
 18:00:11 +0200
Received: by mail-wm1-f47.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so3541183wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:00:11 -0700 (PDT)
X-Gm-Message-State: AOAM533AGjt8F71BfvLY12x2SAhbGFx5C24CURsHvrG92wfPFS///HZI
        zWgvjPXXarDiyB++rQfv0e4oqgF0rRfUd2ruYmA=
X-Google-Smtp-Source: ABdhPJxgCOpW6Xdx1y2lLLqYJGx+1WcYXk5s4vUblBDjWJ/svPaThdJeU9cn4727yf7Eiabe1nXTKAkVwgXf99NHZqM=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr4432044wmq.33.1649952010758; Thu, 14
 Apr 2022 09:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <202204130751.lUeRF1y2-lkp@intel.com> <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
 <d5ffc004-f55c-c01e-3395-7983fb25e570@linux-m68k.org>
In-Reply-To: <d5ffc004-f55c-c01e-3395-7983fb25e570@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Apr 2022 17:59:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29S9q=ZCGEx-1qxYciYB5=Jffkk9jx1+Gv91xvgtdA=g@mail.gmail.com>
Message-ID: <CAK8P3a29S9q=ZCGEx-1qxYciYB5=Jffkk9jx1+Gv91xvgtdA=g@mail.gmail.com>
Subject: Re: [linux-stable-rc:queue/5.4 7091/9999] drivers/staging/comedi/drivers/comedi_isadma.c:25:17:
 error: implicit declaration of function 'claim_dma_lock'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EVSbM0+7zW2d4CH9toEwPeeLTxavFv2vlMl3tW7YdPJ8luNu95W
 Wd9V82Dl3UbI5c+cw+c2NBBgMv+1TMX6p6T3uiYPDCXLLee4RS32T0dhDITiy63GXJJZ6gc
 OUdci3XeQR76pkMKcmZZLUiqTNuDNu7vnHP4G+5i5vkp4gNZO9OxD456D7rJM0BLIzCAGkh
 dl5VY7zKN1ziGlulHftcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dnT8+x68xxA=:lKWJC+A0S6o8xDXMsX1XaN
 nMjv/3QpdkzMUNnzmrOII5pj+6/5X7BDgi/Mc3cw84w1FcjM6+pST7gGzaFOQqRuk4SVBbRCV
 o8b3zcbLen3g3OFRxg5NeptqbhVprflxwKGvns6Nu1OCjIORWPvqw4pTM0hUcuR7LnGPCUNKF
 dFLOjTW+yJ3ZQLUpQ3Ik4M+2uWkMUXuu+apAXNfDuKEVdZJ+3nbmYKSRKBcQzJ7ZSKKfmU8Jd
 xXvvRo1tCyrVN4RVXzuonkeR0Fy1u1NKjGZgjKUMKSvroUyRvHmstf0p6tRp9CZdiDSMq4lv8
 NSaO7dAmWhvhvVM+/ewPtgGBJeRplzY6GlubogfaY20Us/ta6TiC+4OAMb6s3C0tMg28wn/AK
 zZwfvo8FuvrPccZC75arVUJq85pEVOfJ2/mtCrBNLLsTpMZ9ZCsnenglRF2a3UbHbm7Np8L3i
 DBni+XjnzX+du7oCAuEdZLXlVf5TJfgZ6ipMhU8JwJoCSACuD8ayiq2wL/pN4s9nWKgKtmrcA
 Q2mbFLXwQcDW5KSL1Gapz0U40Hk+WZFJyZTuNvvKw1Tw+e2if9wI886U1FxKIj0NJur7MrpLF
 Zmq1mD6RSZakAHMgToBiMfZTMrok4hgm5Xoj9rpTr3rxnCV4YNYddE8T+ftSMOVudPLHTGlWd
 x1CvZw29mLlfXIdHTZiN1ZmcvVGskU8kk8WlNwu/P0nyZcx80D/2UOabnXWF3qdui578=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 4:16 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 13/4/22 18:54, Arnd Bergmann wrote:
> > On Wed, Apr 13, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:
 >
> > Greg (Ungerer), do you see any of these that are used on Coldfire?
> > I can rule out most of them, but there are a few that are unclear to me.
>
> I think the cs89x0 driver may have been used on at least one platform
> in the past. But nothing that is currently supported in mainline code.
> So we can safely assume none of these are required for ColdFire platforms.

Ok, so even if this driver is used on coldfire, it only uses the ISA DMA
code path for actual ISA devices, not for the platform device code on
non-PC systems.

I think we can just remove arch/m68k/coldfire/dma.c and most of
arch/m68k/include/asm/dma.h then after dropping CONFIG_ISA_DMA_API,
leaving only the bits needed for CONFIG_GENERIC_ISA_DMA on Q40
and AMIGA.

     Arnd
