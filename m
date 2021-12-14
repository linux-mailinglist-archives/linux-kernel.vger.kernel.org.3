Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBE474DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhLNWci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:32:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48070 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLNWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 588C5B81B3A;
        Tue, 14 Dec 2021 22:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56323C34605;
        Tue, 14 Dec 2021 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639521155;
        bh=M2HKluCE/kZx1ZzHL6O3FUtbfbX2HVGF4UavWiNkRvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fn+37mqzSWa25v23lcVXr9iuHNGQpe/1G7xxQBV6OEx+Dj7WC5yNcG+kGWwO+B0J9
         NAT/OYo1GbSfY1HmzMHR2PX7Av1j0Zl4pDvWLBxpiFXXGfXiG0vMNm4j1o3+v7WtZj
         pEmYE6BH9fhF2rcFNbIE54HVKswtYTZ1Lyj+3w+ypip0MbmATDCLNuyGltI40CUkKO
         Af59SzbMlI169T69Sahk7Zv0XoljZ3i0H9aMBjQW6AQyJf36ZJ/veqoqPLQiHkM7K7
         KT+qYgsOWHKU62x+X+ZXd57HDidp1+KiQyvQCO+gdkJbB/LYwE2K2hZ0ReUF2Rs1WR
         BbMIf2C0Q1yQA==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 14
Date:   Tue, 14 Dec 2021 22:32:22 +0000
Message-Id: <20211214223228.1745315-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

News: Releases may or may not happen over the next few days since I'm
getting a vacciene dose tomorrow.

Changes since 20211213:

The drm-intel tree gained a conflict with the drm-intel-fixes tree.

The dmaengine tree gained a conflict with the dmaengine-fixes tree.

Non-merge commits (relative to Linus' tree): 6251
 6873 files changed, 291130 insertions(+), 138903 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a defconfig for arm64, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After the
final fixups (if any), I do an x86_64 modules_install followed by builds
for x86_64 allnoconfig, arm64 allnoconfig, arm64 allyesconfig and i386,
and arm64 and htmldocs.

Below is a summary of the state of the merge.

I am currently merging 346 trees (counting Linus' and 94 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
