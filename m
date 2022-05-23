Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1887F530C42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiEWJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiEWJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:04:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB444750
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:04:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f16so24241008ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oSDVPuSGPWzT4Hj4nKtTTsSEe/xvbhG9CeVLh39guR4=;
        b=onm9kd5PObIYeXneYlJSsWfJjZ6o5/pqB5Xxrr1jsi3qN7kDjm5OdFVZy5FHsc/jhx
         qocsfCWh8437DD0NdHxNOpBkq02GT/HZEDmBcxNotwDv8hdmYsXmBNII++6xE+v72u5j
         O6PkzTCFVnWTxMOr1SNNTN4l/vplNWloYlqPHl5o1tfzEPwWembicKjz4/CKYhATjz+w
         yUw/yhKzpN55rm0fUP+dFHj/oEnaYKhJJnZbjdAxapnG6tVyqrlbW7G8rf0ptmqJL+rD
         9iS3g+YaMg+EEIpQWRhaveXJmpNdjaxlYVzUvEXRXq07x7nu5r7/S0U/ImtOqeFzzvFn
         sSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oSDVPuSGPWzT4Hj4nKtTTsSEe/xvbhG9CeVLh39guR4=;
        b=f9J4AVuVnkC8VU+7eixzTuoRtTRoUxss6V4eH/mePQxkxz0XDeXA0dxLfXC4EPWJwK
         O1wbuxwiAp4ektWBYDHfwj37894xcwdprdBh/790JnKp1UOXGyg0EIqiOdCDwOO28bu+
         u9Y35oEVek8T1GbCZVqrF1Tpi4HWOa3OJNuvgSKdFktrLH9+x9AOctHc0Ul2jv2CGvkD
         bexxUH1kc9KBCZKyJ9+JjsS5oKsdgte3Rf2t6Dffy3A1+goi2+f5MQWip8QeAF9M2ABp
         umNJpyCKg/c6ONTo7+FerMvaMPPFsj/CzD2A+Z6I+Xg7Fz5QHlBxsT8EieZIJ/GQCnXC
         ReXA==
X-Gm-Message-State: AOAM533YY3E5Mdf0OjZtOlW6DAXHZwDKz4ItzIerszFWG9rsRxp8fnrG
        Ht6EUXeJK1+J294mgnTk2nP0j+HvNl5C/2hqXszoIKqXWZY=
X-Google-Smtp-Source: ABdhPJyERyb42v86Q0igTiwq/2ftnDKy2vMxTkarhWqKGcmnkJ/5R1AMEGZDjSw5IPQH/KjaRoVrgN6airD21452JzE=
X-Received: by 2002:a25:4253:0:b0:64d:8e3f:4bd1 with SMTP id
 p80-20020a254253000000b0064d8e3f4bd1mr20881202yba.412.1653296655290; Mon, 23
 May 2022 02:04:15 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 23 May 2022 14:34:04 +0530
Message-ID: <CA+G9fYt4+47GzfEYT1nV3dqbGa1YCwFm9XwC668D4PkK4BHFgQ@mail.gmail.com>
Subject: WARNING: CPU: 2 PID: 3331 at drivers/firmware/raspberrypi.c:63 rpi_firmware_property_list
To:     open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following kernel warning was noticed on raspberrypi4 device while
running LTP controllers with Linus mainline kernel tree.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  git_sha: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
  git_describe: v5.18
  kernel_version: 5.18.0
  kernel-config: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/config
  artifact-location: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu
  toolchain: gcc-11
  System.map: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/System.map
  vmlinux.xz: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/vmlinux.xz

Steps to reproduce:
# cd /opt/ltp
# ./runltp -p -q -f controllers

