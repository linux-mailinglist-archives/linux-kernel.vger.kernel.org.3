Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1654E2DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351094AbiCUQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiCUQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:29:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73487ECDAD;
        Mon, 21 Mar 2022 09:27:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F390F2DD;
        Mon, 21 Mar 2022 16:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F390F2DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647880058; bh=YjCaZIKWqNqmu9dKnUmEOpi6LnasMpBng/VE75540eE=;
        h=From:To:Cc:Subject:Date:From;
        b=bOjjX6SWcDXgpRsnEM0S5z2snncWFOilXy40WqzSJfGvXEtnCtYZLYVUh1bViFe5o
         4ZgCpdcJwMfpe0hm+W21KdQRR7AyzhNOBTicoI/fmZ/na7Oz/gTmY/wzha0jHqrQyM
         CMKRDEAgcjrdmeLgnkNEDlPJDaoDWSVHGghgw1UJwvUzfjJXwxrnTX9i1DeXmqCtt4
         7+b7F8YZgfA7JEBMCw2Z3ibTLTeS/W3f7tbDoTMjhFKPs+X5bSfpohSoboD6zvAtFh
         kHfMvw+20rlmawbOwNgaI62jdaB3t1Ni9zrFT8QHp0UrQZ0NZ68DsiwFWMUe0AUQCG
         O9mSZIhZA60/A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.18
