Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA84EE04A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiCaSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiCaSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:21:35 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D33878B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:19:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v75so401187oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=UmEy4y9PjTmQL29BGmVnPhGoeFVJB6ew1tM59ape4EU=;
        b=iRkJYB5sjDYwHA6hDkF9Xn57bLOePpOECuGzyJ+2TzWQ88nfVA2l34qVNpjVy26MCI
         FTmOslALSnpQ2O9p/MwmR3A0ReB3xZEZKLHBQoH+vzpkCwnN9LzyBqQlM6AHuqEJ8WpF
         xpHpNjKq9+JuDriODTgPFCRNoQSVNFQKjbolmoHS+A9UrPKgeC06BxT12WMhW6jVKSVv
         JVERzi9tHHJBx1kok3RflAlTGSUfSIr8kY5fGHmbTMM/Hd1ccX00Cl1cbDI3v/0wZJDW
         hRIgWOj8DuzVx19jNQ+87BgdHzWzc3cEKL0IBYfjPAJZwaF5dplyj+EL6rx1lwV0VzqP
         8mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=UmEy4y9PjTmQL29BGmVnPhGoeFVJB6ew1tM59ape4EU=;
        b=NICKoXMNsEuAob8tmq5Q6dJuG7wgDTVRY8cfO4H+/07oJZDpjFQAGHZ8g2GG7scacw
         w755QqEzj8sVfACtu2OZlLP4Ip7XO+WPHNjDxfCy2ZpEnbd2ccw3nYVqWXwAsB5sD78D
         psw+kUWm0JFoxmqMeNJIO0AcvvfWxcITpUJ4tubh6dT2L6uvXXXIB+yRo/BtD/JK/Q3Z
         G6360Kfe0CYtRzDLe+miKhxFhxh/7PHqnPMMwfZNRSrX1ZUX+6JVdrusJolh/Ep7CL7e
         k7qtovdfrqZInLN6PqIhMQ4mkUvZEtBuT6PbiKYNbNefnRBm0/2CEiY6K2osLKkO7Y9b
         T/mg==
X-Gm-Message-State: AOAM5308hE19quyIECR+h353pBBR/w+xjg6zoHNtQc9gn8fGDDQhnUCq
        A5yS4HW6LDTuQGsaRkGf9d8iVv+CWWqD5A==
X-Google-Smtp-Source: ABdhPJxyXhBs2gU+7i9d2VhmYjMpJbu6B2GokWYmLoczSMphjcpITchlQGMyXmK5b+yJ2XjytKTZPw==
X-Received: by 2002:a54:4593:0:b0:2ec:d27f:eec1 with SMTP id z19-20020a544593000000b002ecd27feec1mr3173830oib.257.1648750787760;
        Thu, 31 Mar 2022 11:19:47 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b005b235a56831sm112550otl.49.2022.03.31.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:19:47 -0700 (PDT)
Date:   Thu, 31 Mar 2022 13:19:45 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: r8188eu: remove handlerOS independent comment
Message-ID: <YkXwwfYBE+P0UObq@bertie>
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

The "need to make timeout handlerOS independent" comment is incorrect.
Remove the comment to avoid misleading developers.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 859ec8d8ad9e..99fc1904ec52 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1408,7 +1408,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 	if (pcmd->res == H2C_DROPPED) {
 		/* TODO: cancel timer and do timeout handler directly... */
-		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-- 
2.32.0

