Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0F577891
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGQWUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGQWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415CD1274D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so18271453eju.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nyzrG7hvu7Tya4/vV8pmII/H6wDDB9RTk/WzCNXAw9k=;
        b=M9RYUWBwLBPtjW4ovR1ITfkUnU/FcuZHLn29wzsdn4rBpldeNcGF675pbUpUzFyNch
         l4frv/nTU/6Cw8AjtSyECcnyyk1DuGJ14R8B3QwGt9Ox8pfwR98Ce8gNDNzND0jxZlEl
         OGxGDyQxXTlneyhH7cXYkUfYUFklQ8VfCMNgz0mZfrEf7crtrFPS96tgtfOtns70dLpL
         1fYW7fiqseVLI6XixVxBvjAJFzfeerlLd4VonVzJSR3BAAxagujuF3yz8BNnXCsUyp3x
         DapkBkQZJsGf3VyHlcNo5prpWiNHQ/k85XQf/ki1CklJW80PIEwwIFHd80FJm1FVPdOx
         uMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nyzrG7hvu7Tya4/vV8pmII/H6wDDB9RTk/WzCNXAw9k=;
        b=ABKL5/Sfiq2M19rgxznriHBCxg1GHjaeuSfdODi0p0tLv5rN2Our6gkXsTzDiBAfEU
         HzHQRUpm0dFbxJFaliQestRW8rgD+R2vFBanhNRTGbI9MCTBjWOLOmOC0ENIwbTQszTU
         TcFyqHPR9LAaTlH/zCOk/+AaKWshCBhrzblP4Qc+eC+oNU+/L5PlW1M/PO0vaRroJ+ve
         Zaupw3CUPS/w9OPofVV8Rjjt0QTWvWXTLBZP1MBYdAPU9rszK8+rMFEYKhUqc4iixRNl
         QylZPqzY0i06RVCTQi/O5J47z3b9FoDgLX67F5YhsuXTQc27cSLU4HXw5QXTh+faK4it
         KQdQ==
X-Gm-Message-State: AJIora8SLS28kbUWps8N9RSpyEur6wsJLBmE7p7wzGha0QIG9sjvieL6
        J/K1fB+JbAlCEEjkqrkpwSA=
X-Google-Smtp-Source: AGRyM1sVirgPePIu4omTVkD83lwQdD6wG5OsPsxHaGxqVVpI8eqVl2tSlKgyQDy5hOknN6dZcFCj/w==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr4103463ejc.227.1658096414764;
        Sun, 17 Jul 2022 15:20:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id h27-20020a170906719b00b0072aeaa1bb5esm4775365ejk.211.2022.07.17.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:14 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: vt6655: Rename MACvReceive0
Message-ID: <d66d14075f365d26438c955082649a3e455542e4.1658094708.git.philipp.g.hortmann@gmail.com>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Please read all patches of this series then the
new name makes sense.
---
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/mac.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 92583ee8bffd..6525b7baf644 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -420,7 +420,7 @@ static void device_init_registers(struct vnt_private *priv)
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_RCR, RCR_WPAERR);
 
 	/* Turn On Rx DMA */
-	MACvReceive0(priv->port_offset);
+	vt6655_mac_dma_ctl(priv->port_offset);
 	MACvReceive1(priv->port_offset);
 
 	/* start the adapter */
@@ -1135,7 +1135,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 
 		isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
-		MACvReceive0(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset);
 		MACvReceive1(priv->port_offset);
 
 		if (max_count > priv->opts.int_works)
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index bfcbeb96f839..60e0f980bcc5 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,7 +537,7 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvReceive0(iobase)						\
+#define vt6655_mac_dma_ctl(iobase)					\
 do {									\
 	unsigned long reg_value;					\
 	reg_value = ioread32(iobase + MAC_REG_RXDMACTL0);		\
-- 
2.37.1

