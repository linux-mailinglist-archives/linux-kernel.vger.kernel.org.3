Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9B58628F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiHAC1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHAC1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:27:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3EB24E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:27:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso3595014pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7V9Ldardxcbrj/Tr9AzUQHon2X/tUHGM08cQ5z7ekV4=;
        b=NLj/6GI9OzN4MMl4s/14AK+tVHsjySZZqDEZLxIDbNUPOceq0If+4icNTShjYpW/lt
         7UTx7xlsPjGz66nCsqK2S6clY8vD+yyRBNA+ObaBmW+bhEn19dwu1LTGI5WZP9rmjMBD
         oVRsOLi7eAzfTZw+RvFttfOwvDGJBLIOUIHkvBtxwiysYVuUHWD3Whr11nrG9TcmS2yy
         8PdhcQ33caUZwrllDxiQkke9Rs9s5L5wL9tA6RJOVH54PRwzIL0mQsZETWajorGjwyIZ
         ebj2Ghhp0cLbCYz1FUn0r+zH/XKblnt+vacl+f73Hcx1HUtQYFXu8DLVpthtom2tmdCB
         1k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7V9Ldardxcbrj/Tr9AzUQHon2X/tUHGM08cQ5z7ekV4=;
        b=3cZxT4E/eupVjF9TAqb52WEHb5HNXm2jJb46uNomilVX1Dk8w5xEq9Tg95JVR4JKEJ
         P0QxsZT/0qpgKIcvSc06u+YM/nDnWjhl/g2A7G6Vze0ltVTVyO7ZEctFdpqLn0VjjchR
         zk9HJOqy55klr8owW+X4+3DhsUzaJj62U5eLg6NMZW5RPxoLn5MhiI+u6vqm1glkR4Sg
         x5KQJGxa7ukG8Vuwe3XMpy/oltf6fOAyqQlxdCL01h/SWu3zBC64yuZ8OAR9aP3fzbtt
         vtQUwDmnqopupYJPLy7naxHEVP5dyT9zR+IMpxPcAgtooMWgwTnLnA2p3CeWllV9EbMY
         RQig==
X-Gm-Message-State: ACgBeo3sU6XDgqFzzQX41YX75DscM1cK1muDh24ZX5gPQCc2MgnURdDx
        VynDvbSU/jd6l4m0mzQ8rHtRwEkzSUw=
X-Google-Smtp-Source: AA6agR6Pjun235BhE4wtKwMU0H6BB/j7AmbN4yfIx5v5ClftRF1/Mbe1NiIXHc89zhuaKAKSVS6uNA==
X-Received: by 2002:a17:90a:de12:b0:1f0:f213:cb9d with SMTP id m18-20020a17090ade1200b001f0f213cb9dmr16703364pjv.207.1659320832436;
        Sun, 31 Jul 2022 19:27:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b0016d763967f8sm8127945plg.107.2022.07.31.19.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:27:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm:amd:display:Remove the unused conditional statements
Date:   Mon,  1 Aug 2022 02:27:08 +0000
Message-Id: <20220801022708.1594588-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Conditional statements have no effect to next process.So remove it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 4b010b1b8aed..b298f13a6911 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4592,10 +4592,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
 	} else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 0;
-	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
-			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
-		*MinPrefetchMode = 0;
-		*MaxPrefetchMode = 3;
 	} else {
 		*MinPrefetchMode = 0;
 		*MaxPrefetchMode = 3;
-- 
2.25.1
