Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE74FE942
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiDLUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiDLUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:27 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865AE70CEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id b17so131760qvp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGAe3LTsLkVSOmk5n1hYimC3Z+ei70JewOhDiYGXx2E=;
        b=mslVj8JNqY9h+etDhOaW5IR2IwPsASkEDfpx83ZM2H2oVURCRCLVverPb8AZ+5I+7I
         Yb4OLW38VZJrs5S4gGLSXXmcoXjjwrc3ryA4XueJFySQj9+K2ezEKJGlHBSHuIrFkgL8
         cymhOrNlfiLJD7cZybUL48DLP1cVPFSmc8KvkkVthiOU/UiANl5gN3P760Wp2CLZ8H+2
         HZ7QamWgc10Lp5ppiCELrjD9/FKVWLcAKRcBQM96E6QRhKZfFqjxJAbz+EYrfhVYXP1I
         8+jeWQKYhoi1mfymtcD1vUpveqaeQDjjnVB6odCA4Wa9HwN1N3zhg/Fgo73iWbFmAYEh
         NEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGAe3LTsLkVSOmk5n1hYimC3Z+ei70JewOhDiYGXx2E=;
        b=iNEgAVnS1axnLLanDS9qUBjvszzAW+nwxjkzfjJCzEVTJ+kH+8G//LSwKa88WBS0w5
         rlPtYcZopqpjz0R1xxTWZ3b1bfoI5608IQWB28UP8dM8VJkxAVKXFNirEqwbHXOjDX5v
         7qKMHeJb63tMYnsAu+Rqw1NIOYzNa90c+bub5gs2gYhsye/Rpy+RyecbnPpMEviNHuA2
         rIJjRQkirR7Z3VpCYyU3wGN38YlUjKWMupgmDxCpPh42mq7ZHZM0GtuGVywGeVUQ7GIM
         ezslUTFjtjkkfeT2sf0AuRTzVWmfakhdt4m4fqInojkMexfmP59O/HZS3zws1hcc3yw7
         34+g==
X-Gm-Message-State: AOAM532KecDUSkrgGBm0ZFuAklxODOG8DPtj1LvwajwEl7e7RqFl9sqS
        zX8hbIN+MfIEPG6dU7WFqww=
X-Google-Smtp-Source: ABdhPJyyulonvQwzYbxt/mlsiQy6OiMMXokv29anfKFSczgkTC6EFhA44wlhlgNg6gRevoajn9OoBw==
X-Received: by 2002:a05:6214:625:b0:441:4934:3c8d with SMTP id a5-20020a056214062500b0044149343c8dmr5208428qvx.40.1649793566406;
        Tue, 12 Apr 2022 12:59:26 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm27270744qtw.26.2022.04.12.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:59:25 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH v2 1/2] staging: greybus: correct typo in comment
Date:   Tue, 12 Apr 2022 15:59:14 -0400
Message-Id: <811ff26b07cf61efcc2814ed5033e8864ef16d7e.1649793138.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649793138.git.jhpark1013@gmail.com>
References: <cover.1649793138.git.jhpark1013@gmail.com>
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

Correct a spelling typo from 'Atleast' to 'At least' in comment.
Issue found by checkpatch.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..45afa208d004 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
 static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.25.1

