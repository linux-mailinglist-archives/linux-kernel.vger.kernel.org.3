Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A8470CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbhLJVmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:42:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbhLJVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:42:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863A0B829D9;
        Fri, 10 Dec 2021 21:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC50C00446;
        Fri, 10 Dec 2021 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639172346;
        bh=rj5x0Sq4Sly57XgOOudF+v3IUpCpLwyJ7UWVTgXoc7w=;
        h=From:To:Cc:Subject:Date:From;
        b=Ggudwh3MfNW9dl11dGAOCLLBzZ7RMg+BK2DwYqT9KUv/S8AISGDQHotQgfVj0K2oL
         UhFBE6tyPuJb3h4j0cz3G/vFdlnOZrLDQu1yK637vXQW7j8Sk4mc2eMOqEKofRDFkp
         NFc5fAF4THCnEqcXujqrra34oerfloON7ydTENtjP8MSBOaQNKZin8Udeg8EVqGwqV
         kAeOb3AGiYEzxjmCx5Z0lW35+l7j9qwSwX2jobmmGd9+DKP0UYk9JUFcZPWUJ63Wp7
         /lLMq84xy5QH+7kZjXx8Vqmp/yd310asDBacr4PXlciclTPs2OaW5mXshqYhJvjJsN
         r8HWIjLzyFuVg==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 10
Date:   Fri, 10 Dec 2021 21:39:00 +0000
Message-Id: <20211210213900.3474100-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20211208:

The kvm tree gained a conflict with the perf tree.

The kvm-arm tree gained a conflict with the kvm tree.

The bpf tree gained a conflict with the ndevdev tree.

The nvdimm tree gained a conflict with the ext4 tree and was dropped for
today.

The rust tree gained a conflict with Linus' tree.

The bitmap tree gained a conflict with the kvm tree.

The akpm-current tree gained a conflict with the folio tree.

Non-merge commits (relative to Linus' tree): 5746
 6195 files changed, 260341 insertions(+), 117230 deletions(-)

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
with an arm64 defconfig, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After the
final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, arm64 allnoconfig and allyesconfig, and
i386, arm64, sparc and sparc64 defconfig and htmldocs.

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
