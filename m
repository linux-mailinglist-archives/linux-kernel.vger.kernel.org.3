Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBC57B4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiGTK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiGTK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:59:09 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84FAE6873B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g7SS5
        IapVntYfeZqhOj7pG0qBPKSykUjDGdGCPqAULM=; b=pzK4iaATkPcZjU7FmERpL
        kHH+WEUB0jcZZuiOnFJMhoLOYeG2jSyVyp6Wlw7zdB2+v/zmEAxRegHLh8laZHo1
        VBV3WdYNe3o5/bNWdUHAfVaUKPZ1nhF6tiDk3MwkzDCgGqPHaM966q5/8sN1SKKf
        pFRriAPl2pSfyKwHvnsuU8=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp2 (Coremail) with SMTP id GtxpCgBn1ejz39diZxDBQA--.1645S2;
        Wed, 20 Jul 2022 18:59:01 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     gregkh@linuxfoundation.org, mchehab+huawei@kernel.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ABI: testing: Fix typo in comment
Date:   Wed, 20 Jul 2022 18:58:55 +0800
Message-Id: <20220720105855.16467-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBn1ejz39diZxDBQA--.1645S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4UWr47XFWDCFy5Xry7ZFb_yoW5ZrW8p3
        40yrnrK3s3Gry7Wr1xAFy8KFWxCr1Ika1rJrs5Wry0vw1qv3W0kFW7tr4rCFnxCrW5uayf
        uFySyryfZF1UuwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pipuWkUUUUU=
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxVEZFWB0iS4PQAAst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/ABI/testing/sysfs-class-rtrs-client         | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server         | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
 Documentation/ABI/testing/sysfs-devices-power             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:
 
 		Reads also cause the AC alarm timer status to be reset.
 
-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.
 
 		If the status return value indicates that the timer has expired,
diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.
 
-- 
2.25.1

