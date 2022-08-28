Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D55A3C78
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiH1Gyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiH1Gyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:54:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4954C9C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x93so6514348ede.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=zlbBwhELsS9ncIi7cmLrnHeCoFJ5J4VqFjmk0yBsOK0=;
        b=n+MTmaYheBrwbksR3a1pDVrtDWAnuQKMmAfl6FgMq5c8w61sNc+o9hU4YQL1hOhr6E
         4Fd83XQCdKqOrpzmc0+27X6tQ/pAtV9EKrtsQ738dJawp2F/IwzoJ+zfjwUlS2+WiX23
         5HdtAnnubtt76SsuF2P2nM26lLk97NQBl/x7RWNDPgRQsqdMCCInOYLCNyXTs0OKF07v
         jM+wKDpAzqFWF3wrAtSN58ximxfh+KFiJtpovD0M6b4oqKNNkHatP1dtx+YKWutk9NeO
         sBzwr+LzJTv6w9bwYwygXJBIHWZkCDXb0qSYfPaPuIxuMrmOskK2YFwh6zdQ2oTo0arg
         TwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=zlbBwhELsS9ncIi7cmLrnHeCoFJ5J4VqFjmk0yBsOK0=;
        b=W5sGbYDjG1deazK9OaIvCt4S2UtkSlw7I9PvLIo8QnZOqYqwTXDlkwlvf2IZed0iLL
         vqchGgEibuvuzH2rwAylC7tNbhdkVqScHMQTOSqU6jnj51erxPtP25SuBLxDAE9Jv4qV
         ErToRYK2pdLlSmwJCwyy5L2Of7knJQOi9iMueMwbGFEmytM89fR+4g6RPJJsoYqJ5VLD
         w219uNwVWg4uz9l3nGR4eL8ndjbxuunAyDxL/m1+8ZyWuo1P84Eegs7vp//se/adPCUb
         /J91mN4GYyztNbABr137QiuTW3J+oTxFMm6Qcg+/K0bpiBxoF59SkCknguQL7l0s2nQe
         Y4sQ==
X-Gm-Message-State: ACgBeo0fcuhcgzhzQOEUclRihwId5oZMsaQlnQ3+naAG0fIHFSZOYiDq
        scC/eaFQWKfTsjpoM7uNt4U=
X-Google-Smtp-Source: AA6agR56QllEkOcl6kLrpUeTLopr8djB51cgB/WfYnU3uDYGuPNru60dfO8/RUPyJteV6glFYoh2EA==
X-Received: by 2002:aa7:cc05:0:b0:447:8654:7fa9 with SMTP id q5-20020aa7cc05000000b0044786547fa9mr12325311edt.298.1661669672826;
        Sat, 27 Aug 2022 23:54:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id d25-20020a056402079900b00447e2aeeba2sm3755535edy.27.2022.08.27.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:54:32 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:54:30 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] staging: vt6655: Delete function MACbIsIntDisable
Message-ID: <2cf96b9b7cf576bdd9d17e54acbc765690b7900b.1661666677.git.philipp.g.hortmann@gmail.com>
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

Delete function MACbIsIntDisable as it is unused and the name is not
accepted by checkpatch.pl.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 24 ------------------------
 drivers/staging/vt6655/mac.h |  2 --
 2 files changed, 26 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 7363dfb04ba8..edd941c4f9ee 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -11,7 +11,6 @@
  *
  * Functions:
  *      vt6655_mac_is_reg_bits_off - Test if All test Bits Off
- *      MACbIsIntDisable - Test if MAC interrupt disable
  *      MACvSetShortRetryLimit - Set 802.11 Short Retry limit
  *      MACvSetLongRetryLimit - Set 802.11 Long Retry limit
  *      MACvSetLoopbackMode - Set MAC Loopback Mode
@@ -103,29 +102,6 @@ static bool vt6655_mac_is_reg_bits_off(struct vnt_private *priv,
 	return !(ioread8(io_base + reg_offset) & mask);
 }
 
-/*
- * Description:
- *      Test if MAC interrupt disable
- *
- * Parameters:
- *  In:
- *      io_base    - Base Address for MAC
- *  Out:
- *      none
- *
- * Return Value: true if interrupt is disable; otherwise false
- *
- */
-bool MACbIsIntDisable(struct vnt_private *priv)
-{
-	void __iomem *io_base = priv->port_offset;
-
-	if (ioread32(io_base + MAC_REG_IMR))
-		return false;
-
-	return true;
-}
-
 /*
  * Description:
  *      Set 802.11 Short Retry Limit
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index ca1211aacec2..cc5d2493375b 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -549,8 +549,6 @@ void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, cons
 void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
 
-bool MACbIsIntDisable(struct vnt_private *priv);
-
 void MACvSetShortRetryLimit(struct vnt_private *priv,
 			    unsigned char byRetryLimit);
 
-- 
2.37.2

