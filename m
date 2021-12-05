Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942A4468DB2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhLEWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhLEWWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:22:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA22C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 14:19:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so35324821edu.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MFO3QfDUhQ829yz4q+jQ0BJUhbvBTHmbhJR4F4U+i1k=;
        b=Ua2JR2R+BTDz/OQvhv8xDfONKtqU0uzqM+CYEJtjXIXHl31ba1Gpv8c2fNwACF26Kn
         1O5e2Juy4VvvYG2lKtbaCfi8nGxJVdVEvxd/BC8ePZC4QGqdlqgmzS9S5L6xsfFywWxf
         gVnUQv0OJBgNK4WFG56IeOm8AiHhd1GaFiu0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MFO3QfDUhQ829yz4q+jQ0BJUhbvBTHmbhJR4F4U+i1k=;
        b=bTtFUb8QaXf9D3d0QUehBwJBtNEkIB8qvsbfyf7orCzwGCSrUd1INkoy/UnMUnXZQ2
         sExOfGDCjImvouU/b7Tg8kcQ9NIBs3MGhSFYvq4CCFRUttB33hBq6KcvWy+B1svoqsJZ
         tEtOlQWH5PdYcL5JWQBlgTzioL0hK4vYRO5WxLjYuy+EVJ8iUSzR3sEQZZP1mtDX5Ycw
         btNMTJWwd3bcExI5JmpGMHrinPkCojAcvWbG5DdxXJFu3fxQDoMwcAlFLV0PBNGLK/tS
         85nuGlBtV7mV9HVLncB0lXvNa0m2ZPPcEFDPQQANE17Qh9lWkTm8FSRJOTjt0sDhzjh4
         Rvrw==
X-Gm-Message-State: AOAM531lER/dCtRe0USX/NUBNc/naQq9eT8kW8ePTcxUOdGNWks6LyrR
        Kd/HCPZrjDy6I/qBbB2vr6dDbfqK8TAt7yi2
X-Google-Smtp-Source: ABdhPJwfpZ6NTiWFoZz7Yx2ip9MYLTG84P1CSux3aWQBe359Bmz3rqotaRqQxgcYHfD7U3nWaE05sw==
X-Received: by 2002:a05:6402:3cd:: with SMTP id t13mr9667732edw.97.1638742756040;
        Sun, 05 Dec 2021 14:19:16 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b11sm6802563ede.62.2021.12.05.14.19.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 14:19:15 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso6319324wmr.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 14:19:15 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr34326099wmq.8.1638742754534;
 Sun, 05 Dec 2021 14:19:14 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Dec 2021 14:18:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguTgfhqftuf6FnW-KZ7zhQGDNktr_POKUkJ6SuMeQuWQ@mail.gmail.com>
Message-ID: <CAHk-=wguTgfhqftuf6FnW-KZ7zhQGDNktr_POKUkJ6SuMeQuWQ@mail.gmail.com>
Subject: Linux 5.16-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly small rc4 this week. Three areas stand out in the diff: some
kvm fixes (and tests), network driver fixes, and the tegra SoC sound
fixes.

The rest is fairly spread out: drm fixes, some filesystem stuff,
various arch updates, and some smattering of random driver fixes.

Nothing looks all that scary, although I certainly hope the kvm side
will calm down.

                  Linus

---

Aaro Koskinen (1):
      i2c: cbus-gpio: set atomic transfer callback

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel ADL

Akhil P Oommen (2):
      drm/msm: Fix null ptr access msm_ioctl_gem_submit()
      drm/msm/a6xx: Fix uinitialized use of gpu_scid

Al Cooper (1):
      serial: 8250_bcm7271: UART errors after resuming from S2

Alain Volmat (4):
      i2c: stm32f7: flush TX FIFO upon transfer errors
      i2c: stm32f7: recover the bus on access timeout
      i2c: stm32f7: stop dma transfer in case of NACK
      i2c: stm32f7: use proper DMAENGINE API for termination

Alexander Stein (1):
      Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

Amir Tzin (1):
      net/mlx5: Fix use after free in mlx5_health_wait_pci_up

Andreas Gruenbacher (4):
      gfs2: Fix remote demote of weak glock holders
      gfs2: gfs2_inode_lookup cleanup
      gfs2: gfs2_inode_lookup rework
      gfs2: gfs2_create_inode rework

Andrew Halaney (1):
      preempt/dynamic: Fix setup_preempt_mode() return value

Anup Patel (1):
      RISC-V: KVM: Fix incorrect KVM_MAX_VCPUS value

Arnaud Pouliquen (1):
      MAINTAINERS: Add rpmsg tty driver maintainer

Arnd Bergmann (3):
      iwlwifi: pcie: fix constant-conversion warning
      drm: msm: fix building without CONFIG_COMMON_CLK
      siphash: use _unaligned version by default

Aya Levin (1):
      net/mlx5: Fix access to a non-supported register

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Wait in SNK_DEBOUNCED until disconnect

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Ben Ben-Ishay (1):
      net/mlx5e: SHAMPO, Fix constant expression result

Ben Gardon (1):
      KVM: x86/mmu: Fix TLB flush range when handling disconnected pt

Benjamin Poirier (2):
      net: mpls: Fix notifications when deleting a device
      net: mpls: Remove rcu protection from nh_dev

Catalin Marinas (1):
      KVM: arm64: Avoid setting the upper 32 bits of TCR_EL2 and CPTR_EL2 t=
o 1

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Christophe JAILLET (2):
      iwlwifi: Fix memory leaks in error handling path
      net: marvell: mvpp2: Fix the computation of shared CPUs

Corey Minyard (2):
      ipmi: fix IPMI_SMI_MSG_TYPE_IPMB_DIRECT response length checking
      ipmi:ipmb: Fix unknown command response

Dan Carpenter (1):
      KVM: VMX: Set failure code in prepare_vmcs02()

Daniel Lezcano (1):
      powercap/drivers/dtpm: Disable DTPM at boot time

David Howells (1):
      netfs: Adjust docs after foliation

Deren Wu (1):
      mt76: fix timestamp check in tx_status

Dmitry Bogdanov (2):
      atlantic: Increase delay for fw transactions
      atlantic: Fix statistics logic for production hardware

