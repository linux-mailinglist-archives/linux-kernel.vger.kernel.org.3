Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CC05308E1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiEWFio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiEWFik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:38:40 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8502018F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:38:39 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24N5c6tX016050;
        Mon, 23 May 2022 14:38:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24N5c6tX016050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653284286;
        bh=8k0/bkhtuM/BaYqS5/Paa+cIIhtF8ZJBatVMjJ7NYMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ncCjg6BqdAPQQVB7Tnaa9iyoMCid23CmMHKF2DfcVUMF38oWckgbuF1xpQvLgLFjf
         SImQYh7/jqMtDlZkzn/IzULgSuJyU7A5Q32gCKLzAsaKGk/IPOddlqUDNjM59KfR/J
         luUd3Jtg7lrcDR8HrWwPpk7YS5wo7GBQVw3xcbdfLtrN8EF22Rnr24KM9eBTHozRL7
         Yw/qitH4qRQIqjXyxrqCwjzc+V9s2N1AmOc3bG37M0E9DaPskHyAoHyLB+aYBxD+h0
         SaEE3td+rq4Q12+Q2voPj/IorLF3nLfYGx2GnzSzhQq9TFyT/K4UdTDSq8BbpK9rqR
         pJCXxBSTWWkxw==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id 31so12742698pgp.8;
        Sun, 22 May 2022 22:38:06 -0700 (PDT)
X-Gm-Message-State: AOAM5321FzyIQgbr/e1mYbnYjpDd4YFbrzn6hYNkyFWaFTSZYUSmwRSM
        sJ8/yc/IQhpT1wBn9QrrGsO4r7u5B+Ao80LSAOQ=
X-Google-Smtp-Source: ABdhPJzG1VZG3WAjvz75BL+VNo9jo0YV4zcGj4QGDXFHIDPBgYuDI5HvMgqvfHfhyFCLrc2AuDCK0FwDUu/P1z3R/ZA=
X-Received: by 2002:a63:fc5e:0:b0:3db:5804:f3b with SMTP id
 r30-20020a63fc5e000000b003db58040f3bmr19090498pgk.126.1653284285678; Sun, 22
 May 2022 22:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220523142431.10ff2f77@canb.auug.org.au>
In-Reply-To: <20220523142431.10ff2f77@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 May 2022 14:37:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcRsuKrepsMiV20D+SSQQYWRqeoWqpo4UoQMtdW2A8SQ@mail.gmail.com>
Message-ID: <CAK7LNAQcRsuKrepsMiV20D+SSQQYWRqeoWqpo4UoQMtdW2A8SQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 1:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   scripts/Makefile.build
>
> between commit:
>
>   0212301af7bb ("kbuild: do not create *.prelink.o for Clang LTO or IBT")
>
> from the kbuild tree and commit:
>
>   753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")
>
> from the tip tree.
>
> I am not sure if I fixed this up correctly, please check the final result
> when linux-next is released.
>
> I fixed it up (I used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell


I think you can fix up around line 420
of scripts/Makefile.build


$(multi-obj-m): objtool-enabled := $(delay-objtool)
$(multi-obj-m): part-of-module := y
$(multi-obj-m): linked-object := y                        <--- Add this
$(multi-obj-m): %.o: %.mod FORCE
        $(call if_changed_rule,ld_multi_m)




-- 
Best Regards
Masahiro Yamada
