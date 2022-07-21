Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9697957C214
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGUCHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGUCHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:07:07 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E47E5252A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XU12i
        H4pMl40EXW/nX9VVQCNZUvF291SzJYyAXnNGu0=; b=RdCgMdCT4MSQbawt/xjUe
        soFmfpQZ6NNQ1dvDXDJ2Dq3u8u7+BzMk8L9GZh+9pwsnvv1rxpcsGsuUYjBY1n9z
        ve/vWlpjN05Ms9C1Y4lJ1aQWOYXXOqSHHvdspDkhF3G0sFkZZ3ReF0XOc+DMuLWJ
        2ljuR4zkqsnDj9zxp0u2F4=
Received: from localhost.localdomain (unknown [223.104.68.243])
        by smtp14 (Coremail) with SMTP id EsCowADn7wejtNhiY2DFOA--.245S2;
        Thu, 21 Jul 2022 10:06:29 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     gregkh@linuxfoundation.org, mchehab+huawei@kernel.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] docs: ABI: Fix typo in comment
Date:   Thu, 21 Jul 2022 10:06:23 +0800
Message-Id: <20220721020623.20974-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADn7wejtNhiY2DFOA--.245S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4UWr47XFyDCFWDAFWUArb_yoWrGFyUp3
        40yrnFgwn3Gry7Xr1xAFykKF1xCr4xCw4rJrs5Wry0v34qv3W0kFW7tr4ruFnxArWruayr
        uFySyryfAF4j9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUI388UUUUU=
X-Originating-IP: [223.104.68.243]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQVFZGBbEaukXAAAso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Add all changes in ABI into 1 single patch
---
 Documentation/ABI/stable/sysfs-module                     | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client         | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server         | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD | 2 +-
 Documentation/ABI/testing/sysfs-devices-power             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.
 
 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
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

