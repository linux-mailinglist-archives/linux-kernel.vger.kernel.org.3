Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8724F10CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348711AbiDDIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245400AbiDDIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:23:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD83B3F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:21:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so18230084ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX6tr4s5zNKGS53pIVnQhyNOwLeKDR+GeeFQvf7Au+o=;
        b=mWS21PoX6y9UlgHUcVRBpDl2E5Y3z9dxssg3gEOcujRzixIiezjGZ9Kcu6rimu1ec2
         UCmJ1IvrDfVhFIWgpt4tfw/8hWdnj+cXuNN4LNqcmt2hP5qqYW1xwK6dSRyEv3suiDiP
         OVTdWfc0ZE5+Yir8uRtCE9NqgomodNFt9HGU9K2xu2nNXMhde1QA9wKNmCE6XD3BMR3U
         Z9r75G3ambOkKC+8AOBDZA7ucJYjeYaQeduErtkmiir3Sf0sfkJqQKrFJ4tO+KK7uPom
         h848qTOUAE0Chhd7BF8sEVnU6jHMHAj4qMtMhn28Gfh5sATq+blZv4/s+P5yhklW0HVz
         1BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX6tr4s5zNKGS53pIVnQhyNOwLeKDR+GeeFQvf7Au+o=;
        b=zxwNhSoDgXpZ1gd++YlDEEJIFx9bke/u91fYzy3tbscxdS158eyGF5bIqn66MeVeMZ
         5/j2vPp8Z5oC/LmUhpgQycEoD3zAD2C6CiqBF8cWMKEcKkqD+OkJffHxjQgDXk/3mFvW
         ZBXNBNLOaH5vEyF4SjC2IFvdUAcVNTM2i9wjLVg7lFywaRo3KPlxhG+Kh0eAUFOSG7n6
         zwU9/dyC1/W48WVKAVzh4+ct7qcNdwNoOXPaFaXNTQi82nHibJU2Oqep5S8Z1pG3+b/H
         JSGWAWwqFr4lfd3DLCyAUvZtHv5uVn8FVy8CWnTm770Ndu2eeFMZF4nqYyadym14Gsak
         zEzg==
X-Gm-Message-State: AOAM532TeGgNKtza5bsIkdrWPRFR7KskOoLP+dG5MW/y4TGYYWhlsjnC
        /0O3150P9TGe8WfoYsZx4otNZ+ts56c=
X-Google-Smtp-Source: ABdhPJxHJzdAUxF3gKV/nKbz79ohy+RLGfDCYPPdkrjcA5TMxYDm5niRhvzyhjI3M5flvDcnTOSGVA==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr9934011ejc.153.1649060507288;
        Mon, 04 Apr 2022 01:21:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4047336ejh.204.2022.04.04.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:21:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove unused fields from struct pwrctrl_priv
Date:   Mon,  4 Apr 2022 10:21:38 +0200
Message-Id: <20220404082142.4639-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404082142.4639-1-straube.linux@gmail.com>
References: <20220404082142.4639-1-straube.linux@gmail.com>
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

There are some unused fields in the pwrctrl_priv structure.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 4cc365aa3fa7..b0d48106fe56 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -47,16 +47,10 @@ struct pwrctrl_priv {
 	u8	smart_ps;
 	u8	bcn_ant_mode;
 
-	u32	alives;
-	struct work_struct cpwm_event;
 	bool	bpower_saving;
 
 	u8	reg_rfoff;
-	u8	reg_pdnmode; /* powerdown mode */
 
-	/* RF OFF Level */
-	u32	cur_ps_level;
-	u32	reg_rfps_level;
 	uint	ips_enter_cnts;
 	uint	ips_leave_cnts;
 
@@ -72,7 +66,6 @@ struct pwrctrl_priv {
 	u8	power_mgnt;
 	u8	bFwCurrentInPSMode;
 	u32	DelayLPSLastTimeStamp;
-	s32		pnp_current_pwr_state;
 	u8		pnp_bstop_trx;
 
 	u8		bInSuspend;
@@ -86,7 +79,6 @@ struct pwrctrl_priv {
 	enum rt_rf_power_state	rf_pwrstate;/* cur power state */
 	enum rt_rf_power_state	change_rfpwrstate;
 
-	u8		wepkeymask;
 	u8		bkeepfwalive;
 };
 
-- 
2.35.1

