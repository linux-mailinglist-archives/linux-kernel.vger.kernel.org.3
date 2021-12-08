Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55B046DC93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhLHUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhLHUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:03:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718ACC061746;
        Wed,  8 Dec 2021 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1ugDHIUqZ4JmdO1FYqmR7ZCGEMv+2r483moMKywYTH4=; b=JxVv58Afhp/FrAIzoVvHXjAwVp
        q7uAnNc4iVe/udpBGLV0v0FqyyH4sq5jc/mipGFbjk04q2G8sHVI9GGPfN5fyjPnekvrvUsCI8CDG
        E+1gOqeGUEOR0/4hM+lIe9vtJhwrbd5xdTBHRtccSaoEmWpfg+RA+ys7HjFSvMTVy9CJhEVaAy/GE
        pJIxdIspSDtunzd+B/PFFpLk4NjCzW6Ios8eRNcD9TzgGz9FXlmMhbAYnXxxhF2Ve063fvXjaFZTS
        tJTsVf7hbuLIFmawqBgHrgqBLsz7jfsx7b7s+rL9VqmL1JON9ZLxp1+4GG1kyjNMxRGXRk9BEb2Ec
        TIvjFvAA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv36D-00E8Zb-43; Wed, 08 Dec 2021 19:59:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        mcgrof@kernel.org, jeyu@kernel.org, mcgrof@bombadil.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Next/Trees: update the modules tree
Date:   Wed,  8 Dec 2021 11:59:31 -0800
Message-Id: <20211208195931.3369500-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon Jessica's request I'm helping with modules maintenance
so this patch reflect this and updates the trees to mine. For
the last v5.16 merge window I have already sent my first
pull request which was merged for v5.16-rc1. I'll queue up fixes
on the modules_linus branch.

I'm now queuing up changes for the next release and so will be putting
those in the modules_next branch to match parity with the same style
used by Jessica.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Next/Trees | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Next/Trees b/Next/Trees
index 1348af7fdb0f..620898543919 100644
--- a/Next/Trees
+++ b/Next/Trees
@@ -46,7 +46,7 @@ input-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#f
 crypto-current	git	git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git#master
 vfio-fixes	git	git://github.com/awilliam/linux-vfio.git#for-linus
 kselftest-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git#fixes
-modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git#modules-linus
+modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-linus
 dmaengine-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git#fixes
 backlight-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-backlight-fixes
 mtd-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#mtd/fixes
@@ -231,7 +231,7 @@ etnaviv		git	https://git.pengutronix.de/git/lst/linux#etnaviv/next
 regmap		git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git#for-next
 sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git#for-next
 sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#for-next
-modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git#modules-next
+modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-next
 input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git#next
 block		git	git://git.kernel.dk/linux-block.git#for-next
 device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git#for-next
-- 
2.33.0

