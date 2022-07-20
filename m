Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE257B6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiGTMwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGTMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:52:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A653EE1A;
        Wed, 20 Jul 2022 05:51:57 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHX3R-1oIDmM2tE1-00DVSx; Wed, 20 Jul 2022 14:51:55 +0200
Received: by mail-yb1-f178.google.com with SMTP id e69so31900199ybh.2;
        Wed, 20 Jul 2022 05:51:55 -0700 (PDT)
X-Gm-Message-State: AJIora8Q9YMbdfkOnYpVRUX0O/Dxd2MV1ldIApsUrs8LTT5b47mHCDPO
        IIO6HwHS8+P9d1cpymMIKj8JOnAlOjZ3qa9hEIg=
X-Google-Smtp-Source: AGRyM1uYdeR1e+2JZ4Dwhm+/qxxE/d3Zoa7V4zLrqSvpRxWG0Tyk1v1g49n+usdQTToXWxxdOGlH+Kc3DV04SHYWrGk=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr38628656yba.550.1658321514363; Wed, 20
 Jul 2022 05:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220720223603.58acc431@canb.auug.org.au>
In-Reply-To: <20220720223603.58acc431@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 14:51:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mK4CHcHUX2XX2rGH29FM4suWiOUpCpR7M2Tg5kn6VpA@mail.gmail.com>
Message-ID: <CAK8P3a0mK4CHcHUX2XX2rGH29FM4suWiOUpCpR7M2Tg5kn6VpA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:icqgQFqJaDPvyB0YkSfMpWNviNdFGPw8bAiL08fzbhFp1HpMU84
 xuAUNpkYmhlTwuVVf4Xipg87ynGPckavWs/w2VbKSHEXqWpmhAEre/gJ/BqQoQv9RD2ZO5T
 OE9WLIq39EKm8j90genak8rXcD9LBKGGqaIMU+2kUB+SYWDCoRta7v8If2mTqkp6464h/eL
 bhHJ5QQh0ppvO29G0Ypxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aoUlawMokhI=:SguTk55j+AKcBVcCq31uTX
 xKqfi0EOEIK0gAtPkyIsK69uWuFGK78vkZPU0ShPCIAOi4Yo58UxGgP20KO775Q+Cj1UzcsLr
 npkvfnQJwLTZ+93sBA2EPmusXlapcSwPi5vqwQ625FI5Ue5iJXRvhLXsDjoaWjpWAQs6pLC2A
 tj6segH+uNAr5ETIU9mCAvbzC/Rx6McZDA1qo5CcHnSNrFbciUyBPEaidNYHE+uuQAkIDuLAK
 bqmGvNGNesgQhMJAHACBGkEzEc9Tezp+EpUMo4Ex58BIkMuC5ndryivQ4Afo5kUtEdToFT2ui
 t1oFxwIDqROljdauUJV88e1JfRxDP/E4tFoAczeR52CcclMmZX5X1JiXMkEQhmZhdeCPf5P+1
 06MG7axTAISvEyi57QmQyQJE4yIxu3quu7Mml/qkQINfkK3gbbQP3wa//3rwI0O734aGXQ6X1
 Hthe/XnlrYVinFyafZNQ4bQgn35I3CCfwZ5r3Bj+p+A4NWNSIya4aQqHZi9BYConM1srvQWX9
 4APv073/SAAkyFtimuQH9k+DhLxLDn8Rw1t12aPLBbVTvTJHoc7826LJQ7vYTZWP0cdOdm9By
 89I6ZgOuWhjgHxljRg00UYYSwq9fShFiuRia3VjwibSGq4XESFVNpRV+5EYYmxJaGxxJ/UxNt
 WOQyqIoZI1iM248ZPYwgGsJp4c6sayC4ixgOmQK7RjGvO1gtgi4+V3ZUvwFCyXyb/OknWCgPc
 /ievDlv5bTMYIDfjhJ7mPf41kO4YlJBhJtkfNA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:36 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the asm-generic tree, today's linux-next build (arm64
> defconfig) failed like this:
>
> drivers/char/mem.c: In function 'page_is_allowed':
> drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'page_is_allowed'? [-Werror=implicit-function-declaration]
>    66 |         return devmem_is_allowed(pfn);
>       |                ^~~~~~~~~~~~~~~~~
>       |                page_is_allowed
> cc1: some warnings being treated as errors
>
> Caused by commit
>
>   cdfde8f61a00 ("asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED")
>
> arm64 does not have a separate declaration of devmem_is_allowed() and
> was using the asm-generic one by accident ... some other architectures
> may be in the same boat.
>
> I have reverted that commit for today.

My mistake. I was already aware that the patch was broken, and Lukas said he
wanted to send an updated version. Unfortunately I picked up the old version
of my asm-generic-fixes branch as I applied a different patch. I've reworked
the branch to take this one out again now.

        Arnd
