Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40584C53BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiBZExk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBZExj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:53:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EDBA1BD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:53:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t14so3524626pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Haj9SValrZqKZTYGpSt6kXipjXiAfqsH/MloLX0cnlY=;
        b=P4qlojskJ+gKddnWPYaLdP/TK1bWGcNJynSFXhzApIM9pH2o6WCVVeT1bfGDUmvyxS
         WdoQII6GbdXOBSm8VXEVRMOXQ82A53p6Vw2EhmP4FziOIqmI8aHotrHH2OtNwSjnECFU
         GxBWaRodBrZeCUKZa2Qf7JOQiQ2RulEXpITqOKfzx3zS2ZCzxRsanuUCoZ/2ftMaHWus
         zgrFageCVZt0B8/CJX00S/KDEJLw3DDVRIDPtIqOAK86/zml6fAzh5pl/h8LY85928G3
         J4np+fcOfvH6AcVVnb2SzXzKakLBg+H5icNikWNTCZ56ekOTcxsH01HTBzv7siFV7hqv
         bvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Haj9SValrZqKZTYGpSt6kXipjXiAfqsH/MloLX0cnlY=;
        b=RbAQXVIWjwRh5pZe+FbbLvSaNQVetqFsSloBbad/9hDD24Diqx6SaxAfnV60zwUzCH
         lgZZuXdRXD5awYUHDJ2i4ONKf1Uoaa/S17pzx5IrPfSHN5Pe2xlDeBBgVg+Ra8sVnJVP
         6JCAFc2K/qi03lHwyp1GRbMwc7X2uzoqnl1RBZTdYT/kLhBOSvNCRPnPHpQwfrhwVDfb
         noulCJ9JaF8e++KH44R9IlO3EQgi+djCeArLh6vsTaKugeDrQ9YkK4lL1bav5z2ntmsN
         MWCQzt+zcIkldDF/MP8UqPwixkQ3mq98pn7bebhfR5A74izp3dEigCfRBuN7ep00GcGi
         v9rg==
X-Gm-Message-State: AOAM5313A1JqMe29pihkj/3e27+Q1y4iEGHosIkttTjqvy3vXWnPkkms
        02LhEyk8MWofzsaN6xombiI=
X-Google-Smtp-Source: ABdhPJzFpupRE/Yxz7PFJ7G+ivCNnYrGJWxbqXPGVsGvL6oFoV6op9CXK4j5yRdz69RT/25tH2cSPg==
X-Received: by 2002:a63:5f47:0:b0:373:cf6c:c9d2 with SMTP id t68-20020a635f47000000b00373cf6cc9d2mr8763272pgb.85.1645851186000;
        Fri, 25 Feb 2022 20:53:06 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a00249200b004df81f5ab5dsm5291196pfv.173.2022.02.25.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 20:53:05 -0800 (PST)
Date:   Sat, 26 Feb 2022 17:52:59 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove TODOs-related item from the TODO file
Message-ID: <YhmyK1Utaoj924im@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All occurences of code annotated with TODO in this driver have been
addressed in the last couple of years by the community. The last
occurrence of the word "TODO" was in the form of a multi-line comment in
the header file intended to be exposed to userspace once this driver
moves away from the staging folder.

This patch removes that TODO as well as the TODO-related item from the
driver's TODO file

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:
- in the include/linux folder I've seen many standards such as:
  -> Just the explanation of that that file is used for (I choose that)
  -> name_of_file.h - brief explanation
  -> include/linux/name_of_file.h - brief explanation

  Since there was not clear pattern I chose the first one. Let me know
  if anyone favours any other approach.

---
 drivers/staging/pi433/TODO       | 1 -
 drivers/staging/pi433/pi433_if.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index 8d0f1b57961a..5cf3fd99d521 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -1,4 +1,3 @@
-* still TODOs, annotated in the code
 * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
   -> Replace this with another interface, hints are welcome!
 * Some missing data (marked with ###) needs to be added in the documentation
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 855f0bebdc1c..25ee0b77a32c 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * include/linux/TODO
- *
  * userspace interface for pi433 radio module
  *
  * Pi433 is a 433MHz radio module for the Raspberry Pi.
-- 
2.34.1

