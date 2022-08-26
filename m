Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A55A254D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiHZKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbiHZKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:20 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD61A6C10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 3A5143ACE9E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508075;
        bh=AHZn9X4lEZeD4sEl/aav+f8s4shU6qaXDqSZTpV22Hk=;
        h=From:To:Cc:Subject:Date;
        b=eO7Z/2/u4g73UlUBWWy9ly/XOcQZhBuBN6LNYjgFXL8hwcgkMH/SxfFSdEJWZAjXu
         m7q17n3PTVaIRxSLae2kzYSEOxwyC8N9ngCKOStBvGLzQkVX+6hcCYEvAyD6msL27z
         lRMalv+CTQ0HCJLCOX2RV3snRznhORzHCg0NXjDo=
Received: from fx601 (localhost [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id CC8943ACC57;
        Fri, 26 Aug 2022 12:01:14 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <61e0.630899e9.d31de.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx601.security-mail.net (Postfix) with ESMTPS id D73913ACE19;
        Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id B544427E02FA;
        Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 9DB4927E0392;
        Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9DB4927E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508073;
        bh=YXD6MxjcXIsKPE6/xq6L97v82v78azRYLfFeM8nubaQ=;
        h=From:To:Date:Message-Id;
        b=QGGol3GvpjpinSaxyUcEiPmia+1kfMXyxIfns3BXB3k/cIPdP3iV5NmxNrg6Qb2l2
         niN4o7CbweXnbRB3u6gVuoJ5AANr1IcW0Czsq9pk3HjoWwWEFtlNOEcsjJpe3kRaJF
         /vDgg7q4ggCbxGHKtCGzbAnFqK5X4Zh4S6WdwOCM=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q7nyrsxYmrQJ; Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 8CF7527E02FA;
        Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>, linux-s390@vger.kernel.org
Subject: [PATCH] s390: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:40 +0200
Message-Id: <20220826100052.22945-12-jmaselbas@kalray.eu>
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

CC: linux-s390@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 arch/s390/kernel/sthyi.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..0fda19b1e21d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event *event, u64 count)
  * combined-sampling data entry consists of a basic- and a diagnostic-sampling
  * data entry.	The sampling function is determined by the flags in the perf
  * event hardware structure.  The function always works with a combined-sampling
- * data entry but ignores the the diagnostic portion if it is not available.
+ * data entry but ignores the diagnostic portion if it is not available.
  *
  * Note that the implementation focuses on basic-sampling data entries and, if
  * such an entry is not valid, the entire combined-sampling data entry is
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |= MAC_CNT_VLD;
 }
 
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
-- 
2.17.1

