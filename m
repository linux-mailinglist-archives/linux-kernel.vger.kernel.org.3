Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5E48ACF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiAKLtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:49:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:33691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238583AbiAKLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641901740;
        bh=vAQJgoSwF0R1ayJFG1oEsNhYDBTZXrjepkeB6W1xDLI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=cHzttAeDG3ll7Dei6iCLnijkJeTyOAgI2VLBdXOBRSx5b4SQ/2xeIk/a8NgS1xz6Q
         HPd8lm0MKmzYEfNZUarca56LPw8zgYhL/Vnw1HQ7Koz/8kFG3DfnN/qCzC2ussi5Sr
         44Dt+w1K+5U98ZoBm/GQTt9eCypj+MGwiX8TKy/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.169.189]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1n5sCX2Qdx-001Uww; Tue, 11
 Jan 2022 12:49:00 +0100
Date:   Tue, 11 Jan 2022 12:48:55 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [GIT PULL] parisc architecture updates v5.17-rc1
Message-ID: <Yd1up5g3mSzj7eHL@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:FZpyUzG+Fz1YGuZQmJz7ehUdKnOcv2voVQso93lJ2uiviVoAAIf
 lAyHvVfbEINWmZg3PFoP06YrVR8aauX9adSD8PxKIW6Y1ThnF88ob9lCc1mdKkJeMm+eM9r
 0R4HMBpxUY5o9kYy04c845FnrPSIekQGRy2OrDICXl4eJzW1iOJD4dREYXb72e+LbcayCRF
 y21qBGn1RPn8nwKpmtVBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OaBGbX5pVnk=:yGnH66ENd9b6teLD1GTOBL
 s6q6qJnoKBbsQ4H4v7wSrJHMYhQTs8R/fgJ3Sl9yCWpU9QJM+v3QXT1SEAH5UzAlVXAqAK2qL
 iGO0HWK5RaoRlfmdA7pbbMBLM8uHsyc4TseVucGi/1gZs14bX4wWRYIUfVjCgfUON9Zg5HzoX
 1ObWsdxXj5d+zYWWm3duF7k46XhFvL/LHXl/kuGAOOnplOcZ84u43DY+8cpvxRxY+EgpDkyCO
 I1M8RZUl1X4ZdVjhPM7jm4ar8pRaiatWNgFNg/d52EQbsRCK388MmrZl9iEIkaFXifvTi6TFI
 cg/A5B0XdEXsX22LxsghKGo4t3r9x4Ar66LtjUqEfyCvGkpN/UCs0BUtod6zxIVzI8g/MRQ7d
 /v6K+YpEgCbSXd6lEW+k+crlwxsA8LgKjmSqCW8nQzEjhMf5bjNFwKKzz7N3F2dhoJdqhHJch
 vaC2ajyY861mgHOBRf380al1obFdF6bvCgCLI27Bbn/T9umTaINUUyI0OICHoLw/ENfBDrchg
 QFENCK3EztAbJtBd5nvcHwHMiHI7vDKMUsYuZbM7mGKVi+4/l13vfF/RSvTqtoUfpUXgELSSv
 dJpGITtwfljWSLDzOZplsfxpXlnpbDMic7n+suQTsevar36JMymrjQ6k8mud2+ufO5hl5x3ou
 8PYG+KxBj0FwlZDPdQzMB4hea/GmCOTz2Gy/GGoztf+ps1KWr6PbI8xBWYJJRG1Pk9QmNn0/4
 yPfT43EmfaiMuEgXoDcXFT+yRpw7bLRYAzSYwMLuoBJx73uyJg+INKQRhTpW3kGzxIqx8Np0u
 O9VMiczTQ2VnLPybmyXJsP/nZY3vPE/3Np08FT5B4J6pcLkQv4xnn2mSft3xl70XCjnyx/6c4
 WG/kMp6tPRkvNi/N9xXA6pv27ghcFtBOwlo4b0QdWSe16z3y9FeDlpaZ+mu9EET7j3lb9pyAo
 tgOdBHuLYJ2wjKP3bhzd8jBFD510TPzKDKPbAGBCDhSdDHHwhCz8CY27/2YnyB3MhNHIFGQrM
 hioIRh+yWIIIxWdYMJu9Q75h8bpFPLhCctmdejdyW0RYte1fRnAXAdmjdRJ8r4Qe3IeOOvQeh
 FP0hLuR2yL/xyA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-1

