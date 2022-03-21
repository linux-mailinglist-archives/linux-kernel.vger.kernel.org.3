Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DF4E25DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiCUMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiCUMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:00:08 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E220F58
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:58:43 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KMY6l6yqmzMqHdZ;
        Mon, 21 Mar 2022 12:58:39 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KMY6l5DcXzlhSLv;
        Mon, 21 Mar 2022 12:58:39 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fixes for v5.18
Date:   Mon, 21 Mar 2022 12:59:13 +0100
Message-Id: <20220321115913.478505-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these Landlock updates for v5.18-rc1 .  These two patches
have been successfully tested in the latest linux-next releases for
several weeks.  They contain minor fixes:
* One addresses a memory leak in a user space sample.  In practice, this
  memory leak doesn't stay long because of the following execve call,
  but let's fix it anyway.
* The second patch standardize the Landlock ruleset file descriptor name
  with square brackets.

Regards,
 Mickaël

--
The following changes since commit dcb85f85fa6f142aae1fe86f399d4503d49f2b60:

  gcc-plugins/stackleak: Use noinstr in favor of notrace (2022-02-03 17:02:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.18-rc1

for you to fetch changes up to aea0b9f2486da8497f35c7114b764bf55e17c7ea:

  landlock: Use square brackets around "landlock-ruleset" (2022-02-04 14:07:44 +0100)

----------------------------------------------------------------
Landlock updates for v5.18-rc1

These two commits contain a minor fix for the sandboxer sample, and a
Landlock ruleset FD name standardization.

----------------------------------------------------------------
Christian Brauner (1):
      landlock: Use square brackets around "landlock-ruleset"

Tom Rix (1):
      samples/landlock: Fix path_list memory leak

 samples/landlock/sandboxer.c | 1 +
 security/landlock/syscalls.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
