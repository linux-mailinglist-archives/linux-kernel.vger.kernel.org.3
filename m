Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635B497082
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiAWHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiAWHkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:40:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D9C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:40:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t18so12618262plg.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=wg8p6MJoeXN1GheWHqOGh696C/oxn1QTFiYK3wt4Tk8=;
        b=Z5KoJjtZgPXHWPGyZccPdL/lJcb/mQ7GECbsSfRL7M6HJy+PMGI1awX0FoGfuM60rC
         pRBMeIYJhm+uC48B303+0UZhu71SfF7R6XkIadC8ooXKjEUzXKQk98DtuR6lJYdfE3SS
         V8d+zRxfVgQWErljDMjCpiX7sJ1poq76A1tKm37/8wHCPcafx/Qk2zbtUck3RZJA/2/+
         /NvrKv8FTO0HJWFN9YVSdKw7aClpcwWgz7DiDnmwzN9DheiZDVaicxssN6uYxzTrbO+p
         T95m4UNNc/GA25hZb3MmFWK2LRABnA3xaGTbCZ/3fQ1hJOHfyWvDKkR9lS09rm7jcWFE
         XQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=wg8p6MJoeXN1GheWHqOGh696C/oxn1QTFiYK3wt4Tk8=;
        b=68PHRWGws+S+ixBNz1ZFgHxbfJ1mBgZD37XU4pU8MTA+WHM3bBvqaZJWNsCw3sAXpH
         /Vc/KtjB6LPNdkMolwCgIoYYzQkbRcBv0XrO7tbWKEDY8HK7+y69NMQBZ7iC+PMIdymT
         JMOP2zwK5seslaRaYC7d12kE9ZA5t3s4+LWCBOYEuGWo7Pi1NT6ClFLkdzue6Jmv5j1x
         RDsaChUJrwy98sDWJFflZxuPisyVuBSRWtoulbloo/fqADagM27R588jU6d5FXzGogow
         YrAzpIaLP6pVTYvnJorUlTp1xXrbT0FKWi9LQTRyW+5CP1Nj9Iu8QVj8PRvzXzg7nQcF
         N90w==
X-Gm-Message-State: AOAM531Blzdd7desBqjjvzXDbZSzJ3EoIw1ooWEWqtfIZjbOWFaPaozl
        4Cv0OkcfMdp87d8mVkzHPF4=
X-Google-Smtp-Source: ABdhPJzuDEyUTnl7YPXxP9QyvYGomwusttAIz+58W9YHxFIgOV4Qv8GSUbbhFKKI+xxt78vwIs0BGA==
X-Received: by 2002:a17:902:8212:b0:149:af87:9f9d with SMTP id x18-20020a170902821200b00149af879f9dmr9924886pln.39.1642923600885;
        Sat, 22 Jan 2022 23:40:00 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id d1sm11875361pfu.206.2022.01.22.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 23:40:00 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:39:55 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: pi433: add missing register contants
Message-ID: <20220123073955.GA79659@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123073855.GA79453@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add missing register constants present in RFM69 and/or RFM69HW so that
we don't need to hardcode values when referencing them.

this patch adds REG_TESTLNA, REG_TESTAFC constants

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69_registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index a170c66c3d5b..0d6737738841 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -89,9 +89,11 @@
 #define  REG_AESKEY16			0x4D
 #define  REG_TEMP1			0x4E
 #define  REG_TEMP2			0x4F
+#define  REG_TESTLNA			0x58
 #define  REG_TESTPA1			0x5A /* only present on RFM69HW */
 #define  REG_TESTPA2			0x5C /* only present on RFM69HW */
 #define  REG_TESTDAGC			0x6F
+#define  REG_TESTAFC			0x71
 
 /******************************************************/
 /* RF69/SX1231 bit definition				*/
-- 
2.25.4

