Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B457E79A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiGVToB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiGVTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:43:58 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AD9C266;
        Fri, 22 Jul 2022 12:43:53 -0700 (PDT)
X-QQ-mid: bizesmtp74t1658519022to35h9sa
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:43:30 +0800 (CST)
X-QQ-SSF: 0100000000200030C000000A0000020
X-QQ-FEAT: v5d6m16HONXNHGd6LaI6M2BNMd1VM1HyIJO+rkMS0zesL6zlvVCy5qcxOHNqw
        NNxkwIuoVTsexRcPopGPy5PsUvtzgOHPRdv6RIZCv2fDWNYu73H0y43cOe2b9cTzFIfGwVX
        0QukgR93vNU9E8LUWH+Y/o7XfqZSMkU/ybyV6XXOTs/ck48IlGy/qB1NBscCV0x+wXegl37
        ALeov1zVZl8xkqYFZjVWcAtU5ykeR+9Hn0nxuKA7dUbeutUNf7NddniskTo7xcswbTnwhM7
        ShIbsrP1A52UBusgOanyeyJ68GwJQ3coiprdLmjQ36UNYiYNLHDrqzZut7AtkSSZnAbzjBE
        XdoYV46Ox+E8+eH2QHPrj/WZdWm2Mr4HC+Qz2foiNiZfKrZ7bo=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] xfs: Fix comment typo
Date:   Sat, 23 Jul 2022 03:43:28 +0800
Message-Id: <20220722194328.18365-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 575, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/xfs/xfs_trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 82cf0189c0db..d055b0938eb9 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -572,7 +572,7 @@ xfs_trans_apply_sb_deltas(
  * xfs_trans_unreserve_and_mod_sb() is called to release unused reservations and
  * apply superblock counter changes to the in-core superblock.  The
  * t_res_fdblocks_delta and t_res_frextents_delta fields are explicitly NOT
- * applied to the in-core superblock.  The idea is that that has already been
+ * applied to the in-core superblock.  The idea is that has already been
  * done.
  *
  * If we are not logging superblock counters, then the inode allocated/free and
-- 
2.30.2

