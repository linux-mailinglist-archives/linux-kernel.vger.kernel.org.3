Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B6589200
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiHCSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHCSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85319010;
        Wed,  3 Aug 2022 11:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1271561208;
        Wed,  3 Aug 2022 18:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D3C433C1;
        Wed,  3 Aug 2022 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659549758;
        bh=u/+RUZfjafvvpTieoAYWceYF/JHA231PECwkQjuH+vs=;
        h=From:To:Cc:Subject:Date:From;
        b=R3YFfPJFlRVXrYrkT9X8Xo24hy1w3vJYkXXg0wWHWn25IFVLNkRoGC99JDbq6Lvu1
         BfI3kHaqJ/FIicNnpaHJUpr3zmMtGIoxPDh/Q7BD3m7oJqKvTYxJmjYHvUA7Vfu/fE
         +0ZoBI0kDfrT6l8JHd51WzGbKuu9u9PRiOayIjZBS/Cfs8Sp4RUtVjXBjYCc7ByN53
         cLXST7PF20GxsZuVhuyUq4zyj1MGJ6JpregAAuh48Xm1aJAHYJNJLsxjcGwU6Abjms
         YhcOWPz9A+Ce6PXnOhQfayb3FKaxshwTxZSeZfKh6osCDqj1pbCClGfv5cBi4Ap0Wz
         PfHTkfmwAYFgg==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 3
Date:   Wed,  3 Aug 2022 19:02:25 +0100
Message-Id: <20220803180225.773206-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20220802:

The overlayfs tree gained a conflict with Linus' tree.

The vfs tree gained a conflict with Linus' tree.

The build failure in the thermal tree was fixed and replaced by a new build
failure so the tree for 20220728 is still being used.

Non-merge commits (relative to Linus' tree): 10626
 10534 files changed, 1225685 insertions(+), 240213 deletions(-)

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
with an arm64 defconfig, an allmodconfig cross build for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf.

Below is a summary of the state of the merge.

I am currently merging 357 trees (counting Linus' and 98 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
