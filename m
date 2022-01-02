Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199FD482D05
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiABWhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiABWhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:37:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FFC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 14:37:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o6so129514591edc.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y0LN2T23VrbLM6uttfB82mzxRwmEHSNqZvn2oV0AJY0=;
        b=ZV5/Cg6dzQfYRgVPUyaR6GOaosDzcaxZwrbnqu7Lv2PdRnxVPRRZ1DSuK1HhfdxEpy
         fI3UWnqLWqiEOjA6O+tIv4coVND4Sboz5OzKr8Hsds/N/Ss8m8cVYMZ/BEu+FtQFqHpy
         BsJx9N/O/vl9R2cUNKfrr6H7bCNaktrvckfxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y0LN2T23VrbLM6uttfB82mzxRwmEHSNqZvn2oV0AJY0=;
        b=MBpyn72pw1kVS9Gangz6LWbyUqNLYq0Bktbft6dt+/6MuPj9hmpXHl4733Usbsm4Q7
         PTSSuJB8pMoGewQU2xx7++QCQCI6W+ZjgkKVFOpIF+dByfU05croZpaHAvudCCDAIapI
         hLZfhRZcd8iPt3Fey5eJWv33ISwwZsg7QTmqtCWbfN50+DiP+Hrc3OBNI3CG4AAYEHVX
         e0Nr4PJDGj5B2x8EpKbnlLYxPCHv7uqa/K130v3FEV8Gc83z2IQcygH9BtyTetmqvDUv
         afBL8GnZBtAmvZMLo93aM6GCVd0l15YoXmOhaB9JZG/qHcWey12L4deayWqjVz6eFqI0
         J6mQ==
X-Gm-Message-State: AOAM533rm8KiJMPRsUqxv13cw72q10MHHodslEDHPkTv5c23gBdp33/J
        ioQxxzw6RqwOPFlAtFnFECP4bRMytqcBdGC4
X-Google-Smtp-Source: ABdhPJweA5Z5jey0RyrI7D8Tx5ysGeWfMN0Hyi1FxmnKyPjMclj7c9rUXZS2a9CTkXPR3MBhNYyoYA==
X-Received: by 2002:a17:906:7944:: with SMTP id l4mr34900316ejo.598.1641163058745;
        Sun, 02 Jan 2022 14:37:38 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id p4sm10174499eju.98.2022.01.02.14.37.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 14:37:38 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id t26so66637270wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 14:37:38 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr36023476wrp.442.1641163057994;
 Sun, 02 Jan 2022 14:37:37 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jan 2022 14:37:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=3dEpPGhz8YvJUDWhFW_GUeASBGmqyw3aPQRfB3ki9w@mail.gmail.com>
Message-ID: <CAHk-=wg=3dEpPGhz8YvJUDWhFW_GUeASBGmqyw3aPQRfB3ki9w@mail.gmail.com>
Subject: Linux 5.16-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So as expected, this is a tiny rc - there really hasn't been a lot
going on during the holidays. Even now, not everybody is necessarily
back, and we'll likely have another very quiet upcoming week and then
I'll do the real 5.16 release and we'll hopefully be more or less back
to normal (and thanks to the people who have already sent me pending
pull request for 5.17 - it helps me to have them early, since I'll
unfortunately have some travel during the upcoming merge window).

The bulk here (and "bulk" is probably the wrong word to use, it's all
pretty small) is gpu and networking drivers, and some core networking
fixes. There's some other minor noise in here too (usb, i2c, input,
auxdisplay, scsi, perf tooling), but it's all very small.

Please, as you emerge from your holiday-induced food coma, do give it
a quick test so that we can all be happy about the final release next
weekend.

                 Linus

---

Adrian Hunter (3):
      perf intel-pt: Fix parsing of VM time correlation arguments
      perf script: Fix CPU filtering of a script's switch events
      perf scripts python: intel-pt-events.py: Fix printing of switch event=
s

Aleksander Jan Bajkowski (1):
      net: lantiq_xrx200: fix statistics of received bytes

