Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F664BE70C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377634AbiBUOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377611AbiBUOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:23:30 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08621EC77
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:23:05 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p7so32310077qvk.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=O3Zh0SgDSu5NGeFuINS3hHY+v4RnsezRC5NYoRpW2wI=;
        b=Lkb0FYOMRRw333nXXWrqWZ6GKQut6dEp6c/PB7RBZG5GaSRs2A0F4xK/z11ZiL1UnY
         oRwntog/2DP3Nc5X1mm6zDH+XXfYdu+SrUg96IvpPAfkQCidhReROu6ePsiHlZyWJY0f
         6rrggqZdRZl2xGGSssjoUz1nGNCqIg63VZBeuGFjqF0KwHYnMgYLZmFbahMye7DMIYdg
         4MT4GnKAFje6woHWB2lGAdomaGuDEBOB1MxOgzkTXZ+ma5nzWdwLH1+0kWcjZQultvuC
         5ZTkhAPKqF9iaTLRtVSUkS6UrlCKCMvTGGq6gXRr21sc4mOd0ldLMTaxnY4QPCyrYd4X
         p43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=O3Zh0SgDSu5NGeFuINS3hHY+v4RnsezRC5NYoRpW2wI=;
        b=weFrhIPINp6hyWvrwax6+6NXhISHpWElBjfIQRgplRfHhPv7zBvpO2iiQO9HV6F1sT
         78GUSMLBQksaZNrqs2nQEP7AfDzDGzCvjXBdV4TliW+NIEbRfIXJGRoErnWWgPIOcJR6
         omwXR5u0uXeZMCPWMmMDpkpn6cHRdhaqjsstQJLyMDqPnu46Ju7FsafxV7bjS7diqCBp
         nTtVHgFnEcYanktQ0nJczhv30doW+VG/hJEaeXAG8vwwYfLFqPk48b208hWKSnEmGx2w
         La/VXKxgf+TY1Emy0Nc0kTnsP5gLhQH5DohBTLCfrRH4vav+37JYD3ts7M17bc/RxSAE
         u/3w==
X-Gm-Message-State: AOAM5333cj+HXxVD4DerkDgKDRgm1f1oK557CzoIt97aRHH3RmlRL4Yg
        agrTPHNpi29AQ7bQd9cnfSQ/rbQy34U=
X-Google-Smtp-Source: ABdhPJzvufEbMHBp33RxXwZW4BCO8gI4pJu/CPNlMglO6vj2ZviBDMtbNRgNNRq/3QIQXgE1bY2dKg==
X-Received: by 2002:a05:622a:192:b0:2cc:5816:7470 with SMTP id s18-20020a05622a019200b002cc58167470mr17719696qtw.51.1645453384170;
        Mon, 21 Feb 2022 06:23:04 -0800 (PST)
Received: from [120.7.1.38] (198-84-206-107.cpe.teksavvy.com. [198.84.206.107])
        by smtp.gmail.com with ESMTPSA id h19sm19904945qtx.12.2022.02.21.06.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 06:23:03 -0800 (PST)
Subject: Re: Linux 5.17-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
From:   Woody Suwalski <wsuwalski@gmail.com>
Message-ID: <8f331927-69d4-e4e7-22bc-c2a2a098dc1e@gmail.com>
Date:   Mon, 21 Feb 2022 09:23:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101 Firefox/68.0
 SeaMonkey/2.53.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> We all know the drill by now. Another week, another rc.