Dmytro Linkin (2):
      net/mlx5: E-switch, Respect BW share of the new group
      net/mlx5: E-Switch, Check group pointer before reading bw_share value

Dongliang Mu (1):
      dpaa2-eth: destroy workqueue at the end of remove function

Douglas Anderson (3):
      drm/msm/a6xx: Allocate enough space for GMU registers
      drm/msm: Fix mmap to include VM_IO and VM_DONTDUMP
      drm/msm/dp: Avoid unpowered AUX xfers that caused crashes

Dust Li (1):
      net/smc: fix wrong list_del in smc_lgr_cleanup_early

Eiichi Tsukata (2):
      rxrpc: Fix rxrpc_peer leak in rxrpc_look_up_bundle()
      rxrpc: Fix rxrpc_local leak in rxrpc_lookup_peer()

Eric Dumazet (3):
      net: annotate data-races on txq->xmit_lock_owner
      net: avoid uninit-value from tcp_conn_request
      ipv4: convert fib_num_tclassid_users to atomic_t

Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

Erik Ekman (1):
      net/mlx4_en: Update reported link modes for 1/10G

Feng Tang (2):
      x86/tsc: Add a timer to make sure TSC_adjust is always checked
      x86/tsc: Disable clocksource watchdog for TSC on qualified platorms

Finn Thain (1):
      pata_falcon: Avoid type warnings from sparse

Flora Cui (2):
      drm/amdgpu: cancel the correct hrtimer on exit
      drm/amdgpu: check atomic flag to differeniate with legacy path

Florian Fainelli (1):
      net: dsa: b53: Add SPI ID table

Frank Li (1):
      usb: cdns3: gadget: fix new urb never complete if ep cancel
previous requests

Frederic Weisbecker (2):
      timers/nohz: Last resort update jiffies on nohz_full IRQ entry
      sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

Gal Pressman (1):
      net/mlx5: Fix too early queueing of log timestamp work

Guangming (1):
      dma-buf: system_heap: Use 'for_each_sgtable_sg' in pages free flow

Guchun Chen (1):
      drm/amdgpu: fix the missed handling for SDMA2 and SDMA3

Gurchetan Singh (2):
      drm/virtgpu api: define a dummy fence signaled event
      drm/virtio: use drm_poll(..) instead of virtio_gpu_poll(..)

Gustavo A. R. Silva (1):
      wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()

Hans de Goede (1):
      ASoC: soc-acpi: Set mach->id field on comp_ids matches

Harshit Mogalapalli (1):
      net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Heiko Carstens (1):
      s390: update defconfigs

Helge Deller (5):
      parisc: Fix KBUILD_IMAGE for self-extracting kernel
      parisc: Enable sata sil, audit and usb support on 64-bit defconfig
      parisc/agp: Annotate parisc agp init functions with __init
      parisc: Fix "make install" on newer debian releases
      parisc: Mark cr16 CPU clocksource unstable on all SMP machines

Hou Wenlong (2):
      KVM: x86/mmu: Skip tlb flush if it has been done in zap_gfn_range()
      KVM: x86/mmu: Pass parameter flush as false in
kvm_tdp_mmu_zap_collapsible_sptes()

Ilia Sergachev (1):
      serial: liteuart: Fix NULL pointer dereference in ->remove()

Ilie Halip (1):
      s390/test_unwind: use raw opcode instead of invalid instruction

Ioanna Alifieraki (1):
      ipmi: Move remove_work to dedicated workqueue

Jakub Kicinski (1):
      ipmi: fix oob access due to uninit smi_msg type

James Smart (1):
      scsi: lpfc: Fix non-recovery of remote ports following an unsolicited=
 LOGO

Jane Jian (1):
      drm/amdgpu/sriov/vcn: add new vcn ip revision check case for
SIENNA_CICHLID

Jason A. Donenfeld (7):
      wireguard: allowedips: add missing __rcu annotation to satisfy sparse
      wireguard: selftests: increase default dmesg log size
      wireguard: selftests: actually test for routing loops
      wireguard: device: reset peer src endpoint when netns exits
      wireguard: receive: use ring buffer for incoming handshakes
      wireguard: receive: drop handshakes if queue lock is contended
      MAINTAINERS: co-maintain random.c

Jay Dolan (2):
      serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
      serial: 8250_pci: rewrite pericom_do_set_divisor()

Jens Axboe (1):
      io-wq: don't retry task_work creation failure on fatal conditions

Jeremy Kerr (1):
      mctp: test: fix skb free in test device tx

Jiapeng Chong (1):
      gro: Fix inconsistent indenting

Jimmy Kizito (1):
      drm/amd/display: Add work around for tunneled MST.

Joerg Roedel (1):
      x86/64/mm: Map all kernel memory into trampoline_pgd

Johan Hovold (4):
      serial: core: fix transmit-buffer reset and memleak
      serial: liteuart: fix use-after-free and memleak on unbind
      serial: liteuart: fix minor-number leak on probe errors
      serial: liteuart: relax compile-test dependencies

Jos=C3=A9 Roberto de Souza (1):
      Revert "drm/i915: Implement Wa_1508744258"

Juergen Gross (1):
      x86/kvm: remove unused ack_notifier callbacks

Kai Vehmanen (2):
      ALSA: hda: Add Intel DG2 PCI ID and HDMI codec vid
      ALSA: hda/hdmi: fix HDA codec entry table order for ADL-P

Karsten Graul (1):
      MAINTAINERS: s390/net: add Alexandra and Wenjia as maintainer

Kuan-Ying Lee (1):
      arm64: update PAC description for kernel

Lai Jiangshan (5):
      KVM: X86: Fix when shadow_root_level=3D5 && guest root_level<4
      KVM: X86: Use vcpu->arch.walk_mmu for kvm_mmu_invlpg()
      x86/entry: Add a fence for kernel entry SWAPGS in paranoid_entry()
      x86/entry: Use the correct fence macro after swapgs in kernel CR3
      x86/xen: Add xenpv_restore_regs_and_return_to_usermode()

Li Zhijian (2):
      wireguard: selftests: rename DEBUG_PI_LIST to DEBUG_PLIST
      selftests: net: Correct case name

