Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1A4D10CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbiCHHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiCHHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:19:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2C31212;
        Mon,  7 Mar 2022 23:18:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt27so37234102ejb.0;
        Mon, 07 Mar 2022 23:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VErC7r/VIhgtIP6NXdpGci8BSiNBhU0SX2iLoyScINk=;
        b=UKq/CMmizDKXVLYIBOg1sWN/vdxd+lNt9BCksrJ6lhd99YZMNEzWssT30OY8G41Z9d
         TEl+b/Oue1O2zgnSh3WbLjc5wyHsYmvcLdrZzL90buknv/MfS/tU0ZfbI8KZLeQq1ym+
         LBxzdsDEaPlvbWLPxED5f1XSzF7z0tVW0NA2SnXPYqYXkbvH+GQdLMnXnD6EZ4pne1nM
         ZKrhfgfj8odm8ue9yo49ENe3XpEjx9cjK8ajyTKzNTsi8lWTJvBeMb2RI6WeLrOzspCX
         gYdm/tmc6S6DoQN7E3bw0g9WGBce6TVAE706YGWEn6OMR/LP91C0JFYF9EWeOb7Shg67
         lmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VErC7r/VIhgtIP6NXdpGci8BSiNBhU0SX2iLoyScINk=;
        b=02fr40hdgkydYHHIJ7TNTT3ae/myvtb2setJwFufAYPSbq0vWktZfaXfrmJCtp6Mke
         WI7B8Fm86m1OpliEG4OkHtzgFebrhg3I84qLHwtQq8pBE4jMppaE6P41YsTP8TQEBdBf
         btuw75nquOaFPRVQJoaFo8gk6/eGnrmII+eHipmS6FmAht15SZaTdP5tqz32lzdP1t6E
         9DYrhbUjXCAKzFJ99JSkyTWNqFvTlGMvryMAufpsdp8ge4BTpWzleUfd+lXtnlRr5wjD
         p8Z0yIta+ixkAkvl3FnEqJUbS3pam/X9ETNCMcIHk/kn9EIf6G8L6F7isLFpJ3b7etOI
         KuQg==
X-Gm-Message-State: AOAM53373rWEO5Y/LolhzNAimTiJdnHppCxjAb5XRQL4gx6VLf9mj3lL
        fr8Do3a4p3TIYuLQctnOd44=
X-Google-Smtp-Source: ABdhPJx92VMHnkznyhGHK41B+WRt9fmIrnkEFUivR46lfNOwYjAVmLv5Ee3fSQR9lFCpAwi8hZ5mSw==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr11625922ejn.278.1646723927789;
        Mon, 07 Mar 2022 23:18:47 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906338400b006d5aca9fc80sm5452981eja.106.2022.03.07.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:18:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
Date:   Tue,  8 Mar 2022 08:18:27 +0100
Message-Id: <20220308071827.9453-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit dae0978d4174 ("dt: bindings: net: add qcom,ath11k.yaml") obviously
adds qcom,ath11k.yaml, but the file entry in MAINTAINERS, added with
commit fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and
ath11k") then refers to qcom,ath11k.txt.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in QUALCOMM ATHEROS ATH11K WIRELESS DRIVER, and
put it in alphabetic order while at it.

Fixes: fcda1cb81663 ("MAINTAINERS: add DT bindings files for ath10k and ath11k")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Kalle, please pick this minor non-urgent clean-up patch.


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b96a22cf5ea..1e567236146f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15923,8 +15923,8 @@ M:	Kalle Valo <kvalo@kernel.org>
 L:	ath11k@lists.infradead.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
 F:	drivers/net/wireless/ath/ath11k/
-F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	Toke Høiland-Jørgensen <toke@toke.dk>
-- 
2.17.1

