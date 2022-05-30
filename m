Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F895537434
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 07:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiE3FAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiE3FAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:00:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB46712C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:00:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r82so7281577ybc.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+03JWP8LqFizkdu8BAr30l+13Hx2X9LWKbjZC6DUoo=;
        b=lw4v6BmxbvzBFhrCE0UETLXyDdPq0f4xwoieXuRfzg4qhI+w8B7o1IohItK3JzWvDu
         lNLGsH36sgnQkJsJuhpN2oo4wrlJeKff8KpxwxnItQQrZlfErA8j8dX1NsE0mn7P4zca
         hjH4QVDEf4cjeXCla+S7g+OtvPd+WIBvWalufpHVA7BN3ru0V8icIhHV1yCp4zvZh5LI
         LgDThkR3HKwwh438shwHrAJmDYIetcHR4u3scAdWu+tJNicj1U66MIzdCJqtWhvSyz4O
         5PxiJEAU3ApOLX5H3FoYQOmqpkOXQdYLys3ZESIUgSkv4AlDmyWRku5bd6YnlAXqXC/Q
         3qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+03JWP8LqFizkdu8BAr30l+13Hx2X9LWKbjZC6DUoo=;
        b=58sjLCZelZabE1CWhMEiG8eK1s74TqugTtjpJasiNjVMxTMk8avYvhzphb4l2Hve8O
         9+3vTvVyXltdtL/kitS4aS54bSRhguODL89vKSSsKmZxpy83AsHwDClWQvQ7BSp0i20U
         g/CaXyL4BWx8RMDLmaVL5YekCf+VLBYsWNczLBH9AIos89iDfNWngR44W4CusydXlC9M
         0RAFjJ56E3vOKaTLBpgpQp+ubWtiZR/UeVmczeHpBdHOL2ZUAmwZjYp0oU7EYc0Dq7do
         rhoKEZHpUsSPs7/g2/EMVB8hPHayvfkG79VpRpcjX/4xuHbLQFje7OuWCtw36LxuClIk
         iiLw==
X-Gm-Message-State: AOAM531oKbSrEWLm/Vfd5QtRFGgVfhVkyRUoVvwN0RX0WdzXCV6hR4Zb
        FNjahXj/t693fNuADm8o0+RaoB3je7Koieza2kmRHw==
X-Google-Smtp-Source: ABdhPJwPRUUf5U1aqUPaZTY1gOwSQ19UWn0xveiElXnhR3CF6ZITgEcqC+Ddb+k6yigJAG+0/KxPFQs9KDfrzOte1r4=
X-Received: by 2002:a25:8d83:0:b0:65c:e76f:a4d7 with SMTP id
 o3-20020a258d83000000b0065ce76fa4d7mr2684932ybl.80.1653886817303; Sun, 29 May
 2022 22:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X> <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X> <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de> <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
 <Yo3WvGnNk3LvLb7R@linutronix.de> <CAGETcx84ja_w_=vXKDOZnM8EVEcuAg1tX9Kqy57PTkDb1=H4FA@mail.gmail.com>
 <YpMv/QRaY/KV0oxY@x1-carbon>
In-Reply-To: <YpMv/QRaY/KV0oxY@x1-carbon>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 29 May 2022 21:59:41 -0700
Message-ID: <CAGETcx8+fQsouyg64Af_rdtezAOB6s_Yj2rOG36BwceCDVjYrQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 1:34 AM 'Niklas Cassel' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed, May 25, 2022 at 12:49:00PM -0700, Saravana Kannan wrote:
> > On Wed, May 25, 2022 at 12:12 AM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2022-05-24 10:46:49 [-0700], Saravana Kannan wrote:
> > > > > Removing probe_timeout_waitqueue (as suggested) or setting the ti=
meout
> > > > > to 0 avoids the delay.
> > > >
> > > > In your case, I think it might be working as intended? Curious, wha=
t
> > > > was the call stack in your case where it was blocked?
> > >
> > > Why is then there 10sec delay during boot? The backtrace is
> > > |------------[ cut here ]------------
> > > |WARNING: CPU: 4 PID: 1 at drivers/base/dd.c:742 wait_for_device_prob=
e+0x30/0x110
> > > |Modules linked in:
> > > |CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5+ #154
> > > |RIP: 0010:wait_for_device_probe+0x30/0x110
> > > |Call Trace:
> > > | <TASK>
> > > | prepare_namespace+0x2b/0x160
> > > | kernel_init_freeable+0x2b3/0x2dd
> > > | kernel_init+0x11/0x110
> > > | ret_from_fork+0x22/0x30
> > > | </TASK>
> > >
> > > Looking closer, it can't access init. This in particular box boots
> > > directly the kernel without an initramfs so the kernel later mounts
> > > /dev/sda1 and everything is good.  So that seems to be the reason=E2=
=80=A6
> >
>
> Hello there,
>
> My (QEMU) boot times were recently extended by 10 seconds.
> Looking at the timestamps, it looks like nothing is being done for 10 who=
le
> seconds.
>
> A git bisect landed me at the patch in $subject:
> 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver regis=
tration")
>
> Adding a WARN_ON(1) in wait_for_device_probe(), as requested by the patch
> author from the others seeing a regression with this patch, gives two dif=
ferent
> stacktraces during boot:

