Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF65440FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiFIBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFIBT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:19:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590596355
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:19:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j6so19756867pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCXY1rhj4g31vz+NjF0VZ/JPyBEqV1WHyHzZOp4wgvw=;
        b=bsxfaE3FCpBRPVBEmw/3kUUEGVjUx585asDSWngPjF3ueGFxh64v/wqBwscwkw+14M
         UbSPLetz7A7Ma3KlOnQB+xYBP3/vY2woLCViGxbQppASW1cosBT5HnLb5ZdIhGfY/bzg
         TPn1DYxY2diyBDSGzSyMhacCR+WmPpri+btLWSr1GguvdAto9XOdKW5O3FWcBrxS1VtT
         gIU3O2oJilzyp154ltbIviCl8ydyzjPgztDuUVvhCxXzCIMa63ddKErLsDPptRXwQjWc
         ZGwWRJCzIGc7+Kam4V7RvgH3MGiVA8vJH5uPfILVek0C4xk0SXQdcwLYJTPAMH/zyq8N
         4Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCXY1rhj4g31vz+NjF0VZ/JPyBEqV1WHyHzZOp4wgvw=;
        b=MBcOJlG5EjApdn9wSCODJeRZY3Hp7Lk56S21R32vfo9mhu+JBGbZbhyNq7cE4OEK6O
         2kPS27YJgG6cVnV+60AER8V2ZgMZA74xIj1fJRNgzi+fjg9EGMyYYJr316IKNMDh+OFS
         K4Yg3JbU2yQCqiDKRyCiRT6Xi7ZpCQyl9yN5CMX2S7HUB3dpnmo8Jgs+CTYLindIHnFZ
         5FfmmD6n7ISlwdCI+WYIq/7mLrU3U4s5kLMSe45zeQhF2y45zJSih3Su0zFjaRIRpTDR
         WF8Md2NpRi3qKKGTmOmHyTlpboGUY5y4aJ1JrMTgY18obFIVD1Uj68OlgdDvoeY6DCEs
         DosQ==
X-Gm-Message-State: AOAM531M77Wm6igv9HJskc9urq74zjdymggqyyYmRxa43XP3S32K+z1K
        vRlWJfukuUmLr9OKWZhvKxPcIiFuL6VR20z8yo+MJg==
X-Google-Smtp-Source: ABdhPJyXvTK2zcvGkTVvxwueEIUztuz3658ykbIdOrK0OVEgXtAxRxvC3+HfCDRX2jGDSfJvsDeeyg==
X-Received: by 2002:a05:6a00:244e:b0:51b:3a93:b888 with SMTP id d14-20020a056a00244e00b0051b3a93b888mr37300112pfj.39.1654737597759;
        Wed, 08 Jun 2022 18:19:57 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b00163d6164889sm15412906plb.236.2022.06.08.18.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 18:19:55 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     jk@ozlabs.org, joel@jms.id.au
Cc:     alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>
Subject: [PATCH -next] fsi: Fix typo in comment
Date:   Thu,  9 Jun 2022 09:19:48 +0800
Message-Id: <20220609011948.53706-1-937225041@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Xueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>
---
 drivers/fsi/fsi-master.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index cd6bee5e12a7..4762315a46ba 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -51,7 +51,7 @@
 #define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
 #define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
 
-/* MRESB: Reset brindge */
+/* MRESB: Reset bridge */
 #define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
 #define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
 
-- 
2.25.1

