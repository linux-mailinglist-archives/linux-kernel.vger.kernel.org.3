Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842C5442C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiFIExr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFIExn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:53:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C49065D7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:53:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y15so16417644qtx.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wK0n9FILdJ7qq+0rwrIHsBXVqiJ9LJ3AWSSuXSk8iyw=;
        b=B8gvoklE6ptVsichtHoq8naMoFmbtfGHS01OSpUXDxD4jpq5MkTk63ywHa2a03UM1I
         COuU51zJRDK3Kci3GDqDSsmJTrdQySyLu24+11A+yR4s2qRqlzNtKIrdxHo1h0hWi7oy
         KJHtFhJZiQMd+d6UtV/UKoz7idXJp3GFd0Kbr23gkti7+uEj+QPnXgEy8VVt5+4agAF9
         9hEtmfii/dt4SZuAwN9oHx1zDuXG3YFpa0S+bzU8E8QkRm1237TnohfxlX/AMVMVVlQ3
         SupyW9yB9jKW3OtTRvWds+Di1xSrQcdvNBHB4kJnndicG8ZrLwvl8CD3zuT/oFsyp+HV
         qrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wK0n9FILdJ7qq+0rwrIHsBXVqiJ9LJ3AWSSuXSk8iyw=;
        b=HLJcjiu2fNMZXnXgbeaLCKJRhBkYU+2UKsi9wtmrOAsormn/5kp67KGTQsvgqLcXTE
         ljqofwuYHLaxdfLRkXPw/6x4bnnFum99niTeotigD0PxQeWZ2a7twsCapsst50yP0wof
         jqDM+Vf3r5hUY7ViKV1DN6vpm3IGfv/1z2aqD7JRlWGFy5C8R1aAmpGSCw7KGU/Q7pAs
         /gPS4Euutew85hgdJ19j6LE1F4w/V0iMApJ9EvrIQ5TmPz75gOGjqi1gYiaAr7qSgUUY
         UkTN2+diMmv8nYgwu5JWq+a2up2zX5lgcIo1E/tRPa9EDXLnvSKDDhWM7HP2CvjAlonl
         +tHA==
X-Gm-Message-State: AOAM533Kpor2VZrLaFtEWC/e7mZCMQGAx8w3bYlvKco6IuYQGUF4UzUc
        fPZ5F9k9RfCZ3aRLhRmvUDg=
X-Google-Smtp-Source: ABdhPJy208Qrh3fZ4OBLFM14cY0HnbAyLYLWybDmC7GjRqstV2rbHIFxcv3xOmCgtEMZu0/ytwie8Q==
X-Received: by 2002:ac8:7fc2:0:b0:304:f234:4597 with SMTP id b2-20020ac87fc2000000b00304f2344597mr13049305qtk.673.1654750418152;
        Wed, 08 Jun 2022 21:53:38 -0700 (PDT)
Received: from Agam.hsd1.mi.comcast.net ([2601:402:4500:22e0::e952])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b006a71729a139sm2674407qkp.44.2022.06.08.21.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 21:53:37 -0700 (PDT)
From:   Agam Kohli <agamkohli9@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Agam Kohli <agamkohli9@gmail.com>
Subject: [PATCH] Staging: comedi: comedi_fops: fixed a spacing coding style issue
Date:   Thu,  9 Jun 2022 00:53:34 -0400
Message-Id: <20220609045334.93266-1-agamkohli9@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Fixed a coding style issue.

Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index e85a99b68f31..3f70e5dfac39 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2169,6 +2169,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case COMEDI_CHANINFO: {
 		struct comedi_chaninfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2177,6 +2178,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_RANGEINFO: {
 		struct comedi_rangeinfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2249,6 +2251,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_INSN: {
 		struct comedi_insn insn;
+
 		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
 			rc = -EFAULT;
 		else

2.36.0

