Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B550A776
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390961AbiDURyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390947AbiDURyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:54:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67149CAE;
        Thu, 21 Apr 2022 10:51:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q20so3660655wmq.1;
        Thu, 21 Apr 2022 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9GPD6F+i42nYYTtaO9dbnr7cCMMcY8a2hQOSNdFpjY=;
        b=J/DVEUpYNkREy8qfWg1OWPB/6EZY7LP+YLW+2V3WIjhwnNwZq/mt2MD7LZ2WzUfVF6
         zXo3k49TPGOSmVmKDJlBPS/lfbxLWylvRJNqFv/zBthfh4P/58XhqywlHpjwz1VnOoQI
         y1p+GG5zjAtz5XaUgBHrfVC7uwPq17DeIcpmcIvPutuaJO1mUvhWgw64Qn58UjXxZKUS
         LpiO04kRQTFbVHnQ/xWVBZRjQ3tgGI1gyGNOyAqt0JlkZG2ZNRobZNbuBESLaZZuuzvk
         yStJ1pueHtmU9Hj2R8dywIuBnMGbnHm+ed4LLqGP5KfdAfijTtn1IhI7vkk803LciUL4
         3iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9GPD6F+i42nYYTtaO9dbnr7cCMMcY8a2hQOSNdFpjY=;
        b=KdUz3v/HJGQZSH1gKxngjkSdZDDo6Nb5VuHlEDWp/aKfNCJjE/nMjmul7um7qpn128
         51ky/VjG1+CuK+hQ2uxez9T6Iiv84TOuOGxxySAMAjL5qruDqps5kjZTSgIPj8+4Twlf
         +CVNojV5VU5mPT4+2ksxF8elwMFitVi7Vyg1Rs1AovSgAmrF+Nl0JeY2ghkS/vXwORkn
         pkS5iccbJoOVVWadgrxb/hjoz0IfUq88kZSLg38rOLLoSSBfq3vreKdjQnbDfAmnRYrx
         hitRMx6Mxa9lH5l/PKuxsxuTjwaIeMSGeizqUZhFTYkc6iGe4EtIMNrYYVF3Cuty8HUR
         wYmQ==
X-Gm-Message-State: AOAM532drdPW7i/lAasmtb3k7c7Bbj/5TyEQ0+BjWnI9o/Wu03clDs7n
        AuTSANRRSwVvVwCRNF7zLt0zk5f/CI4=
X-Google-Smtp-Source: ABdhPJwvgqEiypssd+RliqH52FtCpkOJfC4NqtaaXxYnl3tFg9ove0Gx3PmwEsCpH3FC2CjoB0WCvQ==
X-Received: by 2002:a05:600c:4044:b0:38e:d2bc:1bc6 with SMTP id j4-20020a05600c404400b0038ed2bc1bc6mr9949186wmm.10.1650563470647;
        Thu, 21 Apr 2022 10:51:10 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:10 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 2/5] HID: uclogic: Clarify pen/frame desc_ptr description
Date:   Thu, 21 Apr 2022 19:50:49 +0200
Message-Id: <20220421175052.911446-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Documentation improvements.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index a489c92cee43..fa75efba3130 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -62,8 +62,8 @@ struct uclogic_params_pen_subreport {
  */
 struct uclogic_params_pen {
 	/*
-	 * Pointer to report descriptor describing the inputs.
-	 * Allocated with kmalloc.
+	 * Pointer to report descriptor part describing the pen inputs.
+	 * Allocated with kmalloc. NULL if the part is not specified.
 	 */
 	__u8 *desc_ptr;
 	/*
@@ -101,8 +101,8 @@ struct uclogic_params_pen {
  */
 struct uclogic_params_frame {
 	/*
-	 * Pointer to report descriptor describing the inputs.
-	 * Allocated with kmalloc.
+	 * Pointer to report descriptor part describing the frame inputs.
+	 * Allocated with kmalloc. NULL if the part is not specified.
 	 */
 	__u8 *desc_ptr;
 	/*
-- 
2.25.1

