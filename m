Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431B4EA8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiC2Hzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiC2HzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:55:22 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B4722E941
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:53:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id q129so18275077oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=KCFMGfNYizh6pzOTqsxgLLJuZZfsr83zhrOGb53NYPQ=;
        b=aRwrrxn8IEL+X82hc+96+iD0zXCnJjJYP4lO0q7ULschJPbL45YLvBqJ++M8yMQB6Q
         u9EYAxq6btOkP9NSxsvEBFpF5uqxLtSyaxqRID0HDvQlF5wCPRdMdsEdvO7ZB3Krcu7c
         DF16sbLThsZfms7+9JorppHYeAxoXUpkw5zcESZXl22El3UGGvES36WV/kdyW9s5UeSe
         F2EVj+fkFAYzxHTRyD9kZBPajrx16HAaj+WVp3YrbR8t04YEtKzNicEfcOtc9Bjc4bC9
         fxu74xZ2MI7DfiQ1aO1qHcvDQTEp6f4fh8/ItymsUc7CIPpufVPMJTbf+8d2qg+zeuJC
         TVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=KCFMGfNYizh6pzOTqsxgLLJuZZfsr83zhrOGb53NYPQ=;
        b=iHdHtQ9VUgwkfX0zf9BNUDSqDxZr2bHZEs+q5h/3XGmLP+MNhU7LX0DwMaut9O+zh2
         p1awn8/UkEuXtMrDWKAxC4DVIr4GxcCp683UZKvG5lH+O/b4MNtwgEucXYWyfHnlhxAE
         rHutqvbZ1A2tQEFG0Ofpq5a+vJKhCzYlSy8AccIbc8C1cGKeZDn7p3IUbmMwW/s9qAWk
         DqYF9NFuFUrS/D+4hzJFYYn0auiF9pPStoNG4lvG/0ib6Mbl+7QjosCOL5VkMZuZgszx
         DpczoA3H2qzKhnF3CrMOL3YtG9YqKpdfkVOAqL3rtGiEFxuTiWPY4YHSPEWSkjtaaRiQ
         D2Gg==
X-Gm-Message-State: AOAM5305oknUkX6//z/p+Y2AT5XDJtb0QLDCqKroACJd40MGjSIi9oO6
        QHbW6BMdVSNwi/NYFjYeBRw=
X-Google-Smtp-Source: ABdhPJwYQacqsHy2tk8qS/8ZNe/lsC0CrDqg+g+TH91qEyztXbB7TzVH6xu/cdqZGiNMJyxlxfly4w==
X-Received: by 2002:a05:6808:f07:b0:2da:4916:578e with SMTP id m7-20020a0568080f0700b002da4916578emr1515111oiw.271.1648540417651;
        Tue, 29 Mar 2022 00:53:37 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id w7-20020a9d6387000000b005b2265711fcsm6989536otk.16.2022.03.29.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:53:37 -0700 (PDT)
Date:   Tue, 29 Mar 2022 02:53:36 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: r8188eu: fix suspect code indent for conditional
 statements
Message-ID: <YkK7ABTVt0TCbd18@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the if and else if branches of the conditional statement
to improve readability. Prevent bugs that could be introduced
if developers misread the code. Issue found by checkpatch.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 6eca30124ee8..ccc43c0ba433 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1408,7 +1408,7 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		/* TODO: cancel timer and do timeout handler directly... */
 		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		} else if (pcmd->res != H2C_SUCCESS) {
+	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	}
 
-- 
2.32.0

