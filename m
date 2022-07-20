Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB857B4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiGTKyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbiGTKyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:54:04 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E2026C128
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9X/4L
        hLJkOSj9G88Fq5yEf3kcRtloR2/7db2xlNEo8g=; b=WrNQ2dLt29HwqQ8l5fF+o
        Tbrkv1mzRBvhprbytR+DNwOSXcrzoJ5q89/ggnx8PQHzkTE/EAkHdNxJWBFEWzJ6
        TE1meGzhw/IZRIod1V3UNadHI67pRGYVuHYFEY/nfw2r+TEOiGy9RL3F2vvKRLGY
        44zdOXH1dz3TcMpAG3Jaqc=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp1 (Coremail) with SMTP id GdxpCgBnopao3tdi9o6FPQ--.1264S2;
        Wed, 20 Jul 2022 18:53:30 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ABI: stable/sysfs-module: Fix typo in comment
Date:   Wed, 20 Jul 2022 18:53:26 +0800
Message-Id: <20220720105326.16121-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBnopao3tdi9o6FPQ--.1264S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr47Gr1UWrWfCw1DZr4rGrg_yoW3JrcEvr
        4UtFZYk34UJ345JF4kAws8AFyI9a1fGFs0krs5CFyqqw15twsruF98XrZ5Ar13Wrs29r1f
        WrZ2yFy5WanFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_PEfDUUUUU==
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQpEZFyPdlTZYQAAs6
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
 Documentation/ABI/stable/sysfs-module | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.25.1

