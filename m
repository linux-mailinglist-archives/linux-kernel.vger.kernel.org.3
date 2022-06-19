Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85306550C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiFSRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiFSRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:43:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9AA47D;
        Sun, 19 Jun 2022 10:43:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w17so11740611wrg.7;
        Sun, 19 Jun 2022 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1GJBDNs5yTZIr20ZTfGmqGw+VA/IHMmm9RzUdjuSNI=;
        b=PG5S7vpop0zKsTwPwuiVBzt8o6QGR0G3K1zaG1+m9V6EpGo2DnAXpwGEL7/9aePkRY
         ykcPv/vVovpHppy0K+P+x7pbEQ7O6gIxvyGHXQB/kV+x3dUL4Ab5IzPwP3nEyeoqchIh
         z96qtY5Qftnlu9ldYsuPpbBcDA/h6SRJ5b405iMtl+O3fRNFvd+NSdZCymukQeYuQTu5
         P0fXS12b+b4m4vK+rKBYb9v7RY/ghVHmOyhm2ehRKGEswqdNLn9MbrJyTmW87JovsW4E
         f4F/F5wXTLaN0XgCwKuoOjiu6NWll/q6LMQsALCXwt8k6BAQRUwxv1rW2Tgq078JZoCl
         soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1GJBDNs5yTZIr20ZTfGmqGw+VA/IHMmm9RzUdjuSNI=;
        b=wxQ5WaZNOtJAvI1WcJ2oX1m2A3w28i8Fe2THgw8lUbq6DrqbuxIrvASLPHs9vXfBDh
         AdcMv+McMoubTBT3L/MH3d+F/IVTVBjqSScsflfaN6fTPYG8WU1hjY8d+wNKish6UlyG
         6GjGh95cv95SEID2sDm2DFoDeMsuRv3CWeTM33mMWbDrWDkseOj6IW3o9QyRINDubtLY
         fjoygFYDNdKdPnn5IFv4wQCqWT4bNEPw+gZ47Ra1sytmHAC/edz0ulOBbu5nPAYRPU5g
         iU4aql5ttTrvG25vMpO/oroRi9r0eLCkqujU+6yqGIB/PqNTfaLnNHjoSaroxvEu7c3F
         FegQ==
X-Gm-Message-State: AJIora/MH205p9L02tzUgiSoq5haXo1ea83FwQlYL57NdxKL+5JfVcI0
        ydlKBLkyNjtKevXDWSHBRJSD5yPq+lE=
X-Google-Smtp-Source: AGRyM1vucVEffRRfE76cbwwLXOQ0fR1dQ9uVprKeoEuImGpyxHBGqnRFG4RTx0Fw5jxnWiE5J5rDvw==
X-Received: by 2002:adf:e988:0:b0:21b:8c9d:6ba3 with SMTP id h8-20020adfe988000000b0021b8c9d6ba3mr3124199wrm.10.1655660607563;
        Sun, 19 Jun 2022 10:43:27 -0700 (PDT)
Received: from localhost (226.100-195-80.static.virginmediabusiness.co.uk. [80.195.100.226])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm24347607wms.3.2022.06.19.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 10:43:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: PCI: Remove leading space in info message
Date:   Sun, 19 Jun 2022 18:43:26 +0100
Message-Id: <20220619174326.28743-1-colin.i.king@gmail.com>
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

There is an info message with an extraneous leading space. Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/mips/pci/fixup-lemote2f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index 632ff2daa338..790d674cd80a 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -80,7 +80,7 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		}
 		return dev->irq;
 	} else {
-		printk(KERN_INFO " strange pci slot number.\n");
+		printk(KERN_INFO "strange pci slot number.\n");
 		return 0;
 	}
 }
-- 
2.35.3