Lijo Lazar (1):
      drm/amdgpu: Don't halt RLC on GFX suspend

Like Xu (1):
      KVM: x86/pmu: Fix reserved bits for AMD PerfEvtSeln register

Linus Torvalds (2):
      fget: check that the fd still exists after getting a ref to it
      Linux 5.16-rc4

Lorenzo Bianconi (3):
      mt76: mt7915: fix NULL pointer dereference in mt7915_get_phy_mode
      mt76: fix possible pktid leak
      mt76: fix key pointer overwrite in
mt7921s_write_txwi/mt7663_usb_sdio_write_txwi

Lucas Tanure (1):
      ASoC: cs35l41: Set the max SPI speed for the whole device

Luiz Angelo Daros de Luca (1):
      net: dsa: realtek-smi: fix indirect reg access for ports>3

Lukas Wunner (1):
      serial: 8250: Fix RTS modem control while in rs485 mode

Lyude Paul (2):
      drm/i915: Add support for panels with VESA backlights with PWM
enable/disable
      drm/i915/dp: Perform 30ms delay after source OUI write

Maciej Fijalkowski (1):
      ice: xsk: clear status_error0 for each allocated desc

Maciej S. Szmigiero (1):
      KVM: selftests: page_table_test: fix calculation of guest_test_phys_m=
em

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Maor Dickman (1):
      net/mlx5: E-Switch, Use indirect table only if all destinations suppo=
rt it

Maor Gottlieb (1):
      net/mlx5: Lag, Fix recreation of VF LAG

Marc Zyngier (2):
      KVM: arm64: Save PSTATE early on exit
      KVM: arm64: Move pkvm's special 32bit handling into a generic
infrastructure

Marco Elver (1):
      x86/fpu/signal: Initialize sw_bytes in save_xstate_epilog()

Marek Beh=C3=BAn (6):
      net: dsa: mv88e6xxx: Fix application of erratum 4.8 for 88E6393X
      net: dsa: mv88e6xxx: Drop unnecessary check in
mv88e6393x_serdes_erratum_4_6()
      net: dsa: mv88e6xxx: Save power by disabling SerDes trasmitter
and receiver
      net: dsa: mv88e6xxx: Add fix for erratum 5.2 of 88E6393X family
      net: dsa: mv88e6xxx: Fix inband AN for 2500base-x on 88E6393X family
      net: dsa: mv88e6xxx: Link in pcs_get_state() if AN is bypassed

Mark Bloch (1):
      net/mlx5: E-Switch, fix single FDB creation on BlueField

Mark Rutland (2):
      arm64: kexec: use __pa_symbol(empty_zero_page)
      arm64: ftrace: add missing BTIs

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Mathias Nyman (1):
      xhci: Fix commad ring abort, write all 64 bits to CRCR register.

Matt Johnston (1):
      mctp: Don't let RTM_DELROUTE delete local routes

Matthew Wilcox (Oracle) (1):
      tools: Fix math.h breakage

Maxime Ripard (6):
      drm/vc4: kms: Wait for the commit before increasing our clock rate
      drm/vc4: kms: Fix return code check
      drm/vc4: kms: Add missing drm_crtc_commit_put
      drm/vc4: kms: Clear the HVS FIFO commit pointer once done
      drm/vc4: kms: Don't duplicate pending commit
      drm/vc4: kms: Fix previous HVS commit wait

Michael Sterritt (1):
      x86/sev: Fix SEV-ES INS/OUTS instructions for word, dword, and qword

Mordechay Goodstein (1):
      iwlwifi: mvm: retry init flow if failed

Moshe Shemesh (1):
      net/mlx5: Move MODIFY_RQT command to ignore list in internal error st=
ate

Mustapha Ghaddar (1):
      drm/amd/display: Fix for the no Audio bug with Tiled Displays

Nicholas Kazlauskas (1):
      drm/amd/display: Allow DSC on supported MST branch devices

Nicolas Frattaroli (1):
      ASoC: rk817: Add module alias for rk817-codec

Nikita Danilov (2):
      atlatnic: enable Nbase-t speeds with base-t
      atlantic: Add missing DIDs and fix 115c.

Niklas Schnelle (1):
      s390/pci: move pseudo-MMIO to prevent MIO overlap

Ole Ernst (2):
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub

Ondrej Jirman (1):
      i2c: rk3x: Handle a spurious start completion interrupt flag

Paolo Abeni (1):
      tcp: fix page frag corruption on page fault

Paolo Bonzini (22):
      KVM: VMX: do not use uninitialized gfn_to_hva_cache
      KVM: downgrade two BUG_ONs to WARN_ON_ONCE
      KVM: x86: ignore APICv if LAPIC is not enabled
      selftests: fix check for circular KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      selftests: sev_migrate_tests: free all VMs
      KVM: SEV: expose KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM capability
      KVM: MMU: shadow nested paging does not have PKU
      KVM: VMX: prepare sync_pir_to_irr for running with APICv disabled
      KVM: x86: check PIR even for vCPUs with disabled APICv
      KVM: x86: Use a stable condition around all VT-d PI paths
      KVM: SEV: do not use list_replace_init on an empty list
      KVM: SEV: cleanup locking for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      KVM: SEV: initialize regions_list of a mirror VM
      KVM: SEV: move mirror status to destination of
KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      selftests: sev_migrate_tests: add tests for
KVM_CAP_VM_COPY_ENC_CONTEXT_FROM
      KVM: SEV: Do COPY_ENC_CONTEXT_FROM with both VMs locked
      KVM: SEV: Prohibit migration of a VM that has mirrors
      KVM: SEV: do not take kvm->lock when destroying
      KVM: SEV: accept signals in sev_lock_two_vms
      KVM: VMX: clear vmx_x86_ops.sync_pir_to_irr if APICv is disabled
      KVM: fix avic_set_running for preemptable kernels
      KVM: ensure APICv is considered inactive if there is no APIC

Patrik John (1):
      serial: tegra: Change lower tolerance baud rate limit for
tegra20 and tegra30

Paulo Alcantara (1):
      cifs: fix missed refcounting of ipc tcon

