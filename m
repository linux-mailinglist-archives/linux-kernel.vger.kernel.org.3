Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC105ACEFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiIEJg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiIEJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:36:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAE4A809;
        Mon,  5 Sep 2022 02:36:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u9so15878683ejy.5;
        Mon, 05 Sep 2022 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UVzntTLQu6YKGPoOys5LB9DBMo84EPi0lKU1jOROxRI=;
        b=MNckiRIE8LkV8gv9kXwA+YdPmsVcMoxg3uHJk/dXUt8ZNStv6zhdchlSrB1QWadX6/
         PBeovOiegG0xm3eNdOGCj6OMMzkWEMe99O4QXBWSX2xZJVhpWNk0Fa3kIQdQYHiclQSS
         XKCtrOe0qRsVUlg0xF21PsS3c4sNABJSog/210NQuRbo72KK0scFha2GEsty8nsYXyh7
         kAHhxa391aREbcDMYY55aLeWdPH13BPViMemJLaPnds5bBY2DHc85OqJvs3PF1dobaK/
         XFImXigd/07wAYfSKhCEaBHDQJkmfSbP5etNqtQRl0uA107nlxW+vDfmWdkG4vjPR/25
         y9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UVzntTLQu6YKGPoOys5LB9DBMo84EPi0lKU1jOROxRI=;
        b=cdpETHhBuLuID9oSXFFDbJZAFTkrCA/efTs+quv9Z4V7bxyj29wTyHWQOxivi8MJjI
         2W2MdYSNu0QA9EtMrvVUy6xDRdKQylYvcB1haG3tKQIw5iiW42jx2OmNCDJFI6toOibi
         +XgaPvgyrEkADRinCDbOCxz7dKfGj+il8j1NVeblTvQ7Za+A3/CIfpsVSPrd3e2ptdQs
         EAHgMw8Hi7uqn7j2AiDtc1bv6ZE+nQ6ow0sfSeXoZrunPwRxtPUX6JB7mY3JiEeX0ltp
         FVpnMNVvaWhrTme9FvWZHEwgSVzDuYumIaLI6EZ2D01LglxrHiUIhk4vXQEUf3TLkYFH
         xgyw==
X-Gm-Message-State: ACgBeo24DVcxFa6oEwuq26qJg26mCx9Qu1dGD7/GGdyuTjHDrTEF3WIl
        mKhXDj1VSIWspaD4foJceCg=
X-Google-Smtp-Source: AA6agR6HZnPWDhPjGHZKwHYPw6FFTOmXlHR0ZtPemLi6cU5Vl4zAeyWQMj6OLv6xDEXaiPUuwT6I0w==
X-Received: by 2002:a17:907:6e89:b0:741:a19b:638a with SMTP id sh9-20020a1709076e8900b00741a19b638amr22390703ejc.317.1662370581473;
        Mon, 05 Sep 2022 02:36:21 -0700 (PDT)
Received: from felia.fritz.box (200116b8268cc400942297814b5b37b6.dip.versatel-1u1.de. [2001:16b8:268c:c400:9422:9781:4b5b:37b6])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906300900b00742a4debae1sm4720507ejz.6.2022.09.05.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:36:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Mark Brown <broonie@kernel.org>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry in ARM/APPLE MACHINE SOUND DRIVERS
Date:   Mon,  5 Sep 2022 11:35:46 +0200
Message-Id: <20220905093546.19735-1-lukas.bulwahn@gmail.com>
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

Commit 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver") adds
a new sound driver at the location "sound/soc/apple/", but it adds a file
entry referring to the non-existing location "drivers/sound/apple/*".

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in ARM/APPLE MACHINE SOUND DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Martin, please ack.
Mark, please pick this patch on top of the commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29443aad5031..c239d7e69158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1904,7 +1904,7 @@ L:	asahi@lists.linux.dev
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/apple,*
-F:	drivers/sound/apple/*
+F:	sound/soc/apple/
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
-- 
2.17.1

