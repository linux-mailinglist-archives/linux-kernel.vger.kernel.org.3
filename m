Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC84E9870
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiC1Nlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbiC1Nlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:41:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7330F40
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170E761015
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28448C34111;
        Mon, 28 Mar 2022 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648474795;
        bh=H2qp+0wBKzMRRv5fTBaImRmw9Ax+xJlzZ+N9yTq+Aiw=;
        h=Date:From:To:Cc:Subject:From;
        b=hq6iBqjLG+4unbS0vw6IRo8jmT4vN2pgwDeLIXmiZGT4CFxPN5VWKDzucY5I3oGds
         5Lp8YxufWdgb1d8IK8wx842cZAON/e5uWvmKKpxXI9RFS3DYQ2AkgAEv6X2hnJLIc8
         IXN5K9Xyh96DOmXZDFQk4fWs3eKaBzHdX0HDqyyM=
Date:   Mon, 28 Mar 2022 15:39:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.18-rc1
Message-ID: <YkG6qJsnjjzF0iFD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc1

for you to fetch changes up to 88d99e870143199ba5bf42701dca06ce1d1388f0:

  Documentation: update stable review cycle documentation (2022-03-18 14:32:49 +0100)

----------------------------------------------------------------
Driver core changes for 5.18-rc1

Here is the set of driver core changes for 5.18-rc1.

Not much here, primarily it was a bunch of cleanups and small updates:
	- kobj_type cleanups for default_groups
	- documentation updates
	- firmware loader minor changes
	- component common helper added and take advantage of it in many
	  drivers (the largest part of this pull request).

There will be a merge conflict in drivers/power/supply/ab8500_chargalg.c
with your tree, the merge conflict should be easy (take all the
changes).

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anthony Iliopoulos (1):
      devtmpfs: drop redundant fs parameters from internal fs

Bagas Sanjaya (4):
      Documentation: add note block surrounding security patch note
      Documentation: add link to stable release candidate tree
      Documentation: update stable tree link
      Documentation: update stable review cycle documentation

Ding Xiang (1):
      spdxcheck.py: Fix a type error

Douglas Anderson (1):
      debugfs: Document that debugfs_create functions need not be error checked

Geert Uytterhoeven (1):
      base: soc: Make soc_device_match() simpler and easier to read

Greg Kroah-Hartman (9):
      SUNRPC: use default_groups in kobj_type
      NFS: use default_groups in kobj_type
      power_supply: ab8500: use default_groups in kobj_type
      omapfb: use default_groups in kobj_type
      bcache: use default_groups in kobj_type
      ubifs: use default_groups in kobj_type
      kernfs: move struct kernfs_root out of the public view.
      Merge 5.17-rc6 into driver-core-next
      kernfs: remove unneeded #if 0 guard

Imran Khan (1):
      kernfs: remove redundant kernfs_rwsem declaration.

Jonathan Neuschäfer (1):
      scripts/get_abi.pl: Ignore hidden files

Julia Lawall (2):
      kernfs: fix typos in comments
      devres: fix typos in comments

Luis Chamberlain (1):
      firmware_loader: simplfy builtin or module check

Michal Simek (1):
      scripts: get_abi.pl: Fix typo in help message

Nguyen Dinh Phi (1):
      samples/kobject: Use sysfs_emit instead of sprintf

Randy Dunlap (2):
      firmware_loader: EXTRA_FIRMWARE does not support compressed files
      driver core: dd: fix return value of __setup handler

Rob Herring (2):
      driver core: Refactor multiple copies of device cleanup
      driver core: Refactor sysfs and drv/bus remove hooks

Sergey Shtylyov (1):
      platform: use dev_err_probe() in platform_get_irq_byname()

Stephen Boyd (1):
      component: Replace most references to 'master' with 'aggregate device'

Tom Rix (1):
      driver core: cleanup double words comments

