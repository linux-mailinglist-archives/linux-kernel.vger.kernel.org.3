Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01F57528E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiGNQOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiGNQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:14:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B0161713
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:14 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j27so1801373qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Q1rOEGSDk/MdGe+KKgrYeB7dlxzQOSbkzC7u5rM1Wc=;
        b=Dx7H4mPpGm5SS1i66ZMaq3PN7ZeJq4VEN+s+/tKevX/QCZkEUBxCX7A7e9Ffek9zHr
         lNU2RDlxT4vw/jzXY4oXX8ImwzbmKyX2/NiUIuCuTqBaNPpaQXTWX/ayJ53mxhw2IZgX
         kdjdmNQ4gKjLu96LTpjJ0CQjYIulOoNuflLAoyMeoPGEuKKy6IEGUDUaVORLQSU6Cg8v
         Uhsblg/I+njVq31aFqs+a1IJ2R7rKH3sOJRpE3qrlplmgcOKAWx2zKrmhwPaSy7n8TZA
         P+PenRYSsDIwDuvhVZzZVoDDvwCaZnvqejcd44U5y/DGUwugHs3r8uY2FgdUiFT6zUeP
         WO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Q1rOEGSDk/MdGe+KKgrYeB7dlxzQOSbkzC7u5rM1Wc=;
        b=L6UjIAiBkdXAWe+bJS/JL8Rwpo12aO+X8scwi3+pXo0w3RsJDGte967l+xc46+bfkC
         +ZHUa1HMjdmaWQu/L2vQ7nWW74NyhAUs01AyCd4fK1Wt9rADKWetHCDnCmidMhhdzQ5O
         1vGcI5W0hRitmBT3Kdh86XhtgWG1qIzGYI8Wg9ShXEtmapjlMwR20et8DGIMC0WH/A0+
         ShgMRXSsbBzIs1cuAOVyudFeWKpdmaUvI6dmOETonHc6njiNaYJWOaza6SeWHe8eFZEu
         qdHl9CzujoNrO/gQBJReB95N2R2/K4utCsyCzDnNxesmxPBSQeTEHl8ZMtJfuOAc+jzx
         SKNA==
X-Gm-Message-State: AJIora9O4yDP1O/3HdvSwtsl8dgJ/6h69kSbOmT2JckKx/bo4VEsDnmy
        bbgoMhqa2GNqNzaIuZ4XQj/3rw==
X-Google-Smtp-Source: AGRyM1uTqE6ZqqqpvevdUWlxwbWLNpzg19xTmvBiXDFlKIjlwuUkEjG7pVKK8g/owLabK3CfqMk0Fg==
X-Received: by 2002:a05:622a:1ba7:b0:31e:c153:646b with SMTP id bp39-20020a05622a1ba700b0031ec153646bmr8550357qtb.283.1657815253836;
        Thu, 14 Jul 2022 09:14:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0031eb393aa45sm1690067qtb.40.2022.07.14.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:14:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/4] MAINTAINERS: Update 104-QUAD-8 driver maintainers list
Date:   Thu, 14 Jul 2022 12:07:15 -0400
Message-Id: <53ecbe49e48dd142fc19f6436fdbe5b8573c5f9c.1657813472.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657813472.git.william.gray@linaro.org>
References: <cover.1657813472.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syed Nayyar Waris is no longer available for 104-QUAD-8 driver
maintenance. William Breathitt Gray will continue as the 104-QUAD-8
driver maintainer.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb95b27f418d..22302d3bd7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,7 +299,6 @@ F:	drivers/gpio/gpio-104-idio-16.c
 
 ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
-M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/104-quad-8.c
-- 
2.36.1

