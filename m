Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1409B469FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391826AbhLFPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388956AbhLFPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:35:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A382C09B18F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:20:50 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eBUTJfSYTohYJrigB87qpawZTrkhnOrjrQMyd+1Fhwk=;
        b=eZhwLxSP0xjHaMsmjzLmKUFhWGkGcU+lY49u+slmdMBVa+B0yQeSb0014cmr+9hLtaYxW0
        LITXrzJUUAolVmD0pv6AunfmcFoB6/h5I9tYVNgMUzYyFFUDI3AVfMF9n53HXYCS58ovlj
        HBeuhzlOx/59V1aUzWeEGcArXrZyHafIH1BEASzggpKSMKI6GyHZnHVid8Tnd9aidotcaZ
        nUiTVJByJwlV6FPuPPkjkD0yBQr1siMsmnEobJHOCt9o70Amkq43iDz7+v8bmdu51IlxCL
        ATYKYRa9JqOJXMUwMwbDyxtmzJw0ZVVn+K2ayBGtNZ51tEvg6tsNwmaZO5PMhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eBUTJfSYTohYJrigB87qpawZTrkhnOrjrQMyd+1Fhwk=;
        b=puPYMI4UmCOWYPLU0RULgaRZC/m0aDW6qv/I9YVdjynxikd2Cgh4EdqYAy0l1xOJHZ0zmi
        Obr7NxW+CZS4qpCw==
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2 v2] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
Date:   Mon,  6 Dec 2021 16:20:32 +0100
Message-Id: <20211206152034.2150770-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the previous patch (#2) and adding Boris
(Ostrovsky)'s suggestion regarding the XEN bits.
The previous post can be found at
   https://lore.kernel.org/all/20211122154714.xaoxok3fpk5bgznz@linutronix.d=
e/

Sebastian


