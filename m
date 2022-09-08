Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF45B12D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIHDOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHDOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:14:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F721A3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:14:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l10so3267293plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lj2YfwNoO49u1JDvTZXx6+kIlpsbYxEjipNfytO+vCs=;
        b=nQEK5nC8oAw6xALpVaD7cWoOAlsvszdvZRYNlOlnIP6f8eCsh8ue+N//oqGvqbqHO5
         JPoGwPd+LVd8tyB6El85eVRif2ySMJwKKMXgjjv6bXH6/tKgZaXPd7e/7upZICjeGhGl
         uBfXSj5FxyBTqiqllpHZjf4yr0Z+AlhunZ5hE1nG5Yqr/+IJWo2RrjdC8bkf7Rk1wuCn
         9fRGaZMU0UdkDUe6ZyCRd8dRmZjMrwEH8kMoWOmGbu5fdFDrmWccstZwmtdiX99QbJFR
         cBpSX7IRtqKjBpGGxsFUzXMlCQbrbyfnmPFkkxucaKggPvRKs894sOxOUs9/AsdS7Wc8
         qS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lj2YfwNoO49u1JDvTZXx6+kIlpsbYxEjipNfytO+vCs=;
        b=leqiM8QgMeUHlf1oCymRp1irMfquwD5djuuKwtSwUn9I/ozlCipt+PIWuPK3sThRMS
         YfdeN7txfZCLATrRApWU1Tp8vpEEUC8zEQ32mpnbk6emR6QMOn9QvTsqHMdJKPhXCUGO
         ma6WRPA3SDknPCo5rIGfSrv0DznbY85fvvTALCC5gDP5ojijMeBeTunGrh0B8PnrfJ6z
         bH+M7r97WLtHAZQjiKZAUYzCDFhQsa6Xpj6T7TgxInVkgJAhsXwtw/ZJoVRB6ZxOetqw
         Iu3MbKHWjYGe+j/OuOUkTkPeWH3ZwkN2ObRUOupxvW0PNv+b5tGsOgdwkKJuNU7cNlrk
         KTbA==
X-Gm-Message-State: ACgBeo3bgJ1OKlaG7QZTDV80mY4NNvbfafHN4r8inOuBT7N0Yc0haW5/
        S7K06imlM9A0kGBmo6rEqRSuwCttGY0V
X-Google-Smtp-Source: AA6agR7YKcNoEQt92SgUbr5dFIFg3iQEjYDhmdzCFobfDa2+qKVtlIHdsY8Xn/4H7W0btC7I0h5FfA==
X-Received: by 2002:a17:90a:b782:b0:1fd:bef9:d49 with SMTP id m2-20020a17090ab78200b001fdbef90d49mr1757702pjr.221.1662606871311;
        Wed, 07 Sep 2022 20:14:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ae28d00b002008ba3a74csm457870pjz.52.2022.09.07.20.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 20:14:30 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] mm/damon/vaddr: add a comment for 'default' case in damon_va_apply_scheme()
Date:   Thu,  8 Sep 2022 11:13:17 +0800
Message-Id: <1662606797-23534-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The switch case 'DAMOS_STAT' and switch case 'default' have same
return value in damon_va_apply_scheme(), and the 'default' case
is for DAMOS actions that not supported by 'vaddr'. It might
make sense to add a comment here.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..3814200e61e4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -646,6 +646,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_STAT:
 		return 0;
 	default:
+		/*
+		 * DAMOS actions that not yet supported by 'vaddr'.
+		 */
 		return 0;
 	}
 
-- 
2.27.0

