Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E384AC8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiBGSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiBGShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:37:07 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0FC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:37:06 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 14155 invoked from network); 7 Feb 2022 19:30:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1644258624; bh=0zcWeXpNBSlcuXMbQhaTETW+jrEMSoXxc604ZA0rADo=;
          h=From:To:Cc:Subject;
          b=sgTJpZL9tCTwz5VZBHCYJTe3YBWx9kesDr5AhR6YtNIgLkbojjvCd84A82nH0cC/u
           JppxomjhUStAkwEk3U9JcASLh2JEAFLzF3qVRP26S2oosl2YhgjbmSj47hS36C6m0/
           or/z7qTaOu4PV0HrDRQoNHdjNrz1aRpSOgtM0cVs=
Received: from aaem217.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.116.217])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 7 Feb 2022 19:30:24 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH 2/2] dell-smm-hwmon: rewrite CONFIG_I8K description
Date:   Mon,  7 Feb 2022 19:29:40 +0100
Message-Id: <20220207182940.242838-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207182940.242838-1-mat.jonczyk@o2.pl>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 798211090e6a0b49c177a6c4c0db5bbb
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UYMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not the laptops, but the /proc/i8k interface that is legacy. The
old description was confusing, fix this.

I'm not a native English speaker, so I'd like that someone proofread
this description.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Pali Rohár <pali@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
---
 drivers/hwmon/Kconfig | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dd244aa747ad..8f9f41a9ef70 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -506,18 +506,17 @@ config SENSORS_DELL_SMM
 	  userspace interface for i8kutils package.
 
 config I8K
-	bool "Dell i8k legacy laptop support"
+	bool "Legacy /proc/i8k interface of Dell laptop SMM BIOS hwmon driver"
 	depends on SENSORS_DELL_SMM
 	help
-	  This option enables legacy /proc/i8k userspace interface in hwmon
-	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
-	  temperature and allows controlling fan speeds of Dell laptops via
-	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
-	  it reports also power and hotkey status. For fan speed control is
-	  needed userspace package i8kutils.
+	  This option enables the legacy /proc/i8k userspace interface of the
+	  dell-smm-hwmon driver. The character file /proc/i8k exposes the BIOS
+	  version, temperatures and allows control of fan speeds of some Dell
+	  laptops. Sometimes, it reports also power and hotkey status.
 
-	  Say Y if you intend to run this kernel on old Dell laptops or want to
-	  use userspace package i8kutils.
+	  This interface is required to run programs from the i8kutils package.
+
+	  Say Y if you intend to run userspace programs that use this interface.
 	  Say N otherwise.
 
 config SENSORS_DA9052_ADC
-- 
2.25.1

