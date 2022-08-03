Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251CC588540
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHCBDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:03:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3AF51A20;
        Tue,  2 Aug 2022 18:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBFCFB810B0;
        Wed,  3 Aug 2022 01:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC8CC433D6;
        Wed,  3 Aug 2022 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659488611;
        bh=7w4Dyur9noVacYI2xbunChed9UXqfXV8yWPOuwSLVxA=;
        h=From:To:Cc:Subject:Date:From;
        b=URLI4lCs7bA3y7gBpj+H/jt63+bXnxw8biWjJZVACABO26BtY+6AB/MwzRvzVaKCk
         utX9SgA0xvvQJ4SDpXidd8UTTufkyHFMBWvk6viLX/sMLra1z/JMYYvVltq/fjkzpW
         NDPIubeRTmF5COl27UpqVnx4MgSA4NtKXkA0QJgSIW6a/7JJ3oLcoDaPV/j9VR3uX5
         nb1orxtMcjMD9gOb8NKW57emnk+HR9/mQHScfRLNfPkhICXYVAa7vv3JMwDDSxZO/D
         3+Vz8ffAdYWDmBVt5a0l9z0r79Oq5Vi/7PP/P6ADvvzSEeahBMxpGnMXsODyHXrO8N
         7C6E1hF5NLt8A==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 2
Date:   Wed,  3 Aug 2022 02:03:26 +0100
Message-Id: <20220803010326.2814276-1-broonie@kernel.org>
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

Changes since 20220728:

The hid tree gained a build failure which I fixed up.

The thermal tree gained a build failure, I used the version from 20220728
instead.

The net-next tree gained a conflict against the net tree.

The kvm tree gained a conflict with the kvms390-fixes tree.

The pinctrl tree gained a build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 12734
 12594 files changed, 1319236 insertions(+), 278745 deletions(-)

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
with an arm64 defconfig, an allmodconfig build for x86_64, a
multi_v7_defconfig for arm and a native (arm64) build of tools/perf.

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
