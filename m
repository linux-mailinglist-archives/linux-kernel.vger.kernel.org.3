Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7657BB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiGTQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGTQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:24:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4361B0C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id va17so34058395ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1ulf9tl9d6CNgfQ9aU3xsJISTrMA+hS9QZOTqZ3etU=;
        b=B1fpFgIPrLCBw3JbTobhegsCRwhKHLeS3mIn9zQfzDz/igoUAq0LQtKuF76sY7/xlB
         Os0oA4Z8ack8TjxSQfRD2lIPWg5/ZG2dvSLckQfu2xFSHWU/5WPWhWGE3nA/wyKHTsBm
         b2Wp5QP3G3uSHHP0Y0DR8oQA1Qx9g6nPcjIHY/OX71Zfzh7/OU+ribb8eBNV3Uq/sfxx
         hZUUwttFv8X8d/a9+Dhi8rwGWS3mLTF8/zhe1SYse5zngaPzAxl73pZlQ0pmIK4/gTmp
         uTeJjWSlnJRiuWoqNi5cFW8RqHCSa4PDvCt/O79BFhYNisZCQiUXKzm+pDSoKN0Gcysk
         k92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1ulf9tl9d6CNgfQ9aU3xsJISTrMA+hS9QZOTqZ3etU=;
        b=21A2ZjCHwoLNIoMzZpWlLYE0aVnXgk0csRBYhsO4+3en3WgGNWFL7u6MQHWeXU+uXX
         FXz7EjLbxFkkyOusvy6kAkQT+Rbci/5GFRB/I1a6z0/VTVPy2A6ov69spOVNMvyvIgp8
         FtKSUrmyVwG0maFiXZGLlx+xSmkH5GBLhmqwLRwM5DitVortrUt4GHb2JoPsMAJ0oWo4
         N49g+cZ1rrozsvTZ3gN3cqYsihf29qAO/aBZ1ppN+4Nv9Fz92tPQ6uEYrJmPjAyE9fIl
         B200VVryV+ogkzR6h2lwk+KfUJHIFX4C/RZB5Zg5X2ymht3TBKKINsXFqfMqXuE4/pXu
         fySw==
X-Gm-Message-State: AJIora/sMVfLMmWy7qzyN1l9YleXUI93/c/yBa6LrEDxnbtdnDC3YWfK
        rIwolLaIkO0w4+94SO+gTSs=
X-Google-Smtp-Source: AGRyM1sVRsIQGOTj8rTfOADlm8LQIbTlAOZzvnsi5UY8hGwFR93ppZKRk/3ZI9/L//j5JzSWtgYX3A==
X-Received: by 2002:a17:906:cc13:b0:72b:31d5:a899 with SMTP id ml19-20020a170906cc1300b0072b31d5a899mr35255149ejb.184.1658334274296;
        Wed, 20 Jul 2022 09:24:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7db82000000b0043a253973aasm12347559edt.10.2022.07.20.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:24:33 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:24:32 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vt6655: Rename byOrgValue to reg_value in a
 macro
Message-ID: <83920d919acd7596488943182f37132e479d70f4.1658333350.git.philipp.g.hortmann@gmail.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index e2ef8c6ef7b7..837ae9dd6929 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,10 +539,10 @@
 
 #define MACvClearStckDS(iobase)					\
 do {									\
-	unsigned char byOrgValue;					\
-	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);			\
-	byOrgValue = byOrgValue & 0xFC;					\
-	iowrite8(byOrgValue, iobase + MAC_REG_STICKHW);			\
+	unsigned char reg_value;					\
+	reg_value = ioread8(iobase + MAC_REG_STICKHW);			\
+	reg_value = reg_value & 0xFC;					\
+	iowrite8(reg_value, iobase + MAC_REG_STICKHW);			\
 } while (0)
 
 #define MACvSelectPage0(iobase)				\
-- 
2.37.1

