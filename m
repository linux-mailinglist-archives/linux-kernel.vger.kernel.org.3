Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD95715A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiGLJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGLJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:25:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F47974BF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:25:42 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQvH5-1nxDWt3mi7-00NxMc for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022
 11:25:41 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3137316bb69so74506687b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:25:40 -0700 (PDT)
X-Gm-Message-State: AJIora9kQ8VYUrZW6wgniFlaqssyQIZJBGVz03HERZIC8uD0KwX1Bit7
        ZEPrTDSkUouVZgux/rqRWQeREwFkKGSABqUp5n4=
X-Google-Smtp-Source: AGRyM1sEvCvtuGItLbrpA1VpebWGWsR5cNoZW28n/u9RX1e8XBtI1GwbK/xotjuMsYJrasNN0eno1FlYJcE8JfnEywY=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr26115654ywn.135.1657617939736; Tue, 12
 Jul 2022 02:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a@epcas2p3.samsung.com>
 <20220712094715.2918823-1-youngmin.nam@samsung.com>
In-Reply-To: <20220712094715.2918823-1-youngmin.nam@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 11:25:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17d1J7gu0W-0ojxjz8W6C+Pg+xQW8ai=Qw_q94SJAOdQ@mail.gmail.com>
Message-ID: <CAK8P3a17d1J7gu0W-0ojxjz8W6C+Pg+xQW8ai=Qw_q94SJAOdQ@mail.gmail.com>
Subject: Re: [PATCH] time: correct the prototype of ns_to_kernel_old_timeval
 and ns_to_timespec64
To:     Youngmin Nam <youngmin.nam@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        hajun.sung@samsung.com, hosung0.kim@samsung.com,
        d7271.choe@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nXcf3ikYZUC1IvVYXY2mi58CgFtPvCb9/aZ+xH2J7Ldwom2XWrN
 JjfTPGXEn2PvKg1khUq5nS6j88gq+VpAECO2fl0r9EaPCSpUWeKXVPjfDtb498S8+BAYrxs
 bPIHdGtWzh3dOWXi2Cxc3+tqqXdJ+HXWT5WwAjL5YncFbVO3ooDnJ7Kczy31SnRckUGi9XK
 y9mBITeKDP2Opph5Fe4Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Vz78sk0Wgk=:V7NOQT6J5FHXDx6eKxaRkA
 ZzH5C6fUZstqfy/8zPiTJsZIt1Gko2oDhozgKMY6OK3uwqhxktmr4sOtEbxjdhNV4ssAhgzpZ
 yh8QzIrcczz9ZldCbBLtJKKsUJkmJtGW0E1HttIjeWrL5MSSM0FZAVqcPhR2HZEB60gQLBQDi
 +3RhU0ittURz7aBiwAH94zEhmIoV4UbTwgIwoTZcFxgBfcStsexyALbcMiANZm+7otAe2uRTy
 GFPwvmiry+TMLurDXb5gGCvUrtqDJQW4gmXLhdqKv58jABDmZOxU1bYjUEWQMwwmBNJz1CMq2
 kYRIe7CH3+fuJJcsnIjyVjEtt4xnHLfLJ130o27KUJQI8bARKoqVv2j57RKgw3iF1/tRy9Lvi
 CXkLyDGpVl/Tkyzm+uK/oA3rImz5RNlAuy0MhXnXEPKRQ4lPZvi+GQL2bqT3vJQvenFJAdqWx
 z1nQVZyn03cUZzZqmTWMCknfdvsz+R8uBcT0ob5aekET8nRuIepwfX6BkFPOSmE6E98Sf3sfK
 JAHkbu9ru38pE3wSK4sVb6hC6cnru7TcbrQSaRvYKVrlqNwvytZbC5HeifyAOj3QyNl3eBiVF
 etg0h0hC6I7+d5vQBHMzdRXUzwLfQxlBZ5ricc+DjRq0qusmyjwwlysQ9mvqqza32j954nDny
 lKWewfOlbWJ8W2u9nP0jwCjXR1uYfxaxVtwXEz1P2EBOV3EevE5bZxi3xgRu16CcBCQvImCBz
 +PKH+Sa9ofJ1hSZTzhkrq3GQHEx8XYmGCO2DdAJJpqt2QlP9wE69lHCNVOBvgOTLhCERHX6cB
 mmlZhLGS10M8NxhUYiO51gvri/0wwLhJzhPqP8ruq43Gi3jLj/8evevG+UCE2YXSJhb8IBbSY
 T29jK30jJs4laR4KC43g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:47 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
>
> In ns_to_kernel_old_timeval() definition,
> the function argument is defined with const identifier in kernel/time/time.c,
> but the prototype in include/linux/time32.h looks different.
>
> - The function is defined in kernel/time/time.c as below:
> struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
>
> - The function is decalared in include/linux/time32.h as below:
> extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
>
> Because the variable of arithmethic types isn't modified in the calling scope,
> there's no need to mark arguments as const.
> And there is a review in Link[1] why it was omitted during review stage,
> so they should be matched.
>
> Likewise, we can remove the "const" keyword in both definition and declaration
> of ns_to_timespec64() as it was metentined below Link[2] and Link[3].
>
> Link[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1637458.html
> Link[2]: https://lore.kernel.org/all/20220531064346.51677-1-chanho61.park@samsung.com/T/
> Link[3]: https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com
> Fixes: a84d1169164b ("y2038: Introduce struct __kernel_old_timeval")
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