Perry Yuan (1):
      drm/amd/display: add connector type check for CRC source set

Peter Zijlstra (1):
      objtool: Fix pv_ops noinstr validation

Philip Chen (1):
      drm/msm/dsi: set default num_data_lanes

Philip Yang (3):
      drm/amdkfd: set "r =3D 0" explicitly before goto
      drm/amdkfd: fix double free mem structure
      drm/amdkfd: process_info lock not needed for svm

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Pierre-Louis Bossart (2):
      ASoC: Intel: soc-acpi: add entry for ESSX8336 on CML
      ALSA: intel-dsp-config: add quirk for CML devices based on ES8336 cod=
ec

Ping-Ke Shih (1):
      rtw89: update partition size of firmware header on skb->data

Qais Yousef (1):
      sched/uclamp: Fix rq->uclamp_max not set on first enqueue

Raed Salem (2):
      net/mlx5e: IPsec: Fix Software parser inner l3 type setting in
case of encapsulation
      net/mlx5e: Fix missing IPsec statistics on uplink representor

Rafael J. Wysocki (1):
      powercap: DTPM: Drop unused local variable from init_dtpm()

Randy Dunlap (3):
      wireguard: main: rename 'mod_init' & 'mod_exit' functions to be
module-specific
      vfio: remove all kernel-doc notation
      natsemi: xtensa: fix section mismatch warnings

Ranjani Sridharan (1):
      ASoC: SOF: hda: reset DAI widget before reconfiguring it

Rob Clark (8):
      drm/msm/devfreq: Fix OPP refcnt leak
      drm/msm: Fix wait_fence submitqueue leak
      drm/msm: Restore error return on invalid fence
      drm/msm: Make a6xx_gpu_set_freq() static
      drm/msm: Demote debug message
      drm/msm/gpu: Fix idle_work time
      drm/msm/gpu: Fix check for devices without devfreq
      drm/msm: Do hw_init() before capturing GPU state

Sameer Pujar (16):
      ASoC: tegra: Fix wrong value type in ADMAIF
      ASoC: tegra: Fix wrong value type in I2S
      ASoC: tegra: Fix wrong value type in DMIC
      ASoC: tegra: Fix wrong value type in DSPK
      ASoC: tegra: Fix wrong value type in SFC
      ASoC: tegra: Fix wrong value type in MVC
      ASoC: tegra: Fix kcontrol put callback in ADMAIF
      ASoC: tegra: Fix kcontrol put callback in I2S
      ASoC: tegra: Fix kcontrol put callback in DMIC
      ASoC: tegra: Fix kcontrol put callback in DSPK
      ASoC: tegra: Fix kcontrol put callback in AHUB
      ASoC: tegra: Fix kcontrol put callback in MVC
      ASoC: tegra: Fix kcontrol put callback in SFC
      ASoC: tegra: Fix kcontrol put callback in AMX
      ASoC: tegra: Fix kcontrol put callback in ADX
      ASoC: tegra: Fix kcontrol put callback in Mixer

Sameer Saurabh (3):
      atlantic: Fix to display FW bundle version instead of FW mac version.
      Remove Half duplex mode speed capabilities.
      atlantic: Remove warn trace message.

Sean Christopherson (12):
      KVM: Ensure local memslot copies operate on up-to-dateAaro Koskinen (=
1):
      i2c: cbus-gpio: set atomic transfer callback

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel ADL

Akhil P Oommen (2):
      drm/msm: Fix null ptr access msm_ioctl_gem_submit()
      drm/msm/a6xx: Fix uinitialized use of gpu_scid

Al Cooper (1):
      serial: 8250_bcm7271: UART errors after resuming from S2

Alain Volmat (4):
      i2c: stm32f7: flush TX FIFO upon transfer errors
      i2c: stm32f7: recover the bus on access timeout
      i2c: stm32f7: stop dma transfer in case of NACK
      i2c: stm32f7: use proper DMAENGINE API for termination

Alexander Stein (1):
      Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

Amir Tzin (1):
      net/mlx5: Fix use after free in mlx5_health_wait_pci_up

Andreas Gruenbacher (4):
      gfs2: Fix remote demote of weak glock holders
      gfs2: gfs2_inode_lookup cleanup
      gfs2: gfs2_inode_lookup rework
      gfs2: gfs2_create_inode rework

Andrew Halaney (1):
      preempt/dynamic: Fix setup_preempt_mode() return value

Anup Patel (1):
      RISC-V: KVM: Fix incorrect KVM_MAX_VCPUS value

Arnaud Pouliquen (1):
      MAINTAINERS: Add rpmsg tty driver maintainer

Arnd Bergmann (3):
      iwlwifi: pcie: fix constant-conversion warning
      drm: msm: fix building without CONFIG_COMMON_CLK
      siphash: use _unaligned version by default

Aya Levin (1):
      net/mlx5: Fix access to a non-supported register

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Wait in SNK_DEBOUNCED until disconnect

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Ben Ben-Ishay (1):
      net/mlx5e: SHAMPO, Fix constant expression result

Ben Gardon (1):
      KVM: x86/mmu: Fix TLB flush range when handling disconnected pt

Benjamin Poirier (2):
      net: mpls: Fix notifications when deleting a device
      net: mpls: Remove rcu protection from nh_dev

Catalin Marinas (1):
      KVM: arm64: Avoid setting the upper 32 bits of TCR_EL2 and CPTR_EL2 t=
o 1

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Christophe JAILLET (2):
      iwlwifi: Fix memory leaks in error handling path
      net: marvell: mvpp2: Fix the computation of shared CPUs

Corey Minyard (2):
      ipmi: fix IPMI_SMI_MSG_TYPE_IPMB_DIRECT response length checking
      ipmi:ipmb: Fix unknown command response

Dan Carpenter (1):
      KVM: VMX: Set failure code in prepare_vmcs02()

Daniel Lezcano (1):
      powercap/drivers/dtpm: Disable DTPM at boot time

David Howells (1):
      netfs: Adjust docs after foliation

Deren Wu (1):
      mt76: fix timestamp check in tx_status

Dmitry Bogdanov (2):
      atlantic: Increase delay for fw transactions
      atlantic: Fix statistics logic for production hardware

