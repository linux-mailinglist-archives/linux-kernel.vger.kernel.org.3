Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB454BFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiFODEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiFODEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:04:23 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59644AE10;
        Tue, 14 Jun 2022 20:04:21 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25F33w3w010445;
        Wed, 15 Jun 2022 12:03:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25F33w3w010445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655262239;
        bh=qyIpU0+P63yrWK/J78khVpKLRKXJiye13yDJDLad98g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2+K+ZpzacIhm78uLBD6sfrwi218/9naArDxz42E0r3EhYwMpYFuF228M6LLx49+8G
         wmSg1VE9SDjWvEZ4pIP0kRbPskhigS39Icw1YGexncw++eHVgKU2TzN7bfcPYe/YNa
         SA7mfohLAG7bIlFvy5Mkkg9YSZ8yi+WDu8ATtWV8/fExfB/27xrJ3Civdw3Cy8kGZg
         1aTxZ3cfEA1lRJeEjco12Pb700d5qsqQsxg3OE3qUkq9KQkEZj73retanJJQZ+U4Dd
         hY17wM925S2MzcgqscXp3ZM4lln/N2evBi/pb37Vo5Qvt8aeelaTICG5g/ryG1RdZZ
         dnRpbqrWOJ3Aw==
X-Nifty-SrcIP: [209.85.128.54]
Received: by mail-wm1-f54.google.com with SMTP id e5so5613484wma.0;
        Tue, 14 Jun 2022 20:03:59 -0700 (PDT)
X-Gm-Message-State: AOAM530UB2UsTyUyj5vAGsyJBAUdVivq761QXypkTjgOB6pOpeuiZF3B
        rMnSOy6y6RoNjN4JYTjn2wUr3BxfFmokqWnX9TQ=
X-Google-Smtp-Source: ABdhPJzdCwWyyuo0xm3GFMsNesoRkt8m+h3KRKA9CSHqNXGlBTtwePv9IXfC/2iK7+cOJq/sBvSioWBnu6L9SV7noYI=
X-Received: by 2002:a05:600c:35c2:b0:39b:fa1f:4f38 with SMTP id
 r2-20020a05600c35c200b0039bfa1f4f38mr7536314wmq.22.1655262237660; Tue, 14 Jun
 2022 20:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220614055149.1900535-1-masahiroy@kernel.org> <CAKwvOdmcLCV6J+PYXCugH=0Pt_=yARZ-Y3SEmYy8F+oBpb1UYw@mail.gmail.com>
In-Reply-To: <CAKwvOdmcLCV6J+PYXCugH=0Pt_=yARZ-Y3SEmYy8F+oBpb1UYw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 15 Jun 2022 12:03:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxxvBeooj6t1cPYafS7gd9gNX8YOFghvTbbkusFoQ3pA@mail.gmail.com>
Message-ID: <CAK7LNATxxvBeooj6t1cPYafS7gd9gNX8YOFghvTbbkusFoQ3pA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: remove sed command from cmd_ar_builtin
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:59 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 13, 2022 at 10:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Replace a pipeline of echo and sed with printf to decrease process forks.
>
> If you're trying to minimize process forks, is it possible to remove
> the use of xargs as well and just invoke $(AR) with the parameters
> splatted out? I don't know myself, but maybe you're creative enough?


If I remove xargs, we will go back to the situation
before cd968b97c49214e6557381bddddacbd0e0fb696e.

This patch tries to avoid "too long argument error"
without forking too many processes.
Maybe I am too worried about the potential issue, though...






-- 
Best Regards
Masahiro Yamada
