Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30216587595
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiHBCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiHBCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:40:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012B6152
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:40:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so23603444ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=xPuuf8+PAYoavldmY5b0ibEHAIh5Ld0JS+AL2+6BUHg=;
        b=A8wfm0/Lj6UP6J2JryDD1irUewuyEwBm3U9jUrGLoMk6ihhA52fQ1xstY+87Rg/3Pg
         81rDvRy8AvrKkvVCpTVR1CZb4VdhUO7vUCMrbzCc+paxTDLjZXArzlgyvj6kIlAHZn0Y
         /VUOR1t1JvAwXes35KTGoJpaLzQM4dV31mrq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xPuuf8+PAYoavldmY5b0ibEHAIh5Ld0JS+AL2+6BUHg=;
        b=2PD0BhY/+yWkgNHtaewMH9A88Tce19Ke9W+cJqMiv00Eacw3cPL0ikXvikHXoIW+HL
         JT5FFNOmk8BdaLqiF1DW++cMpJix9uZay/BXIhZyyk+HQVvJlzol4dyPzIf/MEMM4Owh
         KqhelN6BSYliVS6WXO4dGKPxlX3VXkarerOJ59760acMLznSG0iJ9/fpO3+rnOyrJUhr
         4Q0ZKcXRupRqeen62EqDWK0i40o5j7+8/h7wWklH/Q9cYhEQh6J1iquDAEO9Pq/gi6G1
         L9V/zQG7q47oj/jsX1Qe1SmjmH1mMkaolMVt7jBd/aq4Nedo/Rid94beLX3mi8LzXhRV
         rwDQ==
X-Gm-Message-State: AJIora9baUo87pxkhHi6OUs97kA4gAMQ1wA9EioUtueRkPsMx9o/Qag8
        Odi3klDOYH2QLX/D1ZJt91mVyGYoueJXTtLl1prULw==
X-Google-Smtp-Source: AGRyM1ssOTfG0ulGVLlHvsfyQwduJLPLytNCncGY7BXeiV9DslnFDGR/nwnfEhce0TWJka/kMUnxWwF6omDezNqnpLA=
X-Received: by 2002:a17:907:2ccb:b0:72b:52bb:fd51 with SMTP id
 hg11-20020a1709072ccb00b0072b52bbfd51mr14600021ejc.118.1659408038916; Mon, 01
 Aug 2022 19:40:38 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 1 Aug 2022 19:42:26 -0700
Message-ID: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:


  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)


are available in the Git repository at:


  https://github.com/micah-morton/linux.git tags/safesetid-6.0


for you to fetch changes up to 64b634830c919979de4b18163e15d30df66e64a8:


  LSM: SafeSetID: add setgroups() testing to selftest (2022-07-15
18:24:42 +0000)


----------------------------------------------------------------

This pull request contains one commit that touches common kernel code,

one that adds functionality internal to the SafeSetID LSM code, and a

few other commits that only modify the SafeSetID LSM selftest.


The commit that touches common kernel code simply adds an LSM hook in

the setgroups() syscall that mirrors what is done for the existing LSM

hooks in the setuid() and setgid() syscalls. This commit combined with

the SafeSetID-specific one allow the LSM to filter setgroups() calls

according to configured rule sets in the same way that is already done

for setuid() and setgid().


The changes are based on v5.19-rc6 and have been in -next.


----------------------------------------------------------------

Micah Morton (6):

      LSM: SafeSetID: fix userns bug in selftest

      LSM: SafeSetID: selftest cleanup and prepare for GIDs

      LSM: SafeSetID: add GID testing to selftest

      security: Add LSM hook to setgroups() syscall

      LSM: SafeSetID: Add setgroups() security policy handling

      LSM: SafeSetID: add setgroups() testing to selftest


 include/linux/lsm_hook_defs.h                      |   1 +

 include/linux/lsm_hooks.h                          |   7 +

 include/linux/security.h                           |   7 +

 kernel/groups.c                                    |  13 +

 security/safesetid/lsm.c                           |  39 ++-

 security/security.c                                |   5 +

 tools/testing/selftests/safesetid/Makefile         |   2 +-

 tools/testing/selftests/safesetid/safesetid-test.c | 295 ++++++++++++++++++---

 8 files changed, 315 insertions(+), 54 deletions(-)
