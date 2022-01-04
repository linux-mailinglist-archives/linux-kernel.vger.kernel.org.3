Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D109483A66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiADCAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiADCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A27C061761;
        Mon,  3 Jan 2022 18:00:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so73142140wrg.1;
        Mon, 03 Jan 2022 18:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKt+68jSJUNCPwwNkf1daEWZcboLbqBRutwCXsKv6BY=;
        b=UI4sc8btEpIhbSoPM1g2MwogF/i4FelcSbkK+DTrjL19NrhipgomOZahGVpZlwBeJb
         pItcfr0RI9EGVFuk+kD8+zLY6+e/kYANH9PnnytA7dW1/1gZ8dgHp1uOV35hmgn9BzHu
         okfpFB3srnmqivpiKmDZHwLV5HXcaFQKqf+eBcvMtgB30FBpf08eGvSqtYKsodQbDZWy
         alelCrfAakvEXAC4NdZkUYeNdzSyf6wwL1ql46J313gPPFtSGzk9u8ijweBXiOokapCu
         V2PIRx2t3bkiGcY9JHRQRyp1eaqiUXBZcmbja+rDwpUrLyjUurdsdqVR9y2XngpuBwO+
         QmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKt+68jSJUNCPwwNkf1daEWZcboLbqBRutwCXsKv6BY=;
        b=TBQi26i70XEF5z8UDzRrVri9QbHDLK5Si8gNhYX0jYJ+hMXzMB0FrxKzjsxSE9jz3c
         6MaYKnmyzyMwVUEOsgYU+Yrn+bHi/bWlWfVrV3IRv6LvDDmFd9FCRXjq7Zr3abM7hmEf
         65TeNvNic6As5/VXRTHttGLUB7Z21k/J1pqGw7Jdx4OwV8D9jNMTVrNat5buyBLpG7lV
         3Rv61ITWjzBHMkeRX0RDFseXrSVjxHvhx+LV8S4ADws1FpwqPkvy+g5r8ctbj4kaPqzM
         OTvn6YHCDlGEdp6YFFHdiKZRMMzlivwGdTXLfvr87vu/e2CW24MMjUZSLGHFahmOOM6/
         wwwQ==
X-Gm-Message-State: AOAM530ZZYgfEBzXSYhe/GVVqv4Y8Gnv3ZfUk2CA0WyBo+gJtkJkpzMv
        C7YlaP2YJMjbrqJOKEYKf/7wtpiBuwbpnw==
X-Google-Smtp-Source: ABdhPJyLaTU+gIr+tKJZAQVYKr2HdsiCQWaMs1nmbdo7oiM37vshBWu8HH6tFWqwwwDmsf4qnswMDA==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr39851386wrm.122.1641261610624;
        Mon, 03 Jan 2022 18:00:10 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:10 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] scripts: kernel-doc: License cleanup
Date:   Tue,  4 Jan 2022 02:59:44 +0100
Message-Id: <20220104015946.529524-14-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated by Jonathan Corbet in the reply to my version 1, the SPDX line is
enough.

* Transform documentation into POD (13/15)
See step 1 for the series details.

(Still not sure about this tag line, so please correct if needed.)

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 0be723f6e3a2..e4de593dbcb7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -12,9 +12,6 @@ use strict;
 ## 								 ##
 ## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
 ## Copyright (c) 2000 MontaVista Software, Inc.			 ##
-## 								 ##
-## This software falls under the GNU General Public License.     ##
-## Please read the COPYING file for more information             ##
 
 use Pod::Usage qw/pod2usage/;
 
-- 
2.30.2

