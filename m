Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0236516AED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358147AbiEBGnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiEBGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:42:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55472A729
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:39:31 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8yso-1no90p2gQo-0069EA for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022
 08:39:29 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7bb893309so137701607b3.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:39:29 -0700 (PDT)
X-Gm-Message-State: AOAM532IvSULH2cWL8V2m25xgbLaKIavprKfFnaiAQbQnp5C9DPoct5M
        daS+1DzbQK83FeIQ2lnhjQRclN+Uc84zj+rAjwU=
X-Google-Smtp-Source: ABdhPJzE5OwpHzpXPFEJtsLJFYHLxPubCpwCFMQg0sr1QksMReTLI4jUw6Ctec+D9T/Lf1Yk2XlAE95Ueu1oyO8PiT0=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr10502132ywk.209.1651473568501; Sun, 01
 May 2022 23:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <202205020811.kEEGO8QC-lkp@intel.com>
In-Reply-To: <202205020811.kEEGO8QC-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 May 2022 08:39:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Cq5oa8e7SAQ-mOGnytEjnOa4esr1gsfsS3ceH+A2f2g@mail.gmail.com>
Message-ID: <CAK8P3a2Cq5oa8e7SAQ-mOGnytEjnOa4esr1gsfsS3ceH+A2f2g@mail.gmail.com>
Subject: Re: [asahilinux:asahi-soc/rtkit-sart-nvme 4/6] drivers/soc/apple/sart.c:284:4:
 warning: format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
To:     kernel test robot <lkp@intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7A7D0TPXYcrZ8mn6M9XfKYqCtVyx51twYG6E+8hDxm2TiEnQ2KA
 LGLgRqf4deonAtrcXLKaP+CfNU8vqXDt7J36UBORs8/y7JPxXpTzVGj5nJaeSc18zt1+11N
 YXofSJd0m1o0W6+D4dRCEhlfoMLZK4WfCHPKzhN7P08QJ16qPNrtTMmsAKHbQe8wpxuIVip
 uekP7JRdOMmsTphRnOCPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vL7S59B1mPQ=:ut1SZRbFyyf3xsog8SLcUD
 vi+5zAMAltoOdtqUtmQNUwIU8FxHaZhqhdW7jnxapLEJdDal1jCz9hv/pq7oItYp/Rx3951CX
 IOAY9SuAg6FlOGEaatdEKHx8sfLINKMzRQ3qwdLjot5qXettmiYpKLM6kKZRyWuRIrhFYAwbU
 MVxVqSwi9mSrbjrjcYPMxCVEGcT4lYzmpAIWuuURNd73LbhpFDg8wzgTJQ4fEd4vxj9fztx7N
 xNZTwqXUt4hAMUz+9NMDdycUx0DbMPgA3rcgQVCuRM1BW61jWWp2YPo4v/TLAKYgmZig4VmGe
 975fpbSsx4QnE8yckCdRMuTc/TnhqZx/muv7DODotqBjemdbSCFewkeRVfWQrZ8EHQ9nCu7vG
 /gSfFYUnqIApRWRvN80gae/9yeSm8WQzOBHfBWGrORCAzQHaGnyj3j/XvF4erwi4XWU1kP9l+
 Oed30vPDWlmKcZeQB5JJSeoVhcZorHNASaomXkVDvXrd0kFSJSnHNrnSvbNflXoy6GRISXaZb
 n43EYgBT+qEMhPDU3kEj28/ej0SRdjwJBSh66sRmDLmsv0n7/iUu2p/4W81abI6h75juK+DJH
 e/inSaZ1/9i2gpdl4J11O239ifRWUh5i73Q8sLvZ8GYGObKiBb9PH94pf85klA2EDU0krmdg2
 5x/9rMhrp/ljRZYShcshNZibdUDqqOsfbdTpA4lcbWIk17BnXETNYQBTvwoGu49zPrGw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 2:21 AM kernel test robot <lkp@intel.com> wrote:

>    277
>    278                  clear_bit(i, &sart->used_entries);
>    279                  dev_dbg(sart->dev, "cleared entry %d\n", i);
>    280                  return 0;
>    281          }
>    282
>    283          dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
>  > 284                   paddr, size);
>    285

Hi Sven,

to print a phys_addr_t, you should pass the address by reference and use
the special "%pap" format string modifier. I'm not entirely sure if it should
actually be a dma_addr_t instead of a phys_addr_t. If the type gets changed,
the format string would become "%pad".

       Arnd
