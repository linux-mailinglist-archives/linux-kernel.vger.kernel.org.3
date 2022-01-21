Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4D4967DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiAUW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:28:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:59459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbiAUW2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642804106;
        bh=zL6nm69DWgZVJHYquUk/KWyKFBQIbncygS6u/DCkUWE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=gl7bnviXQ4bIHPmUqg0gV7sAhwwP59VEEZers9g3TdA96uYYMjngl9pJaPqnlZCt4
         bRVIxRVtpE4sAMqKhSF01HmAdCpnK7EmLZDeuZIVUS3f1wBTlMGoZobHdD95OGw3nz
         ApfQ0uIkqO4ShFkJBgSKRCN+tZh54s1RrJ4ZzayM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.180.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1nAUA42bIY-000ZPz; Fri, 21
 Jan 2022 23:28:26 +0100
Date:   Fri, 21 Jan 2022 23:27:18 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture fixes & updates v5.17-rc1
Message-ID: <YeszRlKu5dWqiHDQ@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:yehtTieKYk6DBlPRYFOH4VTggDhraqu6eSPSgRCRqX85IxjFm4F
 QucgigxltC316dG0Ve+bpguDObDIHdyOjELNVfrr3FsE+iQ9h4f75ODmFCMxgC04wMmUAw7
 d2xJfHzXxpYyx8Fu3lPvtX8YIW4CUDYuPj+9hLQ7pmmlLpUPm7jd/Bc9+2KX71Chd0oyd/z
 5vMKVumAeU0mLEj7mHU4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pK0W4AuRleM=:KPgR0LnE29rbN8sAKo5QdP
 4Q7kfV4axpMaJqVJNiH+odfIWsLjMxAU2ciQARmlpzYWinmlqwBODthi+1N7/16Dr+inlTB/T
 xXwIVJPZ+B1rsMff5gBPhBhGbhxLQpJ2fom0wVrUKKdRVZYgsivJYqZKzzey3mEJ+o3QiBIK0
 NSawQM90eRA/N/rY7Au1gwgKj8boZ5m7c1yLvifVE7hfkVcRRDu+B/2T9NBnb5FR03+PCn0TH
 DIW0sLHSH6mg7VpSl3YNps8rNsWxmYm4kSWP9zNwsmERyinNxp7WAJ+p88kYXNZeDw32G2cEH
 /memlkgCD3+fzBlh9IlMV+b3y2cEY/CiGfXqfKR8iCjjEMQUFsLjkAu7uP75f7V99VLt7u3Pz
 MJzvh5+KUvppfa+/XiqNUanyO5DRc3iY+XPHOO5QvKEBxKO0G8m5ZNqbB0zBWwXPv3pDdjwD3
 ELhgN40o1u7t/y1NTOAUew1n2xy2ru6bC6Z4CfcQQ1hcgeITXnL4tAccHhx5LVkSEK+YFkyik
 8Fc/zth9BVYirQQYTGCgENPO+JCv8ZgPvlLLyNj0GpHEaDw5HvVnliqFPsyQtR+yyH/ovRb8q
 Uwz+Fke3vQ8kHiP6C9KuTz2Ph33zlJYpanZ7PITAXk9kKGegt2h4l94OiAceR2FetGtb1kUJb
 5IO0M9jgr4Oy6J2RiPOZyavq9GyMOJaIiz0aLaQzGXEeYZEfwtUjg4xD9d6eH8sHg4j7/62h6
 lyqSXUqVgNBEfXa40ufLvd0kTxEsydHnpoy1xEw4HEuQ4PbdxQGsSkxj3DMG5BG/WFzDqXgjO
 s+xMUcll+W/jvFmQrTuQfmXRPy0gHID8Xnbv8LlHoNnR/2df0IZKPMZ3rdrcvfeXrbS+3HoCM
 1i7wjj2mnUcIpmq3/YjZcPYzIAoZVlC2cpHoIpudb6PQRQAlROFS13ZgzxfOXQEJHHUMbXFb8
 SYR8KTeqcHr1hpZq8Dhmyh6jADfx/jQIrEQhv+gdWyQwHb8gLVN0MUAFWfEPhXadmAwQZG1rz
 rEcGTiH5LnVfBzdrZd7gcz489umAqJBiJPYHnoVOesettthBIszoTB5d4SAyGDNqkcba77VDh
 MHeBtknF+yQM1U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 455e73a07f6e288b0061dfcf4fcf54fa9fe06458:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2022-01-12 17:02:27 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-2

for you to fetch changes up to d24846a4246b6e61ecbd036880a4adf61681d241:

  parisc: pdc_stable: Fix memory leak in pdcs_register_pathentries (2022-01-21 22:48:54 +0100)

----------------------------------------------------------------
parisc architecture fixes & enhancements for kernel v5.17-rc1

- a memory leak fix in an error path in pdc_stable (Miaoqian Lin)
- two compiler warning fixes in the TOC code
- added autodetection for currently used console type (serial or graphics)
  which inserts console=<type> if it's missing

----------------------------------------------------------------
Helge Deller (4):
      parisc: Add visible flag to toc_stack variable
      parisc: Use safer strscpy() in setup_cmdline()
      parisc: Autodetect default output device and set console= kernel parameter
      parisc: Fix missing prototype for 'toc_intr' warning in toc.c

Miaoqian Lin (1):
      parisc: pdc_stable: Fix memory leak in pdcs_register_pathentries

 arch/parisc/include/asm/processor.h |  1 +
 arch/parisc/kernel/setup.c          | 15 +++++++++++++--
 arch/parisc/kernel/toc.c            |  3 ++-
 drivers/parisc/pdc_stable.c         |  4 +++-
 4 files changed, 19 insertions(+), 4 deletions(-)
