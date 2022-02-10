Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8794B0229
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiBJB1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:27:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiBJB06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:26:58 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89420188;
        Wed,  9 Feb 2022 17:26:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i21so5996455pfd.13;
        Wed, 09 Feb 2022 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=99kJAF1LYHwtSv0Yf3YOWEwdRAz6cOKJMAAN9vZQpPA=;
        b=V208CxnCfJAW7fmWBawGNO4R+VshKsgngfQdMPxgDkMgP6Ulonm1Em6PIMBqJJbGKU
         3BMFA9b+vjpeszMj3qdKdDh5kwJ2k/Z+7YPP7vwq3JUsdEw+uih0WJjn/ANjfmOPGeCc
         duFAf6yoViCOT5T6JehENfcQ9N0Rwyp2NgNTIsC1y2CkAmBJDNQ2VOKzy2oSRB02trnH
         p4f+FMnlX/E7PMdzfRJrlKkx6x4DfDGGTChKPheLQx0VaEEG+VbFgzlQMFRAz3cZSQUm
         olxOqp9vVZfixIrFdFEeg8R3GjEarejrwz8ySgcr0g61zr3+1mvRyY20OJP1s+drGjdd
         cPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=99kJAF1LYHwtSv0Yf3YOWEwdRAz6cOKJMAAN9vZQpPA=;
        b=DRpRnG9ywyWQuuSDdmnAlVuKZlaQCVpVRv36iQuR1kcUYfwvC7+pI8neB2+5/p/bp6
         h+M0eb28whqjRmYE/ivK3gX8IsXJXe3DoZU9mHS0O0T6MsNIdoIn13FrWSfT+64umcNh
         olVtup9S65O+bhTiI24+otuuYKQO9g+yGzSgIR69686MBM2hYU0UaNo7rRFGQwc/tX7y
         1xP4+79aj+lr5giqUe+FKYqJ3nRwcoIlqk6LBJ6ncoew9NVeLibADBcKPW2YYJBCcDR0
         GNJlumkAnVMPS5XbJghoLZmKxgk0t661ZP+FJ6qhJNb135/kMgP6EzfHqyCd42eRPT34
         c0CA==
X-Gm-Message-State: AOAM5333ep2CQWnTzuswmnidRTbH0w6RWpYg0zZYMmm+sc0yxlYVcTTf
        XYl+OGD2h2tpCQgulqbsr6E=
X-Google-Smtp-Source: ABdhPJx7mH2yZo4C4pJn/aE3cCDOtK+LkPC5Nk+B6bO3/Fqq03i1P/0o3tAvSQXdg21ttVWaEs1o8w==
X-Received: by 2002:a65:4c87:: with SMTP id m7mr4145769pgt.509.1644456416531;
        Wed, 09 Feb 2022 17:26:56 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 6sm15177035pgx.36.2022.02.09.17.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:26:56 -0800 (PST)
Message-ID: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
Date:   Thu, 10 Feb 2022 10:26:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: Makefile: Add -no-shell-escape option to LATEXOPTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding this option, message of "restricted \write18 enabled" from
LaTeX can be silenced.

As there is no use of \write18 in LaTeX sources from sphinx-build, it
is safe to add this option.

Reported-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9f4bd42cef18..64d44c1ecad3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -26,7 +26,7 @@ SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output
 PDFLATEX      = xelatex
-LATEXOPTS     = -interaction=batchmode
+LATEXOPTS     = -interaction=batchmode -no-shell-escape
 
 ifeq ($(KBUILD_VERBOSE),0)
 SPHINXOPTS    += "-q"

base-commit: f647de4b02dcb1815fb3019f86a001a681daf0a1
-- 
2.17.1