Yong Wu (23):
      component: Add common helper for compare/release functions
      drm/komeda: Make use of the helper component_compare_of
      drm/armada: Make use of the helper component_compare_of/dev_name
      drm/etnaviv: Make use of the helper component_compare_of/dev_name
      drm/hirin: Make use of the helper component_compare_of
      drm/ingenic: Make use of the helper component_compare_of
      drm/mediatek: Make use of the helper component_compare_of
      drm/meson: Make use of the helper component_compare_of
      drm/msm: Make use of the helper component_compare_of
      drm/sprd: Make use of the helper component_compare_of
      drm/sti: Make use of the helper component_compare_of
      drm/sun4i: Make use of the helper component_compare_of
      drm/rockchip: Make use of the helper component_compare_dev
      drm/exynos: Make use of the helper component_compare_dev
      drm/mcde: Make use of the helper component_compare_dev
      drm/omap: dss: Make use of the helper component_compare_dev
      drm/vc4: Make use of the helper component_compare_dev
      drm: of: Make use of the helper component_release_of
      iommu/mediatek: Make use of the helper component_compare/release_of
      ASoC: codecs: wcd938x: Make use of the helper component_compare/release_of
      power: supply: ab8500: Make use of the helper component_compare_dev
      video: omapfb: dss: Make use of the helper component_compare_dev
      ALSA: hda/realtek: Make use of the helper component_compare_dev_name

lizhe (1):
      drivers/base/dd.c : Remove the initial value of the global variable

 Documentation/process/stable-kernel-rules.rst      |  32 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   4 +-
 drivers/base/component.c                           | 300 ++++++++++++---------
 drivers/base/dd.c                                  |  88 +++---
 drivers/base/devres.c                              |   4 +-
 drivers/base/devtmpfs.c                            |   2 -
 drivers/base/firmware_loader/Kconfig               |   5 +
 drivers/base/platform.c                            |   6 +-
 drivers/base/soc.c                                 |  14 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |   7 +-
 drivers/gpu/drm/armada/armada_drv.c                |  17 +-
 drivers/gpu/drm/drm_of.c                           |   7 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  16 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   8 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |   7 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   7 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   7 +-
 drivers/gpu/drm/meson/meson_drv.c                  |  10 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  15 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |   8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   7 +-
 drivers/gpu/drm/sprd/sprd_drm.c                    |   7 +-
 drivers/gpu/drm/sti/sti_drv.c                      |   7 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  11 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   7 +-
 drivers/iommu/mtk_iommu.c                          |   4 +-
 drivers/iommu/mtk_iommu.h                          |  10 -
 drivers/iommu/mtk_iommu_v1.c                       |   4 +-
 drivers/md/bcache/stats.c                          |   3 +-
 drivers/md/bcache/sysfs.c                          |  15 +-
 drivers/md/bcache/sysfs.h                          |   2 +-
 drivers/power/supply/ab8500_chargalg.c             |   5 +-
 drivers/power/supply/ab8500_charger.c              |   8 +-
 drivers/power/supply/ab8500_fg.c                   |   3 +-
 .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |   3 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c         |   8 +-
 .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |   3 +-
 .../video/fbdev/omap2/omapfb/dss/overlay-sysfs.c   |   3 +-
 fs/debugfs/inode.c                                 |  10 +
 fs/kernfs/dir.c                                    |   9 +
 fs/kernfs/file.c                                   |   2 +-
 fs/kernfs/kernfs-internal.h                        |  19 +-
 fs/sysfs/mount.c                                   |   2 +-
 fs/ubifs/sysfs.c                                   |   3 +-
 include/linux/component.h                          |  24 +-
 include/linux/firmware.h                           |   2 +-
 include/linux/kernfs.h                             |  18 +-
 kernel/cgroup/cgroup.c                             |   4 +-
 samples/kobject/kobject-example.c                  |   4 +-
 samples/kobject/kset-example.c                     |   4 +-
 scripts/get_abi.pl                                 |   3 +-
 scripts/spdxcheck.py                               |   2 +-
 sound/pci/hda/patch_realtek.c                      |  11 +-
 sound/soc/codecs/wcd938x.c                         |  18 +-
 55 files changed, 381 insertions(+), 435 deletions(-)
