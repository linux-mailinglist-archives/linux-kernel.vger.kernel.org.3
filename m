Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89894EE306
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiCaVGG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiCaVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:06:02 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450813D36
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:04:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A68F609B3C3;
        Thu, 31 Mar 2022 23:04:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GFmecjB0zm2a; Thu, 31 Mar 2022 23:04:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8D8ED609B3CB;
        Thu, 31 Mar 2022 23:04:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1Nhbo3hKyEAb; Thu, 31 Mar 2022 23:04:10 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 633BB609B3C3;
        Thu, 31 Mar 2022 23:04:10 +0200 (CEST)
Date:   Thu, 31 Mar 2022 23:04:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <738009331.204323.1648760650240.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for 5.18
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: F335S66LpflqJb9RQ4q9AmKSilfNng==
Thread-Topic: UML updates for 5.18
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.18-rc1

for you to fetch changes up to 82017457957a550d7d00dde419435dd74a890887:

  um: run_helper: Write error message to kernel log on exec failure on host (2022-03-11 10:56:17 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Devicetree support (for testing)
- Various cleanups and fixes: UBD, port_user, uml_mconsole
- Maintainer update

----------------------------------------------------------------
Anton Ivanov (3):
      um: Document dtb command line option
      um: Migrate vector drivers to NAPI
      um: Fix uml_mconsole stop/go

Benjamin Beichler (1):
      um: fix and optimize xor select template for CONFIG64 and timetravel mode

David Gow (3):
      um: Cleanup syscall_handler_t definition/cast, fix warning
      um: Remove unused timeval_to_ns() function
      um: clang: Strip out -mno-global-merge from USER_CFLAGS

Frédéric Danis (1):
      um: Fix WRITE_ZEROES in the UBD Driver

Glenn Washburn (4):
      um: port_user: Search for in.telnetd in PATH
      um: port_user: Allow setting path to port-helper using UML_PORT_HELPER envvar
      um: port_user: Improve error handling when port-helper is not found
      um: run_helper: Write error message to kernel log on exec failure on host

Johannes Berg (2):
      lib/logic_iomem: correct fallback config references
      uml: net: vector: fix const issue

Richard Weinberger (1):
      MAINTAINERS: Update UserModeLinux entry

Vincent Whitchurch (2):
      um: Fix order of dtb unflatten/early init
      docs: UML: Mention telnetd for port channel

Yang Li (1):
      um: Remove duplicated include in syscalls_64.c

 .../virt/uml/user_mode_linux_howto_v2.rst          |  26 ++++-
 MAINTAINERS                                        |   5 +-
 arch/um/Makefile                                   |   4 +
 arch/um/drivers/mconsole_kern.c                    |   3 +-
 arch/um/drivers/port_user.c                        |  18 +++-
 arch/um/drivers/ubd_kern.c                         |   8 +-
 arch/um/drivers/vector_kern.c                      | 105 ++++++++++-----------
 arch/um/drivers/vector_kern.h                      |   3 +-
 arch/um/drivers/vector_user.c                      |   2 +-
 arch/um/drivers/vector_user.h                      |   2 +-
 arch/um/include/asm/xor.h                          |   4 +-
 arch/um/include/shared/os.h                        |   1 +
 arch/um/kernel/dtb.c                               |   2 +-
 arch/um/os-Linux/file.c                            |   9 ++
 arch/um/os-Linux/helper.c                          |   5 +
 arch/um/os-Linux/time.c                            |   6 --
 arch/x86/um/shared/sysdep/syscalls_64.h            |   5 +-
 arch/x86/um/syscalls_64.c                          |   1 -
 lib/logic_iomem.c                                  |   8 +-
 19 files changed, 136 insertions(+), 81 deletions(-)
