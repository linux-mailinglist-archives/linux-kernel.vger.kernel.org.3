Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3A4C214E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiBXBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBXBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:45:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653813C9D7;
        Wed, 23 Feb 2022 17:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69013B81FCD;
        Thu, 24 Feb 2022 01:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC0CC340E7;
        Thu, 24 Feb 2022 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645667084;
        bh=XHH/uO/8KeWnauMtq/0M/7XsURJLAWgKWhTDuS/j7PU=;
        h=From:To:Cc:Subject:Date:From;
        b=DJ5uOTxE695TQwqvHCCjvBDx1V9zfQteuN6RqddIxwLzmtMtU0YQF/Hbkg//oY47S
         xDTaqE9t1p2533ns/ODCeWx1Yf+G9SergWl28ujncQdNY8B5VjGvbGMYaaSB2oM6ra
         yDW7APgEakixM3iUJbsBFGDH4TKZj9nMls4vF2YHZylU9E4L91Ju4jvzwRJfkMl5ke
         Uiy0wihAareamqkPNxn0XZgpxhwTQbIsA22QZl/QQyGt4S5K1fOFXuKX/l/L4+RhOE
         m3oaJQvnoVZLcS4t5jOOiXg+GEMe+jpgfOqxBVogydXmG4FWlUtgCaSyb7WDYce+co
         WjICUFmHg6BKg==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 23
Date:   Thu, 24 Feb 2022 01:44:40 +0000
Message-Id: <20220224014440.1397777-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Note that today's -next again does not include the akpm tree since it's
been a long day and the conflicts especially with the mm code seemed
more than it was wise for me to attempt.  I'll have another go tomorrow
but no guarantees, I got further today.

Changes since 20220222:

The drm-intel tree gained a conflict with the drm-intel-fixes tree.

The drm-tegra tree gained a conflict with the drm tree.

The mfd tree gained a build failure, I used the version from yesterday
instead.

The kvm tree gained a conflict with the kvm-fixes tree.

The nvmem tree gained a conflict with the spi tree.

The nvmem tree gained a conflict with the char-misc tree.

I applied a fix for the build failure in the maple tree so merged
today's version.

The folio tree gained several conflicts with the maple tree.

Non-merge commits (relative to Linus' tree): 7020
 7614 files changed, 874525 insertions(+), 213969 deletions(-)

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

I am currently merging 346 trees (counting Linus' and 93 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
