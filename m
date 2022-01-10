Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4348489FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiAJTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:06:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:51110 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242273AbiAJTGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:06:22 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A3C836E;
        Mon, 10 Jan 2022 19:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A3C836E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641841582; bh=I27HtCbenu1YUK+88801ssWNiY6yTKRNWPPcmHtLwiU=;
        h=From:To:Cc:Subject:Date:From;
        b=WCf0gOnTm8Ov9mqov8iOQY2xdFedGCTtw5wBrb50U2eqXkbRA8WDNMdmRLVUW2VHT
         C+S33rO20jIXiPn6fVXvCNCYjXdB2+03natY8L9ru34b294e0I6cQnJfA8Tcwq1kDo
         CjeYGYnmbLsc6BWKgDTaTzblQddBJCD6C7Xr8WNILC8huVMhOleSQGcRhziXEs8QRi
         Bb+2MnJrBh18LyDqRqa9whySFBMRsy7XpGZA5Q68mWCza6QyTVz5h/oXzoNCL1tUcm
         NaPOUd2Jceji5F3MC/K0SU14Mn9UJ2ACqApQNmFVp3+4SiWh2wDRIlacojICSFToIu
         KR3WePGSsRLYw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.17
Date:   Mon, 10 Jan 2022 12:06:33 -0700
Message-ID: <87v8yrjtqe.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.17

for you to fetch changes up to 87d6576ddf8ac25f36597bc93ca17f6628289c16:

  scripts: sphinx-pre-install: Fix ctex support on Debian (2022-01-07 09:33=
:13 -0700)

----------------------------------------------------------------
This isn't a hugely busy cycle for documentation, but a few significant
things still showed up:

 - A documentation section for ARC processors
 - Reworked and enhanced KUnit documentation
 - The ability to pick your own theme for HTML builds; if the default
   "Read the Docs" theme isn't ugly enough for you, you can now pick
   an uglier one.
 - More Chinese translation work

Plus the usual assortment of fixes and cleanups.

The KUnit documentation update leads to a couple of simple conflicts
with the KUnit tree - but they wanted this work to go via this path.
----------------------------------------------------------------
Ahmed Zaki (1):
      Doc: networking: Fix the title's Sphinx overline in rds.rst

Alex Shi (1):
      doc/zh_CN: add Chinese document coding style reminder

Alexey Brodkin (2):
      docs: Add documentation for ARC processors
      docs: ARC: Improve readability

Anssi Hannula (1):
      docs/vm: clarify overcommit amount sysctl behavior

Christian L=C3=B6hle (1):
      Documentation: kgdb: Replace deprecated remotebaud

Harinder Singh (7):
      Documentation: KUnit: Rewrite main page
      Documentation: KUnit: Rewrite getting started
      Documentation: KUnit: Added KUnit Architecture
      Documentation: kunit: Reorganize documentation related to running tes=
ts
      Documentation: KUnit: Rework writing page to focus on writing tests
      Documentation: KUnit: Restyle Test Style and Nomenclature page
      Documentation: KUnit: Restyled Frequently Asked Questions

James Clark (1):
      docs: automarkup.py: Fix invalid HTML link output and broken URI frag=
ments

Jonathan Corbet (2):
      Merge tag 'v5.16-rc4' into docs-next
      docs: discourage use of list tables

Lukas Bulwahn (2):
      Documentation: kgdb: properly capitalize the MAGIC_SYSRQ config
      Documentation: refer to config RANDOMIZE_BASE for kernel address-spac=
e randomization

Mauro Carvalho Chehab (8):
      docs: allow selecting a Sphinx theme
      docs: allow to pass extra DOCS_CSS themes via make
      docs: set format for the classic mode
      docs: add support for RTD dark mode
      docs: Makefile: use the right path for DOCS_CSS
      docs: address some text issues with css/theme support
      scripts: sphinx-pre-install: add required ctex dependency
      scripts: sphinx-pre-install: Fix ctex support on Debian

