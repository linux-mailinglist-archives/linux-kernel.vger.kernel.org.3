Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538CA58D383
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiHIGDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiHIGDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:03:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F973881
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:03:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so15624962lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 23:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r4WChPeKtlUBFlqVIMjwDEzyqjUVTlCJwCQhmpiRSlI=;
        b=CTZ8Cm99ro+l0d2wD105NVLay92a6R/lxBoRP4gel4OvzJaZiS+CZmHRKWnz1qZVwk
         EG0/QqDjc9bXXQO2s0jxDE8QUzHuUx9ELLQAg0v8g522a5IQmzFgMj/IdKDyAcbwSSGy
         RwutNDfisSLtKF2ccOIkX0ds6rWBJoMi8IVmmKDIKAbXpUbHPIaNJ6tQBGA+U+OiHdZ0
         hrERxa7a9U4dQ2US9rHGwkGb4PnjgIpsb7HYnz5idZF+5CG1SPeehWtXMGMQEdS9k91v
         lwrliXdP98oXuKI/GOIHN6yQJl+2WbBV2EmqA63Oq8ip9rkW5Hk6TGMa9dClrMZnDabt
         7vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r4WChPeKtlUBFlqVIMjwDEzyqjUVTlCJwCQhmpiRSlI=;
        b=HDiARnhIKbJ8sAkGE535cQ2mGnj/s5cQOormc86iytMP+jbwa8+BWhqHhEtpbfvSnB
         Q1R5aqerhUdRICuIU7VrSyBhOXw1S4UGhXmbSmgLgfYjZwWJDZAlDB3GDbfhxJiDHQ7n
         t35aEmRVPCew8qrm+R0UtXD/z4syC0NiQPZBPAb+RZq3Km7GqhqWyUDs7r48/+agM9zO
         w6D+yLA60+OQEi9W7OgXhhnc30VIbHoTMrPh4v4kqy09EygPRjgSlaq6TFI2H2SITmBY
         On+WP4fTpwCXXPZoGi3x8IqAXAfAyXAfqq6qKBIMWb5P/G5ZhKJr9kMjOHHXPUMxo/5P
         Jcyw==
X-Gm-Message-State: ACgBeo1vbBo9VoRaajFkRBIuDfxG8Ko+25GdayqgskqqJIeIutZb2WVb
        GXtxKkjKlT5ZZbfybE+h/d2Aw+G8FzA=
X-Google-Smtp-Source: AA6agR4QSOZ88TawVoqTxJhe9ymYJ712errQBK+ASEp2Wqidt7mgZyr3a+nTzORE3bj54IGPr4Bjpg==
X-Received: by 2002:a05:6512:b90:b0:48b:3651:6c30 with SMTP id b16-20020a0565120b9000b0048b36516c30mr8169249lfv.328.1660025025531;
        Mon, 08 Aug 2022 23:03:45 -0700 (PDT)
Received: from grinn221.grinn-global.com ([95.143.241.142])
        by smtp.gmail.com with ESMTPSA id s23-20020a056512203700b0047255d211adsm1635446lfs.220.2022.08.08.23.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 23:03:45 -0700 (PDT)
From:   "=?UTF-8?q?Micha=C5=82=20Oleszczyk?=" <oleszczyk.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Micha=C5=82=20Oleszczyk?= <m.oleszczyk@grinn-global.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Oleszczyk?= <m.oleszczyk@grinn-global.com>,
        Michal Oleszczyk <oleszczyk.m@gmail.com>
Subject: [PATCH v2] mfd: core: Delete corresponding OF node entries from list on  MFD removal
Date:   Tue,  9 Aug 2022 08:03:36 +0200
Message-Id: <20220809060336.31892-1-m.oleszczyk@grinn-global.com>
X-Mailer: git-send-email 2.20.1
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

From: Michal Oleszczyk <oleszczyk.m@gmail.com>

When we consider MFD which implements hotplug (e.g. USB hotplug
driver based on product and vendor IDs) functionality it turns out
that its sub-devices are correctly matched with corresponding device
tree nodes only at the first time. When physical device reboots
or is replugged (and MFD driver is disconnected and probed back
again) all sub-devices fails in mfd_add_device() with error
'Failed to locate of_node'.

The reason of that behavior is that when any MFD sub-device is
created for the first time (and matched with device tree node) it
is added to the mfd_of_node_list. It looks like this list is never
cleaned even if devices added there are intentionally removed from
the system. So when MFD device is replugged and all sub-devices
are matched with their device tree nodes again they fail as matched
nodes already exist in mfd_of_node_list. In other words current
implementation does not support MFD with hotplug feature.

This commit extends MFD core for hotplugging support by removing
appropriate OF node entry from mfd_of_node_list when corresponding
device is removed from the system. Thanks to that when device is
added once again it can be matched with its device tree node
successfully.

Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
---

Changes in v2: removing unused variable declaration.

 drivers/mfd/mfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 684a011a6396..a9646a03ca8d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -351,6 +351,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 {
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
+	struct mfd_of_node_entry *of_entry, *tmp;
 	int *level = data;
 
 	if (dev->type != &mfd_dev_type)
@@ -365,6 +366,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 
+	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+		if (of_entry->dev == &pdev->dev) {
+			list_del(&of_entry->list);
+			kfree(of_entry);
+		}
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-- 
2.20.1

