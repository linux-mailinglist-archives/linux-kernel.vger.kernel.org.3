Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210224668E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359853AbhLBRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359792AbhLBROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:14:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6FFC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:11:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so256175pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwOKt3OOkRPRdK64nOMB7Wk4/4KZ8STlxMRNjUNA2As=;
        b=oib93oLHva7M20RUYAcWefBezzxTGxy2OyKORb1mNqbOQ8862ewuDc0yGaxPLB6DNu
         jk9LMO7lYx9np4d/whEpjboaBToF4xKAhsVDMmxjOM0kxj+lRbGbzLBla1DVPnqNprVh
         zzBR7XL2/MkNuramhYxsni3hGRN+MUbEXr2jIzjx4lH7RaTysMyKBzrY+AEm4Oa6zEmC
         EkS5/27JITyjtjzNYJE4K0YqVUDCwMtCENTOXIXhaUwFULzVFgefoV1aMqFKCCG/AdmH
         Vn330MCcJ2xyzQpKBplpUgbRPAvhuvbrle23U0j2/eV5eKp2jHa+B9xfSNFEmdFHIMqy
         BHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwOKt3OOkRPRdK64nOMB7Wk4/4KZ8STlxMRNjUNA2As=;
        b=wPdEkzJYv7OMq5RBIeYZdngTzJK4YHGzILpqSasw59L/mIgOsuS35xLssgAONVOYrY
         BRMJQyLktjQQTT11OoETYqE/eJR7VxhrkApppXzuahfCp1V5Mw/lZamHJ9CKKiyc3Ywe
         xj2ifHaRX+kQ6hJTNpbnHETJdTq4GuiJpBpNIF+x1OxyYmKtZkkJDjBNmvHahXz+ihju
         DLOD+nsyDWk1uFyiPUuX/XkcunvGRPqsw90dPShkInZGzJ1mDfduhNv48pFjWms484xU
         ZSLB9WLZT1vRMwraalLVYr1KbYPoZZdzE6djsqJGMt+wzzXzGiyD5tc+44B7eYX/tJAz
         f4Dw==
X-Gm-Message-State: AOAM531ae2uLS1u28/fnkwSwSC5sTGo2PDB5p7vWvQegl0ma92kKNd1Z
        Zq/Q5BocmQ5jisKe7TijJGFpLw==
X-Google-Smtp-Source: ABdhPJyclO6l/nByo9s1d6Ao5p3spwc35ODbw53u8jGW8M5/K0rNZpCjQmPES1s8TwxqKDKayvN3Rg==
X-Received: by 2002:a17:90a:158f:: with SMTP id m15mr7592898pja.200.1638465088619;
        Thu, 02 Dec 2021 09:11:28 -0800 (PST)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s19sm386523pfu.104.2021.12.02.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:11:27 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Removing Ohad from remoteproc/rpmsg maintenance
Date:   Thu,  2 Dec 2021 10:11:25 -0700
Message-Id: <20211202171125.903608-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ohad has not reviewed patches in the remoteproc and rpmsg subsystems for
several years now:

$ git log --no-merges --format=email drivers/remoteproc/ drivers/rpmsg/ | \
  grep -Pi "^Subject:|^Date:|^[\w\-]+-by:.*ohad*" | grep -B2 ohad

Date: Wed, 16 Sep 2015 07:32:54 -0500
Subject: [PATCH] remoteproc/wkup_m3: Use MODULE_DEVICE_TABLE to export alias
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Date: Fri, 28 Aug 2015 18:08:19 -0700
Subject: [PATCH] remoteproc: report error if resource table doesn't exist
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
--
Date: Wed, 16 Sep 2015 19:29:18 -0500
Subject: [PATCH] remoteproc: fix memory leak of remoteproc ida cache layers
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Date: Fri, 20 Nov 2015 18:26:07 +0100
Subject: [PATCH] remoteproc: avoid stack overflow in debugfs file
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Date: Thu, 18 Jun 2015 11:44:41 +0300
Subject: [PATCH] remoteproc: fix !CONFIG_OF build breakage
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Date: Fri, 22 May 2015 15:45:30 -0500
Subject: [PATCH] remoteproc/wkup_m3: add a remoteproc driver for TI Wakeup M3
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

As such move his names to the CREDITS file.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

Credits to Joe Perches for the git script.

New for V2:
- Fixed Ohad's name and contribution in CREDITS
- Updated Joe's git script in changelog.
---
 CREDITS     | 5 +++++
 MAINTAINERS | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d8f63e8329e8..b97256d5bc24 100644
--- a/CREDITS
+++ b/CREDITS
@@ -315,6 +315,11 @@ S: Via Delle Palme, 9
 S: Terni 05100
 S: Italy
 
+N: Ohad Ben Cohen
+E: ohad@wizery.com
+D: Remote Processor (remoteproc) subsystem
+D: Remote Processor Messaging (rpmsg) subsystem
+
 N: Krzysztof Benedyczak
 E: golbi@mat.uni.torun.pl
 W: http://www.mat.uni.torun.pl/~golbi
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..ee82a598b3ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16171,7 +16171,6 @@ S:	Supported
 F:	fs/reiserfs/
 
 REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
-M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-remoteproc@vger.kernel.org
@@ -16185,7 +16184,6 @@ F:	include/linux/remoteproc.h
 F:	include/linux/remoteproc/
 
 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
-M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-remoteproc@vger.kernel.org
-- 
2.25.1