cgroup_fj_stress_blkio_1_200_one 1 TINFO: Attaching task 7221 to
/sys/fs/cgroup/blkio/ltp/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1
cgroup_fj_stress_blkio_1_200_one 1 TINFO: Attaching task 7221 to
/sys/fs/cgroup/blkio/ltp/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1
cgroup_fj_stress_blkio_1_200_one 1 TINFO: Attaching task 7221 to
/sys/fs/cgroup/blkio/ltp/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1
[ 2442.255887] ------------[ cut here ]------------
[ 2442.260615] Firmware transaction timeout
[ 2442.260704] WARNING: CPU: 2 PID: 3331 at
drivers/firmware/raspberrypi.c:63
rpi_firmware_property_list+0x1e8/0x270
[ 2442.275114] Modules linked in: btrfs blake2b_generic libcrc32c
raid6_pq zstd_compress brcmfmac xhci_pci brcmutil snd_soc_hdmi_codec
xhci_pci_renesas raspberrypi_cpufreq hci_uart btqca btbcm vc4 cfg80211
bluetooth cec drm_cma_helper rfkill drm_kms_helper reset_raspberrypi
clk_raspberrypi crct10dif_ce raspberrypi_hwmon drm pwm_bcm2835
iproc_rng200 pcie_brcmstb i2c_bcm2835 rng_core bcm2711_thermal fuse
[ 2442.311148] CPU: 2 PID: 3331 Comm: kworker/2:2 Not tainted 5.18.0 #1
[ 2442.317599] Hardware name: Raspberry Pi 4 Model B (DT)
[ 2442.322810] Workqueue: events get_values_poll [raspberrypi_hwmon]
[ 2442.329007] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2442.336074] pc : rpi_firmware_property_list+0x1e8/0x270
[ 2442.341381] lr : rpi_firmware_property_list+0x1e8/0x270
[ 2442.346685] sp : ffff800010d63cc0
[ 2442.350043] x29: ffff800010d63cc0 x28: 0000000000000000 x27: ffff0000419d0540
[ 2442.357297] x26: 0000000000000011 x25: ffff80000afdd008 x24: 0000000000001000
[ 2442.364547] x23: ffff000061ce9300 x22: ffff80000ac330b0 x21: ffff0000419d0500
[ 2442.371797] x20: 0000000000000010 x19: ffff80000afdd000 x18: ffffffffffffffff
[ 2442.379046] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800090d63937
[ 2442.386295] x14: ffff80000a912dd0 x13: 74756f656d697420 x12: 6e6f69746361736e
[ 2442.393544] x11: ffff80000a8b1ce8 x10: ffff80000a91c178 x9 : ffff80000811d524
[ 2442.400794] x8 : 00000000ffffefff x7 : ffff80000a909cf8 x6 : 0000000000000001
[ 2442.408044] x5 : ffff80000a88f000 x4 : ffff80000a88f2c0 x3 : 0000000000000000
[ 2442.415293] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000062921040
[ 2442.422543] Call trace:
[ 2442.425020]  rpi_firmware_property_list+0x1e8/0x270
[ 2442.429973]  rpi_firmware_property+0x7c/0xc0
[ 2442.434308]  get_values_poll+0x54/0x120 [raspberrypi_hwmon]
[ 2442.439967]  process_one_work+0x1dc/0x450
[ 2442.444045]  worker_thread+0x154/0x450
[ 2442.447850]  kthread+0x100/0x110
[ 2442.451126]  ret_from_fork+0x10/0x20
[ 2442.454760] ---[ end trace 0000000000000000 ]---
[ 2442.471909] hwmon hwmon1: Failed to get throttled (-110)
[ 2443.499865] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -110
[ 2446.575893] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -110
[ 2450.915855] mmc1: Timeout waiting for hardware cmd interrupt.
[ 2450.921693] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 2450.928227] mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
[ 2450.934763] mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[ 2450.941297] mmc1: sdhci: Argument:  0xaaaa0000 | Trn mode: 0x00000033
[ 2450.947830] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
[ 2450.954362] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 2450.960896] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[ 2450.967429] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000001
[ 2450.973960] mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
[ 2450.980493] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[ 2450.987025] mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
[ 2450.993558] mmc1: sdhci: Cmd:       0x00000d1a | Max curr: 0x00080008
[ 2451.000091] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0076b27f
[ 2451.006624] mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000900
[ 2451.013155] mmc1: sdhci: Host ctl2: 0x0000808c
[ 2451.017659] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xc3400208
[ 2451.024191] mmc1: sdhci: ============================================
[ 2452.679889] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -110
[ 2455.763879] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -110
[ 2460.759844] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 2460.766034] rcu: 1-...!: (1 GPs behind)
idle=add/1/0x4000000000000000 softirq=481373/481374 fqs=23
[ 2460.775311] (detected by 3, t=5253 jiffies, g=915057, q=822)
[ 2460.781141] Task dump for CPU 1:
[ 2460.784411] task:cgroup_fj_stres state:R  running task     stack:
 0 pid: 6806 ppid:   501 flags:0x00000200
