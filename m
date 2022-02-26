Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062C4C5320
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiBZBqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiBZBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:46:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BE24DED4;
        Fri, 25 Feb 2022 17:45:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E32B961E0E;
        Sat, 26 Feb 2022 01:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A8C340E7;
        Sat, 26 Feb 2022 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645839952;
        bh=DeJ/glawEIhByI9KS72jBTvIlHhNmoRRcqULEJRM5W8=;
        h=From:To:Cc:Subject:Date:From;
        b=ohlHvMUXkd6zPwQlxgVVutQwpW3UAlCnSNqvHPujku1JleXYx1J/ulKR80zgLVkVD
         rHDbsvTVYozJXmCiMcuM0gubfBwZU0knSUu3Uk2mzQbXl+JTQPz+Sq6+i39yiLtZuo
         ccmG9ofowSwI5/kPY6ZxEfUKd84x+eFVUtD3H0Xpg9x6KM9wE/3MX537EH4l9VBkZk
         UAAiYBlZWEnnhME6WMPiKDddMwlEEnFWidqJd9qcdGoZWi4/M2K6Q6GwkYRDfdDdwi
         R9lc8KYHL5rFbLWeCYHvuFP7iNSM8ZXQA8czqkRPtUJoDz39Wvz2DN2Yh5QA2GwLro
         yFauBZAblm79Q==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 25
Date:   Sat, 26 Feb 2022 01:45:48 +0000
Message-Id: <20220226014548.302603-1-broonie@kernel.org>
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

You will be relieved to know that Stephen is due back on Monday.

Changes since 20220224:

The at91 tree gained a build failure, I used the version from yesterday.

The drm tree gained multiple conflicts against the drm-fixes tree.

The drm tree gained a build failure, I used the version from yesterday.

The drm-intel tree gained a conflict against the drm-intel-fixes tree.

The char-misc tree gained a build failure, I used the version from
yesterday.

The extcon tree gained a conflict with the battery tree.

The folio tree gained a conflict with the maple tree.

The execve tree was added.

Non-merge commits (relative to Linus' tree): 8105
 8307 files changed, 918091 insertions(+), 229603 deletions(-)

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

I am currently merging 347 trees (counting Linus' and 93 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
