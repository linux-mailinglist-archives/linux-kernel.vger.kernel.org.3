Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4F483A69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiADCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiADCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA1C061785;
        Mon,  3 Jan 2022 18:00:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so11318308wra.8;
        Mon, 03 Jan 2022 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88NWVxoXqyug+IDUMWZAyItnBanJj1QoR3rF3JESF/M=;
        b=BkN2LIaXhLNIXriMIqJhAfPKR+kLuNNywIOKmi2YdnBtrN7WLSM6ujDLhGCGe65lQn
         iuZhp3Mj1IQSJADj1nlGcdTmoVAdKof/rmkF7SE+KymeUBeit5BZtoGCiCEUX7PPzjgt
         Qyp4tOllBoIfvA1PV4JkVudp+0yp7F14QTWrnt45xFOXUp54XTnh16DZlmkxS0aLB45h
         f0rsyYkdXrP4SzdFrEun2uFuUjntksSpjI9WbP/BGIrK76C/G6YzLCWvxHf/UHMBGUZV
         bF5cV6GpUzusMNYXqg0i4rwAgkYuCI8AFh8PfH8tj7zxddsTlRj849F7e2SmohclNsr+
         2WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88NWVxoXqyug+IDUMWZAyItnBanJj1QoR3rF3JESF/M=;
        b=IN1F+EhrqbjmF3RUJV/RElAlKtd/+Vd1b28A12dAgewJgpGpbsoR3jAQQH50cbAUiB
         v4dlVgb4IFMYwo9M95yX0NFoKWIb8L0wTdOxC/br/rXs8w8Ctb0EVQ1NEboi46jZMMAB
         a8otOU8PCp5PT1p31SAaTDPO2FH+2+qhe/QVkowFdr2gpvw5wJ9TkaTHIqNLKeWTwLlO
         wVNLlAxre9Bp8IX7QBSnf52dvRHohRtlOmSjCv7bz5Ho7oDtREOP94/2AwqfhJz4m6Eg
         eU/ZRgMKryHmeslmNwY1ncQita8mYz3u0mW8ISAEOay8qNUmEW1Hejl6IDqLBBj86wu+
         PHgQ==
X-Gm-Message-State: AOAM533UO74zrEBdg2v17Y1gsW7o+BoZLcWV3nVmHsVkz2F5iEew1ifj
        rek0YQApJPPg67NngQ5LsvM=
X-Google-Smtp-Source: ABdhPJy8K0NsmRGuNIRtv+7ls0n2bKRuBIJTYKZlBW2zjTWvHKlCy0zapkGURk3oK7arfq6K34DcyQ==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr40104006wrx.665.1641261611748;
        Mon, 03 Jan 2022 18:00:11 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:11 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] scripts: kernel-doc: Refresh the copyright lines
Date:   Tue,  4 Jan 2022 02:59:45 +0100
Message-Id: <20220104015946.529524-15-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure, why these notices need to stay at the top, but that's what
Jonathat Corbet replied to my version 1.

Anyways, I've cleaned them up a little. Looks good?

My name's included as the refreshing force of this venerable script.

* Transform documentation into POD (14/15)
See step 1 for the series details.

(Still not sure about this tag line, so please correct, let me know, etc.)

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e4de593dbcb7..dd5801cad519 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -4,14 +4,16 @@
 use warnings;
 use strict;
 
-## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
-## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
-## Copyright (C) 2001  Simon Huggins                             ##
-## Copyright (C) 2005-2012  Randy Dunlap                         ##
-## Copyright (C) 2012  Dan Luedtke                               ##
-## 								 ##
-## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
-## Copyright (c) 2000 MontaVista Software, Inc.			 ##
+# Copyright (C) 1998 Michael Zucchi, All Rights Reserved
+# Copyright (C) 2000, 1 Tim Waugh <twaugh@redhat.com>
+# Copyright (C) 2001 Simon Huggins
+# Copyright (C) 2005-2012  Randy Dunlap
+# Copyright (C) 2012 Dan Luedtke
+#
+# #define enhancements by Armin Kuster <akuster@mvista.com>
+# Copyright (C) 2000 MontaVista Software, Inc.
+#
+# Copyright (C) 2022 Tomasz Warniełło (POD)
 
 use Pod::Usage qw/pod2usage/;
 
-- 
2.30.2

