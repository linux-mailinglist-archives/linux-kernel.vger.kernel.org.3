Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0A5961BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiHPSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiHPSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:00:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345638284C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:00:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h8so8421700qvs.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GYxezpsc09PkMg1yRZL6Qrt9K3TjB/V6kS8MJoiT59E=;
        b=Axt9l35MzkACLBrGkfzvprvs2Owh/z7HYRcR7XfTbhXuu84pCwAB2fIpRvlwwlGi1W
         cw7R9Cx/UZ4PAZXtVrcQEbNd4BKQMsvegIQZP4muprBfv/jywBTAmWv6Vzumx17Bjc/I
         z6BqCSYGwfcES/yfqezjRary7Z47VMYlQHjoYkjscTjwkOqaYxTltHbE/OyhEokdfAXS
         5xZ2UmJZPBjV8rpOcubDtgDBNWdStjm46GnjD0LJDr9ONzg2pygwzHiqgXB2gVb7mM4Y
         +zKiK6ntnx09vW1vC+dHCRyf+0JYzF1fKRJ5ZMIjAX0jXPZ7vT6UFW32CKdNGgSBeeaR
         Jmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GYxezpsc09PkMg1yRZL6Qrt9K3TjB/V6kS8MJoiT59E=;
        b=3wOaI+d6cAaMPhfJzz7Z8q2g1KUfjXlu33QeWCfMY1mHc19Il0Lb4z+KocKeRmQsy3
         5dZ27JboXa88GYTxuLipu31+iKO5t+LVIzx+MCVI39hWsKwhSMKEeEIYs+qXVKQcRT27
         Qf24jG78ROAEm7NPS8xZoZFFOeRivvkIkF/hrVHGflI173dI7jZPwKnHPv4cAGmhoqrL
         r/iWQi7ta+9VxnKiyo9iFawaOfKLci5stxmIV8oYXlfy/Er6diTztdao/aiq5VA4FrlA
         1ii4mnBNSlEYoHsxDA8hN25hMTGCAkMzOl+M5ZGuNuyrqjppVgSKW+co/5hPoTZ4tOdV
         DECQ==
X-Gm-Message-State: ACgBeo284DHyVW+nkeMolMZtZp20IrYavQVtFXVEULyzQ+7Bhntcyu6W
        He1j1OW/xmhMrnEByIM9/MCmWvIVHtm2fw==
X-Google-Smtp-Source: AA6agR6eOHlHzAKCTUoJyzxwdEiIcodoi2/BTF8ITfd35MOwEJR9OQ1F05B4YWSnM1XcpAI2/D6thw==
X-Received: by 2002:a17:902:ec91:b0:16f:176f:ec98 with SMTP id x17-20020a170902ec9100b0016f176fec98mr22045569plg.141.1660672806609;
        Tue, 16 Aug 2022 11:00:06 -0700 (PDT)
Received: from fedora.. ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id js20-20020a17090b149400b001faaafcdaa0sm516249pjb.31.2022.08.16.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:00:06 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH v2 linux-next] Remove Unnecessary TODO
Date:   Tue, 16 Aug 2022 23:59:54 +0600
Message-Id: <20220816175954.5259-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The capabilities enabled for multi-link are required as part of the
programming sequences, even when a stream uses a single link we still
use the syncArm/syncGo sequences. Therefore the TODO is no longer
necessary.

Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Previous discussions:
- v1 Link: https://lore.kernel.org/lkml/20220814080416.7531-1-khalid.masum.92@gmail.com/

Changes since v1:
- Remove the todo, leave rest of the code as is
- Update commit message

 drivers/soundwire/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8d4000664fa3..18158825a6d8 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -75,7 +75,6 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 
 	/*
 	 * Initialize multi_link flag
-	 * TODO: populate this flag by reading property from FW node
 	 */
 	bus->multi_link = false;
 	if (bus->ops->read_prop) {
-- 
2.37.1

