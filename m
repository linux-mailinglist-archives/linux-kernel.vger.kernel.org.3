Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246D54F0C45
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376313AbiDCTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiDCTTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:19:17 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D938D9E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:17:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w17-20020a056830111100b005b22c584b93so5875603otq.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Gd2y7AVWs28ptZSwQ3MW03jeLKh2Yn3UJWNjnhCBkQ=;
        b=YgrvFGuqMar6kg3zLV4k+VqjMG6i6EycoQA/RYbGd3gM4mXvQyL8XIIW0SZfxnI/rO
         p9bi2Nci3azhNOjylJ6gtg30uFSDQBBqpZ8IdCNJMcqTOCqUwXzqeaKw5pmQQMXR33Xf
         VMANVxSrNJAfEWwrxPz+T7dSvTf0PB6UPZNlntgL5nQ3PEfdcO8e39m0TBoVNrIupn49
         nauj1SPH3OZ7D7l/85kycHTimQ2WKW7Eyzi8SoUMdDJoBWCYYIvnPvDm6e/x48JiQA+m
         mKOXOh+/ZUJW8eEKHeKdsaAJOKa2fnL05jMEe+fsC5+QgBOOEotUBF1e4jDmhmm9OA3e
         TBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Gd2y7AVWs28ptZSwQ3MW03jeLKh2Yn3UJWNjnhCBkQ=;
        b=zelCc0EpEUwp2gw/TM0jXex88GHMvSqPYn+itdjwKBlQSTGFSwO7LPq1/1fozM2QZS
         +RswMeiRh7QiL2yqj05bV6l6OOJWZCfdTVGOHzvBz1wK3FiLIDDkufYTFNV19ZKNjYId
         PYtYnCYOiQo93oO4qopECaDb7YoTXZY1J5Pr8hGHDZWoT6O0SvIxyku5JSqAo9Zd16/X
         4aEOjQ6EQh1lI5TZrnJoYZ0zyrzgTzXs7qcBttI5BnmCESNp+/jNChd/rk7FtsOWDb3x
         kGyTKZCr1TmfCkPQ93jYPhVB1bpOgcNKERq+9ST6g6+0wGpXTCcZLVzB3LTQX9MoCqS+
         iErQ==
X-Gm-Message-State: AOAM533KkT40uyIOilYLwJTpHm/n/VMzOfU4gGMci6g0+px+N60zbp6z
        K4DAdZRbqq8uxk/Uj32TazQ=
X-Google-Smtp-Source: ABdhPJwJtsq53S3z9z1uQyzjBZ6vcJ80DYbL2VyzbQ+bH5n5YfFTu2BQDNp/2klJ9ja8D7aLJAYsIA==
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id w27-20020a056830061b00b005cc0e447dc3mr10688999oti.159.1649013442167;
        Sun, 03 Apr 2022 12:17:22 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id i28-20020a9d4a9c000000b005ce06a77de2sm3920329otf.48.2022.04.03.12.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 12:17:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: add blank line between functions
Date:   Sun,  3 Apr 2022 14:17:06 -0500
Message-Id: <ccacca6f679a879ad2032dc0aeb0b0156e3a847b.1649011311.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649011311.git.remckee0@gmail.com>
References: <cover.1649011311.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to Linux kernel coding style.
Noticed when completing a different patch.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 2d316a6c8294..ecd0488c439b 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1420,6 +1420,7 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 	rtw_free_cmd_obj(pcmd);
 
 }
+
 void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.32.0

