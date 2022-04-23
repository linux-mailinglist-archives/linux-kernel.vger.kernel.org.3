Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27A50CDED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiDWW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:26:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443DE1968B6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 15:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC317B80DB1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D63C385A5;
        Sat, 23 Apr 2022 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650752626;
        bh=fS+HvnXDamFAQHJoavpT0one5QtA3Lb2FV5c+s39oOI=;
        h=Date:To:Cc:From:Subject:From;
        b=rcny/I7Cil0gaLQUXh9sjfeDdUCcnUZUGC73mQHbOy4jP00BBK6BvLBk6Wys3u+0E
         UhOHimiMJH2NV9T7pNtFu6pm3bXQLAMBHcWS2UPXCNWn9Nb1RoSBOCpr1Tr4KgBtPj
         aeACzTcHHqe85B/xUXCHQY98Ef9CknVG4arry4cYZTtx2kOlb4S/1FEoLMe6ZESHHY
         Z2o1tZ5OPH0tffTzfF4nNOS6T7d2uXBWlfVjyOC/r2eScUkahqqKdAwCwfWO9SdxEE
         mEtKILMfQldtytz0OFMYTQqeHKtAvGEHburuzFg4OeluPswh35Arwq4ddeBVvBHOlG
         PQ9J0wcCtWpXg==
Message-ID: <7b513e98-0cc4-13b9-a26b-d281314c0f74@kernel.org>
Date:   Sat, 23 Apr 2022 15:23:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Bang Li <libang.linuxer@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich@synopsys.com>,
        "geomatsi@gmail.com" <geomatsi@gmail.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC fixes for 5.18-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull.

Thx,
-Vineet
----------------->
The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

   Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.18-rc4

for you to fetch changes up to c6ed4d84a2c49de7d6f490144cca7b4a4831fb6e:

   ARC: remove redundant READ_ONCE() in cmpxchg loop (2022-04-18 
14:47:05 -0700)

----------------------------------------------------------------
ARC fixes for 5.18-rc4

  - Assorted fixes

----------------------------------------------------------------
Bang Li (1):
       ARC: remove redundant READ_ONCE() in cmpxchg loop

Christophe JAILLET (1):
       ARC: Remove a redundant memset()

Julia Lawall (1):
       ARC: fix typos in comments

Krzysztof Kozlowski (1):
       ARC: dts: align SPI NOR node name with dtschema

Rolf Eike Beer (1):
       arc: drop definitions of pgd_index() and pgd_offset{, _k}() entirely

Sergey Matyukevich (2):
       ARC: entry: fix syscall_trace_exit argument
       ARC: atomic: cleanup atomic-llsc definitions

  arch/arc/boot/dts/hsdk.dts            |  2 +-
  arch/arc/include/asm/atomic-llsc.h    | 32 
++++++++++++++++----------------
  arch/arc/include/asm/pgtable-levels.h |  3 ---
  arch/arc/kernel/disasm.c              |  3 +--
  arch/arc/kernel/entry.S               |  1 +
  arch/arc/kernel/signal.c              |  2 +-
  arch/arc/kernel/smp.c                 |  4 ++--
  arch/arc/kernel/unaligned.c           |  2 +-
  arch/arc/mm/cache.c                   |  2 +-
  9 files changed, 24 insertions(+), 27 deletions(-)
