Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6848CE07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiALVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiALVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:50:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2AC06173F;
        Wed, 12 Jan 2022 13:50:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m1so12914055lfq.4;
        Wed, 12 Jan 2022 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ADszw/b12jdboV3uFFfuJB82iam7r93xpIveQJmJIY=;
        b=YpPs7yvtzh3zGYkjXXzOlsIyloJI0tTySSNPY3qcmYb/3BKBJwESgjl82vPwDMuSCN
         aRvP8z9qseGnS0gd0iSjcBqnRB/JOXed0Ky/Nxw0Lm2TKWVa2Aibfd2zwgGJTRHWzLWr
         J+cVmcED++hjxSs80r6MgLAQHPQvPoYWp0TsfBVOHUMNdey6aO2V6qBJGWI2EZsv6xK9
         4VBvjEy6mKOBSTi/NQQOODzU2u7CYjc61O7IiFTERptXuZ8+9rEUg6LiDbKE/ZDT2K8u
         8oycXurqo8xdU/0oX2ul6s7zqyvhuoPndJP4IuMJei7nBDMhc89XUEsAlZxFPnWQ34fU
         xVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ADszw/b12jdboV3uFFfuJB82iam7r93xpIveQJmJIY=;
        b=aEVWX1bmVWtjHkDz45TVA6gDS031Q5mIUFZnIF1G5AxMHoOQBlruwoxxYvUNf5J+qO
         VAI7RdvFi+aI5mnzH+WdF3xKOXyNNiCwKN5UGKrM8USbdmtLy8nyw1azLp+WY0z8Eaer
         3PT1A8MSb8ubaN87FV5omPOwgyuvFgYf74ZT+j6gWgDsChGmQQ61xeidKwJjEB6y7zqm
         mf2nNKI2mJOgq05Kj07KZG7CCI/zaIQfmDFyIVqDVrhztxgHM+agRPtg857gWfi9+GcR
         3AiNU635x76NEVWnO831vvANfIQ/uhKtCjfJIlQzQX1+YxDaMBfz9ve/h9zizvZfVYxa
         2Pkw==
X-Gm-Message-State: AOAM5328u/dtBhtggAG3eEokKnyq4+bTx13nb/f0ERH5X7jxS4jSiA9V
        e6zwVoFnREbX+Vu2ssMJJS7o2S4la+A=
X-Google-Smtp-Source: ABdhPJzN6b9wEZg7hP8CsCDaEm8EV5jyk2q6NQApH2kS7pPRp3Xz39JO9NeK/wGSkzvytjEmKjZC5w==
X-Received: by 2002:a19:7610:: with SMTP id c16mr1141457lff.531.1642024225331;
        Wed, 12 Jan 2022 13:50:25 -0800 (PST)
Received: from localhost.localdomain ([94.179.50.100])
        by smtp.gmail.com with ESMTPSA id q14sm100528lfu.74.2022.01.12.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:50:25 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, "Gregory P . Smith" <greg@krypto.org>,
        =?UTF-8?q?Joel=20Wir=C4=81mu?= <jwp@redhat.com>,
        Jonathan Farrugia <jonfarr87@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) add ASUS Pro B550M-C/PRIME B550M-A
Date:   Wed, 12 Jan 2022 23:50:13 +0200
Message-Id: <20220112215013.11694-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS Pro B550M-C/PRIME B550M-A  boards have got an nct6775 chip, but
by default there's no use of it because of resource conflict with WMI
method.

This commit adds "Pro B550M-C" and "PRIME B550M-A" to
the list of boards that can be monitored using ASUS WMI.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Gregory P. Smith <greg@krypto.org>
Tested-by: Joel Wirāmu <jwp@redhat.com>
Tested-by: Jonathan Farrugia <jonfarr87@gmail.com>
---
 drivers/hwmon/nct6775.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index fd3f91cb01c6..bb62236f395f 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4985,9 +4985,12 @@ static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
 	"ProArt X570-CREATOR WIFI",
+	"Pro B550M-C",
 	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",
+	"PRIME B550M-A",
+	"PRIME B550M-A (WI-FI)",
 	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
 	"ROG CROSSHAIR VIII FORMULA",

base-commit: 00f5117c5f785b95b13663e52dcdcf684a47d4e3
-- 
2.34.1

