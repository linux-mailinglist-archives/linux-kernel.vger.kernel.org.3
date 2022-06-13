Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2AA54936D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358553AbiFMMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358580AbiFMMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:04:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304084A919;
        Mon, 13 Jun 2022 03:57:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r187-20020a1c44c4000000b0039c76434147so4350889wma.1;
        Mon, 13 Jun 2022 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=I+mQAAdlRxYZRH/29vXWOhrYvOZ8KHnvV5uZ0Clui7o=;
        b=YpyLEN1/a2T0NyREDZwDbs+wwokpx38lbbSATmCX92bFRmpSoXUwuShVVr19qfrMiP
         7F3ltt35cRIHX3QT4MeuSbOD1WmTgOZGiB65n3BeqKUWihgcFmMxTr+/mtjH8qdOHI6p
         susamQxk8bGDNiMihDzG+2GSzABq9j9JNZ0ufsis9uU/bJbyG40nZchW3JrfGsdsKAM3
         9vuKtElkiOlRcIwdBf707wuBUrCAsGuSWfZvcNGurFK+LWmnSD1P0fobCc2q5v6pMSmq
         FBZEZJ3NpZLRhwZI53sn8TSIkkGrhzsbTyCDrhsaniB0DAiUe9EzGMpqfLOXfvMoWYXK
         ccXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+mQAAdlRxYZRH/29vXWOhrYvOZ8KHnvV5uZ0Clui7o=;
        b=nOYOc+YXe2/gVjP1zU7YZFQiEdD4ZMH8SEefZrR/2AdQfcZ1SW/jY4K6CKeFaUkP+W
         UvtP23ycbggBPV4MH/uxLvFr9JrKrQXU0eW5HBZgDMRyT8fCOp660xTxDSMhuF6G0d/t
         E7fi9Z8PayF2eumZ3Op2b7UtfKVYb8nh/IFELXcn8FLSW90a3PpyMLYDvwMq8uiUAsmr
         O9K6kj+amBc3RTAyXLLpN5Clflk2m+QgE2XIXkzXotdFWIDoOXMthK0TbNvLV6XqIO1S
         Kjlhm9mXLS7fkU2XXiuAxb2yLMPOqkAqHWvg4vE4ad8sghw9+gSfTVcONJk+C5/Xp6pK
         iDjg==
X-Gm-Message-State: AOAM533MWBgmqYfzzlVyEDBysfF5LvPX2ZoT3/pCIb3D27hhEu4UCBGo
        PRl9fnMZOeG9xKdj36y67cA=
X-Google-Smtp-Source: ABdhPJyx101r3sLv5Q1UW6EdzWAxoF2lKwCmcCsohkETQk9BiO9huRU/LN+nbnRLzzeYjq3k6dfGGg==
X-Received: by 2002:a05:600c:34cf:b0:39c:4dfb:1398 with SMTP id d15-20020a05600c34cf00b0039c4dfb1398mr14043917wmq.133.1655117852610;
        Mon, 13 Jun 2022 03:57:32 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b0039c4ff5e0a7sm9008225wmq.38.2022.06.13.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 03:57:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/display to DRM DRIVERS
Date:   Mon, 13 Jun 2022 12:57:15 +0200
Message-Id: <20220613105715.13578-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/display
are also the maintainers of the corresponding directory
include/dt-bindings/display.

Add the file entry for include/dt-bindings/display to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
David, Daniel, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e7d1e885aed..a8d243668992 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6597,6 +6597,7 @@ F:	Documentation/devicetree/bindings/gpu/
 F:	Documentation/gpu/
 F:	drivers/gpu/
 F:	include/drm/
+F:	include/dt-bindings/display/
 F:	include/linux/vga*
 F:	include/uapi/drm/
 
-- 
2.17.1

