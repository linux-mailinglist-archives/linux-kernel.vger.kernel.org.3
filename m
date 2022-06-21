Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671FA552BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbiFUHXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFUHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:13:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC046173
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:13:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso12840469pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hte8AP5nf1klbLq0oX8P2OsV4GT1ocQRuako+1trRU=;
        b=fzvK6c8GO0RLY8JbxALi6mEmafO8JYM5kkDguilRdW9XCKXROvhiKo+fMipCoEEKL7
         7U437VKxQkc68UGRWGa9UOhdr9TyApgDzp1sZ68ZjoT6GpnUYdijlpSzwSFgXOA8s5JE
         IJqZlyITmjOOBr1JOkWjOPb/5y9xC34S4bgz1Ez0S9KDlJTlYKyfMhD8xiKh5TwmssSq
         h6OWwDmobUnlUbM3hzLX24d6eqb666iCQJnPRDl9ZOsVDsL6FOKc6Bv7u1eo8miJKAGq
         1GA4XThl1pymDU6ot2DjLqlTQGS9lryj2ASa53PLHI6RD5ZPS9xyjRyzIjBTH9jOnw8E
         WW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hte8AP5nf1klbLq0oX8P2OsV4GT1ocQRuako+1trRU=;
        b=HBVJPhqQZmx6MgDuHP7K39x8lRAUO88Ljg7ua8geFLjURamFOmK4BijvodYaFfebTn
         BL9mxKw7oCapiQ02iwEh+JdDtzJDItpyMSLgcMKh7Ox5trlavN9iQWW5ao+DK/S/tmZy
         2ff3tWMmavdxQVYCu8uM+CMGNw3be4fFkTYiw+h/5tgzN+WLIVykOce71xJ1ocYNLZNh
         7B9rc2FNF8cjkJv9Jd/CdcdAFaufCSoy+B6Qz4e4RDgABoGoCV/3mFT4OUw2ZZKoBLFv
         1EXVJON4Nr6cKxBIjweRYMHYjcCO8HZOq9RgE0+86AY3FrY04Yh/SLs7l/41VadBpUWD
         AAVw==
X-Gm-Message-State: AJIora+CrNjjS7rljYlV0K14gDYfhPVjRb6GgtQctc6RECzXkii1rOO8
        sr4UOTwNdHP1/4KMF9iKimZrzwDxsS05RnwN
X-Google-Smtp-Source: AGRyM1sowog3TGzznepPSpPDlmdgPlk3Xw00kqu9HSCjnpSysKBPoHHNxtLp9WxjGqu195sNzA4u+A==
X-Received: by 2002:a17:902:7248:b0:167:95e2:f83c with SMTP id c8-20020a170902724800b0016795e2f83cmr27826774pll.74.1655795591658;
        Tue, 21 Jun 2022 00:13:11 -0700 (PDT)
Received: from longfanaikebuke.Dlink (36-236-237-46.dynamic-ip.hinet.net. [36.236.237.46])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b005251c3e7ac5sm4375310pfu.166.2022.06.21.00.13.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 00:13:11 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     agk@redhat.com
Cc:     snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Steven Lung <1030steven@gmail.com>
Subject: [PATCH] dm cache: fix typo
Date:   Tue, 21 Jun 2022 15:12:59 +0800
Message-Id: <20220621071259.4008-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace neccessarily with necessarily.

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 drivers/md/dm-cache-metadata.h | 2 +-
 drivers/md/dm-cache-target.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.h b/drivers/md/dm-cache-metadata.h
index 179ed5bf8..0905f2c16 100644
--- a/drivers/md/dm-cache-metadata.h
+++ b/drivers/md/dm-cache-metadata.h
@@ -131,7 +131,7 @@ void dm_cache_dump(struct dm_cache_metadata *cmd);
  * hints will be lost.
  *
  * The hints are indexed by the cblock, but many policies will not
- * neccessarily have a fast way of accessing efficiently via cblock.  So
+ * necessarily have a fast way of accessing efficiently via cblock.  So
  * rather than querying the policy for each cblock, we let it walk its data
  * structures and fill in the hints in whatever order it wishes.
  */
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 28c5de8ec..54a8d5c9a 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2775,7 +2775,7 @@ static int load_mapping(void *context, dm_oblock_t oblock, dm_cblock_t cblock,
 
 /*
  * The discard block size in the on disk metadata is not
- * neccessarily the same as we're currently using.  So we have to
+ * necessarily the same as we're currently using.  So we have to
  * be careful to only set the discarded attribute if we know it
  * covers a complete block of the new size.
  */
-- 
2.35.1

