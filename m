Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600E4C06FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiBWBmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiBWBmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:42:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924FF4F9CE;
        Tue, 22 Feb 2022 17:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3575461299;
        Wed, 23 Feb 2022 01:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F9C340E8;
        Wed, 23 Feb 2022 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645580504;
        bh=/cW30QpJUQ5Lg9pkE7CiiZTrKkqZEjIGZ5L2qryw0+w=;
        h=From:To:Cc:Subject:Date:From;
        b=OOAzEvhw8X5IcvMVt4vDWMM9Ho98J168KoT/p0GUWQUA2Lrm+SJQ5h+b+KWsRFHDQ
         +fuDS71Hlq9NNBXwTrYfWGW/EFxumTtIocsLvecf0SCu6US5pkRjva6L1EOrC0kH7F
         s9V6Rn/JLO8lDWkbVzsLrwfn2Qzl7WZ8wMvuz2Xz5Xfii3IUpp5aJn5xOlBqt2cbmL
         Sv0rH6+XY+uKvBJRapaFht/TE9ivzSNONpNuSzFk586QhD6s63+beZI+sJeDh7pdak
         KvWNekGzqzVv93I97maNkcnbHnoV8niZmRkyvTQUHm9Hlcry+ISIFo4yUq/K+fqRAS
         kSW7lkzg/N+AQ==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        akpm@linux-foundation.org
Subject: linux-next: Tree for Feb 22
Date:   Wed, 23 Feb 2022 01:41:35 +0000
Message-Id: <20220223014135.2764641-1-broonie@kernel.org>
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

Note that today's -next does not include the akpm tree since it's been a
long day and the conflicts seemed more than it was wise for me to
attempt at this point.  I'll have another go tomorrow but no guarantees.

Changes since 20220217:

The mips tree gained a conflict with the asm-generic tree.

The nds32 tree gained a conflict with the kbuild tree.

The drm tree gained a conflict with the drm-intel-fixes tree.

The modules tree gained a build failure, I used the version from
20220217.

The kvm tree gained a conflict with the kvm-fixes tree.

The iio tree gained a conflcit with the char-misc.current tree.

The sysctl tree gained a conflict with the tip tree.

The maple tree gained a conflict against the parisc tree.

The maple tree gained a conflict against the memblock tree.

The maple tree gained a build failure so I used the version from
20220217.

The akpm tree was dropped.

Non-merge commits (relative to Linus' tree): 6779
 7408 files changed, 823378 insertions(+), 211667 deletions(-)

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
