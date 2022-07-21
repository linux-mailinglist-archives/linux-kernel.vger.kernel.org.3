Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD957CF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGUPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiGUPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E7FE8735C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658417694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPuumuVLnq8qnbVN8OdSeg616C6kX3rQp22AoE4Gu5Q=;
        b=DFOhRQKZ21RTyv9AzZlHk9fTthevAjSB6SgrJUsBbX4009J6K4o9mZhtgObqCag2derQnj
        6kSipHTyrUfvclWHnKjX/hjXZhCkvbTOZnEmpYCJEokzEzTOhIUAc9rYcxFI39G8z9AVMr
        Tvp4Ib1cziOWPNux0fOZZmir9kUeeKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-c1vK5TWNOhW6dLm8FdDVmQ-1; Thu, 21 Jul 2022 11:34:45 -0400
X-MC-Unique: c1vK5TWNOhW6dLm8FdDVmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9337D801755;
        Thu, 21 Jul 2022 15:34:43 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C772418ECB;
        Thu, 21 Jul 2022 15:34:40 +0000 (UTC)
Date:   Thu, 21 Jul 2022 23:34:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     corbet@lwn.net, Slark Xiao <slark_xiao@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, william.gray@linaro.org, dhowells@redhat.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
        bigeasy@linutronix.de, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220721015605.20651-1-slark_xiao@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 at 09:56am, Slark Xiao wrote:
> Fix typo in the comment

When searching the typo 'the the' in kernel, I found it exists in so
many places. We can sweep them away at one time, lest patches posted to
fix them again and again.

=46rom 8185cce9e9afac63b760280aca12c0fca0e6f9fe Mon Sep 17 00:00:00 2001
=46rom: Baoquan He <bhe@redhat.com>
Date: Thu, 21 Jul 2022 23:16:42 +0800
Subject: [PATCH] Fix all occurences of the 'the the' typo
Content-type: text/plain

The fix is done with below command.
sed -i "s/the the /the /g" `git grep -l "the the "`

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/stable/sysfs-module                  |  2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client      |  2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server      |  2 +-
 .../ABI/testing/sysfs-devices-platform-ACPI-TAD        |  2 +-
 Documentation/ABI/testing/sysfs-devices-power          |  2 +-
 Documentation/admin-guide/kdump/vmcoreinfo.rst         |  2 +-
 Documentation/bpf/map_cgroup_storage.rst               |  4 ++--
 Documentation/core-api/cpu_hotplug.rst                 |  2 +-
 .../devicetree/bindings/arm/msm/qcom,saw2.txt          |  2 +-
 .../devicetree/bindings/clock/ti/davinci/pll.txt       |  2 +-
 Documentation/devicetree/bindings/fpga/fpga-region.txt |  2 +-
 Documentation/devicetree/bindings/gpio/gpio-pisosr.txt |  2 +-
 Documentation/devicetree/bindings/net/qcom-emac.txt    |  2 +-
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml        |  2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml       |  2 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml       |  2 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml       |  2 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml          |  2 +-
 Documentation/devicetree/bindings/powerpc/fsl/cpus.txt |  2 +-
 .../devicetree/bindings/powerpc/opal/power-mgt.txt     |  2 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt       |  2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml       |  4 ++--
 .../bindings/thermal/brcm,avs-ro-thermal.yaml          |  2 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.txt      |  2 +-
 .../devicetree/bindings/thermal/rcar-thermal.yaml      |  2 +-
 Documentation/driver-api/isa.rst                       |  2 +-
 Documentation/filesystems/caching/backend-api.rst      |  2 +-
 Documentation/locking/seqlock.rst                      |  2 +-
 Documentation/sphinx/cdomain.py                        |  2 +-
 arch/arm/Kconfig                                       |  4 ++--
 arch/arm/include/asm/unwind.h                          |  2 +-
 arch/arm/mach-pxa/hx4700-pcmcia.c                      |  2 +-
 arch/arm64/crypto/aes-neon.S                           |  2 +-
 arch/m68k/coldfire/intc-2.c                            |  2 +-
 arch/microblaze/kernel/entry.S                         |  2 +-
 arch/mips/alchemy/devboards/pm.c                       |  2 +-
 arch/s390/kernel/perf_cpum_sf.c                        |  2 +-
 arch/s390/kernel/sthyi.c                               |  2 +-
 arch/sparc/kernel/pci.c                                |  2 +-
 drivers/char/apm-emulation.c                           |  2 +-
 drivers/crypto/nx/nx-common-powernv.c                  |  2 +-
 drivers/crypto/ux500/hash/hash_core.c                  |  2 +-
 drivers/dma/mediatek/mtk-hsdma.c                       |  2 +-
 drivers/extcon/extcon.c                                |  2 +-
 drivers/firmware/qcom_scm.c                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                 |  2 +-
 drivers/gpu/drm/amd/include/atombios.h                 |  4 ++--
 drivers/gpu/drm/display/drm_dp_helper.c                |  4 ++--
 drivers/gpu/drm/drm_ioctl.c                            |  2 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c         |  2 +-
 drivers/gpu/drm/drm_prime.c                            |  2 +-
 drivers/gpu/drm/i915/i915_irq.c                        |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c          |  2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c          |  8 ++++----
 drivers/gpu/drm/pl111/pl111_display.c                  |  2 +-
 drivers/gpu/drm/vc4/vc4_regs.h                         |  2 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c           |  2 +-
 drivers/iio/magnetometer/hmc5843_core.c                |  2 +-
 drivers/infiniband/core/roce_gid_mgmt.c                |  2 +-
 drivers/infiniband/hw/qib/qib.h                        |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                |  2 +-
 drivers/input/mouse/gpio_mouse.c                       |  2 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c                  |  2 +-
 drivers/mailbox/Kconfig                                |  2 +-
 drivers/md/dm-raid.c                                   |  2 +-
 drivers/media/dvb-frontends/tda1002x.h                 |  2 +-
 drivers/media/dvb-frontends/tda10048.c                 |  2 +-
 drivers/media/i2c/mt9v111.c                            |  2 +-
 drivers/media/pci/cx88/cx88-dsp.c                      |  2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c                      |  2 +-
 drivers/media/pci/saa7164/saa7164-core.c               |  2 +-
 drivers/media/platform/ti/davinci/vpbe.c               |  2 +-
 drivers/media/platform/ti/omap3isp/isp.c               |  2 +-
 drivers/media/usb/gspca/finepix.c                      |  2 +-
 drivers/media/usb/tm6000/tm6000-cards.c                |  2 +-
 drivers/media/usb/uvc/uvc_video.c                      |  2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c                   |  2 +-
 drivers/message/fusion/mptspi.c                        |  2 +-
 drivers/mfd/db8500-prcmu.c                             |  2 +-
 drivers/misc/cxl/cxl.h                                 |  2 +-
 drivers/misc/sgi-gru/grukservices.c                    |  2 +-
 drivers/misc/sgi-xp/xpc_uv.c                           |  2 +-
 drivers/mmc/host/dw_mmc.c                              |  2 +-
 drivers/mmc/host/sdhci-acpi.c                          |  2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c             |  2 +-
 drivers/mtd/ubi/ubi.h                                  |  4 ++--
 drivers/mtd/ubi/wl.c                                   |  2 +-
 drivers/net/ethernet/agere/et131x.c                    |  2 +-
 .../ethernet/aquantia/atlantic/macsec/macsec_struct.h  |  4 ++--
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c            |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c           |  2 +-
 drivers/net/ethernet/intel/igb/e1000_82575.c           |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c          |  4 ++--
 drivers/net/ethernet/neterion/s2io.c                   |  2 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c           |  2 +-
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c   |  2 +-
 drivers/net/ipa/gsi_private.h                          |  2 +-
 drivers/net/ipa/gsi_trans.c                            |  4 ++--
 drivers/net/ipa/ipa_qmi_msg.h                          |  2 +-
 drivers/net/wireless/ath/ath6kl/hif.h                  |  2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c                 |  2 +-
 drivers/net/wireless/ath/ath9k/ar9002_phy.c            |  2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c            |  2 +-
 drivers/net/wireless/ath/wcn36xx/hal.h                 |  6 +++---
 .../net/wireless/broadcom/brcm80211/brcmsmac/main.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c      |  2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c            |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h         |  4 ++--
 drivers/net/wireless/rsi/rsi_91x_sdio.c                |  2 +-
 drivers/net/wireless/ti/wl1251/acx.h                   |  2 +-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c          |  2 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c               |  2 +-
 drivers/pinctrl/pinctrl-at91.c                         |  2 +-
 drivers/platform/chrome/wilco_ec/event.c               |  2 +-
 drivers/power/supply/power_supply_sysfs.c              |  2 +-
 drivers/power/supply/tps65217_charger.c                |  2 +-
 drivers/rtc/rtc-rs5c372.c                              |  2 +-
 drivers/s390/net/qeth_core_main.c                      |  2 +-
 drivers/s390/scsi/zfcp_diag.h                          |  2 +-
 drivers/scsi/aacraid/aachba.c                          |  2 +-
 drivers/scsi/bfa/bfa_fcs_rport.c                       |  2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                          |  2 +-
 drivers/scsi/isci/host.h                               |  2 +-
 drivers/scsi/isci/remote_device.h                      |  2 +-
 drivers/scsi/isci/remote_node_context.h                |  2 +-
 drivers/scsi/isci/task.c                               |  2 +-
 drivers/scsi/lpfc/lpfc_attr.c                          | 10 +++++-----
 drivers/scsi/lpfc/lpfc_els.c                           |  2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                       |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                          |  4 ++--
 drivers/scsi/lpfc/lpfc_mbox.c                          |  4 ++--
 drivers/scsi/lpfc/lpfc_nvmet.c                         |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c                           |  2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                       |  2 +-
 drivers/target/target_core_alua.c                      |  2 +-
 drivers/thunderbolt/ctl.h                              |  2 +-
 drivers/usb/dwc2/hcd.c                                 |  2 +-
 drivers/usb/host/max3421-hcd.c                         |  2 +-
 drivers/usb/host/xhci-ring.c                           |  2 +-
 drivers/usb/serial/cypress_m8.c                        |  2 +-
 drivers/usb/serial/mos7720.c                           |  2 +-
 fs/afs/flock.c                                         |  2 +-
 fs/ecryptfs/keystore.c                                 |  2 +-
 fs/kernfs/file.c                                       |  2 +-
 fs/xfs/libxfs/xfs_alloc.c                              |  2 +-
 fs/xfs/xfs_dquot.c                                     |  2 +-
 include/linux/fs.h                                     |  2 +-
 include/linux/seqlock.h                                |  2 +-
 include/uapi/asm-generic/fcntl.h                       |  2 +-
 lib/mpi/mpiutil.c                                      |  2 +-
 lib/zstd/compress/zstd_compress.c                      |  2 +-
 scripts/coccinelle/misc/badty.cocci                    |  2 +-
 scripts/tracing/draw_functrace.py                      |  2 +-
 tools/include/uapi/asm-generic/fcntl.h                 |  2 +-
 tools/perf/Documentation/perf-diff.txt                 |  2 +-
 .../pmu-events/arch/x86/cascadelakex/uncore-other.json |  2 +-
 .../perf/pmu-events/arch/x86/silvermont/pipeline.json  |  2 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json     |  2 +-
 tools/perf/util/cs-etm.c                               |  2 +-
 tools/power/x86/turbostat/turbostat.c                  |  2 +-
 .../futex/functional/futex_requeue_pi_signal_restart.c |  2 +-
 .../selftests/net/forwarding/vxlan_asymmetric.sh       |  2 +-
 tools/thermal/tmon/pid.c                               |  2 +-
 166 files changed, 188 insertions(+), 188 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stab=
le/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.
=20
 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentat=
ion/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@d=
st>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis=
@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established o=
n.
+Description:	RO, Contains the name of HCA the connection established on.
=20
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentat=
ion/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@d=
st>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis=
@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established o=
n.
+Description:	RO, Contains the name of HCA the connection established on.
=20
 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Do=
cumentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:
=20
 		Reads also cause the AC alarm timer status to be reset.
=20
-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.
=20
 		If the status return value indicates that the timer has expired,
diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/=
ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.
=20
diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation=
/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6726f439958c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -200,7 +200,7 @@ prb
=20
 A pointer to the printk ringbuffer (struct printk_ringbuffer). This
 may be pointing to the static boot ringbuffer or the dynamically
-allocated ringbuffer, depending on when the the core dump occurred.
+allocated ringbuffer, depending on when the core dump occurred.
 Used by user-space tools to read the active kernel log buffer.
=20
 printk_rb_static
diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/m=
ap_cgroup_storage.rst
index cab9543017bf..8e5fe532c07e 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_i=
d`` or
     };
=20
 ``cgroup_inode_id`` is the inode id of the cgroup directory.
-``attach_type`` is the the program's attach type.
+``attach_type`` is the program's attach type.
=20
 Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
 When this key type is used, then all attach types of the particular cgroup=
 and
@@ -155,7 +155,7 @@ However, the BPF program can still only associate with =
one map of each type
 ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
 ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
=20
-In all versions, userspace may use the the attach parameters of cgroup and
+In all versions, userspace may use the attach parameters of cgroup and
 attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BP=
F map
 APIs to read or update the storage for a given attachment. For Linux 5.9
 attach type shared storages, only the first value in the struct, cgroup in=
ode
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-ap=
i/cpu_hotplug.rst
index c6f4ba2fb32d..f75778d37488 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -560,7 +560,7 @@ available:
   * cpuhp_state_remove_instance(state, node)
   * cpuhp_state_remove_instance_nocalls(state, node)
=20
-The arguments are the same as for the the cpuhp_state_add_instance*()
+The arguments are the same as for the cpuhp_state_add_instance*()
 variants above.
=20
 The functions differ in the way how the installed callbacks are treated:
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Docu=
mentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 94d50a949be1..c0e3c3a42bea 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -10,7 +10,7 @@ system, notifying them when a low power state is entered =
or exited.
 Multiple revisions of the SAW hardware are supported using these Device No=
des.
 SAW2 revisions differ in the register offset and configuration data. Also,=
 the
 same revision of the SAW in different SoCs may have different configuration
-data due the the differences in hardware capabilities. Hence the SoC name,=
 the
+data due the differences in hardware capabilities. Hence the SoC name, the
 version of the SAW hardware in that SoC and the distinction between cpu (b=
ig
 or Little) or cache, may be needed to uniquely identify the SAW register
 configuration and initialization data. The compatible string is used to
diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/D=
ocumentation/devicetree/bindings/clock/ti/davinci/pll.txt
index 36998e184821..c9894538315b 100644
--- a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
@@ -15,7 +15,7 @@ Required properties:
 	- for "ti,da850-pll1", shall be "clksrc"
=20
 Optional properties:
-- ti,clkmode-square-wave: Indicates that the the board is supplying a squa=
re
+- ti,clkmode-square-wave: Indicates that the board is supplying a square
 	wave input on the OSCIN pin instead of using a crystal oscillator.
 	This property is only valid when compatible =3D "ti,da850-pll0".
=20
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Docum=
entation/devicetree/bindings/fpga/fpga-region.txt
index 7d3515264838..6694ef29a267 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -330,7 +330,7 @@ succeeded.
=20
 The Device Tree Overlay will contain:
  * "target-path" or "target"
-   The insertion point where the the contents of the overlay will go into =
the
+   The insertion point where the contents of the overlay will go into the
    live tree.  target-path is a full path, while target is a phandle.
  * "ranges"
     The address space mapping from processor to FPGA bus(ses).
diff --git a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt b/Docum=
entation/devicetree/bindings/gpio/gpio-pisosr.txt
index 414a01cdf715..fba3c61f6a5b 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
@@ -14,7 +14,7 @@ Optional properties:
  - ngpios		: Number of used GPIO lines (0..n-1), default is 8.
  - load-gpios		: GPIO pin specifier attached to load enable, this
 			  pin is pulsed before reading from the device to
-			  load input pin values into the the device.
+			  load input pin values into the device.
=20
 For other required and optional properties of SPI slave
 nodes please refer to ../spi/spi-bus.txt.
diff --git a/Documentation/devicetree/bindings/net/qcom-emac.txt b/Document=
ation/devicetree/bindings/net/qcom-emac.txt
index 346e6c7f47b7..e6cb2291471c 100644
--- a/Documentation/devicetree/bindings/net/qcom-emac.txt
+++ b/Documentation/devicetree/bindings/net/qcom-emac.txt
@@ -14,7 +14,7 @@ MAC node:
 - mac-address : The 6-byte MAC address. If present, it is the default
 	MAC address.
 - internal-phy : phandle to the internal PHY node
-- phy-handle : phandle the the external PHY node
+- phy-handle : phandle the external PHY node
=20
 Internal PHY node:
 - compatible : Should be "qcom,fsm9900-emac-sgmii" or "qcom,qdf2432-emac-s=
gmii".
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-p=
cie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-m=
ipi-pcie-analog.yaml
index 4d01f3124e1c..a90fa1baadab 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-ana=
log.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-ana=
log.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinct=
rl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.=
yaml
index c689bea7ce6e..d3a8911728d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible:     Should be one of the following:
                     "aspeed,ast2400-scu", "syscon", "simple-mfd"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinct=
rl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.=
yaml
index 9db904a528ee..5d2c1b1fb7fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -17,7 +17,7 @@ description: |+
   			"aspeed,ast2500-scu", "syscon", "simple-mfd"
   			"aspeed,g5-scu", "syscon", "simple-mfd"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinct=
rl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.=
yaml
index 3666ac5b6518..e92686d2f062 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "aspeed,ast2600-scu", "syscon", "simple-mfd"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.=
yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index f005abac7079..4e52ef33a986 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -17,7 +17,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Docum=
entation/devicetree/bindings/powerpc/fsl/cpus.txt
index d63ab1dec16d..801c66069121 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
@@ -5,7 +5,7 @@ Copyright 2013 Freescale Semiconductor Inc.
 Power Architecture CPUs in Freescale SOCs are represented in device trees =
as
 per the definition in the Devicetree Specification.
=20
-In addition to the the Devicetree Specification definitions, the properties
+In addition to the Devicetree Specification definitions, the properties
 defined below may be present on CPU nodes.
=20
 PROPERTIES
diff --git a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt b=
/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
index 9d619e955576..d6658d3dd15e 100644
--- a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
+++ b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
@@ -39,7 +39,7 @@ otherwise. The length of all the property arrays must be =
the same.
=20
 - ibm,cpu-idle-state-flags:
 	Array of unsigned 32-bit values containing the values of the
-	flags associated with the the aforementioned idle-states. The
+	flags associated with the aforementioned idle-states. The
 	flag bits are as follows:
 		0x00000001 /* Decrementer would stop */
 		0x00000002 /* Needs timebase restore */
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/D=
ocumentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index b677900b3aae..658f96fbc4fe 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -37,7 +37,7 @@ on the Qualcomm Hexagon core.
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: The interrupts needed depends on the the compatible
+	Definition: The interrupts needed depends on the compatible
 		    string:
 	qcom,q6v5-pil:
 	qcom,ipq8074-wcss-pil:
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/D=
ocumentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 2ad17b361db0..bc2fb1a80ed7 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -68,9 +68,9 @@ properties:
        array is defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>.
=20
        0 - (default) Odd channel is latched on the negative edge and even
-       channel is latched on the the positive edge.
+       channel is latched on the positive edge.
        1 - Odd channel is latched on the positive edge and even channel is
-       latched on the the negative edge.
+       latched on the negative edge.
=20
        PDMIN1 - PDMCLK latching edge used for channel 1 and 2 data
        PDMIN2 - PDMCLK latching edge used for channel 3 and 4 data
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.=
yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index 1ab5070c751d..89a2c32c0ab2 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
=20
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
=20
 properties:
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soct=
herm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-socthe=
rm.txt
index db880e7ed713..aea4a2a178b9 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -96,7 +96,7 @@ critical trip point is reported back to the thermal frame=
work to implement
 software shutdown.
=20
 - the "hot" type trip points will be set to SOC_THERM hardware as the thro=
ttle
-temperature. Once the the temperature of this thermal zone is higher
+temperature. Once the temperature of this thermal zone is higher
 than it, it will trigger the HW throttle event.
=20
 Example :
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/=
Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 927de79ab4b5..00dcbdd36144 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -42,7 +42,7 @@ properties:
     description:
       Address ranges of the thermal registers. If more then one range is g=
iven
       the first one must be the common registers followed by each sensor
-      according the the datasheet.
+      according the datasheet.
     minItems: 1
     maxItems: 4
=20
diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/is=
a.rst
index def4a7b690b5..3df1b1696524 100644
--- a/Documentation/driver-api/isa.rst
+++ b/Documentation/driver-api/isa.rst
@@ -100,7 +100,7 @@ I believe platform_data is available for this, but if r=
ather not, moving
 the isa_driver pointer to the private struct isa_dev is ofcourse fine as
 well.
=20
-Then, if the the driver did not provide a .match, it matches. If it did,
+Then, if the driver did not provide a .match, it matches. If it did,
 the driver match() method is called to determine a match.
=20
 If it did **not** match, dev->platform_data is reset to indicate this to
diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentat=
ion/filesystems/caching/backend-api.rst
index d7507becf674..3a199fc50828 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -122,7 +122,7 @@ volumes, calling::
 to tell fscache that a volume has been withdrawn.  This waits for all
 outstanding accesses on the volume to complete before returning.
=20
-When the the cache is completely withdrawn, fscache should be notified by
+When the cache is completely withdrawn, fscache should be notified by
 calling::
=20
 	void fscache_relinquish_cache(struct fscache_cache *cache);
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seql=
ock.rst
index 64405e5da63e..bfda1a5fecad 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is=
 following.
 Sequence counters (``seqcount_t``)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This is the the raw counting mechanism, which does not protect against
+This is the raw counting mechanism, which does not protect against
 multiple writers.  Write side critical sections must thus be serialized
 by an external lock.
=20
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain=
=2Epy
index ca8ac9e59ded..a7d1866e72ff 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -151,7 +151,7 @@ class CObject(Base_CObject):
     def handle_func_like_macro(self, sig, signode):
         u"""Handles signatures of function-like macros.
=20
-        If the objtype is 'function' and the the signature ``sig`` is a
+        If the objtype is 'function' and the signature ``sig`` is a
         function-like macro, the name of the macro is returned. Otherwise
         ``False`` is returned.  """
=20
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..b07c31f6a13e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1636,7 +1636,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
=20
 endchoice
=20
@@ -1794,7 +1794,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
=20
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..5fc323586c7a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
=20
 #ifndef __ASSEMBLY__
=20
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK =3D 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND =3D 8,
diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-p=
cmcia.c
index e2331dfe427d..860b78aed18c 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -30,7 +30,7 @@ static int hx4700_pcmcia_hw_init(struct soc_pcmcia_socket=
 *skt)
 	/*
 	 * IRQ type must be set before soc_pcmcia_hw_init() calls request_irq().
 	 * The asic3 default IRQ type is level trigger low level detect, exactly
-	 * the the signal present on GPIOD4_CF_nCD when a CF card is inserted.
+	 * the signal present on GPIOD4_CF_nCD when a CF card is inserted.
 	 * If the IRQ type is not changed, the asic3 interrupt handler will loop
 	 * repeatedly because it is unable to clear the level trigger interrupt.
 	 */
diff --git a/arch/arm64/crypto/aes-neon.S b/arch/arm64/crypto/aes-neon.S
index e47d3ec2cfb4..9de7fbc797af 100644
--- a/arch/arm64/crypto/aes-neon.S
+++ b/arch/arm64/crypto/aes-neon.S
@@ -66,7 +66,7 @@
 	prepare		crypto_aes_inv_sbox, .LReverse_ShiftRows, \temp
 	.endm
=20
-	/* apply SubBytes transformation using the the preloaded Sbox */
+	/* apply SubBytes transformation using the preloaded Sbox */
 	.macro		sub_bytes, in
 	sub		v9.16b, \in\().16b, v15.16b
 	tbl		\in\().16b, {v16.16b-v19.16b}, \in\().16b
diff --git a/arch/m68k/coldfire/intc-2.c b/arch/m68k/coldfire/intc-2.c
index 995093357c59..376e37855ebd 100644
--- a/arch/m68k/coldfire/intc-2.c
+++ b/arch/m68k/coldfire/intc-2.c
@@ -7,7 +7,7 @@
  * family, the 5270, 5271, 5274, 5275, and the 528x family which have two =