for you to fetch changes up to 68d247ad38b1ef46bd945a5220fa6d28c901c2f2:

  parisc: Default to 16 CPUs on 32-bit kernel (2022-01-11 11:57:38 +0100)

----------------------------------------------------------------
parisc architecture updates for kernel v5.17-rc1

- Fix lpa and lpa_user defines (John David Anglin)
- Fix symbol lookup of init functions with an __is_kernel() fix (Helge Deller)
- Fix wrong pdc_toc_pim_11 and pdc_toc_pim_20 definitions (Helge Deller)
- Add lws_atomic_xchg and lws_atomic_store syscalls (John David Anglin)
- Rewrite light-weight syscall and futex code (John David Anglin)
- Enable TOC (transfer of contents) feature unconditionally (Helge Deller)
- Improve fault handler messages (John David Anglin)
- Improve build process (Masahiro Yamada)
- Reduce kernel code footprint of user access functions (Helge Deller)
- Fix build error due to outX() macros (Bart Van Assche)
- Ue default_groups in kobj_type in pdc_stable (Greg Kroah-Hartman)
- Default to 16 CPUs on 32-bit kernel (Helge Deller)

----------------------------------------------------------------
Bart Van Assche (1):
      parisc: io: Improve the outb(), outw() and outl() macros

Greg Kroah-Hartman (1):
      parisc: pdc_stable: use default_groups in kobj_type

Helge Deller (7):
      parisc: Switch user access functions to signal errors in r29 instead of r8
      parisc: Fix pdc_toc_pim_11 and pdc_toc_pim_20 definitions
      parisc: Add kgdb io_module to read chars via PDC
      parisc: Enable TOC (transfer of contents) feature unconditionally
      parisc: Re-use toc_stack as hpmc_stack
      sections: Fix __is_kernel() to include init ranges
      parisc: Default to 16 CPUs on 32-bit kernel

John David Anglin (7):
      parisc: Define depi_safe macro
      parisc: Fix lpa and lpa_user defines
      parisc: Avoid calling faulthandler_disabled() twice
      parisc: Don't call faulthandler_disabled() in do_page_fault()
      parisc: Enhance page fault termination message
      parisc: Rewrite light-weight syscall and futex code
      parisc: Add lws_atomic_xchg and lws_atomic_store syscalls

Masahiro Yamada (1):
      parisc: decompressor: do not copy source files while building

 arch/parisc/Kconfig                     |  17 +-
 arch/parisc/boot/compressed/.gitignore  |   2 -
 arch/parisc/boot/compressed/Makefile    |   8 -
 arch/parisc/boot/compressed/firmware.c  |   2 +
 arch/parisc/boot/compressed/real2.S     |   2 +
 arch/parisc/include/asm/assembly.h      |  10 +
 arch/parisc/include/asm/futex.h         |  59 ++-
 arch/parisc/include/asm/io.h            |   6 +-
 arch/parisc/include/asm/special_insns.h |  44 +-
 arch/parisc/include/asm/uaccess.h       |  12 +-
 arch/parisc/include/uapi/asm/pdc.h      |  32 +-
 arch/parisc/kernel/Makefile             |   3 +-
 arch/parisc/kernel/asm-offsets.c        |   4 +
 arch/parisc/kernel/hpmc.S               |   6 +-
 arch/parisc/kernel/kgdb.c               |  21 +
 arch/parisc/kernel/syscall.S            | 774 ++++++++++++++++++++++++--------
 arch/parisc/kernel/toc.c                |  18 +-
 arch/parisc/kernel/toc_asm.S            |  33 +-
 arch/parisc/kernel/traps.c              |   2 +-
 arch/parisc/mm/fault.c                  |  23 +-
 drivers/parisc/pdc_stable.c             |   3 +-
 include/asm-generic/sections.h          |  10 +-
 scripts/remove-stale-files              |   5 +
 23 files changed, 777 insertions(+), 319 deletions(-)
 create mode 100644 arch/parisc/boot/compressed/firmware.c
 create mode 100644 arch/parisc/boot/compressed/real2.S
