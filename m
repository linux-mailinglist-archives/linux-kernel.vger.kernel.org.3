Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8E4DA362
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiCOTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351422AbiCOTkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:23 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AAA2A254;
        Tue, 15 Mar 2022 12:39:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s11so131419qtc.3;
        Tue, 15 Mar 2022 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2zVgXnlF97kfQZU4hBwzTBXD9p1KQnPsEAJ23W9Aok=;
        b=nk8cRuI60pQJMdDFYScVdGyJhYGw3hyQEwlLkjLcK1rqyLbjSb41CodrEz7M91a/86
         viGjTEkHnjKF3djf7ieqbT/3sEhDFJm0139+x41ruH3IyyBYoOdl5knGUHiD4pt/F6mz
         bMREAkcW209ChB+fwye7FistKPobJkOmBSWYK0/nJWuyz/fs0YTnJtdX7eGc2JIZAGaH
         cw2XJ/8JZu4A+M72bW9ufmC9TCTl2AugQOVMO7N258yynpuoHXFIAVxjXTyG2d2V+92g
         a4B27660vAIWA9EkPWnLrYr4skqhp1ReM0kyo3r0LnA/+XBG93odDRxpWTghGoFyrf+f
         4r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2zVgXnlF97kfQZU4hBwzTBXD9p1KQnPsEAJ23W9Aok=;
        b=y/tO2pN5L2PqcPB0LJEmk9KTZ9am99HpNL21he1mny1Gpm0cFKYWdeWf3hbeeQOGfV
         iR8vVYu1dZYeLZ2qgz0Mxn3sPm20IeDiHHW5hVE+k5tGr1UzPbZfVeJWXs6g3QJTlNMX
         l5+K0TImi/txVBAe8hWioshlITJ/+cAleupBrkG9I4Qc+tq6HUAadakNX40N8k52fkfL
         N5spKXo6ffRRXEvFAGz5YrQgYk7KjFKdyYnK6OE1nE9kp0viQe0AZsSp3WFi4IpOplT/
         7YyLTrgAhkPVtacRfh6LDP3jDm5gVEn1NlBwookV7jDqqvPUMTY27XGdzSNvcE1DSCae
         y+Gg==
X-Gm-Message-State: AOAM532qf1D4wSa9Wfp8p1Jp+N30JzyP9ClyHIGuy05iRI6eXrmLzICR
        eSd3HHXSJOZBWdnQYPpi3No=
X-Google-Smtp-Source: ABdhPJzRFXiGL4qJknqCgskM7Cd5tXnRJZPk8pOuyRG9nhU+lbPKvIIjh2AYUnUMMdZvOJv7jT7svQ==
X-Received: by 2002:a05:622a:189e:b0:2e1:dcd4:d01c with SMTP id v30-20020a05622a189e00b002e1dcd4d01cmr5781103qtc.1.1647373150034;
        Tue, 15 Mar 2022 12:39:10 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:09 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 5/6] MAINTAINERS: Add Counter subsystem git tree
Date:   Tue, 15 Mar 2022 15:38:56 -0400
Message-Id: <41db1ea7bd9384da99fb332019ddc03067fe5311.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
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

The Counter subsystem tree is now separate from the IIO tree.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ba1e4af2cbc..f4875a9faa2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4951,6 +4951,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+T:	git git@gitlab.com:vilhelmgray/counter.git
 F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
-- 
2.35.1

