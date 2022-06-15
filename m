Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B154D4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiFOWuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347059AbiFOWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:50:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44AF563BA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:50:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1852017wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slLd2M4FeFuQ75PNi/iVPJrjSxRl7uO5CbDqnGxyUvc=;
        b=oTapA6GkI2BtG0p+MMpdoIzvXyo01oiPJm0f7r35RnvqMheuC3Y0SGUmKPcchEOI+l
         X/IFrfA0r1Xdk90UO92fS1UZO2V3+Zxy+6T9BAbDWu+hT+onTeGkUdCjmkm2bGmbhs07
         HAtDNgARdKzNUsUEzFroiT1zTwmmsCKyytd7VpnMbKQGuyV/PQrYeI3B4nG+/TL7RQEm
         F9Hd98jHe2ijEcKuNbGaCVgWRgwv9zjssDDtWqnl4BXNGIdoMRO/pkueUFHBKQ/2yi+5
         WitDbKslL4VTKOCKaGfrg+pxr3ZcD8wAKeSggMOH8Qli/c/5RLVemkbAlFq6MXMwLrMT
         04oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slLd2M4FeFuQ75PNi/iVPJrjSxRl7uO5CbDqnGxyUvc=;
        b=rrxhf1DJzT7jvzojN8D1cks4iV+fFtG+qhuT9EGchA2wxI8+lwlrTHKCHDZSsNP5jC
         Ov7t43Botff8GaDHPjoc/Eg2qJfmqDN6/Wet8D88eL0HbhUjA8KgN3woNalfL7yyRa9S
         whKLmv4EF+53F7FIDgCPHtwmAukvATuhZe33svwQKB6TxY58CWugBRJxEKwqREPnfaZ4
         yVfbGLSjujSwPWbBNup3PJ/Y/7im8hGECERvny38LjlLEy2pgVrf57ee4ii3tintHxHV
         BYPx1+vVKMEDQ5dWZeGYUs2EucGr0UBhPYTtN3pqIZPhMjgsy/xxm7ECqo/J5RNoW3Sh
         Dzug==
X-Gm-Message-State: AJIora/My1QDeJf+AqQ39KgxozXbpAFcjSg3f0xWw3N0sSrCFlaxTZEm
        hKhuiwnVFLi1FDHg22KDKlg=
X-Google-Smtp-Source: AGRyM1tRcpj9XQ2aBF/NhWHk9JkyWVC+LaflvE+dirzykkZPI6kRXeb67v9goXcwEDacSvexR3ouUQ==
X-Received: by 2002:a05:600c:3b8c:b0:39c:60e3:36db with SMTP id n12-20020a05600c3b8c00b0039c60e336dbmr1747400wms.77.1655333413253;
        Wed, 15 Jun 2022 15:50:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h18-20020a5d4312000000b002167efdd549sm186571wrq.38.2022.06.15.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:50:12 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] mailmap: add entry for Christian Marangi
Date:   Thu, 16 Jun 2022 00:50:12 +0200
Message-Id: <20220615225012.18782-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add entry to map ansuelsmth@gmail.com to the unique identity of
Christian Marangi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index dda0030573ca..2ed1cf869175 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,6 +87,7 @@ Christian Borntraeger <borntraeger@linux.ibm.com> <borntrae@de.ibm.com>
 Christian Brauner <brauner@kernel.org> <christian@brauner.io>
 Christian Brauner <brauner@kernel.org> <christian.brauner@canonical.com>
 Christian Brauner <brauner@kernel.org> <christian.brauner@ubuntu.com>
+Christian Marangi <ansuelsmth@gmail.com>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
 Colin Ian King <colin.king@intel.com> <colin.king@canonical.com>
-- 
2.36.1

