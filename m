Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38464D12EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbiCHI4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCHI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:56:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436413B287;
        Tue,  8 Mar 2022 00:55:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c192so10679014wma.4;
        Tue, 08 Mar 2022 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIGGAdxcAJktyvvLN7ctm6KsCvgqfCMtQ7c4CCL5b9c=;
        b=PxD5TRqKcZ1b3ymH5+Oa12FXgi/OSAiKAiKh74vrtv6udbgxWfDklShr8z6zcP7Vix
         eGFExX1IuXeXIl2Em4otYNMv7g6YeNZl90T+AnYfZMUty+KuSPxIGUCRrP1GZW+Fbu4K
         ePKuDmXz7Oa6OM7CNA+La6vhFEjwiuA5Dr7gDg2FwiiV+LxMOnGZhg0cNEbwKpnDjQns
         MJlEzYuQiLjqaNP+GogpIXOvSmPvg4OaDRKG+PmUgNEiUlZH1aKaYmGhnOqwZrzkNxr9
         Yv9z4iqp5i5av3zDuap6eNcq+AaHRO7y8p3C92PIHPXjAJ22/Q4p0ypOFs9RAmrT5pTG
         /uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIGGAdxcAJktyvvLN7ctm6KsCvgqfCMtQ7c4CCL5b9c=;
        b=hYscd/PIeLFiu4QPag1CJCYWiMnLxRVsxcWkvWNFqMSaVp4Ns1E0Y75IQGu30JzXyF
         au1JTm6joTgUAegRGfObi0Fu2KmA0p7ZTJEQZhxs/PXrG42H5uhTzkrkky8von3Ghs6F
         /lwLBJoY8sBKoc6kGyrPzEcTHGG+Y1wJ2+9YzYIGD7XXzYeTHV9AxfZq6dVn0Gl5+Ori
         zL9d9M5Ju6TSf0sHg72UnMMPUlKhjJQ0fibpbw0iMPXtmeKfTol22kACeDn8cCKuqmgT
         ozDKvah8opvNzMKESSWw73KGy0Q2g9HVABbJDNmdWh+3hB+X5359HrYx7Z4Bz+B/dDPK
         B+dg==
X-Gm-Message-State: AOAM533KBbvTHj7ry1JjdcvkdQ6VjnbkLhu3ncvER4rmdEFL5dwu0ZRw
        YaZpFRj+8DV3lRLpDlQ96baRmw9+YOo=
X-Google-Smtp-Source: ABdhPJyL/5OQs6l/obkYBGgeF0liuRveJql9sGbkP8ZS8KK+vx90gFAxqH3v48tm8CGKlHLABm2wKw==
X-Received: by 2002:a1c:3b55:0:b0:389:89bc:4207 with SMTP id i82-20020a1c3b55000000b0038989bc4207mr2578544wma.132.1646729720711;
        Tue, 08 Mar 2022 00:55:20 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm8147557wrs.105.2022.03.08.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:55:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: rectify entry for QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
Date:   Tue,  8 Mar 2022 09:55:03 +0100
Message-Id: <20220308085503.537-1-lukas.bulwahn@gmail.com>
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

v1 -> v2: no change in patch, only added linux-wireless as recipient

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

