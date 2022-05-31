Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA40538FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiEaL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343669AbiEaL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:26:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB45C84A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:26:16 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MzQbw-1nZmGE29iK-00vLXX for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022
 13:26:14 +0200
Received: by mail-yb1-f169.google.com with SMTP id g4so9686322ybf.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:26:14 -0700 (PDT)
X-Gm-Message-State: AOAM532kh8ecTkuqMOepCqDLJ0ixqiUqaVYGL37WzoL840svdtz8liu0
        ioOhBvVweHZ2neztjCMF8bFFrVRqRWCpqjl7aWg=
X-Google-Smtp-Source: ABdhPJxtl1qqrn14EPYm8PbfCPI0pi9FyDMFFreTqh1wbuF17Zw8CgSl2+hEg9WeSUi62l6AYElN5l2vVe9mtSj8Sm4=
X-Received: by 2002:a25:4f0a:0:b0:64f:6a76:3d8f with SMTP id
 d10-20020a254f0a000000b0064f6a763d8fmr47892113ybb.134.1653996373367; Tue, 31
 May 2022 04:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220531064348epcas2p2168f11ba49e9a119219bebe18a769dff@epcas2p2.samsung.com>
 <20220531064346.51677-1-chanho61.park@samsung.com>
In-Reply-To: <20220531064346.51677-1-chanho61.park@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 13:25:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com>
Message-ID: <CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com>
Subject: Re: [PATCH] linux/time32.h: correct ns_to_kernel_old_timeval prototype
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/7ApfJ4/DLeIHrMb/W9jbw6bGFNN5GbLKygze0pLdvcCrCPZZMf
 lMeRiqWfqycS+oSDfCtqknJgx8OfYbMHyQ2Xz02e0ZuVDxmtGSRGQvuH7U2rQMXce9SRyHf
 v6Cn1AA6LXyOx8YIPiLzyuy0MfaK/W3ESmALPEhP1f+sch2Pbt8Mpai3Bc5HgA56VBxUj2w
 vCJvWiMZ2y8n9ei9OpydQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mvm5nJipfy0=:mryax1sGgvmHLckqFjq+5z
 j4sacrjNgX4ypX/Ekr+K8d6CF5jiNZiFyPrP3KWJrBIMaySZd2RL9wmbJ5JZqmOeF1m6lcck3
 02UW4MwUoirvLaiu5uci37MvNTeRdF78TLrkd6N6l4zIR1E9cGvyEc1peivOyA0FQ0lV4gWsS
 YXEXS4IA75hbxd6G3oQmjIv8PSEQaTnpfgNJCJw3F9suiWa++3xUN7b0acDUU13q1bVuJ1TtG
 tsL7fn/ljP1UgGN73rHPR/aa0NXV4Ah0ujIRoNPlxUWweFIScaPiMhHGoJpoNDHUPKufMpBLP
 Z7FK9vVARG10czXCPfVJh8tf1fsqjvakfZ25XQYi9SjtNfpcBloFnvkArcM+AiO3PP5QFZ7m0
 LpgSR3UiZ10qw7+vLZ4mSM4YpJuUSkf0LAvq9YJQ1+7hu6Vlz3/LagYsvUJUdq8RbqUed95U4
 VER7D358l1gwgzy/IGx/qiqIa9UwOGiqORwtgNRu62i9IbpmajfjANaXk2splJ9k7GtBPP8Mp
 SHwY0M45qEvzZXCJhg75kWdqlB1OPl9g3jw4hRWh51Xal+CwCPtcYDxUzzeD31hthoiQb1z2Z
 88CejZ2MFYtP8xMtI+Av0oNbWNgmWRND0JEoDCPfqnYc5JAIGcByMQoHptJJN+LYgLFIpD+jU
 BXSITfKWYSHYQqw3cWfP1QcLCayOU1bi2fWiuHd+Mlw/BkD10bGT+P+CSxqEyi0ojtbrIGJPE
 SD3kVa7tcI1Oxbj30di6Xg5qtobUBVNP0sLEVVhsgAoX2yk1QhKMDZkTnj2Sezaje1iVwc5Kk
 SmroBh594kTl7+GQJfrxsxV7aS838Dh46WVEhUKF0uPsQxB4RCzNW9A3A/MLWFmogp57mA642
 LNqLfGr906FnbbjV7GKQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:43 AM Chanho Park <chanho61.park@samsung.com> wrote:
>
> The function argument is defined with const identifier in
> kernel/time/time.c but the prototype looks different between time.c and
> time32.h. There is a review[1] why it was omitted during review stage but
> they should be matched.

Thanks for report and the patch!

Since the 'const' keyword is still useless here, I would suggest
instead dropping
it from the function definition where I accidentally left it, and from the
related ns_to_timespec64() as well, both its declaration and definition.

       Arnd