Dmytro Linkin (2):
      net/mlx5: E-switch, Respect BW share of the new group
      net/mlx5: E-Switch, Check group pointer before reading bw_share value

Dongliang Mu (1):
      dpaa2-eth: destroy workqueue at the end of remove function

Douglas Anderson (3):
      drm/msm/a6xx: Allocate enough space for GMU registers
      drm/msm: Fix mmap to include VM_IO and VM_DONTDUMP
      drm/msm/dp: Avoid unpowered AUX xfers that caused crashes

Dust Li (1):
      net/smc: fix wrong list_del in smc_lgr_cleanup_early

Eiichi Tsukata (2):
      rxrpc: Fix rxrpc_peer leak in rxrpc_look_up_bundle()
      rxrpc: Fix rxrpc_local leak in rxrpc_lookup_peer()

Eric Dumazet (3):
      net: annotate data-races on txq->xmit_lock_owner
      net: avoid uninit-value from tcp_conn_request
      ipv4: convert fib_num_tclassid_users to atomic_t

Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

Erik Ekman (1):
      net/mlx4_en: Update reported link modes for 1/10G

Feng Tang (2):
      x86/tsc: Add a timer to make sure TSC_adjust is always checked
      x86/tsc: Disable clocksource watchdog for TSC on qualified platorms

Finn Thain (1):
      pata_falcon: Avoid type warnings from sparse

Flora Cui (2):
      drm/amdgpu: cancel the correct hrtimer on exit
      drm/amdgpu: check atomic flag to differeniate with legacy path

Florian Fainelli (1):
      net: dsa: b53: Add SPI ID table

Frank Li (1):
      usb: cdns3: gadget: fix new urb never complete if ep cancel
previous requests

Frederic Weisbecker (2):
      timers/nohz: Last resort update jiffies on nohz_full IRQ entry
      sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

Gal Pressman (1):
      net/mlx5: Fix too early queueing of log timestamp work

Guangming (1):
      dma-buf: system_heap: Use 'for_each_sgtable_sg' in pages free flow

Guchun Chen (1):
      drm/amdgpu: fix the missed handling for SDMA2 and SDMA3

Gurchetan Singh (2):
      drm/virtgpu api: define a dummy fence signaled event
      drm/virtio: use drm_poll(..) instead of virtio_gpu_poll(..)

Gustavo A. R. Silva (1):
      wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()

Hans de Goede (1):
      ASoC: soc-acpi: Set mach->id field on comp_ids matches

Harshit Mogalapalli (1):
      net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Heiko Carstens (1):
      s390: update defconfigs

Helge Deller (5):
      parisc: Fix KBUILD_IMAGE for self-extracting kernel
      parisc: Enable sata sil, audit and usb support on 64-bit defconfig
      parisc/agp: Annotate parisc agp init functions with __init
      parisc: Fix "make install" on newer debian releases
      parisc: Mark cr16 CPU clocksource unstable on all SMP machines

Hou Wenlong (2):
      KVM: x86/mmu: Skip tlb flush if it has been done in zap_gfn_range()
      KVM: x86/mmu: Pass parameter flush as false in
kvm_tdp_mmu_zap_collapsible_sptes()

Ilia Sergachev (1):
      serial: liteuart: Fix NULL pointer dereference in ->remove()

Ilie Halip (1):
      s390/test_unwind: use raw opcode instead of invalid instruction

Ioanna Alifieraki (1):
      ipmi: Move remove_work to dedicated workqueue

Jakub Kicinski (1):
      ipmi: fix oob access due to uninit smi_msg type

James Smart (1):
      scsi: lpfc: Fix non-recovery of remote ports following an unsolicited=
 LOGO

Jane Jian (1):
      drm/amdgpu/sriov/vcn: add new vcn ip revision check case for
SIENNA_CICHLID

Jason A. Donenfeld (7):
      wireguard: allowedips: add missing __rcu annotation to satisfy sparse
      wireguard: selftests: increase default dmesg log size
      wireguard: selftests: actually test for routing loops
      wireguard: device: reset peer src endpoint when netns exits
      wireguard: receive: use ring buffer for incoming handshakes
      wireguard: receive: drop handshakes if queue lock is contended
      MAINTAINERS: co-maintain random.c

Jay Dolan (2):
      serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
      serial: 8250_pci: rewrite pericom_do_set_divisor()

Jens Axboe (1):
      io-wq: don't retry task_work creation failure on fatal conditions

Jeremy Kerr (1):
      mctp: test: fix skb free in test device tx

Jiapeng Chong (1):
      gro: Fix inconsistent indenting

Jimmy Kizito (1):
      drm/amd/display: Add work around for tunneled MST.

Joerg Roedel (1):
      x86/64/mm: Map all kernel memory into trampoline_pgd

Johan Hovold (4):
      serial: core: fix transmit-buffer reset and memleak
      serial: liteuart: fix use-after-free and memleak on unbind
      serial: liteuart: fix minor-number leak on probe errors
      serial: liteuart: relax compile-test dependencies

Jos=C3=A9 Roberto de Souza (1):
      Revert "drm/i915: Implement Wa_1508744258"

Juergen Gross (1):
      x86/kvm: remove unused ack_notifier callbacks

Kai Vehmanen (2):
      ALSA: hda: Add Intel DG2 PCI ID and HDMI codec vid
      ALSA: hda/hdmi: fix HDA codec entry table order for ADL-P

Karsten Graul (1):
      MAINTAINERS: s390/net: add Alexandra and Wenjia as maintainer

Kuan-Ying Lee (1):
      arm64: update PAC description for kernel

Lai Jiangshan (5):
      KVM: X86: Fix when shadow_root_level=3D5 && guest root_level<4
      KVM: X86: Use vcpu->arch.walk_mmu for kvm_mmu_invlpg()
      x86/entry: Add a fence for kernel entry SWAPGS in paranoid_entry()
      x86/entry: Use the correct fence macro after swapgs in kernel CR3
      x86/xen: Add xenpv_restore_regs_and_return_to_usermode()

Li Zhijian (2):
      wireguard: selftests: rename DEBUG_PI_LIST to DEBUG_PLIST
      selftests: net: Correct case name

