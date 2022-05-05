Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687351B4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiEEAdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiEEAdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:33:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3B54BD1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:29:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7d621d1caso33113007b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DBZHgTgHhGifz1O+OvTLRL4mlr40VVe72aYyr9oFJs=;
        b=dufIc96PMUlxP7YcnxTZoMITLMW8Y8Vo05y80Fc6JcS6UdgaV0y+6VIGR01O9ZyAFn
         VzgCR2el/k9vlj/s3PNNu1ujfqQGw0o4JhuN6JoKakSGUfCC0EkykjyAuq+tQKFxgZZ/
         GVl99IrkhYo99EI/plVjYvWuSlliV2lt3vfymRAoKwa/Bw7ItBwDYrcO+AhCCmNWjzcz
         FaLAW5c/R6V6hjaS0RaO65IAFph/k2zU7r4m3tPSKtOLZmPJtVpDRegKLE9+pCML2Hkr
         6hV1zIFdE1SFEzA3r4ZR+kzUzCWEQBlKP1Dsw5QGGA9fC2MwHnt14Z2z4QLSXJN7nyDe
         i5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DBZHgTgHhGifz1O+OvTLRL4mlr40VVe72aYyr9oFJs=;
        b=QdZNrJkCc4olCMiisc4cCmV0HJwg++nqtRoPxt0FPgBKaCFkiDzDul2e3nTnVRtuwy
         s5CPVDuk9yOLt68YC6zeRze1UIXcWuTxXm2/wS7e4HEonbR9dvF/KakehJReCu3VpNcK
         exDPJfrvhWkE5DEk9e+9mdtfA5sUz7enny1RNYLprnJl5jQBG+tFy+4gK4T9Qli6VArY
         4/aLqXPwXgCgXvz934jX2dZyDOloS4dWxW+S3tpEaelhgeBH2NrxF+d+K3+jFi/LRmQX
         b1s99RQ89ZAS4Yxn6arVN6C/I36wKnJqATopPUjBC52PLNSaAub5IGZvnGtg2ecDow39
         n9rw==
X-Gm-Message-State: AOAM530uREQu7xi2DXcE9fJxErLPoBRkqK604Cj4IBVQ4vp8qYfbXp5F
        nrZK0k0gN0/3z2HNCGShE8dgQQSX9kvOuzWD1O5Tbg==
X-Google-Smtp-Source: ABdhPJzxktpUG4Yp9bPU3HQqkPixfSm6UoQDjkuYNelP2+Ks74Aez5gQHsRBFtq1NoKFbP2TcO2lCR/gg4qL/ccgLHo=
X-Received: by 2002:a81:8d02:0:b0:2f8:c9f7:4041 with SMTP id
 d2-20020a818d02000000b002f8c9f74041mr21759476ywg.117.1651710573858; Wed, 04
 May 2022 17:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com> <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com> <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net> <YnKx5a9WvJ1UhWPm@google.com>
 <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
In-Reply-To: <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 17:28:57 -0700
Message-ID: <CABCJKueqqq-keiyE8tYJQtfitxQt08vQwEfG41C8t3aJC8AwKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, andrew.cooper3@citrix.com,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> __cfi_\sym:                                     __cfi_\sym:
>                                                         int3; int3                              # 2
>         endbr                   # 4                     mov     \hash, %eax                     # 5
>         call    __fineibt_\hash # 5                     int3; int3                              # 2
> \sym:                                           \sym:

OK, that looks reasonable to me.

> It seems to preserve the properties of the last one in that direct calls
> will already be correct and we don't need linker fixups, and objtool can
> simply parse the preamble as regular instructions without needing
> further help.

Wouldn't objtool still print out unreachable instruction warnings here?

Sami
