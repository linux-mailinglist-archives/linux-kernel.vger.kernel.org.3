Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F293572CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiGMEfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiGMEfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:35:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BA2C444D;
        Tue, 12 Jul 2022 21:35:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so13848292wrx.0;
        Tue, 12 Jul 2022 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DHg85HnlDdUWHodmCx9AEEsZRSGQjLvy0aYkybCOVUQ=;
        b=SgDxR0zrTVHDRX9OiyvY9vECFsOfPczyd5lwZoNW+W4kOVn2VHNH9IttU5Wyponfj1
         rmzmaEQ7nrhi3SeokC8dz2JeqMecCaOlyI4fk6mX2oT9+kE+vUr4m/ewsqbMNfHwLmFZ
         z0hUtg+iubeG/eJwk9O8iAynbgtz2Ble7Ph3snDIwRZKgaPUWcNDaHqIvysJ4lIU1br0
         BXXlJNkpDoaKLEMHtvIrMUvPNTETtqgZ476WWB0GPYu9s6RbUslaNMFoQZ32q3aUNBRg
         vKz5HV4wSAgeCwPO59XM4V5Jk9L999a50cqf4vrXue6x6g/G+kp3pyWRxY07pg5HC9ut
         2rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DHg85HnlDdUWHodmCx9AEEsZRSGQjLvy0aYkybCOVUQ=;
        b=3q7IkQj2J1MF7gyVZ5evJenvFr4rLqqr3HPPaWF5+TyuY2bkbBfU8OGivdeSkBiAuZ
         JJSOL9hBLWBEkZmt8RNjGZCQwjhf9G4hzJ0CRrek516eNP4IXOTgJOh/G7fYpqJEq6lo
         b7i6M6USmenzRPdMcWmzOv/8nXWD9jwfoYjOjUOFgBmyQBl8cl+uAgwmOrpqWN0imAz2
         FNDjlDkz6PnROn8JmaEGox+X3ZIeWHIwTq6ic85LTT2PUU6uMDs/HB2e7F+lzw1EkuW0
         wOSvk9MzfaWXMMcQnVOepM0dxjGBrjBNGwhTCtBPMtZ9IIcUo6lgsSIg8uFr3f9J6Qzh
         tDAQ==
X-Gm-Message-State: AJIora+O8/ePq0OmbvSQW8YAtg4zXO2U9fbEwe0nbB3epYK2OIzhsHRg
        lig5YUfadweR4eOQfECXfk38rafV2wY=
X-Google-Smtp-Source: AGRyM1sgWnHQAvd/tpBZ47ma6lVXstx43MCqh1KulBw+m+/VJSdj/0rY+aUqPOlVZh9/G/PzLv1g/A==
X-Received: by 2002:a05:6000:1789:b0:21d:7279:f455 with SMTP id e9-20020a056000178900b0021d7279f455mr1167645wrg.542.1657686941045;
        Tue, 12 Jul 2022 21:35:41 -0700 (PDT)
Received: from felia.fritz.box (200116b826b4e8009cf80f75265d524b.dip.versatel-1u1.de. [2001:16b8:26b4:e800:9cf8:f75:265d:524b])
        by smtp.gmail.com with ESMTPSA id o38-20020a05600c512600b0039c5642e430sm860428wms.20.2022.07.12.21.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:35:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: mark linux-doc-tw-discuss mailing list moderated
Date:   Wed, 13 Jul 2022 06:35:16 +0200
Message-Id: <20220713043516.19290-1-lukas.bulwahn@gmail.com>
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

After sending a patch to linux-doc-tw-discuss@lists.sourceforge.net, I got
the typical response for a moderated list:

  Your mail to 'linux-doc-tw-discuss' with the subject
  ....
  Is being held until the list moderator can review it for approval.

  The reason it is being held:

      Post by non-member to a members-only list

Mark this mailing list moderated in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5aeaddc9539..1320d3eaf198 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20579,7 +20579,7 @@ F:	tools/tracing/rtla/
 
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Hu Haowen <src.res@email.cn>
-L:	linux-doc-tw-discuss@lists.sourceforge.net
+L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
-- 
2.17.1

