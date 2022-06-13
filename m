Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438CF548B85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386332AbiFMOzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386949AbiFMOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:54:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE8CE5F9;
        Mon, 13 Jun 2022 04:57:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so6805772wra.9;
        Mon, 13 Jun 2022 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6TuJuerUWJ8EtOROL8wReDLxoePQoYwCsoov/k8HMWg=;
        b=gf9LBZYFHf0KNaMSaE7tF715h96Jnv2U9DTHOIX1cCAIYCWDQzAvUke7pFZjwLhzUq
         sVeVobVZ0jPIphEKmLbjmpSC5FHi2qeEv2Z+V2myfcalV6E7DK+pe3JX/lXmgXFH9kOt
         ntPg+5+S0pl//HDHNYXTaZYjbnIjTOcPxBrzTaGpGopYjVOpOU0w2uPBBPb8hE4L5+/C
         LYjWQe7ThdziR8KideulKhoEoYWZyjQh+hc14xUq7ZQe0RdCaJRVLPttJKmiK+xEfF/K
         52K2zdnD7bPEdCdyVRp+SnYC+pQ88eBJB9a25ljv+Ck89DPJNceRbuErlZ9V4Fy18gdK
         /UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6TuJuerUWJ8EtOROL8wReDLxoePQoYwCsoov/k8HMWg=;
        b=TinEZqPJ8PG7y9vMb+GHH+znz3eSEL/+m+ztbprgQCxKWyzmzbLAc+qrFvFT4bqpqp
         ZAMGDdpwdUtAIHdhQ9UAtarRIZN6GyW6offehLQTJlJk1H/kKWC2YFw996O10vkpWSFN
         MZy27hRr55QN8x6PyS9ZW1I2mH+eqBp9gIOGi9LYoVznsOquy+xZFio62LIJsui5dVnd
         moMyledykwR0CusJgT71QHX8gTZwYRrSLsVSkarxe5x0jf/PN+gUV1MG2AObF6YaGbVR
         smqd7Wjt5XT9VSz2U+Ljl0VTA8MtKXt4nplzJBbNA9IToHowVHFLUr0cMnW2tmznx8yw
         lqVg==
X-Gm-Message-State: AOAM533ZLxY8afySBGCAbpHcEawgU5qz9f67jv7EBkEb53DkXIwYyE0g
        Hx1xqUdmXLSQwWINembOLwqtqqgBK6s=
X-Google-Smtp-Source: ABdhPJw2cZFX7WimZ6Mnf7xBkyQlGQD4CktwSjYghR9IhrDJiyy6H5yezCDMK0B8BFcbsTyu8UtMGQ==
X-Received: by 2002:a05:6000:226:b0:217:851a:4300 with SMTP id l6-20020a056000022600b00217851a4300mr42651926wrz.389.1655121418721;
        Mon, 13 Jun 2022 04:56:58 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b00218468314d7sm8330144wrw.62.2022.06.13.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:56:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/input to INPUT DRIVERS
Date:   Mon, 13 Jun 2022 13:56:54 +0200
Message-Id: <20220613115654.28117-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/input
are also the maintainers of the corresponding directory
include/dt-bindings/input.

Add the file entry for include/dt-bindings/input to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Dmitry, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 503b8042784e..262ed53d544a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9815,6 +9815,7 @@ F:	Documentation/devicetree/bindings/input/
 F:	Documentation/devicetree/bindings/serio/
 F:	Documentation/input/
 F:	drivers/input/
+F:	include/dt-bindings/input/
 F:	include/linux/input.h
 F:	include/linux/input/
 F:	include/uapi/linux/input-event-codes.h
-- 
2.17.1

