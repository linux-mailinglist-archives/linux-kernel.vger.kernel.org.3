Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50E4F179F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347374AbiDDOyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiDDOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:54:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A1CEF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:52:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso5751127wmz.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYxLsEyrkgXdnm5LAQn/zPFIjossJ27xzVLlTLKNJ1o=;
        b=mJwseqYMjX/TfeU0TOz5lm6Zk4glWq/g3mAYF7Z4aRpv+SDPrL8NZyBjFJ3xeKA1W9
         nygt+qc3exzXmzW90iQSz1PtJ2DGIqDxkXPTKcqsYffKmUADTvOyM0UDX/cv4hUsayET
         5nc2qAPmbJzkwxox6fOSHbKecczcn2eUCS5mHAY1piJgJArOS4t5Gt7vcX914nqEHCHV
         KFNKev5qRw4vMDGKJWAtryaWmFOZBoDURehR9o+t/0WCRn7a7XnqiVXifEOlMMTm5emR
         l6g5bVk4Bq1ZpF0RUXNdk/1TJ3Gs7R6JDloT/xpvIeMbhdkA6HY1k+z+YrbmzokwPPH6
         zXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYxLsEyrkgXdnm5LAQn/zPFIjossJ27xzVLlTLKNJ1o=;
        b=GS88aivgwAVzH951IdbUxXr4cR9qTZaNJ/7f1YLB0r4mEnsVzrqDcymDKCzeywg7Th
         EVs/8R7p93TR2iqnBIhP2Q7ESGHwj9xWZXT9KS92+iEoT+ePPj3TZG0HfWnz5HKMiBrC
         z42kqBwIb0SeOkBn90Eq31WNZ6d6I45GG6COYAjGG74QAsBzGo/jfvPHArOjLZifZXCj
         Dx05+ZYOu3aryuRyLcDW/wFF8LHjNLfVrQpbhGPDOjjIkfeF9C3+aRHOfQLiiV5tJ/KB
         38tkCU7PYxCU/IWi8TBmtfP1gR/0VIbx3rzd/pTXs1Kk0pY7upEvd8yd7QITasWxWkTq
         6k5w==
X-Gm-Message-State: AOAM5336zwPslxKbnh8yOFRXHK51GyIwbVkTmQvP9oxJ3Ishv17NbWYv
        RZwOxk68VELbutIB7hcNLVUMQlBQ/SI=
X-Google-Smtp-Source: ABdhPJyAXJ20VBx2Ek7B4vBvpOYLDKniIMEAu9TwaQfHA38MDBoTVIZu0vLfi112O8MFSf5vnU6jvg==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr20140642wmi.91.1649083941411;
        Mon, 04 Apr 2022 07:52:21 -0700 (PDT)
Received: from alaa-emad ([41.42.174.117])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm9412536wmg.38.2022.04.04.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:52:20 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: r8188eu: remove unnecessary blank lines
Date:   Mon,  4 Apr 2022 16:52:17 +0200
Message-Id: <20220404145217.15069-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Reported by checkpatch:

CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 2ff78ed1faab..ac6effbecf6d 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -188,7 +188,6 @@ void	expire_timeout_chk(struct adapter *padapter)
 				spin_lock_bh(&pstapriv->auth_list_lock);
 			}
 		}
-
 	}
 	spin_unlock_bh(&pstapriv->auth_list_lock);
 
@@ -381,7 +380,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		/* set ra_id, init_rate */
 		psta->raid = raid;
 		psta->init_rate = init_rate;
-
 	}
 }
 
@@ -455,7 +453,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
-- 
2.35.1

