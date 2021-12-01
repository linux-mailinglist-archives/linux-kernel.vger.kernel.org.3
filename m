Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845CC46544C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351929AbhLAR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351890AbhLAR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:57:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A60CC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:53:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z6so18310620plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLivoSQF+Nb/nS5+Ht9TCA4kgeoYAKeMAfnTZCL56ws=;
        b=hRrR0qSpwI0vBXkRvWAVJKErjNc3E4wDPnwHUbcki+5E3NvEcuSvI5kMSht19brkee
         ZhjQidWRe6aldt4sXynAcDemEYL2ZdBT6C+hea8K+ufVuLOVpoAK1ISfRLEOGibN0Fd1
         XNgz5Oace5v7T9A5iRk4Rrgs9R15dHeg0QL+KLOqD9ZPLDOq98OiEgac9SpWYfMyu9s3
         TJHMQJk6a3Z+dHlnyACvxBJET5Yx3laxNLaPM58wfU/NAYNP/1/igzSeTzE5ueFGq8oZ
         i7O0G/JvVGekdN/3H8ibO/MkPbP6LA5+/r5yZfwX8AHv0c4GfIN2032+rVjxA3Krtlmz
         hBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLivoSQF+Nb/nS5+Ht9TCA4kgeoYAKeMAfnTZCL56ws=;
        b=vuo4Fz3jY8e5cX3ScHBD114dMZ/ynhckC5DrFJwMQhkOew3cFEc67NTkNsv1yWf/Wk
         ZtgDvR6RnCCy5cmHTXQHlAyKgrg8Jq6jAptoGNwTXP2Nbosotq/8Ddf2sqMcadaWcj4K
         2Tx0/T6mBXWEwLfkcZXul1NIRlb6ueQerx/HM+lozbNq1864SW/DFXa94yW+c9KiLe80
         FbVhhNM0jpbVuE44TelmYYR5r8Lhm+eCH7bSQo23vr4tSDG2nJzNVCVS7o5MHSz+Attv
         mSc3s9Se+DpsYw49C1qiPi8SZFqWn5I4iUxYMFKZDKtMYVblfTrT/5QhYA51AoRHnlwc
         pLMg==
X-Gm-Message-State: AOAM533oXvgvNsvSrrbz9/DXGcelWBFhkue+veIEOMz+zF3pzNMCJN8c
        rvGQRbkme5Ubwq1Q/zaz11Ismg==
X-Google-Smtp-Source: ABdhPJwuRSAU8koWn4LjF+BFiKcgkBXMPDXqWo+Jl6gT2WRFf28RHlJOBndRJ/ZvLW8oaXRkarcZzQ==
X-Received: by 2002:a17:902:ea10:b0:142:112d:c0b9 with SMTP id s16-20020a170902ea1000b00142112dc0b9mr9270004plg.35.1638381228000;
        Wed, 01 Dec 2021 09:53:48 -0800 (PST)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q21sm275072pgm.83.2021.12.01.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 09:53:47 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Removing Ohad from remoteproc/rpmsg maintenance
Date:   Wed,  1 Dec 2021 10:53:45 -0700
Message-Id: <20211201175345.865408-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ohad has not reviewed patches in the remoteproc and rpmsg subsystems for
several years now:

$ git log --no-merges --format=email drivers/remoteproc/ drivers/rpmsg/ | \
grep -Pi "^Subject:|^Date:|^\w+-by:.*ohad*" | grep -B2 ohad

Date: Thu, 12 Mar 2015 11:54:41 +1030
Subject: [PATCH] virtio_rpmsg: set DRIVER_OK before using device
Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
--
Date: Mon, 15 Jul 2013 11:24:08 +0930
Subject: [PATCH] remoteproc: don't use PTR_RET().
Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
--
Date: Thu, 14 Feb 2013 17:53:18 +0100
Subject: [PATCH] remoteproc: omap: depend on OMAP_MBOX_FWK
Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

As such move his names to the CREDITS file.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

---
Credits to Joe Perches for the script [1].

[1]. https://www.spinics.net/lists/kernel/msg4163272.html
---

 CREDITS     | 5 +++++
 MAINTAINERS | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d8f63e8329e8..504e026ca132 100644
--- a/CREDITS
+++ b/CREDITS
@@ -315,6 +315,11 @@ S: Via Delle Palme, 9
 S: Terni 05100
 S: Italy
 
+N: Ohad Ben-Cohen
+E: ohad@wizery.com
+D: Contribution to remoteproc subsystem
+D: contribution to RPMSG subsystem
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