>
> Things continue to look pretty much normal. There are fixes all over
> the place, but no more than usual for this time of the release. And
> the statistics look normal too, with most of the changes being to
> drivers. The diffstat looks a bit unusual with the Intel iwlwifi
> driver showing a lot of modification, but it's almost entirely due to
> removal of the deprecated broadcast filtering that doesn't even work
> with newer firmware.
>
> Outside the driver subsystems, it's mostly arch updates (kvm shows up
> a lot again), tooling and networking.
>
> And various random changes elsewhere. The appended shortlog gives more
> details for the people who are interested in the minutiae.
>
> Please do test.
>
>                  Linus
>
> ---
>
> Alex Henrie (1):
>        HID: apple: Set the tilde quirk flag on the Wellspring 5 and later
>
> Alex Maydanik (1):
>        net: fix documentation for kernel_getsockname
>
> Alexey Khoroshilov (1):
>        net: dsa: lantiq_gswip: fix use after free in gswip_remove()
>
> Amir Goldstein (1):
>        cifs: fix set of group SID via NTSD xattrs
>
> Anders Roxell (1):
>        powerpc/lib/sstep: fix 'ptesync' build error
>
> Andy Lutomirski (1):
>        x86/ptrace: Fix xfpregs_set()'s incorrect xmm clearing
>
> Andy Shevchenko (1):
>        parisc: Add ioread64_lo_hi() and iowrite64_lo_hi()
>
> AngeloGioacchino Del Regno (1):
>        drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with external bridge
>
> Ansuel Smith (2):
>        mtd: parsers: qcom: Fix kernel panic on skipped partition
>        mtd: parsers: qcom: Fix missing free for pparts in cleanup
>
> Arnaldo Carvalho de Melo (2):
>        tools headers UAPI: Sync linux/perf_event.h with the kernel sources
>        perf bpf: Defer freeing string after possible strlen() on it
>
> Basavaraj Natikar (7):
>        HID: amd_sfh: Increase sensor command timeout
>        HID: amd_sfh: Add illuminance mask to limit ALS max value
>        HID: amd_sfh: Handle amd_sfh work buffer in PM ops
>        HID: amd_sfh: Correct the structure field name
>        HID: amd_sfh: Disable the interrupt for all command
>        HID: amd_sfh: Add functionality to clear interrupts
>        HID: amd_sfh: Add interrupt handler to process interrupts
>
> Benjamin Beichler (1):
>        mac80211_hwsim: report NOACK frames in tx_status
>
> Bryan O'Donoghue (2):
>        mtd: rawnand: qcom: Fix clock sequencing in qcom_nandc_probe()
>        mtd: parsers: qcom: Don't print error message on -EPROBE_DEFER
>
> Cai Huoqing (1):
>        Drivers: hv: utils: Make use of the helper macro LIST_HEAD()
>
> Changbin Du (1):
>        perf trace: Avoid early exit due SIGCHLD from non-workload processes
>
> Charles Keepax (1):
>        ASoC: wm_adsp: Correct control read size when parsing compressed buffer
>
> Cheng Jui Wang (1):
>        lockdep: Correct lock_classes index mapping
>
> Christian Brauner (3):
>        tests: fix idmapped mount_setattr test
>        MAINTAINERS: add entry for idmapped mounts
>        fs: add kernel doc for mnt_{hold,unhold}_writers()
>
> Christian Eggers (1):
>        mtd: rawnand: gpmi: don't leak PM reference in error path
>
> Christian Löhle (1):
>        mmc: block: fix read single on recovery logic
>
> Christoph Hellwig (1):
>        block: fix surprise removal for drivers calling blk_set_queue_dying
>
> Christophe JAILLET (1):
>        dmaengine: ptdma: Fix the error handling path in pt_core_init()
>
> Christophe Leroy (1):
>        powerpc/603: Fix boot failure with DEBUG_PAGEALLOC and KFENCE
>
> DENG Qingfang (1):
>        net: phy: mediatek: remove PHY mode check on MT7531
>
> Dan Carpenter (1):
>        mtd: phram: Prevent divide by zero bug in phram_setup()
>
> Dan Williams (1):
>        ACPI: tables: Quiet ACPI table not found warning
>
> Danie du Toit (1):
>        nfp: flower: netdev offload check for ip6gretap
>
> Daniel Thompson (1):
>        HID: i2c-hid: goodix: Fix a lockdep splat
>
> Daniele Palmas (1):
>        net: usb: cdc_mbim: avoid altsetting toggling for Telit FN990
>
> David Woodhouse (1):
>        KVM: x86/xen: Fix runstate updates to be atomic when preempting vCPU
>
> Dmitry Torokhov (2):
>        module: fix building with sysfs disabled
>        Input: psmouse - set up dependency between PS/2 and SMBus companions
>
> Dongliang Mu (1):
>        HID: elo: fix memory leak in elo_probe
>
> Dāvis Mosāns (1):
>        btrfs: send: in case of IO error log it
>
> Eliav Farber (1):
>        EDAC: Fix calculation of returned address and next offset in
> edac_align_ptr()
>
> Emmanuel Grumbach (4):
>        iwlwifi: mei: fix the pskb_may_pull check in ipv4
>        iwlwifi: mei: retry mapping the shared area
>        iwlwifi: mvm: don't feed the hardware RFKILL into iwlmei
>        iwlwifi: mei: report RFKILL upon register when needed
>
> Eric Anholt (1):
>        i2c: bcm2835: Avoid clock stretching timeouts
>
> Eric Dumazet (8):
>        netfilter: xt_socket: fix a typo in socket_mt_destroy()
>        drop_monitor: fix data-race in dropmon_net_event / trace_napi_poll_hit
>        net_sched: add __rcu annotation to netdev->qdisc
>        crypto: af_alg - get rid of alg_memory_allocated
>        bonding: fix data-races around agg_select_timer
>        net: sched: limit TC_ACT_REPEAT loops
>        ipv4: fix data races in fib_alias_hw_flags_set
>        ipv6: fix data-race in fib6_info_hw_flags_set / fib6_purge_rt
>
> Eric W. Biederman (5):
>        rlimit: Fix RLIMIT_NPROC enforcement failure caused by
> capability calls in set_user
>        ucounts: Enforce RLIMIT_NPROC not RLIMIT_NPROC+1
>        ucounts: Base set_cred_ucounts changes on the real user
>        ucounts: Move RLIMIT_NPROC handling after set_user
>        ucounts: Handle wrapping in is_ucounts_overlimit
>
> Evan Quan (1):
>        drm/amd/pm: correct UMD pstate clocks for Dimgrey Cavefish and Beige Goby
>
> Filipe Manana (1):
>        btrfs: get rid of warning on transaction commit when using flushoncommit
>
> Florian Westphal (1):
>        selftests: netfilter: add synproxy test
>
> Gatis Peisenieks (1):
>        atl1c: fix tx timeout after link flap on Mikrotik 10/25G NIC
>
> Geert Uytterhoeven (3):
>        RISC-V: Fix hartid mask handling for hartid 31 and up
>        RISC-V: Fix handling of empty cpu masks
>        RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering
>
> German Gomez (1):
>        perf test: Fix arm64 perf_event_attr tests wrt --call-graph initialization
>
> Guenter Roeck (1):
>        ASoC: Revert "ASoC: mediatek: Check for error clk pointer"
>
> Haimin Zhang (1):
>        block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern
>
> Hangbin Liu (2):
>        selftests: netfilter: fix exit value for nft_concat_range
>        selftests: netfilter: disable rp_filter on router
>
> Hangyu Hua (1):
>        tipc: fix a bit overflow in tipc_crypto_key_rcv()
>
> Helge Deller (2):
>        parisc: Show error if wrong 32/64-bit compiler is being used
>        parisc: Fix some apparent put_user() failures
>
> Ignat Korchagin (1):
>        ipv6: mcast: use rcu-safe version of ipv6_get_lladdr()
>
> JaeMan Park (1):
>        mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work
>
> James Clark (2):
>        perf cs-etm: No-op refactor of synth opt usage
>        perf cs-etm: Fix corrupt inject files when only last branch
> option is enabled
>
> James Smart (1):
>        scsi: lpfc: Fix pt2pt NVMe PRLI reject LOGO loop
>
> Jani Nikula (1):
>        drm/i915/opregion: check port number bounds for SWSCI display power state
>
> Jeremy Kerr (1):
>        mctp: serial: Cancel pending work from ndo_uninit handler
>
> Jesse Brandeburg (1):
>        ice: enable parsing IPSEC SPI headers for RSS
>
> Jiasheng Jiang (3):
>        mac80211: mlme: check for null after calling kmemdup
>        dmaengine: sh: rcar-dmac: Check for error num after setting mask
>        dmaengine: sh: rcar-dmac: Check for error num after dma_set_max_seg_size
>
> Jim Mattson (2):
>        KVM: x86/pmu: Don't truncate the PerfEvtSeln MSR when creating a
> perf event
>        KVM: x86/pmu: Use AMD64_RAW_EVENT_MASK for PERF_TYPE_RAW
>
> Jinyoung Choi (1):
>        scsi: ufs: core: Fix divide by zero in ufshcd_map_queues()
>
> Jiri Olsa (2):
>        MAINTAINERS: Update Jiri's email address
>        libperf: Fix perf_cpu_map__for_each_cpu macro
>
> Joakim Tjernlund (1):
>        arm64: Correct wrong label in macro __init_el2_gicv3
>
> Johannes Berg (4):
>        iwlwifi: pcie: fix locking when "HW not ready"
>        iwlwifi: pcie: gen2: fix locking when "HW not ready"
>        cfg80211: fix race in netlink owner interface destruction
>        iwlwifi: fix use-after-free
>
> John David Anglin (3):
>        parisc: Drop __init from map_pages declaration
>        parisc: Fix data TLB miss in sba_unmap_sg
>        parisc: Fix sglist access in ccio-dma.c
>
> Jon Maloy (2):
>        tipc: fix wrong publisher node address in link publications
>        tipc: fix wrong notification node addresses
>
> Jonas Gorski (1):
>        Revert "net: ethernet: bgmac: Use devm_platform_ioremap_resource_byname"
>
> José Expósito (1):
>        Input: clear BTN_RIGHT/MIDDLE on buttonpads
>
> Kai Vehmanen (3):
>        ASoC: rt5682s: do not block workqueue if card is unbound
>        ASoC: rt5668: do not block workqueue if card is unbound
>        ASoC: rt5682: do not block workqueue if card is unbound
>
> Kalle Valo (4):
>        MAINTAINERS: mark ath6kl as orphan
>        MAINTAINERS: change Loic as wcn36xx maintainer
>        MAINTAINERS: hand over ath9k maintainership to Toke
>        MAINTAINERS: add DT bindings files for ath10k and ath11k
>
> Kees Cook (1):
>        libsubcmd: Fix use-after-free for realloc(..., 0)
>
> Krzysztof Kozlowski (1):
>        selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
>
> Laibin Qiu (1):
>        block/wbt: fix negative inflight counter when remove scsi device
>
> Linus Torvalds (3):
>        tty: n_tty: do not look ahead for EOL character past the end of the buffer
>        mm: don't try to NUMA-migrate COW pages that have other uses
>        Linux 5.17-rc5
>
> Linus Walleij (2):
>        power: supply: bq256xx: Handle OOM correctly
>        Input: zinitix - add new compatible strings
>
> Long Li (1):
>        PCI: hv: Fix NUMA node assignment when kernel boots with custom
> NUMA topology
>
> Luca Coelho (2):
>        iwlwifi: remove deprecated broadcast filtering feature
>        iwlwifi: mvm: don't send SAR GEO command for 3160 devices
>
> Luis Chamberlain (1):
>        fs/file_table: fix adding missing kmemleak_not_leak()
>
> Mans Rullgard (3):
>        net: dsa: lan9303: fix reset on probe
>        net: dsa: lan9303: handle hwaccel VLAN tags
>        net: dsa: lan9303: add VLAN IDs to master device
>
> Marc Zyngier (1):
>        KVM: arm64: vgic: Read HW interrupt pending state from the HW
>
> Mark Brown (4):
>        ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
>        ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_sx()
>        ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range()
>        ASoC: ops: Fix stereo change notifications in snd_soc_put_xr_sx()
>
> Martin Povišer (1):
>        ASoC: tas2770: Insert post reset delay
>
> Matteo Martelli (1):
>        ALSA: usb-audio: revert to IMPLICIT_FB_FIXED_DEV for M-Audio
> FastTrack Ultra
>
> Matthew Auld (1):
>        drm/i915/ttm: tweak priority hint selection
>
> Maxim Levitsky (10):
>        KVM: x86: SVM: don't passthrough SMAP/SMEP/PKE bits in !NPT &&
> !gCR0.PG case
>        KVM: x86: nSVM: fix potential NULL derefernce on nested migration
>        KVM: x86: nSVM: mark vmcb01 as dirty when restoring SMM saved state
>        KVM: x86: nSVM/nVMX: set nested_run_pending on VM entry which is
> a result of RSM
>        KVM: x86: nSVM: expose clean bit support to the guest
>        KVM: x86: nSVM: deal with L1 hypervisor that intercepts
> interrupts but lets L2 control them
>        KVM: x86: lapic: don't touch irr_pending in
> kvm_apic_update_apicv when inhibiting it
>        KVM: x86: SVM: move avic definitions from AMD's spec to svm.h
>        KVM: SVM: extract avic_ring_doorbell
>        KVM: SVM: fix race between interrupt delivery and AVIC inhibition
>
> Miaoqian Lin (3):
>        mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get
>        Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj
>        dmaengine: stm32-dmamux: Fix PM disable depth imbalance in
> stm32_dmamux_probe
>
> Michael Kelley (1):
>        Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)
>
> Mike Christie (1):
>        scsi: qedi: Fix ABBA deadlock in qedi_process_tmf_resp() and
> qedi_process_cmd_cleanup_resp()
>
> Ming Lei (1):
>        block: loop:use kstatfs.f_bsize of backing file to set discard granularity
>
> Miquel Raynal (1):
>        net: ieee802154: ca8210: Fix lifs/sifs periods
>
> Miri Korenblit (2):
>        iwlwifi: mvm: fix condition which checks the version of rate_n_flags
>        iwlwifi: fix iwl_legacy_rate_to_fw_idx
>
> Muhammad Usama Anjum (2):
>        selftests/exec: Add non-regular to TEST_GEN_PROGS
>        selftests: kvm: Remove absent target file
>
> Nicholas Bishop (1):
>        drm/radeon: Fix backlight control on iMac 12,1
>
> Nikolay Aleksandrov (1):
>        MAINTAINERS: bridge: update my email
>
> Oleksandr Mazur (1):
>        net: bridge: multicast: notify switchdev driver whenever MC
> processing gets disabled
>
> Oliver Barta (1):
>        regulator: core: fix false positive in regulator_late_cleanup()
>
> Oliver Neukum (2):
>        USB: zaurus: support another broken Zaurus
>        CDC-NCM: avoid overflow in sanity checking
>
> Pablo Neira Ayuso (2):
>        netfilter: nft_synproxy: unregister hooks on init error path
>        selftests: netfilter: synproxy test requires nf_conntrack
>
> Pankaj Raghav (1):
>        block: Add handling for zone append command in blk_complete_request
>
> Paolo Bonzini (1):
>        KVM: SVM: set IRR in svm_deliver_interrupt
>
> Peter Zijlstra (1):
>        sched: Fix yet more sched_fork() races
>
> Phil Elwell (1):
>        brcmfmac: firmware: Fix crash in brcm_alt_fw_path
>
> Qu Wenruo (2):
>        btrfs: don't hold CPU for too long when defragging a file
>        btrfs: defrag: don't try to defrag extents which are under writeback
>
> Radu Bulie (1):
>        dpaa2-eth: Initialize mutex used in one step timestamping path
>
> Rafał Miłecki (1):
>        i2c: brcmstb: fix support for DSL and CM variants
>
> Rajib Mahapatra (1):
>        drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
>
> Randy Dunlap (3):
>        drm/i915/gvt: clean up kernel-doc in gtt.c
>        power: supply: fix table problem in sysfs-class-power
>        serial: parisc: GSC: fix build when IOSAPIC is not set
>
> Reinette Chatre (1):
>        x86/sgx: Fix missing poison handling in reclaimer
>
> Rob Herring (1):
>        libperf: Fix 32-bit build for tests uint64_t printf
>
> Robin Murphy (1):
>        drm/cma-helper: Set VM_DONTEXPAND for mmap
>
> Roger Quadros (1):
>        mtd: rawnand: omap2: Prevent invalid configuration and build error
>
> Ronnie Sahlberg (3):
>        cifs: do not use uninitialized data in the owner/group sid
>        cifs: fix double free race when mount fails in cifs_get_root()
>        cifs: modefromsids must add an ACE for authenticated users
>
> Sean Christopherson (1):
>        Revert "svm: Add warning message for AVIC IPI invalid target"
>
> Sergio Costas (1):
>        HID:Add support for UGTABLET WP5540
>
> Seth Forshee (1):
>        vsock: remove vsock from connected table when connect is
> interrupted by a signal
>
> Sherry Yang (1):
>        selftests/seccomp: Fix seccomp failure by adding missing headers
>
> Siva Mullati (1):
>        drm/i915/gvt: Make DRM_I915_GVT depend on X86
>
> Stephen Boyd (1):
>        ASoC: qcom: Actually clear DMA interrupt register for HDMI
>
> Steve French (2):
>        smb3: fix snapshot mount option
>        cifs: fix confusing unneeded warning message on smb2.1 and earlier
>
> Takashi Iwai (9):
>        ALSA: memalloc: Fix dma_need_sync() checks
>        ALSA: memalloc: invalidate SG pages before sync
>        ALSA: hda: Fix regression on forced probe mask option
>        ALSA: hda: Fix missing codec probe on Shenker Dock 15
>        ALSA: usb-audio: Don't abort resume upon errors
>        ALSA: hda/realtek: Fix deadlock by COEF mutex
>        ALSA: hda: Set max DMA segment size
>        ASoC: SOF: hda: Set max DMA segment size
>        ASoC: intel: skylake: Set max DMA segment size
>
> Tom Rix (2):
>        dpaa2-switch: fix default return of dpaa2_switch_flower_parse_mirror_key
>        mctp: fix use after free
>
> Trond Myklebust (3):
>        NFS: Remove an incorrect revalidation in nfs4_update_changeattr_locked()
>        NFS: LOOKUP_DIRECTORY is also ok with symlinks
>        NFS: Do not report writeback errors in nfs_getattr()
>
> Tzung-Bi Shih (1):
>        MAINTAINERS: update cros_ec_codec maintainers
>
> V sujith kumar Reddy (1):
>        ASoC: amd: acp: Set gpio_spkr_en to None for max speaker
> amplifer in machine driver
>
> Ville Syrjälä (4):
>        drm/i915: Fix dbuf slice config lookup
>        drm/i915: Fix mbus join config lookup
>        drm/i915/fbc: Fix the plane end Y offset check
>        drm/atomic: Don't pollute crtc_state->mode_blob with error pointers
>
> Vladimir Oltean (2):
>        net: dsa: mv88e6xxx: flush switchdev FDB workqueue before removing VLAN
>        net: mscc: ocelot: fix use-after-free in ocelot_vlan_del()
>
> Vladimir Zapolskiy (2):
>        i2c: qcom-cci: don't delete an unregistered adapter
>        i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()
>
> Waiman Long (1):
>        copy_process(): Move fd_install() out of sighand->siglock critical section
>
> Wen Gu (1):
>        net/smc: Avoid overwriting the copies of clcsock callback functions
>
> Willem de Bruijn (1):
>        ipv6: per-netns exclusive flowlabel checks
>
> Wolfram Sang (4):
>        i2c: cadence: allow COMPILE_TEST
>        i2c: imx: allow COMPILE_TEST
>        i2c: qup: allow COMPILE_TEST
>        MAINTAINERS: remove duplicate entry for i2c-qcom-geni
>
> Woody Suwalski (1):
>        ACPI: processor: idle: fix lockup regression on 32-bit ThinkPad T40
>
> Xin Long (1):
>        ping: fix the dif and sdif check in ping_lookup
>
> Yang Li (1):
>        power: supply: core: fix application of sizeof to pointer
>
> Yang Yingliang (1):
>        dmaengine: at_xdmac: Fix missing unlock in at_xdmac_tasklet()
>
> Yifan Zhang (1):
>        drm/amd/pm: correct the sequence of sending gpu reset msg
>
> Yongzhi Liu (1):
>        dmaengine: shdma: Fix runtime PM imbalance on error
>
> Yu Huang (1):
>        ALSA: hda/realtek: Add quirk for Legion Y9000X 2019
>
> Zhang Changzhong (1):
>        bonding: force carrier update when releasing slave
>
> Zhang Yunkai (1):
>        ipv4: add description about martian source
>
> david regan (1):
>        mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status


Compile failed like reported by Robert Gadson in 
https://lkml.org/lkml/2022/2/20/341

As a workaround:
nf_defrag_ipv6.patch
--- a/net/netfilter/xt_socket.c    2022-02-21 07:29:21.938263397 -0500
+++ b/net/netfilter/xt_socket.c    2022-02-21 07:40:16.730022272 -0500
@@ -17,11 +17,11 @@
  #include <net/inet_sock.h>
  #include <net/netfilter/ipv4/nf_defrag_ipv4.h>

-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+//#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
  #include <linux/netfilter_ipv6/ip6_tables.h>
  #include <net/inet6_hashtables.h>
  #include <net/netfilter/ipv6/nf_defrag_ipv6.h>
-#endif
+//#endif

  #include <net/netfilter/nf_socket.h>
  #include <linux/netfilter/xt_socket.h>



Or force use CONFIG_IP6_NF_IPTABLES :-)

Thanks, Woody