Date:   Mon, 21 Mar 2022 10:27:37 -0600
Message-ID: <8735jbnudi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 854d0982eef0e424e8108d09d9275aaf445b1597:

  docs/vm: Fix typo in *harden* (2022-01-27 11:22:34 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.18

for you to fetch changes up to 75c05fabb873367d9e64f063dda8a310c4c58826:

  docs/kernel-parameters: update description of mem=3D (2022-03-16 15:57:56=
 -0600)

----------------------------------------------------------------
It has been a moderately busy cycle for documentation; some of the
highlights are:

- Numerous PDF-generation improvements

- Kees's new document with guidelines for researchers studying the
  development community.

- The ongoing stream of Chinese translations

- Thorsten's new document on regression handling

- A major reworking of the internal documentation for the kernel-doc
  script.

Plus the usual stream of typo fixes and such.

----------------------------------------------------------------
Akira Yokosawa (14):
      docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
      docs: sphinx/kfigure.py: Add check of 'dot -Tpdf'
      docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
      docs: sphinx/kfigure.py: Delegate inkscape msg to kernellog.verbose
      docs: Makefile: Add -no-shell-escape option to LATEXOPTS
      docs: pdfdocs: Tweak width params of TOC
      docs: pdfdocs: Switch default CJK font to KR variants
      docs: pdfdocs: Enable CJKspace in TOC for Korean titles
      docs/translations: Skip CJK contents if suitable fonts not found
      docs: pdfdocs: Move CJK monospace font setting to main conf.py
      docs: scripts/kernel-doc: Detect absence of FILE arg
      docs: pdfdocs: Pull LaTeX preamble part out of conf.py
      docs: kerneldoc-preamble.sty: Expand comments in LaTeX code
      Reword note on missing CJK fonts

Andrew Halaney (1):
      Documentation/locking/locktypes: Fix PREEMPT_RT _bh() description

Andy Shevchenko (1):
      docs: process: submitting-patches: Clarify the Reported-by usage

Bagas Sanjaya (1):
      Documentation: describe how to apply incremental stable patches

Ethan Dye (1):
      docs: Fix wording in optional zram feature docs

Frank Rowand (1):
      Documentation: dev-tools: clarify KTAP specification wording

Jonathan Corbet (3):
      Merge branch 'pdf-conversion' into docs-next
      Merge branch 'pdf' into docs-next
      docs: fix RST error in vm/page_owner.rst

Kees Cook (1):
      Documentation/process: Add Researcher Guidelines

Mike Rapoport (1):
      docs/kernel-parameters: update description of mem=3D

Naohiro Aota (1):
      Documentation: block/diskstats: update function names

Nicolas Saenz Julienne (1):
      Documentation: core-api: entry: Add comments about nesting

Oscar Shiang (1):
      docs: Remove duplicated words in trace/osnoise-tracer

Pali Roh=C3=A1r (1):
      Documentation: Fix links for udftools project and pktcdvd tool

Randy Dunlap (1):
      Docs: ktap: add code-block type

Tang Yizhou (10):
      docs/zh_CN: Cleanup index.rst
      docs/zh_CN: Add power/index Chinese translation
      docs/zh_CN: Add opp Chinese translation
      docs/zh_CN: Add rbtree Chinese translation
      docs: scheduler: Fix outdated parameter of rebalance_domains
      docs/zh_CN: Add energy-model Chinese translation
      docs/zh_CN: Add sched-energy Chinese translation
      docs/zh_CN: Add sched-stats Chinese translation
      docs: scheduler: Convert schedutil.txt to ReST
      docs/zh_CN: Add sched-nice-design Chinese translation

Thomas Gleixner (1):
      Documentation: Fill the gaps about entry/noinstr constraints

Thorsten Leemhuis (3):
      docs: add two documents about regression handling
      docs: *-regressions.rst: explain how quickly issues should be handled
      docs: reporting-issues.rst: link new document about regressions

Tomasz Warnie=C5=82=C5=82o (11):
      scripts: kernel-doc: Add the basic POD sections
      scripts: kernel-doc: Relink argument parsing error handling to pod2us=
age
      scripts: kernel-doc: Translate the DESCRIPTION section
      scripts: kernel-doc: Translate the "Output format selection" subsecti=
on of OPTIONS
      scripts: kernel-doc: Translate the "Output format selection modifier"=
 subsection of OPTIONS
      scripts: kernel-doc: Translate the "Output selection" subsection of O=
PTIONS
      scripts: kernel-doc: Translate the "Output selection modifiers" subse=
ction of OPTIONS
      scripts: kernel-doc: Translate the "Other parameters" subsection of O=
PTIONS
      scripts: kernel-doc: Replace the usage function
      scripts: kernel-doc: Drop obsolete comments
      scripts: kernel-doc: Refresh the copyright lines

Vincent Whitchurch (1):
      docs: UML: Mention telnetd for port channel

Wan Jiabing (2):
      docs: fix 'make htmldocs' warning in perf
      docs: serial: fix a reference file name in driver.rst

Yanteng Si (20):
      docs/zh_CN: add vm/index translation
      docs_zh_CN: add active_mm translation
      docs/zh_CN: add balance translation
      docs/zh_CN: add damon index tronslation
      docs/zh_CN: add damon faq translation
      docs/zh_CN: add damon design translation
      docs/zh_CN: add damon api translation
      docs/zh_CN: add free_page_reporting translation
      docs/zh_CN: add highmem translation
      docs/zh_CN: add riscv vm-layout translation
      docs/zh_CN: add peci index translation
      docs/zh_CN: add peci subsystem translation
      docs/zh_CN: add devicetree index translation
      docs/zh_CN: add devicetree usage-model translation
      docs/zh_CN: add devicetree of_unittest translation
      docs/zh_CN: Refactoring the admin-guide directory index
      docs/zh_CN: add admin-guide damon index translation
      docs/zh_CN: add admin-guide damon start translation
      docs/zh_CN: add damon usage translation
      docs/zh_CN: add damon reclaim translation

Yixuan Cao (1):
      Documentation/vm/page_owner.rst: fix language

wangyong (1):
      docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst

xu xin (3):
      Add Chinese translation for vm/ksm.rst
      zh_CN: Add translations for admin-guide/mm/ksm.rst
      zh_CN: Add translation for admin-guide/mm/index.rst

 Documentation/Makefile                             |   2 +-
 Documentation/admin-guide/blockdev/zram.rst        |  20 +-
 Documentation/admin-guide/index.rst                |   1 +
 Documentation/admin-guide/iostats.rst              |   6 +-
 Documentation/admin-guide/kernel-parameters.txt    |  18 +
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/reporting-issues.rst     |  73 +-
 .../admin-guide/reporting-regressions.rst          | 451 +++++++++++++
 Documentation/cdrom/packet-writing.rst             |   4 +-
 Documentation/conf.py                              | 131 +---
 Documentation/core-api/entry.rst                   | 279 ++++++++
 Documentation/core-api/index.rst                   |   8 +
 Documentation/dev-tools/ktap.rst                   |  49 +-
 Documentation/driver-api/serial/driver.rst         |   2 +-
 Documentation/locking/locktypes.rst                |   2 +-
 Documentation/process/applying-patches.rst         |  28 +-
 Documentation/process/handling-regressions.rst     | 746 +++++++++++++++++=
++++
 Documentation/process/index.rst                    |   2 +
 Documentation/process/researcher-guidelines.rst    | 143 ++++
 Documentation/process/submitting-patches.rst       |   3 +-
 Documentation/scheduler/index.rst                  |   1 +
 Documentation/scheduler/sched-domains.rst          |   8 +-
 .../scheduler/{schedutil.txt =3D> schedutil.rst}     |  30 +-
 Documentation/sphinx/kerneldoc-preamble.sty        | 226 +++++++
 Documentation/sphinx/kfigure.py                    | 134 +++-
 Documentation/trace/osnoise-tracer.rst             |   4 +-
 Documentation/translations/conf.py                 |  12 -
 Documentation/translations/ja_JP/index.rst         |   4 +-
 Documentation/translations/ko_KR/index.rst         |   5 +-
 .../zh_CN/accounting/delay-accounting.rst          |  62 +-
 .../translations/zh_CN/admin-guide/index.rst       | 124 ++--
 .../zh_CN/admin-guide/mm/damon/index.rst           |  28 +
 .../zh_CN/admin-guide/mm/damon/reclaim.rst         | 232 +++++++
 .../zh_CN/admin-guide/mm/damon/start.rst           | 132 ++++
 .../zh_CN/admin-guide/mm/damon/usage.rst           | 286 ++++++++
 .../translations/zh_CN/admin-guide/mm/index.rst    |  49 ++
 .../translations/zh_CN/admin-guide/mm/ksm.rst      | 148 ++++
 .../translations/zh_CN/core-api/index.rst          |   2 +-
 .../translations/zh_CN/core-api/rbtree.rst         | 391 +++++++++++
 .../translations/zh_CN/devicetree/index.rst        |  50 ++
 .../translations/zh_CN/devicetree/of_unittest.rst  | 189 ++++++
 .../translations/zh_CN/devicetree/usage-model.rst  | 330 +++++++++
 Documentation/translations/zh_CN/index.rst         |  21 +-
 Documentation/translations/zh_CN/peci/index.rst    |  26 +
 Documentation/translations/zh_CN/peci/peci.rst     |  54 ++
 .../translations/zh_CN/power/energy-model.rst      | 190 ++++++
 Documentation/translations/zh_CN/power/index.rst   |  56 ++
 Documentation/translations/zh_CN/power/opp.rst     | 341 ++++++++++
 Documentation/translations/zh_CN/riscv/index.rst   |   1 +
 .../translations/zh_CN/riscv/vm-layout.rst         |  67 ++
 .../translations/zh_CN/scheduler/index.rst         |   9 +-
 .../translations/zh_CN/scheduler/sched-energy.rst  | 351 ++++++++++
 .../zh_CN/scheduler/sched-nice-design.rst          |  99 +++
 .../translations/zh_CN/scheduler/sched-stats.rst   | 156 +++++
 Documentation/translations/zh_CN/vm/active_mm.rst  |  85 +++
 Documentation/translations/zh_CN/vm/balance.rst    |  81 +++
 Documentation/translations/zh_CN/vm/damon/api.rst  |  32 +
 .../translations/zh_CN/vm/damon/design.rst         | 139 ++++
 Documentation/translations/zh_CN/vm/damon/faq.rst  |  48 ++
 .../translations/zh_CN/vm/damon/index.rst          |  33 +
 .../translations/zh_CN/vm/free_page_reporting.rst  |  38 ++
 Documentation/translations/zh_CN/vm/highmem.rst    | 128 ++++
 Documentation/translations/zh_CN/vm/index.rst      |  53 ++
 Documentation/translations/zh_CN/vm/ksm.rst        |  70 ++
 Documentation/translations/zh_TW/index.rst         |   4 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   6 +-
 Documentation/vm/page_owner.rst                    |  10 +-
 MAINTAINERS                                        |   2 +
 scripts/kernel-doc                                 | 354 +++++-----
 70 files changed, 6323 insertions(+), 549 deletions(-)
 create mode 100644 Documentation/admin-guide/reporting-regressions.rst
 create mode 100644 Documentation/core-api/entry.rst
 create mode 100644 Documentation/process/handling-regressions.rst
 create mode 100644 Documentation/process/researcher-guidelines.rst
 rename Documentation/scheduler/{schedutil.txt =3D> schedutil.rst} (92%)
 create mode 100644 Documentation/sphinx/kerneldoc-preamble.sty
 delete mode 100644 Documentation/translations/conf.py
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/i=
ndex.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/r=
eclaim.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/s=
tart.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/u=
sage.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/index.r=
st
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/rbtree.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/index.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/of_unittest=
.rst
 create mode 100644 Documentation/translations/zh_CN/devicetree/usage-model=
.rst
 create mode 100644 Documentation/translations/zh_CN/peci/index.rst
 create mode 100644 Documentation/translations/zh_CN/peci/peci.rst
 create mode 100644 Documentation/translations/zh_CN/power/energy-model.rst
 create mode 100644 Documentation/translations/zh_CN/power/index.rst
 create mode 100644 Documentation/translations/zh_CN/power/opp.rst
 create mode 100644 Documentation/translations/zh_CN/riscv/vm-layout.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-energy=
.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-nice-d=
esign.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-stats.=
rst
 create mode 100644 Documentation/translations/zh_CN/vm/active_mm.rst
 create mode 100644 Documentation/translations/zh_CN/vm/balance.rst
 create mode 100644 Documentation/translations/zh_CN/vm/damon/api.rst
 create mode 100644 Documentation/translations/zh_CN/vm/damon/design.rst
 create mode 100644 Documentation/translations/zh_CN/vm/damon/faq.rst
 create mode 100644 Documentation/translations/zh_CN/vm/damon/index.rst
 create mode 100644 Documentation/translations/zh_CN/vm/free_page_reporting=
.rst
 create mode 100644 Documentation/translations/zh_CN/vm/highmem.rst
 create mode 100644 Documentation/translations/zh_CN/vm/index.rst
 create mode 100644 Documentation/translations/zh_CN/vm/ksm.rst