Thanks for the report. My patch was exposing an existing issue. I
already sent a fix for that a few days ago. Waiting for it to get
picked up.

-Saravana

>
> [    0.459633] printk: console [netcon0] enabled
> [    0.459636] printk: console [netcon0] printing thread started
> [    0.459637] netconsole: network logging started
> [    0.459896] cfg80211: Loading compiled-in X.509 certificates for regul=
atory database
> [    0.460230] kworker/u8:6 (105) used greatest stack depth: 14744 bytes =
left
> [    0.461031] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    0.461077] platform regulatory.0: Direct firmware load for regulatory=
.db failed with error -2
> [    0.461085] cfg80211: failed to load regulatory.db
> [    0.461113] ALSA device list:
> [    0.461116]   No soundcards found.
> [    0.461614] ------------[ cut here ]------------
> [    0.461615] WARNING: CPU: 2 PID: 1 at drivers/base/dd.c:741 wait_for_d=
evice_probe+0x1a/0x160
> [    0.485809] Modules linked in:
> [    0.486089] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.18.0-next-2022=
0526-00004-g74f936013b08-dirty #20
> [    0.486842] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.487707] RIP: 0010:wait_for_device_probe+0x1a/0x160
> [    0.488103] Code: 00 e8 fa e4 b5 ff 8b 44 24 04 48 83 c4 08 5b c3 0f 1=
f 44 00 00 53 48 83 ec 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 <=
0f> 0b e8 1f ac 57 00 8b 15 f1 b3 24 01 85 d2 75 3d 48 c7 c7 60 2f
> [    0.489539] RSP: 0000:ffff9c7900013ed8 EFLAGS: 00010246
> [    0.489965] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 000000000=
0000d02
> [    0.490597] RDX: 0000000000000cc2 RSI: 0000000000000000 RDI: 000000000=
002e990
> [    0.491181] RBP: 0000000000000214 R08: 000000000000000f R09: 000000000=
0000064
> [    0.491788] R10: ffff9c7900013c6c R11: 0000000000000000 R12: ffff8964c=
0343640
> [    0.492384] R13: ffffffff9e51791c R14: 0000000000000000 R15: 000000000=
0000000
> [    0.492960] FS:  0000000000000000(0000) GS:ffff896637d00000(0000) knlG=
S:0000000000000000
> [    0.493658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.494501] CR2: 0000000000000000 CR3: 00000001ed20c001 CR4: 000000000=
0370ee0
> [    0.495621] Call Trace:
> [    0.496059]  <TASK>
> [    0.496266]  ? init_eaccess+0x3b/0x76
> [    0.496657]  prepare_namespace+0x30/0x16a
> [    0.497016]  kernel_init_freeable+0x207/0x212
> [    0.497407]  ? rest_init+0xc0/0xc0
> [    0.497714]  kernel_init+0x16/0x120
> [    0.498250]  ret_from_fork+0x1f/0x30
> [    0.498898]  </TASK>
> [    0.499307] ---[ end trace 0000000000000000 ]---
> [    0.748413] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    0.749053] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    0.749461] ata2.00: ATA-7: QEMU HARDDISK, version, max UDMA/100
> [    0.749470] ata2.00: 732 sectors, multi 16: LBA48 NCQ (depth 32)
> [    0.749479] ata2.00: applying bridge limits
> [    0.750915] ata4: SATA link down (SStatus 0 SControl 300)
> [    0.752110] ata5: SATA link down (SStatus 0 SControl 300)
> [    0.753424] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    0.754877] ata3: SATA link down (SStatus 0 SControl 300)
> [    0.755342] ata1.00: ATA-7: QEMU HARDDISK, version, max UDMA/100
> [    0.755377] ata1.00: 268435456 sectors, multi 16: LBA48 NCQ (depth 32)
> [    0.755387] ata1.00: applying bridge limits
> [    0.755486] ata6.00: ATA-7: QEMU HARDDISK, version, max UDMA/100
> [    0.755492] ata6.00: 8388608 sectors, multi 16: LBA48 NCQ (depth 32)
> [    0.755500] ata6.00: applying bridge limits
> [    0.757330] ata1.00: configured for UDMA/100
> [    0.757441] ata6.00: configured for UDMA/100
> [    0.757505] ata2.00: configured for UDMA/100
> [    0.758015] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    =
ion  PQ: 0 ANSI: 5
> [    0.760542] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    0.760669] sd 0:0:0:0: [sda] 268435456 512-byte logical blocks: (137 =
GB/128 GiB)
> [    0.760778] sd 0:0:0:0: [sda] Write Protect is off
> [    0.760787] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    0.760847] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [    0.760981] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    0.761319] scsi 1:0:0:0: Direct-Access     ATA      QEMU HARDDISK    =
ion  PQ: 0 ANSI: 5
> [    0.762808] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    0.763004] sd 1:0:0:0: [sdb] 732 512-byte logical blocks: (375 kB/366=
 KiB)
