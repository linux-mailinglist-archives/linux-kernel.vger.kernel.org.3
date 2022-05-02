Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A493516A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357759AbiEBFT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 01:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiEBFTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 01:19:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE0BE25;
        Sun,  1 May 2022 22:15:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 15so10917598pgf.4;
        Sun, 01 May 2022 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0VubNrQWYHk4IlQD+kxXHZzHAldnrU5eq+ivCmkfLU=;
        b=KkR7X/snPIE3XMgJ0HxwJcymPlARTygWmRMP8MpCKWyk8oS+hH89cSkJMaHhGkC22D
         zRvT8HIrXpoORVRsjzQbtTbsiQGfzoeDVs75Z6Egv0jwOLHJKnSC0UmFzvwIqmjDbah3
         hyedoI6C5mwFuM+VksuOKzMkVGY/qPue01ozH0VoGIDEllcH97XAxWqaO3+q88mDez5n
         175zLK5dFhak10yCfxrT8DJXOTdc13rgDwRw5VLzJodkhRfge88st/GJQW6MXuDo9GSY
         i2o/3/ipIE9ghWnmaR5DDpRv9rU7VQAfNNvmFaDjyEcNj9kHZQu2/cp9+PP42+O8z+EX
         d/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0VubNrQWYHk4IlQD+kxXHZzHAldnrU5eq+ivCmkfLU=;
        b=XLniLXXNNYy+tc9B56N6vS89sAL3PGZySb7NPilVU731vUMIRz2mWsuDyrlx3WHYs4
         irxgspRlE+Qs4i4+uyptWxtjbZrKJnCjS9jCAXztH/Lv2PoL9jyvdiPO2JBju/xdzhtH
         l952s8VH1L8qbZ5qPHuHAZp1ptANLq6pvI+9IBVQbr3EeeZSjgLcRXa1Js9sfDgAIZOb
         3J3zy0AoUbLQA+lVyFfTW/yDWuVUBmpKFNc8mSbAAoTO37uo1Ra2x06pVjFK79ts9TwP
         WiuyBmo8d6PRKYnv86+r3qMnhM6glHIyCeOCtF7fEXCBMl8kAATB2y1XlLUYE/rflwjm
         5LVg==
X-Gm-Message-State: AOAM5339nk0Evr5CQGo55t5+YGCenwaKzxbPVznO1E+xw0HmGQSlh0HR
        KG6E1UyRUDhs0FhS6HdwGHLVtC0q/vjKig==
X-Google-Smtp-Source: ABdhPJw/YEtcJ3NYNLsPSznJMmKPEcHZcURomlUZzqjadz4cqXXix5uDPn+SrqlvcdEwvtv1UHCuvA==
X-Received: by 2002:a65:6e92:0:b0:3c1:c903:e5fe with SMTP id bm18-20020a656e92000000b003c1c903e5femr8529040pgb.424.1651468555540;
        Sun, 01 May 2022 22:15:55 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-92.three.co.id. [180.214.232.92])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7874e000000b0050dc7628139sm3849561pfo.19.2022.05.01.22.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 22:15:55 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] firmware_loader: describe 'module' parameter of firmware_upload_register()
Date:   Mon,  2 May 2022 12:14:56 +0700
Message-Id: <20220502051456.30741-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
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

Stephen Rothwell reported kernel-doc warning:

drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function parameter or member 'module' not described in 'firmware_upload_register'

Fix the warning by describing the 'module' parameter.

Fixes: 97730bbb242cde ("firmware_loader: Add firmware-upload support")
Link: https://lore.kernel.org/linux-next/20220502083658.266d55f8@canb.auug.org.au/
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on driver-core-next tree.

 drivers/base/firmware_loader/sysfs_upload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 8cdcf3516c7e94..87044d52322aa2 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -266,6 +266,7 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 
 /**
  * firmware_upload_register() - register for the firmware upload sysfs API
+ * @module: kernel module of this device
  * @parent: parent device instantiating firmware upload
  * @name: firmware name to be associated with this device
  * @ops: pointer to structure of firmware upload ops

base-commit: f8ae07f4b8bfde0f33761e1a1aaee45a4e85e9d6
-- 
An old man doll... just what I always wanted! - Clara

