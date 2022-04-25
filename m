Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37250E0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiDYMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiDYMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:53:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018072E6B3;
        Mon, 25 Apr 2022 05:50:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q8so3626919plx.3;
        Mon, 25 Apr 2022 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtSqGSMA3etNjTj6trmxv7klrkKu8BVhmcusbSV9Xzs=;
        b=T/bFkBsyhIjD6D3+BALHVAdR5tBxgVsW5YsA6N+HpTMFOGoCyefZm1HUgMnXgVkptx
         700CaTcip07oIPVYecY+S9uHia/Gr3ru48pvnbB3Lh2uX8vYKh2ap0Im7OaIJa1Ie5Gi
         vWmnxTEaJ1n3JeklZ1myYNUCYV9s76DmRyxXJD8zPMZA0ApCnA3LqBztAvUA0LRUgUik
         JG9RizCiDRoZuPP+49ISrYXq7I2B6OLZECx1iTA+iiF0TG6VGoIvjJKHLlraR/vJzr4H
         GJcUFiJVKRnpcMoSCYT2U7szzmBC9brcpDFLyvhbQq2G/jTrh6svZZ9lK3Syq5scssYs
         zYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtSqGSMA3etNjTj6trmxv7klrkKu8BVhmcusbSV9Xzs=;
        b=1YaIksxCe3xKPRFCvd3aUVV+Ei7JTF6o558YPUmwBfhZYWk0aYdsqH7izJqUka2fds
         JKh2tbPzihhf4DbluPs08JVcuGjp5+ult5vpOxqNKjATGVlpSHoBIeYUJnPcEQQaifK3
         CqJoBTCcFznnuUgcbc6odE8bcSpaVWMFTzFwpZxqbbD3gT2f78s0GIVe5ON2gumDqnfs
         MEKgAC2nsXynySfIPvDmGEeRO253kZaSW3TqyBo70b7V9gsJ+xtqrgkVngnyVN4LvCXR
         ScQx/vd5xwVmbVNIsypq+q5+GZbyHfjSPcpnk3ua8MMvnTYLbNbysjQ0VwRuIHLl8t9a
         nfvQ==
X-Gm-Message-State: AOAM532KwgjriDX/w76OZZnRqrAsfAtZVCx6VLS7ejaMkpH26gZuhCNm
        aOo9Q86enbyK9MxJ4NyLPvY=
X-Google-Smtp-Source: ABdhPJxCBZ0QibQ5JoVP0o9YmqfK0IKE+R1KzODQuZg4QuDggW49f0lWvAXsjw6UbBO/bxdq+tXH+A==
X-Received: by 2002:a17:90a:550e:b0:1cd:e722:8b82 with SMTP id b14-20020a17090a550e00b001cde7228b82mr31481162pji.223.1650891022182;
        Mon, 25 Apr 2022 05:50:22 -0700 (PDT)
Received: from localhost.localdomain ([240b:12:16e1:e200:4aa8:af1e:5803:5c87])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004fb358ffe84sm11532675pfk.104.2022.04.25.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 05:50:21 -0700 (PDT)
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
To:     akiyks@gmail.com
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] docs/ja_JP/index: update section title in Japanese
Date:   Mon, 25 Apr 2022 21:48:53 +0900
Message-Id: <20220425124853.8347-1-fujimotokosuke0@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Update section title "Japanese Translation" in Japanese.
This change is to keep consistency with other translations.

Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/translations/ja_JP/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/translations/ja_JP/index.rst
index 20738c931d02..43b9fb7246d3 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -5,7 +5,7 @@
 	\kerneldocCJKon
 	\kerneldocBeginJP{
 
-Japanese translations
+日本語訳
 =====================
 
 .. toctree::
-- 
2.25.1