such
  * controllers, and the 547x and 548x families which have only one of them.
  *
- * The external 7 fixed interrupts are part the the Edge Port unit of these
+ * The external 7 fixed interrupts are part the Edge Port unit of these
  * ColdFire parts. They can be configured as level or edge triggered.
  *
  * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index b179f8f6d287..8651fe351276 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
=20
=20
 /* This the initial entry point for a new child thread, with an appropriate
-   stack in place that makes it look the the child is in the middle of an
+   stack in place that makes it look the child is in the middle of an
    syscall.  This function is actually `returned to' from switch_thread
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards=
/pm.c
index 73c77814687a..b17a0d199851 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -17,7 +17,7 @@
  * Generic suspend userspace interface for Alchemy development boards.
  * This code exports a few sysfs nodes under /sys/power/db1x/ which
  * can be used by userspace to en/disable all au1x-provided wakeup
- * sources and configure the timeout after which the the TOYMATCH2 irq
+ * sources and configure the timeout after which the TOYMATCH2 irq
  * is to trigger a wakeup.
  */
=20
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_s=
f.c
index 332a49965130..0fda19b1e21d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event=
 *event, u64 count)
  * combined-sampling data entry consists of a basic- and a diagnostic-samp=
ling
  * data entry.	The sampling function is determined by the flags in the perf
  * event hardware structure.  The function always works with a combined-sa=
mpling
- * data entry but ignores the the diagnostic portion if it is not availabl=
e.
+ * data entry but ignores the diagnostic portion if it is not available.
  *
  * Note that the implementation focuses on basic-sampling data entries and=
, if
  * such an entry is not valid, the entire combined-sampling data entry is
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |=3D MAC_CNT_VLD;
 }
