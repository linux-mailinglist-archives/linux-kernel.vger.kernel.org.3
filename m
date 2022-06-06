Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DA53E096
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiFFEtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFFEtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:49:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D12D4452;
        Sun,  5 Jun 2022 21:44:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h192so5204477pgc.4;
        Sun, 05 Jun 2022 21:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=Ei98CzMADVmZgYFeiLtsGJYTQVfE9A0BeZIjyPKxUtY=;
        b=CSuyvVspJpgNGH9mOvuz7ac/YH7ga0gFudZfmsHX3Ot8N8h8Z4THzZb8P6v7A16pxW
         3f9h82XPYmwfzrdKdGtHFc120HqaiPdQgMjL9h+y+H+ZUsTUZ/4bGPjN/Fklf7+tOuzN
         Kvs94TR6MfZWCPCQfhFwS3dmfnAGi6I9TwdKUNiv5v83NJAEmqKCgBRN/TPZcfYxnY8C
         24q2viLFBH2i/jnZkwQlxAWNPeaJ5eUA1jl9KLATOjkVS2boATi+e/cRJ67IYRdQa7zk
         3WfxWgBPTmvl7JS5zGBbPDTkLpr8RtUMDrBiplyAuhbBgxd+sTNyeAiyJ0/Xe8/dhGZD
         i+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=Ei98CzMADVmZgYFeiLtsGJYTQVfE9A0BeZIjyPKxUtY=;
        b=UCP44IBHKqule4+o2LAXcKU+g6LFNmw6/Mf8DhhdzlIzuAGf5XivOYwosQeHkZ2ADZ
         ya53cHoImZjtmumEjGZTF4lECyixhUeQ8gzyEvKHbjNrx/3dbmCFeJ65x7LqqtJWQg7B
         Yp28a5FDfwwJ9/iFIvHs9MkFL9x8X+RwLD9UHQ7MsMngtWPevJJXunJn177QUH2bhQo6
         /k8OtlN02MWvGww38ldM9s6RW6gknJiF37wolPe7oAA+RraVlTpCm1LN8oiQ5XfI4zTs
         8U1+Q6rRPcz2urVchXr5TAq+1XU1VgCw4a9CJwXMw53xcsgyYJkBziQ9EnNAuo2YFPH+
         e5sw==
X-Gm-Message-State: AOAM531MSpS+1X7vbv5DZt05ZucR9SakVLSaIsw2DEGQRHXHkKuUqQXf
        rf8JGIHXRBkLZnK0ocstU8Q=
X-Google-Smtp-Source: ABdhPJxF/pRL7PBQzioMDWZkadWITlMEbaosSR/T+Gac9Nx5KXf/CYJVQGejc5ZvODYb5r4B8ibBxA==
X-Received: by 2002:a05:6a00:1805:b0:51c:1a6:2253 with SMTP id y5-20020a056a00180500b0051c01a62253mr7996757pfa.70.1654490671586;
        Sun, 05 Jun 2022 21:44:31 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001636d95fe59sm9472391plb.172.2022.06.05.21.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 21:44:30 -0700 (PDT)
Message-ID: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
Date:   Mon, 6 Jun 2022 13:44:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] gpio: Fix kernel-doc comments to nested union
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

Commit 48ec13d36d3f ("gpio: Properly document parent data union")
is supposed to have fixed a warning from "make htmldocs" regarding
kernel-doc comments to union members.  However, the same warning
still remains [1].

Fix the issue by following the example found in section "Nested
structs/unions" of Documentation/doc-guide/kernel-doc.rst.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 48ec13d36d3f ("gpio: Properly document parent data union")
Link: https://lore.kernel.org/r/20220606093302.21febee3@canb.auug.org.au/ [1]
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 include/linux/gpio/driver.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b1e0f1f8ee2e..54c3c6506503 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -167,21 +167,24 @@ struct gpio_irq_chip {
 	 */
 	irq_flow_handler_t parent_handler;
 
-	/**
-	 * @parent_handler_data:
-	 *
-	 * If @per_parent_data is false, @parent_handler_data is a single
-	 * pointer used as the data associated with every parent interrupt.
-	 *
-	 * @parent_handler_data_array:
-	 *
-	 * If @per_parent_data is true, @parent_handler_data_array is
-	 * an array of @num_parents pointers, and is used to associate
-	 * different data for each parent. This cannot be NULL if
-	 * @per_parent_data is true.
-	 */
 	union {
+		/**
+		 * @parent_handler_data:
+		 *
+		 * If @per_parent_data is false, @parent_handler_data is a
+		 * single pointer used as the data associated with every
+		 * parent interrupt.
+		 */
 		void *parent_handler_data;
+
+		/**
+		 * @parent_handler_data_array:
+		 *
+		 * If @per_parent_data is true, @parent_handler_data_array is
+		 * an array of @num_parents pointers, and is used to associate
+		 * different data for each parent. This cannot be NULL if
+		 * @per_parent_data is true.
+		 */
 		void **parent_handler_data_array;
 	};
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.25.1

