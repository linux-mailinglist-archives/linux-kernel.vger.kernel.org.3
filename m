Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFF5845F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiG1Svw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiG1Svt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:51:49 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06955743DE;
        Thu, 28 Jul 2022 11:51:49 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id v18so2550834plo.8;
        Thu, 28 Jul 2022 11:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=q3oeKEjtvlvPNkG5zR+PlPN6rycCHhc3ruuEWMjNKTM=;
        b=CzUYBxvVoyoNmASe97+ikLDvmq4XqM5Wm1I7GnXiCbP9gKZ8JvZ9/vfvhOTWXiYKcp
         DwuOElQs5ly2nXdosL7wtnX3f08LIqQxIIqkNXhVWely2wTJFrDd0c4bvwNsjwE0DArU
         aip+V0aJJa4s2hngdoSLj0StEGjMy+spFrnRjbZxauJsMwkQ+3Lt/+oja34xfw7CQ3LN
         fSDe4q7qdf7mK25L9ijt2I9kFf6GisqSQSlDYHvVAi+88TcVZPanXpf9EDfGP4YREkxT
         Qlw9S2w3Pw1mh2MoCDZ5gxXcfO/ahVfECx9TwCm5weS01BQNJWI5P0YXvS40/zDIviS8
         0H7Q==
X-Gm-Message-State: ACgBeo30pQdJ3HzWkDKpq4T8WFzCPheLxu811nvRObviVu95mx85YOt2
        NK+4oGzLMvoR/wkDay0k4gJTveWCYTCSCuNpnCVK+Fel6G4=
X-Google-Smtp-Source: AA6agR6sJHmBT9spTWeHSOkRH0SmOntZuWBc/osfJJG5ZsaBAI1+JvPSysWa3L2LqUWIUTWUoEwaWUnpfpaiL+m45NE=
X-Received: by 2002:a17:903:2282:b0:16c:500f:b78e with SMTP id
 b2-20020a170903228200b0016c500fb78emr204415plh.49.1659034308454; Thu, 28 Jul
 2022 11:51:48 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 28 Jul 2022 14:51:36 -0400
Message-ID: <CAJvTdK=yehzeVG42K=W_chyJ2YPRh18m729S1trWk=yKVDzRQw@mail.gmail.com>
Subject: [GIT PULL] turbostat update to 2022.07.28
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these turbostat patches.
(only updating the utility here, no kernel changes)

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 3afe697b74bc6c59f0b9a9c89d5b163db56fd4b1:

  tools/power turbostat: version 2022.07.28 (2022-07-28 14:38:55 -0400)

----------------------------------------------------------------
Artem Bityutskiy (4):
      tools/power turbostat: separate SPR from ICX
      tools/power turbostat: cleanup 'automatic_cstate_conversion_probe()'
      tools/power turbostat: fix SPR PC6 limits
      tools/power turbostat: do not decode ACC for ICX and SPR

Chen Yu (1):
      tools/power turbostat: print the kernel boot commandline

Colin Ian King (2):
      tools/power turbostat: replace strncmp with single character compare
      tools/power turbostat: Fix file pointer leak

George D Sworo (1):
      tools/power turbostat: Support RAPTORLAKE P

Jiang Jian (1):
      tools/power turbosstat: fix comment

Len Brown (6):
      tools/power turbostat: Show uncore frequency
      tools/power turbostat: update turbostat.8
      tools/power turbostat: dump CPUID.7.EDX.Hybrid
      tools/power turbostat: simplify dump_turbo_ratio_limits()
      tools/power turbostat: dump secondary Turbo-Ratio-Limit
      tools/power turbostat: version 2022.07.28

Zhang Rui (2):
      tools/power turbostat: Introduce support for RaptorLake
      tools/power turbostat: add support for ALDERLAKE_N

 arch/x86/include/asm/msr-index.h      |   1 +
 tools/power/x86/turbostat/turbostat.8 | 200 +++++++++++++++++-----------
 tools/power/x86/turbostat/turbostat.c | 240 +++++++++++++++++++++++++---------
 3 files changed, 302 insertions(+), 139 deletions(-)
