Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77A4550E29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiFTAp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbiFTAnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EFC31
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o73so6882163qke.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xv+tIa48UrOnTpHHPCzrOKYFNSv+Nn5TCx9go9g+iVw=;
        b=eaiXZoK60MvQ2CdtXu2PKhXT8ZplmCpv6qZBmPhhRT6rU2xYRyXdZB1+R8eXU1S/qT
         HhozAYwmzcVyoaCt0qvx1Syis9C82cWy/ZWngnhXuo1SInk+5vmM8qPqTAB6iNBlVEm5
         qXeOiX8WY68mu+PI5TUIICPdFSNaBtfIw84y9jtE1YWKTEoqOOkxnngPKLovgYlEoPnU
         HbUboPBVLgLM0sMuy9GDMTxY8OKmk3+ujgOfgWSOaTNgxjH1EminncL9p9ytrwV6+hoG
         VGibstPfbF0Ff2sntd85ZRZqAJjyA5J62LM0NCWVXtR56CN9omTm0Z5LgE1xyRuNGK1X
         rxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xv+tIa48UrOnTpHHPCzrOKYFNSv+Nn5TCx9go9g+iVw=;
        b=29rEK/N+IgBffi3vwZuYf1SKgQLK8WJNjm11yK6nRkUKPQRl9UnzU7YEroJjy/WXSl
         7hSXG8HNYYzKlDdkW3OMsThgED7e313M5okhmO276q70fc467Dj0+5TFymW7OxrfFjmI
         PYIcyHP0QmREnG7fVKw9S8tYv6KMXGybdQVPpdJKnTHejzT1zJyrRpjvPt+gCjJ/NSsI
         KVLLPZNP/kH0+CJDiMU01go2gfQJRxT3mzmyAVVFnzIJmsF4D46UQ7ItHOo7o6pcJJsL
         h1kLY+BL19m6PV/8wrgZA9zSnul5NKnBW6eD9WTee0eQcxWbeI2mGrmqllkv3KZ06FLI
         R5Aw==
X-Gm-Message-State: AJIora9LdbievqRqD+aBblxwKv6zpjxnBROsFg7GJgPFGmZvAvs3kE5t
        hLjQYTVjzITtnRLD64PN7kamrnihHkKJ/V4=
X-Google-Smtp-Source: AGRyM1sSYBZpSG6ZKIG2kKHTTolELNxubEJe5pVBUEcpCqD1kkcqL+HgabyrFTApw9T4QrGr9yrf9w==
X-Received: by 2002:a37:98b:0:b0:6a6:b2ca:194c with SMTP id 133-20020a37098b000000b006a6b2ca194cmr15003040qkj.470.1655685827787;
        Sun, 19 Jun 2022 17:43:47 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bj6-20020a05620a190600b006a73ad95d40sm10706091qkb.55.2022.06.19.17.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:46 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 32/34] ACPI/APEI: Add missing include
Date:   Sun, 19 Jun 2022 20:42:31 -0400
Message-Id: <20220620004233.3805-33-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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

The upcoming patch to switch tracing from seq_buf to printbuf means
we're no longer pulling in headers that we used to; this adds a missing
include so things don't break.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/acpi/apei/erst-dbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index c740f0faad..90aa034dce 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -11,6 +11,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
-- 
2.36.1

