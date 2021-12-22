Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8B47CD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhLVHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhLVHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:03:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A5CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:03:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id l10so1306905pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3VDOWPcXWhDFPAt9Df/Qo17xw6phBw6+Cx2n5GdYw8I=;
        b=KQEn3RcHLikmtvkAq09i7D8+irGECceKpSEVr09pDFXyO8xdK79Z3J+FSAxdQPfZmK
         6fDhpjfwz/ErFKb5Y84eXlHPyfeMiSQOeYj6qiHfFEuhn+MWlDuYOxdwKfI23GgsFSHe
         +VQv7tZsd/3Zp3lFgIP8LWo6Su6kJX+FA281G9z+iyX2t9Imtu5as0ChygbTECXfoDuu
         4HjadGJM7+Qt9QP1nvVu5qcNii5jqaiiGzkKAoKKuiLrUe22xQEaVyf4jSVsRx0mJLk5
         WXUEbQHaQvlh8gBAdEM3fpV3ZqXjurLJpNAOl3OhIdbuSN8SnKgzc7fhftaMjLYY8lSe
         f8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3VDOWPcXWhDFPAt9Df/Qo17xw6phBw6+Cx2n5GdYw8I=;
        b=vlPvMR0qp7sCeUzbABZUimMAqkEn0yMpgUIYzVewpYAnt9dgMyVRTl3LpOgtr8AFWa
         45KlqSgoIP+zsntb9h1qYfKInKOxA7iSk4DTu4eicceAIVct5p7VO4ysEvj7bLCiHNeN
         62nm0Bm59N32PVU22OhE22rAgAS6srSPpK/BqkdoAIp8CyKjDqiIqqiP8Gui1TnklKvj
         Pdcsf2H1TifPg7lIijGPmSkpWmFCoTZ8gNhSAfLTOTUriXcRwbXWrt0+8mGo5kC/1PS1
         YNQufM/xs43EmfHseyYuoL9iE0hnqq48LxaLqFHX5rP2IdPGt3qLZZjMZW8iVG9oHBy8
         +cPg==
X-Gm-Message-State: AOAM530a8UqCsuhDh737C7Dwv00FEJCoQCZKNUQnyZl0zdYuNifcSLXV
        gF2PVIE/gdi+hpWvX+a0Zjg=
X-Google-Smtp-Source: ABdhPJycGG6AFTvNA5CCdWBtS06E4j1qggcF88zMZtOu/rUTQU/wK+IpHwer4hO2GDScPqbJ0V0QYA==
X-Received: by 2002:a05:6a00:248f:b0:4a0:1e25:3155 with SMTP id c15-20020a056a00248f00b004a01e253155mr1650662pfv.21.1640156582285;
        Tue, 21 Dec 2021 23:03:02 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id z2sm1034777pge.86.2021.12.21.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 23:03:01 -0800 (PST)
Date:   Wed, 22 Dec 2021 20:02:56 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove unnecessary parentheses pointed out
 by checkpatch.pl
Message-ID: <20211222070256.GA7644@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports 'Unnecessary parentheses around <lines>'.
Fix this by removing extraneous parentheses where applicable.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index dc047bcdf44b..e62e61ef4d27 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -470,9 +470,9 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
 		return -EINVAL;
 	}
 
-	if ((mantisse != mantisse16) &&
-	    (mantisse != mantisse20) &&
-	    (mantisse != mantisse24)) {
+	if (mantisse != mantisse16 &&
+	    mantisse != mantisse20 &&
+	    mantisse != mantisse24) {
 		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u", mantisse);
 		return -EINVAL;
 	}
-- 
2.25.4

