Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84315994DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbiHSFv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHSFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:51:25 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FBBD4E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:51:21 -0700 (PDT)
Date:   Fri, 19 Aug 2022 05:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1660888276; x=1661147476;
        bh=cz10ipUno8dD1+pM5LF8YqsHsL6C1fEdrMtk+bGlqNg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=A72YWD2c7K2rv8qx0B1eu3fm+yFSUNfI1ypCP0JNTAbsuJwm/KFGfFq8x4LoZ8+J2
         mbMMvICfRXRCRtsg3RW8ySZB8emnUiRhpNoGeL/dMYYrnx19ChZg70PB7dZu2f6Nr8
         aOk0fLzTZpuscZZCCm29nqeVBjrB1OfgJclv/9hMWHabEEfxRBE3a3My+F1A+dbz4L
         LWFKfZ1qrQn8J4wXwj3ZPp8Jnh4oOEWx/b5WbbJwJul2EVjbzDlntm7a3Y7BPR2aj4
         S83xsLD4iLNLLcPMa4TY2Vo3+mfoIGweZbIMQITQATSeUU5ipfEF8becWY59cl6tDC
         zBHCDD5wQqENQ==
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
From:   Juerg Haefliger <juergh@proton.me>
Cc:     linux-kernel@vger.kernel.org, Juerg Haefliger <juergh@proton.me>
Reply-To: Juerg Haefliger <juergh@proton.me>
Subject: [PATCH] MAINTAINERS: Update Juerg Haefliger's email address
Message-ID: <20220819055039.840221-1-juergh@proton.me>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my main @proton.me email address.

Signed-off-by: Juerg Haefliger <juergh@proton.me>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..d7efa940dc37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6178,7 +6178,7 @@ F:=09Documentation/devicetree/bindings/memory-control=
lers/samsung,exynos5422-dmc.y
 F:=09drivers/memory/samsung/exynos5422-dmc.c

 DME1737 HARDWARE MONITOR DRIVER
-M:=09Juerg Haefliger <juergh@gmail.com>
+M:=09Juerg Haefliger <juergh@proton.me>
 L:=09linux-hwmon@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/hwmon/dme1737.rst
@@ -21784,7 +21784,7 @@ F:=09lib/test_scanf.c
 F:=09lib/vsprintf.c

 VT1211 HARDWARE MONITOR DRIVER
-M:=09Juerg Haefliger <juergh@gmail.com>
+M:=09Juerg Haefliger <juergh@proton.me>
 L:=09linux-hwmon@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/hwmon/vt1211.rst
--
2.34.1


