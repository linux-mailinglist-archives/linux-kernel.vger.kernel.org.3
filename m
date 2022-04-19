Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0518E5066D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiDSIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiDSIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:23:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D32715B;
        Tue, 19 Apr 2022 01:20:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x1so840402pfj.2;
        Tue, 19 Apr 2022 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTopSLgJ2n3PXWtDskFTEfFV8BTHV9oM8z+ikuAV+ic=;
        b=i3uBhJ2tVRdvok0bNuPj65kqsxeaM6leVUupmQNrGxSNJviBhNJVQAQ9rhS7yNvGUC
         bfyI1tb+WUIRNhWtkxFCPR4muaRLaOOrNzHFxPpey5OZ6dVX94RdQeUoj2Gjh5GPxaiW
         WO/PUiu05x4a52l+SrwTmxbHLghXjYsmf1YiFo7Xch6YuqOqpQ6jWlVPRBQs4kOtRCvp
         koKZnnvS7kq6rqR8MeprwzA8h+rfJarKzmfDwMfGR68MqyRUxoOGo/21TNk2MiKEeXt/
         HaDBNHPfVnQNsYSXlWaoKjud09ZRE6bAufLtkmQ1aT3DWqa3UztzUY+o/39pkRWghFBZ
         cr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTopSLgJ2n3PXWtDskFTEfFV8BTHV9oM8z+ikuAV+ic=;
        b=XkigLi6d5Ji4xW9vxiRWdFZ7crKDOuPRZkL3mZPnGIMQlKT0v1jQvXHJVQja7vbqwF
         PI96OblUMPwWy1QRrMjFFqzt9ZR+2MxcTSspUNvm1npajA2S9svpn//SEG0HsKUsFFwL
         h/AsMVVNvbMgoHva71mPnlMAjfJ3c9cNAHPiS2yl0O9x1VnkAOIwiu+8j31XuALSKI2H
         arxjWMIgguHq3ImmkKatS87oGjupjaRqLtEVwm1OS51HXKNLwXnWKbHRQMHUhBAz58SG
         vchgvTSTVWeyolW8PJiF0V0+aUTcZ+zDqJvlENZacGLJAmaz/hYOYkWGGwSXogWqHKs8
         oc4g==
X-Gm-Message-State: AOAM533+rySFs4D7jWVh6R2viqq5cFACBfvBz1O87P/afp+7mDf6ySLK
        hfkx9hBN3tceWxk0UyrbTZQ=
X-Google-Smtp-Source: ABdhPJzqc+PBDxZ1Tbj3AaMVcrSMOUebhmsMu9TDtibfYoxNGpgjoyrqrxZTuL9vBYotbKMQH4ND6Q==
X-Received: by 2002:a05:6a00:1c5c:b0:505:7469:134a with SMTP id s28-20020a056a001c5c00b005057469134amr16520442pfw.16.1650356430520;
        Tue, 19 Apr 2022 01:20:30 -0700 (PDT)
Received: from localhost.localdomain ([240b:12:16e1:e200:929:c115:ea25:1e5c])
        by smtp.gmail.com with ESMTPSA id rm5-20020a17090b3ec500b001c7559762e9sm18673797pjb.20.2022.04.19.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:20:29 -0700 (PDT)
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
To:     akiyks@gmail.com
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs/ja_JP/index: update section title in Japanese
Date:   Tue, 19 Apr 2022 17:18:13 +0900
Message-Id: <20220419081813.6838-1-fujimotokosuke0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update section title "Japanese Translation" in Japanese instead of English

Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org
---
 Documentation/translations/ja_JP/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/translations/ja_JP/index.rst
index 20738c931d02..558a1f5642b0 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -5,7 +5,7 @@
 	\kerneldocCJKon
 	\kerneldocBeginJP{
 
-Japanese translations
+日本語翻訳
 =====================
 
 .. toctree::
-- 
2.25.1

