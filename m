Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFA54AD06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354247AbiFNJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352256AbiFNJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:12:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB22E095;
        Tue, 14 Jun 2022 02:12:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e11so8054214pfj.5;
        Tue, 14 Jun 2022 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5LT+u5NJwfL+PCufqicam27W4bMIdilO9Tb0uSbuJw=;
        b=nyyfSAIljfbbg9J3tKKnVZ1qRwcUvNUP3r7s0JcEfwNekIsrKQezYRevflWcjzMxrU
         xfTEW/dsQ0N+F9PVsr91emTuWnp233t51yjsizqPVHyRK0m2DprdU65mAZhPmSKf6U4y
         mB7tBYeCXFMDDsmbxlX7EToxp/Ey8QTE7aMUiD2sU10e7AvDfIy6J9Kb+XGmt0MRh7Qq
         rkgPP1m0bgNTcfKPNCtijqiLwyAhRj6x2zlzt1P4hge8RYn8mlWhtbM9zdMjPFPL55ZP
         flNwWqgmhbLWRDVTqBNBxhRe/CtfnLAzUvcE1ufSrm/zWwz/R90tdU1nPO349Bl6hv1L
         VSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5LT+u5NJwfL+PCufqicam27W4bMIdilO9Tb0uSbuJw=;
        b=MOVFZjA3Jgu1JYRz7X3AIE2z+mF6S4TVvoK7r4JtA8dHP2WzSeEHMvB9kKXsL7XK0Y
         HpkBHE7n/vsEwiuYZainTBcPaBqTZRK4n2HGGGMK1MYRU/Wnh9vRtWhi+Vhh1dAt8eDJ
         Fj9WGNDmpqXmpZ720rmMdYQePvZ+dJ49KPQOEPZxOqqUcY2h+z81XqQQbNEUasaXjUDT
         TRlEAX0KZXHc3RqCbKzJImc9exzSFeXgA4xRK98yFk/JGKMCTHs7EntKZfCsjha/Axjh
         ZgeA3MrqlMzdjbSltPAwsgOYI9JLvix3IsU8cDm5yxvl/jtssAmYDvHSY+0CqTNjv6YC
         9xkw==
X-Gm-Message-State: AOAM532Yy3PA3v7FqARQIIjtiMBQop7bijb+IeXtO0XpIMQZh417qiId
        OEHfckw6ppNOnXYRlcS5XNznnKywIgE=
X-Google-Smtp-Source: ABdhPJxOvBmngXgCrooJxQT9ykcKnUh3jmmDBWhzUl3DjtQzdednyrSId9pr8pomv5f7DOGeD0vOLg==
X-Received: by 2002:a63:3193:0:b0:3fe:3f57:35fd with SMTP id x141-20020a633193000000b003fe3f5735fdmr3735508pgx.232.1655197968928;
        Tue, 14 Jun 2022 02:12:48 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00168c5230332sm6680965plb.148.2022.06.14.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 02:12:48 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: tty: add closing double backticks for lookahead_buf() prototype
Date:   Tue, 14 Jun 2022 16:12:15 +0700
Message-Id: <20220614091214.511791-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220614164745.7b746354@canb.auug.org.au>
References: <20220614164745.7b746354@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging tty tree for linux-next testing, Stephen Rothwell reported
htmldocs warning:

Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline literal start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.
Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.

The warning is because of missing closing double backticks at
lookahead_buf() function prototype ([DRV] directive), which cause the
prototype to be rendered as normal paragraph text instead of inline code
(monospace).

Fix the warning by adding missing closing backticks.

Link: https://lore.kernel.org/linux-next/20220614164745.7b746354@canb.auug.org.au/
Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on next-20220614.

 include/linux/tty_ldisc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 33678e1936f6a6..ede6f2157f329f 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -187,7 +187,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	function for automatic flow control.
  *
  * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, int count)
+ *			const unsigned char *cp, const char *fp, int count)``
  *
  *	This function is called by the low-level tty driver for characters
  *	not eaten by ->receive_buf() or ->receive_buf2(). It is useful for

base-commit: 35d872b9ea5b3ad784d7479ea728dcb688df2db7
-- 
An old man doll... just what I always wanted! - Clara

