Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0790B4FCBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiDLBw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiDLBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:52:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5717A7676
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z14so3970053qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0zgX0lRBSeUYGjy4/2KaVjVU1Nii6uaJF61nZ62EHQo=;
        b=ALgJryFJ8KuYRsLAi1C70WILaGJYBJhDByCkA4L1ffkmDCQ/ZcrlTh7vQsszZdUX9o
         tpDYK5/Bl7zAg9xOpA/+n1JSC/YhUIL83iiBcKEtVOlvRZZGuNfD0QM3biDB0YQUqt/e
         q2kTTCfXhdiIagqLBL8nroWc/e7+9wyvqvTqEwVkfKvsPBKFlTI26gP+mFCkuOMwgwb/
         tsbhTwcL+tE5V4KpcWj7r+B5T7Ocwk2aKDVRlKZfLstP+CkTxl/gO9wxp41K9fPIfd44
         SHMI5MfC4wFxdQeXE84aVPZLm7YaYklDFHx32VoPtEl06EIkyB/M89AjY30pDhgfkeX1
         Ytjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0zgX0lRBSeUYGjy4/2KaVjVU1Nii6uaJF61nZ62EHQo=;
        b=T8eEntfSvSo/6B9i6jR5kPSRrg1VTLIgLu4Vl94tRgTsG9vKiJAL1G13EJhWi3bk/R
         8Gw4JAiqkgyyqA1n/ITkw1G6s/8UZge4sq7lf6cJBTG8KIioXmvHOAC4FtBYR6zh+QHO
         amkI0uWMSJ8nV2c/0doJdiZ66/mnKirgXIAT5C0A0A8MNBNxMGfKLHgx3l/idVuo+ZUb
         SqXoZffpYjgZFwgGIu2eZXtMzpwjJM1fXKgURJDjNF6Nna2CdvvNWcNTzXGmQLjldEFW
         om2xjC5nGqjeqqbRU39j2rA3UsVNb9/kgBJ96spX5LPQ5Nj+FTqqvX4Yz0USPN2cHQdx
         fP7g==
X-Gm-Message-State: AOAM531w/aQXkYkgUQBt0pdG03OqUNHmfK34mXckTlCCsFsJu1KiYBFr
        HGnUwO71WgerUgK7bDhuMno=
X-Google-Smtp-Source: ABdhPJyVeA6zt+aob1XQm4uc32KoNAGhowGFGSAdjfqXLMJZMqwhQg9FsbA9zzbKZLBucKwnc+oolA==
X-Received: by 2002:ac8:688c:0:b0:2f0:4bcd:1e46 with SMTP id m12-20020ac8688c000000b002f04bcd1e46mr1159320qtq.577.1649728235524;
        Mon, 11 Apr 2022 18:50:35 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm29556305qta.75.2022.04.11.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:50:35 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH 2/2] staging: greybus: remove return in an empty void function
Date:   Mon, 11 Apr 2022 21:50:22 -0400
Message-Id: <eaf51ac31d264179298cb24c91f05a14e3651bda.1649712572.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649712572.git.jhpark1013@gmail.com>
References: <cover.1649712572.git.jhpark1013@gmail.com>
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

Issue found by checkpatch:
WARNING: void function return statements are not generally useful

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 0f50d1e51e2c..3e3a16568def 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
 static void gbcodec_remove(struct snd_soc_component *comp)
 {
 	/* Empty function for now */
-	return;
 }
 
 static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
-- 
2.25.1

