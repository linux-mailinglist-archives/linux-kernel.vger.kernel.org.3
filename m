Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99BA488D57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiAIXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiAIXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:20:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20059C06175A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 15:20:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z22so1550019edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ddUkt5ZQROXmp/18L9Hj4+Uq1nHDUgctyp+1BiDyBzI=;
        b=MZ+ykaCeQXAp7pVZiSLifdjB8J0je334yniG+eJhuQ3i/uz/rqvHL9UrKtLlhORHjU
         VEux+kB+1cEC3oCFRRse+2NqFFJd0u6QbA3Dl74eTzQIqXMb5AKUWlWhgP5+aBXeh872
         uElE+/QdL6Wg5RwcNCnQEBsx0D6tT1UanFB2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ddUkt5ZQROXmp/18L9Hj4+Uq1nHDUgctyp+1BiDyBzI=;
        b=Hhxua5RHHYUg38IkNNAGkN3P75dk6oq+WePuHX3VzzXNr6+qscmnJe9ulJJHNquJ3f
         tzhYCFgmaw7uEdm70AIB1/thgffti/+mePqrhyzm/pOXr9N81jATr4X0Wj+WZb2JD1ko
         9+NslcOjrUxIirNfL4nnhKBD1JccJ8+dF4PU9Xh1lxJE083+QeK6neCDF/f4tx1JbuD6
         3AsLz5jBYFfK6Um923zQKh6JXjAeGXu1wVa+0Qp2Tyid6V9dH6up5rU5HZ5CnvZQPZ9d
         kuaaoxLBI7vf247vbvDaMZNDeNKqobi5j6bl/zUPE0LyVDnzXQ5eKPkCcYPnOtYFhkb4
         zTmw==
X-Gm-Message-State: AOAM5339ky/+aiqd+7spWpl6dGQ5sk2yJWz5Playp5EXJiZTtXL0oZem
        P8JJsWXvsZZsQrXfuAl3YhKEieu7gBe0/QLAPXA=
X-Google-Smtp-Source: ABdhPJxTZQ7MnDraKg3JH6qEVZa5HkGCWxhYrXIBXH4wu/fbq+19TVzvsAhR7hyirHFEN1eEdBIJ8g==
X-Received: by 2002:a05:6402:5202:: with SMTP id s2mr65152592edd.206.1641770427271;
        Sun, 09 Jan 2022 15:20:27 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id r8sm2661905edd.39.2022.01.09.15.20.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 15:20:26 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id k18so23455623wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 15:20:26 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr61714628wrp.442.1641770425904;
 Sun, 09 Jan 2022 15:20:25 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 15:20:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUkBrUVhjixy4wvrUhPbW-DTgtQubJWVOoLW=O0wRKMA@mail.gmail.com>
Message-ID: <CAHk-=wgUkBrUVhjixy4wvrUhPbW-DTgtQubJWVOoLW=O0wRKMA@mail.gmail.com>
Subject: Linux 5.16
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a lot here since -rc8, which is not unexpected. We had that extra
week due to the holidays, and it's not like we had lots of last-minute
things that needed to be sorted out.

So this mainly contains some driver fixes (mainly networking and
rdma), a cgroup credential use fix, a few core networking fixes, a
couple of last-minute reverts, and some other random noise. The
appended shortlog is so small that you might as well scroll through
it.

This obviously means that the merge window for 5.17 opens tomorrow,
and I'm happy to say I already have several pending early pull
requests.  I wish I had even more, because this merge window is going
to be somewhat painful due to unfortunate travel for family reasons.
So I'll be doing most of it on the road on a laptop - something I
generally try to avoid.

That said, the merging part of the merge window works perfectly well
on a laptop, it's just that I normally really want to do more local
build testing between merges than a laptop really allows me to do. So
the main downside during travel is that I end up relying much more on
the automated build testing in the cloud. And so really hope that
everything has been properly cooking in linux-next so that there are
no unnecessary issues that pop up when things hit my tree.

Of course, realistically our automated build testing is so good
anyway, and people have been pretty good about linux-next, that maybe
my local builds aren't _that_ important. I do end up occasionally
hitting issues that should never have made it as far as my tree, but
it's not like it's a common - or generally serious - issue.

Knock wood.

Anyway, I don't expect any real issue, but I'll probably be jetlagged
and in odd timezones, so my response time might be "variable".

But hey, before that merge window even opens, you still have some time
to give a shiny new kernel release some TLC and testing.

                Linus

---

Aaron Ma (1):
      Revert "net: usb: r8152: Add MAC passthrough support for more
Lenovo Docks"

Alex Deucher (2):
      fbdev: fbmem: add a helper to determine if an aperture is used by a f=
w fb
      drm/amdgpu: disable runpm if we are the primary adapter

Andrew Lunn (3):
      seg6: export get_srh() for ICMP handling
      icmp: ICMPV6: Examine invoking packet for Segment Route Headers.
      udp6: Use Segment Routing Header for dest address if present

Arnaldo Carvalho de Melo (1):
      Revert "libtraceevent: Increase libtraceevent logging when verbose"

Arthur Kiyanovski (3):
      net: ena: Fix undefined state when tx request id is out of bounds
      net: ena: Fix wrong rx request id by resetting device
      net: ena: Fix error handling when calculating max IO queues number

Chris Packham (1):
      i2c: mpc: Avoid out of bounds memory access

