Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0C55ACE1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiFYWQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:16:43 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238412D29;
        Sat, 25 Jun 2022 15:16:42 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25PMGJoK019329;
        Sun, 26 Jun 2022 07:16:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25PMGJoK019329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656195380;
        bh=DUNIqP9Q/mkNEIYTyhgihl/qnaSSI9hnwidfj3zyUyI=;
        h=From:Date:Subject:To:Cc:From;
        b=FJRf/fi71Q0O+7gzXJ6ybV9PMO9s1LjL/gyCDfWjXdh7KcYbr73/UCUwbDRWbolJn
         br58iZrHmb5gkxguju5VzUlxA8+mEPlZg7/KJViXHnhMm+OccYpZPenp6BNSXVNV1A
         TMpFXnmKuT2kKMuHun2u2XHZAOl9SOkuQjTvkLz6iyn/7V+GbLs5YvQfYX6nx5enLI
         IkSrKvjaOLP3VD9UbW6NKmmAp0ExTuBat/wTsGTeP0vhQW/Q9H0yOu1P82ZuJ0FzbU
         alCd+OlrNZ5Mr8U6gz0MO6ougcYiYuAG5rRsX3uELtaOr+u2Uiuut3lmxDJfKQkf5j
         Par42PfVD8Zow==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id w17so7797486wrg.7;
        Sat, 25 Jun 2022 15:16:19 -0700 (PDT)
X-Gm-Message-State: AJIora+YqEF3bZKy7h0pNY7BH2FHOZgt6lHgM2ZBoKoc6Cg5qq9J4AIy
        Z888B4hpmkZotSBOwp9jQL9GDrO0a6Ws0HZugcI=
X-Google-Smtp-Source: AGRyM1up9FyxGg+rfvxRkBtqzNC9XhkFVXBckI6+aYjdR9FE4De4ZKghkd6DhnwIjgy1eu9Kj6bKb00lEiU1TFVau9E=
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id
 t4-20020adfe104000000b0021b9938b07amr5332616wrz.682.1656195378382; Sat, 25
 Jun 2022 15:16:18 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Jun 2022 07:15:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
Message-ID: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull a couple of Kbuild fixes.
Thanks.



The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.19-2

for you to fetch changes up to ff139766764675b9df12bcbc8928a02149b7ba95:

  kbuild: Ignore __this_module in gen_autoksyms.sh (2022-06-26 06:15:05 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.19 (2nd)

 - Fix modpost to detect EXPORT_SYMBOL marked as __init or__exit

 - Update the supported arch list in the LLVM document

 - Avoid the second link of vmlinux for CONFIG_TRIM_UNUSED_KSYMS

 - Avoid false __KSYM___this_module define in include/generated/autoksyms.h

----------------------------------------------------------------
Masahiro Yamada (2):
      modpost: fix section mismatch check for exported init/exit sections
      kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS (2nd attempt)

Nick Desaulniers (1):
      Documentation/llvm: Update Supported Arch table

Sami Tolvanen (1):
      kbuild: Ignore __this_module in gen_autoksyms.sh

 Documentation/kbuild/llvm.rst | 10 ++++++++--
 Makefile                      |  2 +-
 scripts/gen_autoksyms.sh      |  3 +++
 scripts/mod/modpost.c         |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)


-- 
Best Regards
Masahiro Yamada
