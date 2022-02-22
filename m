Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5A4BF02E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiBVDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:21:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbiBVDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:21:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A0192B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so721310pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bo6oFnHJAbU/j6h7MDnhNKM3GTAQUQeHdOFA1uJIsUk=;
        b=EDq4SB+mfddJkNzCL9/fiSz1vybCDTColQrt8/RVk3xtwZMlybZx64fyOoDEmqXskF
         44JDspyyREMNADEBbTQ19OHSGxh79/dNXb6l+Ebujg1nt2ZSwZwtnQClQRgWOaQ2IfeG
         0R1lU4alHMG9J6VKJy4dFW4440rYTyHsKh5Yj4vnKcmOt2gYIYyjIjgrYkrZMUfjZPVG
         0evu6LGLPMc9yVvyVpMSmDrhx+7jR0BXTW/asbgpZen2sXuEZo+moIhA8TzG1Wqeqg+H
         UcZ/ZAkZbFKK1JgaenBlQiUop97ggn912xs6QBiGKMseO621NBwuV8KEsbT/EpakB5Bh
         Z72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bo6oFnHJAbU/j6h7MDnhNKM3GTAQUQeHdOFA1uJIsUk=;
        b=smppZ+rZi4AmaXZFdnJxxW5PHS8YADnle7MvFVtX6XUUBPHEzktwvr9pi/MLFWhzLF
         83E512428zAt6NCUAPveK/bBU5+9qhi+eB8Z93tU23W36gUEu4O7XtCuayy9wxuPqGzE
         ZUHkXrWANhd7JeloJyztammoYwplk4j6W8ySdj+dgg+PbqmpLtvzVfD2j0pqpMKNU3pj
         gH6kwsnsBcZimXSw/wrQTsI+gG4lDREW4dIjX6XQ7hIIIQ4FibPrB+A+q/u0/vP6S4Fd
         D0HvJ4wxAu1qCg/ahx59smrL/Al/gpfPWJ56OMGsmOY/j0itNVRtVhGRf8+ITKUoUh4q
         Ytnw==
X-Gm-Message-State: AOAM533XwAw+KRT6HXX5wvx8w/rROjsNiD3YPBOZJQ8tNIbknLmX5Ut6
        x2+fZpyN+5koy0Ud0fmXW5k=
X-Google-Smtp-Source: ABdhPJy4i4RlzYqweyTHlpPwJmd11zenAaP8eiZmT+eCs5JW/E2Jzh7enjEMTMuPMemNWopbUEZoPw==
X-Received: by 2002:a17:90b:388d:b0:1b9:950c:f08b with SMTP id mu13-20020a17090b388d00b001b9950cf08bmr2019553pjb.49.1645500041868;
        Mon, 21 Feb 2022 19:20:41 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x12sm19068111pgp.25.2022.02.21.19.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:20:41 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     david regan <dregan@mail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 4.14] mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
Date:   Mon, 21 Feb 2022 19:20:23 -0800
Message-Id: <20220222032024.10220-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222032024.10220-1-f.fainelli@gmail.com>
References: <20220222032024.10220-1-f.fainelli@gmail.com>
MIME-Version: 1.0
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

From: david regan <dregan@mail.com>

commit 36415a7964711822e63695ea67fede63979054d9 upstream

The brcmnand driver contains a bug in which if a page (example 2k byte)
is read from the parallel/ONFI NAND and within that page a subpage (512
byte) has correctable errors which is followed by a subpage with
uncorrectable errors, the page read will return the wrong status of
correctable (as opposed to the actual status of uncorrectable.)

The bug is in function brcmnand_read_by_pio where there is a check for
uncorrectable bits which will be preempted if a previous status for
correctable bits is detected.

The fix is to stop checking for bad bits only if we already have a bad
bits status.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: david regan <dregan@mail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/trinity-478e0c09-9134-40e8-8f8c-31c371225eda-1643237024774@3c-app-mailcom-lxa02
[florian: make patch apply to 4.14, file was renamed]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index c65724d0c725..0138c0c6a4b9 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1637,7 +1637,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 					mtd->oobsize / trans,
 					host->hwcfg.sector_size_1k);
 
-		if (!ret) {
+		if (ret != -EBADMSG) {
 			*err_addr = brcmnand_read_reg(ctrl,
 					BRCMNAND_UNCORR_ADDR) |
 				((u64)(brcmnand_read_reg(ctrl,
-- 
2.25.1

