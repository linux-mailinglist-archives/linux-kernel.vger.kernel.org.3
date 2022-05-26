Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1620D534953
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiEZDkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiEZDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81788BC6C0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A8AB615AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D65C385B8;
        Thu, 26 May 2022 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653536440;
        bh=MgP39NRgoy5EWYmX0BdpJsZYRi3iKh0TwgnObf2cek0=;
        h=Date:To:Cc:From:Subject:From;
        b=qqd/vKrpEw6A7UTDY5587KVdzBnBPJCG7wg9kH/v05N1VtN3+206pAHcVUQFs3VI1
         ISvAYRMNeTApfp67pjLJh40DWZ07nWIonAoL8XQ3iYQJhk/Kd+RXCXQpnkCGoqO9yw
         uCD5B3Dow4e9tAjGsCRCwsE1/gQ+QJqqZWWySrO+DuJqWiX/mYwMPNsUWLN5WpqyAE
         oJ5/RYWBVaLnHcP1y6jgzD/J1coFGAgy2W+cxPZ2jxS+M6WbZFcS95qbbjAQakRW0+
         kfwNjoOSK+jfT9le0/fDIIiLvAP5W4RDDA03enXU3z1ERff1+VukvxgVStGGNFZ9yc
         pQ/mezIkwC5PA==
Message-ID: <a22af786-288f-92ad-79a0-0f40768cfdbc@kernel.org>
Date:   Wed, 25 May 2022 20:40:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        abrodkin@synopsys.com, "geomatsi@gmail.com" <geomatsi@gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC changes for 5.19-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull.

Thx,
-Vineet
--------------->
The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

   Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.19-rc1

for you to fetch changes up to 6aa98f6217861889523e38b0141c8c71b2ef8a83:

   ARC: bpf: define uapi for BPF_PROG_TYPE_PERF_EVENT program type 
(2022-04-26 09:35:28 -0700)

----------------------------------------------------------------
ARC changes for 5.19-rc1

  - Basic eBPF support  (Sergey)

----------------------------------------------------------------
Sergey Matyukevich (4):
       ARC: enable HAVE_REGS_AND_STACK_ACCESS_API feature
       ARC: implement syscall tracepoints
       ARC: disasm: handle ARCv2 case in kprobe get/set functions
       ARC: bpf: define uapi for BPF_PROG_TYPE_PERF_EVENT program type

  arch/arc/Kconfig                           |   2 +
  arch/arc/include/asm/perf_event.h          |   4 +
  arch/arc/include/asm/ptrace.h              |  27 ++++++
  arch/arc/include/asm/syscall.h             |   2 +
  arch/arc/include/asm/thread_info.h         |   5 +-
  arch/arc/include/uapi/asm/bpf_perf_event.h |   9 ++
  arch/arc/kernel/disasm.c                   |  64 ++++++++++++-
  arch/arc/kernel/entry.S                    |  12 +--
  arch/arc/kernel/ptrace.c                   | 140 
++++++++++++++++++++++++++++-
  9 files changed, 253 insertions(+), 12 deletions(-)
  create mode 100644 arch/arc/include/uapi/asm/bpf_perf_event.h