Alex Deucher (4):
      drm/amdgpu: add support for IP discovery gc_info table v2
      drm/amdgpu: fix runpm documentation
      drm/amdgpu: always reset the asic in suspend (v2)
      drm/amdgpu: no DC support for headless chips

Alexey Makhalov (1):
      scsi: vmw_pvscsi: Set residual data length conditionally

Amir Tzin (1):
      net/mlx5e: Wrap the tx reporter dump callback to extract the sq

Andra Paraschiv (1):
      nitro_enclaves: Use get_user_pages_unlocked() call to handle mmap ass=
ert

Angus Wang (1):
      drm/amd/display: Changed pipe split policy to allow for
multi-display pipe split

Charlene Liu (1):
      drm/amd/display: fix B0 TMDS deepcolor no dislay issue

Chris Mi (2):
      net/mlx5: Fix tc max supported prio for nic mode
      net/mlx5e: Delete forward rule for ct or sample action

Christian Brauner (1):
      fs/mount_setattr: always cleanup mount_kattr

Christian K=C3=B6nig (2):
      drm/amdgpu: fix dropped backing store handling in
amdgpu_dma_buf_move_notify
      drm/nouveau: wait for the exclusive fence after the shared ones v2

Christophe JAILLET (3):
      net/mlx5: Fix some error handling paths in 'mlx5e_tc_add_fdb_flow()'
      net: ag71xx: Fix a potential double free in error handling paths
      ionic: Initialize the 'lif->dbid_inuse' bitmap

Chunfeng Yun (4):
      usb: mtu3: fix interval value for intr and isoc
      usb: mtu3: add memory barrier before set GPD's HWO
      usb: mtu3: fix list_head check warning
      usb: mtu3: set interval of FS intr and isoc endpoint

Ciara Loftus (1):
      xsk: Initialise xskb free_list_node

Coco Li (2):
      udp: using datalen to cap ipv6 udp max gso segments
      selftests: Calculate udpgso segment count without header adjustment

Dan Carpenter (1):
      scsi: lpfc: Terminate string in lpfc_debugfs_nvmeio_trc_write()

Deep Majumder (1):
      Docs: Fixes link to I2C specification

Dmitry V. Levin (1):
      uapi: fix linux/nfc.h userspace compilation errors

Dust Li (2):
      net/smc: don't send CDC/LLC message if link not ready
      net/smc: fix kernel panic caused by race of smc_sock

Evan Quan (1):
      drm/amdgpu: put SMU into proper state on runpm suspending for
BOCO capable platform

Gal Pressman (2):
      net/mlx5e: Fix skb memory leak when TC classifier action
offloads are disabled
      net/mlx5e: Fix wrong features assignment in case of error

Heikki Krogerus (1):
      usb: typec: ucsi: Only check the contract if there is a connection

Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

Huang Rui (1):
      drm/amdgpu: introduce new amdgpu_fence object to indicate the
job embedded fence

James McLaughlin (1):
      igc: Fix TX timestamp support for non-MSI-X platforms

Javier Martinez Canillas (1):
      efi: Move efifb_setup_from_dmi() prototype from arch headers

Jianguo Wu (2):
      selftests: net: Fix a typo in udpgro_fwd.sh
      selftests: net: using ping6 for IPv6 in udpgro_fwd.sh

Jiasheng Jiang (1):
      net/ncsi: check for error return from call to nla_put_u32

John Garry (1):
      perf pmu: Fix alias events list

Karsten Graul (1):
      net/smc: fix using of uninitialized completions

Krzysztof Kozlowski (1):
      nfc: uapi: use kernel size_t to fix user-space builds

Lai, Derek (1):
      drm/amd/display: Added power down for DCN10

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Lijo Lazar (1):
      drm/amd/pm: Fix xgmi link control on aldebaran

Linus Torvalds (1):
      Linux 5.16-rc8

Lixiaokeng (1):
      scsi: libiscsi: Fix UAF in iscsi_conn_get_param()/iscsi_conn_teardown=
()

Luiz Sampaio (2):
      auxdisplay: charlcd: fixing coding style issue
      auxdisplay: charlcd: checking for pointer reference before dereferenc=
