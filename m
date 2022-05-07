Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557751E453
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445617AbiEGFai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445593AbiEGFaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:25 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667916FA3A;
        Fri,  6 May 2022 22:26:23 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2475Q3fC030972;
        Sat, 7 May 2022 14:26:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2475Q3fC030972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651901164;
        bh=FfZkot1xX9/3A26jW6H/8b0WNAiDAR0EcY13U3/8Ct0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+FER/8w3E5h6Qsm1RElS6vuq+ZL8wApsSglUlUn9U53jWyLp4y2P9SBNF7xHSyT7
         dKPa+Zt/YnrZct/IS0ChkpJ8UcISu5zND744AU65GLgiowTHpT35Rr5ZQltemvoXwr
         xZIwgYJG0zYOuI7Oi68kS37hvB1an9E/7eMoI8gIXLBUoWSoUHspfjE8vBtnhARFzQ
         UX4Hwe+oeLR/svhlTocHsw54+9/U741E8el6WSuEX08MF3aHwrarABm6bLQ8KPikMG
         G/Uz8u7p6vEN9ROSAjf59+3jJxaS9SFrkq0Y12NJQrgfAuwFDFNjFYNkHXwI1sibAT
         VgFZuCMCI8KGw==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id d22so9272567plr.9;
        Fri, 06 May 2022 22:26:03 -0700 (PDT)
X-Gm-Message-State: AOAM533scEs/vByiND3hk9Ip1uikIKv0ja5UNlQldFT+V8gcPNS4v7/Z
        LDqGE4zl2RviDMVdAItKEJg6wnbgcZfXQR7zMCM=
X-Google-Smtp-Source: ABdhPJz/0IPfWjlKJGTu0YSnMBSWgwcJp83smiYNjc8NlYMvw4l6ht/5A57T92PaEldUnyvY+t3vLEb0KSQNQvhbfZs=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr7014096plp.162.1651901162954; Fri, 06
 May 2022 22:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220501130749.1123387-1-masahiroy@kernel.org>
 <YnT3GtU975OsXVuN@gondor.apana.org.au> <CAK7LNASkQ_14NYu7K_eEOG4boBMpKEXyrOzDJMOjcT5paC7E1A@mail.gmail.com>
 <YnXTPPXRlCpUvoKz@gondor.apana.org.au>
In-Reply-To: <YnXTPPXRlCpUvoKz@gondor.apana.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 7 May 2022 14:24:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReyv20PAb1LdkoBhR_x1pvLQJA7a=jMZYf11TmK9h-iQ@mail.gmail.com>
Message-ID: <CAK7LNAReyv20PAb1LdkoBhR_x1pvLQJA7a=jMZYf11TmK9h-iQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: vmx - Align the short log with Makefile cleanups
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 11:02 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sat, May 07, 2022 at 12:25:32AM +0900, Masahiro Yamada wrote:
> >
> > Sorry, I just noticed the 0day bot had reported the error.
> >
> > I sent v2.    (CONFIG_LITTLE_ENDIAN  --> CONFIG_CPU_LITTLE_ENDIAN)
> >
> > https://lore.kernel.org/lkml/20220506150820.1310802-1-masahiroy@kernel.org/
> >
> >
> > Could you replace it, or fix it up, please?
>
> Please send me an incremental patch.

Done.

BTW, you added a wrong Reported-by tag:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=b52455a73db95ef90fd3c2be84db77b55be43f46

It is a clean up patch, where 0day bot did not report anything.




-- 
Best Regards
Masahiro Yamada
