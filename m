Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748EE513097
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiD1KF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiD1KF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:05:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EE06A072;
        Thu, 28 Apr 2022 02:50:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:50:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651139446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amI3erXdt1Xv23VT11iPF4AsfDkiPeSSWj4s2lUQsjo=;
        b=p3N41ujw5RH74qFPNSz9lXYvgJN4H8y4wsu+G5zPr0PvBBKkKGmquu7UgajGiH0Ne5TupU
        rMMIndCCuwjZnUN50EGr7gGzZspJ48HcHwk2ODwP24P+AcCvTzgrpxYb+8C4sNVebQlRxg
        wZCMFf5e/drAtZbyr5OxR7QZ/d6RsrAm8F7G3tz0k7nbDw1q2P+2pYHmS9zNoyfIlc3N5l
        KBAvtkhXC1ygK80mx+DJeVlP1t20zq7TY8qZJuITVjg9JAchXdWEGZ2o91fpMgLwD8m8l8
        n7tMxE4Yd4lL6SD5MbmjXAW+UJk9rnHZECQX2xgdOGN42BzseX0FNTw83UN13A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651139446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amI3erXdt1Xv23VT11iPF4AsfDkiPeSSWj4s2lUQsjo=;
        b=evAc7t+BNdoZVnfhbgvPKQlXitk+Zkws83gsYFbK6DUNowTdBmCYwDOViplOLWAz7STxCk
        /cvKM2HXn7G7BRAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/speculation: Add missing prototype for
 unpriv_ebpf_notify()
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
References: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165113944536.4207.8430547828762066325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2147c438fde135d6c145a96e373d9348e7076f7f
Gitweb:        https://git.kernel.org/tip/2147c438fde135d6c145a96e373d9348e70=
76f7f
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 25 Apr 2022 16:40:02 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Apr 2022 11:12:17 +02:00

x86/speculation: Add missing prototype for unpriv_ebpf_notify()

Fix the following warnings seen with "make W=3D1":

  kernel/sysctl.c:183:13: warning: no previous prototype for =E2=80=98unpriv_=
ebpf_notify=E2=80=99 [-Wmissing-prototypes]
    183 | void __weak unpriv_ebpf_notify(int new_state)
        |             ^~~~~~~~~~~~~~~~~~

  arch/x86/kernel/cpu/bugs.c:659:6: warning: no previous prototype for =E2=80=
=98unpriv_ebpf_notify=E2=80=99 [-Wmissing-prototypes]
    659 | void unpriv_ebpf_notify(int new_state)
        |      ^~~~~~~~~~~~~~~~~~

Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status in Sp=
ectre v2 mitigation reporting")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/5689d065f739602ececaee1e05e68b8644009608.1650=
930000.git.jpoimboe@redhat.com
---
 include/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298..ecc3d3e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2085,6 +2085,8 @@ void bpf_offload_dev_netdev_unregister(struct bpf_offlo=
ad_dev *offdev,
 				       struct net_device *netdev);
 bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev);
=20
+void unpriv_ebpf_notify(int new_state);
+
 #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
 int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr);
=20