Miguel Ojeda (1):
      Remove mentions of the Trivial Patch Monkey

Rae Moar (1):
      Documentation: dev-tools: Add KTAP specification

Randy Dunlap (1):
      Documentation/sphinx: fix typos of "its"

Shile Zhang (1):
      docs/zh_CN: Update and fix a couple of typos

Shuah Khan (1):
      docs: update self-protection __ro_after_init status

Tang Yizhou (7):
      doc/zh-CN: Update cpufreq-stats.rst to make it more readable
      doc/zh-CN: Update cpu-freq/cpu-drivers.rst to make it more readable
      doc/zh-CN: Update cpu-freq/core.rst to make it more readable
      docs/zh_CN: Add cputopology Chinese translation
      docs/zh_CN: Add sched-capacity Chinese translation
      docs/zh_CN: Add sched-design-CFS Chinese translation
      docs/zh_CN: Add sched-domains translation

Thorsten Leemhuis (1):
      docs: 5.Posting.rst: describe Fixes: and Link: tags

Yang Yang (2):
      docs/zh_CN: Add zh_CN/accounting/taskstats.rst
      docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst

Yanteng Si (12):
      docs/zh_CN: add pciebus-howto translation
      docs/zh_CN: add pci-iov-howto translation
      docs/zh_CN: move sparse into dev-tools
      docs/zh_CN: update sparse translation
      docs/zh_CN: add scheduler index translation
      docs/zh_CN: add completion translation
      docs/zh_CN: add scheduler sched-arch translation
      docs/zh_CN: add scheduler sched-bwc translation
      docs/scheduler: fix typo and warning in sched-bwc
      docs/trace: fix a label of boottime-trace
      docs/zh_CN: add msi-howto translation
      docs/zh_CN: add sysfs-pci trnaslation

Zhiqiang Liu (1):
      doc: fs: remove bdev_try_to_free_page related doc

 Documentation/Makefile                             |  11 +-
 .../admin-guide/blockdev/drbd/figures.rst          |   4 +-
 .../drbd/{node-states-8.dot =3D> peer-states-8.dot}  |   5 -
 Documentation/admin-guide/hw-vuln/spectre.rst      |   2 +-
 Documentation/arc/arc.rst                          |  85 +++
 Documentation/arc/features.rst                     |   3 +
 Documentation/arc/index.rst                        |  17 +
 Documentation/arch.rst                             |   1 +
 Documentation/conf.py                              |  97 +++-
 Documentation/dev-tools/index.rst                  |   1 +
 Documentation/dev-tools/kgdb.rst                   |   6 +-
 Documentation/dev-tools/ktap.rst                   | 298 +++++++++++
 Documentation/dev-tools/kunit/architecture.rst     | 204 ++++++++
 Documentation/dev-tools/kunit/faq.rst              |  73 ++-
 Documentation/dev-tools/kunit/index.rst            | 172 +++---
 .../dev-tools/kunit/kunit_suitememorydiagram.svg   |  81 +++
 Documentation/dev-tools/kunit/run_manual.rst       |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst      | 247 +++++++++
 Documentation/dev-tools/kunit/start.rst            | 198 +++----
 Documentation/dev-tools/kunit/style.rst            | 105 ++--
 Documentation/dev-tools/kunit/usage.rst            | 578 +++++++++--------=
