Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF1565D76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiGDSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiGDSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:20:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D5397
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:20:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lw20so18004984ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/4mrpFh2VC3VcVrJHlOYXFL5VgTeC9Ovzmvx1towKw=;
        b=VEcDxqNRwQ18kFq8J9qG8BH10PMPS98sEiIlM1yHXXSc65M1DzkaxpssEVqG7QZAT+
         1T0+z1wduMLTcAa81FsyITnrTxjf3E0JCJ+BxlgC/spH/NaOnLVmivxSz8srPxGpZwTP
         c6IC92aH04uxU5rm+MmaE/LVDrqHTgKZVnflBLopeEpSOLTppJkdlCp/qUK4YykROr+G
         mdaB3KslpCDwB9lBoUC79dPtqA5v/WKQ6OQi4THKnhOJ9IUlM01PoPeflzwrZN4s66DG
         fMbZWIkzTA3Kr02DpzBYz0ySnFvokQ6lBXOlrxceYJdwMeO+V8GCm1yzCtKQkc1pGH7g
         rv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/4mrpFh2VC3VcVrJHlOYXFL5VgTeC9Ovzmvx1towKw=;
        b=f4EiZVcUZ32XlpZXGM23G9G6rk8fsoHHI7jIJxi/4GWk11WSvtzbv9IRjg9eG6fAUc
         1HGpgVvRQUTpqQkAKmTvHp9qBDAZ6IBoauAjUzpkEI690naGFHSE2lVXsYmJi5crxWg9
         zA5X6GNlh/TqBCoKPddvyxWveOBLA1dXWvBoqJMa8yVM4sSjre+XEzZsoiIHAhvNb/ez
         7RWo1FCtakMRtWKuredC+JBGyk678pRGEARq2UDIOfhTvpymY25MJjX72F5uCc1T2weH
         9fRL/nV/0hhzT2qiZzG3Tr3v4nskxbH1sYWGmiB5nCOfPlwk39WOeVKD029hyDSd+c+c
         agsg==
X-Gm-Message-State: AJIora/RhOO6cZ5djqDX/DZBFtFl5ftak+HjUGaCj/AMKTM1szdr5Q9f
        d22LXyoIIOID/UzeYcI6bcY=
X-Google-Smtp-Source: AGRyM1tXqNG/QRjwS0/M/cdpKxCw5lRc8L7RzqHNeXMOhLVnRT0BCKC/UmxpWaFqjkichXX6AK6hJg==
X-Received: by 2002:a17:906:54c3:b0:6ef:d07b:c8ec with SMTP id c3-20020a17090654c300b006efd07bc8ecmr28840942ejp.687.1656958850201;
        Mon, 04 Jul 2022 11:20:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id fg8-20020a056402548800b0043a3f52418asm3153435edb.18.2022.07.04.11.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:20:49 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: vt6655: Rename MACvReadEtherAddress
Message-ID: <3714f7cd3425e0ef0a3df0cc291131cdb85a3796.1656835310.git.philipp.g.hortmann@gmail.com>
References: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/mac.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 6cf21883d1fe..b9c57c661729 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1722,7 +1722,7 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 	}
 	/* initial to reload eeprom */
 	MACvInitialize(priv);
-	MACvReadEtherAddress(priv->port_offset, priv->abyCurrentNetAddr);
+	vt6655_mac_read_ether_addr(priv->port_offset, priv->abyCurrentNetAddr);
 
 	/* Get RFType */
 	priv->byRFType = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_RFTYPE);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index cfebd126e42f..ba5575d63db0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -577,7 +577,7 @@ do {								\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
-#define MACvReadEtherAddress(iobase, mac_addr)			\
+#define vt6655_mac_read_ether_addr(iobase, mac_addr)		\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
 	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);		\
-- 
2.36.1

