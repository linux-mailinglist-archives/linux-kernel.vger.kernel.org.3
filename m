Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A50A5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiDUQ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDUQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:10:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC447541;
        Thu, 21 Apr 2022 09:07:55 -0700 (PDT)
Date:   Thu, 21 Apr 2022 18:07:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650557273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=K14QTM7Qe+PKqSGcrLG7jOzYp3yn8ozz6G/LoWNfiyc=;
        b=JUA6dHEJm3WZyKKktnpAyxcAqobaMl08V0hDiBfciCFoUfwe1jPmDFiVrx7QfXQDMCRc6f
        jdxE6uDh6ZvSTjIW4FE4O1pjHjP4pQMkt/SSbp1HeclEyWVEWfAG1uU0RPxegrS4P4zcg9
        eLYSfIDIV9mIKK7OLeDDD5Tz48EvUHdc97mTrg0r6gy7KLFKuPYZYobbnauyENilQvvtyA
        wPcDwu3clBssqlgzOpEVscM7m1ImjIPJBelG49x12/paOgiymFmGNFwpOm45SNVQ+hZ4tJ
        MwuJhN8CRrtBa7lkJNsangSxMbAhdtf+joXQLIF1FO6ZV/IgXWGqiMtZ6BjpHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650557273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=K14QTM7Qe+PKqSGcrLG7jOzYp3yn8ozz6G/LoWNfiyc=;
        b=k68WP7D8eVaPd0RnakYM6Medmw/sl7gr/TCpP+ZXibP350SD9mtpEiqCzWktttbdNPSZ+F
        7V/NTmtP7qGzXTDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rc3-rt1
Message-ID: <YmGBVzuZLRVNs3C2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.18-rc3-rt1 patch set. 

Changes since v5.17.1-rt17:

  - Rebase to v5.18-rc3.

  - Update John's printk series to v3.

  - Include v5 of "smp: Make softirq handling RT friendly" as posted by
    Thomas Gleixner.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rc3-rt1

The RT patch against v5.18-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rc3-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rc3-rt1.tar.xz

Sebastian
