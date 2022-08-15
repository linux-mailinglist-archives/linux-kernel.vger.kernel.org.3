Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298359277E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiHOBaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbiHOB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:45 -0400
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA212ACF;
        Sun, 14 Aug 2022 18:29:39 -0700 (PDT)
Received: by mail-pf1-f193.google.com with SMTP id h28so5567481pfq.11;
        Sun, 14 Aug 2022 18:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nndRH9wcguEYZEjLtGM6nLmTtPovMPErPkqPa7bodQA=;
        b=kOhJJg6djJlgzftuhYT+u2hoq50XDCsbE7goVXvP9/grszUYInXlECZOpLECxqVk0t
         tn0fNjNM4peFOTUICU5/r07DjWI32rmT1Wn+EtP8llB7vDcxXWs/jKXR/xNiDvbcVztc
         Gv+EMzE8cTnzHh/tl00/ZHFSkqj7XTDgTUQvxIyoPonU8LlTg2rcaFfzhiSEYG3ZIrq5
         2fB7U2JGNQlunApLoH9rEjWRxhK4ypSW3GSMyW6RJUWl5Da3FhaDO90nAkpmwRUZ2XB8
         N2uVCGh0f6mwkf1T5VIGCmdaTh6vVCT7sKl2ppov5cgZx0dzd4+qgWxg0koJN6eEDT5J
         jXug==
X-Gm-Message-State: ACgBeo28gApCVfA2pix2P6sj7tmd+W8EwWs2ZGrtDyyg2qKqOTkxKBuZ
        FpZLcETSBA8gllVio6/ynOi3SO5xAcuh
X-Google-Smtp-Source: AA6agR4QfEWswMpDq1HqtXKh9yUsblGeE/1wwg0AW1Kmgz4lD4PbvHWbPd7yjXvUZ7oTAQIVmM1GXw==
X-Received: by 2002:a63:6909:0:b0:41c:9f4f:a63c with SMTP id e9-20020a636909000000b0041c9f4fa63cmr12294589pgc.76.1660526978756;
        Sun, 14 Aug 2022 18:29:38 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090aee8400b001f55dda84b3sm3659327pjz.22.2022.08.14.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:29:38 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        kai.heng.feng@canonical.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: light: cm32181: make cm32181_pm_ops static
Date:   Mon, 15 Aug 2022 09:29:30 +0800
Message-Id: <20220815012930.150078-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of cm32181.c, so marks it static.

Fixes the following sparse warnings:
>> drivers/iio/light/cm32181.c:508:1: sparse: sparse: symbol 'cm32181_pm_ops'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index edbe6a3138d0..001055d09750 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -505,7 +505,7 @@ static int cm32181_resume(struct device *dev)
 					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
 }
 
-DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
 
 static const struct of_device_id cm32181_of_match[] = {
 	{ .compatible = "capella,cm3218" },
-- 
2.25.1

