Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EB58AA77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiHEMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiHEMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:04:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451B140ED;
        Fri,  5 Aug 2022 05:04:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n185so1317970wmn.4;
        Fri, 05 Aug 2022 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jmupmgL/y2HrrDUu//62/jqyRcBAlD1KYeBUZ5VB29Q=;
        b=b8qEIFbxhE6kPRN0WZdb4m+PaZL+4KC/1yg4Gz1Jce1OEuy99CmL5Vr5idAf9saHWg
         VsETqlLVqRi/tNA2+I79MkFR7H8+WG4DPKeJqZ0FnRNpctc1ZauGLyXzwmscDeA6mtyh
         txBplgaDJZoVpBgskaKuoCBKug8rJHmh9nv/tE/XH+PnT+6kQ/hIyHQ19uiwK5fKrEEK
         OkKgBZYACjruR0Wpg/U72t4BJz6Im4q0NOfWhzThXI/R+UHMj5Rw2AI8xGdMoYOWf+XP
         /6gi4lnAE9eAjE+g6+cas3xASUIIckjfF42pCqLuXb5W4Il+vhXHG4E7ngQcwXC15c2l
         SRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jmupmgL/y2HrrDUu//62/jqyRcBAlD1KYeBUZ5VB29Q=;
        b=8Q4EseuGUMBYQX0mzcWD7CH6OOyKS7Brz2OdFzPRJttfIBIG5LBUcyzqWxGCDMjCvb
         3FgxrclHSAp/ldp/LbGTK9uxy5b+4PUO+tA5h+6e0nvMBqMZzJis9zwyKbqV/orNPmYB
         +7FasIW7AZdMYXIOlAqF3YVTmMZtsIZHieHUqpLA0Ze78rsZCN4fUJCbeIFs6KiD68zA
         aLLa6SxogojeqyxhAAAUstheHG+pAIj8cb816DBHQJat/xmzBj43Gx7ym7JJAOWjgm7U
         HBzpFlu80mWtCqewZ/Wk/74Klz/OubjWXWo/LCsaOftJR/nfV/VXvFDMfK2oFjc3ryGT
         SRtw==
X-Gm-Message-State: ACgBeo2RNJgmD0AIs6FK1PGzYAKaFYAvuSjmj0gQSw4WIs8ceSEAUy+u
        X5Yx0+4MBrRRr3IDX0/DKv8=
X-Google-Smtp-Source: AA6agR6u9Puh26OFXNYNA2fGhuTHgRV6hSXWlKH1p0IlWaXaoWvPpuNub8BzWmlWTKsp2X5M9NTADw==
X-Received: by 2002:a7b:c7cd:0:b0:3a3:8f1:8aeb with SMTP id z13-20020a7bc7cd000000b003a308f18aebmr9227015wmk.90.1659701080818;
        Fri, 05 Aug 2022 05:04:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003a3442f1229sm8977412wml.29.2022.08.05.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:04:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ice1712: remove redundant assignment to new
Date:   Fri,  5 Aug 2022 13:04:39 +0100
Message-Id: <20220805120439.2341600-1-colin.i.king@gmail.com>
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

The variable new is initialized with a value but it is never read. It is
being re-assigned a new value in every case path in the following switch
statement. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
sound/pci/ice1712/quartet.c:569:8: warning: Although the value stored
to 'new' is used in the enclosing expression, the value is never actually
read from 'new' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/ice1712/quartet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 0dfa093f7dca..20b3e8f94719 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -566,7 +566,7 @@ static int qtet_ain12_sw_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned int old, new, tmp, masked_old;
-	old = new = get_scr(ice);
+	old = get_scr(ice);
 	masked_old = old & (SCR_AIN12_SEL1 | SCR_AIN12_SEL0);
 	tmp = ucontrol->value.integer.value[0];
 	if (tmp == 2)
-- 
2.35.3

