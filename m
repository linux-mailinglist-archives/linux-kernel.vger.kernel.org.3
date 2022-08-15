Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE56059335D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiHOQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHOQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D94E15A1D;
        Mon, 15 Aug 2022 09:38:53 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:38:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660581531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mR5aJQ+ixxsJdwz7JgkYzGq5xOEhb41JS1FsLgQyQ7Y=;
        b=p/DiDaPBxR25FVxGwb7RXWphq1km+ECP9R/m7DkL6oWDWbBDsbznk0dSUKUiSo7bMbTJMH
        DOzg3dPa1OBaO3YWmcs9IaCHaAv6njvdsCQgx8NSAVpiBeC3Ny4mgaVymIMHBuZ4TRcpfB
        852poxW5KSlitEr9cEMoIJ12+LWVGsxEKgfHxS2ztKeZYm990lQDcYwN5vK/4cg/HfL3Lh
        uaec01I6xBGim33832soNDj9UVHrkGhja5Fh3GFIwK9vRBkD2tmVeat7aYF4NUS51Bpnxe
        5QT0lpU7CmTqpHZfLONxSElFdvWpmW5NqPxBZcKVzthSW4xYebYiBeDrs7H0bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660581531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mR5aJQ+ixxsJdwz7JgkYzGq5xOEhb41JS1FsLgQyQ7Y=;
        b=9aS82H7rJwi/cDwUA0j0Yo6s0bp0WfrN0tI17b9JKuSLroeAb3QlWIFkYRPzTpdgAcGj+a
        8sqDJe5o4eYGJBDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.0-rc1-rt1
Message-ID: <Yvp2mbetlsy6+PGo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.0-rc1-rt1 patch set. 

Changes since v5.19-rt10:

  - Rebase to v6.0-rc1

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0-rc1-rt1

The RT patch against v6.0-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0-rc1-rt1.tar.xz

Sebastian
