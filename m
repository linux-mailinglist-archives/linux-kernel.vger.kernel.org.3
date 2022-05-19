Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3C52DEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbiESVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbiESVKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:10:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314FEC330
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:10:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b32so7660038ljf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4voUmXX2drgJSODM/AOB6lNYeHvu2UbFe9Rge8COUw=;
        b=I767hPJ46OgIVQdTE6a4ai/xgOIvEcKdHGfRG7PSAgeA7OqZ/D9aV9m1nUlizm5jGm
         OiLQpgHn+FhPy8yyJTJxFT9gS9tamDdHAZnJQ03O1fHMRR6q1UIh4SPu9YP29i13ETK0
         m94P3KxzB/C2QhiCfyoIoE0iw2zbIpwPjfWHvWFRJ4LXfc3sdfXTD3T2sg/5p5suJ4CD
         cLv3h+n5/1+IMs+O0y9lxiv3BjpZSuBkQTcrFRvWT+wJqsijKYTSmNvOolNFLA0vwUyY
         dWtj+wo7UZTPKLmn0HHKB4N17kKtVDihFiGoDF0r244SVkOaGufJR3ToMV3H67X4Vo0d
         k+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4voUmXX2drgJSODM/AOB6lNYeHvu2UbFe9Rge8COUw=;
        b=145QJ2RALe1lQ3T7tjhroDp6XWFOHIBUfcXeIQtFF44gxp9uSr4Dpq0hKuZj5xBDQj
         YBzxjYGJU29csLMQrV2dboms0FVzuGnxYafT1j06uNLPGoQ0cVpdJJAnKnkGFNRLTd47
         3AQ4BmqWydG6HPBL+Gc16L1x+R7X6+R2HQXCeL05c5VqNnmY/9zR3w9VeWbhvyqbnWVp
         ouI5TnR+1KzWB/Kbi/pfUSvQhihm+kfIAAjdBTHLuzUqZ9bh7dqFPgHhWQWaH+o6+39S
         WComtOdotknOFCyu2/P4oOKoSUq+Q1waC2ozmfXvKs6+5hNPdBslaZbYe8b+U/NQrOTd
         Iy+g==
X-Gm-Message-State: AOAM532xJ0k5WR7rbe51wOMUaL/gVKmnGHp/D1c6cazY36WlmTUQ/CHT
        0HK9BY2Ys97GKpupRdwyV8Y=
X-Google-Smtp-Source: ABdhPJwZVFtZxGg8enpZxx6q0WPL2VTnZKOfm81APVdQQcBl2zKXoBuU4vEknB3/Mgxkp2p7aJm7fg==
X-Received: by 2002:a05:651c:994:b0:253:c449:12f with SMTP id b20-20020a05651c099400b00253c449012fmr3735869ljq.413.1652994610776;
        Thu, 19 May 2022 14:10:10 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id v13-20020a19740d000000b00477bd2d89b9sm400913lfe.140.2022.05.19.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:10:10 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: add myself as r8188eu reviewer
Date:   Fri, 20 May 2022 00:10:08 +0300
Message-Id: <7656c9eb3d430524373f4826714f7d205480c3e2.1652993983.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652993983.git.paskripkin@gmail.com>
References: <cover.1652993983.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reviewing r8188eu patches for a while, but I am missing some of
them, since I am not in CC list. I want to be CC'ed to help reviewing
and testing more patches.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes since v1:
	- Added Dan's Ack. Thanks to Dan! :)

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a635f2ae5b9..bd38a2e465cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18716,6 +18716,7 @@ F:	drivers/staging/olpc_dcon/
 STAGING - REALTEK RTL8188EU DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 M:	Phillip Potter <phil@philpotter.co.uk>
+R:	Pavel Skripkin <paskripkin@gmail.com>
 S:	Supported
 F:	drivers/staging/r8188eu/
 
-- 
2.36.1

