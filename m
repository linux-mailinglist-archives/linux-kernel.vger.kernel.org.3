Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4D497823
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiAXE0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiAXE0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:26:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8EC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:26:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so8931497pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=wg8p6MJoeXN1GheWHqOGh696C/oxn1QTFiYK3wt4Tk8=;
        b=HSKGIMxHPF0hjmGxZ7JnR8ZIymOJus9qLm27mkGXkFuSX0+AgExwJ56EGzvyG1Gzfe
         UI64p1Ar1V6vyHEH6ecabD8nhpmzlHy1Fwv/MTIYwKbSACopW+mUMwJ9dTkCFzPfMfxw
         XRm2H2dF8uDmGfCXmxx0dlJvXWyYo6vOsFd/H2Z9OjwOOfm+6SHKqUZ71qM9yNlLZ900
         m0p0uUt0x5aCV8sc4bNRj4hR0w2fZZS6TeZPDRhMHxhVwSgLe5hXEORwIrrdFjSR/r+c
         KjPSQnWhjhZOUsfggnxoh2I60/3RNSH9bMaurInM7SD4pKaBxW04HqNl4YGgOA4AkDKl
         FePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=wg8p6MJoeXN1GheWHqOGh696C/oxn1QTFiYK3wt4Tk8=;
        b=yFXFK7cgGYYhugvWp7Q5q1tgVgjFvzmMC+ew33hD546zv1n4HlcILJySQhRGegWrzD
         PuZbhg6YUF223iIhhVrDXuJfQI/wTbO/iv9gHiLdo5X1O3b7PggPnLbf0YYK71Ym/fw6
         7vQ9qFQRA3ux0Ui0NbXKeeo9vandbcCZdiklGU8EweAWbjdIRJZD+cxM7/10M0HZYz3B
         wEhl4aB60+PJCGaXaLdjybLXR4BZ5jTSRcOZa92cmnsfCk3KGkLqXshA17jA6qdVUIAn
         QwhlDmctB3VG/MxPLlOOgSYSGkjlf42n+JYga0SeVVWb+3iqZPWPdeKj3PbB22pl6sqv
         sj1w==
X-Gm-Message-State: AOAM530ubMUvsdIwdQpZXwt+8fhM6s+Q4ihGFF15OfILbz9KO8mcGd3I
        j0XggA0VVEI8rO8m2N5W58A=
X-Google-Smtp-Source: ABdhPJxFGme3GKnWg91F82NBmqrmlLAp9xb2nFQdckwfSvKAecraKNcNxVAgPLLCvv9uz1LlfwzwtA==
X-Received: by 2002:a05:6a00:2189:b0:4bc:3def:b662 with SMTP id h9-20020a056a00218900b004bc3defb662mr12747565pfi.5.1642998401887;
        Sun, 23 Jan 2022 20:26:41 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id l10sm2070853pff.44.2022.01.23.20.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 20:26:41 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:26:36 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: pi433: add missing register contants
Message-ID: <20220124042636.GA7962@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124042506.GA7662@mail.google.com>
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

