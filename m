Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A71487FA1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiAGXwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:52:39 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:44730
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231815AbiAGXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:52:28 -0500
Received: from integral2.. (unknown [36.68.70.227])
        by gnuweeb.org (Postfix) with ESMTPSA id 366E2C17A2;
        Fri,  7 Jan 2022 23:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1641599544;
        bh=ca4bX+EcjyR4n5K34jrDY96jKXArWt9Pb9enQ9ZUt30=;
        h=From:To:Cc:Subject:Date:From;
        b=lMaBAnZKc8oFO48pca8fTMa0E7HcYQI2bq5HHBxr75synNX2PmFJc3LU713f6Wu5J
         ti4tCjC4BvGXUgqSdZRc8yj4F7jwMDjynErfWpfs7qRCfVNWQONZeGA+L+b0khUWzZ
         cFFEzts9RR3Y9den/EVbfD9KF4mbtsGwEnvjMUxlU/VYkI4PG/ikTlVzhmIzDkQkUI
         K1ZYRITPUd9q5v3R8jjw1E+A82FWYOZraSDJfn6+wHwGb/KqkJ8rCAzf7z/X74tm1K
         wWFQn0TlWrdaO2ppFPp3QaxsmLvBKIkpWUWELnkGHADkSIh8u62GZ37JT0xMFDKs1w
         sW1Qbzdxq15dw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>
Subject: [PATCH v1 0/3] x86-64 entry documentation and clean up
Date:   Sat,  8 Jan 2022 06:52:07 +0700
Message-Id: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are 3 patches in this series.

1) Trivial clean up in entry_64.S.
2) Add comment about registers on exit in entry_64.S.
3) Add documentation about registers on entry and exit.

(2) and (3) are based on the discussion we had at:

  https://lore.kernel.org/lkml/alpine.LSU.2.20.2110131601000.26294@wotan.suse.de/

This series is based on commit:

  24556728c305886b8bb05bf2ac7e20cf7db3e314 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

Thanks!

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
Ammar Faizi (3):
  x86/entry/64: Clean up spaces after instruction
  x86/entry/64: Add info about registers on exit
  Documentation: x86-64: Document registers on entry and exit

 Documentation/x86/entry_64.rst | 47 ++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S      | 27 ++++++++++++++-----
 2 files changed, 67 insertions(+), 7 deletions(-)


base-commit: 24556728c305886b8bb05bf2ac7e20cf7db3e314
-- 
Ammar Faizi

