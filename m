Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F058527D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiG2P0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbiG2P0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:26:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B832BD0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:26:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b133so4920247pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzNLfrCl5rV2i8rqnbdT3o4k9KbeFkIr7Ha5/Z3Q21I=;
        b=ZaSF+z1STM3QtulM2VIw49uRISrGK4kI0+fjdp4uH7FwKvDULDg3GpCTnudDHUhdkc
         9A6/AZGT7OlMkWG4j0gdMFN3upPLKG/WGvstnfrlPCJd4nlkf/3BLfTtIvhkzmfcaQcr
         /7H3Gsur6TZs+3rZP1lkUi6gDyTdVZsPSSY70/+l5SutbG+veUrBJnxMiIA4uq9p5Bkm
         cYDxa27Rd/jnoB+Iqo+Rd5AuS3mK1ArUTtbQWDM7Wo0cT5XJfT4ERwdWpuOtGkEuY4Kg
         nkM28uMWOocM1evlAs8Zcc6rrkz2+cJlF12UWgSbSGFpHlM3f9HcEczGSzd7/huGXhGL
         nDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzNLfrCl5rV2i8rqnbdT3o4k9KbeFkIr7Ha5/Z3Q21I=;
        b=397YWciQEbpoaIu3r0OEIf0S66YstKOg6ZQckeXuUTyiYVrLaTCQeTVgFzJXcW+1/d
         a+WYAwdKvJQL3MPvtXMvCOa9lwwfkfGEz6dH6tWxGZiRLh5dn8PU0HRvlU7lM0gGw8td
         bg+PVW/MtvrYIaoeotOUV2pfdrRu79H7zKmg/GZ4PCE7+xBqFB4OoOHlJcxhAIdT4Naa
         H13uor6o8JsrxHBJG4Wa/nug5aZ0DEbY4C6hDS0Rx8LKuBi/65lJ+Sh020fm2ahFGT8u
         HG7Ax6p8ZGupM3h/Ft8LdwnrMi4gDGm/KjwmtOi7/mr9IJRKdJETBNVSv++2HLSm/+xK
         a0hg==
X-Gm-Message-State: AJIora/UHtThZkfzcvAeONon9WzE6PRupzgvzJ3quOUgxLv8OjO+VerO
        vGTaBY8ycv0Q1qsJtqF492rmd7XocawpDA==
X-Google-Smtp-Source: AGRyM1vgUrdkeWs107TARuGdN4xKS2m2j5IJuXmtCc4+qi/WNslNlPfwA38Uln7msPr34BtLn3u+TQ==
X-Received: by 2002:a63:d90b:0:b0:41a:ff05:4808 with SMTP id r11-20020a63d90b000000b0041aff054808mr3395244pgg.159.1659108359911;
        Fri, 29 Jul 2022 08:25:59 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b0016c06a10861sm3804779plh.74.2022.07.29.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:25:59 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix wrong comment
Date:   Fri, 29 Jul 2022 16:25:54 +0100
Message-Id: <20220729152554.8211-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.30.2
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

The comment should describe the error when user calls rf69_write_fifo()
not rf69_write_fifo().

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 659c8c1b38fd..8c7fab6a46bb 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -816,7 +816,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 	if (size > FIFO_SIZE) {
 		dev_dbg(&spi->dev,
-			"read fifo: passed in buffer bigger then internal buffer\n");
+			"write fifo: passed in buffer bigger then internal buffer\n");
 		return -EMSGSIZE;
 	}
 
-- 
2.30.2

