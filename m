Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA294611D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhK2KMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbhK2KJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6415DC0698CD;
        Mon, 29 Nov 2021 01:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E521B80E75;
        Mon, 29 Nov 2021 09:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B6C53FD3;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179277;
        bh=cvDcFaDZVEW1u/gAhNbQDP9i1EmPWvMAVO+rzVJt8UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDA1Q9rsnDrm+hHvttboWsJuGAPuy/3d9fyfQ23IueJVZbr+aMpCOqklJt3U+ORoK
         t1pIY4Rg1GwFFFV/Uaa7XIDE4Wq1WaMA2TOoM+xz6CRYjGoHzZYsj7Lbqq7PotdSSt
         bWUq0GoNdKaTuy3SW5bsyqQFEH8mzpCQzPmhyo2RFATHGSg2n5tpqLX+6NH1UGnIhU
         iqCJ6t9+iL0/zADu5LeVTsmhL4vYZv0l9TgAin5nPbpJ+8MmuQrJHmdD0uTwlSC0cV
         czb3TDNao9phOiHV3T4t3vQH8l6OXXXhAwpVTS8EUInQme+bL+orlxiv2o/IG5UVl8
         S67L0j8X/zr+w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBu-SX; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 16/20] media: davinci: vpbe_osd: mark read reg function as __always_unused
Date:   Mon, 29 Nov 2021 10:47:48 +0100
Message-Id: <0c086fea0d3f0771f6c8627e99edb719e282a49c.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such function is currently unused, but could be needed in the
future. So, keep it, marking it as __always_unused, in order to
avoid a clang W=1 error.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/platform/davinci/vpbe_osd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/davinci/vpbe_osd.c
index 91b571a0ac2c..32f7ef547c82 100644
--- a/drivers/media/platform/davinci/vpbe_osd.c
+++ b/drivers/media/platform/davinci/vpbe_osd.c
@@ -45,7 +45,7 @@ static const struct platform_device_id vpbe_osd_devtype[] = {
 MODULE_DEVICE_TABLE(platform, vpbe_osd_devtype);
 
 /* register access routines */
-static inline u32 osd_read(struct osd_state *sd, u32 offset)
+static inline u32 __always_unused osd_read(struct osd_state *sd, u32 offset)
 {
 	struct osd_state *osd = sd;
 
-- 
2.33.1