Lijo Lazar (1):
      drm/amdgpu: Don't halt RLC on GFX suspend

Like Xu (1):
      KVM: x86/pmu: Fix reserved bits for AMD PerfEvtSeln register

Linus Torvalds (2):
      fget: check that the fd still exists after getting a ref to it
      Linux 5.16-rc4

Lorenzo Bianconi (3):
      mt76: mt7915: fix NULL pointer dereference in mt7915_get_phy_mode
      mt76: fix possible pktid leak
      mt76: fix key pointer overwrite in
mt7921s_write_txwi/mt7663_usb_sdio_write_txwi

Lucas Tanure (1):
      ASoC: cs35l41: Set the max SPI speed for the whole device

Luiz Angelo Daros de Luca (1):
      net: dsa: realtek-smi: fix indirect reg access for ports>3

Lukas Wunner (1):
      serial: 8250: Fix RTS modem control while in rs485 mode

Lyude Paul (2):
      drm/i915: Add support for panels with VESA backlights with PWM
enable/disable
      drm/i915/dp: Perform 30ms delay after source OUI write

Maciej Fijalkowski (1):
      ice: xsk: clear status_error0 for each allocated desc

Maciej S. Szmigiero (1):
      KVM: selftests: page_table_test: fix calculation of guest_test_phys_m=
em

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Maor Dickman (1):
      net/mlx5: E-Switch, Use indirect table only if all destinations suppo=
rt it

Maor Gottlieb (1):
      net/mlx5: Lag, Fix recreation of VF LAG

Marc Zyngier (2):
      KVM: arm64: Save PSTATE early on exit
      KVM: arm64: Move pkvm's special 32bit handling into a generic
infrastructure

Marco Elver (1):
      x86/fpu/signal: Initialize sw_bytes in save_xstate_epilog()

Marek Beh=C3=BAn (6):
      net: dsa: mv88e6xxx: Fix application of erratum 4.8 for 88E6393X
      net: dsa: mv88e6xxx: Drop unnecessary check in
mv88e6393x_serdes_erratum_4_6()
      net: dsa: mv88e6xxx: Save power by disabling SerDes trasmitter
and receiver
      net: dsa: mv88e6xxx: Add fix for erratum 5.2 of 88E6393X family
      net: dsa: mv88e6xxx: Fix inband AN for 2500base-x on 88E6393X family
      net: dsa: mv88e6xxx: Link in pcs_get_state() if AN is bypassed

Mark Bloch (1):
      net/mlx5: E-Switch, fix single FDB creation on BlueField

Mark Rutland (2):
      arm64: kexec: use __pa_symbol(empty_zero_page)
      arm64: ftrace: add missing BTIs

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Mathias Nyman (1):
      xhci: Fix commad ring abort, write all 64 bits to CRCR register.

Matt Johnston (1):
      mctp: Don't let RTM_DELROUTE delete local routes

Matthew Wilcox (Oracle) (1):
      tools: Fix math.h breakage

Maxime Ripard (6):
      drm/vc4: kms: Wait for the commit before increasing our clock rate
      drm/vc4: kms: Fix return code check
      drm/vc4: kms: Add missing drm_crtc_commit_put
      drm/vc4: kms: Clear the HVS FIFO commit pointer once done
      drm/vc4: kms: Don't duplicate pending commit
      drm/vc4: kms: Fix previous HVS commit wait

Michael Sterritt (1):
      x86/sev: Fix SEV-ES INS/OUTS instructions for word, dword, and qword

Mordechay Goodstein (1):
      iwlwifi: mvm: retry init flow if failed

Moshe Shemesh (1):
      net/mlx5: Move MODIFY_RQT command to ignore list in internal error st=
ate

Mustapha Ghaddar (1):
      drm/amd/display: Fix for the no Audio bug with Tiled Displays

Nicholas Kazlauskas (1):
      drm/amd/display: Allow DSC on supported MST branch devices

Nicolas Frattaroli (1):
      ASoC: rk817: Add module alias for rk817-codec

Nikita Danilov (2):
      atlatnic: enable Nbase-t speeds with base-t
      atlantic: Add missing DIDs and fix 115c.

Niklas Schnelle (1):
      s390/pci: move pseudo-MMIO to prevent MIO overlap

Ole Ernst (2):
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub

Ondrej Jirman (1):
      i2c: rk3x: Handle a spurious start completion interrupt flag

Paolo Abeni (1):
      tcp: fix page frag corruption on page fault

Paolo Bonzini (22):
      KVM: VMX: do not use uninitialized gfn_to_hva_cache
      KVM: downgrade two BUG_ONs to WARN_ON_ONCE
      KVM: x86: ignore APICv if LAPIC is not enabled
      selftests: fix check for circular KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      selftests: sev_migrate_tests: free all VMs
      KVM: SEV: expose KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM capability
      KVM: MMU: shadow nested paging does not have PKU
      KVM: VMX: prepare sync_pir_to_irr for running with APICv disabled
      KVM: x86: check PIR even for vCPUs with disabled APICv
      KVM: x86: Use a stable condition around all VT-d PI paths
      KVM: SEV: do not use list_replace_init on an empty list
      KVM: SEV: cleanup locking for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      KVM: SEV: initialize regions_list of a mirror VM
      KVM: SEV: move mirror status to destination of
KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      selftests: sev_migrate_tests: add tests for
KVM_CAP_VM_COPY_ENC_CONTEXT_FROM
      KVM: SEV: Do COPY_ENC_CONTEXT_FROM with both VMs locked
      KVM: SEV: Prohibit migration of a VM that has mirrors
      KVM: SEV: do not take kvm->lock when destroying
      KVM: SEV: accept signals in sev_lock_two_vms
      KVM: VMX: clear vmx_x86_ops.sync_pir_to_irr if APICv is disabled
      KVM: fix avic_set_running for preemptable kernels
      KVM: ensure APICv is considered inactive if there is no APIC

Patrik John (1):
      serial: tegra: Change lower tolerance baud rate limit for
tegra20 and tegra30

Paulo Alcantara (1):
      cifs: fix missed refcounting of ipc tcon

Perry Yuan (1):
      drm/amd/display: add connector type check for CRC source set

