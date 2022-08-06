Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482458B7EC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiHFT3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiHFT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:29:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37CE017
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:29:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so5150471edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oED7syY+V3zgD36XpJjLM4EAhHlSgzKnmcI5LESeGWM=;
        b=BWcjrHAnx6ky24V2+JKGzY16TFX6QbOpagm+x059Iwk55AL7VS6aQ7tnmMNAKWtTrF
         j9eDFibzGRrV1ITqz74U7929k7vapvCJIL/rYgPd2DwFLYH14vYJYkgKMXc0tIdJlxwb
         yxXrMuF0q4m5/WRR3TUyfqze+BA9m+fqSdKTD/D8/BN2TgpnKdIZquy3K1QlLKWPVE5i
         o78+Hc9cFl6UrhdR3JZJD9dyDfxvp0f2dz662NsHwqBw1EqZyFH3v0iZ8f8nynfLsDRn
         6lqBjkDtVRVnXl1nNnj3enq3kq8u96mlLtBGT+D50XHIFs3+x8EJktniG3tZY0w7Wpgi
         jHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=oED7syY+V3zgD36XpJjLM4EAhHlSgzKnmcI5LESeGWM=;
        b=t71XtsQX+zVNee8X3RMOLMYBHz2JXto1WdepLsbjhBx/1o05Pb/XP1xLbCgejL2XEC
         U8r/mXHGAAseteuSWiZkNV06ocGgoUoCxx/cJBsDzGxFwcfHByP90mODLR0qzBB5Kgwc
         NXHx0oNlLTW7vafbVJSzZ3ftYhi//mypiyckxCFNkq3O7/rdYQNpsYuKdg3sk/SEabc1
         1w8LXe1It2V/8uokFsjnP3iWHEF7tZUXleroL1xw1qb6Gcwq9ePytynAge1gNcDIn0RG
         7Or39GbIgaxv4YG/UiPyZ0zEoq0ovkIp/5y1a59fsvRk4TO+W72jNix1n5VDtfVNkJhX
         XUoA==
X-Gm-Message-State: ACgBeo0qOH62s4lIeCOAi/nZH3VkykSCr/0wFlJJaJDfj8CyBsjICwir
        JecmT3VKaIgAgPEUJ7opW58=
X-Google-Smtp-Source: AA6agR4TxXRDEVMm448VI22AacxW7Uw0twQuEHLKfFc4l3PQQsCCCkbaWrlxWXBHftRLjP0hvZk+jg==
X-Received: by 2002:a05:6402:40ce:b0:43d:f8a0:9c4f with SMTP id z14-20020a05640240ce00b0043df8a09c4fmr11863751edb.95.1659814182358;
        Sat, 06 Aug 2022 12:29:42 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7c913000000b004406f11ba7csm1042692edt.32.2022.08.06.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 12:29:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 21:29:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86 fixes
Message-ID: <Yu7BI4wlC6J4tGP6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-06

   # HEAD: de979c83574abf6e78f3fa65b716515c91b2613d x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

Misc fixes:

 - an old(er) binutils build fix,
 - a new-GCC build fix,
 - and a kexec boot environment fix.

NOTE, there's a new conflict in arch/x86/um/Makefile, due to these two 
commits interacting:

  upstream:      # 5b301409e8bc UML: add support for KASAN under x86_64
                 # adds two new targets to the single subarch-y line

  x86/urgent:    # de979c83574a x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
                 # splits the ../entry/thunk_64.o target from the subarch-y line

it's a context conflict only, my resolution was:

  subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../lib/memmove_64.o ../lib/memset_64.o
  subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o

Thanks,

	Ingo

------------------>
Andrea Righi (1):
      x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

Chenyi Qiang (1):
      x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero

Siddh Raman Pant (1):
      x86/numa: Use cpumask_available instead of hardcoded NULL check


 arch/x86/entry/Makefile     |  3 ++-
 arch/x86/entry/thunk_32.S   |  2 --
 arch/x86/entry/thunk_64.S   |  4 ----
 arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
 arch/x86/mm/numa.c          |  4 ++--
 arch/x86/um/Makefile        |  3 ++-
 6 files changed, 20 insertions(+), 23 deletions(-)
