Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C364F0C46
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbiDCTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiDCTTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:19:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29538D93
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:17:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso3904415otj.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZOpoW+EgxvMAo7hvmBoOUeiQEc5COuYjcGcZDOKzLc=;
        b=JQK1FwAb9d8bTgZVd7v9+TEI8+adbyUbMJ5BEuAaJsT0lGtcNpU2uyNrENyCyfk1hC
         081WHP4dXs60RAGaLrweRKW2n2Lx2/vmpjO7aWMwBRln654nYBlMBYGocuuA+eEZn75V
         HZuhkr8Yche0813E2nDbH//ZXW2MV+tCQITD9syD5I2l2wE27vCQ+YYyHzGUcRvHLx91
         L0wLk1lkbWLV8gqPU7ooFUebiAcwQBwKGNxg0v5RRmQLwCWcA9J/aDYefl2n9rpR/4FX
         JP0xBTuXJ9w1hUA5KTQXRjt75oFCHRg0yLstvgxasV4KQbWdcOS6k0/T1Fd5ulGq1qE5
         FZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZOpoW+EgxvMAo7hvmBoOUeiQEc5COuYjcGcZDOKzLc=;
        b=Hr8MllL5AuE/nEjDbA5euTA710mOFU12eWtL9rmjIn1dhZjMUKvTLd/k3rqeMxejea
         P4Ie861UOEL9n4IdYGlK5s02RsIn0R4hrp06+Qu2y2Hj6UVQKwlvBnoYBxylURAyLM1v
         g1uRDNdQ/K28S3LNMgfCN/TfIRrsBmt3hHXD6Rup3auv6XX/0Q49D8CX8nUE3ELDgNy3
         MDB/Gj+y3ZMehmlZXNln688vfa2c4th6oCmt/RzB4zcPmqJ8gqbVouUJtShGd4HLrPl8
         5FmueGh8pkL+q/DJUM21HAdFU9n8xLnAeMRyYOdwhjBff0skkUrxQ23YJ64wbgBPhn4r
         +8Rw==
X-Gm-Message-State: AOAM531pMqI+HgKDfEn6lrqys5qle5lvhmkZqkEy3OOSv6O/mM/KUjq6
        GaGBuTh9J3vDQKnmBxR0Ebg=
X-Google-Smtp-Source: ABdhPJyjmxClNgj0VKMCSAgVoFaHxPSSnWmsCRFSbROZnjNlk493xlFpDF25J2s1BXfg5F1yQiWMLQ==
X-Received: by 2002:a05:6830:907:b0:5c9:54e8:8e0a with SMTP id v7-20020a056830090700b005c954e88e0amr10711310ott.103.1649013436199;
        Sun, 03 Apr 2022 12:17:16 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830237700b005b2610517c8sm3808634oth.56.2022.04.03.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 12:17:15 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/3] staging: r8188eu: remove handlerOS independent comment
Date:   Sun,  3 Apr 2022 14:17:04 -0500
Message-Id: <7d0d2253d86f46bc0def0447de424727d70f03a7.1649011311.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649011311.git.remckee0@gmail.com>
References: <cover.1649011311.git.remckee0@gmail.com>
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

The "need to make timeout handlerOS independent" comment is incorrect.
Remove the comment to avoid misleading developers.
Additional instance found with git grep.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8b24330e97c1..da455eb4d8cb 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1447,7 +1447,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 	if (pcmd->res == H2C_DROPPED) {
 		/* TODO: cancel timer and do timeout handler directly... */
-		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-- 
2.32.0

