Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC38536918
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353197AbiE0XC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiE0XC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:02:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C212E33F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:02:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so5536600pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xYVHCl/Xc9S+LdQbVuLzGS9n/Ik2J15PVCpCDhSAeog=;
        b=3+WCWlBLrTPP74onI6sVY3zOylHFVssupUpB5BhHRLaoBYi3VIWHfalrCFO0eg/INM
         PJKLAw/EcUhbuJ09XId4j/cHEqdil6iz2OQm/qZ/rFnj2+aJyh/Wq8tRmEoYS6cvYu0P
         qKZ5AGH5NeDSRhoNkycdouWcZUInvuJl43UaWLTgs6mRLcfv7hIK3CMpVD4AjI3n4tLf
         ZG3gh4Ee/+SkLsbmUThfTsn3niXCi1FxmAsbUi/n5KVb8oGM8m1sTGCUxfbj8d9OtwLL
         YWCicSEM1ccGB40V3Z8Ah8kBuOS3v6BnHaeB960+0PwOAmu8tWJyFJ+2npQDiG2mkyTq
         b21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xYVHCl/Xc9S+LdQbVuLzGS9n/Ik2J15PVCpCDhSAeog=;
        b=oU+i4lM0oUU5U2eOdseF0EYH14XZ6g4paqG0gnaRI6bYqHqq9mcJQdGZfYWx/iRrhP
         QB29SK0auDgZwZJ4Byq/vFz+vWhBzOTeGbDlN1qzjTT5OBhCYBstRasoBOcF57o4fneU
         1ZgzrAagRY08ILr4Gl8dm+7ew8SHahzUF86nCgSAnOFU0Oy+FNYl9Jw4Ibi4YqasbIXO
         H2Ga5cERjMeSnzYmYrQS6hIREkT5bm9mRae6ZL9Y+R5E3aEjr/N8KNWLG51g3eS8Z7Tq
         UUQu0Ox/bLKaCTqh0udPXCQzz7wCgeyJ1YbC2jJD+MfxS/VV3ZTLFTztOT7PD9wk1B+p
         5RiA==
X-Gm-Message-State: AOAM532WFD/ZE5mGoDa6s+eMrG8o3Kg6V4Nfi5kS21sT17WpOAL6uzvs
        FfJBPrE71G4uiw80Vdi0aGS37JF/vjMItA8c1sVAMQ==
X-Google-Smtp-Source: ABdhPJzpmxSaUq/+C3wNgGna1Vs4gnc9QL2CMADJ9qDD7W2F4JZ0oOyJ/VE10sK2MnKm2ffbHBKIk2l8WCtJACkzygg=
X-Received: by 2002:a63:5610:0:b0:3f2:7e19:1697 with SMTP id
 k16-20020a635610000000b003f27e191697mr38215091pgb.74.1653692574359; Fri, 27
 May 2022 16:02:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 May 2022 16:02:53 -0700
Message-ID: <CAPcyv4gmk-69G+eqtxqeNUoy0G9XPvdTJg1h32_F9qudbx4SOw@mail.gmail.com>
Subject: [GIT PULL] Compute Express Link for 5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.19

...to receive the CXL update for this cycle. The highlight is new
driver-core infrastructure and CXL subsystem changes for allowing
lockdep to validate device_lock() usage. Thanks to PeterZ for setting
me straight on the current capabilities of the lockdep API, and Greg
acked it as well.

On the CXL ACPI side this update adds support for CXL _OSC so that
platform firmware knows that it is safe to still grant Linux native
control of PCIe hotplug and error handling in the presence of CXL
devices. A circular dependency problem was discovered between suspend
and CXL memory for cases where the suspend image might be stored in
CXL memory where that image also contains the PCI register state to
restore to re-enable the device. Disable suspend for now until an
architecture is defined to clarify that conflict.

Lastly a collection of reworks, fixes, and cleanups to the CXL
subsystem where support for snooping mailbox commands and properly
handling the "mem_enable" flow are the highlights.

It has appeared in -next for several releases with some fixes from Dan
and others, but no more outstanding issues as of now.

Please pull, thanks.

---

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.19

for you to fetch changes up to 34e37b4c432cd0f1842b352fde4b8878b4166888:

  cxl/port: Enable HDM Capability after validating DVSEC Ranges
(2022-05-20 12:30:53 -0700)

----------------------------------------------------------------
cxl for 5.19

- Add driver-core infrastructure for lockdep validation of
  device_lock(), and fixup a deadlock report that was previously hidden
  behind the 'lockdep no validate' policy.

- Add CXL _OSC support for claiming native control of CXL hotplug and
  error handling.

- Disable suspend in the presence of CXL memory unless and until a
  protocol is identified for restoring PCI device context from memory
  hosted on CXL PCI devices.

- Add support for snooping CXL mailbox commands to protect against
  inopportune changes, like set-partition with the 'immediate' flag set.

- Rework how the driver detects legacy CXL 1.1 configurations (CXL DVSEC
  / 'mem_enable') before enabling new CXL 2.0 decode configurations (CXL
  HDM Capability).

- Miscellaneous cleanups and fixes from -next exposure.

----------------------------------------------------------------
Alison Schofield (11):
      cxl/mbox: Move cxl_mem_command construction to helper funcs
      cxl/mbox: Move raw command warning to raw command validation
      cxl/mbox: Move build of user mailbox cmd to a helper functions
      cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
      cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
      cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
      cxl/mbox: Move cxl_mem_command param to a local variable
      cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
      cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
      cxl/mbox: Use type __u32 for mailbox payload sizes
      cxl/mbox: Replace NULL check with IS_ERR() after vmemdup_user()

