Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB35305A4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbiEVTuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350584AbiEVTtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576539BA2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg11so16671196edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eultuTEo5w5eygrW9gVkDvFHvAk3bhGxWLnJbMnNQas=;
        b=dmk5A5Gk2wv1TJq84Ek34IX1JOsZb9SGnbiTbrmaPhS1PU5mIki4hE6pBQ2uRPJXWH
         29SLdEoR98gF7l3bvjtPoXekV/57Gz+49xU/p5mNkpS7SfkoMNhC1fITQOPO8CM1xXWo
         Axg+ibMEkqjczg7HjvYMQ2FD/4dugG8Jh6OWAu1BzXoo7sO4Ph/rfAbPkZ+715sJU4Pa
         9nnQqywU1bLkUe+aFOPDNNcxHZ+F73J5C+6RsfJQPcQyA2A+swbS6CH7IhFSXtPNlYl9
         rAq6rOpv9PY3KZFUslCkUCH68Pysw2Ada47K9dBlj2Frpl70gsSexlWLyIuB49m40oql
         S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eultuTEo5w5eygrW9gVkDvFHvAk3bhGxWLnJbMnNQas=;
        b=fFldaRmm4LIv1I+wELq15WD4TE1FpVRczD0A1IqWyLZYblOqaM+fhcNQaEWZmwdE/C
         pd7AJdwxhFIsVuKgWMm7QZw7GeUtocFsGOMTsgKcKoo43iWXI1EGjKuHEdpPZIF2Gt0S
         8YMYglGQ0vavJ8YcQfIhk0KoJgVy4fTRZQTNahuOzXo+W8mOkpbSEZNW67OgV1W2Pa/3
         vKpOqHVpW6fny7eNNUTXntd1tUJTDVVwv3H2QfCnNGP8ABJyjVeIdRThcksWkrllEmvj
         WucmjgWm+mWTmFLemxg0VigW/bMmQJu/V7BPadGsZaU/odDO39KJvGfzoa8TxvXLuf/X
         f4nQ==
X-Gm-Message-State: AOAM530pR1I3AmEIDDaQr1qFGHzggFvZ9tvMuxTvMcbnOsCx501EiMDb
        6Rz3OncHD+yZH2L5MldhjP4=
X-Google-Smtp-Source: ABdhPJzyzizf2j0e6lvnG9ZsB8qqhd+6+XCsDStsjRAhRnG39LAWsBq7ksCgTulvxbX57X6ZomwNxg==
X-Received: by 2002:a05:6402:2815:b0:420:c32e:ebe2 with SMTP id h21-20020a056402281500b00420c32eebe2mr21065747ede.1.1653248976241;
        Sun, 22 May 2022 12:49:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906024600b006f3ef214e70sm5318456ejl.214.2022.05.22.12.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:49:35 -0700 (PDT)
Date:   Sun, 22 May 2022 21:49:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: vt6655: Delete upc.h
Message-ID: <b553095c618e7885af5c3e42f9b9b39d95127a44.1653203927.git.philipp.g.hortmann@gmail.com>
References: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete upc.h as all macros have been removed from upc.h.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h  |  2 +-
 drivers/staging/vt6655/srom.c |  2 +-
 drivers/staging/vt6655/upc.h  | 29 -----------------------------
 3 files changed, 2 insertions(+), 31 deletions(-)
 delete mode 100644 drivers/staging/vt6655/upc.h

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 71de3aa7e7c5..102e575c965d 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -18,7 +18,7 @@
 #ifndef __MAC_H__
 #define __MAC_H__
 
-#include "upc.h"
+#include "device.h"
 
 /*---------------------  Export Definitions -------------------------*/
 /* Registers in the MAC */
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 722a2cc9a473..ee5ca4db74dc 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -27,7 +27,7 @@
  *
  */
 
-#include "upc.h"
+#include "device.h"
 #include "mac.h"
 #include "srom.h"
 
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
deleted file mode 100644
index c7966a638fde..000000000000
--- a/drivers/staging/vt6655/upc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
- * All rights reserved.
- *
- * Purpose: Macros to access device
- *
- * Author: Tevin Chen
- *
- * Date: Mar 17, 1997
- *
- */
-
-#ifndef __UPC_H__
-#define __UPC_H__
-
-#include "device.h"
-
-/*---------------------  Export Definitions -------------------------*/
-
-/* For memory mapped IO */
-
-/*---------------------  Export Classes  ----------------------------*/
-
-/*---------------------  Export Variables  --------------------------*/
-
-/*---------------------  Export Functions  --------------------------*/
-
-#endif /* __UPC_H__ */
-- 
2.25.1