ing

Lukas Bulwahn (1):
      x86/build: Use the proper name CONFIG_FW_LOADER

Ma Xinjian (1):
      selftests: mptcp: Remove the deprecated config NFT_COUNTER

Mathias Nyman (1):
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Matthew Brost (2):
      drm/i915: Fix possible uninitialized variable in parallel extension
      drm/i915: Increment composite fence seqno

Matthias-Christian Ott (1):
      net: usb: pegasus: Do not drop long Ethernet frames

Maxim Mikityanskiy (2):
      net/mlx5e: Fix interoperability between XSK and ICOSQ recovery flow
      net/mlx5e: Fix ICOSQ recovery flow for XSK

Mel Gorman (2):
      mm: vmscan: Reduce throttling due to a failure to make progress
      mm: vmscan: reduce throttling due to a failure to make progress -fix

Miaoqian Lin (4):
      net/mlx5: DR, Fix NULL vs IS_ERR checking in dr_domain_init_resources
      net: phy: fixed_phy: Fix NULL vs IS_ERR() checking in __fixed_phy_reg=
ister
      perf expr: Fix return value of ids__new()
      fsl/fman: Fix missing put_device() call in fman_port_probe

Michael Ellerman (1):
      powerpc/ptdump: Fix DEBUG_WX since generic ptdump conversion

Mike Kravetz (1):
      userfaultfd/selftests: fix hugetlb area allocations

Moshe Shemesh (1):
      net/mlx5: Fix SF health recovery flow

Muchun Song (1):
      net: fix use-after-free in tw_timer_handler

Nicholas Kazlauskas (3):
      drm/amd/display: Send s0i2_rdy in stream_count =3D=3D 0 optimization
      drm/amd/display: Set optimize_pwr_state for DCN31
      drm/amd/display: Fix USB4 null pointer dereference in
update_psp_stream_config

Nikolay Aleksandrov (3):
      net: bridge: mcast: add and enforce query interval minimum
      net: bridge: mcast: add and enforce startup query interval minimum
      net: bridge: mcast: fix br_multicast_ctx_vlan_global_disabled helper

Pavel Skripkin (2):
      Input: appletouch - initialize work before device registration
      i2c: validate user data in compat ioctl

Prike Liang (1):
      drm/amd/pm: skip setting gfx cgpg in the s0ix suspend-resume

Roi Dayan (1):
      net/mlx5e: TC, Fix memory leak with rules with internal port

SeongJae Park (1):
      mm/damon/dbgfs: fix 'struct pid' leaks in 'dbgfs_target_ids_write()'

Shay Drory (2):
      net/mlx5: Use first online CPU instead of hard coded CPU
      net/mlx5: Fix error print in case of IRQ request failed

Tamir Duberstein (1):
      ipv6: raw: check passed optlen before reading

Todd Kjos (1):
      binder: fix async_free_space accounting for empty parcels

Tom Rix (1):
      selinux: initialize proto variable in selinux_ip_postroute_compat()

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

Vinicius Costa Gomes (1):
      igc: Do not enable crosstimestamping for i225-V models

Wei Yongjun (1):
      NFC: st21nfca: Fix memory leak in device probe and remove

William Zhao (1):
      ip6_vti: initialize __ip6_tnl_parm struct in vti6_siocdevprivate

Xin Long (1):
      sctp: use call_rcu to free endpoint

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix querying eswitch manager vport for ECPF

Zekun Shen (1):
      atlantic: Fix buff_ring OOB in aq_ring_rx_clean

chen gong (1):
      drm/amdgpu: When the VCN(1.0) block is suspended, powergating is
explicitly enabled

wolfgang huang (1):
      mISDN: change function names to avoid conflicts

wujianguo (1):
      selftests/net: udpgso_bench_tx: fix dst ip argument

xu xin (1):
      Documentation: fix outdated interpretation of ip_no_pmtu_disc

yangxingwu (1):
      net: udp: fix alignment problem in udp4_seq_show()

yaowenbin (1):
      perf top: Fix TUI exit screen refresh race condition