----
 Documentation/doc-guide/sphinx.rst                 |  22 +-
 Documentation/filesystems/locking.rst              |   5 -
 Documentation/networking/rds.rst                   |   2 +-
 Documentation/process/5.Posting.rst                |  29 +-
 Documentation/process/changes.rst                  |  11 +
 Documentation/process/submitting-patches.rst       |  22 +-
 Documentation/scheduler/sched-bwc.rst              |   5 +-
 Documentation/security/self-protection.rst         |   3 +-
 Documentation/sphinx-static/theme_overrides.css    |  16 +-
 Documentation/sphinx-static/theme_rtd_colors.css   |  37 ++
 Documentation/sphinx/automarkup.py                 |  25 +-
 Documentation/sphinx/kernel_abi.py                 |   2 +-
 Documentation/sphinx/kernel_feat.py                |   2 +-
 Documentation/trace/boottime-trace.rst             |   4 +-
 Documentation/translations/zh_CN/PCI/index.rst     |   7 +-
 Documentation/translations/zh_CN/PCI/msi-howto.rst | 233 +++++++++
 .../translations/zh_CN/PCI/pci-iov-howto.rst       | 170 ++++++
 .../translations/zh_CN/PCI/pciebus-howto.rst       | 192 +++++++
 Documentation/translations/zh_CN/PCI/sysfs-pci.rst | 126 +++++
 .../zh_CN/accounting/delay-accounting.rst          | 111 ++++
 .../translations/zh_CN/accounting/index.rst        |   4 +-
 .../translations/zh_CN/accounting/taskstats.rst    | 145 ++++++
 .../translations/zh_CN/admin-guide/README.rst      |  11 +-
 .../translations/zh_CN/admin-guide/cputopology.rst |  96 ++++
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 Documentation/translations/zh_CN/cpu-freq/core.rst |  24 +-
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    | 139 ++---
 .../translations/zh_CN/cpu-freq/cpufreq-stats.rst  |  45 +-
 .../translations/zh_CN/dev-tools/index.rst         |   2 +-
 .../zh_CN/{sparse.txt =3D> dev-tools/sparse.rst}     |  67 ++-
 Documentation/translations/zh_CN/index.rst         |   7 +-
 .../translations/zh_CN/scheduler/completion.rst    | 256 +++++++++
 .../translations/zh_CN/scheduler/index.rst         |  44 ++
 .../translations/zh_CN/scheduler/sched-arch.rst    |  76 +++
 .../translations/zh_CN/scheduler/sched-bwc.rst     | 204 ++++++++
 .../zh_CN/scheduler/sched-capacity.rst             | 390 ++++++++++++++
 .../zh_CN/scheduler/sched-design-CFS.rst           | 205 ++++++++
 .../translations/zh_CN/scheduler/sched-domains.rst |  72 +++
 Documentation/vm/overcommit-accounting.rst         |   3 +-
 MAINTAINERS                                        |   7 +-
 scripts/sphinx-pre-install                         |   4 +
 62 files changed, 4239 insertions(+), 833 deletions(-)
 rename Documentation/admin-guide/blockdev/drbd/{node-states-8.dot =3D> pee=
r-states-8.dot} (71%)
 create mode 100644 Documentation/arc/arc.rst
 create mode 100644 Documentation/arc/features.rst
 create mode 100644 Documentation/arc/index.rst
 create mode 100644 Documentation/dev-tools/ktap.rst
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.=
svg
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst
 create mode 100644 Documentation/sphinx-static/theme_rtd_colors.css
 create mode 100644 Documentation/translations/zh_CN/PCI/msi-howto.rst
 create mode 100644 Documentation/translations/zh_CN/PCI/pci-iov-howto.rst
 create mode 100644 Documentation/translations/zh_CN/PCI/pciebus-howto.rst
 create mode 100644 Documentation/translations/zh_CN/PCI/sysfs-pci.rst
 create mode 100644 Documentation/translations/zh_CN/accounting/delay-accou=
nting.rst
 create mode 100644 Documentation/translations/zh_CN/accounting/taskstats.r=
st
 create mode 100644 Documentation/translations/zh_CN/admin-guide/cputopolog=
y.rst
 rename Documentation/translations/zh_CN/{sparse.txt =3D> dev-tools/sparse.=
rst} (58%)
 create mode 100644 Documentation/translations/zh_CN/scheduler/completion.r=
st
 create mode 100644 Documentation/translations/zh_CN/scheduler/index.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-arch.r=
st
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-bwc.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-capaci=
ty.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-design=
-CFS.rst
 create mode 100644 Documentation/translations/zh_CN/scheduler/sched-domain=
s.rst
