Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798E44C3B84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiBYCQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiBYCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:16:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC226275799;
        Thu, 24 Feb 2022 18:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B2960FFA;
        Fri, 25 Feb 2022 02:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396CBC340E9;
        Fri, 25 Feb 2022 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645755366;
        bh=6voC2Z9JQQqhcZTaQgEzY/6rEPqj9sJDyUQALUUcRnA=;
        h=From:To:Cc:Subject:Date:From;
        b=ISPiUX2fs7qPBUQrchQV0+kHefRo7qr4hPxHy0cNaL5V7dZh7H5l5SUN/cKPBHKBG
         OX/RqjCzibfiy/6a1jKf/LLyXlEah4z37+v41wNQ5YW6zwTzvN1UkpsFN0Ssb3l5gQ
         ArlTY2GGp4mwn3q3R3HhJ0+S0ykrpY4RIC/jik2Zp3kXkG78TqxNrrgWd+NjOAYAKA
         Qb0J8hiE/CP+kb6k8USypiAuee1OpH2XXTBX6Ku51yRgloRWnyKhgi6OzUUztveg5v
         CTqETlIP+Oow0Uy3Yw5O0DAtu4ywgtFAehW28/lbvb5rHEtWeLstcHRk1YCVPPJm6y
         LyDPuNu3NF0nA==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 24
Date:   Fri, 25 Feb 2022 02:16:03 +0000
Message-Id: <20220225021603.1960898-1-broonie@kernel.org>
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

Changes since 20220223:

The btrfs tree gained several conflicts with the btrfs-fixes tree.

The net-next tree gained conflicts with the net tree.

The drm tree gained conflicts against the drm-fixes tree.

The drm tree gained a conflict with the drm-intel-gt tree.

The akpm tree was updated and merged, thanks to Andrew for his help with
this.

Non-merge commits (relative to Linus' tree): 7842
 8121 files changed, 894334 insertions(+), 225439 deletions(-)

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
