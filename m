Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B46A4E4C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiCWFmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiCWFmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:42:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962C70F74;
        Tue, 22 Mar 2022 22:40:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so414641otj.1;
        Tue, 22 Mar 2022 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9iIfkCt/jg8MEhpfaNAJxpOXh4bHPiVzV6CVbqqBJs=;
        b=iCna7uRVmR2CR1uSBU4qBsBAPa0KMhMyZMEE9BRrB90wetgTjPhPcGcJrkRomy/Fxi
         /xJYgYSE1H3JS3oBd0knw2ArObKjyo0GWOXhMjbtPy9+xqutvziuGHv+6WAV6Bq09amh
         Esa3EQNseK5pfT88JoPz/gnkXryhAkiyM7AT5tWTcwjDI6yPk6kEcajERCj0H5o6MQrI
         5oVyO+Etpw8fDW371FzE3Njghw1zTBgLP5ltEKBchNT2i3iWCCRKc/hG4zoBUk0J3krK
         YU+WkGotpNJcc95zd1yVRBAMqq5diKV84Jschqq3o1+OiBgKKmWlqQVLMmcrS7REKgFl
         lhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9iIfkCt/jg8MEhpfaNAJxpOXh4bHPiVzV6CVbqqBJs=;
        b=TeEj5BqbyZHYfKWNijf23hhJ5MmLxk5xpxkDwGspZ+7+NAFRaWblxKT8ACOJK8WOs1
         CUpcwty9sNS4pFmong5VxUUq0WeUHRBREVilLLZGGNtkAXmOu5eO6aKZVmw5MBuWSOWr
         yVfF1GfDH//lf7jDcN0IvNdkF9gAxvW9ujfgG34o2+PEkuLP48of5ElVXKV8bgVLcUft
         F73trrkHbtImhM18MWhmxku7rpAZeLxRIY8CjjwvTh7koZKog3BUJUxKNfZjKV1tOXJP
         t/fMaePww+OuxMihZvNPN5k8vhusuLVAW6izzdYjkMGUI/L+MDV41p66+/Gqgj70rJ1O
         /wWg==
X-Gm-Message-State: AOAM530eYsh37GDG5FC257tCDgGkmNalwJni5fPsfvKR3dj9P6+/xMIV
        qOQecF7ZF+pLb5xyNwor6FU=
X-Google-Smtp-Source: ABdhPJwT7qIA+JhlvsgQLzNSrBXdnRr+3ER4Igpyq3xXFHf3P6mlqPPYF800ZTC7dJj+pGOwv2IS8w==
X-Received: by 2002:a05:6830:3155:b0:5cb:28ca:8cf9 with SMTP id c21-20020a056830315500b005cb28ca8cf9mr11140320ots.270.1648014040139;
        Tue, 22 Mar 2022 22:40:40 -0700 (PDT)
Received: from localhost.localdomain ([187.39.20.187])
        by smtp.gmail.com with ESMTPSA id s22-20020a056830149600b005b24a96174asm9700619otq.8.2022.03.22.22.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 22:40:39 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] ata: libata-core: fix "it's" typos
Date:   Wed, 23 Mar 2022 02:40:01 -0300
Message-Id: <20220323054001.17344-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Use the contraction "it's" instead of the possessive form "its".

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c854aebfe0b..22c93589f2c4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1398,7 +1398,7 @@ unsigned long ata_id_xfermask(const u16 *id)
 
 		/* But wait.. there's more. Design your standards by
 		 * committee and you too can get a free iordy field to
-		 * process. However its the speeds not the modes that
+		 * process. However it's the speeds not the modes that
 		 * are supported... Note drivers using the timing API
 		 * will get this right anyway
 		 */
@@ -5603,7 +5603,7 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
  *	Start and then freeze ports of @host.  Started status is
  *	recorded in host->flags, so this function can be called
  *	multiple times.  Ports are guaranteed to get started only
- *	once.  If host->ops isn't initialized yet, its set to the
+ *	once.  If host->ops isn't initialized yet, it's set to the
  *	first non-dummy port ops.
  *
  *	LOCKING:
-- 
2.35.1

