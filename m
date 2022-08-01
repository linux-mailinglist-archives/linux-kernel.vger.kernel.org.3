Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA16586CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiHAOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiHAOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:11:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74041EEC8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:11:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tk8so20581219ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G2DQ2egNgOtIylD5rbuzBV+FmwbsVin8WsOAsQz97s0=;
        b=KCaUpMc8QZnybgzBIcbTovL0LSzNf/4uNFbWVWm+dYvqkuRED32aaxQXIYWNzYd6K7
         GAvAzFCE8soPckX9HTgltr+oPJ1Q2vbvc631JC3JCUKF+YaIhLKzJgfDnjzwWebVA7se
         TtsnO9wgNxsCv2Suih6Ivd3dDAWmkzp2VchYMuC1SOiMNXrrMQsMXRCB/ANLtRkRrbnw
         ky2VotGPKS0SgX1KC5o3KK5kOCAGInbh7nezQeWWf9l0RhmG2szAHMvtESVmGQYyItwD
         ZheXoL59iS/E8FI0ax6ohAlgtLsvw/DrJtgVbp/QPH7i2p6JR2CJAZ1A/XRiQmXqU31L
         tSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=G2DQ2egNgOtIylD5rbuzBV+FmwbsVin8WsOAsQz97s0=;
        b=kkosQof7FxcHXH7V5wzP5avIhj+BeJcoCHHw/nitEbHxteOMcy2GqNM8pFh6cIGF5i
         v4L+7BRtdKLLwSt/MuC0IfhJl3HcnjZkCkBphiipigkISof4c1McX8XCJJ1/AK9ao0qq
         1h3p9vMyYrPdQEPzeunCpqa63rGYfQ3COfJWHZQ6ceM53hDw6xnqsMf/Y6h6D9Bw0vEY
         JCCDR1EwSJqoLjSFAoKGpO/gkCrY2Vs5TlOiUIAsXO9PvIQIwKKYnW3O6L8kGUvE7hoO
         DyxVaH7SXQ8fGXpJ4d1Js662WXcbFaqiVOEf5qB2xwL1ldYU1j2HEMaNL6Y5JC93bEHM
         KwFw==
X-Gm-Message-State: ACgBeo05IvPJJk9zODxeOu2BtyX6fd6OXTag5OeqwIvy5czcLWgWWb2D
        cFBxKq0r3iIglc8WvelNVEA=
X-Google-Smtp-Source: AA6agR5BKwpLsTpwiTfUHxUJwuCXLcO7cPT5MQOQGmtVes62+TdYBVI9ICOtoXvp7ZYcoWdGlHdY4A==
X-Received: by 2002:a17:906:9bc9:b0:730:6595:dfc8 with SMTP id de9-20020a1709069bc900b007306595dfc8mr6055637ejc.286.1659363074413;
        Mon, 01 Aug 2022 07:11:14 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7dbd6000000b0043d06d80d27sm6235542edt.86.2022.08.01.07.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:11:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 16:11:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Locking updates for v6.0
Message-ID: <Yufe/3UMD2f4WFZK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-08-01

   # HEAD: eae6d58d67d9739be5f7ae2dbead1d0ef6528243 locking/lockdep: Fix lockdep_init_map_*() confusion

This was a fairly quiet cycle for the locking subsystem:

 - lockdep: Fix a handful of the more complex lockdep_init_map_*() primitives
   that can lose the lock_type & cause false reports. No such mishap was
   observed in the wild.

 - jump_label improvements: simplify the cross-arch support of
   initial NOP patching by making it arch-specific code (used on MIPS only),
   and remove the s390 initial NOP patching that was superfluous.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (3):
      jump_label: s390: avoid pointless initial NOP patching
      jump_label: mips: move module NOP patching into arch code
      jump_label: make initial NOP patching the special case

Peter Zijlstra (1):
      locking/lockdep: Fix lockdep_init_map_*() confusion


 Documentation/staging/static-keys.rst |  3 ---
 arch/arc/kernel/jump_label.c          | 13 -----------
 arch/arm/kernel/jump_label.c          |  6 -----
 arch/arm64/kernel/jump_label.c        | 11 ----------
 arch/mips/include/asm/jump_label.h    |  2 ++
 arch/mips/kernel/jump_label.c         | 19 ++++++++++++++++
 arch/mips/kernel/module.c             |  5 +++--
 arch/parisc/kernel/jump_label.c       | 11 ----------
 arch/riscv/kernel/jump_label.c        | 12 ----------
 arch/s390/include/asm/jump_label.h    |  5 ++---
 arch/s390/kernel/jump_label.c         | 28 +++++-------------------
 arch/s390/kernel/module.c             |  1 -
 arch/sparc/kernel/module.c            |  3 ---
 arch/x86/kernel/jump_label.c          | 13 -----------
 arch/x86/kernel/module.c              |  3 ---
 include/linux/jump_label.h            |  9 +-------
 include/linux/lockdep.h               | 30 ++++++++++++++-----------
 kernel/jump_label.c                   | 41 +++++------------------------------
 kernel/locking/lockdep.c              |  7 +++---
 19 files changed, 59 insertions(+), 163 deletions(-)
