Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FF5A2558
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbiHZKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbiHZKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:20 -0400
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EDDD5996
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 6CBAF3D3B098
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508073;
        bh=XOpWOzVHbQqn5UQdIbMGAIlVue4aBavc/v1XQOqP2Hw=;
        h=From:To:Cc:Subject:Date;
        b=qpRHk9VZz0OXMTm16Oh6Q448koV5rejWCZlnIkx2X/89mpggqFaWQhmEBmM5+k4Om
         Y4ZplO48T4pVr50lfxlP2hU+o505g3+nohib94/FVCruKzE9CppF0+9T8yl66kOD6l
         +8x9OQJRV9Uh4i4SjKxqtnfZ6bzS2U7BjflhA2Zg=
Received: from fx302 (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 758D23D3B085;
        Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <15a98.630899e7.5f823.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx302.security-mail.net (Postfix) with ESMTPS id B5BD13D3B0F4;
        Fri, 26 Aug 2022 12:01:11 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 34C3027E02FA;
        Fri, 26 Aug 2022 12:01:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 1D88B27E0392;
        Fri, 26 Aug 2022 12:01:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1D88B27E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508070;
        bh=/B4H62Ql/fDwYtt6B8yJ3OwEAw90E0dg2l8SOHFyVvs=;
        h=From:To:Date:Message-Id;
        b=CyNhI6+2VZ9JfcVEz45N82yM1dz/yv3QOuU58YrHGo/fOF0pveyr42o/GQS6cYgIz
         kpjMgGf2pBiZL3yL0YDe3n5Dvo+sUh7EUMYt2dFDLQSiV1Bai49YCLRVpUkdfBLhes
         H+liVsCkOcihIEhCIDXiKADuvTaKPujzLCA5XU5Q=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uYRkkLsCIhy2; Fri, 26 Aug 2022 12:01:10 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 0DEA627E02FA;
        Fri, 26 Aug 2022 12:01:10 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>, ecryptfs@vger.kernel.org
Subject: [PATCH] fs/ecryptfs: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:37 +0200
Message-Id: <20220826100052.22945-9-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: ecryptfs@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..2452d6fd7062 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
  * @filename: This function kmalloc's the memory for the filename
  * @filename_size: This function sets this to the amount of memory
  *                 kmalloc'd for the filename
- * @packet_size: This function sets this to the the number of octets
+ * @packet_size: This function sets this to the number of octets
  *               in the packet parsed
  * @mount_crypt_stat: The mount-wide cryptographic context
  * @data: The memory location containing the start of the tag 70
-- 
2.17.1

