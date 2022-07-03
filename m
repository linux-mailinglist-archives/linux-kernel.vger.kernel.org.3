Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A5564985
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiGCT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGCT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:26:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3421BE;
        Sun,  3 Jul 2022 12:26:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n10so6868838plp.0;
        Sun, 03 Jul 2022 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko4FLx/zT4WyjidusLHvpuHoIsoPjnk74mrmMkIRO34=;
        b=aSdePPkaoiggVQvZTHd0K8u6V+AHMuklxapVQ+2i5AWbeU8NHrmU5QqWEhoxHzIGJ6
         YudfyhsmJlv8i2lKL5Hmqdo5fIs2da6Z4CdCe/4VFFoLMTRKop3pctci2TTn58/J0iau
         wI/T7ZrJDFxrY713Jpd9o05JRWbPSuFV4lgS/SZLftRUVoh8sIqhCehgnSWgkBdapf2+
         86e4vqu2E7cxgY5b9l+8XqiEfBEJYzT3GkwbT8T6ct+rnOMg309m13iI64cGNEG0Gj1o
         ytOASkzU3tfffpp3eyVwLFzg4gUoKRAZ6OtTwZ7iZRrpXQ7g3+cdrZ2Mh9/WntPvmThK
         9/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ko4FLx/zT4WyjidusLHvpuHoIsoPjnk74mrmMkIRO34=;
        b=sMtyuTTWoTSWUA0Z2KOSpAarkIByyCryeUkk6enwErCSROy741q7LvW58axFMgR88t
         CTUPbiekNR9BODdBJw9DJiuJdyGFTBDDIZk9g14xF6J3Aw1dsDOhZ/x6M6rjtNsVMZp8
         A4Blh3UwPBBKzFhwnKRbIR/jwpGDhlF97axa32RFshtNMw2/grn5pr9G8Sgunajkf0T+
         TWuH6ufIogRXqVS4Q4cf6ig9VhnQUz9E3MoSSsGP0JOPA166Q93DTwysIy7fziD6XDNe
         iDWAaXPntv5aB4AKt0n4jpC0ZI543cv1LGhqoVQWDraRmlt0JzpoHueNP20Dms3/qOhu
         GVjg==
X-Gm-Message-State: AJIora93TWp5oU19wH2Vn4JUKN+B35xA6BRjfNiX1o2bvw6bwVgrUWFZ
        14D5OZW7QZcZDLATzIBHQdw4PLKYjh1J+RnD
X-Google-Smtp-Source: AGRyM1vRgNbXzRNTe19H3aGcY46VOCbn98Rj38c8aEYnLB5138lI378QP7k4qXTLsoPtTbXjvTPm7g==
X-Received: by 2002:a17:90a:af98:b0:1ef:1d10:c052 with SMTP id w24-20020a17090aaf9800b001ef1d10c052mr30691024pjq.111.1656876365391;
        Sun, 03 Jul 2022 12:26:05 -0700 (PDT)
Received: from fedora.. ([103.230.107.40])
        by smtp.gmail.com with ESMTPSA id s91-20020a17090a69e400b001ef831a2015sm1341876pjj.22.2022.07.03.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:26:05 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, khalid.masum.92@gmail.com
Subject: [PATCH] usb: dwc3: Describe function parameter 'mult'
Date:   Mon,  4 Jul 2022 01:24:48 +0600
Message-Id: <20220703192448.13763-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the parameter is not described. Which triggers warning when using
make htmldocs. Fix it by describing the parameter.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8716bece1072..e8c86b08cd83 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -657,6 +657,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
+ * @mult: multiplier, 'mult' value for SS Isoc EPs
  *
  * Calculates the size value based on the equation below:
  *
-- 
2.36.1

