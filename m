Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FF586E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiHAPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiHAPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:50:15 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91200263B;
        Mon,  1 Aug 2022 08:50:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A5E032C3;
        Mon,  1 Aug 2022 15:50:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A5E032C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659369011; bh=20A5U+Z3gG4choYaxh9BzbOOX1QGE8qoOKb510sBEP0=;
        h=From:To:Cc:Subject:Date:From;
        b=p6o+o3j98yfsVZnWPIgTRnF4RTPBMjY56mwPjeNQfcF4BpdIE9/0nvkae1ZwbfVgP
         vbyrDHRgCNOowXKI18tJ838NzR5qGKCgCcBhfAKlvn3hDk+k0iVz/UxEsNwS0RcpvD
         YdOEuOm0IJGVHbxmc6GBBcjmtnuXe8AKOr15NdAhu9/Y8KT4lsFUVJ5sWIEHKTeV/8
         IvWvMsBPk2i4Hmq1/HBzaMBbOPGYbm8yKztydi9Kl8Ch9DBmLZlyhSynRS3vzk6xlN
         rPYyNyues3EPSItl15IAMPdVpMpaXSXmWXPLAQCYKUf9MCbGoXvdUwXgKFyDYKRTbh
         HmZOXQXhvFOVA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.0
Date:   Mon, 01 Aug 2022 09:50:11 -0600
Message-ID: <87ilnc6k0c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.0

for you to fetch changes up to 339170d8d3da5685762619080263abb78700ab4c:

  docs: efi-stub: Fix paths for x86 / arm stubs (2022-07-28 09:41:56 -0600)

----------------------------------------------------------------
This was a moderately busy cycle for documentation, but nothing all that
earth-shaking:

- More Chinese translations, and an update to the Italian translations.
  The Japanese, Korean, and traditional Chinese translations are
  more-or-less unmaintained at this point, instead.

- Some build-system performance improvements.

- The removal of the archaic submitting-drivers.rst document, with the
  movement of what useful material that remained into other docs.

- Improvements to sphinx-pre-install to, hopefully, give more useful
  suggestions.

- A number of build-warning fixes

Plus the usual collection of typo fixes, updates, and more.

