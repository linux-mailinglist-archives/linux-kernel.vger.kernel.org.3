Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DFC4F4788
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiDEVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457623AbiDEQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:18:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F391193D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:16:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t2so11861975qtw.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=FLSzkzyFKsMmWfcxhBs2Il7HtUd5I2QlvTXEeLFEpwI=;
        b=j9daqXZVYch5PcpAusIBWMCwCZEA3KuTMvcnCJaxNxRmfjMoMsoNrNQZfOxu51vnLp
         LmXUEEnUs+fN2pcJOcHqj0RSl/YrbpWNq3Px1arRKi/1PJQbDH2s3Zd43OqHi9aeMIfk
         49FXG0jcUhMbkUAIagFnqSO4ZO3YIxij/23L6s/bAwH51pqO+L6He0sK6ZO4U+2CClJ+
         7E6rGSmG1Yoe2MrDplF1/IPg+TYoCjqIojEo91MdsP5NE4CrS5qXvWW4+N6kJfjFJn74
         wC3XiQTmBoDQlzC36uwwR0TRsFAJqVgRZM0PV/SOvxlvVsGmwtZcWZgyLSmPnAxmBv72
         mgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=FLSzkzyFKsMmWfcxhBs2Il7HtUd5I2QlvTXEeLFEpwI=;
        b=fbymIrYMWN+eyp41Ffw2nunwjaAfcSNkUh6O2TJjKnGADFoBsNM0iMHOOS1nkq/ARx
         S1Fs96fmFRWUPsvJRYNTuCp6NWGPt+QlSio0vvaR0mTl3s9gvDJa2lTnfz4LkPYU69/f
         VT6TbWidZ3oL3h6ytl3j6+BU08HmNUYvZ/erW6StksTGENv+e7SZ2LEl9YqBAXR1SbuS
         njNOUyFqS4FG1hTVVtfJ8dcBXrg6dXAUgrFOmSM/5zzmXbZv+0gdb+vMQeswIucaWv17
         0psqdSJNB56NZtt8U7sXKLOcEvEg2qlNtNGKrXaerKFYj15wL73zS90AW63W11Q0jxV4
         d9uA==
X-Gm-Message-State: AOAM531sS38aYLkcCbB0I1omzVi6wT2GwwKn5kFTxAMc9wfDIst8873S
        0ZzLPD/bTOjqnRJqhuPWUeMuuNaC5dtaww==
X-Google-Smtp-Source: ABdhPJyfBydtZeKLeim9Up5yEFW9t0urIMuUeqTm5Q4+BL7NMsNpsqz5Yyt2XPRxiO0/MgGVyqlYIw==
X-Received: by 2002:ac8:7dca:0:b0:2e1:db1b:7ba1 with SMTP id c10-20020ac87dca000000b002e1db1b7ba1mr3631493qte.614.1649175407387;
        Tue, 05 Apr 2022 09:16:47 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87d48000000b002e1c6faae9csm11228777qtb.28.2022.04.05.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:16:46 -0700 (PDT)
Date:   Tue, 5 Apr 2022 12:16:43 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v3] staging: rtl8723bs: fix indentation
Message-ID: <20220405161643.GA630826@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding indentation style. Also remove the comments that
became irrelevant after fixing indentation.

Reported by checkpatch:

WARNING: suspect code indent for conditional statements

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---

v1 -> v2: Remove the comments that became irrelevant with proper indentation.

v2 -> v3: Update the changelog text to say everything the commit is doing.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 04e29e228c1e..1bdbd0971f73 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5143,17 +5143,9 @@ void link_timer_hdl(struct timer_list *t)
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
 		/* re-auth timer */
 		if (++pmlmeinfo->reauth_count > REAUTH_LIMIT) {
-			/* if (pmlmeinfo->auth_algo != dot11AuthAlgrthm_Auto) */
-			/*  */
-				pmlmeinfo->state = 0;
-				report_join_res(padapter, -1);
-				return;
-			/*  */
-			/* else */
-			/*  */
-			/* 	pmlmeinfo->auth_algo = dot11AuthAlgrthm_Shared; */
-			/* 	pmlmeinfo->reauth_count = 0; */
-			/*  */
+			pmlmeinfo->state = 0;
+			report_join_res(padapter, -1);
+			return;
 		}
 
 		pmlmeinfo->auth_seq = 1;
-- 
2.25.1

