Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C64F2130
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiDECVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiDECU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:20:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AD30CF3F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:15:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17-20020a056830111100b005b22c584b93so8375901otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hh3bnTlEGk3VlP0hz02GBXWX+XEzV5IY2jvUvwAG3Hw=;
        b=kQqkj9gTOKGnqQQMyT5BWPtnJD8d8oZzKUo9COxUNgIREnZhtcWPlvVs4rFpEV9A++
         Xh2knjyzBHj+dySJp93r4LPd+kLuA2DeGomuUM13cSC5qNSn1PmoNoFJphevvZ55egH5
         PesBH1xnMkV+0lX1xYTuQoD1wVV80GH+Z6ZrPbH66eOAOyTdMyGypNSluad3dasiNmOE
         rVcO8XmO0ofSQM74c5lrWvQ4HXXc6UfKYWYmp06zfimnCYv49Sq528Vcr7qo/YI6arUQ
         6mDAAzC4ni1RGYqlgiX9lL9wxzJ67vtIdCMER0X8KyA9HDxyYJjpLfJtP4RHY8gZkoGV
         cJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh3bnTlEGk3VlP0hz02GBXWX+XEzV5IY2jvUvwAG3Hw=;
        b=k6oUNX5lH3UURGNQZHc9bvPh+gvQlut/EDgQZBUlv/ldtvtBZf0qVUneHC51cC1Zq0
         Pdw1bOTIAoKHBcdI/WcPIX7UA4PFTTb714b2d8CflKCRrI9VF91LI7hQ17UP8oOwog8P
         jxVXnLGXa52QUuQQ53sAiKO302wNeyB0R0mTut5je2A9EjuS+BeQ1sCG+yECvbp1IWFQ
         Ts6r4BceRtDKzaY8LEIJ57pX2eptiGoUtz5EhRz/VegqAVkWxDbvIMYzlRvwrGUelq+1
         NchLePtxS9PQ7ZM85+36tdsGBDMlWrJHa03EOwg7fIOv6kuhGsEmaJTa7djEFUe3T6CB
         sMQg==
X-Gm-Message-State: AOAM530t8m6mtvczgqqS3Hv835Blmki+tfz82RUtdlLAOHE4KIdMBx8t
        Mg1H7oEcLKnzgGhKEFitod8=
X-Google-Smtp-Source: ABdhPJzfY0a8mvy/V2gG5sQfuEGhRoPtCfuBeNlLV7hMUfIDu7kaNFuYW6yuHz+wjM0b2hC89ilh3Q==
X-Received: by 2002:a9d:7f95:0:b0:5cd:b19f:2c3a with SMTP id t21-20020a9d7f95000000b005cdb19f2c3amr365037otp.272.1649121055356;
        Mon, 04 Apr 2022 18:10:55 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id mj27-20020a0568700d9b00b000de29e1d6adsm3164195oab.16.2022.04.04.18.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 18:10:55 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] staging: rtl8723bs: remove handlerOS independent comment
Date:   Mon,  4 Apr 2022 20:10:43 -0500
Message-Id: <416ed753b7b3062cc8c674dea9028fc901e85426.1649120568.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649120568.git.remckee0@gmail.com>
References: <cover.1649120568.git.remckee0@gmail.com>
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
Additional instances found with git grep.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 46e18a90529f..c16a2b644296 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1887,7 +1887,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 	if (pcmd->res == H2C_DROPPED) {
 		/* TODO: cancel timer and do timeout handler directly... */
-		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
@@ -1918,7 +1917,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 
 	if (pcmd->res == H2C_DROPPED) {
 		/* TODO: cancel timer and do timeout handler directly... */
-		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-- 
2.32.0