The -mm tree renames Documentation/vm to Documentation/*m*m; we tried to
avoid conflicts from that move, but some have crept in anyway.  The path
to resolution is for everything to be in the latter directory once all
is done.

----------------------------------------------------------------
Akira Yokosawa (3):
      docs/doc-guide: Add footnote on Inkscape for better images in PDF doc=
uments
      docs/doc-guide: Put meta title for kernel-doc HTML page
      docs/doc-guide: Mention make variable SPHINXDIRS

Alex Shi (1):
      doc/zh_CN: remove submitting-driver reference from docs

Binbin Zhou (12):
      docs/zh_CN: core-api: Update the translation of cachetlb.rst to 5.19-=
rc3
      docs/zh_CN: core-api: Update the translation of cpu_hotplug.rst to 5.=
19-rc3
      docs/zh_CN: core-api: Update the translation of irq/irq-domain.rst to=
 5.19-rc3
      docs/zh_CN: core-api: Update the translation of kernel-api.rst to 5.1=
9-rc3
      docs/zh_CN: core-api: Update the translation of mm-api.rst to 5.19-rc3
      docs/zh_CN: core-api: Update the translation of printk-basics.rst to =
5.19-rc3
      docs/zh_CN: core-api: Update the translation of printk-format.rst to =
5.19-rc3
      docs/zh_CN: core-api: Update the translation of workqueue.rst to 5.19=
-rc3
      docs/zh_CN: core-api: Update the translation of xarray.rst to 5.19-rc3
      docs/zh_CN: riscv: Remove the translation of pmu.rst
      docs/zh_CN: riscv: Update the translation of vm-layout.rst to 5.19-rc1
      docs/zh_CN: core-api: Add watch_queue Chinese translation

Chao Liu (1):
      docs: filesystems: f2fs: fix description about compress ioctl

David Reaver (1):
      scripts: get_feat.pl: use /usr/bin/env to find perl

Deming Wang (1):
      docs: Remove duplicate word

Dongliang Mu (1):
      docs: dev-tools: modify SPL reference URL to actual SPL doc entry

Dov Murik (1):
      Documentation: siphash: Fix typo in the name of offsetofend macro

Federico Vaga (1):
      doc:it_IT: align Italian documentation

Jason A. Donenfeld (1):
      docs: ABI: correct QEMU fw_cfg spec path

Jonathan Corbet (4):
      docs: automarkup: track failed cross-reference attempts
      docs: automarkup: do not look up symbols twice
      Merge branch 'submitting-drivers-removal' into docs-next
      docs: Remove spurious tag from admin-guide/mm/overcommit-accounting.r=
st

Jo=C3=A3o Paulo Rechi Vita (1):
      docs: efi-stub: Fix paths for x86 / arm stubs

Juerg Haefliger (1):
      docs: Kconfig: Fix help text indentation

Lukas Bulwahn (12):
      MAINTAINERS: mark linux-doc-tw-discuss mailing list moderated
      docs: kernel-docs: order reference from newest to oldest
      docs: kernel-docs: shorten the lengthy doc title
      docs: kernel-docs: reflect that it is community-maintained
      docs: kernel-docs: add a reference mentioned in submitting-drivers.rst
      docs: admin: devices: drop confusing outdated statement on Latex
      docs: process: remove outdated submitting-drivers.rst
      docs: it_IT: align to submitting-drivers removal
      docs: ja_JP: howto: remove reference to removed submitting-drivers
      docs: ko_KR: howto: remove reference to removed submitting-drivers
      docs: zh_CN: align to submitting-drivers removal
      docs: zh_TW: align to submitting-drivers removal

Martin Li=C5=A1ka (1):
      docs/arm64: elf_hwcaps: Unify HWCAP lists as description lists

Mauro Carvalho Chehab (23):
      scripts: sphinx-pre-install: fix venv version check logic
      scripts: sphinx-pre-install: report broken venv
      scripts: sphinx-pre-install: check for PDF min version later on
      scripts: sphinx-pre-install: provide both venv and package installs
      scripts: sphinx-pre-install: place a warning for Sphinx >=3D 3.0
      docs: tegra194-hte.rst: don't include gpiolib.c twice
      docs: netdev: update maintainer-netdev.rst reference
      docs: filesystems: update netfs-api.rst reference
      docs: zh_CN: page_frags.rst: fix a broken reference
      docs: zh_CN/devicetree: fix typos
      docs: zh_CN: fix a broken reference
      docs: zh_CN/vm: fix a typo for page reporting ReST file
      docs: zh_CN/vm/zsmalloc.rst: fix a typo
      Documentation: update watch_queue.rst references
      Documentation: KVM: update s390-pv.rst reference
      Documentation: KVM: update amd-memory-encryption.rst references
      Documentation: KVM: update msr.rst reference
      Documentation: KVM: update s390-diag.rst reference
      objtool: update objtool.txt references
      arch: m68k: q40: README: drop references to IDE driver
      tegra194-hte.rst: fix reference to its binding
      dt-bindings: mfd: update dlg,da9063.yaml reference
      MAINTAINERS: update nvidia,tegra20-host1x.yaml reference

Michael Kelley (3):
      Documentation: hyperv: Add overview of Hyper-V enlightenments
      Documentation: hyperv: Add overview of VMbus
      Documentation: hyperv: Add overview of clocks and timers

Muhammad Usama Anjum (1):
      docs/kselftest: add more guidelines for adding new tests

Niklas S=C3=B6derlund (1):
      scripts: kernel-doc: Always increment warnings counter

Sotir Danailov (1):
      Documentation: process: Update email client instructions for Thunderb=
ird

Stephen Kitt (1):
      docs: admin-guide/sysctl: Fix rendering error

Steven Lung (1):
      docs: UML: fix typo

Tang Yizhou (2):
      docs/zh_CN: Show the Chinese translation of spinlocks
      docs/zh_CN: Add mutex-design Chinese translation

Tom Schwindl (1):
      docs: driver-api: gpio: Fix some typos

Wu XiangCheng (3):
      docs/zh_CN: Update translation of reporting-issues.rst to 5.18
      docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to 5.19-rc1
      docs/zh_CN: Add a new translation of reporting-regressions.rst

Yanteng Si (13):
      docs/zh_CN: Update the translation of highmem to 5.19-rc1
      docs/zh_CN: Update the translation of page_owner to 5.19-rc1
      docs/zh_CN: Update the translation of vm index to 5.19-rc1
      docs/zh_CN: add vm page_migration translation
      docs/zh_CN: add vm vmalloced-kernel-stacks translation
      Docs/zh_CN: Update the translation of iio_configfs to 5.19-rc8
      Docs/zh_CN: Update the translation of kasan to 5.19-rc8
      Docs/zh_CN: Update the translation of sparse to 5.19-rc8
      Docs/zh_CN: Update the translation of testing-overview to 5.19-rc8
      Docs/zh_CN: Update the translation of usage to 5.19-rc8
      Docs/zh_CN: Update the translation of pci-iov-howto to 5.19-rc8
      Docs/zh_CN: Update the translation of pci to 5.19-rc8
      Docs/zh_CN: Update the translation of sched-stats to 5.19-rc8

Yixuan Cao (1):
      Documentation/translations/zh_CN/mm/page_owner.rst: adjust some words

 .../ABI/testing/sysfs-firmware-qemu_fw_cfg         |   5 +-
 Documentation/Kconfig                              |  23 +-
 Documentation/admin-guide/devices.rst              |   7 +-
 Documentation/admin-guide/efi-stub.rst             |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 Documentation/admin-guide/sysctl/kernel.rst        |   4 +-
 Documentation/arm64/elf_hwcaps.rst                 |  23 --
 Documentation/dev-tools/coccinelle.rst             |   2 +-
 Documentation/dev-tools/kselftest.rst              |  27 +-
 .../devicetree/bindings/input/da9062-onkey.txt     |   2 +-
 Documentation/doc-guide/kernel-doc.rst             |   2 +
 Documentation/doc-guide/sphinx.rst                 |  14 +-
 Documentation/driver-api/gpio/consumer.rst         |   2 +-
 Documentation/driver-api/gpio/driver.rst           |   6 +-
 Documentation/driver-api/gpio/using-gpio.rst       |   2 +-
 Documentation/driver-api/hte/tegra194-hte.rst      |   5 +-
 Documentation/filesystems/f2fs.rst                 |  13 +-
 Documentation/filesystems/overlayfs.rst            |   2 +-
 Documentation/hwmon/submitting-patches.rst         |   1 -
 Documentation/kernel-hacking/hacking.rst           |   3 +-
 Documentation/process/5.Posting.rst                |   3 +-
 Documentation/process/8.Conclusion.rst             |  16 +-
 Documentation/process/email-clients.rst            |  69 ++--
 Documentation/process/howto.rst                    |   4 +-
 Documentation/process/index.rst                    |   1 -
 Documentation/process/kernel-docs.rst              |  62 +--
 Documentation/process/submitting-drivers.rst       | 194 ---------
 Documentation/process/submitting-patches.rst       |   5 +-
 Documentation/security/keys/core.rst               |   2 +-
 Documentation/security/secrets/coco.rst            |   2 +-
 Documentation/security/siphash.rst                 |   2 +-
 Documentation/sphinx/automarkup.py                 |  56 +--
 .../devicetree/bindings/submitting-patches.rst     |  11 +
 .../translations/it_IT/doc-guide/kernel-doc.rst    |   2 +
 .../translations/it_IT/doc-guide/sphinx.rst        |  18 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |  27 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |  14 +-
 .../it_IT/maintainer/configure-git.rst             |  10 +
 .../translations/it_IT/networking/netdev-FAQ.rst   |   2 +-
 .../translations/it_IT/process/3.Early-stage.rst   |  17 +-
 .../translations/it_IT/process/5.Posting.rst       |  32 +-
 .../translations/it_IT/process/8.Conclusion.rst    |   5 +-
 .../translations/it_IT/process/changes.rst         |  25 +-
 .../translations/it_IT/process/coding-style.rst    |  42 +-
 .../translations/it_IT/process/deprecated.rst      |  24 +-
 Documentation/translations/it_IT/process/howto.rst |   3 +-
 Documentation/translations/it_IT/process/index.rst |   2 +-
 .../it_IT/process/maintainer-handbooks.rst         |  24 ++
 .../it_IT/process/maintainer-pgp-guide.rst         |  14 +-
 .../translations/it_IT/process/maintainer-tip.rst  |  10 +
 .../translations/it_IT/process/maintainers.rst     |  13 +
 .../it_IT/process/stable-kernel-rules.rst          |  42 +-
 .../it_IT/process/submitting-drivers.rst           |  16 -
 .../it_IT/process/submitting-patches.rst           |  72 ++--
 Documentation/translations/ja_JP/howto.rst         |   4 +-
 Documentation/translations/ko_KR/howto.rst         |   2 +-
 .../translations/zh_CN/PCI/pci-iov-howto.rst       |   7 +-
 Documentation/translations/zh_CN/PCI/pci.rst       |   6 +-
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst           |   2 +
 .../zh_CN/admin-guide/reporting-issues.rst         | 125 +++---
 .../zh_CN/admin-guide/reporting-regressions.rst    | 370 ++++++++++++++++++
 .../translations/zh_CN/core-api/cachetlb.rst       |   6 +
 .../translations/zh_CN/core-api/cpu_hotplug.rst    | 435 +++++++++++++++++=
+---
 .../translations/zh_CN/core-api/index.rst          |   1 +
 .../translations/zh_CN/core-api/irq/irq-domain.rst |  22 +-
 .../translations/zh_CN/core-api/kernel-api.rst     |   3 +
 .../translations/zh_CN/core-api/mm-api.rst         |  23 +-
 .../translations/zh_CN/core-api/printk-basics.rst  |   3 +-
 .../translations/zh_CN/core-api/printk-formats.rst |   3 +-
 .../translations/zh_CN/core-api/watch_queue.rst    | 313 +++++++++++++++
 .../translations/zh_CN/core-api/workqueue.rst      |  21 +-
 .../translations/zh_CN/core-api/xarray.rst         |   4 +-
 .../translations/zh_CN/dev-tools/kasan.rst         | 117 ++++--
 .../translations/zh_CN/dev-tools/sparse.rst        |   2 +
 .../zh_CN/dev-tools/testing-overview.rst           |  25 ++
 .../translations/zh_CN/devicetree/index.rst        |   2 +-
 .../translations/zh_CN/devicetree/of_unittest.rst  |   2 +-
 .../translations/zh_CN/devicetree/usage-model.rst  |   2 +-
 .../translations/zh_CN/doc-guide/kernel-doc.rst    |   2 +-
 .../translations/zh_CN/iio/iio_configfs.rst        |  12 +-
 .../translations/zh_CN/kernel-hacking/hacking.rst  |  25 +-
 Documentation/translations/zh_CN/locking/index.rst |   5 +-
 .../translations/zh_CN/locking/mutex-design.rst    | 145 +++++++
 .../translations/zh_CN/process/5.Posting.rst       |   3 +-
 .../translations/zh_CN/process/8.Conclusion.rst    |   1 -
 Documentation/translations/zh_CN/process/howto.rst |   1 -
 Documentation/translations/zh_CN/process/index.rst |   1 -
 .../zh_CN/process/submitting-drivers.rst           | 160 --------
 .../zh_CN/process/submitting-patches.rst           |   4 +-
 Documentation/translations/zh_CN/riscv/index.rst   |   1 -
 Documentation/translations/zh_CN/riscv/pmu.rst     | 235 -----------
 .../translations/zh_CN/riscv/vm-layout.rst         |  37 ++
 .../translations/zh_CN/scheduler/sched-stats.rst   |   8 +-
 .../translations/zh_CN/vm/free_page_reporting.rst  |   2 +-
 Documentation/translations/zh_CN/vm/frontswap.rst  |   2 +-
 Documentation/translations/zh_CN/vm/highmem.rst    |  77 ++--
 Documentation/translations/zh_CN/vm/index.rst      |  31 +-
 Documentation/translations/zh_CN/vm/page_frags.rst |   2 +-
 .../translations/zh_CN/vm/page_migration.rst       | 228 +++++++++++
 Documentation/translations/zh_CN/vm/page_owner.rst |  79 +++-
 .../zh_CN/vm/vmalloced-kernel-stacks.rst           | 133 +++++++
 Documentation/translations/zh_CN/vm/zsmalloc.rst   |   2 +-
 .../translations/zh_TW/process/5.Posting.rst       |   3 +-
 .../translations/zh_TW/process/8.Conclusion.rst    |   1 -
 Documentation/translations/zh_TW/process/howto.rst |   1 -
 Documentation/translations/zh_TW/process/index.rst |   1 -
 .../zh_TW/process/submitting-drivers.rst           | 164 --------
 .../zh_TW/process/submitting-patches.rst           |   4 +-
 Documentation/virt/hyperv/clocks.rst               |  73 ++++
 Documentation/virt/hyperv/index.rst                |  12 +
 Documentation/virt/hyperv/overview.rst             | 207 ++++++++++
 Documentation/virt/hyperv/vmbus.rst                | 303 ++++++++++++++
 Documentation/virt/index.rst                       |   1 +
 Documentation/virt/kvm/api.rst                     |   4 +-
 Documentation/virt/kvm/s390/s390-pv-boot.rst       |   2 +-
 Documentation/virt/kvm/x86/hypercalls.rst          |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   2 +-
 Documentation/vm/overcommit-accounting.rst         |   2 -
 Documentation/x86/orc-unwinder.rst                 |   2 +-
 MAINTAINERS                                        |   7 +-
 arch/m68k/q40/README                               |   5 +-
 include/linux/fscache.h                            |   2 +-
 include/linux/objtool.h                            |   2 +-
 include/linux/watch_queue.h                        |   2 +-
 init/Kconfig                                       |   2 +-
 kernel/watch_queue.c                               |   2 +-
 lib/Kconfig.debug                                  |   2 +-
 scripts/get_feat.pl                                |   2 +-
 scripts/kernel-doc                                 |  82 ++--
 scripts/sphinx-pre-install                         |  90 ++++-
 tools/include/linux/objtool.h                      |   2 +-
 tools/objtool/check.c                              |   2 +-
 133 files changed, 3274 insertions(+), 1400 deletions(-)
 delete mode 100644 Documentation/process/submitting-drivers.rst
 create mode 100644 Documentation/translations/it_IT/devicetree/bindings/su=
bmitting-patches.rst
 create mode 100644 Documentation/translations/it_IT/maintainer/configure-g=
it.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainer-han=
dbooks.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainer-tip=
.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainers.rst
 delete mode 100644 Documentation/translations/it_IT/process/submitting-dri=
vers.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/reporting-=
regressions.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/watch_queue.r=
st
 create mode 100644 Documentation/translations/zh_CN/locking/mutex-design.r=
st
 delete mode 100644 Documentation/translations/zh_CN/process/submitting-dri=
vers.rst
 delete mode 100644 Documentation/translations/zh_CN/riscv/pmu.rst
 create mode 100644 Documentation/translations/zh_CN/vm/page_migration.rst
 create mode 100644 Documentation/translations/zh_CN/vm/vmalloced-kernel-st=
acks.rst
 delete mode 100644 Documentation/translations/zh_TW/process/submitting-dri=
vers.rst
 create mode 100644 Documentation/virt/hyperv/clocks.rst
 create mode 100644 Documentation/virt/hyperv/index.rst
 create mode 100644 Documentation/virt/hyperv/overview.rst
 create mode 100644 Documentation/virt/hyperv/vmbus.rst