Peter Zijlstra (1):
      objtool: Fix pv_ops noinstr validation

Philip Chen (1):
      drm/msm/dsi: set default num_data_lanes

Philip Yang (3):
      drm/amdkfd: set "r =3D 0" explicitly before goto
      drm/amdkfd: fix double free mem structure
      drm/amdkfd: process_info lock not needed for svm

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Pierre-Louis Bossart (2):
      ASoC: Intel: soc-acpi: add entry for ESSX8336 on CML
      ALSA: intel-dsp-config: add quirk for CML devices based on ES8336 cod=
ec

Ping-Ke Shih (1):
      rtw89: update partition size of firmware header on skb->data

Qais Yousef (1):
      sched/uclamp: Fix rq->uclamp_max not set on first enqueue

Raed Salem (2):
      net/mlx5e: IPsec: Fix Software parser inner l3 type setting in
case of encapsulation
      net/mlx5e: Fix missing IPsec statistics on uplink representor

Rafael J. Wysocki (1):
      powercap: DTPM: Drop unused local variable from init_dtpm()

Randy Dunlap (3):
      wireguard: main: rename 'mod_init' & 'mod_exit' functions to be
module-specific
      vfio: remove all kernel-doc notation
      natsemi: xtensa: fix section mismatch warnings

Ranjani Sridharan (1):
      ASoC: SOF: hda: reset DAI widget before reconfiguring it

Rob Clark (8):
      drm/msm/devfreq: Fix OPP refcnt leak
      drm/msm: Fix wait_fence submitqueue leak
      drm/msm: Restore error return on invalid fence
      drm/msm: Make a6xx_gpu_set_freq() static
      drm/msm: Demote debug message
      drm/msm/gpu: Fix idle_work time
      drm/msm/gpu: Fix check for devices without devfreq
      drm/msm: Do hw_init() before capturing GPU state

Sameer Pujar (16):
      ASoC: tegra: Fix wrong value type in ADMAIF
      ASoC: tegra: Fix wrong value type in I2S
      ASoC: tegra: Fix wrong value type in DMIC
      ASoC: tegra: Fix wrong value type in DSPK
      ASoC: tegra: Fix wrong value type in SFC
      ASoC: tegra: Fix wrong value type in MVC
      ASoC: tegra: Fix kcontrol put callback in ADMAIF
      ASoC: tegra: Fix kcontrol put callback in I2S
      ASoC: tegra: Fix kcontrol put callback in DMIC
      ASoC: tegra: Fix kcontrol put callback in DSPK
      ASoC: tegra: Fix kcontrol put callback in AHUB
      ASoC: tegra: Fix kcontrol put callback in MVC
      ASoC: tegra: Fix kcontrol put callback in SFC
      ASoC: tegra: Fix kcontrol put callback in AMX
      ASoC: tegra: Fix kcontrol put callback in ADX
      ASoC: tegra: Fix kcontrol put callback in Mixer

Sameer Saurabh (3):
      atlantic: Fix to display FW bundle version instead of FW mac version.
      Remove Half duplex mode speed capabilities.
      atlantic: Remove warn trace message.

Sean Christopherson (12):
      KVM: Ensure local memslot copies operate on up-to-date arch-specific =
data
      KVM: Disallow user memslot with size that exceeds "unsigned long"
      KVM: RISC-V: Unmap stage2 mapping when deleting/moving a memslot
      KVM: nVMX: Flush current VPID (L1 vs. L2) for KVM_REQ_TLB_FLUSH_GUEST
      KVM: nVMX: Abide to KVM_REQ_TLB_FLUSH_GUEST request on nested
vmentry/vmexit
      KVM: nVMX: Emulate guest TLB flush on nested VM-Enter with new vpid12
      KVM: x86/mmu: Use yield-safe TDP MMU root iter in MMU notifier unmapp=
ing
      KVM: x86/mmu: Remove spurious TLB flushes in TDP MMU zap collapsible =
path
      KVM: x86/mmu: Handle "default" period when selectively waking kthread
      KVM: x86/mmu: Retry page fault if root is invalidated by memslot upda=
te
      KVM: SEV: Return appropriate error codes if SEV-ES scratch setup fail=
s
      KVM: SEV: Fall back to vmalloc for SEV-ES scratch area if necessary

Shen, George (1):
      drm/amd/display: Clear DPCD lane settings after repeater training

Shyam Prasad N (3):
      cifs: wait for tcon resource_id before getting fscache super
      cifs: add server conn_id to fscache client cookie
      cifs: avoid use of dstaddr as key for fscache client cookie

Stanislaw Gruszka (1):
      rt2x00: do not mark device gone on EPROTO errors during start

Stefan Binding (1):
      ALSA: hda/cs8409: Set PMSG_ON earlier inside cs8409 driver

Stephen Suryaputra (1):
      vrf: Reset IPCB/IP6CB when processing outbound pkts in vrf dev xmit

Steven Rostedt (VMware) (1):
      tracing/histograms: String compares should not care about signed valu=
es

Sukadev Bhattiprolu (2):
      ibmvnic: drop bad optimization in reuse_rx_pools()
      ibmvnic: drop bad optimization in reuse_tx_pools()

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

Sven Schuchmann (1):
      net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of
"0" if no IRQ is available

Tang Yizhou (2):
      cpufreq: Fix a comment in cpufreq_policy_free
      cpufreq: docs: Update core.rst

Tariq Toukan (1):
      net/mlx5e: Sync TIR params updates against concurrent create/modify

Tetsuo Handa (1):
      loop: Use pr_warn_once() for loop_control_remove() warning

Tianhao Chai (1):
      ethernet: aquantia: Try MAC address from device tree

Tianjia Zhang (1):
      net/tls: Fix authentication failure in CCM mode

Tom Lendacky (1):
      KVM: SVM: Do not terminate SEV-ES guests on GHCB validation failure

Tony Lu (1):
      net/smc: Keep smc_close_final rc during active close

Tony Luck (1):
      x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

Vincent Whitchurch (1):
      net: stmmac: Avoid DMA_CHAN_CONTROL write if no Split Header support

