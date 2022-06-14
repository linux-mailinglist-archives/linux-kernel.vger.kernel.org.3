Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F754AC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbiFNIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355865AbiFNIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:47:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437EE44A20;
        Tue, 14 Jun 2022 01:47:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso11139312pjl.3;
        Tue, 14 Jun 2022 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EntQmblUAdy6HR5OkX3ZttgJaoB68on9RXGKibxpzLU=;
        b=jfo5hdK/2DWPVT1N+BbJklo1XAaKZTDglASGXP1TElxpubp011j8p2SaBoLRPZd9ly
         QLuAHv2+ENIkuvIijwt4XLhodqEDC2F2Nd7Bkp0N0xAumQWXXwI5Zxbpx0QHf5MD6nAN
         fD+4QJFEzr7m6bFmH3NiAiV2I7oVqmQBEO5+MRAa+IY9EogcchjPL1B+nxLAsv7NF526
         zOwtFqHtyazzOBoUSXm5lm8GLH8Njr1ev7HxjZQqBYaRgAxDnB1xY6ZKyUEPq8oHDwMD
         BGRXWpc8RrfeuycCnsIAN73HkzDvLbsh5ss/ZYjYLpSOgqNGkcvD3oX3fCo2E8Xm1lIm
         4JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EntQmblUAdy6HR5OkX3ZttgJaoB68on9RXGKibxpzLU=;
        b=LkmOuzlSuTzEExx8/HZvoQn/Vy9MapVEbJCGQ5+IDGXv4BCRRAMJ8mR8vdOrSPMfUr
         hHoilpzkqLeEUlNE4nu9AV50sDu/9+OXMLlw/goIpAe+/B+FoK6c2/mSNHrPHd5LJvwC
         o6f5cAFkuWKtIc7xYyvq37aI/X6hWZzgu6aR6ogLWVwc0aTJtqfJMAtfTs5ZtVQYUtkK
         w09tgWEWWQSEBP28Hzups0B3/UhL4nE6KZ+YOWMuVTQW+QZSGVTC33MsfiBoVMPOhNHZ
         XaVjBIeUPPw/TtHk1ZAXYP+uyYBen7kRVIYjtkZhFSJPzEwKCx4Qe84pP17pLs5oZzIQ
         vSsA==
X-Gm-Message-State: AOAM531XYUy5dZ8ClY87c7fUpVhXPZEqT9e8kscQvwq+X7tV8WwwITP/
        TGduBy6awNi6rJpx/TSP3dCYzT4UxJs=
X-Google-Smtp-Source: ABdhPJwKmt6r6V9ps0nGuI2DJWluBPG4fDDZW5mVMQExOJ7Sv+tuv4XRvrEVZYanjmWiuXBlFyQ6Kw==
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59ac with SMTP id q6-20020a17090311c600b0016790e559acmr3193741plh.143.1655196427261;
        Tue, 14 Jun 2022 01:47:07 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-37.three.co.id. [116.206.28.37])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a008500b001e325b9a809sm8828724pja.38.2022.06.14.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:47:06 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: samsung-s3c24xx: Add blank line after SPDX directive
Date:   Tue, 14 Jun 2022 15:46:58 +0700
Message-Id: <20220614084658.509389-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220614164506.6afd65a6@canb.auug.org.au>
References: <20220614164506.6afd65a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging spdx tree for linux-next testing, Stephen Rothwell reported
htmldocs warning:

Documentation/arm/samsung-s3c24xx/cpufreq.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

It is due to missing blank line separator between SPDX directive and
page title.

Add the blank line to fix the warning.

Link: https://lore.kernel.org/linux-next/20220614164506.6afd65a6@canb.auug.org.au/
Fixes: b7bc1c9e5b04da ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_147.RULE")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Allison Randal <allison@lohutok.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arm/samsung-s3c24xx/cpufreq.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/samsung-s3c24xx/cpufreq.rst b/Documentation/arm/samsung-s3c24xx/cpufreq.rst
index ed19ce1a462921..cd22697cf60660 100644
--- a/Documentation/arm/samsung-s3c24xx/cpufreq.rst
+++ b/Documentation/arm/samsung-s3c24xx/cpufreq.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-only
+
 =======================
 S3C24XX CPUfreq support
 =======================

base-commit: 35d872b9ea5b3ad784d7479ea728dcb688df2db7
-- 
An old man doll... just what I always wanted! - Clara