Christoph Hellwig (1):
      netrom: fix copying in user data in nr_setsockopt

Colin Ian King (1):
      bpf, selftests: Fix spelling mistake "tained" -> "tainted"

Darrick J. Wong (1):
      xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like falloca=
te

David Ahern (7):
      ipv4: Check attribute length for RTA_GATEWAY in multipath route
      ipv4: Check attribute length for RTA_FLOW in multipath route
      ipv6: Check attribute length for RTA_GATEWAY in multipath route
      ipv6: Check attribute length for RTA_GATEWAY when deleting multipath =
route
      lwtunnel: Validate RTA_ENCAP_TYPE attribute length
      ipv6: Continue processing multipath route even if gateway
attribute is invalid
      ipv6: Do cleanup if attribute validation fails in multipath route

Di Zhu (1):
      i40e: fix use-after-free in i40e_sync_filters_subtask()

Dinh Nguyen (2):
      dt-bindings: spi: cadence-quadspi: document "intel,socfpga-qspi"
      ARM: dts: socfpga: change qspi to "intel,socfpga-qspi"

Eric Dumazet (1):
      sch_qfq: prevent shift-out-of-bounds in qfq_init_qdisc

Evan Quan (1):
      drm/amd/pm: keep the BACO feature enabled for suspend

Florian Fainelli (1):
      Revert "net: phy: fixed_phy: Fix NULL vs IS_ERR() checking in
__fixed_phy_register"

Gagan Kumar (1):
      mctp: Remove only static neighbour on RTM_DELNEIGH

Gregory Fong (1):
      MAINTAINERS: update gpio-brcmstb maintainers

Haimin Zhang (1):
      net ticp:fix a kernel-infoleak in __tipc_sendmsg()

Heiner Kallweit (1):
      reset: renesas: Fix Runtime PM usage

Jedrzej Jagielski (1):
      i40e: Fix incorrect netdev's real number of RX/TX queues

Jianguo Wu (1):
      selftests: net: udpgro_fwd.sh: explicitly checking the available
ping feature

Jiasheng Jiang (1):
      RDMA/uverbs: Check for null return of kmalloc_array

Jiri Olsa (2):
      ftrace/samples: Add missing prototypes direct functions
      perf trace: Avoid early exit due to running SIGCHLD handler
before it makes sense to

Karen Sornek (1):
      iavf: Fix limit of total number of queues to active queues of VF

Len Brown (1):
      Revert "drm/amdgpu: stop scheduler when calling hw_fini (v2)"

Leon Romanovsky (1):
      RDMA/core: Don't infoleak GRH fields

Li Zhijian (1):
      RDMA/rxe: Prevent double freeing rxe_map_set()

Linus L=C3=BCssing (1):
      batman-adv: mcast: don't send link-local multicast to mcast routers

Linus Torvalds (1):
      Linux 5.16

Linus Walleij (1):
      power: supply: core: Break capacity loop

Magnus Karlsson (1):
      Revert "xsk: Do not sleep in poll() when need_wakeup set"

Maor Gottlieb (1):
      Revert "RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow"

Markus Koch (1):
      net/fsl: Remove leftover definition in xgmac_mdio

Martin Habets (1):
      sfc: The RX page_ring is optional

Mateusz Palczewski (2):
      i40e: Fix to not show opcode msg on unsuccessful VF MAC change
      i40e: Fix for displaying message regarding NVM version

Nathan Chancellor (1):
      power: reset: ltc2952: Fix use of floating point literals

Naveen N. Rao (2):
      tracing: Fix check for trace_percpu_buffer validity in get_trace_buf(=
)
      tracing: Tag trace_percpu_buffer as a percpu pointer

Nikita Travkin (1):
      Input: zinitix - make sure the IRQ is allocated before it gets enable=
d

Nikunj A Dadhania (1):
      KVM: x86: Check for rmaps allocation

Pavel Skripkin (2):
      mac80211: mesh: embedd mesh_paths and mpp_paths into ieee80211_if_mes=
h
      ieee802154: atusb: fix uninit value in atusb_set_extended_addr

Phil Elwell (1):
      ARM: dts: gpio-ranges property is now required

Qiuxu Zhuo (1):
      EDAC/i10nm: Release mdev/mbase when failing to detect HBM

Song Liu (1):
      md/raid1: fix missing bitmap update w/o WriteMostly devices

Steven Lee (1):
      gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in irq handler

Taehee Yoo (1):
      selftests: set amt.sh executable

Tejun Heo (6):
      cgroup: Use open-time credentials for process migraton perm checks
      cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
      cgroup: Use open-time cgroup namespace for process migration perm che=
cks
      selftests: cgroup: Make cg_create() use 0755 for permission
instead of 0644
      selftests: cgroup: Test open-time credential usage for migration chec=
ks
      selftests: cgroup: Test open-time cgroup namespace usage for
migration checks

Thomas Toye (1):
      rndis_host: support Hytera digital radios

Tom Rix (1):
      mac80211: initialize variable have_higher_than_11mbit

Wanpeng Li (1):
      KVM: SEV: Mark nested locking of kvm->lock

Wolfram Sang (1):
      Revert "i2c: core: support bus regulator controlling in adapter"

Xin Long (1):
      sctp: hold endpoint before calling cb in sctp_transport_lookup_proces=
s

Yauhen Kharuzhy (1):
      power: bq25890: Enable continuous conversion for ADC at charging
