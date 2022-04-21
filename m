Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5C50A90B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391904AbiDUTYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391880AbiDUTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5C4D25B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so3999109qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waPvZGOg2+RC3HM/74+dHiUU2qD9NP4c44RrV5MzX3U=;
        b=W9ybfcqWpycDEozBpfQU6LFay8XtJafMWTs7wjxBUsAiHQCiVqgK/TTf5zf9GOI2pi
         sypB5HYbVxR6NS02HKa1y4yTaUDEZpGyl6by7caBkMBxSp7quXUzwAlbGR7eIDCb3eOS
         8v+4VQ+TsK6VtBS5+1XHr5be7NbrKIH7M8czJl4o8/VbEU0pJIPrqdo223WjtQ/fGS7+
         z3PMwJnGkXpW4Mhzrv/8GVLJBMUosYFa/A+c4xAfxbAhDTiUUVKD/NXCY6R22f6EYUtB
         lhF7YS3NHcNJmEdQz1yBlB5xtJiWU2fP+ybgvnNXJbaOx34zazR+j2dbpKGJFYBOfAb+
         mzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waPvZGOg2+RC3HM/74+dHiUU2qD9NP4c44RrV5MzX3U=;
        b=W31zngE5vhkP+/7r6leUDYEiAgX8VTQUPqwVlYR8F9E8b2uCn3qoNKdHRYLtun1DgD
         MT9iKRCAv/4J3vMGzhTu7mdkvLabubWWoiLMStKhpy7TnemlTxEG1FTzMTb4fAnC3AGe
         sugTTnTkMTHbj/Vya9lYVqaLIh0VvpVlvgfOnKqE9uqAu1Fs2cTYELBIkjStUnmGCthr
         7VxGLkBWg4e8uLClIxQNMu4v1Nz88hgoDO7eQK/0CbZti9wTGf040GdqbuRr7IpaIs+b
         GHhCIlS8QVANiMG93SseeQ61ZYc4o28TgwV8wMB+B/Jjx/KUEPOzPWDhwkU0WNtPiZsc
         ZWxQ==
X-Gm-Message-State: AOAM530K0pD+buua3++v+jx0PhSW0+j/aEJvhewdzPILokZa0l0KoKss
        3vLJjvOvfSXbrrLw0ZQQilM=
X-Google-Smtp-Source: ABdhPJwh2SbVL0Zx5HMApclIxaVzYaeCo81OEwDlcihKTpvq1Bgtr7vbzN2dhgpj1kHLG+3mkF6ang==
X-Received: by 2002:ac8:5f50:0:b0:2f2:1e88:f919 with SMTP id y16-20020ac85f50000000b002f21e88f919mr745715qta.535.1650568846914;
        Thu, 21 Apr 2022 12:20:46 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:46 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 7/7] staging: r8188eu: remove unused else condition
Date:   Thu, 21 Apr 2022 15:20:32 -0400
Message-Id: <bba338ae5f9992dbf2a64b388f7702e6b287d8c2.1650568579.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650568579.git.jhpark1013@gmail.com>
References: <cover.1650568579.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s_ret cannot return '2' so this else condition is unused. Remove this
unnecessary else statement.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d422ce87ba7c..29b8b101180b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -723,9 +723,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 			if (s_ret == _SUCCESS) {
 				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
-			} else if (s_ret == 2) { /* there is no need to wait for join */
-				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-				rtw_indicate_connect(adapter);
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-- 
2.25.1

