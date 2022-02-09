Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B034AFE86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiBIUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:33:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiBIUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:33:04 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF6C002B5D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:33:07 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso3831840oop.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVhiOF8iv2xIg9kYcs7/IvgqJ+jTjVp+C/mxqQxAHV8=;
        b=IMuFYG7DLvcriu374lorFQTy1rdZYFQgDePxlljqs3bFlxdrM3KloXehndGqfik/rj
         48ZiJ8kmNp0rfYr5+w66gNKH6yy+Fz5Xtb+NPSlvvQSMe3j2I7fSsTMXDRSjxtp/9Ov8
         aYzJ09UtegV2GP5fszfWROUcQMOynSkTkI0WWR04/Q3xkvzz0S/VpdH8w5nkAIS/UZeU
         V5ojHC4Ur/eo5OAxBpKKEldpCpnqvUel8sc6s1wWjqRnRHjIB6CT7xiL93OQZ07V2Kdo
         f6yCq0NTSrF/YYZ9rQPvjovtkICtStpI5WhJRFI4t1Ris2FVfwaYGuQj9YAA7s3U69ka
         lUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVhiOF8iv2xIg9kYcs7/IvgqJ+jTjVp+C/mxqQxAHV8=;
        b=6xnyZa2BW23rmVMPm6SjX3FKD8/viA+d43Reptj2OQc+xJuuQTTMDpj7JojZT1gzoA
         oEhKL4Qx9352jHILFqZO0R9ptmum5rh1qLfn2E21rXyEr8j/XjuwHKbeAp5mfWiPuVfT
         D6Ovt/jcsI2KYMMks2Fy/2xjSFoqKEdOORQzp6WfgGkAbDuhv2AVT9xBsyidwlZMdu4A
         cN5sHcnGAC4tjZY5V9t1wVInFr+pwXhQNZ79idmwu2as6wbX1BUrcYcB9G17stPusCEq
         h2mdiNGfXc2up5Ek7FubhXQsFBdbZTy9D2Q9jqMTmouvgVqHd7QROJzHT1tXvbg2j4vs
         l3ew==
X-Gm-Message-State: AOAM532a55d6BBAxrTIzx3BTjE8w8WTiT42h3Cmr54an715UWJs6khIe
        k5hapY1kF38B6uly3Y1e8pSiHHKuCj/thg==
X-Google-Smtp-Source: ABdhPJxAtO6Kq6OIAoojf5SUerefeAMYP1QbgsfPihawjTNVODfPK4W77h7JFU6ebe1aNA1QZSYiZw==
X-Received: by 2002:a05:6870:3815:: with SMTP id y21mr1423624oal.330.1644438786477;
        Wed, 09 Feb 2022 12:33:06 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:758b:9a0d:6e95:934f])
        by smtp.gmail.com with ESMTPSA id u32sm3051052oiw.28.2022.02.09.12.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:33:05 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: Please don't use multiple blank lines
Date:   Wed,  9 Feb 2022 17:32:59 -0300
Message-Id: <20220209203259.4718-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

This patch fixes the following checkpatch.pl warning:

CHECK: Please don't use multiple blank lines

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e236316188c1..ef0dd395b1d8 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -433,7 +433,6 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 void rtw_getbbrfreg_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 
-
 	kfree(pcmd->parmbuf);
 	kfree(pcmd);
 }
-- 
2.29.0