Dan Carpenter (1):
      cxl/mbox: fix logical vs bitwise typo

Dan Williams (29):
      cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
      cxl/pci: Add debug for DVSEC range init failures
      cxl/mem: Make cxl_dvsec_range() init failure fatal
      cxl/pci: Make cxl_dvsec_ranges() failure not fatal to cxl_pci
      cxl/mem: Rename cxl_dvsec_decode_init() to cxl_hdm_decode_init()
      cxl/mem: Replace redundant debug message with a comment
      PM: CXL: Disable suspend
      PCI/ACPI: Prefer CXL _OSC instead of PCIe _OSC for CXL host bridges
      cxl: Replace lockdep_mutex with local lock classes
      cxl/acpi: Add root device lockdep validation
      cxl: Drop cxl_device_lock()
      nvdimm: Replace lockdep_mutex with local lock classes
      ACPI: NFIT: Drop nfit_device_lock()
      nvdimm: Drop nd_device_lock()
      device-core: Kill the lockdep_mutex
      nvdimm: Fix firmware activation deadlock scenarios
      cxl/mem: Drop mem_enabled check from wait_for_media()
      cxl/pci: Consolidate wait_for_media() and wait_for_media_ready()
      cxl/pci: Drop wait_for_valid() from cxl_await_media_ready()
      cxl/mem: Fix cxl_mem_probe() error exit
      cxl/mem: Validate port connectivity before dvsec ranges
      cxl/pci: Move cxl_await_media_ready() to the core
      cxl/mem: Consolidate CXL DVSEC Range enumeration in the core
      cxl/mem: Skip range enumeration if mem_enable clear
      cxl/mem: Merge cxl_dvsec_ranges() and cxl_hdm_decode_init()
      cxl/pci: Drop @info argument to cxl_hdm_decode_init()
      cxl/port: Move endpoint HDM Decoder Capability init to port driver
      cxl/port: Reuse 'struct cxl_hdm' context for hdm init
      cxl/port: Enable HDM Capability after validating DVSEC Ranges

Davidlohr Bueso (4):
      cxl/mbox: Drop mbox_mutex comment
      cxl/pci: Use CXL_MBOX_SUCCESS to check against mbox_cmd return code
      cxl/mbox: Improve handling of mbox_cmd hw return codes
      cxl/mbox: Use new return_code handling

Vishal Verma (2):
      PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
      PCI/ACPI: negotiate CXL _OSC

 drivers/Makefile                |   2 +-
 drivers/acpi/bus.c              |   2 +-
 drivers/acpi/nfit/core.c        |  30 ++--
 drivers/acpi/nfit/nfit.h        |  24 ---
 drivers/acpi/pci_root.c         | 238 ++++++++++++++++++++++----
 drivers/base/core.c             |   3 -
 drivers/cxl/Kconfig             |   4 +
 drivers/cxl/Makefile            |   2 +-
 drivers/cxl/acpi.c              |  13 ++
 drivers/cxl/core/Makefile       |   1 +
 drivers/cxl/core/mbox.c         | 334 ++++++++++++++++++++++--------------
 drivers/cxl/core/memdev.c       |   3 +
 drivers/cxl/core/pci.c          | 364 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pmem.c         |  10 +-
 drivers/cxl/core/port.c         |  68 ++++----
 drivers/cxl/core/suspend.c      |  24 +++
 drivers/cxl/cxl.h               |  78 ---------
 drivers/cxl/cxlmem.h            |  75 ++++++++-
 drivers/cxl/cxlpci.h            |   2 +
 drivers/cxl/mem.c               | 148 +++-------------
 drivers/cxl/pci.c               | 175 +------------------
 drivers/cxl/pmem.c              |  13 +-
 drivers/cxl/port.c              |  28 +++-
 drivers/nvdimm/btt_devs.c       |  23 +--
 drivers/nvdimm/bus.c            |  38 ++---
 drivers/nvdimm/core.c           |  19 +--
 drivers/nvdimm/dax_devs.c       |   4 +-
 drivers/nvdimm/dimm_devs.c      |  12 +-
 drivers/nvdimm/namespace_devs.c |  46 ++---
 drivers/nvdimm/nd-core.h        |  68 +-------
 drivers/nvdimm/pfn_devs.c       |  31 ++--
 drivers/nvdimm/pmem.c           |   2 +-
 drivers/nvdimm/region.c         |   2 +-
 drivers/nvdimm/region_devs.c    |  20 ++-
 include/acpi/acpi_bus.h         |  12 +-
 include/linux/acpi.h            |  42 ++++-
 include/linux/device.h          |  48 +++++-
 include/linux/lockdep.h         |   6 +-
 include/linux/pm.h              |   9 +
 include/uapi/linux/cxl_mem.h    |  14 +-
 kernel/power/hibernate.c        |   2 +-
 kernel/power/main.c             |   5 +-
 kernel/power/suspend.c          |   3 +-
 lib/Kconfig.debug               |  23 ---
 tools/testing/cxl/Kbuild        |   3 +-
 tools/testing/cxl/mock_mem.c    |  10 --
 tools/testing/cxl/test/mem.c    |  17 --
 tools/testing/cxl/test/mock.c   |  29 ++++
 48 files changed, 1266 insertions(+), 863 deletions(-)
 create mode 100644 drivers/cxl/core/suspend.c
 delete mode 100644 tools/testing/cxl/mock_mem.c
