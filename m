Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1801E550CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiFSTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiFSTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:42:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28792189
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso8437617pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCs87Dk/aKCfwCETT4OMFZvnQ0qo0jo5IYu3+Wptn0s=;
        b=fwYlDqRSLxTMl5+ku1DyMIQBOAuUnuVibTqYnRU3/vT2MIXjw2jzjVP+CG8tOerlZm
         DAS9S4Ze26zFEPbEE02guXPqS3OsObT3HuUe9UuTC4NScQ5ErHgIBikdhyWO5rBpHV8R
         BFzI6ygy7/JmFitOivznMsErlWTuXlNKLmUWLMZbFCfjpMziwTa8xwxpMuWtZdwVaETK
         RKX/Kt+xOoh/GMk6UpROcB7652pvOydb7MnWMN+jWCZNcub++mY/6O2+Dh4iipfP2YN+
         A7o7OV4cspXKvytT7VnliUtOt0WTh1pxrDZ3vglyTCPQRs4Tcp8qeP3/BUJ3umOUUFJF
         feqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCs87Dk/aKCfwCETT4OMFZvnQ0qo0jo5IYu3+Wptn0s=;
        b=jklGLy0ZYhLB6OV8pi0FFkq8a1nbjnSd75P9wHfl5krQ21VfhtWBd1cdCvdRclqDk/
         51sU+ebqS3/W6Ck/RShneqHVw02RBUq9sLfAWMkhUOPTquAdkgkVxrzGiWAm0ERX7/0r
         vdgyYZXWzh21g4WFy3TLgxEEfBgyQZIdgOHAiE2myTLYJftxOw9m6RX9Rwla8Q2qTZzO
         70cOhFGr7gdBnW9jxpL6j28qdtL1vr6HjYmRX2V/jHf3fe80cIWhpGLKDJsVGfKpbxzx
         41ZJBMxFqVJQ45ryRSbYbwb5lvW9bEA5WlXX5CKca/7CQcEk0nhtbxJsr+e574eTS4DI
         U0ZA==
X-Gm-Message-State: AJIora/w03IC93NKT9LebwOvD1WPmwmYSa2OyjIGPsWGCK9eKIylBher
        tB8zD+IydpbgRVIc7WSizoM=
X-Google-Smtp-Source: AGRyM1segxxj5LTL7p0h4ydvGeT/uE/ijZCyoz+pBMMGd4fYW0IoeUCmajONVnjUqJviS7CNCvt60g==
X-Received: by 2002:a17:902:a405:b0:167:97e4:6038 with SMTP id p5-20020a170902a40500b0016797e46038mr20419475plq.144.1655667770304;
        Sun, 19 Jun 2022 12:42:50 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a7e9000b001e2afd35791sm6732389pjl.18.2022.06.19.12.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:49 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 0/5] Fixed some coding style issues and spelling
Date:   Sun, 19 Jun 2022 12:42:26 -0700
Message-Id: <cover.1655666628.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618204454.16071-1-marcus.yu.56@gmail.com>
References: 
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

Fixed a few coding style issues and some spelling errors in the
comments.

Changes in v2:
Separated the original big patch into 5 smaller patches so that each
clean up is in its own patch.

Chang Yu (5):
  Staging: r8188eu: core: rtw_xmit: Fixed some whitespace coding style
    issues
  Staging: r8188eu: core: rtw_xmit: Fixed two indentation coding style
    issues.
  Staging: r8188eu: core: rtw_xmit: Fixed some spelling errors in the
    comments
  Staging: r8188eu: core: rtw_xmit: Fixed a brace coding style issue
  Staging: r8188eu: core: rtw_xmit: Fixed a coding style issue

 drivers/staging/r8188eu/core/rtw_xmit.c | 28 ++++++++++---------------
 1 file changed, 11 insertions(+), 17 deletions(-)

-- 
2.36.1