=20
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part=
_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 31b0c1983286..385c61d199cd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm=
_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index 230cf852fa9c..e795390b070f 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -544,7 +544,7 @@ static int apm_suspend_notifier(struct notifier_block *=
nb,
 		wake_up_interruptible(&apm_waitqueue);
=20
 		/*
-		 * Wait for the the suspend_acks_pending variable to drop to
+		 * Wait for the suspend_acks_pending variable to drop to
 		 * zero, meaning everybody acked the suspend event (or the
 		 * process was killed.)
 		 *
diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-c=
ommon-powernv.c
index f418817c0f43..f34c75a862f2 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -75,7 +75,7 @@ static int (*nx842_powernv_exec)(const unsigned char *in,
 /**
  * setup_indirect_dde - Setup an indirect DDE
  *
- * The DDE is setup with the the DDE count, byte count, and address of
+ * The DDE is setup with the DDE count, byte count, and address of
  * first direct DDE in the list.
  */
 static void setup_indirect_dde(struct data_descriptor_entry *dde,
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/h=
ash/hash_core.c
index 265ef3e96fdd..f104e8a43036 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -421,7 +421,7 @@ static int hash_get_device_data(struct hash_ctx *ctx,
  * @keylen:		The lengt of the key.
  *
  * Note! This function DOES NOT write to the NBLW registry, even though
- * specified in the the hw design spec. Either due to incorrect info in the
+ * specified in the hw design spec. Either due to incorrect info in the
  * spec or due to a bug in the hw.
  */
 static void hash_hw_write_key(struct hash_device_data *device_data,
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hs=
dma.c
index 9ebd9231f62f..434b6306a450 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -138,7 +138,7 @@ struct mtk_hsdma_vdesc {
=20
 /**
  * struct mtk_hsdma_cb - This is the struct holding extra info required fo=
r RX
- *			 ring to know what relevant VD the the PD is being
+ *			 ring to know what relevant VD the PD is being
  *			 mapped to.
  * @vd:			 Pointer to the relevant VD.
  * @flag:		 Flag indicating what action should be taken when VD
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d3a32b806499..0e40418ad287 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -247,7 +247,7 @@ static int find_cable_index_by_id(struct extcon_dev *ed=
ev, const unsigned int id
 {
 	int i;
=20
-	/* Find the the index of extcon cable in edev->supported_cable */
+	/* Find the index of extcon cable in edev->supported_cable */
 	for (i =3D 0; i < edev->max_supported; i++) {
 		if (edev->supported_cable[i] =3D=3D id)
 			return i;
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 3163660fa8e2..4623d2919ed0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1337,7 +1337,7 @@ static int qcom_scm_probe(struct platform_device *pde=
v)
=20
 	/*
 	 * If requested enable "download mode", from this point on warmboot
-	 * will cause the the boot stages to enter download mode, unless
+	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
 	if (download_mode)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index d16c8c1f72db..f90149941651 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -46,7 +46,7 @@
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
  * are no longer in use by the associated ring on the GPU and
- * that the the relevant GPU caches have been flushed.
+ * that the relevant GPU caches have been flushed.
  */
=20
 struct amdgpu_fence {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index dc76d2b3ce52..8530befb2051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -54,7 +54,7 @@
  * (uncached system pages).
  * Each VM has an ID associated with it and there is a page table
  * associated with each VMID.  When executing a command buffer,
- * the kernel tells the the ring what VMID to use for that command
+ * the kernel tells the ring what VMID to use for that command
  * buffer.  VMIDs are allocated dynamically as commands are submitted.
  * The userspace drivers maintain their own address space and the kernel
  * sets up their pages tables accordingly when they submit their
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/i=
nclude/atombios.h
index 1f9df4e7509b..15943bc21bc5 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -3255,8 +3255,8 @@ ucMaxNBVoltageHigh:     Voltage regulator dependent P=
WM value. High 8 bits of  t
 ucMinNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits=
 of the value for the min voltage.Set this one to 0x00 if VC without PWM or=
 no VC at all.
=20
=20
-usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value m=
akes the the voltage >=3DMin NB voltage but <=3DInterNBVoltageHigh. Set thi=
s to 0x0000 if VC without PWM or no VC at all.
-usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value m=
akes the the voltage >=3DInterNBVoltageLow but <=3DMax NB voltage.Set this =
to 0x0000 if VC without PWM or no VC at all.
+usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value m=
akes the voltage >=3DMin NB voltage but <=3DInterNBVoltageHigh. Set this to=
 0x0000 if VC without PWM or no VC at all.
+usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value m=
akes the voltage >=3DInterNBVoltageLow but <=3DMax NB voltage.Set this to 0=
x0000 if VC without PWM or no VC at all.
 */
=20
=20
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/disp=
lay/drm_dp_helper.c
index e7c22c2ca90c..c258cbd6857b 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1595,9 +1595,9 @@ static int drm_dp_aux_reply_duration(const struct drm=
_dp_aux_msg *msg)
=20
 /*
  * Calculate the length of the i2c transfer in usec, assuming
- * the i2c bus speed is as specified. Gives the the "worst"
+ * the i2c bus speed is as specified. Gives the "worst"
  * case estimate, ie. successful while as long as possible.
- * Doesn't account the the "MOT" bit, and instead assumes each
+ * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
  * account for additional random variables such as clock stretching.
  */
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 51fcf1298023..8faad23dc1d8 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -83,7 +83,7 @@
  *
  * 1. Directly call VERSION to get the version and to match against the dr=
iver
  *    name returned by that ioctl. Note that SET_VERSION is not called, wh=
ich
- *    means the the unique name for the master node just opening is _not_ =
filled
+ *    means the unique name for the master node just opening is _not_ fill=
ed
  *    out. This despite that with current drm device nodes are always boun=
d to
  *    one device, and can't be runtime assigned like with drm 1.0.
  * 2. Match driver name. If it mismatches, proceed to the next device node.
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/d=
rm/drm_panel_orientation_quirks.c
index d4e0f2e85548..fc1728d46ac2 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -193,7 +193,7 @@ static const struct dmi_system_id orientation_data[] =
=3D {
 		},
 		.driver_data =3D (void *)&lcd800x1280_rightside_up,
 	}, {	/*
-		 * GPD Pocket, note that the the DMI data is less generic then
+		 * GPD Pocket, note that the DMI data is less generic then
 		 * it seems, devices with a board-vendor of "AMI Corporation"
 		 * are quite rare, as are devices which have both board- *and*
 		 * product-id set to "Default String"
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index e3f09f18110c..a3f180653b8b 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -839,7 +839,7 @@ EXPORT_SYMBOL(drm_prime_pages_to_sg);
  * @sgt: sg_table describing the buffer to check
  *
  * This helper calculates the contiguous size in the DMA address space
- * of the the buffer described by the provided sg_table.
+ * of the buffer described by the provided sg_table.
  *
  * This is useful for implementing
  * &drm_gem_object_funcs.gem_prime_import_sg_table.
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_ir=
q.c
index 73cebc6aa650..783a6ca41a61 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -65,7 +65,7 @@
=20
 /*
  * Interrupt statistic for PMU. Increments the counter only if the
- * interrupt originated from the the GPU so interrupts from a device which
+ * interrupt originated from the GPU so interrupts from a device which
  * shares the interrupt line are not accounted.
  */
 static inline void pmu_irq_stats(struct drm_i915_private *i915,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index 8bf00b396ec1..ca6dc8884bc9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1048,7 +1048,7 @@ nvkm_vmm_ctor(const struct nvkm_vmm_func *func, struc=
t nvkm_mmu *mmu,
 	__mutex_init(&vmm->mutex, "&vmm->mutex", key ? key : &_key);
=20
 	/* Locate the smallest page size supported by the backend, it will
-	 * have the the deepest nesting of page tables.
+	 * have the deepest nesting of page tables.
 	 */
 	while (page[1].shift)
 		page++;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/dr=
m/panel/panel-novatek-nt35510.c
index 873cbd38e6d3..4085822f619a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -190,7 +190,7 @@ struct nt35510_config {
 	 * 6 =3D Hsync x 2
 	 * 7 =3D Hsync x 4
 	 * bits 4..6 in the upper nibble controls BTP, the boosting
-	 * amplification for the the step-up circuit:
+	 * amplification for the step-up circuit:
 	 * 0 =3D Disable
 	 * 1 =3D 1.5 x VDDB
 	 * 2 =3D 1.66 x VDDB
@@ -211,7 +211,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls NCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTN, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 =3D Disable
 	 * 1 =3D -1.5 x VDDB
 	 * 2 =3D -2 x VDDB
@@ -231,7 +231,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls HCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTH, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 =3D AVDD + VDDB
 	 * 1 =3D AVDD - AVEE
 	 * 2 =3D AVDD - AVEE + VDDB
@@ -250,7 +250,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls LCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTL, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 =3D AVEE + VCL
 	 * 1 =3D AVEE - AVDD
 	 * 2 =3D AVEE + VCL - AVDD
diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/=
pl111_display.c
index 443e3b932322..2fdd3b968e87 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -248,7 +248,7 @@ static void pl111_display_enable(struct drm_simple_disp=
lay_pipe *pipe,
 		cntl |=3D CNTL_ST_CDWID_24;
=20
 	/*
-	 * Note that the the ARM hardware's format reader takes 'r' from
+	 * Note that the ARM hardware's format reader takes 'r' from
 	 * the low bit, while DRM formats list channels from high bit
 	 * to low bit as you read left to right. The ST Micro version of
 	 * the PL110 (LCDC) however uses the standard DRM format.
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index a2b5cbbbc1b0..f0290fad991d 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -264,7 +264,7 @@
  * output line.
  */
 # define SCALER_DISPSTAT_ESLINE(x)		BIT(10 + ((x) * 8))
-/* Set when the the downstream tries to read from the display FIFO
+/* Set when the downstream tries to read from the display FIFO
  * while it's empty.
  */
 # define SCALER_DISPSTAT_EUFLOW(x)		BIT(9 + ((x) * 8))
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/int=
el-ish-hid/ishtp-hid-client.c
index 4338c9b68a43..e3d70c5460e9 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -328,7 +328,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl,=
 void *recv_buf,
=20
 /**
  * ish_cl_event_cb() - bus driver callback for incoming message/packet
- * @device:	Pointer to the the ishtp client device for which this message
+ * @device:	Pointer to the ishtp client device for which this message
  *		is targeted
  *
  * Remove the packet from the list and process the message by calling
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetom=
eter/hmc5843_core.c
index 92eb2d156ddb..4a63b2da9df0 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Device driver for the the HMC5843 multi-chip module designed
+ * Device driver for the HMC5843 multi-chip module designed
  * for low field magnetic sensing.
  *
  * Copyright (C) 2010 Texas Instruments
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/c=
ore/roce_gid_mgmt.c
index 68197e576433..e958c43dd28f 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -250,7 +250,7 @@ static bool upper_device_filter(struct ib_device *ib_de=
v, u32 port,
=20
 /**
  * is_upper_ndev_bond_master_filter - Check if a given netdevice
- * is bond master device of netdevice of the the RDMA device of port.
+ * is bond master device of netdevice of the RDMA device of port.
  * @ib_dev:		IB device to check
  * @port:		Port to consider for adding default GID
  * @rdma_ndev:		Pointer to rdma netdevice
diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qi=
b.h
index b37b1c6d35c6..26c615772be3 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -321,7 +321,7 @@ struct qib_verbs_txreq {
  * These 7 values (SDR, DDR, and QDR may be ORed for auto-speed
  * negotiation) are used for the 3rd argument to path_f_set_ib_cfg
  * with cmd QIB_IB_CFG_SPD_ENB, by direct calls or via sysfs.  They
- * are also the the possible values for qib_link_speed_enabled and active
+ * are also the possible values for qib_link_speed_enabled and active
  * The values were chosen to match values used within the IB spec.
  */
 #define QIB_IB_SDR 1
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/u=
lp/ipoib/ipoib_ib.c
index 2c3dca41d3bd..ab86165e45de 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1109,7 +1109,7 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib=
_dev_priv *priv)
 	 * if he sets the device address back to be based on GID index 0,
 	 * he no longer wishs to control it.
 	 *
-	 * If the user doesn't control the the device address,
+	 * If the user doesn't control the device address,
 	 * IPOIB_FLAG_DEV_ADDR_SET is set and ib_find_gid failed it means
 	 * the port GUID has changed and GID at index 0 has changed
 	 * so we need to change priv->local_gid and priv->dev->dev_addr
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mo=
use.c
index 23507fce3a2b..18ccbd45004a 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -41,7 +41,7 @@ struct gpio_mouse {
=20
 /*
  * Timer function which is run every scan_ms ms when the device is opened.
- * The dev input variable is set to the the input_dev pointer.
+ * The dev input variable is set to the input_dev pointer.
  */
 static void gpio_mouse_scan(struct input_dev *input)
 {
diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/=
mISDN/hfcsusb.c
index cd5642cef01f..651f2f8f685b 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1557,7 +1557,7 @@ reset_hfcsusb(struct hfcsusb *hw)
 	write_reg(hw, HFCUSB_USB_SIZE, (hw->packet_size / 8) |
 		  ((hw->packet_size / 8) << 4));
=20
-	/* set USB_SIZE_I to match the the wMaxPacketSize for ISO transfers */
+	/* set USB_SIZE_I to match the wMaxPacketSize for ISO transfers */
 	write_reg(hw, HFCUSB_USB_SIZE_I, hw->iso_packet_size);
=20
 	/* enable PCM/GCI master mode */
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..089ef39a71fa 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -66,7 +66,7 @@ config ARMADA_37XX_RWTM_MBOX
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
-	  Mailbox implementation for communication with the the firmware
+	  Mailbox implementation for communication with the firmware
 	  running on the Cortex-M3 rWTM secure processor of the Armada 37xx
 	  SOC. Say Y here if you are building for such a device (for example
 	  the Turris Mox router).
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 80c9f7134e9b..3247c5901fbe 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -1369,7 +1369,7 @@ static int parse_raid_params(struct raid_set *rs, str=
uct dm_arg_set *as,
 			}
 			rs->md.bitmap_info.daemon_sleep =3D value;
 		} else if (!strcasecmp(key, dm_raid_arg_name_by_flag(CTR_FLAG_DATA_OFFSE=
T))) {
-			/* Userspace passes new data_offset after having extended the the data =
image LV */
+			/* Userspace passes new data_offset after having extended the data imag=
e LV */
 			if (test_and_set_bit(__CTR_FLAG_DATA_OFFSET, &rs->ctr_flags)) {
 				rs->ti->error =3D "Only one data_offset argument pair allowed";
 				return -EINVAL;
diff --git a/drivers/media/dvb-frontends/tda1002x.h b/drivers/media/dvb-fro=
ntends/tda1002x.h
index 60a0952c1bca..00491bea9975 100644
--- a/drivers/media/dvb-frontends/tda1002x.h
+++ b/drivers/media/dvb-frontends/tda1002x.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
     TDA10021/TDA10023  - Single Chip Cable Channel Receiver driver module
-			 used on the the Siemens DVB-C cards
+			 used on the Siemens DVB-C cards
=20
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergenc=
e.de>
     Copyright (C) 2004 Markus Schulz <msc@antzsystem.de>
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-fro=
ntends/tda10048.c
index d1d206ebdedd..0b3f6999515e 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -1118,7 +1118,7 @@ struct dvb_frontend *tda10048_attach(const struct tda=
10048_config *config,
 		state->pll_pfactor =3D 0;
 	}
=20
-	/* Establish any defaults the the user didn't pass */
+	/* Establish any defaults the user didn't pass */
 	tda10048_establish_defaults(&state->frontend);
=20
 	/* Set the xtal and freq defaults */
diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 2dc4a0f24ce8..7beca0b70b72 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v11=
1)
=20
 	/*
 	 * Set pixel integration time to the whole frame time.
-	 * This value controls the the shutter delay when running with AE
+	 * This value controls the shutter delay when running with AE
 	 * disabled. If longer than frame time, it affects the output
 	 * frame rate.
 	 */
diff --git a/drivers/media/pci/cx88/cx88-dsp.c b/drivers/media/pci/cx88/cx8=
8-dsp.c
index f1e1fc1cb4bd..e378f3b215c7 100644
--- a/drivers/media/pci/cx88/cx88-dsp.c
+++ b/drivers/media/pci/cx88/cx88-dsp.c
@@ -24,7 +24,7 @@
=20
 /*
  * We calculate the baseband frequencies of the carrier and the pilot tones
- * based on the the sampling rate of the audio rds fifo.
+ * based on the sampling rate of the audio rds fifo.
  */
=20
 #define FREQ_A2_CARRIER         baseband_freq(54687.5, 2689.36, 0.0)
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivt=
v-yuv.c
index e79e8a5a744a..4ba10c34a16a 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -538,7 +538,7 @@ static void ivtv_yuv_handle_vertical(struct ivtv *itv, =
struct yuv_frame_info *f)
 	reg_2964 =3D (reg_2964 << 16) + reg_2964 + (reg_2964 * 46 / 94);
=20
 	/* Okay, we've wasted time working out the correct value,
-	   but if we use it, it fouls the the window alignment.
+	   but if we use it, it fouls the window alignment.
 	   Fudge it to what we want... */
 	reg_2964 =3D 0x00010001 + ((reg_2964 & 0x0000FFFF) - (reg_2964 >> 16));
 	reg_2968 =3D 0x00010001 + ((reg_2968 & 0x0000FFFF) - (reg_2968 >> 16));
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/s=
aa7164/saa7164-core.c
index 7973ae42873a..d5f32e3ff544 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -626,7 +626,7 @@ static irqreturn_t saa7164_irq(int irq, void *dev_id)
 	portf =3D &dev->ports[SAA7164_PORT_VBI2];
=20
 	/* Check that the hardware is accessible. If the status bytes are
-	 * 0xFF then the device is not accessible, the the IRQ belongs
+	 * 0xFF then the device is not accessible, the IRQ belongs
 	 * to another driver.
 	 * 4 x u32 interrupt registers.
 	 */
diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platf=
orm/ti/davinci/vpbe.c
index 5f0aeb744e81..509ecc84624e 100644
--- a/drivers/media/platform/ti/davinci/vpbe.c
+++ b/drivers/media/platform/ti/davinci/vpbe.c
@@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *=
vpbe_dev)
  * vpbe_get_output - Get output
  * @vpbe_dev: vpbe device ptr
  *
- * return current vpbe output to the the index
+ * return current vpbe output to the index
  */
 static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
 {
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platf=
orm/ti/omap3isp/isp.c
index 4c937f3f323e..f99dda7337b9 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1528,7 +1528,7 @@ void omap3isp_print_status(struct isp_device *isp)
  * To solve this problem power management support is split into prepare/co=
mplete
  * and suspend/resume operations. The pipelines are stopped in prepare() a=
nd the
  * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enab=
led in
- * resume(), and the the pipelines are restarted in complete().
+ * resume(), and the pipelines are restarted in complete().
  *
  * TODO: PM dependencies between the ISP and sensors are not modelled expl=
icitly
  * yet.
diff --git a/drivers/media/usb/gspca/finepix.c b/drivers/media/usb/gspca/fi=
nepix.c
index 66c8e5122a0a..bc6133b525e3 100644
--- a/drivers/media/usb/gspca/finepix.c
+++ b/drivers/media/usb/gspca/finepix.c
@@ -129,7 +129,7 @@ static void dostream(struct work_struct *work)
 				 * for, then it's the end of the
 				 * frame. Sometimes the jpeg is not complete,
 				 * but there's nothing we can do. We also end
-				 * here if the the jpeg ends right at the end
+				 * here if the jpeg ends right at the end
 				 * of the frame. */
 				gspca_frame_add(gspca_dev, LAST_PACKET,
 						data, len);
diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm=
6000/tm6000-cards.c
index 98f4a63adc2a..b7842cd6f9af 100644
--- a/drivers/media/usb/tm6000/tm6000-cards.c
+++ b/drivers/media/usb/tm6000/tm6000-cards.c
@@ -1297,7 +1297,7 @@ static int tm6000_usb_probe(struct usb_interface *int=
erface,
 		le16_to_cpu(dev->udev->descriptor.idProduct),
 		interface->altsetting->desc.bInterfaceNumber);
=20
-/* check if the the device has the iso in endpoint at the correct place */
+/* check if the device has the iso in endpoint at the correct place */
 	if (!dev->isoc_in.endp) {
 		printk(KERN_ERR "tm6000: probing error: no IN ISOC endpoint!\n");
 		rc =3D -ENODEV;
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_=
video.c
index 6d3dfa4e0bb2..5aaee916045d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1077,7 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streamin=
g *stream,
 	}
=20
 	/* Synchronize to the input stream by waiting for the FID bit to be
-	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
+	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
 	 * stream->last_fid is initialized to -1, so the first isochronous
 	 * frame will always be in sync.
 	 *
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core=
/v4l2-ioctl.c
index 21470de62d72..129bc032fe58 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1020,7 +1020,7 @@ static void v4l_sanitize_format(struct v4l2_format *f=
mt)
 	/*
 	 * The v4l2_pix_format structure has been extended with fields that were
 	 * not previously required to be set to zero by applications. The priv
-	 * field, when set to a magic value, indicates the the extended fields
+	 * field, when set to a magic value, indicates the extended fields
 	 * are valid. Otherwise they will contain undefined values. To simplify
 	 * the API towards drivers zero the extended fields and set the priv
 	 * field to the magic value when the extended pixel format structure
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptsp=
i.c
index 388675cc1765..4c87a6b986f6 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -101,7 +101,7 @@ static u8	mptspiInternalCtx =3D MPT_MAX_PROTOCOL_DRIVER=
S; /* Used only for interna
  *	@target: per target private data
  *	@sdev: SCSI device
  *
- * 	Update the target negotiation parameters based on the the Inquiry
+ * 	Update the target negotiation parameters based on the Inquiry
  *	data, adapter capabilities, and NVRAM settings.
  **/
 static void
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 56c61c99eb23..27a881da4d6e 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -798,7 +798,7 @@ void db8500_prcmu_get_abb_event_buffer(void __iomem **b=
uf)
  * @opp: The new ARM operating point to which transition is to be made
  * Returns: 0 on success, non-zero on failure
  *
- * This function sets the the operating point of the ARM.
+ * This function sets the operating point of the ARM.
  */
 int db8500_prcmu_set_arm_opp(u8 opp)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 7a6dd91987fd..0562071cdd4a 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1104,7 +1104,7 @@ extern const struct cxl_backend_ops cxl_native_ops;
 extern const struct cxl_backend_ops cxl_guest_ops;
 extern const struct cxl_backend_ops *cxl_ops;
=20
-/* check if the given pci_dev is on the the cxl vphb bus */
+/* check if the given pci_dev is on the cxl vphb bus */
 bool cxl_pci_is_vphb_device(struct pci_dev *dev);
=20
 /* decode AFU error bits in the PSL register PSL_SERR_An */
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/gru=
kservices.c
index 19dbdad8ad8a..fa1f5a632e7f 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -36,7 +36,7 @@
  * kernel/user requirements.
  *
  * Blade percpu resources reserved for kernel use. These resources are
- * reserved whenever the the kernel context for the blade is loaded. Note
+ * reserved whenever the kernel context for the blade is loaded. Note
  * that the kernel context is not guaranteed to be always available. It is
  * loaded on demand & can be stolen by a user if the user demand exceeds t=
he
  * kernel demand. The kernel can always reload the kernel context but
diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index ba9ae0e2df0f..fff522d347e3 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -1598,7 +1598,7 @@ xpc_send_payload_uv(struct xpc_channel *ch, u32 flags=
, void *payload,
 		 * by xpc_notify_senders_of_disconnect_uv(), and to also get an
 		 * error returned here will confuse them. Additionally, since
 		 * in this case the channel is being disconnected we don't need
-		 * to put the the msg_slot back on the free list.
+		 * to put the msg_slot back on the free list.
 		 */
 		if (cmpxchg(&msg_slot->func, func, NULL) !=3D func) {
 			ret =3D xpSuccess;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 581614196a84..7f00d7d7e35e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *hos=
t,
 		 * is just about to roll over.
 		 *
 		 * We do this whole thing under spinlock and only if the
-		 * command hasn't already completed (indicating the the irq
+		 * command hasn't already completed (indicating the irq
 		 * already ran so we don't want the timeout).
 		 */
 		spin_lock_irqsave(&host->irq_lock, irqflags);
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c0350e9c03f3..93fe6e5a5f9f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platfo=
rm_device *pdev,
 	 *       in reading a garbage value and using the wrong presets.
 	 *
 	 *       Since HS400 and HS200 presets must be identical, we could
-	 *       instead use the the SDR104 preset register.
+	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
 	 *    firmware that that has valid presets (i.e., SDR12 <=3D 12 MHz).
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/=
raw/gpmi-nand/gpmi-nand.c
index 889e40329956..0893320d250b 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1359,7 +1359,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_dat=
a *this)
 /*
  * Handles block mark swapping.
  * It can be called in swapping the block mark, or swapping it back,
- * because the the operations are the same.
+ * because the operations are the same.
  */
 static void block_mark_swapping(struct gpmi_nand_data *this,
 				void *payload, void *auxiliary)
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 078112e23dfd..d9039e7f6703 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -281,7 +281,7 @@ struct ubi_eba_leb_desc {
=20
 /**
  * struct ubi_volume - UBI volume description data structure.
- * @dev: device object to make use of the the Linux device model
+ * @dev: device object to make use of the Linux device model
  * @cdev: character device object to create character device
  * @ubi: reference to the UBI device description object
  * @vol_id: volume ID
@@ -439,7 +439,7 @@ struct ubi_debug_info {
=20
 /**
  * struct ubi_device - UBI device description structure
- * @dev: UBI device object to use the the Linux device model
+ * @dev: UBI device object to use the Linux device model
  * @cdev: character device object to create character device
  * @ubi_num: UBI device number
  * @ubi_name: UBI device name
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..330f9ffec3a7 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -429,7 +429,7 @@ static int prot_queue_del(struct ubi_device *ubi, int p=
num)
 /**
  * sync_erase - synchronously erase a physical eraseblock.
  * @ubi: UBI device description object
- * @e: the the physical eraseblock to erase
+ * @e: the physical eraseblock to erase
  * @torture: if the physical eraseblock has to be tortured
  *
  * This function returns zero in case of success and a negative error code=
 in
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/age=
re/et131x.c
index fbf4588994ac..d19d1579c415 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -1106,7 +1106,7 @@ static void et1310_config_rxmac_regs(struct et131x_ad=
apter *adapter)
 	writel(0, &rxmac->mif_ctrl);
 	writel(0, &rxmac->space_avail);
=20
-	/* Initialize the the mif_ctrl register
+	/* Initialize the mif_ctrl register
 	 * bit 3:  Receive code error. One or more nibbles were signaled as
 	 *	   errors  during the reception of the packet.  Clear this
 	 *	   bit in Gigabit, set it in 100Mbit.  This was derived
diff --git a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_struct.h =
b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_struct.h
index b6119dcc3bb9..c2fda80fe1cc 100644
--- a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_struct.h
+++ b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_struct.h
@@ -158,7 +158,7 @@ struct aq_mss_egress_class_record {
 	 *  1: compare the SNAP header.
 	 *  If this bit is set to 1, the extracted filed will assume the
 	 *  SNAP header exist as encapsulated in 802.3 (RFC 1042). I.E. the
-	 *  next 5 bytes after the the LLC header is SNAP header.
+	 *  next 5 bytes after the LLC header is SNAP header.
 	 */
 	u32 snap_mask;
 	/*! 0: don't care and no LLC header exist.
@@ -422,7 +422,7 @@ struct aq_mss_ingress_preclass_record {
 	 *  1: compare the SNAP header.
 	 *  If this bit is set to 1, the extracted filed will assume the
 	 *  SNAP header exist as encapsulated in 802.3 (RFC 1042). I.E. the
-	 *  next 5 bytes after the the LLC header is SNAP header.
+	 *  next 5 bytes after the LLC header is SNAP header.
 	 */
 	u32 snap_mask;
 	/*! Mask is per-byte.
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/=
net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 7de3800437c9..c2822e635f89 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2859,7 +2859,7 @@ static const struct net_device_ops cxgb4vf_netdev_ops=
	=3D {
  *				address stored on the adapter
  *	@adapter: The adapter
  *
- *	Find the the port mask for the VF based on the index of mac
+ *	Find the port mask for the VF based on the index of mac
  *	address stored in the adapter. If no mac address is stored on
  *	the adapter for the VF, use the port mask received from the
  *	firmware.
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethe=
rnet/emulex/benet/be_main.c
index cd4e243da5fa..41acd18a3fd2 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3178,7 +3178,7 @@ static irqreturn_t be_intx(int irq, void *dev)
 	}
 	be_eq_notify(adapter, eqo->q.id, false, true, num_evts, 0);
=20
-	/* Return IRQ_HANDLED only for the the first spurious intr
+	/* Return IRQ_HANDLED only for the first spurious intr
 	 * after a valid intr to stop the kernel from branding
 	 * this irq as a bad one!
 	 */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/eth=
ernet/intel/fm10k/fm10k_mbx.c
index 30ca9ee1900b..c499b62b49b1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -809,7 +809,7 @@ static s32 fm10k_mbx_read(struct fm10k_hw *hw, struct f=
m10k_mbx_info *mbx)
  *  @hw: pointer to hardware structure
  *  @mbx: pointer to mailbox
  *
- *  This function copies the message from the the message array to mbmem
+ *  This function copies the message from the message array to mbmem
  **/
 static void fm10k_mbx_write(struct fm10k_hw *hw, struct fm10k_mbx_info *mb=
x)
 {
diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/eth=
ernet/intel/igb/e1000_82575.c
index cbe92fd23a70..8d6e44ee1895 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2207,7 +2207,7 @@ s32 igb_write_phy_reg_82580(struct e1000_hw *hw, u32 =
offset, u16 data)
  *  igb_reset_mdicnfg_82580 - Reset MDICNFG destination and com_mdio bits
  *  @hw: pointer to the HW structure
  *
- *  This resets the the MDICNFG.Destination and MDICNFG.Com_MDIO bits base=
d on
+ *  This resets the MDICNFG.Destination and MDICNFG.Com_MDIO bits based on
  *  the values found in the EEPROM.  This addresses an issue in which these
  *  bits are not restored from EEPROM after reset.
  **/
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_x550.c
index e4b50c7781ff..35c2b9b8bd19 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1737,7 +1737,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw,=
 ixgbe_link_speed *speed)
  * @speed: link speed
  * @autoneg_wait_to_complete: unused
  *
- * Configure the the integrated PHY for native SFP support.
+ * Configure the integrated PHY for native SFP support.
  */
 static s32
 ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
@@ -1786,7 +1786,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe=
_link_speed speed,
  * @speed: link speed
  * @autoneg_wait_to_complete: unused
  *
- * Configure the the integrated PHY for SFP support.
+ * Configure the integrated PHY for SFP support.
  */
 static s32
 ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/ne=
terion/s2io.c
index 6dd451adc331..b73c7fe63500 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -2156,7 +2156,7 @@ static int verify_xena_quiescence(struct s2io_nic *sp)
=20
 	/*
 	 * In PCI 33 mode, the P_PLL is not used, and therefore,
-	 * the the P_PLL_LOCK bit in the adapter_status register will
+	 * the P_PLL_LOCK bit in the adapter_status register will
 	 * not be asserted.
 	 */
 	if (!(val64 & ADAPTER_STATUS_P_PLL_LOCK) &&
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/eth=
ernet/netronome/nfp/bpf/jit.c
index e31f8fbbc696..df2ab5cbd49b 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -4233,7 +4233,7 @@ static void nfp_bpf_opt_ldst_gather(struct nfp_prog *=
nfp_prog)
 			}
=20
 			/* If the chain is ended by an load/store pair then this
-			 * could serve as the new head of the the next chain.
+			 * could serve as the new head of the next chain.
 			 */
 			if (curr_pair_is_memcpy(meta1, meta2)) {
 				head_ld_meta =3D meta1;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers=
/net/ethernet/netronome/nfp/flower/lag_conf.c
index ede90e086b28..fb7ea5e17bda 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -234,7 +234,7 @@ nfp_fl_lag_config_group(struct nfp_fl_lag *lag, struct =
nfp_fl_lag_group *group,
 	}
=20
 	/* To signal the end of a batch, both the switch and last flags are set
-	 * and the the reserved SYNC group ID is used.
+	 * and the reserved SYNC group ID is used.
 	 */
 	if (*batch =3D=3D NFP_FL_LAG_BATCH_FINISHED) {
 		flags |=3D NFP_FL_LAG_SWITCH | NFP_FL_LAG_LAST;
diff --git a/drivers/net/ipa/gsi_private.h b/drivers/net/ipa/gsi_private.h
index ea333a244cf5..d7065e23c92e 100644
--- a/drivers/net/ipa/gsi_private.h
+++ b/drivers/net/ipa/gsi_private.h
@@ -108,7 +108,7 @@ void *gsi_ring_virt(struct gsi_ring *ring, u32 index);
  * gsi_channel_tx_queued() - Report the number of bytes queued to hardware
  * @channel:	Channel whose bytes have been queued
  *
- * This arranges for the the number of transactions and bytes for
+ * This arranges for the number of transactions and bytes for
  * transfer that have been queued to hardware to be reported.  It
  * passes this information up the network stack so it can be used to
  * throttle transmissions.
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 55f8fe7d2668..5c6874d25548 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -351,7 +351,7 @@ struct gsi_trans *gsi_channel_trans_alloc(struct gsi *g=
si, u32 channel_id,
 	if (!gsi_trans_tre_reserve(trans_info, tre_count))
 		return NULL;
=20
-	/* Allocate and initialize non-zero fields in the the transaction */
+	/* Allocate and initialize non-zero fields in the transaction */
 	trans =3D gsi_trans_pool_alloc(&trans_info->pool, 1);
 	trans->gsi =3D gsi;
 	trans->channel_id =3D channel_id;
@@ -685,7 +685,7 @@ int gsi_trans_read_byte(struct gsi *gsi, u32 channel_id=
, dma_addr_t addr)
 	if (!gsi_trans_tre_reserve(trans_info, 1))
 		return -EBUSY;
=20
-	/* Now fill the the reserved TRE and tell the hardware */
+	/* Now fill the reserved TRE and tell the hardware */
=20
 	dest_tre =3D gsi_ring_virt(ring, ring->index);
 	gsi_trans_tre_fill(dest_tre, addr, 1, true, false, IPA_CMD_NONE);
diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
index 3233d145fd87..495e85abe50b 100644
--- a/drivers/net/ipa/ipa_qmi_msg.h
+++ b/drivers/net/ipa/ipa_qmi_msg.h
@@ -214,7 +214,7 @@ struct ipa_init_modem_driver_req {
=20
 /* The response to a IPA_QMI_INIT_DRIVER request begins with a standard
  * QMI response, but contains other information as well.  Currently we
- * simply wait for the the INIT_DRIVER transaction to complete and
+ * simply wait for the INIT_DRIVER transaction to complete and
  * ignore any other data that might be returned.
  */
 struct ipa_init_modem_driver_rsp {
diff --git a/drivers/net/wireless/ath/ath6kl/hif.h b/drivers/net/wireless/a=
th/ath6kl/hif.h
index f9d3f3a5edfe..ba16b98c872d 100644
--- a/drivers/net/wireless/ath/ath6kl/hif.h
+++ b/drivers/net/wireless/ath/ath6kl/hif.h
@@ -92,7 +92,7 @@ struct bus_request {
  *     emode - This indicates the whether the command is to be executed in=
 a
  *             blocking or non-blocking fashion (HIF_SYNCHRONOUS/
  *             HIF_ASYNCHRONOUS). The read/write data paths in HTC have be=
en
- *             implemented using the asynchronous mode allowing the the bus
+ *             implemented using the asynchronous mode allowing the bus
  *             driver to indicate the completion of operation through the
  *             registered callback routine. The requirement primarily comes
  *             from the contexts these operations get called from (a drive=
r's
diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/=
ath/ath6kl/sdio.c
index 6b51a2dceadc..8a43c48ec1cf 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -1185,7 +1185,7 @@ static int ath6kl_sdio_bmi_read(struct ath6kl *ar, u8=
 *buf, u32 len)
 	 *        Wait for first 4 bytes to be in FIFO
 	 *        If CONSERVATIVE_BMI_READ is enabled, also wait for
 	 *        a BMI command credit, which indicates that the ENTIRE
-	 *        response is available in the the FIFO
+	 *        response is available in the FIFO
 	 *
 	 *  CASE 3: length > 128
 	 *        Wait for the first 4 bytes to be in FIFO
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_phy.c b/drivers/net/wire=
less/ath/ath9k/ar9002_phy.c
index fcfed8e59d29..ebdb97999335 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_phy.c
@@ -498,7 +498,7 @@ static void ar9002_hw_spectral_scan_config(struct ath_h=
w *ah,
 	else
 		REG_CLR_BIT(ah, AR_PHY_SPECTRAL_SCAN, repeat_bit);
=20
-	/* on AR92xx, the highest bit of count will make the the chip send
+	/* on AR92xx, the highest bit of count will make the chip send
 	 * spectral samples endlessly. Check if this really was intended,
 	 * and fix otherwise.
 	 */
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wire=
less/ath/ath9k/ar9003_phy.c
index dc0e5ea25673..090ff0600c81 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -1744,7 +1744,7 @@ static void ar9003_hw_spectral_scan_config(struct ath=
_hw *ah,
 	REG_SET_BIT(ah, AR_PHY_RADAR_0, AR_PHY_RADAR_0_FFT_ENA);
 	REG_SET_BIT(ah, AR_PHY_SPECTRAL_SCAN, AR_PHY_SPECTRAL_SCAN_ENABLE);
=20
-	/* on AR93xx and newer, count =3D 0 will make the the chip send
+	/* on AR93xx and newer, count =3D 0 will make the chip send
 	 * spectral samples endlessly. Check if this really was intended,
 	 * and fix otherwise.
 	 */
diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/=
ath/wcn36xx/hal.h
index 46a49f0a51b3..a1afe1f85f0e 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1961,7 +1961,7 @@ struct wcn36xx_hal_config_bss_params {
=20
 	/* HAL should update the existing BSS entry, if this flag is set.
 	 * UMAC will set this flag in case of reassoc, where we want to
-	 * resue the the old BSSID and still return success 0 =3D Add, 1 =3D
+	 * resue the old BSSID and still return success 0 =3D Add, 1 =3D
 	 * Update */
 	u8 action;
=20
@@ -2098,7 +2098,7 @@ struct wcn36xx_hal_config_bss_params_v1 {
=20
 	/* HAL should update the existing BSS entry, if this flag is set.
 	 * UMAC will set this flag in case of reassoc, where we want to
-	 * resue the the old BSSID and still return success 0 =3D Add, 1 =3D
+	 * resue the old BSSID and still return success 0 =3D Add, 1 =3D
 	 * Update */
 	u8 action;
=20
@@ -4142,7 +4142,7 @@ struct wcn36xx_hal_dump_cmd_rsp_msg {
 	/* Length of the responce message */
 	u32 rsp_length;
=20
-	/* FIXME: Currently considering the the responce will be less than
+	/* FIXME: Currently considering the responce will be less than
 	 * 100bytes */
 	u8 rsp_buffer[DUMPCMD_RSP_BUFFER];
 } __packed;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 8ddfc3d06687..11b33e78127c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -3800,7 +3800,7 @@ static void brcms_b_set_shortslot(struct brcms_hardwa=
re *wlc_hw, bool shortslot)
 }
=20
 /*
- * Suspend the the MAC and update the slot timing
+ * Suspend the MAC and update the slot timing
  * for standard 11b/g (20us slots) or shortslot 11g (9us slots).
  */
 static void brcms_c_switch_shortslot(struct brcms_c_info *wlc, bool shorts=
lot)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/w=
ireless/intel/iwlwifi/fw/api/tx.h
index ecc6706f66ed..194de9545989 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -200,7 +200,7 @@ enum iwl_tx_offload_assist_bz {
  *	cleared. Combination of RATE_MCS_*
  * @sta_id: index of destination station in FW station table
  * @sec_ctl: security control, TX_CMD_SEC_*
- * @initial_rate_index: index into the the rate table for initial TX attem=
pt.
+ * @initial_rate_index: index into the rate table for initial TX attempt.
  *	Applied if TX_CMD_FLG_STA_RATE_MSK is set, normally 0 for data frames.
  * @reserved2: reserved
  * @key: security key
@@ -858,7 +858,7 @@ struct iwl_extended_beacon_notif {
=20
 /**
  * enum iwl_dump_control - dump (flush) control flags
- * @DUMP_TX_FIFO_FLUSH: Dump MSDUs until the the FIFO is empty
+ * @DUMP_TX_FIFO_FLUSH: Dump MSDUs until the FIFO is empty
  *	and the TFD queues are empty.
  */
 enum iwl_dump_control {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index a3cefbc43e80..abf8585bf3bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -29,7 +29,7 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *ch=
andef)
=20
 /*
  * Maps the driver specific control channel position (relative to the cent=
er
- * freq) definitions to the the fw values
+ * freq) definitions to the fw values
  */
 u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef)
 {
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wire=
less/marvell/mwifiex/sdio.c
index 76004bda0c02..9b91580c4f92 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1549,7 +1549,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_ad=
apter *adapter,
 /*
  * This function decode sdio aggreation pkt.
  *
- * Based on the the data block size and pkt_len,
+ * Based on the data block size and pkt_len,
  * skb data will be decoded to few packets.
  */
 static void mwifiex_deaggr_sdio_pkt(struct mwifiex_adapter *adapter,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 2dda4c5d7427..674461fa7fb3 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -1721,8 +1721,8 @@ enum qlink_chan_stat {
  * @time_on: amount of time radio operated on that channel.
  * @time_tx: amount of time radio spent transmitting on the channel.
  * @time_rx: amount of time radio spent receiving on the channel.
- * @cca_busy: amount of time the the primary channel was busy.
- * @cca_busy_ext: amount of time the the secondary channel was busy.
+ * @cca_busy: amount of time the primary channel was busy.
+ * @cca_busy_ext: amount of time the secondary channel was busy.
  * @time_scan: amount of radio spent scanning on the channel.
  * @chan_noise: channel noise.
  */
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless=
/rsi/rsi_91x_sdio.c
index 9f16128e4ffa..d09998796ac0 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -796,7 +796,7 @@ static int rsi_sdio_host_intf_write_pkt(struct rsi_hw *=
adapter,
  * rsi_sdio_host_intf_read_pkt() - This function reads the packet
  *				   from the device.
  * @adapter: Pointer to the adapter data structure.
- * @pkt: Pointer to the packet data to be read from the the device.
+ * @pkt: Pointer to the packet data to be read from the device.
  * @length: Length of the data to be read from the device.
  *
  * Return: 0 on success, -1 on failure.
diff --git a/drivers/net/wireless/ti/wl1251/acx.h b/drivers/net/wireless/ti=
/wl1251/acx.h
index 1da6ba95d3d4..1da6ab664e41 100644
--- a/drivers/net/wireless/ti/wl1251/acx.h
+++ b/drivers/net/wireless/ti/wl1251/acx.h
@@ -1229,7 +1229,7 @@ struct wl1251_acx_arp_filter {
 	u8 address[16];	/* The IP address used to filter ARP packets.
 			   ARP packets that do not match this address are
 			   dropped. When the IP Version is 4, the last 12
-			   bytes of the the address are ignored. */
+			   bytes of the address are ignored. */
 } __attribute__((packed));
=20
 struct wl1251_acx_ac_cfg {
diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/am=
logic/phy-meson-axg-mipi-dphy.c
index fdbd64c03e12..32d1ff09befb 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
@@ -136,7 +136,7 @@
 /* TWAKEUP. */
 #define MIPI_DSI_WAKEUP_TIM				0x20
=20
-/* when in RxULPS check state, after the the logic enable the analog,
+/* when in RxULPS check state, after the logic enable the analog,
  *	how long we should wait to check the lP state .
  */
 #define MIPI_DSI_LPOK_TIM				0x24
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadco=
m/phy-brcm-usb-init.c
index dd0f66288fbd..dddcbd3cd5f3 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -861,7 +861,7 @@ static void usb_init_common(struct brcm_usb_init_params=
 *params)
 	brcmusb_usb2_eye_fix(ctrl);
=20
 	/*
-	 * Make sure the the second and third memory controller
+	 * Make sure the second and third memory controller
 	 * interfaces are enabled if they exist.
 	 */
 	if (USB_CTRL_MASK_FAMILY(params, SETUP, SCB1_EN))
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d91a010e65f5..f1234e719e58 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1748,7 +1748,7 @@ static int at91_gpio_of_irq_setup(struct platform_dev=
ice *pdev,
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
=20
 	/*
-	 * Let the generic code handle this edge IRQ, the the chained
+	 * Let the generic code handle this edge IRQ, the chained
 	 * handler will perform the actual work of handling the parent
 	 * interrupt.
 	 */
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/ch=
rome/wilco_ec/event.c
index 814518509739..32e400590be5 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -343,7 +343,7 @@ static __poll_t event_poll(struct file *filp, poll_tabl=
e *wait)
  *
  * Removes the first event from the queue, places it in the passed buffer.
  *
- * If there are no events in the the queue, then one of two things happens,
+ * If there are no events in the queue, then one of two things happens,
  * depending on if the file was opened in nonblocking mode: If in nonblock=
ing
  * mode, then return -EAGAIN to say there's no data. If in blocking mode, =
then
  * block until an event is available.
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 4239591e1522..5369abaceb5c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -442,7 +442,7 @@ static int add_prop_uevent(struct device *dev, struct k=
obj_uevent_env *env,
 	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;
-		 * send the uevent with at least the the PRESENT=3D0 property
+		 * send the uevent with at least the PRESENT=3D0 property
 		 */
 		return 0;
 	}
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply=
/tps65217_charger.c
index ba33d1617e0b..a4bc9f2a10bc 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_charge=
r *charger)
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
 	 * The device can be configured to support a 100k NTC (B =3D 3960) by
-	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
+	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
 	 * is not recommended to do so. In sleep mode, the charger continues
 	 * charging the battery, but all register values are reset to default
 	 * values. Therefore, the charger would get the wrong temperature
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index cb15983383f5..8d551e15b91a 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -150,7 +150,7 @@ static int rs5c_get_regs(struct rs5c372 *rs5c)
 	 * least 80219 chips; this works around that bug.
 	 *
 	 * The third method on the other hand doesn't work for the SMBus-only
-	 * configurations, so we use the the first method there, stripping off
+	 * configurations, so we use the first method there, stripping off
 	 * the extra register in the process.
 	 */
 	if (rs5c->smbus) {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index 9e54fe76a9b2..35d4b398c197 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3565,7 +3565,7 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q=
 *queue, int index,
 			if (!atomic_read(&queue->set_pci_flags_count)) {
 				/*
 				 * there's no outstanding PCI any more, so we
-				 * have to request a PCI to be sure the the PCI
+				 * have to request a PCI to be sure the PCI
 				 * will wake at some time in the future then we
 				 * can flush packed buffers that might still be
 				 * hanging around, which can happen if no
diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
index da55133da8fe..15c25fefe91a 100644
--- a/drivers/s390/scsi/zfcp_diag.h
+++ b/drivers/s390/scsi/zfcp_diag.h
@@ -2,7 +2,7 @@
 /*
  * zfcp device driver
  *
- * Definitions for handling diagnostics in the the zfcp device driver.
+ * Definitions for handling diagnostics in the zfcp device driver.
  *
  * Copyright IBM Corp. 2018, 2020
  */
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 81462f4ddb90..4d4cb47b3846 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1050,7 +1050,7 @@ static void get_container_serial_callback(void *conte=
xt, struct fib * fibptr)
 				vpdpage83data.type1.productid));
=20
 			/* Convert to ascii based serial number.
-			 * The LSB is the the end.
+			 * The LSB is the end.
 			 */
 			for (i =3D 0; i < 8; i++) {
 				u8 temp =3D
diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rp=
ort.c
index c21aa37b8adb..dd78bea3e111 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -1971,7 +1971,7 @@ bfa_fcs_rport_gidpn_response(void *fcsarg, struct bfa=
_fcxp_s *fcxp, void *cbarg,
 			/*
 			 * Device's PID has changed. We need to cleanup
 			 * and re-login. If there is another device with
-			 * the the newly discovered pid, send an scn notice
+			 * the newly discovered pid, send an scn notice
 			 * so that its new pid can be discovered.
 			 */
 			list_for_each(qe, &rport->port->rport_q) {
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 39e16eab47aa..28e8b9f1e1a4 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -205,7 +205,7 @@ static int fcoe_sysfs_fcf_add(struct fcoe_fcf *new)
 		 * that doesn't have a priv (fcf was deleted). However,
 		 * libfcoe will always delete FCFs before trying to add
 		 * them. This is ensured because both recv_adv and
-		 * age_fcfs are protected by the the fcoe_ctlr's mutex.
+		 * age_fcfs are protected by the fcoe_ctlr's mutex.
 		 * This means that we should never get a FCF with a
 		 * non-NULL priv pointer.
 		 */
diff --git a/drivers/scsi/isci/host.h b/drivers/scsi/isci/host.h
index 6bc3f022630a..64e4759f25d7 100644
--- a/drivers/scsi/isci/host.h
+++ b/drivers/scsi/isci/host.h
@@ -244,7 +244,7 @@ enum sci_controller_states {
 	SCIC_INITIALIZED,
=20
 	/**
-	 * This state indicates the the controller is in the process of becoming
+	 * This state indicates the controller is in the process of becoming
 	 * ready (i.e. starting).  In this state no new IO operations are permitt=
ed.
 	 * This state is entered from the INITIALIZED state.
 	 */
diff --git a/drivers/scsi/isci/remote_device.h b/drivers/scsi/isci/remote_d=
evice.h
index 3ad681c4c20a..db097483ff04 100644
--- a/drivers/scsi/isci/remote_device.h
+++ b/drivers/scsi/isci/remote_device.h
@@ -198,7 +198,7 @@ enum sci_status sci_remote_device_reset_complete(
  * permitted.  This state is entered from the INITIAL state.  This state
  * is entered from the STOPPING state.
  *
- * @SCI_DEV_STARTING: This state indicates the the remote device is in
+ * @SCI_DEV_STARTING: This state indicates the remote device is in
  * the process of becoming ready (i.e. starting).  In this state no new
  * IO operations are permitted.  This state is entered from the STOPPED
  * state.
diff --git a/drivers/scsi/isci/remote_node_context.h b/drivers/scsi/isci/re=
mote_node_context.h
index c7ee81d01125..f22950b12b8b 100644
--- a/drivers/scsi/isci/remote_node_context.h
+++ b/drivers/scsi/isci/remote_node_context.h
@@ -154,7 +154,7 @@ enum sci_remote_node_context_destination_state {
 /**
  * struct sci_remote_node_context - This structure contains the data
  *    associated with the remote node context object.  The remote node con=
text
- *    (RNC) object models the the remote device information necessary to m=
anage
+ *    (RNC) object models the remote device information necessary to manage
  *    the silicon RNC.
  */
 struct sci_remote_node_context {
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index c514b20293b2..9a311a58c37c 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -67,7 +67,7 @@
 /**
 * isci_task_refuse() - complete the request to the upper layer driver in
 *     the case where an I/O needs to be completed back in the submit path.
-* @ihost: host on which the the request was queued
+* @ihost: host on which the request was queued
 * @task: request to complete
 * @response: response code for the completed task.
 * @status: status code for the completed task.
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 3caaa7c4af48..7c1d58250672 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2460,7 +2460,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
=20
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2551,7 +2551,7 @@ lpfc_##attr##_show(struct device *dev, struct device_=
attribute *attr, \
  * takes a default argument, a minimum and maximum argument.
  *
  * lpfc_##attr##_init: Initializes an attribute.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Validates the min and max values then sets the adapter config field
@@ -2584,7 +2584,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
  * into a function with the name lpfc_hba_queue_depth_set
  *
  * lpfc_##attr##_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2713,7 +2713,7 @@ lpfc_##attr##_show(struct device *dev, struct device_=
attribute *attr, \
  * lpfc_##attr##_init: validates the min and max values then sets the
  * adapter config field accordingly, or uses the default if out of range
  * and prints an error message.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Returns:
@@ -2745,7 +2745,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val=
) \
  * lpfc_##attr##_set: validates the min and max values then sets the
  * adapter config field if in the valid range. prints error message
  * and does not set the parameter if invalid.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val:	integer attribute value.
  *
  * Returns:
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 3fababb7c181..70c0ef8d4f41 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -8666,7 +8666,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpf=
c_iocbq *cmdiocb,
  * @rrq: Pointer to the rrq struct.
  *
  * Build a ELS RRQ command and send it to the target. If the issue_iocb is
- * Successful the the completion handler will clear the RRQ.
+ * Successful the completion handler will clear the RRQ.
  *
  * Return codes
  *   0 - Successfully sent rrq els iocb.
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbad=
isc.c
index fb36f26170e4..c1b9c61da280 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -2453,7 +2453,7 @@ static void lpfc_sli4_fcf_pri_list_del(struct lpfc_hb=
a *phba,
  * @phba: pointer to lpfc hba data structure.
  * @fcf_index: the index of the fcf record to update
  * This routine acquires the hbalock and then set the LPFC_FCF_FLOGI_FAILED
- * flag so the the round robin slection for the particular priority level
+ * flag so the round robin slection for the particular priority level
  * will try a different fcf record that does not have this bit set.
  * If the fcf record is re-read for any reason this flag is cleared brfore
  * adding it to the priority list.
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 750dd1e9f2cc..27b48f93ca42 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5499,7 +5499,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	bf_set(lpfc_mbx_read_top_link_spd, la,
 	       (bf_get(lpfc_acqe_link_speed, acqe_link)));
=20
-	/* Fake the the following irrelvant fields */
+	/* Fake the following irrelvant fields */
 	bf_set(lpfc_mbx_read_top_topology, la, LPFC_TOPOLOGY_PT_PT);
 	bf_set(lpfc_mbx_read_top_alpa_granted, la, 0);
 	bf_set(lpfc_mbx_read_top_il, la, 0);
@@ -12501,7 +12501,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int =
vectors)
 			/* Mark CPU as IRQ not assigned by the kernel */
 			cpup->flag |=3D LPFC_CPU_MAP_UNASSIGN;
=20
-			/* If so, find a new_cpup thats on the the SAME
+			/* If so, find a new_cpup thats on the SAME
 			 * phys_id as cpup. start_cpu will start where we
 			 * left off so all unassigned entries don't get assgined
 			 * the IRQ of the first entry.
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 9858b1743769..cebb3d7598e5 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2509,7 +2509,7 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct =
lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also i=
s used
  * to indicate where received unsolicited frames from this FCF will be sen=
t. By
  * default this routine will set up the FCF to forward all unsolicited fra=
mes
- * the the RQ ID passed in the @phba. This can be overridden by the caller=
 for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
@@ -2577,7 +2577,7 @@ lpfc_reg_fcfi(struct lpfc_hba *phba, struct lpfcMboxq=
 *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also i=
s used
  * to indicate where received unsolicited frames from this FCF will be sen=
t. By
  * default this routine will set up the FCF to forward all unsolicited fra=
mes
- * the the RQ ID passed in the @phba. This can be overridden by the caller=
 for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index c0ee0b39075d..6cdd32832c96 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1471,7 +1471,7 @@ lpfc_nvmet_cleanup_io_context(struct lpfc_hba *phba)
 	if (!infop)
 		return;
=20
-	/* Cycle the the entire CPU context list for every MRQ */
+	/* Cycle the entire CPU context list for every MRQ */
 	for (i =3D 0; i < phba->cfg_nvmet_mrq; i++) {
 		for_each_present_cpu(j) {
 			infop =3D lpfc_get_ctx_list(phba, j, i);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 80ac3a051c19..9ee7e8a236b7 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20538,7 +20538,7 @@ lpfc_log_fw_write_cmpl(struct lpfc_hba *phba, u32 s=
hdr_status,
  * the offset after the write object mailbox has completed. @size is used =
to
  * determine the end of the object and whether the eof bit should be set.
  *
- * Return 0 is successful and offset will contain the the new offset to use
+ * Return 0 is successful and offset will contain the new offset to use
  * for the next write.
  * Return negative value for error cases.
  **/
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_=
hwi.c
index 991eb01bb1e0..1c7aae12fd2a 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3134,7 +3134,7 @@ int pm8001_mpi_local_phy_ctl(struct pm8001_hba_info *=
pm8001_ha, void *piomb)
  *
  * when HBA driver received the identify done event or initiate FIS receiv=
ed
  * event(for SATA), it will invoke this function to notify the sas layer t=
hat
- * the sas toplogy has formed, please discover the the whole sas domain,
+ * the sas toplogy has formed, please discover the whole sas domain,
  * while receive a broadcast(change) primitive just tell the sas
  * layer to discover the changed domain rather than the whole domain.
  */
diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core=
_alua.c
index b56ef8af66e7..58df0145e8d0 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -385,7 +385,7 @@ target_emulate_set_target_port_groups(struct se_cmd *cm=
d)
=20
 			/*
 			 * Extract the RELATIVE TARGET PORT IDENTIFIER to identify
-			 * the Target Port in question for the the incoming
+			 * the Target Port in question for the incoming
 			 * SET_TARGET_PORT_GROUPS op.
 			 */
 			rtpi =3D get_unaligned_be16(ptr + 2);
diff --git a/drivers/thunderbolt/ctl.h b/drivers/thunderbolt/ctl.h
index e8c64898dfce..7c7d80f96c0c 100644
--- a/drivers/thunderbolt/ctl.h
+++ b/drivers/thunderbolt/ctl.h
@@ -35,7 +35,7 @@ struct tb_cfg_result {
 			    * If err =3D 1 then this is the port that send the
 			    * error.
 			    * If err =3D 0 and if this was a cfg_read/write then
-			    * this is the the upstream port of the responding
+			    * this is the upstream port of the responding
 			    * switch.
 			    * Otherwise the field is set to zero.
 			    */
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3f107a06817d..d8d20aa638c9 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -999,7 +999,7 @@ static void dwc2_hc_set_even_odd_frame(struct dwc2_hsot=
g *hsotg,
=20
 		/*
 		 * Try to figure out if we're an even or odd frame. If we set
-		 * even and the current frame number is even the the transfer
+		 * even and the current frame number is even the transfer
 		 * will happen immediately.  Similar if both are odd. If one is
 		 * even and the other is odd then the transfer will happen when
 		 * the frame number ticks.
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 502a3ac5e35b..352e3ac2b377 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -312,7 +312,7 @@ static const int hrsl_to_error[] =3D {
=20
 /*
  * See https://www.beyondlogic.org/usbnutshell/usb4.shtml#Control for a
- * reasonable overview of how control transfers use the the IN/OUT
+ * reasonable overview of how control transfers use the IN/OUT
  * tokens.
  */
 #define MAX3421_HXFR_BULK_IN(ep)	(0x00 | (ep))	/* bulk or interrupt */
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 46d0b9ad6f74..ad81e9a508b1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1964,7 +1964,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
=20
 	/*
 	 * Check to see if xhci-hub.c is waiting on RExit to U0 transition (or
-	 * RExit to a disconnect state).  If so, let the the driver know it's
+	 * RExit to a disconnect state).  If so, let the driver know it's
 	 * out of the RExit state.
 	 */
 	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m=
8.c
index 6924fa95f6bd..da8913683104 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -256,7 +256,7 @@ static int analyze_baud_rate(struct usb_serial_port *po=
rt, speed_t new_rate)
 		/*
 		 * Mike Isely <isely@pobox.com> 2-Feb-2008: The
 		 * Cypress app note that describes this mechanism
-		 * states the the low-speed part can't handle more
+		 * states the low-speed part can't handle more
 		 * than 800 bytes/sec, in which case 4800 baud is the
 		 * safest speed for a part like that.
 		 */
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..23ccbba716c7 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -826,7 +826,7 @@ static int mos77xx_calc_num_ports(struct usb_serial *se=
rial,
 		/*
 		 * The 7715 uses the first bulk in/out endpoint pair for the
 		 * parallel port, and the second for the serial port. We swap
-		 * the endpoint descriptors here so that the the first and
+		 * the endpoint descriptors here so that the first and
 		 * only registered port structure uses the serial-port
 		 * endpoints.
 		 */
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, in=
t error)
 }
=20
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode bei=
ng
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..2452d6fd7062 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
  * @filename: This function kmalloc's the memory for the filename
  * @filename_size: This function sets this to the amount of memory
  *                 kmalloc'd for the filename
- * @packet_size: This function sets this to the the number of octets
+ * @packet_size: This function sets this to the number of octets
  *               in the packet parsed
  * @mount_crypt_stat: The mount-wide cryptographic context
  * @data: The memory location containing the start of the tag 70
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879..39bde6976b03 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -243,7 +243,7 @@ static ssize_t kernfs_fop_read_iter(struct kiocb *iocb,=
 struct iov_iter *iter)
  * There is no easy way for us to know if userspace is only doing a partial
  * write, so we don't support them. We expect the entire buffer to come on
  * the first write.  Hint: if you're writing a value, first read the file,
- * modify only the the value you're changing, then write entire buffer
+ * modify only the value you're changing, then write entire buffer
  * back.
  */
 static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *=
iter)
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index d3f2886fdc08..210c0a05b933 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -84,7 +84,7 @@ xfs_prealloc_blocks(
 /*
  * The number of blocks per AG that we withhold from xfs_mod_fdblocks to
  * guarantee that we can refill the AGFL prior to allocating space in a ne=
arly
- * full AG.  Although the the space described by the free space btrees, the
+ * full AG.  Although the space described by the free space btrees, the
  * blocks used by the freesp btrees themselves, and the blocks owned by the
  * AGFL are counted in the ondisk fdblocks, it's a mistake to let the ondi=
sk
  * free space in the AG drop so low that the free space btrees cannot refi=
ll an
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 5a6c3c3c4de2..8fb90da89787 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -549,7 +549,7 @@ xfs_dquot_check_type(
 	 * at the same time.  The non-user quota file can be switched between
 	 * group and project quota uses depending on the mount options, which
 	 * means that we can encounter the other type when we try to load quota
-	 * defaults.  Quotacheck will soon reset the the entire quota file
+	 * defaults.  Quotacheck will soon reset the entire quota file
 	 * (including the root dquot) anyway, but don't log scary corruption
 	 * reports to dmesg.
 	 */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..a3fab3718a12 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2931,7 +2931,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
=20
 /*
- * Userspace may rely on the the inode number being non-zero. For example,=
 glibc
+ * Userspace may rely on the inode number being non-zero. For example, gli=
bc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..4e2ae90554cd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -863,7 +863,7 @@ static inline unsigned read_seqretry(const seqlock_t *s=
l, unsigned start)
 }
=20
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fc=
ntl.h
index f13d37b60775..974629ba0c5a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flo=
ck)
  * locks, and they are only released automatically when the last reference=
 to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
index bc81419f400c..aa8c46544af8 100644
--- a/lib/mpi/mpiutil.c
+++ b/lib/mpi/mpiutil.c
@@ -272,7 +272,7 @@ MPI mpi_set_ui(MPI w, unsigned long u)
 	if (!w)
 		w =3D mpi_alloc(1);
 	/* FIXME: If U is 0 we have no need to resize and thus possible
-	 * allocating the the limbs.
+	 * allocating the limbs.
 	 */
 	RESIZE_IF_NEEDED(w, 1);
 	w->d[0] =3D u;
diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_com=
press.c
index a4e916008b3a..73fff4c60149 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -4441,7 +4441,7 @@ static size_t ZSTD_validateSequence(U32 offCode, U32 =
matchLength,
                                     size_t posInSrc, U32 windowLog, size_t=
 dictSize, U32 minMatch) {
     size_t offsetBound;
     U32 windowSize =3D 1 << windowLog;
-    /* posInSrc represents the amount of data the the decoder would decode=
 up to this point.
+    /* posInSrc represents the amount of data the decoder would decode up =
to this point.
      * As long as the amount of data decoded is less than or equal to wind=
ow size, offsets may be
      * larger than the total length of output decoded in order to referenc=
e the dict, even larger than
      * window size. After output surpasses windowSize, we're limited to wi=
ndowSize offsets again.
diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/=
badty.cocci
index ed3e0b8f3b1a..e3530cade156 100644
--- a/scripts/coccinelle/misc/badty.cocci
+++ b/scripts/coccinelle/misc/badty.cocci
@@ -4,7 +4,7 @@
 //# This makes an effort to find cases where the argument to sizeof is wro=
ng
 //# in memory allocation functions by checking the type of the allocated m=
emory
 //# when it is a double pointer and ensuring the sizeof argument takes a p=
ointer
-//# to the the memory being allocated. There are false positives in cases =
the
+//# to the memory being allocated. There are false positives in cases the
 //# sizeof argument is not used in constructing the return value. The resu=
lt
 //# may need some reformatting.
 //
diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_funct=
race.py
index 7011fbe003ff..438516bdfb3c 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -8,7 +8,7 @@ This script parses a trace provided by the function tracer =
in
 kernel/trace/trace_functions.c
 The resulted trace is processed into a tree to produce a more human
 view of the call stack by drawing textual but hierarchical tree of
-calls. Only the functions's names and the the call time are provided.
+calls. Only the functions's names and the call time are provided.
=20
 Usage:
 	Be sure that you have CONFIG_FUNCTION_TRACER
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/as=
m-generic/fcntl.h
index 0197042b7dfb..826afd9192d8 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -140,7 +140,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flo=
ck)
  * locks, and they are only released automatically when the last reference=
 to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentat=
ion/perf-diff.txt
index be65bd55ab2a..b77957ac288b 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -285,7 +285,7 @@ If specified the 'Weighted diff' column is displayed wi=
th value 'd' computed as:
=20
   - period being the hist entry period value
=20
-  - WEIGHT-A/WEIGHT-B being user supplied weights in the the '-c' option
+  - WEIGHT-A/WEIGHT-B being user supplied weights in the '-c' option
     behind ':' separator like '-c wdiff:1,2'.
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index aa460d0c4851..59ab88de1b37 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -1923,7 +1923,7 @@
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
+        "PublicDescription": "Counts cycles when the receive side (Rx) of =
the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode =
where we disable 60% of the UPI lanes, decreasing our bandwidth in order to=
 save power.",
         "Unit": "UPI LL"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 03a4c7f26698..3278c7d1654d 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -257,7 +257,7 @@
         "Counter": "0,1",
         "EventCode": "0xCA",
         "EventName": "NO_ALLOC_CYCLES.NOT_DELIVERED",
-        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the the front-end bandwidth.",
+        "PublicDescription": "The NO_ALLOC_CYCLES.NOT_DELIVERED event is u=
sed to measure front-end inefficiencies, i.e. when front-end of the machine=
 is not delivering micro-ops to the back-end and the back-end is not stalle=
d. This event can be used to identify if the machine is truly front-end bou=
nd.  When this event occurs, it is an indication that the front-end of the =
machine is operating at less than its theoretical peak performance.  Backgr=
ound: We can think of the processor pipeline as being divided into 2 broade=
r parts: Front-end and Back-end. Front-end is responsible for fetching the =
instruction, decoding into micro-ops (uops) in machine understandable forma=
t and putting them into a micro-op queue to be consumed by back end. The ba=
ck-end then takes these micro-ops, allocates the required resources.  When =
all resources are ready, micro-ops are executed. If the back-end is not rea=
dy to accept micro-ops from the front-end, then we do not want to count the=
se as front-end bottlenecks.  However, whenever we have bottlenecks in the =
back-end, we will have allocation unit stalls and eventually forcing the fr=
ont-end to wait until the back-end is ready to receive more UOPS. This even=
t counts the cycles only when back-end is requesting more uops and front-en=
d is not able to provide them. Some examples of conditions that cause front=
-end efficiencies are: Icache misses, ITLB misses, and decoder restrictions=
 that limit the front-end bandwidth.",
         "SampleAfterValue": "200003",
         "UMask": "0x50"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index aa0f67613c4a..0c96e6924d62 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -1852,7 +1852,7 @@
         "EventCode": "0x25",
         "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
+        "PublicDescription": "Counts cycles when the receive side (Rx) of =
the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode =
where we disable 60% of the UPI lanes, decreasing our bandwidth in order to=
 save power.",
         "Unit": "UPI LL"
     },
     {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..16db965ac995 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1451,7 +1451,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * tidq->packet->instr_count represents the number of
 		 * instructions in the current etm packet.
 		 *
-		 * Period instructions (Pi) contains the the number of
+		 * Period instructions (Pi) contains the number of
 		 * instructions executed after the sample point(n) from the
 		 * previous etm packet.  This will always be less than
 		 * etm->instructions_sample_period.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbos=
tat/turbostat.c
index ede31a4287a0..ad4c9b79c051 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5398,7 +5398,7 @@ void print_dev_latency(void)
 }
=20
 /*
- * Linux-perf manages the the HW instructions-retired counter
+ * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
  */
 void linux_perf_init(void)
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_sign=
al_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_si=
gnal_restart.c
index f8c43ce8fe66..c6b8f32990c8 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_rest=
art.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_rest=
art.c
@@ -184,7 +184,7 @@ int main(int argc, char *argv[])
 		/*
 		 * If res is non-zero, we either requeued the waiter or hit an
 		 * error, break out and handle it. If it is zero, then the
-		 * signal may have hit before the the waiter was blocked on f1.
+		 * signal may have hit before the waiter was blocked on f1.
 		 * Try again.
 		 */
 		if (res > 0) {
diff --git a/tools/testing/selftests/net/forwarding/vxlan_asymmetric.sh b/t=
ools/testing/selftests/net/forwarding/vxlan_asymmetric.sh
index 0727e2012b68..43469c7de118 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_asymmetric.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_asymmetric.sh
@@ -525,7 +525,7 @@ arp_suppression()
=20
 	log_test "neigh_suppress: on / neigh exists: yes"
=20
-	# Delete the neighbour from the the SVI. A single ARP request should be
+	# Delete the neighbour from the SVI. A single ARP request should be
 	# received by the remote VTEP
 	RET=3D0
=20
diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index 296f69c00c57..da20088285bd 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -27,7 +27,7 @@
=20
 /**************************************************************************
  * PID (Proportional-Integral-Derivative) controller is commonly used in
- * linear control system, consider the the process.
+ * linear control system, consider the process.
  * G(s) =3D U(s)/E(s)
  * kp =3D proportional gain
  * ki =3D integral gain
--=20
2.34.1

