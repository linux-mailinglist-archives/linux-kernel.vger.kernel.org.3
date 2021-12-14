Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CE473B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhLNDCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLNDCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:02:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A2C061574;
        Mon, 13 Dec 2021 19:02:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F88EB815B8;
        Tue, 14 Dec 2021 03:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315DCC34603;
        Tue, 14 Dec 2021 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639450939;
        bh=HRVA4L6EH/KF8FO0x/gNMH5vDkhOCikRbawIeH2EJRI=;
        h=From:To:Cc:Subject:Date:From;
        b=o1VSquNf8EbGIBEyckGDLSlncdukveopZ1wyuwoqBcJQiR7quuWHj9+/6WwzkcYEe
         QXjoB8iEmTcgR5msxONmK1Q3kx26IFKlZ2UHyKy37KRX2R4STkcj9mQXtJDwLlQ9GT
         DCnc8l6qGy9r4dpgLolGIBkJsKhht5SrpSnEnhjdBLmjunmi1e9cmwMRypeAAa7t0m
         fyL3+iFrQl3SNFKMDtsSGhQcgTNqQ4ySwKy+PoKqwJkn9SAPw5MsI8jhyl3ISfdFgR
         D77MhyDTcD5p5TnP+/uyTQMQ0f4Mb03ggu1rSrhRPfQNJLxkDorxDv2yxkVeYiwzyO
         kJe70czuvnfrw==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 13
Date:   Tue, 14 Dec 2021 03:02:15 +0000
Message-Id: <20211214030215.3181149-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Non-merge commits (relative to Linus' tree): 5960
 6555 files changed, 277265 insertions(+), 120864 deletions(-)

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
multi_v7_defconfig for arm and a native build of tools/perf.

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
