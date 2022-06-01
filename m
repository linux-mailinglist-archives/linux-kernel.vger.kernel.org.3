Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB07539E44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbiFAHff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350335AbiFAHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:35:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064C673563;
        Wed,  1 Jun 2022 00:35:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z7so943964edm.13;
        Wed, 01 Jun 2022 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7+lEh+59GUTlIgrygAE5T9rpW2NdEWdsFcmPjl4IHoM=;
        b=G5ekiN7OwTibpzVIId2YhAQzVch8b0pybutep43fc17FBZQUJpVwiweqO3ttbcwFcp
         bchU2u3DzN2bWtELdIBJ3kxBpdWML2qd7At0oemzpm6h0ZMD+TQ7/IG12RT2b1surrxt
         avK806/Itm5tSSluh8BSwReWr4/Hr2f362DIXJSTFfCsNZlc4T/K+k1VvgpqlESsO51o
         Ao90Vh5dLF+D9VBUHC7OZsODMuwPWbcnpp5uxd6c30yb0mvZKiMx4BgSIlJhTIwBq649
         JPu8u4APnckejI8rex7phyBY2PZhc3AWL0BDWgvCSPXs8k7mser7Vmemer1oKa+25exu
         iSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+lEh+59GUTlIgrygAE5T9rpW2NdEWdsFcmPjl4IHoM=;
        b=zHloSwmhRkh1nHZv5uMGGNJr+xk+/bHIgEy+2LczFbN5RZFxfKoO0dAEQxtjnbFcA/
         B1/xmcu/J4FeLwmJbf/lbPydCJNJQYn12Z0dhUmG8/RrVwg8gi3ynohaAl4hfLpG/ZOZ
         afXQ3YxoX9FGmPAgJ4eSYhZVMN+tyVb0kddN6EEU0PhMpiAgf4IF49Pi7OROJJo9Wnl3
         QpTBQqxTZ5V7m8HW1xCVn/bHZ94sLOgnD697ZRwjPT2ZoehwnSC8eYAN7dCIF1zNfMCx
         pE2v4NFNniR06OYsBj9SXDKNO6+KoNjHGne69YcBU8WVH4gnzmLmemy/DCWtmIibsHf2
         UPhw==
X-Gm-Message-State: AOAM532ZVATxAWuGxMWvjeLTxqbt2H35/6zYRvVtp30KY5NZbX64xCRY
        LQVfyuGjP0lCxVSlWBpWk5BsXQzhaig=
X-Google-Smtp-Source: ABdhPJzYvYDrGNixQaKbbDBnwt4B7btkj+BrcX3UcW2XEHd/bEH3x5hy3eCddd4YFji6o1z9XneCUQ==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id f1-20020a056402194100b00413282209c8mr70130779edz.13.1654068924456;
        Wed, 01 Jun 2022 00:35:24 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id qu19-20020a170907111300b006fe960c5c5asm365239ejb.126.2022.06.01.00.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:35:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry for max77693 dt after merge conflict mess-up
Date:   Wed,  1 Jun 2022 09:35:11 +0200
Message-Id: <20220601073511.15721-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b38213c6118b ("dt-bindings: mfd: maxim,max77693: Convert to
dtschema") converts max77693.txt to maxim,max77693.yaml and adjusts the
file entry in MAINTAINERS accordingly.

Unfortunately, the merge commit afb67df31a8c ("Merge branches [...] into
ibs-for-mfd-merged") resolves some conflict in MAINTAINERS in such a way
that the file entry for the converted text file max77693.txt, removed in
the commit above, is added back into MAINTAINERS.

Remove the file entry to this converted text file in MAXIM PMIC AND MUIC
DRIVERS FOR EXYNOS BASED BOARDS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lee, please pick this minor non-urgent clean-up patch. Thanks.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ccdd7727840..01e276fa6476 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12117,7 +12117,6 @@ F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
-F:	Documentation/devicetree/bindings/mfd/max77693.txt
 F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
-- 
2.17.1

