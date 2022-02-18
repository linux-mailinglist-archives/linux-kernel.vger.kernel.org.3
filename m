Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF34BBF57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiBRSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiBRSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0E36301;
        Fri, 18 Feb 2022 10:16:52 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w13so5254947wmi.2;
        Fri, 18 Feb 2022 10:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETcVMH7Xr0E5efOZr2jk0ulPirFO8VUQbOlOEWLlTGA=;
        b=OBrG2ryyfhgdHOGpeDi7AoYwrGWdbVPm2RUjXjFLEK6YcFHAhj4u4QIqRqYQhF3UHE
         DOn53qAOt390Zh3ErdSxCPQIp5aQ+2zKFNyBPmps7fjZIiK3B3IudeYggkG1oW9RyjdT
         gK8o8Y51H7N8nbTcBHgYGDyNuT0qxx3JKAeqt8Cl7G6CSRPeKjuhzCQpdR/Nan1a+tm3
         zufVJsS0Yto5VTIjvLfBc6iESZsiRXgb7U6pSRHO/JtZMv+H1c34bWSNvkq/aWQbO67t
         H442LAN4xyd6RNOeguRqEv6MjUm1DIeF+v7V0BjsWsw+IfWKKj0L+QIXINbNbvxBHosV
         /30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETcVMH7Xr0E5efOZr2jk0ulPirFO8VUQbOlOEWLlTGA=;
        b=OFRKmGJwVGO7sH6rLx6C+Rjr8L422Gc+RXFvFtQEDfqpy7oScS55i+BSI1YTKYAGxK
         ovmGJY2tfOpxxL6HyXTILW1HHn2l7BF+Y+SSytYURoYvtVjL1uN1X8HSxaXvmmwZ+hho
         9a6zh3EZGwfDkLQPRBsTiAAZYutz+0c4aqW/SSicoZ7WQM5Prq4lPqgeNdNgmKeLrEx8
         cUa45ZOSWCzCDTJGtLLX4N2POSgrEcRwTdhYg38+d9SBu3YcrR+ClYVraFf0EVksSe9z
         SjFK/r7GY4a/fuXMberheayWTspFqy5Y/Huag1+SoUDRXarTTy6oTrh/XJ0Sv9D3MG7V
         KOzw==
X-Gm-Message-State: AOAM530wp3iAjBZaYQ+XrHbIWJt78f2vv1RclW0b5/qXPJT5m+yQR9S8
        levDksDTUBcvs0ASBVw998E=
X-Google-Smtp-Source: ABdhPJzoubtI1LUd0IkrwtzvoBvjnX7U0ve1cBkdshNXS9MB2fQMBtFEa18QojEraqFDTutoictQ0w==
X-Received: by 2002:a05:600c:1e0e:b0:37c:6c82:72a6 with SMTP id ay14-20020a05600c1e0e00b0037c6c8272a6mr11603865wmb.35.1645208211504;
        Fri, 18 Feb 2022 10:16:51 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:51 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] scripts: kernel-doc: Refresh the copyright lines
Date:   Fri, 18 Feb 2022 19:16:28 +0100
Message-Id: <20220218181628.1411551-12-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
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

I wanted to clean up these lines, but in the end decided not to touch
the old ones and just add my own about POD. I'll leave the cleanup
for lawyers.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---

Still credits go to Jonathat Corbet for alerting me when I moved them to
POD in version 1.
---
 scripts/kernel-doc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index a5a397e22ea7..f06f68f3c3d9 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -12,6 +12,8 @@ use strict;
 ## 								 ##
 ## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
 ## Copyright (c) 2000 MontaVista Software, Inc.			 ##
+#
+# Copyright (C) 2022 Tomasz Warniełło (POD)
 
 use Pod::Usage qw/pod2usage/;
 
-- 
2.30.2

