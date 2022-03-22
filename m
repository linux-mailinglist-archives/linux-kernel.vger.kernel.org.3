Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE024E4625
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiCVSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiCVSka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C461BEB8;
        Tue, 22 Mar 2022 11:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BF0612FC;
        Tue, 22 Mar 2022 18:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E19C340EC;
        Tue, 22 Mar 2022 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647974341;
        bh=83MxWvJXMMxW++0FlJkhqDhlQdcZsuRg4UGE2d3K+6w=;
        h=Date:From:To:Cc:Subject:From;
        b=il+PF/5lDTVALM0N2qoPSMPAqqGIuPjE3GYn6jbjRxPVk21cRep1A/IVxKET0tZXt
         sok4x4hv+Lh0rwFR3UKK6eWuelqsBJFGzl7qOA2UtFoOPnjgwsArNBNKek24j7c6yF
         OSZ2y7T7z/AuvmoYvDYfjT0ZQrj+sRjLGfCkjH9rccfZQll7np7/Mi+KWyQGwzEeUP
         9KtwvNggDbbr20wGckoy0tkAvpT20UFRuDV8S2rN8vE2dYJwo8sRmaXjrMS2diN5Hk
         oRPSNtCtdgeFMw8jeUtq9Rckgu8yIa1AgXa5OsE9ZLabnmWbYoU59DZ1JCP8IvZNXi
         6+3RcNzP/PHpg==
Date:   Tue, 22 Mar 2022 13:48:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations for 5.18-rc1
Message-ID: <20220322184802.GA2533969@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-5.18-rc1

for you to fetch changes up to 5224f79096170bf7b92cc8fe42a12f44b91e5f62:

  treewide: Replace zero-length arrays with flexible-array members (2022-02-17 07:00:39 -0600)

----------------------------------------------------------------
flexible-array transformations for 5.18-rc1

Hi Linus,

Please, pull the following treewide patch that replaces zero-length arrays with
flexible-array members. This patch has been baking in linux-next for a
whole development cycle.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      treewide: Replace zero-length arrays with flexible-array members

 arch/alpha/include/asm/hwrpb.h                       |  2 +-
 arch/ia64/include/asm/sal.h                          |  2 +-
 arch/s390/include/asm/ccwgroup.h                     |  2 +-
 arch/s390/include/asm/chsc.h                         |  2 +-
 arch/s390/include/asm/eadm.h                         |  2 +-
 arch/s390/include/asm/fcx.h                          |  4 ++--
 arch/s390/include/asm/idals.h                        |  2 +-
 arch/s390/include/asm/sclp.h                         |  2 +-
 arch/s390/include/asm/sysinfo.h                      |  6 +++---
 arch/sh/include/asm/thread_info.h                    |  2 +-
 arch/sparc/include/asm/vio.h                         | 10 +++++-----
 arch/um/include/shared/net_kern.h                    |  2 +-
 arch/x86/include/asm/microcode_amd.h                 |  2 +-
 arch/x86/include/asm/microcode_intel.h               |  4 ++--
 arch/x86/include/asm/pci.h                           |  2 +-
 arch/x86/include/asm/pci_x86.h                       |  2 +-
 arch/xtensa/include/asm/bootparam.h                  |  2 +-
 drivers/crypto/caam/pdb.h                            |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c           |  2 +-
 drivers/gpu/drm/nouveau/include/nvfw/hs.h            |  2 +-
 drivers/hwtracing/coresight/coresight-config.h       |  2 +-
 drivers/misc/bcm-vk/bcm_vk.h                         |  2 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h    |  6 +++---
 .../misc/habanalabs/include/gaudi/gaudi_packets.h    |  4 ++--
 drivers/misc/habanalabs/include/goya/goya_packets.h  |  4 ++--
 drivers/net/ethernet/freescale/enetc/enetc_hw.h      |  2 +-
 drivers/net/ethernet/i825xx/sun3_82586.h             |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h      |  6 +++---
 drivers/net/ethernet/qlogic/qed/qed_mfw_hsi.h        |  2 +-
 drivers/net/ethernet/ti/davinci_mdio.c               |  2 +-
 drivers/scsi/dpt/dpti_i2o.h                          |  2 +-
 drivers/scsi/elx/libefc_sli/sli4.h                   | 20 ++++++++++----------
 drivers/scsi/mpi3mr/mpi3mr.h                         |  2 +-
 drivers/scsi/qla2xxx/qla_bsg.h                       |  4 ++--
 drivers/scsi/qla2xxx/qla_def.h                       |  2 +-
 drivers/scsi/qla2xxx/qla_edif_bsg.h                  |  4 ++--
 drivers/scsi/qla2xxx/qla_fw.h                        |  2 +-
 drivers/scsi/qla4xxx/ql4_fw.h                        |  2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h            | 10 +++++-----
 drivers/staging/rtl8712/rtl871x_cmd.h                |  8 ++++----
 drivers/staging/rtl8723bs/include/ieee80211.h        |  2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h          |  2 +-
 .../vc04_services/include/linux/raspberrypi/vchiq.h  |  2 +-
 drivers/visorbus/vbuschannel.h                       |  2 +-
 fs/cifs/ntlmssp.h                                    |  2 +-
 fs/ext4/fast_commit.h                                |  4 ++--
 fs/ksmbd/ksmbd_netlink.h                             |  2 +-
 fs/ksmbd/ntlmssp.h                                   |  6 +++---
 fs/ksmbd/smb2pdu.h                                   |  8 ++++----
 fs/ksmbd/transport_rdma.c                            |  2 +-
 fs/ksmbd/xattr.h                                     |  2 +-
 fs/xfs/scrub/attr.h                                  |  2 +-
 include/asm-generic/tlb.h                            |  4 ++--
 include/linux/greybus/greybus_manifest.h             |  4 ++--
 include/linux/greybus/hd.h                           |  2 +-
 include/linux/greybus/module.h                       |  2 +-
 include/linux/i3c/ccc.h                              |  6 +++---
 include/linux/platform_data/brcmfmac.h               |  2 +-
 include/linux/platform_data/cros_ec_commands.h       |  2 +-
 include/net/bluetooth/mgmt.h                         |  2 +-
 include/net/ioam6.h                                  |  2 +-
 include/sound/sof/channel_map.h                      |  4 ++--
 scripts/dtc/libfdt/fdt.h                             |  4 ++--
 sound/soc/intel/atom/sst-mfld-dsp.h                  |  4 ++--
 sound/soc/intel/skylake/skl-topology.h               |  2 +-
 tools/lib/perf/include/perf/event.h                  |  2 +-
 66 files changed, 111 insertions(+), 111 deletions(-)
