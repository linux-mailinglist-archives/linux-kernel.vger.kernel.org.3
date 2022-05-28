Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B59536BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiE1JOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiE1JOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 05:14:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5A26A;
        Sat, 28 May 2022 02:14:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q123so859996pgq.6;
        Sat, 28 May 2022 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GURDLD8fq2AWOdGy1BHqDXdBjLx5bVXEyWSiOccXTFA=;
        b=YEYAbQLZVyGOPW5q4qCpmJz2/LnPnAd6qik6FWAHDEjH5YfqQwL3C6QGUoAOkObnbK
         HAbUdoX5X1ku9dx5nNVLj9RvhAwD7VeFPy9tiQFM6H8xjdmD8HWocqzxw3qqFBW1lyDY
         M4/TOtVySSw0pKdPboWBs5hHk5Crb6Zyx1my4xIoHb61AanhYhdU4jLW6I2Z5sYnF05R
         paOCT16OvCabwdzIiE4QKBVSBNAn82adwTlNO2KHaxCjyeDUuFSPkmL2m0ctdTlFwkes
         dhWi2y37HUu4X4z+miEAJOyl/vnqD2tjuHM/Vfq/LVg5eQ5BQ9u04tnaNSYVkG7NEt/0
         gGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GURDLD8fq2AWOdGy1BHqDXdBjLx5bVXEyWSiOccXTFA=;
        b=KTAcgflGTdGigP/fN2mdKVZugINro3oUW52vyulrFcS0hgueYuspT1b+JBwd89zi0F
         cDJB+wuqC2AWASuqeS9bDw3zsph/ukn0OhJTcBK1sZbZHSsuAClCyqaoKIhMeE2tGQOp
         NOZSY6o5EFMRQb2a8qPMzSJnhFHZ9MIGFIpbNk6kehUCTT4UNMqICK5mnnWYh1kCOPDw
         5oNsioirSrahw7OsyDwm7qIQ0Fpj+x/gFnDCS/79ia4hbIxN2j3YWY2KD1N0Yg7lkpJ5
         Gpihgung7F5h7gFElb4zD9zHq/tOANOSZ9RZepxt6ZVPxeUfAwOzkj6exWj5faPTQTYl
         XJoQ==
X-Gm-Message-State: AOAM533whCPA6lGNHlkj5m7CKMd0BQSYnPPjSpKZb6RfVXfOPr7NciDB
        ZkIdRWRbJmTuEsXn35A4kfjBcwX2BIJ2Sez/
X-Google-Smtp-Source: ABdhPJyWJQoeIcudr0763uMq1YHoIpFW+NSB6/bA4tJRRtTuk9T/ssqTDu2E1yv15WgN8FH+cScgLQ==
X-Received: by 2002:a65:6055:0:b0:3c6:adfd:5135 with SMTP id a21-20020a656055000000b003c6adfd5135mr40786271pgp.146.1653729276731;
        Sat, 28 May 2022 02:14:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b0016198062800sm5320179plg.161.2022.05.28.02.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 02:14:36 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        llvm@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: uclogic: remove extraneous asterisk on uclogic_params_* static functions comments
Date:   Sat, 28 May 2022 16:14:02 +0700
Message-Id: <20220528091403.160169-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220528091403.160169-1-bagasdotme@gmail.com>
References: <20220528091403.160169-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*uclogic_params_pen_inrange_to_str(), uclogic_params_pen_hid_dbg(), and
uclogic_params_frame_hid_dbg() are static functions but contain
double-asterisk (/** */) comment, which confuses kernel-doc as public
function for generating documentation.

Remove the extraneous asterisk from these comments.

Link: https://lore.kernel.org/linux-doc/202205272033.XFYlYj8k-lkp@intel.com/
Fixes: a228809fa6f39c ("HID: uclogic: Move param printing to a function")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "José Expósito" <jose.exposito89@gmail.com>
Cc: llvm@lists.linux.dev
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index db838f16282d64..71501453de12e4 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -20,7 +20,7 @@
 #include <linux/ctype.h>
 #include <asm/unaligned.h>
 
-/**
+/*
  * uclogic_params_pen_inrange_to_str() - Convert a pen in-range reporting type
  *                                       to a string.
  *
@@ -44,7 +44,7 @@ static const char *uclogic_params_pen_inrange_to_str(
 	}
 }
 
-/**
+/*
  * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
  *
  * @hdev:	The HID device the pen parameters describe.
@@ -76,7 +76,7 @@ static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
 		(pen->tilt_y_flipped ? "true" : "false"));
 }
 
-/**
+/*
  * Dump tablet interface frame parameters with hid_dbg(), indented with two
  * tabs.
  *
-- 
An old man doll... just what I always wanted! - Clara

