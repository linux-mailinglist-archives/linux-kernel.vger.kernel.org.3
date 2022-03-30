Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DDB4EC951
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbiC3QKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348617AbiC3QKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:10:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC51D0FA;
        Wed, 30 Mar 2022 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648656484;
        bh=eyZgoSOXBgiY7IogFE1g9ozYUMFErfGzTyG1DhV1kkY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=P5R+TUQXTBR5ZCq5q4HQJgGqqqXy95xx0yWYvvjiEXxb1IoYII3Vsw2os0viT82VJ
         IlVaN1aWaxdevY0iJmoc6+YB+HkYMUF3eQP956IaVeHocoZfE93WpXQNW1BUJqsd1J
         0aB4gFT3fyxbAii6w1AQlbe9kfmYVY7lDjuSvfPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.163.139]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1nZKHT3P31-0023Lm; Wed, 30
 Mar 2022 18:08:04 +0200
Date:   Wed, 30 Mar 2022 18:08:02 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture updates for v5.18-rc1 - part 2
Message-ID: <YkSAYq2dExCq1TcP@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:MbVWdF/mQgvKGKlOMFlTd9dekYyXQSvHMFQhLCksPoJI1ugbOr3
 n1lfwy+jWdULLkT2hKaGclODh0OpeW6kDtZ/IFMLu8czFJ/fN1Hkkn603tPT/Iyr2JAjnIL
 2NVmZrUrSHUI4F2OF9/292PY1Q1LMjoMHYwu+HqzXIZInobQ0TZMp4SHhMMn6fPJ9YTwUu8
 1KU9YSJTHeElju21FzSvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e381kNrS15c=:VZUO+9WCVHeJFzsWc6ssxd
 w51nALGlBlEFiW+c0ZsabN6qXGFKqftVpiwvnz0AaqrYjN9XrAKi/OnBoffEt8eDdYRCHsC06
 6kQjSRba2HC8t0G53zBARFTv6hVLwDyCO+YjXd3yzOnimLP0MXqjuKd96JFUQA9qVvIGkgD00
 XkuABS+QQPcmnBMytKYYOli3D9ZNQrlrr+lzFg9Gp4v/+iet6IRqZw1gkdP3w61IIzpZu2mWy
 zTZOUkJk4khai6iIssNV1cEv0IY3TE8oLeBmmyki59cAOnDo9lBU5PTeUnUtW01MtEPXWdgnk
 DOFvNRWRk7aHY3yaCQNXN7sZpWJu8ZMPsfTlvBdKUlFSxR3ncPDPFYmLOEO0FcWoXwzdWIAQu
 tM5dg8r/U53FJ8n6PruWdjA5MqdCmHG7WePM4udqRW2asqv58xmxV6cQgzOhdjF39IJ2zbytj
 BNmwsAWAgq/9sJeIEXDwP5Z1Xd6ARkWn/BBGA0AKS0Jj5k73ordXs5caAfl2uktcKzIL50k6/
 MS1rWguLjkcfnP6Gs7C3HQqk9DY/I/L5C3UGk9Uz+jwHkUHUpiO4wKxTkVYi4FWJmRlVtbiRo
 XA5W3A3fGGUNFVYmt+SGDXHNkWbpcGril1LN2EEeD6jWHkz34Ip4tIJr0jlSjsfuftImfUHo8
 wVA8l+UBtGqYP3al81VUQBtXCKj/JAVBHMTPPFszLYGR57wYQEd11KpTowLCVXVHm/E8oB59c
 X1oDgkFKV5n7ZTQ2hIF9m9B/McIeo5Ztt9Pwt6XitB3pH+DZfK8XOs9+gDEgz8WKmcTsNlwJu
 n7WkQOfh/61zJUqW+OfvGxaA28lzlR8weLLuaHVCU2Qta60+z/YIBwhwP41V8UuDQIWjIT1ye
 4HkbB9T7Pov6a2VPrneS77NYXp3rcLglSHGVNtm4M28RbQ5hIdRiuyeQQuEwHSTHTZ3yDe2dA
 0sJlSxTWy0MJqol6Oj85clHN1d3Di3+N97yjTGn2uowMK1p4imewyO+O254WLtno7UP6+qWcU
 vkrUfOBERGZJDVUYEGJtUPnloWHuS03LC7Wn0JZ8Y9gIe+ZZi2X6Clfo742xFI3qK+ad0rlWP
 8VvcqWFYC9nhqo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae085d7f9365de7da27ab5c0d16b12d51ea7fca9:

  mm: kfence: fix missing objcg housekeeping for SLAB (2022-03-27 18:47:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-2

for you to fetch changes up to a9fe7fa7d874a536e0540469f314772c054a0323:

  parisc: Fix patch code locking and flushing (2022-03-29 21:37:13 +0200)

----------------------------------------------------------------
More parisc architecture updates & fixes for kernel v5.18-rc1

* Revert a patch to the invalidate/flush vmap routines which broke kernel
  patching functions on older PA-RISC machines.

* Fix the kernel patching code wrt. locking and flushing. Works now on
  B160L machine as well.

* Fix CPU IRQ affinity for LASI, WAX and Dino chips

* CPU hotplug support

* Detect the hppa-suse-linux-gcc compiler when cross-compiling

----------------------------------------------------------------
Helge Deller (15):
      Revert "parisc: Fix invalidate/flush vmap routines"
      parisc: Fix CPU affinity for Lasi, WAX and Dino chips
      parisc: Clean up cpu_check_affinity() and drop cpu_set_affinity_irq()
      parisc: Detect hppa-suse-linux-gcc compiler for cross-building
      parisc: Add constants for control registers and clean up mfctl()
      parisc: Ensure set_firmware_width() is called only once
      parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY
      parisc: Move store_cpu_topology() into text section
      parisc: Move CPU startup-related functions into .text section
      parisc: Move disable_sr_hashing_asm() into .text section
      parisc: Add PDC locking functions for rendezvous code
      parisc: Implement __cpu_die() and __cpu_disable() for CPU hotplugging
      parisc: Rewrite arch_cpu_idle_dead() for CPU hotplugging
      parisc: Move common_stext into .text section when CONFIG_HOTPLUG_CPU=y
      parisc: Find a new timesync master if current CPU is removed

John David Anglin (1):
      parisc: Fix patch code locking and flushing

 arch/parisc/Kconfig                     |  12 +---
 arch/parisc/Makefile                    |   4 +-
 arch/parisc/include/asm/pdc.h           |   3 +
 arch/parisc/include/asm/pdcpat.h        |   3 +-
 arch/parisc/include/asm/processor.h     |   1 +
 arch/parisc/include/asm/smp.h           |   9 +--
 arch/parisc/include/asm/special_insns.h |  17 +++--
 arch/parisc/include/asm/topology.h      |  23 +------
 arch/parisc/kernel/Makefile             |   2 +-
 arch/parisc/kernel/cache.c              |  26 ++------
 arch/parisc/kernel/firmware.c           |  44 ++++++++++++-
 arch/parisc/kernel/head.S               |  11 +++-
 arch/parisc/kernel/irq.c                |  25 +-------
 arch/parisc/kernel/pacache.S            |   2 +-
 arch/parisc/kernel/patch.c              |  25 ++++----
 arch/parisc/kernel/process.c            |  27 +++++++-
 arch/parisc/kernel/processor.c          |   6 +-
 arch/parisc/kernel/smp.c                | 108 +++++++++++++++++++++++++++-----
 arch/parisc/kernel/time.c               |   6 +-
 arch/parisc/kernel/topology.c           |  77 ++++++-----------------
 drivers/parisc/dino.c                   |  41 +++++++++---
 drivers/parisc/gsc.c                    |  31 +++++++++
 drivers/parisc/gsc.h                    |   1 +
 drivers/parisc/lasi.c                   |   7 +--
 drivers/parisc/wax.c                    |   7 +--
 25 files changed, 312 insertions(+), 206 deletions(-)
