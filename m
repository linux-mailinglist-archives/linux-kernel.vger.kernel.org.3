Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86534BFE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiBVQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBVQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:14:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6E1662CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:14:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso2235281wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xasGxjrWKUc8knKCgLkgRZOxjNjk0+kPfOd8fVbvqhU=;
        b=Uzd7uFCrCfTZmnmyq7XQpk6x3ugcA+wC0doquagldpVyGgPBQXI7nKoc4gvCtS0jw0
         3y0CKdjRgmrlJTD3qH8L++heLeT/7eVONkD+2jrLMdcuMwVH+3bFpZn5IMy6sJzciyW0
         6Nny5GfcxWLe4DyGuFmQN2/h+NKKAwqeLsJJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xasGxjrWKUc8knKCgLkgRZOxjNjk0+kPfOd8fVbvqhU=;
        b=o+fPoXleiNSOSrIrR2LW/vg2WDwhTVKjCeU83ANXXrbNy+QBY2MJziBkfpnvuZy1RK
         jovPb6hAvHXvOFrEWnmD7n9H5lpuywAv6AOMNBKIC4BpZpe4zQTGq7HJuTDuKLgA177U
         LJp7vYPZmA7pIMfpCWPNABS2Bt88Cdr0g4b8OJrBqDkQhXzv2GIs6fopUDO5k3WEdrm6
         B0ISYTDOOegAm8PWLE37s2aYxZ5rgMaQKrd9nRUfGrQOdCHG/WKcZfREbNP3z029J4Xz
         nr2lEOiM1foc3xGjrXGHqhQnymwGGxnaLB29a/mHh0x1juHKOAw0n9QxhJ09G6wcwYut
         f8Vg==
X-Gm-Message-State: AOAM530lv0lEBo3BHSWbjlbDedAeUE6VP0SzDhyQ5tzcAuoHAjr8HOa3
        ZL9+l77fxj5+41ZqL21zxnLVTMYHG16Zkrz0
X-Google-Smtp-Source: ABdhPJxy3JfkDLpNbVyQxRl/PTpz5egGbFjnDEiLGsOCyGivRmc3NdFk+JRQndorBH2jF4GJnRj1Ww==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr3954756wmo.162.1645546452525;
        Tue, 22 Feb 2022 08:14:12 -0800 (PST)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id z24-20020a1c4c18000000b0037bd7f40771sm2671433wmf.30.2022.02.22.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:14:12 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alsi@bang-olufsen.dk, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net] MAINTAINERS: add myself as co-maintainer for Realtek DSA switch drivers
Date:   Tue, 22 Feb 2022 17:14:08 +0100
Message-Id: <20220222161408.577783-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Adding myself (Alvin Šipraga) as another maintainer for the Realtek DSA
switch drivers. I intend to help Linus out with reviewing and testing
changes to these drivers, particularly the rtl8365mb driver which I
authored and have hardware access to.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b57077b935ba..0171f3e949fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16370,6 +16370,7 @@ F:	drivers/watchdog/realtek_otto_wdt.c
 
 REALTEK RTL83xx SMI DSA ROUTER CHIPS
 M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Alvin Šipraga <alsi@bang-olufsen.dk>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
 F:	drivers/net/dsa/realtek-smi*
-- 
2.35.1

