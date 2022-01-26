Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49F49D560
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiAZWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiAZWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:22:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE5C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:22:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 133so645060pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRwhL1NPkbRdnv8DYdCIqNEvEwK08/NeYumLy6TnqFI=;
        b=GejB6uj8tAaqSUfWeYhJQ+YhhcQNMDVdWsrOd2KteNyszjDIibMmICgjVI0tdBPxHz
         W4319Cq/TmYyRMjmyFBDFy8GN+9fEUgRxp8ajlWuiyP6fbZXz0LXqfFb5IBJq0MBvUbG
         8sn4/8QYotyzcMZ1n/fJpCUXayvrrwsnEwnOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRwhL1NPkbRdnv8DYdCIqNEvEwK08/NeYumLy6TnqFI=;
        b=V3Fs2QRn7eBHmZkimiLM0pDBO9PLJ8pZcsAS1k6apLE0SjtFUqlJHWySu2qqsjx9Ix
         Na0eBldmPAM8DOVFpmkkA7/dYWVPaIM356pR4I9sxporJj81tiDeCjuONqwwjtM55+jk
         BenQr/8Njyue4O5zxvXpGORJlsDenrSedi5O5ULBUjXaeEyGCi4WX+X0jpVH89q4qkM7
         ODd33m+ye3AxGqUmg5O1UwzzIxopq1ez/CF5r0+qEBL6TVvYwS6LT6VWy+g5gVilY5d6
         hf1RtuV9AyQB4zJvQJgPP4rbaeUgsdoh8dbOEicNuAg4P3qPMOBVO8/oQV88DZH4p1MO
         erRQ==
X-Gm-Message-State: AOAM5337OMehiYqDuOl6aSsdewjVepHRywfEnHsvoLe2PowDXKYX/5ir
        fC6he6f3WUAm1RpMRDTmkEcZnw==
X-Google-Smtp-Source: ABdhPJwW4gtXLi7FUbmqmsJLyKkC4nxO8knlYkooSPKifiMgPCNpALVd5g3uaIeh6lNY73omJA+5ow==
X-Received: by 2002:a63:8bc4:: with SMTP id j187mr683449pge.536.1643235760574;
        Wed, 26 Jan 2022 14:22:40 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:7499:b258:18ee:819f])
        by smtp.gmail.com with ESMTPSA id q16sm3020769pfu.194.2022.01.26.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:22:40 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     chrome-platform@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, bleung@google.com,
        bleung@chromium.org, pmalani@chromium.org
Subject: [PATCH] MAINTAINERS: platform-chrome: Add new chrome-platform@lists.linux.dev list
Date:   Wed, 26 Jan 2022 14:22:33 -0800
Message-Id: <20220126222233.2852280-1-bleung@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..cad7b0fff9f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4537,6 +4537,7 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
 
 CHROME HARDWARE PLATFORM SUPPORT
 M:	Benson Leung <bleung@chromium.org>
+L:	chrome-platform@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 F:	drivers/platform/chrome/
@@ -4544,6 +4545,7 @@ F:	drivers/platform/chrome/
 CHROMEOS EC CODEC DRIVER
 M:	Cheng-Yi Chiang <cychiang@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
+L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
@@ -4551,6 +4553,7 @@ F:	sound/soc/codecs/cros_ec_codec.*
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
+L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/power/supply/cros_usbpd-charger.c
 N:	cros_ec
@@ -4558,11 +4561,13 @@ N:	cros-ec
 
 CHROMEOS EC USB TYPE-C DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
+L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_ec_typec.c
 
 CHROMEOS EC USB PD NOTIFY DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
+L:	chrome-platform@lists.linux.dev
 S:	Maintained
 F:	drivers/platform/chrome/cros_usbpd_notify.c
 F:	include/linux/platform_data/cros_usbpd_notify.h
-- 
2.35.0.rc0.227.g00780c9af4-goog

