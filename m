Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2468B4A3B07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbiA3X3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiA3X3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:29:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54797C061714;
        Sun, 30 Jan 2022 15:29:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u15so22017085wrt.3;
        Sun, 30 Jan 2022 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLbEQW9WRjfjCOJjcHwjau+rY74wRZCMKsTX1f6w8SU=;
        b=WcoeXrV34BHPjj4lRvCCPIDlWvkDsD+33H+VXZqK7Z8jZ8ChwCFEcPrIu8RG0UYkm1
         5KZtv8VbD7JlkSHihpNXk5Mt/EDnL9DIceqmr5Xg0r5uOBn2sn5ku2U31YJb4W9/f8pV
         oJWD/nnFkbQGgcgCKqXY0mAxr2yYa0Fem8lYg+V+i2IqPCIMT9vntwXf1+yyCUYjgEzO
         aprDFFudD4bEoOha2u4KEE8fFJbJItnFCFZfVRBgXvA8RuxPqP6OyG27pDvFPfbMjDx4
         Z5GmYse/Kvc6/GHNv/EjuMNXCkJBVcK/srwWeT6F/wDVqFte5fS/KUN5k5kUa4vSMoTP
         bVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLbEQW9WRjfjCOJjcHwjau+rY74wRZCMKsTX1f6w8SU=;
        b=5kdPJ5nxvOp/FQ4ACsaeCnpMTqhl848rPpCUpwcnv7Qjy8mjASa7QPr2INDxQ7Fo9Z
         Z1UmnrsUtbshotLPfCXk1X8oeP+CyFHLcOAhzOOXrjYuJxdcpHMlsoVDlzWzVGd0SbGc
         EijLV92gL+KlkXllGeiKoUcSOxD4kZilMee2Bk9v1zdj71DiyGyiwnIdby+t8dRLiNyl
         EmuQsi1Zq2eagex+0kI/kfBE0jmij7aYt35e8JtV81g7tGnrQpM1nAo+NVMhbjAFQTga
         XF9AkX6xbGN/KZ3haBD3ZOlSffOGbXl/VtPrruJFCYBhEke4PnhFBgxqoC6AzIoSFQ73
         HZ1g==
X-Gm-Message-State: AOAM531+4aIM8+8yIOFPQcBNMJ97J/547HUHbZo/IsFPHEVSzf8kiy2U
        FCDGt01Ei4XXQ3TkWbc9V5BvfGoDE6cDxw==
X-Google-Smtp-Source: ABdhPJwUjvqkYN2VU4QMMbDI6+PcG9vx8rqmsQs4AgbDXlovRrJ7XEVkQAGvvD8saYv65P4rMAcinQ==
X-Received: by 2002:a05:6000:170b:: with SMTP id n11mr14927426wrc.156.1643585351320;
        Sun, 30 Jan 2022 15:29:11 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 16sm7323377wmj.12.2022.01.30.15.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:29:10 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: remove redundant assignment to variable buffer_config
Date:   Sun, 30 Jan 2022 23:29:10 +0000
Message-Id: <20220130232910.9313-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable buffer_config is being assigned a value that is never read, it
is being re-assigned later on. The assignment is redundant and can be
removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/comedi/drivers/pcm3724.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/comedi/drivers/pcm3724.c b/drivers/comedi/drivers/pcm3724.c
index e4103f9eeced..ca8bef54dacc 100644
--- a/drivers/comedi/drivers/pcm3724.c
+++ b/drivers/comedi/drivers/pcm3724.c
@@ -93,7 +93,6 @@ static void do_3724_config(struct comedi_device *dev,
 	unsigned long port_8255_cfg;
 
 	config = I8255_CTRL_CW;
-	buffer_config = 0;
 
 	/* 1 in io_bits indicates output, 1 in config indicates input */
 	if (!(s->io_bits & 0x0000ff))
-- 
2.34.1

