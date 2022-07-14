Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B173574A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbiGNKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiGNKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:31:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5310B47B9B;
        Thu, 14 Jul 2022 03:31:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so1919180wrd.13;
        Thu, 14 Jul 2022 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EOlh3v/6xBJDZv6ZGOpt/dvzibJ1078WTnbe9Z7a3s=;
        b=l4/H1maNxLSK6atZSaqo6hrRGoHzgnLUji0fudW+DyAgJ8cecLEgzj4Zw6ef+HPhC8
         9YB9FwRjVuAz1IE9NLY5Cz1smNkrCmHRw1cygKimrKhxNmg0XAFeh5yUp8cvb3rxnRqS
         zdE0K1aIrp1aLRSL1AMuaqo9rhM6D4WbA1H0/YbHyq+gLU3PsqyVIttm42N7sqLn+MKV
         NUnS7Jrqt3udztLKS23XMZP1pNYlb+Y6TxAkvn4mcCOAIYvyAA+edqukgJr2ClG2qlIy
         JomiyuwXe+cGIvsgt0hYh+7c+EB4Fk/9nIz5lxorZUtwE5rRlMy4sH0WI7u9AWXhTRYy
         ZAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EOlh3v/6xBJDZv6ZGOpt/dvzibJ1078WTnbe9Z7a3s=;
        b=yjfa8w3WPZLRkvB8YIUx0/4bh1bnoiva5xwBNNG6i2jEKxD8tqJ1XGlNlDzAhiwbQx
         u1zeiUU9X9wAqS5D1oaWSRv9Q71w1cuXhKI12GZQDRhu7XYyRgxg/I55SydXTaXWR0Y1
         dSJKX6rz8Nv040N8tSCzej0u7Yvm5LFxr6yTyeRvgHaPtzPwIf8aIh3wCCSTlT2NXj2A
         uzACB/8+po27bfg8LekXxH/8w6Deta+Rz40JIi1n1KrP3XIdDaXshlqaIEC3tUasH44N
         cYiDl3EoCVGl9r5xwyy9pv0IShrOx7TEqwEnNxtnLG0gJ6Ec6NdIL26aWaHGaSo01yvu
         kS+g==
X-Gm-Message-State: AJIora/r/lQqWSmWoQCgtjQHqSwCzfeQBOcrQt23DnDbKRH7f4nxdpQY
        h34BmoR86Lp/cQSE3zq8dNIobYiLxOzqzA==
X-Google-Smtp-Source: AGRyM1vnKESpQu4b4WNRNs2rw6wijJCfL2aCPeDMXT676QjKQeC/CpvLv4w0DYo0UZjP/38xo+75zQ==
X-Received: by 2002:a05:6000:178c:b0:21d:b6d0:11a8 with SMTP id e12-20020a056000178c00b0021db6d011a8mr7445192wrg.547.1657794680941;
        Thu, 14 Jul 2022 03:31:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b003a18de85a64sm1591785wmq.24.2022.07.14.03.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:31:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] habanalabs: Fix spelling mistake "Scrubing" -> "Scrubbing"
Date:   Thu, 14 Jul 2022 11:31:19 +0100
Message-Id: <20220714103119.22927-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index cb2988e2c7a8..05dd5e13f13e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4723,7 +4723,7 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev)
 	addr = prop->sram_user_base_address;
 	size = hdev->pldm ? 0x10000 : prop->sram_size - SRAM_USER_BASE_OFFSET;
 
-	dev_dbg(hdev->dev, "Scrubing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
+	dev_dbg(hdev->dev, "Scrubbing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
 			addr, addr + size, val);
 	rc = gaudi_memset_device_memory(hdev, addr, size, val);
 	if (rc) {
-- 
2.35.3

