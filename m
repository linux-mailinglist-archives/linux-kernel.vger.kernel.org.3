Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C71553A343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiFAKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiFAKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:50:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D2640B;
        Wed,  1 Jun 2022 03:50:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z186so2197264ybz.3;
        Wed, 01 Jun 2022 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fIMlY+QoAuZ+nDSyG0fbX2WbHP3uq76m2tMk5hKhLWQ=;
        b=pUfGZFEeC+FWcpciJw/HZD5Y1YnlA+xI+24jgJWkRGfE/3ufQqRkE+QG+sg7Yvnvia
         WFZcAU2lpg3x7GHxwhBKg9elSgHLYcaw8eOy7crChf3Zf8lY/wo5oGwMcumipKNVRS4H
         dYw/ELUE/LAVaRaSfiTk7J9tq22IScYPrRPgEGjR6en1b8Tq1SuJ3FdrdxyW3MI0JTsO
         /+pe4zYeFDaSyHdL1pKVv8DpmMFU+r1HRVcNHHAQACriCEzh/VwC6vreesq4zuJcvDyb
         u6NOf84uwsitWcZyYpw3JSSeVpugdLZD/m9JuyPFbC6dtBFqSxdWxkneKcZC0dQph2Gb
         X7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fIMlY+QoAuZ+nDSyG0fbX2WbHP3uq76m2tMk5hKhLWQ=;
        b=VmgHoAPU0mV2feVzdCxP8BKlxKF6IX9WEohz2uU5eY2C/3cSxv5iBPJk1VACm+nrrX
         NgvJGtusMBGccTWGyKy/ncqmJXM+bSMAh9cxISavXQSvdYub1QGy958Qmfjdi+gwQHDY
         InZcTi/D0rpMr90ctDQ9Zbz8TOLncsCBthlLBI9pSsNiv03xObMk9hJohQ/LMMaM/W+X
         5f0qR9GsoFlldSN+5oxxRfBMBH4SCZ+3shkaTPXVgfLu0LinFVlkHEBDKZZa9TQ6T2Fi
         cekhhoO1Z4XrcgTGNTYYXEklHV6QMHjyBt+eSDIf9hxA64r9tscpBv83rLdySRpX3Kqv
         MKhg==
X-Gm-Message-State: AOAM5337u/dvE0QWZBRYPuoIAtLqADJVBj+SyBanzLzTs9rtX47FOFx2
        6xlT3R+4Fqfa4tYzPZOn4HO7mXGxbYIbTGpseTENx7qOp458Lg==
X-Google-Smtp-Source: ABdhPJyxQ1AAjbJ94OpwPdV1j+wlWRSxUxVrz6TB9cVkfpM6nqA7QOdTAyHNnYuAzgphhvebBLF49a1lt0FbnJawG3w=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr7100942yba.389.1654080657937; Wed, 01
 Jun 2022 03:50:57 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 1 Jun 2022 12:50:47 +0200
Message-ID: <CAKXUXMwyf5jbfKCh0k+G=begmqXQo-q-qGfAVmecoKUiSnOYWA@mail.gmail.com>
Subject: Reference to non-existing config X86_SMAP in config UBSAN_UNREACHABLE
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Josh,

Commit dbae0a934f09 ("x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"")
from Borislav removes the config X86_SMAP and makes smap on x86
default.

Josh, your commit 03f16cd020eb ("objtool: Add CONFIG_OBJTOOL") makes
config UBSAN_UNREACHABLE in lib/Kconfig.ubsan refer to this
non-existing config X86_SMAP.

See this hunk in lib/Kconfig.ubsan:

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index f3c57ed51838..c4fe15d38b60 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
        bool "Perform checking for unreachable code"
        # objtool already handles unreachable checking and gets angry about
        # seeing UBSan instrumentation located in unreachable places.
-       depends on !STACK_VALIDATION
+       depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
        depends on $(cc-option,-fsanitize=unreachable)
        help
          This option enables -fsanitize=unreachable which checks for control

I think X86_SMAP can just be dropped in this line, but I leave it up
to you to change, as I am not completely certain on the needed change
and if that just breaks the config dependencies for stack validation.

By the way, this issue was identified with the script
./scripts/checkkconfigsymbols.py

Best regards,

Lukas
