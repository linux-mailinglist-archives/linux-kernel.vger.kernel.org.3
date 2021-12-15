Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD4847657E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhLOWQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:16:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36996 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLOWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:16:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE6261B16;
        Wed, 15 Dec 2021 22:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55837C36AE3;
        Wed, 15 Dec 2021 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639606583;
        bh=1hSjeBr9VK09A920ZiCqpUGXz/tcRcEu0B3NSFSN9Sg=;
        h=From:To:Cc:Subject:Date:From;
        b=VzvfjufzjFK5OQlfhq7RCUUT8gtWoFrpXlWOciHQRyIxO3kO27skF7qJ1kp+Alzvb
         Doj1QNkm96LgEmNwVcgEqojrhR9s/qNj0NawAjtkU4WX3Re1nykPtiKV7m5Ds1hwDh
         dHfu1sgdbCn3pXeCr2aftkjBeY3wtatDf5mAhj6Jjup6D8lf6CEs/5bOjvVHocdmvB
         K0Gf3DiUc8VeZHTCxEyenTKzCO9P2W0lBsReLGnbWisl4tgkoRbQFTfoFBZDGQcutN
         103eA4jQiRtfoBEG6JoxAEYxq6t2Fop3ZsEOqDs8TKWDYGq7NqchQNQ52bx1WTHhnS
         fujEzQaNL6KsQ==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 15
Date:   Wed, 15 Dec 2021 22:16:19 +0000
Message-Id: <20211215221619.822904-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

News: I had a vaccine dose today so no guarantees about releases at
least tomorrow depending on side effects.

Changes since 20211214:

The kvm tree gained a conflict.

The phy-next tree gained a build failure and I used the version from
yesterday.

Non-merge commits (relative to Linus' tree): 6683
 7239 files changed, 321081 insertions(+), 155400 deletions(-)

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

I am currently merging 347 trees (counting Linus' and 94 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
