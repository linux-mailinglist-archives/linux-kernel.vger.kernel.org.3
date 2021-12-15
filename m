Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323A475FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhLORsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhLORsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:48:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA7C061574;
        Wed, 15 Dec 2021 09:48:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u3so44668800lfl.2;
        Wed, 15 Dec 2021 09:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUJgiOCeEkvWRBfsS4oHMEMSHGIv4GiMwDTH+LmBGxo=;
        b=aCybwx8HJzex6q8SsbeG93ODdvKq3RiRJ+1ydnISYyP6BRk00cb0QM3cNocpcr84SS
         /f4L+PbNsici1VNpGtWQxgmLP0w5qMjJe8zw5XIjtVGuUd3hH8V0thhmLElw/JrSozOn
         oslJzqDGf7a1X6wYmuuRuEEHVB6jCo8wGJcCHZj7oISg3bzx805L2Dr92Uq8QUXRnq9R
         bu2PW7EYmjH+tNyMwvQUjsDmyO4MKg4l8NTswLbUyY49/PNssSBwdmPIzVG5n2ZB7D9y
         Q8sbNGLmTFbsjuHWG9sVjqjO/dXwEpw1if6lqKuEuvOmgwBxlwE8xWSL4jKXMWJOGnpd
         fVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUJgiOCeEkvWRBfsS4oHMEMSHGIv4GiMwDTH+LmBGxo=;
        b=sjOh1EpKFMc0d9ChmKiN6UFz4U7N2sDVIPOW2eeUC6nQ2kPRa1xjGf0WcHClOHlFJf
         FejB1Y89r54gUr/JWp+Jqv3MxO55oEvE//prb8ZsKI/NpnfwoKnjlMHQ8XoOYo/ztPAj
         /zMHtpHRalARLIRVxRhDH3Dcvv9X1AGtgRq+Si1raKCb32NkqRfhfT0Suk6vYMIVqhXv
         jKt8j/fmgiLwZhvhVfv0pm+pMx/tg1kGT+T+tBYC/h6PCZ0x5I0KdVYsS9Pafp8mrG5b
         2xYUl2chBTiOSCcLekFY4vAO2lhF/MEywE2D7FaQiH6vkazbsq4kZ6Hpzgfm+xAXnKba
         QkYA==
X-Gm-Message-State: AOAM531JLZLjUBIK4I1lW+7twFCfwfQdG38OosfsxuS79jYH1f72dA4b
        +McPDi90Vm8yyaQ1XC+MW5U=
X-Google-Smtp-Source: ABdhPJxgkaZdq4SDRDpCwwhvJ5K7obz453eS6h9ijgkAXromE/ebhtNw3OJ0YnVmPHkAVWIkHcYItg==
X-Received: by 2002:a19:6717:: with SMTP id b23mr10755556lfc.659.1639590508523;
        Wed, 15 Dec 2021 09:48:28 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y4sm422306lfg.163.2021.12.15.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:48:28 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] pinctrl: add one more "const" for generic function groups
Date:   Wed, 15 Dec 2021 18:48:21 +0100
Message-Id: <20211215174821.21668-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Generic code doesn't modify those strings and .get_function_groups
callback has that extra "const" as well. This allows more flexibility in
GENERIC_PINMUX_FUNCTIONS users.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/pinctrl/pinmux.c | 2 +-
 drivers/pinctrl/pinmux.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 6cdbd9ccf2f0..f94d43b082d9 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -875,7 +875,7 @@ EXPORT_SYMBOL_GPL(pinmux_generic_get_function);
  */
 int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 				const char *name,
-				const char **groups,
+				const char * const *groups,
 				const unsigned int num_groups,
 				void *data)
 {
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 78c3a31be882..72fcf03eaa43 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -129,7 +129,7 @@ static inline void pinmux_init_device_debugfs(struct dentry *devroot,
  */
 struct function_desc {
 	const char *name;
-	const char **group_names;
+	const char * const *group_names;
 	int num_group_names;
 	void *data;
 };
@@ -150,7 +150,7 @@ struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
 
 int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 				const char *name,
-				const char **groups,
+				const char * const *groups,
 				unsigned const num_groups,
 				void *data);
 
-- 
2.31.1

