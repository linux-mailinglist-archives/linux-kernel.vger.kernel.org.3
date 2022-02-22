Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6732B4BF76A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiBVLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiBVLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:42:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CDE137744;
        Tue, 22 Feb 2022 03:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 924AEB81871;
        Tue, 22 Feb 2022 11:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D28C340E8;
        Tue, 22 Feb 2022 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645530129;
        bh=D2KqbO6eGYgWoVDqwkm8sFaVGoXiE9qbHySLnP8AXg0=;
        h=From:To:Cc:Subject:Date:From;
        b=u+97p9UWGW4VFXXWPnxKX/v62ujsqpa04ERX8+I8KFoLc5/y1pVEnbY0ESQqnlUHa
         pFN7WzcTs6Dv2im2jPQ5KAhb/eC80MKUZAKi5dG0kOOdbjXAMYqokpF3ZiQVW2I8sU
         jmjx9+SkQ8Vs4TkfN2R955r3+bIDK1WSJ1FhQNp3fAYYyOCdZv8R/A4TZmCwZH3TOm
         YG/vnfYZafLNPo7K3qyPprLD7D6a4JTITgget5IoFM9GxczH25dPvFc0lj57lw3CKP
         gzDY5tRn1uzI+gD3wv8wMGnFUXoWaJZDO0WLsWlh9gMpiirL+tkKI/MDXPMp7uaxg8
         ByzcHyB1KkWNw==
From:   broonie@kernel.org
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mips tree with the asm-generic tree
Date:   Tue, 22 Feb 2022 11:42:03 +0000
Message-Id: <20220222114203.686638-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/sibyte/common/sb_tbprof.c

between commit:

  27e8140d7819b ("uaccess: fix type mismatch warnings from access_ok()")

from the asm-generic tree and commit:

  10242464e506b ("MIPS: sibyte: Add missing __user annotations in sb_tbprof.c")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/mips/sibyte/common/sb_tbprof.c
index 01d00b87d0f5a,bc47681e825a3..0000000000000
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c

(used the head version)
