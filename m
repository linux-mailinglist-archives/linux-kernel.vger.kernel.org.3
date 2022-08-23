Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990A59D1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiHWHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiHWHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:10:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952361B0D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p13so659392pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=En29KNYOM5bn+2RlGr+4Bbrav0QZmmNk4w8B8GT3lnk=;
        b=lFGt6oUTvy/bOoNFGabf262wdXzHqQWR7duFeh8JnGpCbgIHoWgmIrTxRrJ0CP9izZ
         PFTaxLDNiVianamkWS62VPVUwqufHKCZLIzW4or5Vgy/fhsDPV1kOYt7H3djxxGOUjKh
         Q8g54eYoX8894jVI1Hb/X0gOTxOXoyDsvyMWFTE2BT0VnTl+a9LVbpdIg2+HXzk/sBRV
         1HS2+P0n4KLm29hK30u1bss8x4J0L4rKr9UTer2rxmlRcAB5hoa/AUAz24S2yfTVpcYy
         SuI03XNcpMqgGwPhO9WSm18tUEWguCLee4ToqFbczcFIaGNtPVePk1FmrrRNrDyhy0M0
         95Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=En29KNYOM5bn+2RlGr+4Bbrav0QZmmNk4w8B8GT3lnk=;
        b=saKfB72jgg4AiR+ExFrqoQ82LOmkCG3z0pA6UFlt6ksngEGsdTStHqvzv7wBcKsKym
         6a0l8cnAIZqKSc49qWuu2qDZ5urjogkMxS5xmQIZgWMs1V8q3jPbhBI/1xTdYayieWIH
         xlYh3qJjh+j0caTlqv1eMC0rnH5c5QacxeUuEfk1JhC/MrzIC//7tbOt9vY+lsYkg3lr
         rmDDTanKoanknTPKJevDhzkLJtXFyXHqRE2HCAs/k/h55Ts/fiV9AR0P80hQocCSRr5D
         XjQv5+wpOY0wyBgsJLWOdifyhG4PwFMIeqqAluo3aGvHXPa/y92zTpREQ6agF7eyyDcQ
         XmmQ==
X-Gm-Message-State: ACgBeo2JWUsR9TiBOM/XB9fpx6NJer3pfvDXdNAIYVxwWGhkh8hRaMOo
        P9cg2hIJ4aEta0cbheYhOsltBdFaLaQ=
X-Google-Smtp-Source: AA6agR6vw/YQou/C2a+Wa6319ffL+L0Dm1JALXJ6LXPYMphfgix4ML25PWRG4konP8DQzQgVuxRqug==
X-Received: by 2002:a17:902:ebc9:b0:172:951d:fc9c with SMTP id p9-20020a170902ebc900b00172951dfc9cmr23123287plg.97.1661238610444;
        Tue, 23 Aug 2022 00:10:10 -0700 (PDT)
Received: from localhost.localdomain (121-200-9-125.79c809.mel.nbn.aussiebb.net. [121.200.9.125])
        by smtp.gmail.com with ESMTPSA id 22-20020a630d56000000b0041c66a66d41sm8506773pgn.45.2022.08.23.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:10:10 -0700 (PDT)
From:   Daniel Tobias <dan.g.tob@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Tobias <dan.g.tob@gmail.com>, satishkh@cisco.com,
        jejb@linux.ibm.com, trivial@kernel.org
Subject: [PATCH 2/3] scsi: fix typo debugsfs -> debugfs
Date:   Tue, 23 Aug 2022 17:08:38 +1000
Message-Id: <20220823070839.533562-3-dan.g.tob@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823070839.533562-1-dan.g.tob@gmail.com>
References: <20220823070839.533562-1-dan.g.tob@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Tobias <dan.g.tob@gmail.com>
---
 drivers/scsi/fnic/fnic_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 6fedc3b7d1ab..16fb05c8f347 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -425,7 +425,7 @@ void fnic_fc_trace_debugfs_terminate(void)
  * @file: The file pointer to attach the stats reset flag.
  *
  * Description:
- * This routine opens a debugsfs file reset_stats and stores i_private data
+ * This routine opens a debugfs file reset_stats and stores i_private data
  * to debug structure to retrieve later for while performing other
  * file oprations.
  *
@@ -569,7 +569,7 @@ static int fnic_reset_stats_release(struct inode *inode,
  * @file: The file pointer to attach the specific host statistics.
  *
  * Description:
- * This routine opens a debugsfs file stats of specific host and print
+ * This routine opens a debugfs file stats of specific host and print
  * fnic stats.
  *
  * Returns:
-- 
2.37.2

