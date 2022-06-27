Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423E055CC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiF0TsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiF0TsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:48:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922702F7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:48:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j14-20020a17090a694e00b001ed112b078aso6188889pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8vuVXYvJfBvj87s82zuwR5uZ38nwkb6NnG/Ll73ax1I=;
        b=htX4B8EBq9Nzt09U6GpGtS/1j4Xr/6r2Q7zgWC8yVOtLGqNTOdsPp7DFpFI9UbfQWM
         Z1E5BBioD9azElO6WWky+cF4brEmU28mMTvIVCFbhgZEHr+Vcy2TPclUQmF3hnBTBgKN
         ScBnxHiWp5KGdy1jxpxJ4FpZj1Pxr/UZS36dUDojdhlzYC+viLLxFWBuhTDFwMPoQsLU
         hNiBPjmH5Q9RxtgIuA8JUbu23s+p/QhjOQGgl1B/2mP/zkkXwdT3LsFGNo7XdfneqsOR
         VACfLg1nXXP1wKYm+3LqBPmBe9t4kZRE+3DwXoFZqnW/vTJ0fsgOnXisN+oZtHEKMxTx
         afaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8vuVXYvJfBvj87s82zuwR5uZ38nwkb6NnG/Ll73ax1I=;
        b=aDyx5UtcU0e1BpNSRB6ouIcx8rIRkrXSk8AN84LjI2T775/ow7Gjs+8Juem3KdxWFw
         4GvHEjSIVT+PoO4NK9Y1Ni0hx3xjiJugXaCuoxztkDb1EMjzgotT2DUcLgyknlWy3lh3
         FB1iWjiJHuiTOIInyIGIpriAEt99optc/0iTUGKtfD9nF9Kgb3GgCfc7ILaIFVxFF5rA
         Bc/VARw6dCZW2OklKrg25JWvTuQnfFKRX/EFEyXD1y/VXkgdbIL6KY7WMTNQ5d7aSobl
         wsJEIscHQRo41KHlrFskbEVUS6YX3b8WUN2fw9qJ5N+1TOGg3dJolKKcky78kpvYHXrf
         hF3Q==
X-Gm-Message-State: AJIora/4SbXnjDpfJyroBJbqdOv0tj+jluXP1fSvHK8Iz5oDjBr8LwSq
        IhWsN/aOBS+cx478CL7/F+B6dDHf3aQ0fA==
X-Google-Smtp-Source: AGRyM1vJjRQBMLhTYKCZSp0SoyQfIf1AY0yBakonkHhZyU77GIL+coaefM7CVOGZs5EwVngYl3nmq16uKubqHg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a63:31d3:0:b0:40d:dfdf:55c8 with SMTP id
 x202-20020a6331d3000000b0040ddfdf55c8mr8321021pgx.618.1656359284114; Mon, 27
 Jun 2022 12:48:04 -0700 (PDT)
Date:   Mon, 27 Jun 2022 19:47:53 +0000
In-Reply-To: <20220627192434.2306065-1-cmllamas@google.com>
Message-Id: <20220627194753.2309523-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220627192434.2306065-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] MAINTAINERS: update Android driver maintainers
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been contributing patches for binder{,fs} targeting fixes as well
as new functionality. I've also helped reviewing some of the incoming
changes. As such I'd like to be added to the maintainers list for the
Android drivers. Note I'm also dropping Hridya's name from the list as
she has now moved to a different role.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v1->v2: Use the google account instead of personal email.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..081f1dc17871 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1329,7 +1329,7 @@ M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Christian Brauner <christian@brauner.io>
-M:	Hridya Valsaraju <hridya@google.com>
+M:	Carlos Llamas <cmllamas@google.com>
 M:	Suren Baghdasaryan <surenb@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.37.0.rc0.161.g10f37bed90-goog

