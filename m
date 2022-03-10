Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453934D449A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiCJKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiCJKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:31:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FAD139109
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:30:05 -0800 (PST)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNc1T-1nmFeR0u1z-00P7kn for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022
 11:30:04 +0100
Received: by mail-wr1-f53.google.com with SMTP id t11so7192640wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:30:04 -0800 (PST)
X-Gm-Message-State: AOAM533h2NQhDlMa1mamJYbp9NTR07JsUlZmTVP2lG5u8CeGM90u2T93
        MbjDOfCiuhTnE2CU6ST2Lyp7HY7CbgYKJExn+Mw=
X-Google-Smtp-Source: ABdhPJzsF5MzvG2xycGj6tQMwNy8qNwsmOgxiOyipSIlNToREeL3z7dcYGqcbdOJelWseKLIGlic23KJUIY+0F5Tok8=
X-Received: by 2002:a5d:6810:0:b0:203:7cbb:20be with SMTP id
 w16-20020a5d6810000000b002037cbb20bemr2991507wru.219.1646908203883; Thu, 10
 Mar 2022 02:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20220310065045.24772-1-yuehaibing@huawei.com> <20220310095852.GA1699@willie-the-truck>
 <CAK8P3a2=iRLqM36wwxtQRrCwrZ2-tkBZPZCqqba-4kmk9GxcCw@mail.gmail.com> <20220310102125.GA1883@willie-the-truck>
In-Reply-To: <20220310102125.GA1883@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 11:29:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0K973ggjPStn+qe1w_NqwV_C4up+k2mcG8uV5fV0+cnA@mail.gmail.com>
Message-ID: <CAK8P3a0K973ggjPStn+qe1w_NqwV_C4up+k2mcG8uV5fV0+cnA@mail.gmail.com>
Subject: Re: [PATCH v2 -next] perf/marvell: cn10k Fix build error without CONFIG_OF
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Zk6gt/DZYAp6IvpKsENrp7pkOYBGwTfi+h0ViOXQJ+29a7vDSZW
 z60PWJuWuWzTPeWPrWfrCEzzznAwSaEDZlH/fPXijC0FEuM8Ecf4A3pG6ikHU7BiweouHWd
 0+njNU+OApYwUZy71NgC648CPATsI59ThGPwui7h2pRm1RZSWjz0wfj2AakxkpZaed5MgBw
 sEJUFGMjLdrZLmmGtjbGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8QhIep5onN8=:UE805ZQLkxPhLXehJJ430p
 grkusd08Wiw77WNjIxjRQvBF83AVVgFQ1RHS5QY3AuqZClVNrrDOOd37xt+N10bJSc2Caa+o+
 lgYuM/OSZjoiX2TjxNfT301hZ5Ivy22H2w+ubEKORVyz1WhKLo9Bbb3x5SdHHrigFZucyMh1c
 krNN5lG10kh1jJA0I1RBP4wnbiE94yReI6FXh8E1W3OaU7AMeXocgGYqp+SkGoBKZUvbwh0vu
 592OJCJpQI8WupQH4XZIwOyYVcN+Ey+zTZIqaHPS6XKGLPeXq4PtW+HnVfQGYHDcPEvWPyOHl
 HimI3SILFzgud0bBy+g9RkWa6/nBSgvhqqao/REcHtTWUdu6UP5IdWQAiKVfzD0L5a1IAujP5
 eXjAsZRCOsnbmaCcy0w90Q3yS6LBk0OUvxD4ptOer0EohhkHSBIpH+sWiXxLEM/sx1osQ73IM
 RCTv1Al+OOWHwc7O+lrGMB+5ZTnLUfcXCxyK3seGAh4Rh3ouaJMONoyh18KfraE4ypJQIKhTL
 xBQABYIecqmQqAehYclasFsJ6jecqQFgvEShWUtH3tl2gOD/uwvL1Vtsy+2F1TJEHq/nVJJiO
 p4mQ+GLIoOu4UOAJ6llQuBnTEByihJOEncl6EuttdmRJYUkMk2783bC3wGx1qKTghy07lqkxP
 DkYjyPwLA0n8vj0G3/yR0CNId0l1h3GpCDR0dlqw5uL10h0RJ2bov5ApKFca3g20su1ls31vs
 krrWDLW6GA80wtzUj92KMePS3Lbs04D5g+DyIsPZpYim2LYrCfgiE84YcmfPtV0Wg7lFzsUeu
 GeplBGLD90YxtFq+6GBWV93ZofZGsv5f7XEkct5HUPFZWdkhnE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:21 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Mar 10, 2022 at 11:04:21AM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 10, 2022 at 10:58 AM Will Deacon <will@kernel.org> wrote:
>
> I think the problem is when the #ifdefs are removed but the use of
> of_match_ptr() remains, leading to reports from the robot:
>
> https://lore.kernel.org/r/202201041700.01KZEzhb-lkp@intel.com
>
> Should we therefore remove of_match_ptr() altogether? It seems like it's
> leading people in the wrong direction here.

There may be valid uses for it, e.g. if the array referenced by it is
in a separate, and conditionally compiled file, or if the #ifdef block
covers more than just the table.

Removing 1563 instances of it also takes a lot of work. Almost
all of them are probably useless, and quite a lot of them are
actively wrong, because they refer to arrays without an #ifdef.

Maybe coccinelle can help here.

        Arnd