Vitaly Kuznetsov (3):
      KVM: selftests: Avoid KVM_SET_CPUID2 after KVM_RUN in hyperv_features=
 test
      KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
      KVM: selftests: Make sure kvm_create_max_vcpus test won't hit
RLIMIT_NOFILE

Wei Yongjun (2):
      ipmi: msghandler: Make symbol 'remove_work_wq' static
      net: mscc: ocelot: fix missing unlock on error in ocelot_hwstamp_set(=
)

William Kucharski (1):
      net/rds: correct socket tunable error in rds_tcp_tune()

Xiayu Zhang (1):
      Fix Comment of ETH_P_802_3_MIN

Xiongfeng Wang (1):
      cpufreq: Fix get_cpu_device() failure in add_cpu_dev_symlink()

Yang Guang (1):
      ata: replace snprintf in show functions with sysfs_emit

Zhenyu Wang (1):
      vfio/pci: Fix OpRegion read

Zhou Qingyang (4):
      net: qlogic: qlcnic: Fix a NULL pointer dereference in
qlcnic_83xx_add_rings()
      net/mlx4_en: Fix an use-after-free bug in mlx4_en_try_alloc_resources=
()
      octeontx2-af: Fix a memleak bug in rvu_mbox_init()
      usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init()

chongjiapeng (1):
      iwlwifi: Fix missing error code in iwl_pci_probe()

msizanoen1 (1):
      ipv6: fix memory leak in fib6_rule_suppress

shaoyunl (1):
      drm/amdgpu: adjust the kfd reset sequence in reset sriov function

=C5=81ukasz Bartosik (1):
      iwlwifi: fix warnings produced by kernel debug options

arch-specific data
      KVM: Disallow user memslot with size that exceeds "unsigned long"
      KVM: RISC-V: Unmap stage2 mapping when deleting/moving a memslot
      KVM: nVMX: Flush current VPID (L1 vs. L2) for KVM_REQ_TLB_FLUSH_GUEST
      KVM: nVMX: Abide to KVM_REQ_TLB_FLUSH_GUEST request on nested
vmentry/vmexit
      KVM: nVMX: Emulate guest TLB flush on nested VM-Enter with new vpid12
      KVM: x86/mmu: Use yield-safe TDP MMU root iter in MMU notifier unmapp=
ing
      KVM: x86/mmu: Remove spurious TLB flushes in TDP MMU zap collapsible =
path
      KVM: x86/mmu: Handle "default" period when selectively waking kthread
      KVM: x86/mmu: Retry page fault if root is invalidated by memslot upda=
te
      KVM: SEV: Return appropriate error codes if SEV-ES scratch setup fail=
s
      KVM: SEV: Fall back to vmalloc for SEV-ES scratch area if necessary

Shen, George (1):
      drm/amd/display: Clear DPCD lane settings after repeater training

Shyam Prasad N (3):
      cifs: wait for tcon resource_id before getting fscache super
      cifs: add server conn_id to fscache client cookie
      cifs: avoid use of dstaddr as key for fscache client cookie

Stanislaw Gruszka (1):
      rt2x00: do not mark device gone on EPROTO errors during start

Stefan Binding (1):
      ALSA: hda/cs8409: Set PMSG_ON earlier inside cs8409 driver

Stephen Suryaputra (1):
      vrf: Reset IPCB/IP6CB when processing outbound pkts in vrf dev xmit

Steven Rostedt (VMware) (1):
      tracing/histograms: String compares should not care about signed valu=
es

Sukadev Bhattiprolu (2):
      ibmvnic: drop bad optimization in reuse_rx_pools()
      ibmvnic: drop bad optimization in reuse_tx_pools()

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

Sven Schuchmann (1):
      net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of
"0" if no IRQ is available

Tang Yizhou (2):
      cpufreq: Fix a comment in cpufreq_policy_free
      cpufreq: docs: Update core.rst

Tariq Toukan (1):
      net/mlx5e: Sync TIR params updates against concurrent create/modify

Tetsuo Handa (1):
      loop: Use pr_warn_once() for loop_control_remove() warning

Tianhao Chai (1):
      ethernet: aquantia: Try MAC address from device tree

Tianjia Zhang (1):
      net/tls: Fix authentication failure in CCM mode

Tom Lendacky (1):
      KVM: SVM: Do not terminate SEV-ES guests on GHCB validation failure

Tony Lu (1):
      net/smc: Keep smc_close_final rc during active close

Tony Luck (1):
      x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

Vincent Whitchurch (1):
      net: stmmac: Avoid DMA_CHAN_CONTROL write if no Split Header support

Vitaly Kuznetsov (3):
      KVM: selftests: Avoid KVM_SET_CPUID2 after KVM_RUN in hyperv_features=
 test
      KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
      KVM: selftests: Make sure kvm_create_max_vcpus test won't hit
RLIMIT_NOFILE

Wei Yongjun (2):
      ipmi: msghandler: Make symbol 'remove_work_wq' static
      net: mscc: ocelot: fix missing unlock on error in ocelot_hwstamp_set(=
)

William Kucharski (1):
      net/rds: correct socket tunable error in rds_tcp_tune()

Xiayu Zhang (1):
      Fix Comment of ETH_P_802_3_MIN

Xiongfeng Wang (1):
      cpufreq: Fix get_cpu_device() failure in add_cpu_dev_symlink()

Yang Guang (1):
      ata: replace snprintf in show functions with sysfs_emit

Zhenyu Wang (1):
      vfio/pci: Fix OpRegion read

Zhou Qingyang (4):
      net: qlogic: qlcnic: Fix a NULL pointer dereference in
qlcnic_83xx_add_rings()
      net/mlx4_en: Fix an use-after-free bug in mlx4_en_try_alloc_resources=
()
      octeontx2-af: Fix a memleak bug in rvu_mbox_init()
      usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init()

chongjiapeng (1):
      iwlwifi: Fix missing error code in iwl_pci_probe()

msizanoen1 (1):
      ipv6: fix memory leak in fib6_rule_suppress

shaoyunl (1):
      drm/amdgpu: adjust the kfd reset sequence in reset sriov function

=C5=81ukasz Bartosik (1):
      iwlwifi: fix warnings produced by kernel debug options
