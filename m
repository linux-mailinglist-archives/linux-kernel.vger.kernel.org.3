Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A45A6230
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH3Ljc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiH3Lie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:38:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF64E86B;
        Tue, 30 Aug 2022 04:37:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l3so10823716plb.10;
        Tue, 30 Aug 2022 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6KNK/Qer37pzDc5PqooWdVUsv4ChHn4/mUHtr5VgJZ0=;
        b=B/RK3EqxipgVqKFf0dtCSUmJhO0BwkBfBN5JAZqQrjRyS55tYNgcifxj8m3yKWL9T1
         sN4yvF+Rde0etRQu9R9ULdjfCNVWfDQM08fHMWWE4ZEkxxd7FdC/wW+zc+do68vs6WKQ
         VL0Wr64doOvUeppiDemQZhnFV4UDB2aU+4Bmqf+YobACeQtWuwuMy/NngcIywMlDBl6Z
         U2cKgIZI7l+4OdMTs76iRSEbJ69dVBtzqlKaNYVxaE1RbpmdqCgdzUBWAIjgxFdM02By
         zV6rc7/icw4DfWHUNm/SLdR77rl8NDTZE8BCSGlpP7wcG3VzaS69ntrzekgJepNCOTz9
         gC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6KNK/Qer37pzDc5PqooWdVUsv4ChHn4/mUHtr5VgJZ0=;
        b=pkzW9BO6aQyqPiJHf2SeQonnzw4WcwoBhYgrpz21b5Ex1tIEZ6Ve1nVpYB++eGi70U
         yB7hfGq5JLOum9JbuIetGUZRMrlZejBtdk5meMRAddSR4zn/OLvpoarC/Czj4lBYZ8fr
         TdzBT5L3YjmN4EcpoBYAmX2RcZsRtz2RhLquxmeNX2rBjHZPUA4FmKOe+dldpdj/13NT
         7GQ+4vuG++gho2ze9bmJDq4eOnhVPQERchdrykJMJo9DBA8Rtk0etL03jDvtrwEhJYZ0
         7ytBJH8cj3ASQ7Dwi8TFcqxLst7s8NPVHZ8g0UBDmHCk6thKyWQp0hwEAe8LXEkujsP5
         NIUA==
X-Gm-Message-State: ACgBeo2JL6HPUf4t8AIvfX8MITXPMpiPK6/ElgHDRGMpns6DXTi8Al+Z
        M8l4w918qW6wqp+y1OwG2Us=
X-Google-Smtp-Source: AA6agR75UjHnbrL+QMBV7Kx0U4AmXrY0/uQSilpcTQY4gnXb4H5a3CnIgH5v5bp5zmVwiNAoHs3ghQ==
X-Received: by 2002:a17:90b:4a51:b0:1f5:8308:6ed7 with SMTP id lb17-20020a17090b4a5100b001f583086ed7mr23096648pjb.177.1661859441227;
        Tue, 30 Aug 2022 04:37:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016cb873fe6fsm7467590pln.183.2022.08.30.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:37:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] usb: gadget: remove redundant variables ret
Date:   Tue, 30 Aug 2022 11:37:16 +0000
Message-Id: <20220830113716.287855-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Rturn value directly from configfs_register_subsystem()
instead of getting value from redundant variable ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/usb/gadget/configfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 3a6b4926193e..070872d1ae70 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1671,12 +1671,9 @@ EXPORT_SYMBOL_GPL(unregister_gadget_item);
 
 static int __init gadget_cfs_init(void)
 {
-	int ret;
-
 	config_group_init(&gadget_subsys.su_group);
 
-	ret = configfs_register_subsystem(&gadget_subsys);
-	return ret;
+	return configfs_register_subsystem(&gadget_subsys);
 }
 module_init(gadget_cfs_init);
 
-- 
2.25.1