> [    0.763649] sd 1:0:0:0: [sdb] Write Protect is off
> [    0.763661] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    0.763965] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [    0.764026] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> [    0.765923] scsi 5:0:0:0: Direct-Access     ATA      QEMU HARDDISK    =
ion  PQ: 0 ANSI: 5
> [    0.767987] sd 5:0:0:0: Attached scsi generic sg2 type 0
> [    0.768626] sd 5:0:0:0: [sdc] 8388608 512-byte logical blocks: (4.29 G=
B/4.00 GiB)
> [    0.769909] sd 5:0:0:0: [sdc] Write Protect is off
> [    0.769920] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    0.770515] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    0.770900] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [    0.771782] sd 5:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
> [    0.773900]  sda: sda1 sda14 sda15
> [    0.774499] sd 5:0:0:0: [sdc] Attached SCSI disk
> [    0.774907] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.084011] input: ImExPS/2 Generic Explorer Mouse as /devices/platfor=
m/i8042/serio1/input/input3
> [   10.887350] md: Waiting for all devices to be available before autodet=
ect
> [   10.887395] md: If you don't use raid, use raid=3Dnoautodetect
> [   10.887445] ------------[ cut here ]------------
> [   10.887448] WARNING: CPU: 1 PID: 1 at drivers/base/dd.c:741 wait_for_d=
evice_probe+0x1a/0x160
> [   10.893987] Modules linked in:
> [   10.894314] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-next-20220526-00004-g74f936013b08-dirty #20
> [   10.895389] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   10.896590] RIP: 0010:wait_for_device_probe+0x1a/0x160
> [   10.897215] Code: 00 e8 fa e4 b5 ff 8b 44 24 04 48 83 c4 08 5b c3 0f 1=
f 44 00 00 53 48 83 ec 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 <=
0f> 0b e8 1f ac 57 00 8b 15 f1 b3 24 01 85 d2 75 3d 48 c7 c7 60 2f
> [   10.899269] RSP: 0000:ffff9c7900013ec8 EFLAGS: 00010246
> [   10.899762] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 000000000=
0000000
> [   10.900424] RDX: 0000000000000000 RSI: ffffffff9d998089 RDI: 00000000f=
fffffff
> [   10.901060] RBP: 0000000000000214 R08: 80000000ffffe1ca R09: ffff9c790=
0013ea8
> [   10.901839] R10: 3fffffffffffffff R11: 0000000000000000 R12: ffff8964c=
0343640
> [   10.902615] R13: ffffffff9e51791c R14: 0000000000000000 R15: 000000000=
0000000
> [   10.903371] FS:  0000000000000000(0000) GS:ffff896637c80000(0000) knlG=
S:0000000000000000
> [   10.904188] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.904721] CR2: 0000000000000000 CR3: 00000001ed20c001 CR4: 000000000=
0370ee0
> [   10.905340] Call Trace:
> [   10.905558]  <TASK>
> [   10.905739]  md_run_setup+0x3c/0x6a
> [   10.906036]  prepare_namespace+0x35/0x16a
> [   10.906391]  kernel_init_freeable+0x207/0x212
> [   10.906748]  ? rest_init+0xc0/0xc0
> [   10.907021]  kernel_init+0x16/0x120
> [   10.907312]  ret_from_fork+0x1f/0x30
> [   10.907617]  </TASK>
> [   10.907796] ---[ end trace 0000000000000000 ]---
> [   10.908159] md: Autodetecting RAID arrays.
> [   10.908160] md: autorun ...
> [   10.908160] md: ... autorun DONE.
> [   10.911301] EXT4-fs (sda1): INFO: recovery required on readonly filesy=
stem
> [   10.911303] EXT4-fs (sda1): write access will be enabled during recove=
ry
> [   11.038001] EXT4-fs (sda1): orphan cleanup on readonly fs
> [   11.038466] EXT4-fs (sda1): 2 orphan inodes deleted
> [   11.038475] EXT4-fs (sda1): recovery complete
> [   11.053033] EXT4-fs (sda1): mounted filesystem with ordered data mode.=
 Quota mode: none.
> [   11.053074] VFS: Mounted root (ext4 filesystem) readonly on device 8:1=
.
> [   11.053175] devtmpfs: mounted
> [   11.061921] Freeing unused kernel image (initmem) memory: 1680K
> [   11.061930] Write protecting the kernel read-only data: 24576k
> [   11.071108] Freeing unused kernel image (text/rodata gap) memory: 2032=
K
> [   11.073596] Freeing unused kernel image (rodata/data gap) memory: 924K
> [   11.073609] Run /sbin/init as init process
>
>
> Kind regards,
> Niklas
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