[ 2460.794483] Call trace:
[ 2460.796958]  __switch_to+0x104/0x160
[ 2460.800595]  0xffff0000403cff00
[ 2460.803782] rcu: rcu_preempt kthread timer wakeup didn't happen for
5216 jiffies! g915057 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[ 2460.815430] rcu: Possible timer handling issue on cpu=0 timer-softirq=161506
[ 2460.822667] rcu: rcu_preempt kthread starved for 5222 jiffies!
g915057 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[ 2460.833345] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[ 2460.842606] rcu: RCU grace-period kthread stack dump:
[ 2460.847726] task:rcu_preempt     state:I stack:    0 pid:   15
ppid:     2 flags:0x00000008
[ 2460.856203] Call trace:
[ 2460.858678]  __switch_to+0x104/0x160
[ 2460.862305]  __schedule+0x314/0x8ac
[ 2460.865843]  schedule+0x5c/0xd4
[ 2460.869028]  schedule_timeout+0xa4/0x1c4
[ 2460.873010]  rcu_gp_fqs_loop+0x140/0x520
[ 2460.876998]  rcu_gp_kthread+0x1a8/0x25c
[ 2460.880891]  kthread+0x100/0x110
[ 2460.884167]  ret_from_fork+0x10/0x20
[ 2460.887796] rcu: Stack dump where RCU GP kthread last ran:
[ 2460.893357] Task dump for CPU 0:
[ 2460.896624] task:swapper/0       state:R  running task     stack:
 0 pid:    0 ppid:     0 flags:0x0000000a
[ 2460.906690] Call trace:
[ 2460.909165]  __switch_to+0x104/0x160
[ 2460.912791]  0x0
[ 2461.159863] mmc1: Timeout waiting for hardware cmd interrupt.
[ 2461.165699] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 2461.172231] mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
[ 2461.178763] mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[ 2461.185294] mmc1: sdhci: Argument:  0xaaaa0000 | Trn mode: 0x00000033
[ 2461.191826] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
[ 2461.198358] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 2461.204887] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[ 2461.211419] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000001
[ 2461.217951] mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
[ 2461.224483] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[ 2461.231013] mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
[ 2461.237543] mmc1: sdhci: Cmd:       0x00000d1a | Max curr: 0x00080008
[ 2461.244073] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0076b27f
[ 2461.250604] mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000900
[ 2461.257135] mmc1: sdhci: Host ctl2: 0x0000808c
[ 2461.261639] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xc3400208
[ 2461.268169] mmc1: sdhci: ============================================
[ 2462.019897] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -110
[ 2471.403852] mmc1: Timeout waiting for hardware cmd interrupt.
[ 2471.409689] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 2471.416219] mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
[ 2471.422751] mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[ 2471.429282] mmc1: sdhci: Argument:  0xaaaa0000 | Trn mode: 0x00000033
[ 2471.435814] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
[ 2471.442345] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 2471.448876] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[ 2471.455407] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000001
[ 2471.461938] mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
[ 2471.468469] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[ 2471.474998] mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
[ 2471.481529] mmc1: sdhci: Cmd:       0x00000d1a | Max curr: 0x00080008
[ 2471.488061] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0076b27f
[ 2471.494592] mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000900
[ 2471.501122] mmc1: sdhci: Host ctl2: 0x0000808c
[ 2471.505624] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xc3400208
[ 2471.512155] mmc1: sdhci: ============================================
[ 2481.647850] mmc1: Timeout waiting for hardware cmd interrupt.
[ 2481.653680] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 2481.660211] mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
[ 2481.666742] mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[ 2481.673273] mmc1: sdhci: Argument:  0xaaaa0000 | Trn mode: 0x00000033
[ 2481.679804] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
[ 2481.686335] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 2481.692866] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[ 2481.699397] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000001
[ 2481.705928] mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
[ 2481.712459] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
[ 2481.718988] mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
[ 2481.725519] mmc1: sdhci: Cmd:       0x00000d1a | Max curr: 0x00080008
[ 2481.732050] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0076b27f
[ 2481.738581] mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000900
[ 2481.745111] mmc1: sdhci: Host ctl2: 0x0000808c
[ 2481.749613] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xc3400208
[ 2481.756143] mmc1: sdhci: ============================================
[ 2481.763349] mmc1: card aaaa removed
[ 2523.923843] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 2523.930032] rcu: 1-...0: (1 GPs behind)
idle=add/1/0x4000000000000000 softirq=481373/481374 fqs=3169
[ 2523.939484] (detected by 3, t=21044 jiffies, g=915057, q=1474)
[ 2523.945491] Task dump for CPU 1:
[ 2523.948761] task:cgroup_fj_stres state:R  running task     stack:
 0 pid: 6806 ppid:   501 flags:0x00000202
[ 2523.958831] Call trace:
[ 2523.961307]  __switch_to+0x104/0x160
[ 2523.964942]  0xffff0000403cff00

Full test log,
https://lkft.validation.linaro.org/scheduler/job/5075973

--
Linaro LKFT
https://lkft.linaro.org
