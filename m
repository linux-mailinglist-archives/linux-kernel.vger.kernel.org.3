Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C721F4660AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356595AbhLBJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:53:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:56004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356587AbhLBJx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:53:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260668422"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="260668422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="677605092"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 01:50:30 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com
Subject: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Date:   Thu,  2 Dec 2021 11:50:23 +0200
Message-Id: <20211202095029.2165714-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to bring the kernel and tools x86 instruction decoder
more up to date.

x86 instruction decoder is used for both kernel instructions and user space
instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
it with new instructions.


Adrian Hunter (6):
      perf tests: Add AMX instructions to x86 instruction decoder test
      x86/insn: Add AMX instructions to x86 instruction decoder
      perf tests: Add misc instructions to x86 instruction decoder test
      x86/insn: Add misc instructions to x86 instruction decoder
      perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
      x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder

 arch/x86/include/asm/insn.h                  |    2 +-
 arch/x86/lib/x86-opcode-map.txt              |  111 +-
 tools/arch/x86/include/asm/insn.h            |    2 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  111 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  918 +++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 1426 ++++++++++++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 1189 +++++++++++++++++++++
 7 files changed, 3731 insertions(+), 28 deletions(-)


Regards
Adrian
