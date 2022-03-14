Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AE4D8C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbiCNTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbiCNTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:32:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAB3B562
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so36377923ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JR1ztvq6kbKN8hA7Y7h98nuZLWbTGZ3l/pHlNUnX8tE=;
        b=XGomWcDqK/SjKlZAq4K+U+TwMjoR8oh+nnvFNnUZI0bHV6Vo5DkLiQHehbD4V83RYy
         1oX/VohumuiCcDz8OoQ/FDMgx/pPW8BbyS1RKUk/LW/Lkv3IiCfIkAgA0nD2EIlThttp
         BuHZ7b0tAs7pRAgOvPMDVRH0GLnXYID/8J/oGwGFtGYY2W667Naz0bH/Wdb4Lus9d6Xc
         39d9C/jPsgt3IYC3uub69dzuKZfsdjiDQNA/zmmJRfLc/UxEPKwLsDjeosnm3TJPnqZg
         9TcDtfjuT45wCgxIOm1WqNloiUsUB8oMr1RCw0UV62eHgnTZ8NUwmRDOxoygviqjCM7S
         ogGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JR1ztvq6kbKN8hA7Y7h98nuZLWbTGZ3l/pHlNUnX8tE=;
        b=CdPXFM/DtJoiTQu/Rh/lMcTEcCfNi1hr4GB3qRhgou94ZGEQi+I03PtIyaGtnsczOH
         jn7ABOiNcZG32IQKc6XCnZZyI86aM9wcLKW9A1p2xEe/DOcGFJO+/x6PTDGZ4HgP3kqv
         p3prtldLzdHTv2ozHoG+x5atfQYwyWWqhtdm3ufk7RLqWndJTKNjbts0s8KdVz7dbMUC
         xd4H5dP+EnQfIXSaeiji0PBiAh2CnPDU03KkAWBU9LRctCE4w/K6sckEQDloVU8IuAGd
         2LgtUOMc6J2YpN6qt1WGFwXoj4zdQqeCnRhftPt+6pULceOowc4kyp4SyypIGLp+iPPZ
         pIoA==
X-Gm-Message-State: AOAM530Rcg76nYYMBMYV+g75LDo9G8CJqlrc6G/IU6VEcR4tIuI/wkiG
        UKRX1YYYyKwCYAC+JoZmDGQfVe7OJFIvhA==
X-Google-Smtp-Source: ABdhPJwX0bDiQzNL3RTuiGVwPJ5kgLUdAZRRQyXu26dwV/buw7A9BNgZ36XpNbZ/EApYwyXNm/mI6A==
X-Received: by 2002:a17:906:6158:b0:6ce:61d6:f243 with SMTP id p24-20020a170906615800b006ce61d6f243mr19652896ejl.268.1647286273745;
        Mon, 14 Mar 2022 12:31:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id w2-20020a50d982000000b00410dc0889b9sm8646960edj.63.2022.03.14.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 12:31:13 -0700 (PDT)
Date:   Mon, 14 Mar 2022 20:31:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6656: Removed unused variable
 vt3342_vnt_threshold
Message-ID: <6e1ef287e66039f9013435f8fa1266de7387df2e.1647284830.git.philipp.g.hortmann@gmail.com>
References: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing part of staging: vt6656: Remove unused rf_type in baseband.c
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index c04fd052e467..ad7b963f0d98 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -167,30 +167,6 @@ static const struct vnt_threshold vt3226_vnt_threshold[] = {
 	{41, 0xff, 0x00}
 };
 
-static const struct vnt_threshold vt3342_vnt_threshold[] = {
-	{0, 0x00, 0x38},	/* Max sensitivity */
-	{66, 0x00, 0x43},
-	{65, 0x00, 0x52},
-	{64, 0x00, 0x68},
-	{63, 0x00, 0x80},
-	{62, 0x00, 0x9c},
-	{61, 0x00, 0xc0},
-	{60, 0x00, 0xea},
-	{59, 0x01, 0x30},
-	{58, 0x01, 0x70},
-	{57, 0x01, 0xb0},
-	{56, 0x02, 0x30},
-	{55, 0x02, 0xc0},
-	{53, 0x04, 0x00},
-	{51, 0x07, 0x00},
-	{49, 0x0a, 0x00},
-	{47, 0x11, 0x00},
-	{45, 0x18, 0x00},
-	{43, 0x26, 0x00},
-	{42, 0x36, 0x00},
-	{41, 0xff, 0x00}
-};
-
 /*
  * Description: Set Antenna mode
  *
-- 
2.25.1

