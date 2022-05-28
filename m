Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434B536E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiE1U2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiE1U2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:28:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29B3BFB0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:28:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v19so1784567edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rKUdcZ5+CPg7gfBlzCJZPvk1sAk9u+GiolWKz3aKZJ4=;
        b=TcMj9I52z4nW4O9auyhU4iqIfkK7jNDvixcbtcVHG9vj2K5PhDl2EZK9gE+oSmtNNa
         i22jzxGDHIY7sJoNIGFsCjsmv7xYgCZyzhTgF0h+F8lM4PE5SgmmM1FMH4VdAY5SMpjh
         mZxiFg2rElYM6TeKG509eyjFm3df+Bd1oSD6HLQxfxHybfEksBBUp9mfz/f0hoWIkxqf
         pm90WAo/IvhtaAgcHAr4hhVC+v3J1Vi4ZRcUehoNFw9KkgojX4qNeB9RlJuLOUAIt3Hw
         S9z0Y9VBTQOx1CEIufx+d6WPhWLvjnVHkKrszXGSZAXbEcEKxg2y4mVbTpt2nZ8pJY24
         dNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rKUdcZ5+CPg7gfBlzCJZPvk1sAk9u+GiolWKz3aKZJ4=;
        b=S7HDIKhNq8v1MoyYemcS3maE7AzlRW6CvfGN7xmDl65YGPvUiRPLxVQVQ0EkdIgqg9
         B/XKqBq0OSOA2ipui2Z4mqVjfFE3Fcul7gV/wdnkYCk++Jat46kTtK0vFPP16navrN0e
         FeYrZubuCFBe90TT17NcCZNE2uiTmmLof8NUOyQeBWRfaR3Q7holEjIaLY3BpFQgccQz
         udTsiXo1TAxwZnWrnWYPrN8KCI8nomnIhP5BMlsgr+T2NNB68GrurePE0J8o8vFm1cI9
         XDS6bfWpy87xwSUt+e4oRGMQPZZgPxIFeA+BzWxm02n8V59GSKHMWvhLEY+eIIJ2ninq
         bKKw==
X-Gm-Message-State: AOAM532SKKqIe4oRLAfi/+YWyHX3kQszZcncxFJz7BZq2azHAqWHrDIa
        k1I05vOCtqzQNcEBAfnKAFk=
X-Google-Smtp-Source: ABdhPJzuDEVEW7U72D6+nmZQHvZ+ZHGh7iZZzNYJFbDloCZtN9XijZIbaZRNoT/ru2QE0bhww24c5Q==
X-Received: by 2002:a05:6402:1912:b0:42b:615e:6025 with SMTP id e18-20020a056402191200b0042b615e6025mr33758049edz.152.1653769712131;
        Sat, 28 May 2022 13:28:32 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:bd8e:fdbc:fec6:5b2e])
        by smtp.gmail.com with ESMTPSA id v27-20020a50d59b000000b0042aae307407sm3833779edi.21.2022.05.28.13.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 13:28:31 -0700 (PDT)
Date:   Sat, 28 May 2022 22:28:31 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: remove unnecessary type cast
Message-ID: <20220528202831.GA129473@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove le64_to_cpu(), as the type is already u64, as reported by sparse:
drivers/staging/vt6655/card.c:758:16: warning: cast to restricted __le64

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 2cde0082fc03..852300c59980 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -755,7 +755,7 @@ u64 vt6655_get_current_tsf(struct vnt_private *priv)
 		return 0;
 	low = ioread32(iobase + MAC_REG_TSFCNTR);
 	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
-	return le64_to_cpu(low + ((u64)high << 32));
+	return low + ((u64)high << 32);
 }
 
 /*
-- 
2.25.1

