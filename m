Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB94EFFC6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353953AbiDBIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353934AbiDBIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:53:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351314FFD1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w127so5045634oig.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnmEBkloSHxQt/4YP7PohGytgpfueUHdKvsK8QotGQ0=;
        b=bSUF+T6m6TZymW/6Wb3e8wkKFvcZMEkZvwlXT+EzejOuvoApmEaDlLRib5EjIP5xBp
         LHZjSri2RAUbsK0VbAujyS5fmXDRCCSxqgs2FzLzkVXnsKMHpeg6pdGdOIFlGEgmI4Ju
         /OihV5mpOOlvMAPKev2s7vQTIOAakWpFrk40DXNLPrT6H2HSREZ4orVymdr/n4zjXxth
         IQgRWyzFBVFrHZjAt2AsaSnbEJuLjCidXcEFk8JTWvlIxyeP6xAEVqe1/p0HmnP30U/B
         1yy+NbCsSXOX9MWaX+fpUzhlnkvMInsRpeDg8WWeqnnaVdRoQewnQFG1rehzWpbljkKj
         8M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnmEBkloSHxQt/4YP7PohGytgpfueUHdKvsK8QotGQ0=;
        b=NE9+SaKS0roNJ0CX6SSOZZaXmKLBtkd16KUvLiTdafu9XcNwC1PG9y4g+K5H1kviAW
         hONSBJ6eYGLGpgDDdHxRrjg2oQkQlaFId8rW5/NIeJ4NeYiWGnB6P2HmHDSoGmcP++nz
         swy/XYDQ8nKgjETJMZTVXGe9otCg9F7GYAXRpwfeXgJ545OMaHnKDx6fSCr/NlmYhyD7
         ZeMznpLDafu0CvCvTGgBEJMQF1ne5cIg7sdKJu5G3TIDS1xpQ65gYZvtPRhHJYUH/gfC
         DkgPZWlXZgbwwEl56UFK6VjWYlcDe3NT2JoUeggfXTKjcjIOfmeCk/7umGXB6A3uF5y0
         fZTA==
X-Gm-Message-State: AOAM5311Hh+73RK3CN31jKa3LCXqKgOd4ZQXeHg3tjzn1/BG/NxnQ2mZ
        Tu0ys3ni/YbR9g5pxzuAH/A=
X-Google-Smtp-Source: ABdhPJx9yj1rO/Fdh8dSjci4ZXIejhpZSiiX374O4S5O1esXJBrQRrMtoB1jCwL7nKArO6F3UoeXHg==
X-Received: by 2002:a05:6808:ec3:b0:2ef:895e:752a with SMTP id q3-20020a0568080ec300b002ef895e752amr6373419oiv.12.1648889473986;
        Sat, 02 Apr 2022 01:51:13 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm2108550otr.1.2022.04.02.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:13 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove else after return
Date:   Sat,  2 Apr 2022 03:50:44 -0500
Message-Id: <84db0348481b54f58cb0b6200fa9ae471ee06b3b.1648888461.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1648888461.git.remckee0@gmail.com>
References: <cover.1648888461.git.remckee0@gmail.com>
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

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3b282c387282..09fde5b23ce2 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1427,8 +1427,10 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		spin_unlock_bh(&pmlmepriv->lock);
 
 		return;
-	} else /* clear bridge database */
-		nat25_db_cleanup(padapter);
+	}
+
+	/* clear bridge database */
+	nat25_db_cleanup(padapter);
 
 	/*  free cmd */
 	rtw_free_cmd_obj(pcmd);
-- 
2.32.0

