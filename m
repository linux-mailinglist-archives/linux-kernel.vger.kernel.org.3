Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C667572CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiGMFBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiGMFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:01:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C52DC1A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z23so1298888eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J60Rmir7dSGsldLQfgkvKBUxKvKSm5Gzr4J1SAOmK5U=;
        b=JX2G6QvdmHYEry9ztvQ0t9LMZSSolwIgpsrpzXtir81krUCl0IYMB1JiycXMrY8ylj
         Pl+pRHJytw4iP+Je/VpS810EJOEL1clBC3xYGEnrJwXBQgkmz4zpa8qbdCwAxBbtDeuN
         0jAkc9innJmuUqpIIgrL4RG5See3SyO7onALBWdfYf8+uabuoESL2a/+bFm4KdJAakj1
         zffwhAabqWd1XN4CNvtAhZBnmIbScc4ybJZByXxkuof+G1ForJLaf8qn1lX4t8dYPpD7
         BKiwZoYkV0ZWy2su0UbYR0yJ9tm0ML2yHosEgaYE+EKxXGsoYCxH9N+oTcs+CdXXCjYG
         e8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J60Rmir7dSGsldLQfgkvKBUxKvKSm5Gzr4J1SAOmK5U=;
        b=LlF4K3yUaJehJVkK0KKcJZ1SPRrrwSJAz2WX230SFgcpfc+9Wcfd9DKygpXqijXR7b
         lCX9dHGpu0lRDVR20wvUGwGcrzszyNirnqGvlz6xio1sP+3xeNqaUsL0VeWe9xdUVpmG
         vvzByHHaE7V1etVvUwK8cr5JFw3GoBGQeKgd6nPyQ2l3AnzHSQra15Oztj8sBidAFRZX
         nL43IaD6s1PD4IVtKW8WgdsxWs833/fI1+ef4tYn63vkBeGVKnVD25drtyB3S/C7SD65
         CZhFA1jupMH9PnaAj7gbYBsKT6sOANV7+ZoQHjZJvSAwV8uHPsXzrVoSs49de8IKTy5d
         yLaw==
X-Gm-Message-State: AJIora99V0pIDUCiXtWU0oXt/ULfrlFPrEniLLxm8p78NzAKQVpBqIjJ
        hyV9B5U7xYuxxEz43S34Yv7JSkaz6nw=
X-Google-Smtp-Source: AGRyM1vGQMK7US3OWpP6uHM586Znd8FlSDd2lLKAhBh28Hjc/P7dEV58L5WtlyewsCX1RQD4oR8Bqg==
X-Received: by 2002:a17:906:9b93:b0:72b:8fad:6cf8 with SMTP id dd19-20020a1709069b9300b0072b8fad6cf8mr1510599ejc.415.1657688461017;
        Tue, 12 Jul 2022 22:01:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906c29400b0072ae174cdd4sm4518015ejz.111.2022.07.12.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:01:00 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:00:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] staging: vt6655: Rename MACvWordRegBitsOff
Message-ID: <b8d4b72ddfdefb6b8a73fb95f6851e0f365118ba.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 12 ++++++------
 drivers/staging/vt6655/mac.h  |  2 +-
 drivers/staging/vt6655/rf.c   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index ec70a1f611d4..846469cc06bb 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -352,18 +352,18 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	switch (priv->byRFType) {
 	case RF_RFMD2959:
-		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_TXPEINV);
+		vt6655_mac_word_reg_bits_off(priv->port_offset, MAC_REG_SOFTPWRCTL,
+					     SOFTPWRCTL_TXPEINV);
 		vt6655_mac_word_reg_bits_on(priv->port_offset, MAC_REG_SOFTPWRCTL,
 					    SOFTPWRCTL_SWPE1);
 		break;
 
 	case RF_AIROHA:
 	case RF_AL2230S:
-		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_SWPE2);
-		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_SWPE3);
+		vt6655_mac_word_reg_bits_off(priv->port_offset, MAC_REG_SOFTPWRCTL,
+					     SOFTPWRCTL_SWPE2);
+		vt6655_mac_word_reg_bits_off(priv->port_offset, MAC_REG_SOFTPWRCTL,
+					     SOFTPWRCTL_SWPE3);
 		break;
 	}
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 16f2b77e1371..4d328b724559 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -558,7 +558,7 @@ do {									\
 	iowrite8(reg_value & ~(bit_mask), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOff(iobase, reg_offset, bit_mask)		\
+#define vt6655_mac_word_reg_bits_off(iobase, reg_offset, bit_mask)	\
 do {									\
 	unsigned short reg_value;					\
 	reg_value = ioread16(iobase + reg_offset);			\
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 6953afc0be34..1fadc2fc4412 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -212,7 +212,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL,
 				    (SOFTPWRCTL_SWPECTI | SOFTPWRCTL_TXPEINV));
 	/* PLL  Off */
-	MACvWordRegBitsOff(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
+	vt6655_mac_word_reg_bits_off(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
 
 	/* patch abnormal AL2230 frequency output */
 	IFRFbWriteEmbedded(priv, (0x07168700 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW));
-- 
2.37.0

