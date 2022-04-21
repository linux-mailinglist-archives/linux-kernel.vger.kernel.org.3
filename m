Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4340550961F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiDUE7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiDUE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:59:08 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8154B1C7;
        Wed, 20 Apr 2022 21:56:19 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e67799d278so464860fac.11;
        Wed, 20 Apr 2022 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9XbwS4JRE+E1xS3jpejPWWOe5/Rhrz8qwuMNjwZTg0=;
        b=M3v8KuS8ddaokuIvZ1DJVjujg21dJoOyry7mIiW60XPNGAKTkpF+HtDsbW944ZeUuc
         iS6KotIgiS69hhM/G+LZDN8NxsucSu8boVsYSIpm6YVbuwfKCZYJ5hJ81xRJjbxbTC53
         Fp+QxOdiIGOZ+4NSJP+DTHUVJgD/PmGaqJrxTyGd3r1AjOQgMq6B1ASXe5Elz5s1MrPy
         HDfUBaPxqHyBDesFQS7T5SryzTtUxvy55OfkfcmsqxjGG7+5vw3DkrBcx6MGEkynOYTg
         /hr5s4I7LrMRXrLzioHMarsXssxkn8NwYa9yzlICpgA/HjHlpvuqKmiGEOTSsS0hNAmX
         2MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9XbwS4JRE+E1xS3jpejPWWOe5/Rhrz8qwuMNjwZTg0=;
        b=AES7rtgXzMrbjNHLBHuHU2LFQItOU0cBiiGALEqoR9qEltkpSNTxKP/AvWcZsazkZq
         U9mmdQnKrS/yK/Gf2FmKWzNkFQ9cKx8eX9lGGDY5ZXZVFde96FwD+ncQX5fnJlEd/enG
         noRo6EAzI7AH4ok6XHPlrCqMiTayX1/LPc0/Imof3337PCYdVDb4iK44zqM6lHmD7i6s
         QMv9mMIa6RjOWA1zwX8mPvtmsioOdu9DIRheEAGqDkoSNpGisdzeWF8FvBMnSyOdDtBm
         2GasrrD3IspTZbUruFBtCdmUh04N8lmm6i6vXDdOq6ve3o8jYxmnT1R5KjH75CgzUR+f
         qWmw==
X-Gm-Message-State: AOAM531XXxnyO9iKA/Sm2kjeRRyk2hF3iYvAPNt+TpANi0pdrPnZvoE6
        hNRYk7rPa53H1+h1RUeZpGSTTd4Y12U9rw==
X-Google-Smtp-Source: ABdhPJyO/cilz5sq3Fk98cPUv6Ij6l7UoZvqEspXy4hyc0XFNEJh382E4c+PkcyifDf22InLHZ3ZRA==
X-Received: by 2002:a05:6870:7013:b0:e5:dfc8:b471 with SMTP id u19-20020a056870701300b000e5dfc8b471mr3050984oae.35.1650516978963;
        Wed, 20 Apr 2022 21:56:18 -0700 (PDT)
Received: from localhost.localdomain ([189.35.230.120])
        by smtp.gmail.com with ESMTPSA id o133-20020acaf08b000000b002ef7562e07csm7140449oih.41.2022.04.20.21.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:56:17 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] ata: libata-core: replace "its" with "it is"
Date:   Thu, 21 Apr 2022 01:54:23 -0300
Message-Id: <20220421045423.17821-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and "isn't" with "is not". The former fixes the typo while the latter
just uses the same formal language.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ca6483764..ecbbd0838 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1398,7 +1398,7 @@ unsigned long ata_id_xfermask(const u16 *id)
 
 		/* But wait.. there's more. Design your standards by
 		 * committee and you too can get a free iordy field to
-		 * process. However its the speeds not the modes that
+		 * process. However it is the speeds not the modes that
 		 * are supported... Note drivers using the timing API
 		 * will get this right anyway
 		 */
@@ -5605,7 +5605,7 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
  *	Start and then freeze ports of @host.  Started status is
  *	recorded in host->flags, so this function can be called
  *	multiple times.  Ports are guaranteed to get started only
- *	once.  If host->ops isn't initialized yet, its set to the
+ *	once.  If host->ops is not initialized yet, it is set to the
  *	first non-dummy port ops.
  *
  *	LOCKING:
-- 
2.36.0

