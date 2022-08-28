Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB835A3C76
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiH1Gyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiH1Gy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:54:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000A550A8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so6684162edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=7dMyYYgs9WG1YLzH7CIuB16LlkbU7Y/AywSYT+BK2ig=;
        b=KnMWxfi7QHTJlijEKWqkumgHp7DdX2xnw4KAyM7VzAgtWKDUEyo4UoyF5wysv7/W20
         vynQ/HYTjl911T8L8A8vkPZQox39hUpOnHN4SF5mAWlCyCx945WJwQ1rPAuxTau9pEGL
         gcJE25I87KWu+lZLzxeF9PoA42/6pPbMDZsnVTJnK8f7mdc8tpWxpuHIqQFWbSGsN8Lk
         0h3yUpGLpXKjGP1fRxABNUHjY9oIm/4XDP7RC0LkVdFFnPjhb9HM9A37O2xzQlDGMFcR
         AelreFO3+zzYVOZsji0mYZuArLTlrZGFi4BNeF7SVELJRqT9mZswxHweQXmxPlOhxRQO
         VZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=7dMyYYgs9WG1YLzH7CIuB16LlkbU7Y/AywSYT+BK2ig=;
        b=oG8Jle2T+NFUi2XAJb8W/br9XJRK2bfoAgcB8pi6viBlwxMPXpmdwvegoph2T97Sxo
         niXLXygJplMg27EphhECHNKxLK+GH9B1VWRQO6PFCiBBteC3qQloApsX7xuZ73NLaoUD
         LHDTFeufme56oSx+5b3Cc/hK9Wndj/UBApnbjsnhnBomc7XYUcoS2+U7jH98MaZWitbM
         DYcaPkBskBF7KEywNt/hDD5ZkUTCZ+FnxT436zinA/wVsc7F1JBohIJmM1p6EykuyzKK
         WPA6sIqztOWVuX7tKY+PM3CrLfBl9ok7NLbZ24f1F/VuMM9R+Eyg49zD2HhKTlxobVBm
         3G1Q==
X-Gm-Message-State: ACgBeo2yp14XshVUmybyUQ5va56k28j5f8Lpbrg/0qOXy4z6SxBRd9k/
        CzV5eFh+qiHPs1O3p1nN1MH5es/BHpE=
X-Google-Smtp-Source: AA6agR48Ilm2GhMQdjKbgeWykFXkbwEZw1Lcht+JFV0dBV4KT38eBvoNqVjbi3xZMLScG5cl50jLqA==
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id fg9-20020a056402548900b0043bb935db37mr12714463edb.347.1661669661330;
        Sat, 27 Aug 2022 23:54:21 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o1-20020a170906768100b0073dddffbe70sm2867422ejm.224.2022.08.27.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:54:20 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:54:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] staging: vt6655: Rename function MACbIsRegBitsOff
Message-ID: <79530d864d4e39e29b899b80f2e2ecf0566366dc.1661666677.git.philipp.g.hortmann@gmail.com>
References: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of MACbIsRegBitsOff as it is not needed. Rename
function MACbIsRegBitsOff to vt6655_mac_is_reg_bits_off, rename
byRegOfs to reg_offset and byTestBits to mask to avoid CamelCase which
is not accepted by checkpatch.pl. Made function static to keep namespace
clean.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 15 ++++++++-------
 drivers/staging/vt6655/mac.h |  3 ---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 742391b24afb..7363dfb04ba8 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -10,7 +10,7 @@
  * Date: May 21, 1996
  *
  * Functions:
- *      MACbIsRegBitsOff - Test if All test Bits Off
+ *      vt6655_mac_is_reg_bits_off - Test if All test Bits Off
  *      MACbIsIntDisable - Test if MAC interrupt disable
  *      MACvSetShortRetryLimit - Set 802.11 Short Retry limit
  *      MACvSetLongRetryLimit - Set 802.11 Long Retry limit
@@ -86,20 +86,21 @@ static void vt6655_mac_clear_stck_ds(void __iomem *iobase)
  * Parameters:
  *  In:
  *      io_base    - Base Address for MAC
- *      byRegOfs    - Offset of MAC Register
- *      byTestBits  - Test bits
+ *      reg_offset - Offset of MAC Register
+ *      mask       - Test bits
  *  Out:
  *      none
  *
  * Return Value: true if all test bits Off; otherwise false
  *
  */
-bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
-		      unsigned char byTestBits)
+static bool vt6655_mac_is_reg_bits_off(struct vnt_private *priv,
+				       unsigned char reg_offset,
+				       unsigned char mask)
 {
 	void __iomem *io_base = priv->port_offset;
 
-	return !(ioread8(io_base + byRegOfs) & byTestBits);
+	return !(ioread8(io_base + reg_offset) & mask);
 }
 
 /*
@@ -767,7 +768,7 @@ bool MACbPSWakeup(struct vnt_private *priv)
 	void __iomem *io_base = priv->port_offset;
 	unsigned int ww;
 	/* Read PSCTL */
-	if (MACbIsRegBitsOff(priv, MAC_REG_PSCTL, PSCTL_PS))
+	if (vt6655_mac_is_reg_bits_off(priv, MAC_REG_PSCTL, PSCTL_PS))
 		return true;
 
 	/* Disable PS */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 2af243b9389f..ca1211aacec2 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -549,9 +549,6 @@ void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, cons
 void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
 
-bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
-		      unsigned char byTestBits);
-
 bool MACbIsIntDisable(struct vnt_private *priv);
 
 void MACvSetShortRetryLimit(struct vnt_private *priv,
-- 
2.37.2

